package com.ojo.controller;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ojo.dao.MainDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/appServlet/test-context.xml")
public class DBTest {

	@Autowired
	private SqlSession sqlSession;
	
	@Test
	public void test() {
		MainDao mainDao = sqlSession.getMapper(MainDao.class);
//		Member member = mainDao.getMember();
//		System.out.println(member.toString());
	}

}
