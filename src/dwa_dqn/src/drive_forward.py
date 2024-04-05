#!/usr/bin/env python
import rospy
from geometry_msgs.msg import Twist

rospy.init_node('drive_forward')
pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)

msg = Twist()
msg.linear.x = 5
msg.angular.z = 0

pub.publish(msg)