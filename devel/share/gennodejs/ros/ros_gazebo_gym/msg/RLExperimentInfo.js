// Auto-generated. Do not edit!

// (in-package ros_gazebo_gym.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class RLExperimentInfo {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.episode_number = null;
      this.step_number = null;
      this.reward = null;
    }
    else {
      if (initObj.hasOwnProperty('episode_number')) {
        this.episode_number = initObj.episode_number
      }
      else {
        this.episode_number = 0;
      }
      if (initObj.hasOwnProperty('step_number')) {
        this.step_number = initObj.step_number
      }
      else {
        this.step_number = 0;
      }
      if (initObj.hasOwnProperty('reward')) {
        this.reward = initObj.reward
      }
      else {
        this.reward = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type RLExperimentInfo
    // Serialize message field [episode_number]
    bufferOffset = _serializer.int32(obj.episode_number, buffer, bufferOffset);
    // Serialize message field [step_number]
    bufferOffset = _serializer.int32(obj.step_number, buffer, bufferOffset);
    // Serialize message field [reward]
    bufferOffset = _serializer.float32(obj.reward, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type RLExperimentInfo
    let len;
    let data = new RLExperimentInfo(null);
    // Deserialize message field [episode_number]
    data.episode_number = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [step_number]
    data.step_number = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [reward]
    data.reward = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 12;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ros_gazebo_gym/RLExperimentInfo';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c19794b666c4451be032d9f41dd657c4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Message used to send training related information.
    int32 episode_number
    int32 step_number
    float32 reward
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new RLExperimentInfo(null);
    if (msg.episode_number !== undefined) {
      resolved.episode_number = msg.episode_number;
    }
    else {
      resolved.episode_number = 0
    }

    if (msg.step_number !== undefined) {
      resolved.step_number = msg.step_number;
    }
    else {
      resolved.step_number = 0
    }

    if (msg.reward !== undefined) {
      resolved.reward = msg.reward;
    }
    else {
      resolved.reward = 0.0
    }

    return resolved;
    }
};

module.exports = RLExperimentInfo;
