package net.crow.activiti.track.common.db.entity;

import java.math.BigInteger;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Table(name="actt_ru_task",catalog="acti_time")
@GenericGenerator(name = "jpa-uuid2", strategy = "org.hibernate.id.UUIDGenerator" )
@EntityListeners(AuditingEntityListener.class)
public class RuTask {

	@Id @GeneratedValue(generator = "jpa-uuid2")
	@Column(name = "id_",length=32) 
	private String id;

	@Column(name = "proc_inst_id_",length=36) 
	private String procInstId;

	@Column(name = "name_") 
	private String name;

	@Column(name = "parent_task_id_",length=36) 
	private String parentTaskId;

	@Column(name = "desc_") 
	private String desc;

	@Column(name = "task_def_key_") 
	private String taskDefKey;

	@Column(name = "owner_") 
	private String owner;

	@Column(name = "assignee_") 
	private String assignee;

	@Column(name = "delegation_") 
	private String delegation;

	@Column(name = "priority_") 
	private Integer priority;

	@Column(name = "start_time_") 
	private Timestamp startTime;

	@Column(name = "end_time_") 
	private Timestamp endTime;

	@Column(name = "create_time_") 
	private Timestamp createTime;
	
	@Column(name = "last_tracking_date_") 
	private Timestamp lastTrackingDate;
	
	@Column(name = "estimate_") 
	private BigInteger estimate;

	@Column(name = "spent_time_") 
	private BigInteger spentTime;
	
	@Column(name = "overdue_date_") 
	private Timestamp overdueDate;
	
	@Column(name = "sys_status_id_",length=36)
	private String sysStatusId;
	
	@Column(name = "sys_type_id_", length=36)
	private String sysTypeId;
	
	@Column(name = "suspension_state_") 
	private Integer suspensionState;

	@Column(name = "tenant_id_",length=36)
	private String tenantId;
	@Column(name = "tenant_name_")
	private String tenantName;
	@Column(name = "crt_id_")
	@CreatedBy()
	private String crtId;	
	@Column(name = "upd_id")
	@LastModifiedBy()
	private String updId;	
	@Column(name = "crt_time_")
	@CreatedDate
	private Timestamp crtTime;	
	@Column(name = "upd_time_")
	@LastModifiedDate
	private Timestamp updTime;
	@Column(name = "rev_")
	private int rev = 1;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getProcInstId() {
		return procInstId;
	}
	public void setProcInstId(String procInstId) {
		this.procInstId = procInstId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getParentTaskId() {
		return parentTaskId;
	}
	public void setParentTaskId(String parentTaskId) {
		this.parentTaskId = parentTaskId;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getTaskDefKey() {
		return taskDefKey;
	}
	public void setTaskDefKey(String taskDefKey) {
		this.taskDefKey = taskDefKey;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getAssignee() {
		return assignee;
	}
	public void setAssignee(String assignee) {
		this.assignee = assignee;
	}
	public String getDelegation() {
		return delegation;
	}
	public void setDelegation(String delegation) {
		this.delegation = delegation;
	}
	public Integer getPriority() {
		return priority;
	}
	public void setPriority(Integer priority) {
		this.priority = priority;
	}
	public Timestamp getStartTime() {
		return startTime;
	}
	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}
	public Timestamp getEndTime() {
		return endTime;
	}
	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getLastTrackingDate() {
		return lastTrackingDate;
	}
	public void setLastTrackingDate(Timestamp lastTrackingDate) {
		this.lastTrackingDate = lastTrackingDate;
	}
	public Timestamp getOverdueDate() {
		return overdueDate;
	}
	public void setOverdueDate(Timestamp overdueDate) {
		this.overdueDate = overdueDate;
	}
	public BigInteger getEstimate() {
		return estimate;
	}
	public void setEstimate(BigInteger estimate) {
		this.estimate = estimate;
	}
	public BigInteger getSpentTime() {
		return spentTime;
	}
	public void setSpentTime(BigInteger spentTime) {
		this.spentTime = spentTime;
	}
	public String getSysStatusId() {
		return sysStatusId;
	}
	public void setSysStatusId(String sysStatusId) {
		this.sysStatusId = sysStatusId;
	}
	public String getSysTypeId() {
		return sysTypeId;
	}
	public void setSysTypeId(String sysTypeId) {
		this.sysTypeId = sysTypeId;
	}
	public Integer getSuspensionState() {
		return suspensionState;
	}
	public void setSuspensionState(Integer suspensionState) {
		this.suspensionState = suspensionState;
	}
	public String getTenantId() {
		return tenantId;
	}
	public void setTenantId(String tenantId) {
		this.tenantId = tenantId;
	}
	public String getTenantName() {
		return tenantName;
	}
	public void setTenantName(String tenantName) {
		this.tenantName = tenantName;
	}
	public String getCrtId() {
		return crtId;
	}
	public void setCrtId(String crtId) {
		this.crtId = crtId;
	}
	public String getUpdId() {
		return updId;
	}
	public void setUpdId(String updId) {
		this.updId = updId;
	}
	public Timestamp getCrtTime() {
		return crtTime;
	}
	public void setCrtTime(Timestamp crtTime) {
		this.crtTime = crtTime;
	}
	public Timestamp getUpdTime() {
		return updTime;
	}
	public void setUpdTime(Timestamp updTime) {
		this.updTime = updTime;
	}
	public int getRev() {
		return rev;
	}
	public void setRev(int rev) {
		this.rev = rev;
	}

}
