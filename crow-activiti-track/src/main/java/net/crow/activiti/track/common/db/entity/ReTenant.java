package net.crow.activiti.track.common.db.entity;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="actt_re_tenant",catalog="acti_time")
@GenericGenerator(name = "jpa-uuid2", strategy = "org.hibernate.id.UUIDGenerator" )
public class ReTenant{
	
	@Id @GeneratedValue(generator = "jpa-uuid2")
	@Column(name = "id_",length=36) 
	private String id;

	@Column(name = "name_")
	private String name;
	
	@Column(name = "status_")
	private String status;
	
	@Column(name = "account_")
	private String account;

	@Column(name = "addr_")
	private String addr;
	
	@Column(name = "phone_")
	private String phone;

	@Column(name = "remark_")
	private String remark;
	
	@Column(name = "crt_no_")
	private String crt_no;
	
	@Column(name = "upd_no_")
	private String upd_no;
	
	@Column(name = "crt_time_")
	private Timestamp crt_time;
	
	@Column(name = "upd_time_")
	private Timestamp upd_time;

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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getCrt_no() {
		return crt_no;
	}

	public void setCrt_no(String crt_no) {
		this.crt_no = crt_no;
	}

	public String getUpd_no() {
		return upd_no;
	}

	public void setUpd_no(String upd_no) {
		this.upd_no = upd_no;
	}

	public Timestamp getCrt_time() {
		return crt_time;
	}

	public void setCrt_time(Timestamp crt_time) {
		this.crt_time = crt_time;
	}

	public Timestamp getUpd_time() {
		return upd_time;
	}

	public void setUpd_time(Timestamp upd_time) {
		this.upd_time = upd_time;
	}
	
}
