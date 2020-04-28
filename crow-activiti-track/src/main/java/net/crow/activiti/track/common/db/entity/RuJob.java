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
@Table(name="actt_hi_procinst",catalog="acti_time")
@GenericGenerator(name = "jpa-uuid2", strategy = "org.hibernate.id.UUIDGenerator" )
@EntityListeners(AuditingEntityListener.class)
public class RuJob{
	
	@Id @GeneratedValue(generator = "jpa-uuid2")
	@Column(name = "id_") 
	private String id;
	
	@Column(name = "parent_proc_inst_id_",length=36) 
	private String parentId;

	@Column(name = "name_") 
	private String name;

	@Column(name = "business_key_") 
	private String businessKey;

	@Column(name = "start_time_") 
	private Timestamp startTime;

	@Column(name = "end_time_") 
	private Timestamp endTime;

	@Column(name = "duration_") 
	private BigInteger duration;

	@Column(name = "sys_status_id_",length=36) 
	private String sysStatusId;

	@Column(name = "start_user_no_",length=36) 
	private String startUserNo;

	@Column(name = "end_user_no_",length=36) 
	private String endUserNo;

	@Column(name = "start_act_id_",length=36) 
	private String startActId;

	@Column(name = "end_act_id_",length=32) 
	private String endActId;

	@Column(name = "desc_") 
	private String desc;

	@Column(name = "tenant_id_",length=32)
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
		return this.id;
	}
	public void setId(String id) {
        this.id = id;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBusinessKey() {
		return businessKey;
	}
	public void setBusinessKey(String businessKey) {
		this.businessKey = businessKey;
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
	public BigInteger getDuration() {
		return duration;
	}
	public void setDuration(BigInteger duration) {
		this.duration = duration;
	}
	public String getSysStatusId() {
		return sysStatusId;
	}
	public void setSysStatusId(String sysStatusId) {
		this.sysStatusId = sysStatusId;
	}
	public String getStartUserNo() {
		return startUserNo;
	}
	public void setStartUserNo(String startUserNo) {
		this.startUserNo = startUserNo;
	}
	public String getEndUserNo() {
		return endUserNo;
	}
	public void setEndUserNo(String endUserNo) {
		this.endUserNo = endUserNo;
	}
	public String getStartActId() {
		return startActId;
	}
	public void setStartActId(String startActId) {
		this.startActId = startActId;
	}
	public String getEndActId() {
		return endActId;
	}
	public void setEndActId(String endActId) {
		this.endActId = endActId;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
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
