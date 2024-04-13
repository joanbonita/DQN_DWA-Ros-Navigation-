;; Auto-generated. Do not edit!


(when (boundp 'ros_gazebo_gym::RLExperimentInfo)
  (if (not (find-package "ROS_GAZEBO_GYM"))
    (make-package "ROS_GAZEBO_GYM"))
  (shadow 'RLExperimentInfo (find-package "ROS_GAZEBO_GYM")))
(unless (find-package "ROS_GAZEBO_GYM::RLEXPERIMENTINFO")
  (make-package "ROS_GAZEBO_GYM::RLEXPERIMENTINFO"))

(in-package "ROS")
;;//! \htmlinclude RLExperimentInfo.msg.html


(defclass ros_gazebo_gym::RLExperimentInfo
  :super ros::object
  :slots (_episode_number _step_number _reward ))

(defmethod ros_gazebo_gym::RLExperimentInfo
  (:init
   (&key
    ((:episode_number __episode_number) 0)
    ((:step_number __step_number) 0)
    ((:reward __reward) 0.0)
    )
   (send-super :init)
   (setq _episode_number (round __episode_number))
   (setq _step_number (round __step_number))
   (setq _reward (float __reward))
   self)
  (:episode_number
   (&optional __episode_number)
   (if __episode_number (setq _episode_number __episode_number)) _episode_number)
  (:step_number
   (&optional __step_number)
   (if __step_number (setq _step_number __step_number)) _step_number)
  (:reward
   (&optional __reward)
   (if __reward (setq _reward __reward)) _reward)
  (:serialization-length
   ()
   (+
    ;; int32 _episode_number
    4
    ;; int32 _step_number
    4
    ;; float32 _reward
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _episode_number
       (write-long _episode_number s)
     ;; int32 _step_number
       (write-long _step_number s)
     ;; float32 _reward
       (sys::poke _reward (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _episode_number
     (setq _episode_number (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _step_number
     (setq _step_number (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _reward
     (setq _reward (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ros_gazebo_gym::RLExperimentInfo :md5sum-) "c19794b666c4451be032d9f41dd657c4")
(setf (get ros_gazebo_gym::RLExperimentInfo :datatype-) "ros_gazebo_gym/RLExperimentInfo")
(setf (get ros_gazebo_gym::RLExperimentInfo :definition-)
      "# Message used to send training related information.
int32 episode_number
int32 step_number
float32 reward

")



(provide :ros_gazebo_gym/RLExperimentInfo "c19794b666c4451be032d9f41dd657c4")


