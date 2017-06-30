package com.gigabox.admin.cinema.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cinema.persistence.ScheduleDAO;
import com.gigabox.admin.cinema.vo.ScheduleSearchCriteria;
import com.gigabox.admin.cinema.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Inject
	private ScheduleDAO scheduleDAO;
	
	@Override
	public List<ScheduleVO> scheduleList(ScheduleSearchCriteria ssc) {
		return scheduleDAO.scheduleList(ssc);
	}

	@Override
	public int scheduleListCount(ScheduleSearchCriteria ssc) {
		return scheduleDAO.scheduleListCount(ssc);
	}

	@Override
	public ScheduleVO scheduleDetail(ScheduleVO scheduleVO) {
		return scheduleDAO.scheduleDetail(scheduleVO);
	}

	@Override
	public int scheduleInsert(ScheduleVO scheduleVO) {
		return scheduleDAO.scheduleInsert(scheduleVO);
	}

	@Override
	public int scheduleUpdate(ScheduleVO scheduleVO) {
		return scheduleDAO.scheduleUpdate(scheduleVO);
	}

}
