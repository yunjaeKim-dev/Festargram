package com.teamproject.mapper;

import java.util.List;

import com.teamproject.domain.AttachFile;

public interface FileMapper {
	
	// 첨부파일 DB등록
	int insert(AttachFile file);
	
	// uuid를 통해 특정첨부파일 한개만삭제하는 mapepr
	int delete(String uuid);
	
	// postno를통해 해당게시글의 모든 첨부파일을 삭제하는 mapper
	int deleteAll(Integer postno);
	
	//Quartz 라이브러리르를통해 하루전파일들을 DB와 비교해 삭제하기위해 하루전첨부파일 리스트를 가져오는 mapper
	List<AttachFile> getOldFiles();
	// Postno를통해 해당게시글의 모든 첨부파일을 리턴하는 mapper
	List<AttachFile> getAttachListByPostno(Integer postno);
}
