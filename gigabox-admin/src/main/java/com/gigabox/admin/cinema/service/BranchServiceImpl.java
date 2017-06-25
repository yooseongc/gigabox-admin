package com.gigabox.admin.cinema.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.cinema.persistence.BranchDAO;
import com.gigabox.admin.cinema.vo.BranchSearchCriteria;
import com.gigabox.admin.cinema.vo.BranchVO;

@Service
public class BranchServiceImpl implements BranchService {

	@Inject
	private BranchDAO branchDAO;
	
	@Override
	public List<BranchVO> branchListAll() {
		return branchDAO.branchListAll();
	}

	@Override
	public List<BranchVO> branchList(BranchSearchCriteria bsc) {
		return branchDAO.branchList(bsc);
	}

	@Override 
	public int branchListCount(BranchSearchCriteria bsc) {
		return branchDAO.branchListCount(bsc);
	}
	
	@Override
	public BranchVO branchDetail(BranchVO branchVO) {
		return branchDAO.branchDetail(branchVO);
	}

	@Override
	public int branchInsert(BranchVO branchVO) {
		return branchDAO.branchInsert(branchVO);
	}

	@Override
	public int branchUpdate(BranchVO branchVO) {
		return branchDAO.branchUpdate(branchVO);
	}

}
