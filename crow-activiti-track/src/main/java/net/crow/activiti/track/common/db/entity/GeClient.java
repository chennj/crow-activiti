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

/**
 * 
 * spring data jpa能自动区分出来insert 和 update 能自动填上时间，狠省心啊
 * @EntityListeners
 * @CreatedDate 		//创建时间
 * @LastModifiedDate 	//更新时间
 * @CreatedBy()  
 * @LastModifiedBy()
 * @author chenn
 *
 */
@Entity
@Table(name="actt_ge_client",catalog="acti_time")
@GenericGenerator(name = "jpa-uuid2", strategy = "org.hibernate.id.UUIDGenerator" )
@EntityListeners(AuditingEntityListener.class)
public class GeClient{
	
	@Id @GeneratedValue(generator = "jpa-uuid2")
	@Column(name = "id_",length=32) 
	private String id;

	@Column(name = "name_")
	private String name;
	
	@Column(name = "addr_")
	private String addr;
	
	@Column(name = "state_")
	private String state;

	@Column(name = "province_")
	private String province;

	@Column(name = "phone_")
	private String phone;

	@Column(name = "mobile_")
	private String mobile;

	@Column(name = "email_")
	private String email;

	@Column(name = "desc_")
	private String desc;

	@Column(name = "proc_inst_id_",length=32)
	private String procInstId;
	
	@Column(name = "sys_status_id_",length=32)
	private String sysStatusId;	

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
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getProcInstId() {
		return procInstId;
	}
	public void setProcInstId(String procInstId) {
		this.procInstId = procInstId;
	}
	public String getSysStatusId() {
		return sysStatusId;
	}
	public void setSysStatusId(String sysStatusId) {
		this.sysStatusId = sysStatusId;
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
