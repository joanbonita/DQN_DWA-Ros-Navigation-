#!/usr/bin/env python3
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan
from nav_msgs.msg import Odometry
import numpy as np

class DWANavigation:
    def __init__(self):
        rospy.init_node('dwa_navigation')
        self.cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)
        self.laser_sub = rospy.Subscriber('/front/scan', LaserScan, self.laser_callback)
        self.odom_sub = rospy.Subscriber('/odometry/filtered', Odometry, self.odom_callback)

        # DWA parameters
        self.max_speed = 0.4  # m/s
        self.max_angular_speed = 0.3  # rad/s
        self.max_acceleration = 0.2  # m/s^2
        self.max_angular_acceleration = 0.1  # rad/s^2
        self.goal_x = 10.400433900868524  # Goal position (x)
        self.goal_y = -2.633206132260891  # Goal position (y)

        self.current_pose = None
        self.laser_data = None

    def laser_callback(self, msg):
        self.laser_data = msg

    def odom_callback(self, msg):
        self.current_pose = msg.pose.pose

    def run_dwa(self):
        rate = rospy.Rate(10)
        while not rospy.is_shutdown():
            if self.current_pose is not None and self.laser_data is not None:
                twist = self.dwa_controller()
                self.cmd_vel_pub.publish(twist)
            rate.sleep()

    def dwa_controller(self):
        twist = Twist()

        # Generate candidate trajectories
        velocities = self.generate_candidate_velocities()

        # Evaluate candidate trajectories
        best_trajectory = self.evaluate_trajectories(velocities)

        # Set the linear and angular velocities
        twist.linear.x = best_trajectory[0]
        twist.angular.z = best_trajectory[1]

        return twist

    def generate_candidate_velocities(self):
        """Generate a set of candidate linear and angular velocities."""
        v_list = np.arange(0, self.max_speed, 0.05)
        w_list = np.arange(-self.max_angular_speed, self.max_angular_speed, 0.05)
        candidate_velocities = [(v, w) for v in v_list for w in w_list]
        return candidate_velocities

    def evaluate_trajectories(self, velocities):
        """Evaluate the candidate trajectories and select the best one."""
        best_trajectory = None
        best_score = float('-inf')

        for v, w in velocities:
            # Simulate the trajectory for a short time
            x, y, theta = self.current_pose.position.x, self.current_pose.position.y, self.current_pose.orientation.z
            for _ in range(10):
                x += v * np.cos(theta) * 0.3
                y += v * np.sin(theta) * 0.3
                theta += w * 0.1

            # Evaluate the trajectory
            score = self.evaluate_trajectory(x, y, theta)
            if score > best_score:
                best_score = score
                best_trajectory = (v, w)

        return best_trajectory

    def evaluate_trajectory(self, x, y, theta):
        # Check for obstacles along the trajectory
        for angle in np.arange(theta - np.pi/2, theta + np.pi/2, 0.1):
            distance = self.get_distance_to_obstacle(x, y, angle)
            if distance < 0.3:
                return -0.3

        # Calculate the distance to the goal
        goal_distance = np.sqrt((x - self.goal_x)**2 + (y - self.goal_y)**2)
        return -goal_distance

    def get_distance_to_obstacle(self, x, y, angle):
        min_distance = float('inf')
        for i, distance in enumerate(self.laser_data.ranges[200:600]):
            if distance < min_distance and angle - np.pi/2 <= self.laser_data.angle_min + i * self.laser_data.angle_increment <= angle + np.pi/2:
                min_distance = distance
        return min_distance

if __name__ == "__main__":
    try:
        dwa_navigator = DWANavigation()
        dwa_navigator.run_dwa()
    except rospy.ROSInterruptException:
        pass