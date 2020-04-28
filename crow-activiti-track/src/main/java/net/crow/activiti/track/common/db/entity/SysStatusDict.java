package net.crow.activiti.track.common.db.entity;

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
@Table(name="actt_sys_status_dict",catalog="acti_time")
@GenericGenerator(name = "jpa-uuid2", strategy = "org.hibernate.id.UUIDGenerator" )
@EntityListeners(AuditingEntityListener.class)
public class SysStatusDict {

	@Id @GeneratedValue(generator = "jpa-uuid2")
	@Column(name = "id_",length=36) 
	private String id;

	@Column(name = "category_")
	private String category;

	@Column(name = "type_")
	private String type;

	@Column(name = "name_")
	private String name;

	@Column(name = "value_")
	private String value;

	@Column(name = "status_")
	private String status;

	@Column(name = "flag_")
	private String flag;

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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
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
