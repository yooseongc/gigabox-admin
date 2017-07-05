package com.gigabox.admin.stat.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.stat.persistence.StatDAO;
import com.gigabox.admin.stat.vo.BranchStatVO;
import com.gigabox.admin.stat.vo.MovieStatVO;
import com.gigabox.admin.stat.vo.UserStatVO;


@Service
public class StatServiceImpl implements StatService {

	@Inject
	private StatDAO statDAO;
	
	@Override
	public List<UserStatVO> getUserGenderCountStat() {
		return statDAO.getUserGenderCountStat();
	}

	@Override
	public List<UserStatVO> getUserRegisterCountStat(String selectedYear, String selectedMonth) {
		return statDAO.getUserRegisterCountStat(selectedYear, selectedMonth);
	}

	@Override
	public List<UserStatVO> getUserAgeCountStat() {
		return statDAO.getUserAgeCountStat();
	}

	@Override
	public List<BranchStatVO> getBranchResvStatusStat(String selectedYear, String selectedMonth) {
		return statDAO.getBranchResvStatusStat(selectedYear, selectedMonth);
	}

	@Override
	public List<BranchStatVO> getBranchPaymentStat(String selectedYear, String selectedMonth) {
		return statDAO.getBranchPaymentStat(selectedYear, selectedMonth);
	}

	@Override
	public List<MovieStatVO> getMovieResvStatusStat(String selectedYear, String selectedMonth) {
		return statDAO.getMovieResvStatusStat(selectedYear, selectedMonth);
	}

	@Override
	public List<MovieStatVO> getMoviePaymentStat(String selectedYear, String selectedMonth) {
		return statDAO.getMoviePaymentStat(selectedYear, selectedMonth);
	}

}
