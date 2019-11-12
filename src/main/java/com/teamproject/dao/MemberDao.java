package com.teamproject.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.stereotype.Component;

import com.teamproject.domain.Member;

import lombok.Data;

@Data @Component
public class MemberDao {
	private SqlSessionFactory factory;
	public List<Member> getmemebers() {
		return 	factory.openSession().selectList("getmemberlists");
	}
	
	

}
