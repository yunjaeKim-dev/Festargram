package com.teamproject.domain;

import org.apache.ibatis.type.Alias;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Alias("alarm")
public class Alarm {
	private Integer alarmno;
	private String name;
	private Integer mno;
	private String profimg;
	private String category;
	private String parentno;
	private String regdate;
}
