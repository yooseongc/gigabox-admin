package com.gigabox.admin.stat.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.stat.vo.BranchStatVO;
import com.gigabox.admin.stat.vo.MovieStatVO;
import com.gigabox.admin.stat.vo.UserStatVO;

@Repository
public class StatDAOImpl implements StatDAO {

	private static final String namespace = "com.gigabox.admin.mapper.StatMapper";
	
	@Inject
	private SqlSession sqlSession;
	
	@Override
	public List<UserStatVO> getUserGenderCountStat() {
		return sqlSession.selectList(namespace + ".getUserGenderCountStat");
	}

	@Override
	public List<UserStatVO> getUserRegisterCountStat(String selectedYear, String selectedMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectedYear", selectedYear);
		map.put("selectedMonth", selectedMonth);
		return sqlSession.selectList(namespace + ".getUserRegisterCountStat", map);
	}

	@Override
	public List<UserStatVO> getUserAgeCountStat() {
		return sqlSession.selectList(namespace + ".getUserAgeCountStat");
	}

	@Override
	public List<BranchStatVO> getBranchResvStatusStat(String selectedYear, String selectedMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectedYear", selectedYear);
		map.put("selectedMonth", selectedMonth);
		return sqlSession.selectList(namespace + ".getBranchResvStatusStat", map);
	}

	@Override
	public List<BranchStatVO> getBranchPaymentStat(String selectedYear, String selectedMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectedYear", selectedYear);
		map.put("selectedMonth", selectedMonth);
		return sqlSession.selectList(namespace + ".getBranchPaymentStat", map);
	}

	@Override
	public List<MovieStatVO> getMovieResvStatusStat(String selectedYear, String selectedMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectedYear", selectedYear);
		map.put("selectedMonth", selectedMonth);
		return sqlSession.selectList(namespace + ".getMovieResvStatusStat", map);
	}

	@Override
	public List<MovieStatVO> getMoviePaymentStat(String selectedYear, String selectedMonth) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("selectedYear", selectedYear);
		map.put("selectedMonth", selectedMonth);
		return sqlSession.selectList(namespace + ".getMoviePaymentStat", map);
	}

}
