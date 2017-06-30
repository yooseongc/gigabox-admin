package com.gigabox.admin.cinema.service;

import java.util.List;

import com.gigabox.admin.cinema.vo.MovieroomVO;

public interface MovieroomService {

	public List<MovieroomVO> movieroomList(int branchNumber);
	
	public MovieroomVO movieroomDetail(MovieroomVO movieroomVO);
	
	public int movieroomInsert(MovieroomVO movieroomVO);
	
	public int movieroomUpdate(MovieroomVO movieroomVO);
	
}
