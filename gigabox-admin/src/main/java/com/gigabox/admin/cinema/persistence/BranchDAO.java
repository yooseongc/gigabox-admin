package com.gigabox.admin.cinema.persistence;

import java.util.List;

import com.gigabox.admin.cinema.vo.BranchVO;

public interface BranchDAO {

	public List<BranchVO> branchListAll(BranchVO branchVO);
	
	
	
}
