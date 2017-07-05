package com.gigabox.admin.reservation.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.reservation.vo.ReservationVO;

@Repository
public class ReservationDAOImpl implements ReservationDAO {

	@Inject
	private SqlSession sqlSession;
	
	private final static String namespace = "com.gigabox.admin.mapper.ReservationMapper";
	
	@Override
	public List<ReservationVO> reservationList(ReservationVO resvVO) {
		return sqlSession.selectList(namespace + ".reservationList", resvVO);
	}

	@Override
	public ReservationVO reservationDetail(ReservationVO resvVO) {
		return sqlSession.selectOne(namespace + ".reservationDetail", resvVO);
	}

	@Override
	public int reservationSeatInsert(ReservationVO resvVO) {
		return sqlSession.insert(namespace + ".reservationSeatInsert", resvVO);
	}

	@Override
	public int reservationPaymentUpdate(ReservationVO resvVO) {
		return sqlSession.update(namespace + ".reservationPaymentUpdate", resvVO);
	}

	@Override
	public int reservationDelete(ReservationVO resvVO) {
		return sqlSession.delete(namespace + ".reservationDelete", resvVO);
	}

}
