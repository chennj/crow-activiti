package net.crow.activiti.track.common.db.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.crow.activiti.track.common.db.dao.model.ReturnT;
import net.crow.activiti.track.common.db.second.dao.IXxlMqMessageDao;
import net.crow.activiti.track.common.util.DateUtil;

@Service
public class MessageService {

	@Autowired
	IXxlMqMessageDao xxlMqMessageDao;
	
	public Map<String,Object> dashboardInfo(){
		
        int bizCount = 12;
        int topicCount = 10;
        int messageCount = 50;

//        List<MqBiz> bizList = xxlMqBizService.findAll();
//        bizCount = bizList!=null?bizList.size():0;
//        topicCount = xxlMqTopicDao.pageListCount(0, 1, -1, null);
//        messageCount = xxlMqMessageDao.pageListCount(0, 1, null, null, null, null);

        Map<String, Object> dashboardMap = new HashMap<String, Object>();
        dashboardMap.put("bizCount", bizCount);
        dashboardMap.put("topicCount", topicCount);
        dashboardMap.put("messageCount", messageCount);
        return dashboardMap;

	}

    public ReturnT<Map<String, Object>> chartInfo(String startDate, String endDate) {

        // process
        List<String> messageDay_list = new ArrayList<String>();
        List<Integer> newNum_list = new ArrayList<Integer>();
        List<Integer> ingNum_list = new ArrayList<Integer>();
        List<Integer> successNum_list = new ArrayList<Integer>();
        List<Integer> failNum_list = new ArrayList<Integer>();

        int newNum_total = 0;
        int ingNum_total = 0;
        int successNum_total = 0;
        int failNum_total = 0;


        List<Map<String, Object>> triggerCountMapAll = xxlMqMessageDao.messageCountByDay(startDate, endDate);
        if (triggerCountMapAll!=null && triggerCountMapAll.size()>0) {
            for (Map<String, Object> item: triggerCountMapAll) {

                String messageDay = String.valueOf(item.get("messageDay"));
                int newNum = Integer.valueOf(String.valueOf(item.get("newNum")));
                int ingNum = Integer.valueOf(String.valueOf(item.get("ingNum")));
                int successNum = Integer.valueOf(String.valueOf(item.get("successNum")));
                int failNum = Integer.valueOf(String.valueOf(item.get("failNum")));

                messageDay_list.add(messageDay);
                newNum_list.add(newNum);
                ingNum_list.add(ingNum);
                successNum_list.add(successNum);
                failNum_list.add(failNum);

                newNum_total += newNum;
                ingNum_total += ingNum;
                successNum_total += successNum;
                failNum_total += failNum;
            }
        } else {
            for (int i = 4; i > -1; i--) {
                String messageDay = DateUtil.formatDate(new Date());

                messageDay_list.add(messageDay);
                newNum_list.add(0);
                ingNum_list.add(0);
                successNum_list.add(0);
                failNum_list.add(0);
            }
        }


        Map<String, Object> result = new HashMap<String, Object>();
        result.put("messageDay_list", messageDay_list);
        result.put("newNum_list", newNum_list);
        result.put("ingNum_list", ingNum_list);
        result.put("successNum_list", successNum_list);
        result.put("failNum_list", failNum_list);

        result.put("newNum_total", newNum_total);
        result.put("ingNum_total", ingNum_total);
        result.put("successNum_total", successNum_total);
        result.put("failNum_total", failNum_total);

        return new ReturnT<Map<String, Object>>(result);
    }

}
