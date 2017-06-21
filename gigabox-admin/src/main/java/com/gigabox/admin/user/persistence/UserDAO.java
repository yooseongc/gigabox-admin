package com.gigabox.admin.user.persistence;

import java.util.List;

import com.gigabox.admin.user.vo.UserSearchCriteria;
import com.gigabox.admin.user.vo.UserVO;

public interface UserDAO {

	public List<UserVO> userList(UserSearchCriteria usc);
	
	public int userListCount(UserSearchCriteria usc);
	
	public UserVO userDetail(UserVO userVO);
	
	public int userUpdate(UserVO userVO);
	
}
