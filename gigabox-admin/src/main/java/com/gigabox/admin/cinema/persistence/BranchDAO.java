package com.gigabox.admin.cinema.persistence;

import java.util.List;

import com.gigabox.admin.cinema.vo.BranchSearchCriteria;
import com.gigabox.admin.cinema.vo.BranchVO;

public interface BranchDAO {

	public List<BranchVO> branchListAll();
	
	public List<BranchVO> branchList(BranchSearchCriteria bsc);
	
	public int branchListCount(BranchSearchCriteria bsc);
	
	public BranchVO branchDetail(BranchVO branchVO);
	
	public int branchInsert(BranchVO branchVO);
	
	public int branchUpdate(BranchVO branchVO);
	
}
