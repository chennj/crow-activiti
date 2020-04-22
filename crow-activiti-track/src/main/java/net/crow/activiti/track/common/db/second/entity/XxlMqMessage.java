package net.crow.activiti.track.common.db.second.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author xuxueli 2016-08-28 14:05:23
 */
@Entity
@Table(name="xxl_mq_message_copy",catalog="xxl-mq")
public class XxlMqMessage {

	@Id
    @GeneratedValue
	private Long id;				// 消息ID,
	
	@Column(name = "topic")
	private String topic;			// 消息主题
	
	@Column(name = "group")
	private String group;			// 消息分组, 分组一致时消息仅消费一次；存在多个分组时，多个分组时【广播消费】；
	
	@Column(name = "data")
	private String data;			// 消息数据
	
	@Column(name = "status")
	private String status;			// 消息状态, @sae XxlMqMessageStatus
	
	@Column(name = "retry_count")
	private Integer retryCount;			// 重试次数, 执行失败且大于0时生效，每重试一次减一；
	
	@Column(name = "sharding_id")
	private Long shardingId;		// 分片ID, 大于0时启用，否则使用消息ID；消费者通过该参数进行消息分片消费；分片ID不一致时分片【并发消费】、一致时【串行消费】；
	
	@Column(name = "timeout")
	private Integer timeout;			// 超时时间，单位秒；大于0时生效，处于锁定运行状态且运行超时时，将主动标记运行失败；
	
	@Column(name = "effect_time")
	private Timestamp effectTime;		// 生效时间, new Date()立即执行, 否则在生效时间点之后开始执行;
	
	@Column(name = "add_time")
	private Timestamp addTime;			// 创建时间
	
	@Column(name = "log")
	private String log;				// 流转日志


	public XxlMqMessage() {
	}

	public XxlMqMessage(String topic, String data) {
		this.topic = topic;
		this.data = data;
	}

	public XxlMqMessage(String topic, String data, Timestamp effectTime) {
		this.topic = topic;
		this.data = data;
		this.effectTime = effectTime;
	}

	public XxlMqMessage(String topic, String data, Long shardingId) {
		this.topic = topic;
		this.data = data;
		this.shardingId = shardingId;
	}

	// for clone
	public XxlMqMessage(XxlMqMessage xxlMqMessage) {
		this.id = xxlMqMessage.id;
		this.topic = xxlMqMessage.topic;
		this.group = xxlMqMessage.group;
		this.data = xxlMqMessage.data;
		this.status = xxlMqMessage.status;
		this.retryCount = xxlMqMessage.retryCount;
		this.shardingId = xxlMqMessage.shardingId;
		this.timeout = xxlMqMessage.timeout;
		this.effectTime = xxlMqMessage.effectTime;
		this.addTime = xxlMqMessage.addTime;
		this.log = xxlMqMessage.log;
	}


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Integer getRetryCount() {
		return retryCount;
	}

	public void setRetryCount(Integer retryCount) {
		this.retryCount = retryCount;
	}

	public Long getShardingId() {
		return shardingId;
	}

	public void setShardingId(Long shardingId) {
		this.shardingId = shardingId;
	}

	public Timestamp getEffectTime() {
		return effectTime;
	}

	public void setEffectTime(Timestamp effectTime) {
		this.effectTime = effectTime;
	}

	public Integer getTimeout() {
		return timeout;
	}

	public void setTimeout(Integer timeout) {
		this.timeout = timeout;
	}

	public Timestamp getAddTime() {
		return addTime;
	}

	public void setAddTime(Timestamp addTime) {
		this.addTime = addTime;
	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

	@Override
	public String toString() {
		return "XxlMqMessage{" +
				"id=" + id +
				", topic='" + topic + '\'' +
				", group='" + group + '\'' +
				", data='" + data + '\'' +
				", status='" + status + '\'' +
				", retryCount=" + retryCount +
				", shardingId=" + shardingId +
				", timeout=" + timeout +
				", effectTime=" + effectTime +
				", addTime=" + addTime +
				", log='" + log + '\'' +
				'}';
	}
	
}