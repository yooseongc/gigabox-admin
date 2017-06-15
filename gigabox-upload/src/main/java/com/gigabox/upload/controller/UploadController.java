package com.gigabox.upload.controller;

import java.io.File;
import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.gigabox.upload.dto.UploadFileDTO;
import com.gigabox.upload.dto.UploadMessageDTO;
import com.gigabox.upload.utils.UploadUtil;

@RestController
@RequestMapping("/upload/gigabox")
public class UploadController {

	private final static Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	private final static String PATH_HOME = "C:\\yooseongc\\upload";
	private final static String PATH_POSTER = PATH_HOME + "\\movie\\poster\\";
	/*private final static String PATH_STEELCUT = PATH_HOME + "\\movie\\steelcut\\";
	private final static String PATH_TRAILER = PATH_HOME + "\\movie\\trailer\\";
	private final static String PATH_SEAT = PATH_HOME + "\\seat\\";
	*/
	
	@RequestMapping(value="/movie/poster", method=RequestMethod.POST)
	public ResponseEntity<UploadMessageDTO> uploadMoviePoster(UploadFileDTO dto, MultipartFile uploadFile) {
		
		logger.info("===================================================");
		logger.info("UPLOAD MOVIE POSTER FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		
		// 1. "110"번 에러 : 파일 missing
		if (uploadFile.isEmpty()) {
			logger.info("ERROR : NO FILE UPLOADED!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILE");
			mdto.setResult(110);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 2. 목적 오류
		if (dto.getPurpose() == null || "".equals(dto.getPurpose())) {
			logger.info("ERROR : NO PURPOSE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if ("POSTER-UPLOAD".equals(dto.getPurpose())) {
			logger.info("ERROR : IMPROPER PURPOSE! : " + dto.getPurpose());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 3. 파일 타입 오류 (JPG, GIF, PNG만)
		if (dto.getFileType() == null || "".equals(dto.getFileType())) {
			logger.info("ERROR : NO FILETYPE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileType().equalsIgnoreCase("jpg") || 
				dto.getFileType().equalsIgnoreCase("png") || dto.getFileType().equalsIgnoreCase("gif") 
				|| dto.getFileType().equalsIgnoreCase("jpeg"))) {
			logger.info("ERROR : IMPROPER FILETYPE! : " + dto.getFileType());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
		}

		// 4. 파일 이름 체크
		if (dto.getFileName() == null || "".equals(dto.getFileName())) {
			logger.info("ERROR : NO FILENAME!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILENAME");
			mdto.setResult(90);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 5. 경로 체크
		if (dto.getFileDir() == null || "".equals(dto.getFileDir())) {
			logger.info("ERROR : NO FILEDIR!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileDir().startsWith(PATH_POSTER))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
		}
		
		logger.info("UPLOADING FILE NAME= " + uploadFile.getName());
		logger.info("UPLOADING FILE TYPE= " + uploadFile.getContentType());
		logger.info("UPLOADING FILE ORIGINAL NAME= " + uploadFile.getOriginalFilename());
		logger.info("UPLOADING FILE SIZE= " + uploadFile.getSize());
		
		File fileDir = new File(dto.getFileDir());
		if (!fileDir.exists()) {
			fileDir.mkdir();
		}
		String fileDirPath = fileDir.getAbsolutePath();
		String fileName = dto.getFileName();
		String fileType = dto.getFileType();
		
		try {
			UploadUtil.fileUpload(uploadFile, fileDirPath, fileName, fileType, true);
		} catch (IOException e) {
			e.printStackTrace();
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("ERROR OCCURED IN SERVER SIDE: " + e.getMessage());
			mdto.setResult(120);
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.EXPECTATION_FAILED);
		}
		
		logger.info("UPLOADING MOVIE SUCCESSED!");
		UploadMessageDTO mdto = new UploadMessageDTO();
		mdto.setFileDir(dto.getFileDir());
		mdto.setFileName(dto.getFileName());
		mdto.setFileType(dto.getFileType());
		mdto.setPurpose(dto.getPurpose());
		mdto.setThumb("thumb_" + dto.getFileName() + dto.getFileType());
		mdto.setThumbDir(dto.getFileDir() + File.pathSeparator + "thumb");
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD MOVIE POSTER FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
		
	}
	
}
