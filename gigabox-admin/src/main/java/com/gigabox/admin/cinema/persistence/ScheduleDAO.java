package com.gigabox.admin.cinema.persistence;

import java.util.List;

import com.gigabox.admin.cinema.vo.ScheduleSearchCriteria;
import com.gigabox.admin.cinema.vo.ScheduleVO;

public interface ScheduleDAO {

	public List<ScheduleVO> scheduleList(ScheduleSearchCriteria ssc);
	
	public int scheduleListCount(ScheduleSearchCriteria ssc);
	
	public ScheduleVO scheduleDetail(ScheduleVO scheduleVO);
	
	public int scheduleInsert(ScheduleVO scheduleVO);
	
	public int scheduleUpdate(ScheduleVO scheduleVO);
	
}
