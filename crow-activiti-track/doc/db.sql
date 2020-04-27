-- 	删除所有表外键
--	1.先查出所有外键
--	SELECT CONCAT('ALTER TABLE ',TABLE_SCHEMA,'.',TABLE_NAME,' DROP FOREIGN KEY ',CONSTRAINT_NAME,' ;') 
--	FROM information_schema.TABLE_CONSTRAINTS c 
--	WHERE c.TABLE_SCHEMA='库名' AND c.CONSTRAINT_TYPE='FOREIGN KEY';
--	2.逐条执行查询出的结果
--	ALTER TABLE '表名' DROP FOREIGN KEY '外键名';

drop table if exists actt_ge_client;
create table actt_ge_client(
	id_ varchar(36) NOT NULL COMMENT '主键',
	name_ varchar(220) not null,
	addr_ varchar(1000),
	state_ varchar(255),
	province_ varchar(255),
	phone_ varchar(32),
	mobile_ varchar(32),
	email_ varchar(255),
	desc_ varchar(2000),
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	sys_status_id_ varchar(36) COMMENT '任务状态',
	tenant_id_ varchar(36) not null,
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key(id_),
	unique index actt_idx_ge_client_name_tenant(name_,tenant_id_),
	index actt_idx_ge_client_tenant_name(tenant_name_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户';

drop table if exists actt_hi_procinst;
create table actt_hi_procinst (
	id_ varchar(36) NOT NULL COMMENT '主键',
	parent_proc_inst_id_ varchar(36) COMMENT '父进程ID',
	name_ varchar(255) not null,
	business_key_ varchar(255) not null,
	start_time_ timestamp COMMENT '开始时间',
	end_time_ timestamp COMMENT '结束时间',
	duration_ bigint COMMENT '持续时间',
	sys_status_id_ varchar(36) not null COMMENT '任务状态',
	start_user_no_ varchar(32),
	end_user_no_ varchar(32),
	start_act_id_ varchar(36),
	end_act_id_ varchar(36),
	desc_ varchar(1000),
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	index actt_idx_hi_pro_i_buskey(business_key_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='工作进程';

drop table if exists actt_ru_task;
create table actt_ru_task(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) not null COMMENT '工作进程id',
	name_ varchar(255),
	parent_task_id_ varchar(36) COMMENT '对应父任务',
	desc_ varchar(1000),
	task_def_key_ varchar(255),
	owner_ varchar(255) COMMENT '发起人',
	assignee_ varchar(255) COMMENT '分配到任务的人',
	delegation_ varchar(255) COMMENT '委托人',
	priority_ int COMMENT '优先级',
	start_time_ timestamp COMMENT '发起时间',
	end_time_ timestamp COMMENT '暂时用不到',
	overdue_date_ timestamp COMMENT '过期时间',
	create_time_ timestamp COMMENT '建立时间',
	last_tracking_date_ timestamp COMMENT '上次跟踪日期',
	estimate_  bigint COMMENT '预估时间',
	spent_time_ bigint COMMENT '花费时间',
	sys_status_id_ varchar(36) not null COMMENT '任务状态',
	sys_type_id_ varchar(36) not null COMMENT '任务类型',
	suspension_state_ int(11) COMMENT '暂停状态 1：激活 2：挂起',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key (id_),
	index actt_idx_ru_task_procinst(proc_inst_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='当前任务';

drop table if exists actt_hi_taskinst;
create table actt_hi_taskinst(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	name_ varchar(255),
	parent_task_id_ varchar(36) COMMENT '对应父任务',
	desc_ varchar(1000),
	task_def_key_ varchar(255),
	owner_ varchar(255) COMMENT '发起人',
	assignee_ varchar(255) COMMENT '分配到任务的人',
	delegation_ varchar(255) COMMENT '委托人',
	priority_ int COMMENT '优先级',
	start_time_ timestamp COMMENT '发起时间',
	end_time_ timestamp COMMENT '结束时间',
	claim_time_ timestamp COMMENT '签收时间',
	overdue_date_ timestamp COMMENT '过期时间',
	create_time_ timestamp COMMENT '建立时间',
	last_tracking_date_ timestamp COMMENT '上次跟踪日期',
	estimate_  bigint COMMENT '预估时间',
	spent_time_ bigint COMMENT '花费时间',
	sys_status_id_ varchar(36) not null COMMENT '任务状态',
	sys_type_id_ varchar(36) not null COMMENT '任务类型',
	suspension_state_ int(11) COMMENT '暂停状态 1：激活 2：挂起',
	delete_reason_ varchar(1000) COMMENT '删除理由',
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_hi_taskinst_procinst(proc_inst_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务历史';

drop table if exists actt_ru_task_time;
create table actt_ru_task_time(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	task_id_ varchar(36) COMMENT '任务id',
	start_time_ timestamp COMMENT '开始时间',
	end_time_ timestamp COMMENT '结束时间',
	duration_ bigint COMMENT '持续时间',
	sys_status_id_ varchar(36) COMMENT '任务状态',
	desc_ varchar(1000),
	comment_id_ varchar(36) COMMENT '节点处理意见表id',
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_ru_task_time_procinst(proc_inst_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务处理时间追踪';

drop table if exists actt_hi_taskinst_time;
create table actt_hi_taskinst_time(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	task_id_ varchar(36) COMMENT '任务id',
	start_time_ timestamp COMMENT '开始时间',
	end_time_ timestamp COMMENT '结束时间',
	sys_status_id_ varchar(36) COMMENT '任务状态',
	duration_ bigint COMMENT '持续时间',
	desc_ varchar(1000),
	comment_id_ varchar(36) COMMENT '节点处理意见表id',
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_hi_taskinst_time_procinst(proc_inst_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史任务处理时间追踪';

drop table if exists actt_hi_comment;
create table actt_hi_comment(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	task_id_ varchar(36) COMMENT '任务id',
	task_time_id_ varchar(36) COMMENT '任务时间id',
	type_ varchar(255) COMMENT '意见类型',
	comment_ varchar(4000),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_hi_comment_procinst(proc_inst_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='节点留言表';

drop table if exists actt_ru_variable;
create table actt_ru_variable(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	task_id_ varchar(36) COMMENT '任务id',
	name_ varchar(255) not null COMMENT '变量名',
	var_type_ varchar(100) COMMENT '变量类型',
	double_ double,
	long_ bigint,
	text_ varchar(2000),
	text2_ varchar(2000),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_ru_procinst(proc_inst_id_),
	index actt_idx_ru_task(task_id_),
	index actt_idx_ru_name_type(name_,var_type_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务自定义变量';

drop table if exists actt_hi_varinst;
create table actt_hi_varinst(
	id_ varchar(36) NOT NULL COMMENT '主键',
	proc_inst_id_ varchar(36) COMMENT '工作进程id',
	task_id_ varchar(36) COMMENT '任务id',
	name_ varchar(255) not null COMMENT '变量名',
	var_type_ varchar(100) COMMENT '变量类型',
	double_ double,
	long_ bigint,
	text_ varchar(2000),
	text2_ varchar(2000),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本',
	primary key(id_),
	index actt_idx_hi_varinst_procinst(proc_inst_id_),
	index actt_idx_hi_task(task_id_),
	index actt_idx_hi_name_type(name_,var_type_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务历史自定义变量';

drop table if exists actt_ru_identitylink;
create table actt_ru_identitylink(
	id_ varchar(36) NOT NULL COMMENT '主键',
	type_ varchar(255), 
	task_id_ varchar(36), 
	user_ids_ varchar(4000), 
	proc_inst_id_ varchar(36), 
	client_id_ varchar(36),
	user_belong_id_ varchar(36),
	sys_role_id_ varchar(36),
	rev_ int, 
	PRIMARY KEY (id_),
	index actt_idx_ru_identitylink_task_id(task_id_),
	index actt_idx_ru_identitylink_proc_inst_id(proc_inst_id_),
	index actt_idx_ru_identitylink_client_id(client_id_),
	index actt_idx_ru_identitylink_user_belong_id(user_belong_id_),
	index actt_idx_ru_identitylink_user_sys_role_id(sys_role_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='任务参与者数据表。主要存储当前节点参与者的信息';

drop table if exists actt_hi_identitylink;
CREATE TABLE actt_hi_identitylink ( 
	id_ varchar(36) NOT NULL COMMENT '主键',
	type_ varchar(255), 
	user_ids_ varchar(4000),
	task_id_ varchar(36), 
	proc_inst_id_ varchar(36), 
	client_id_ varchar(36),
	user_belong_id_ varchar(36),
	sys_role_id_ varchar(36),
	rev_ int, 
	PRIMARY KEY (id_),
	index actt_idx_hi_identitylink_task_id(task_id_),
	index actt_idx_hi_identitylink_proc_inst_id(proc_inst_id_),
	index actt_idx_hi_identitylink_client_id(client_id_),
	index actt_idx_hi_identitylink_user_belong_id(user_belong_id_),
	index actt_idx_hi_identitylink_user_sys_role_id(sys_role_id_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='历史任务参与者数据表。';

drop table if exists actt_id_user;
create table actt_id_user(
	id_ varchar(36) NOT NULL COMMENT '主键',
	first_ varchar(255) COMMENT '员工名',
	last_ varchar(255) COMMENT '员工姓',
	parent_id_ varchar(36),
	nickname_ varchar(255),
	no_ varchar(32) not null COMMENT '员工编号',
	status_ varchar(4),
	ip_ varchar(255),
	email_ varchar(255),
	pwd_ varchar(255),
	salt_ varchar(255),
	picture_id_ varchar(36) COMMENT '头像id',
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	rev_ int, 
	primary key(id_),
	unique index actt_idx_user_no (no_,tenant_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息表';

drop table if exists actt_id_user_role;
create table actt_id_user_role(
	id_ varchar(36) NOT NULL COMMENT '主键',
	no_ varchar(32) not null COMMENT '员工编号',
	user_id_ varchar(36) not null,
	sys_role_id_ varchar(36) not null COMMENT '系统角色',
	skills_role_ varchar(4) COMMENT '技能角色 状态 业务字典(0:有效 其他:无效)',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key(id_),
	index actt_id_user_role_no (no_),
	index actt_id_user_role_idx_user_id(user_id_),
	index actt_id_user_role_idx_sys_role_id(sys_role_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

drop table if exists actt_sys_status_dict;
create table actt_sys_status_dict(
	id_ varchar(36) NOT NULL COMMENT '主键',
	category_ varchar(128) not null COMMENT '分类,例如：task,process,client...',
	type_ varchar(128) not null COMMENT '状态类别，例如：open,close...',
	name_ varchar(255) not null,
	value_ varchar(8) default '0',
	status_ varchar(2) default '0' COMMENT '启用，停用，等',
	flag_ varchar(2) default '1' COMMENT '标记：表示缺省等',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key(id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统状态字典表';

drop table if exists actt_sys_role_info;
CREATE TABLE actt_sys_role_info (
	id_ varchar(36) NOT NULL COMMENT '主键',
	parent_id_ varchar(36),
	role_type_ varchar(64) not null COMMENT '角色类型', 
	role_name_ varchar(255) not null COMMENT '角色名称', 
	role_name_ch varchar(255) COMMENT '角色名称中文',
	role_value_ varchar(64),
	auth_ids_ text COMMENT '权限码', 
	sys_ varchar(8) not null, 
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	index actt_sys_role_info_idx_role_type(role_type_),
	index actt_sys_role_info_idx_role_name(role_name_),
	index actt_sys_role_info_idx_sys(sys_)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统角色表';

drop table if exists actt_re_user_belong;
create table actt_re_user_belong(
	id_ varchar(36) NOT NULL COMMENT '主键',
	parent_id_ varchar(36),
	user_belong_type_id_ varchar(36) not null,
	name_ varchar(255) not null,
	status_ varchar(4),
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	index actt_re_user_belong_idx_name(name_),
	index actt_re_user_belong_idx_user_belong_type_id(user_belong_type_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义用户归属表，例如部门表，地区表';

drop table if exists actt_re_user_belong_role;
create table actt_re_user_belong_role(
	id_ varchar(36) NOT NULL COMMENT '主键',
	user_belong_id_ varchar(36) not null,
	sys_role_id_ varchar(36), 
	status_ varchar(4),
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	index acct_re_user_belong_role_idx_user_belong_id(user_belong_id_),
	index acct_re_user_belong_role_idx_sys_role_id(sys_role_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义用户归属表角色';

drop table if exists actt_re_user_belong_type;
create table actt_re_user_belong_type(
	id_ varchar(36) NOT NULL COMMENT '主键',
	name_ varchar(255),
	desc_ varchar(255),
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_) 
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自定义属性类别表，例如部门，地区';

drop table if exists actt_id_belong_user_membership;
create table actt_id_belong_user_membership(
	user_id_ varchar(36) not null,
	belong_id_ varchar(36) not null,
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (user_id_,belong_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='属性用户关系表';

drop table if exists actt_re_bus_dict;
create table actt_re_bus_dict(
	id_ varchar(36) NOT NULL COMMENT '主键',
	name_ varchar(128) not null,
	key_ varchar(128) not null,
	value_ varchar(128) not null,
	desc_ varchar(255),
	status_ varchar(2) COMMENT '0:有效',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	index actt_re_bus_dict_idx_name(name_),
	index actt_re_bus_dict_idx_key(key_),
	index actt_re_bus_dict_idx_value(value_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='业务字典';

drop table if exists actt_sys_config;
create table actt_sys_config(
	id_ varchar(36) NOT NULL COMMENT '主键',
	key_ varchar(128) not null,
	value_ varchar(1000) not null,
	desc_ varchar(255),
	status_ varchar(2) COMMENT '0:有效',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='全局配置表';

drop table if exists actt_re_tenant;
create table actt_re_tenant(
	id_ varchar(36) NOT NULL COMMENT '主键',
	name_ varchar(255) not null,
	status_ varchar(4),
	account_ varchar(255),
	addr_ varchar(255),
	phone_ varchar(32),
	remark_ varchar(2000),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	unique index actt_re_tenant_uni_idx_name(name_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='租户表';

drop table if exists actt_sys_type;
create table actt_sys_type(
	id_ varchar(36) NOT NULL COMMENT '主键',
	parent_id_ varchar(36),
	category_ varchar(128) not null COMMENT '分类,例如：task,process,client...',
	name_ varchar(255) not null,
	desc_ varchar(255),
	status_ varchar(2) COMMENT '0:有效',
	tenant_id_ varchar(36),
	tenant_name_ varchar(128),
	crt_id_ varchar(36) COMMENT '建立人工号',
	upd_id_ varchar(36) COMMENT '修改人工号',
	crt_time_ timestamp DEFAULT CURRENT_TIMESTAMP NULL COMMENT '创建时间', 
	upd_time_ timestamp NULL COMMENT '更新时间', 
	rev_ int COMMENT '版本号',
	primary key (id_),
	unique index actt_sys_type_uni_idx_name_tenant_parent(name_,tenant_id_,parent_id_)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统类型表';

alter table actt_hi_procinst add constraint actt_fk_actt_ge_hi_procinst_buskey_id foreign key (business_key_) references actt_ge_client(id_);

alter table	actt_id_belong_user_membership add constraint actt_fk_belong_user_membership_user foreign key actt_id_belong_user_membership(user_id_) references actt_id_user(id_);
alter table	actt_id_belong_user_membership add constraint actt_fk_belong_user_membership_prop foreign key actt_id_belong_user_membership(belong_id_) references actt_re_user_belong(id_);

-- 主键算法  select REPLACE(uuid(),'-','');
insert into actt_re_tenant(id_,name_,status_,account_,addr_,phone_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value ('00dfbbfd802d11ea814654e1ad0a1f62','demo','0000','demo-account','earth','change frequently','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

insert into actt_id_user(id_,first_,last_,no_,status_,salt_,pwd_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value ('5e3d1eea7fb211ea93b054e1ad0a1f62','cheyenne','chen','Cheyenne0001','0000','cf7a3889-05d0-4db4-b910-4cef9929e30c','8d49b28c40a800575fca4319eed21890','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

insert into actt_sys_role_info(id_,role_type_,role_name_,auth_ids_,sys_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value ('b43b56b7803011ea814654e1ad0a1f62','super-admin','super system manager','0000','demo','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

insert into actt_id_user_role(id_,no_,user_id_,sys_role_id_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value (REPLACE(uuid(),'-',''),'Cheyenne0001','5e3d1eea7fb211ea93b054e1ad0a1f62','b43b56b7803011ea814654e1ad0a1f62','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

insert into actt_re_user_belong_type(id_,name_,desc_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value ('ca295f2c803c11ea814654e1ad0a1f62','Department','use for demo','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
insert into actt_re_user_belong_type(id_,name_,desc_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_) value ('33e99110803d11ea814654e1ad0a1f62','Time zone','use for demo','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Task','Open','Start','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Task','Open','Processing','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Task','Close','Finished','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Task','Close','Deleted','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Job','Open','Start','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Job','Open','Processing','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Job','Close','Finished','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Job','Close','Deleted','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Client','Open','Start','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Client','Open','Processing','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Client','Close','Finished','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_status_dict (id_,category_,type_,name_,flag_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'Client','Close','Deleted','1','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);

INSERT INTO actt_sys_type (id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE('fe9a20ce883511eabba454e1ad0a1f62','Task','NON-BILLABLE','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'fe9a20ce883511eabba454e1ad0a1f62','Task','Non-Billable','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'fe9a20ce883511eabba454e1ad0a1f62','Task','OTHER ACCOUTING SERVICES','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE('cbd84d09883611eabba454e1ad0a1f62','Task','BILLABLE','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','FINANCIAL STATEMENTS PREPARATION','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','ADVISORY & PLANNING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','ADMIN & ADMIN SUPPORTING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','AUDIT ASSISTANCE','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','AUDIT REPRESENTATION','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','BOOKKEEPING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','QUICKBOOKS TRAINING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','QUICKBOOKS CLEANING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','DIRECTOR/MANAGER/OFFICER/OFFICER SUPPORTING','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
INSERT INTO actt_sys_type (id_,parent_id_,category_,name_,status_,tenant_id_,tenant_name_,crt_id_,upd_id_,crt_time_,upd_time_,rev_)
VALUE(REPLACE(uuid(),'-',''),'cbd84d09883611eabba454e1ad0a1f62','Task','PAYROLL SERVICE','0','00dfbbfd802d11ea814654e1ad0a1f62','demo','demo','','2020-04-07 00:00:00','2020-04-07 00:00:00',1);
