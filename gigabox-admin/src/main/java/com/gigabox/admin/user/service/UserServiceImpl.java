package com.gigabox.admin.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gigabox.admin.user.persistence.UserDAO;
import com.gigabox.admin.user.vo.UserSearchCriteria;
import com.gigabox.admin.user.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO userDAO;
	
	@Override
	public List<UserVO> userList(UserSearchCriteria usc) {
		return userDAO.userList(usc);
	}

	@Override
	public int userListCount(UserSearchCriteria usc) {
		return userDAO.userListCount(usc);
	}

	@Override
	public UserVO userDetail(UserVO userVO) {
		return userDAO.userDetail(userVO);
	}

	@Override
	public int userUpdate(UserVO userVO) {
		return userDAO.userUpdate(userVO);
	}

}
