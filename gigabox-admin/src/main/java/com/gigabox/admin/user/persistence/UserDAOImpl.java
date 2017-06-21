package com.gigabox.admin.user.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gigabox.admin.user.vo.UserSearchCriteria;
import com.gigabox.admin.user.vo.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.gigabox.admin.mapper.UserMapper";
	
	@Override
	public List<UserVO> userList(UserSearchCriteria usc) {
		return sqlSession.selectList(namespace + ".userList", usc);
	}

	@Override
	public int userListCount(UserSearchCriteria usc) {
		return sqlSession.selectOne(namespace + ".userListCount", usc);
	}

	@Override
	public UserVO userDetail(UserVO userVO) {
		return sqlSession.selectOne(namespace + ".userDetail", userVO);
	}

	@Override
	public int userUpdate(UserVO userVO) {
		return sqlSession.update(namespace + ".userUpdate", userVO);
	}

}
