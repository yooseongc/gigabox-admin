package com.gigabox.admin.stat.service;

import java.util.List;

import com.gigabox.admin.stat.vo.BranchStatVO;
import com.gigabox.admin.stat.vo.MovieStatVO;
import com.gigabox.admin.stat.vo.UserStatVO;

public interface StatService {
	
	public List<UserStatVO> getUserGenderCountStat();
	
	public List<UserStatVO> getUserRegisterCountStat(String selectedYear, String selectedMonth);
	
	public List<UserStatVO> getUserAgeCountStat();
	
	public List<BranchStatVO>  getBranchResvStatusStat(String selectedYear, String selectedMonth);
	
	public List<BranchStatVO> getBranchPaymentStat(String selectedYear, String selectedMonth);
	
	public List<MovieStatVO>  getMovieResvStatusStat(String selectedYear, String selectedMonth);
	
	public List<MovieStatVO> getMoviePaymentStat(String selectedYear, String selectedMonth);

}
