package com.gigabox.admin.cinema.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cinema.persistence.MovieroomDAO;
import com.gigabox.admin.cinema.vo.MovieroomVO;

@Service
public class MovieroomServiceImpl implements MovieroomService {

	@Inject
	private MovieroomDAO movieroomDAO;
	
	@Override
	public List<MovieroomVO> movieroomList(int branchNumber) {
		return movieroomDAO.movieroomList(branchNumber);
	}

	@Override
	public MovieroomVO movieroomDetail(MovieroomVO movieroomVO) {
		return movieroomDAO.movieroomDetail(movieroomVO);
	}

	@Override
	public int movieroomInsert(MovieroomVO movieroomVO) {
		return movieroomDAO.movieroomInsert(movieroomVO);
	}

	@Override
	public int movieroomUpdate(MovieroomVO movieroomVO) {
		return movieroomDAO.movieroomUpdate(movieroomVO);
	}

}
