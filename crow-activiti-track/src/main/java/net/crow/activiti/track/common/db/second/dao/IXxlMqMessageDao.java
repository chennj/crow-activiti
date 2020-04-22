package net.crow.activiti.track.common.db.second.dao;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import net.crow.activiti.track.common.db.second.entity.XxlMqMessage;

@Repository
public interface IXxlMqMessageDao extends JpaRepository<XxlMqMessage, BigInteger>{

	@Query(value = "SELECT "
			+ "DATE_FORMAT(addTime,'%Y-%m-%d') messageDay,"
			+ "COUNT(id) as totalNum,"
			+ "SUM(CASE WHEN (status = 'NEW' ) then 1 else 0 end) as newNum,"
			+ "SUM(CASE WHEN (status = 'RUNNING' ) then 1 else 0 end) as ingNum,"
			+ "SUM(CASE WHEN (status = 'SUCCESS' ) then 1 else 0 end) as successNum,"
			+ "SUM(CASE WHEN (status = 'FAIL' ) then 1 else 0 end) as failNum "
			+ "FROM xxl_mq_message "
			+ "WHERE addTime BETWEEN :startDate and :endDate "
			+ "GROUP BY messageDay",nativeQuery = true)
	public List<Map<String,Object>> messageCountByDay(@Param("startDate") String startDate, @Param("endDate") String endDate);

}
