package com.gigabox.upload.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gigabox.upload.dto.UploadFileDTO;
import com.gigabox.upload.dto.UploadMessageDTO;
import com.gigabox.upload.utils.UploadUtil;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/gigabox")
public class UploadController {

	private final static Logger logger = LoggerFactory.getLogger(UploadController.class);
	
	@RequestMapping(value="/movieroom/seatdata", method=RequestMethod.POST) 
	public ResponseEntity<UploadMessageDTO> uploadSeatdata(UploadFileDTO dto, String jsonStr,
			 HttpServletRequest request) {
		logger.info("===================================================");
		logger.info("UPLOAD SEATDATA JSON TEXT FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		logger.info("CONTEXT PATH= " + request.getServletContext().getRealPath("/"));
		
		String contextPath = request.getServletContext().getRealPath("/");
		String seatdataPathHome = "upload" + File.separator + "gigabox" + File.separator + "movieroom" + 
				File.separator;
		logger.info("SEATDATA PATH= " + seatdataPathHome);
		
		
		
		// 2. 목적 오류
		if (dto.getPurpose() == null || "".equals(dto.getPurpose())) {
			logger.info("ERROR : NO PURPOSE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD SEATDATA JSON TEXT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!"seatdata".equals(dto.getPurpose())) {
			logger.info("ERROR : IMPROPER PURPOSE! : " + dto.getPurpose());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD SEATDATA JSON TEXT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 5. 경로 체크
		if (dto.getFileDir() == null || "".equals(dto.getFileDir())) {
			logger.info("ERROR : NO FILEDIR!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD SEATDATA JSON TEXT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileDir().startsWith(seatdataPathHome))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD SEATDATA JSON TEXT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		File fileDir = new File(contextPath + dto.getFileDir());
		if (!fileDir.exists()) {
			logger.info("MAKE DIRECTORY= " + fileDir.getAbsolutePath());
			fileDir.mkdir();
		}
		String fileDirPath = contextPath + dto.getFileDir();
		logger.info("FILEDIR PATH= " + fileDirPath);
		String fileName = dto.getFileName();
		String fileType = dto.getFileType();
		
		
		JSONParser parser = new JSONParser();
		JSONObject jsonObj = null;
		
		
		
		
		try (FileWriter file = new FileWriter(fileDirPath + File.separator + fileName + "." + fileType)) {
			jsonObj = (JSONObject) parser.parse(jsonStr);
			logger.info("JSON OBJ= " + jsonObj.toJSONString());
			file.write(jsonObj.toJSONString());
			logger.info("Successfully Copied JSON Object to File...");
		} catch (IOException | ParseException e) {
			e.printStackTrace();
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("ERROR OCCURED IN SERVER SIDE: " + e.getMessage());
			mdto.setResult(120);
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.EXPECTATION_FAILED);
		}
		
		logger.info("UPLOADING SEATDATA JSON TEXT SUCCESSED!");
		UploadMessageDTO mdto = new UploadMessageDTO();
		mdto.setFileDir(dto.getFileDir());
		mdto.setFileName(dto.getFileName());
		mdto.setFileType(dto.getFileType());
		mdto.setPurpose(dto.getPurpose());
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD SEATDATA JSON TEXT FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/branch/picture", method=RequestMethod.POST)
	public ResponseEntity<UploadMessageDTO> uploadBranchPicture(UploadFileDTO dto, MultipartHttpServletRequest request) {
		
		logger.info("===================================================");
		logger.info("UPLOAD BRANCH PICTURE FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		logger.info("CONTEXT PATH= " + request.getServletContext().getRealPath("/"));
		String contextPath = request.getServletContext().getRealPath("/");
		String picturePathHome = "upload" + File.separator + "gigabox" + File.separator + "branch" + 
				File.separator;
		logger.info("BRANCH PATH= " + picturePathHome);
		MultipartFile uploadFile = request.getFile(request.getFileNames().next());
		
		// 1. "110"번 에러 : 파일 missing
		if (uploadFile.isEmpty()) {
			logger.info("ERROR : NO FILE UPLOADED!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILE");
			mdto.setResult(110);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 2. 목적 오류
		if (dto.getPurpose() == null || "".equals(dto.getPurpose())) {
			logger.info("ERROR : NO PURPOSE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!"picture".equals(dto.getPurpose())) {
			logger.info("ERROR : IMPROPER PURPOSE! : " + dto.getPurpose());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 3. 파일 타입 오류 (JPG, GIF, PNG만)
		if (dto.getFileType() == null || "".equals(dto.getFileType())) {
			logger.info("ERROR : NO FILETYPE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileType().equalsIgnoreCase("jpg") || 
				dto.getFileType().equalsIgnoreCase("png") || dto.getFileType().equalsIgnoreCase("gif") 
				|| dto.getFileType().equalsIgnoreCase("jpeg"))) {
			logger.info("ERROR : IMPROPER FILETYPE! : " + dto.getFileType());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
		}

		// 4. 파일 이름 체크
		if (dto.getFileName() == null || "".equals(dto.getFileName())) {
			logger.info("ERROR : NO FILENAME!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILENAME");
			mdto.setResult(90);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 5. 경로 체크
		if (dto.getFileDir() == null || "".equals(dto.getFileDir())) {
			logger.info("ERROR : NO FILEDIR!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileDir().startsWith(picturePathHome))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD BRANCH PICTURE FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		logger.info("UPLOADING FILE NAME= " + uploadFile.getName());
		logger.info("UPLOADING FILE TYPE= " + uploadFile.getContentType());
		logger.info("UPLOADING FILE ORIGINAL NAME= " + uploadFile.getOriginalFilename());
		logger.info("UPLOADING FILE SIZE= " + uploadFile.getSize());
		
		File fileDir = new File(contextPath + dto.getFileDir());
		if (!fileDir.exists()) {
			logger.info("MAKE DIRECTORY= " + fileDir.getAbsolutePath());
			fileDir.mkdir();
		}
		String fileDirPath = contextPath + dto.getFileDir();
		logger.info("FILEDIR PATH= " + fileDirPath);
		String fileName = dto.getFileName();
		String fileType = dto.getFileType();
		
		try {
			UploadUtil.fileUpload(uploadFile, fileDirPath, fileName, fileType, false);
		} catch (IOException e) {
			e.printStackTrace();
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("ERROR OCCURED IN SERVER SIDE: " + e.getMessage());
			mdto.setResult(120);
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.EXPECTATION_FAILED);
		}
		
		logger.info("UPLOADING BRANCH PICTURE SUCCESSED!");
		UploadMessageDTO mdto = new UploadMessageDTO();
		mdto.setFileDir(dto.getFileDir());
		mdto.setFileName(dto.getFileName());
		mdto.setFileType(dto.getFileType());
		mdto.setPurpose(dto.getPurpose());
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD BRANCH PICTURE FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
	}
	
	@RequestMapping(value="/movie/poster", method=RequestMethod.POST)
	public ResponseEntity<UploadMessageDTO> uploadMoviePoster(UploadFileDTO dto, MultipartHttpServletRequest request) {
		
		logger.info("===================================================");
		logger.info("UPLOAD MOVIE POSTER FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		logger.info("CONTEXT PATH= " + request.getServletContext().getRealPath("/"));
		String contextPath = request.getServletContext().getRealPath("/");
		String posterPathHome = "upload" + File.separator + "gigabox" + File.separator + "movie" + 
				File.separator + "poster" + File.separator;
		logger.info("POSTER PATH= " + posterPathHome);
		MultipartFile uploadFile = request.getFile(request.getFileNames().next());
		
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
		} else if (!"POSTER-UPLOAD".equals(dto.getPurpose())) {
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
		} else if (!(dto.getFileDir().startsWith(posterPathHome))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE POSTER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		logger.info("UPLOADING FILE NAME= " + uploadFile.getName());
		logger.info("UPLOADING FILE TYPE= " + uploadFile.getContentType());
		logger.info("UPLOADING FILE ORIGINAL NAME= " + uploadFile.getOriginalFilename());
		logger.info("UPLOADING FILE SIZE= " + uploadFile.getSize());
		
		File fileDir = new File(contextPath + dto.getFileDir());
		if (!fileDir.exists()) {
			logger.info("MAKE DIRECTORY= " + fileDir.getAbsolutePath());
			fileDir.mkdir();
		}
		String fileDirPath = contextPath + dto.getFileDir();
		logger.info("FILEDIR PATH= " + fileDirPath);
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
		mdto.setThumb("thumb_" + dto.getFileName() + "." + dto.getFileType());
		mdto.setThumbDir(dto.getFileDir() + File.separator + "thumb");
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD MOVIE POSTER FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/movie/steelcut", method=RequestMethod.POST)
	public ResponseEntity<UploadMessageDTO> uploadMovieSteelcut(UploadFileDTO dto, MultipartHttpServletRequest request) {
		
		logger.info("===================================================");
		logger.info("UPLOAD MOVIE STEELCUT FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		logger.info("CONTEXT PATH= " + request.getServletContext().getRealPath("/"));
		String contextPath = request.getServletContext().getRealPath("/");
		String steelcutPathHome = "upload" + File.separator + "gigabox" + File.separator + "movie" + 
				File.separator + "steelcut" + File.separator;
		logger.info("STEELCUT PATH= " + steelcutPathHome);
		MultipartFile uploadFile = request.getFile(request.getFileNames().next());
		
		// 1. "110"번 에러 : 파일 missing
		if (uploadFile.isEmpty()) {
			logger.info("ERROR : NO FILE UPLOADED!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILE");
			mdto.setResult(110);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 2. 목적 오류
		if (dto.getPurpose() == null || "".equals(dto.getPurpose())) {
			logger.info("ERROR : NO PURPOSE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!"STEELCUT-UPLOAD".equals(dto.getPurpose())) {
			logger.info("ERROR : IMPROPER PURPOSE! : " + dto.getPurpose());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 3. 파일 타입 오류 (JPG, GIF, PNG만)
		if (dto.getFileType() == null || "".equals(dto.getFileType())) {
			logger.info("ERROR : NO FILETYPE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileType().equalsIgnoreCase("jpg") || 
				dto.getFileType().equalsIgnoreCase("png") || dto.getFileType().equalsIgnoreCase("gif") 
				|| dto.getFileType().equalsIgnoreCase("jpeg"))) {
			logger.info("ERROR : IMPROPER FILETYPE! : " + dto.getFileType());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
		}

		// 4. 파일 이름 체크
		if (dto.getFileName() == null || "".equals(dto.getFileName())) {
			logger.info("ERROR : NO FILENAME!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILENAME");
			mdto.setResult(90);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 5. 경로 체크
		if (dto.getFileDir() == null || "".equals(dto.getFileDir())) {
			logger.info("ERROR : NO FILEDIR!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileDir().startsWith(steelcutPathHome))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE STEELCUT FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		logger.info("UPLOADING FILE NAME= " + uploadFile.getName());
		logger.info("UPLOADING FILE TYPE= " + uploadFile.getContentType());
		logger.info("UPLOADING FILE ORIGINAL NAME= " + uploadFile.getOriginalFilename());
		logger.info("UPLOADING FILE SIZE= " + uploadFile.getSize());
		
		File fileDir = new File(contextPath + dto.getFileDir());
		if (!fileDir.exists()) {
			logger.info("MAKE DIRECTORY= " + fileDir.getAbsolutePath());
			fileDir.mkdir();
		}
		String fileDirPath = contextPath + dto.getFileDir();
		logger.info("FILEDIR PATH= " + fileDirPath);
		String fileName = dto.getFileName();
		String fileType = dto.getFileType();
		
		File[] alreadyFiles = new File(fileDirPath).listFiles();
		String fileList = "";
		for (int i = 0; i < alreadyFiles.length; i++) {
			if (i == alreadyFiles.length - 1) {
				fileList += alreadyFiles[i].getName();
			}
			fileList += alreadyFiles[i].getName() + ", ";
		}
		logger.info("FILE LIST IN FILEDIR PATH= " + fileList);
		
		// 개수 처리 : 파일 개수에 따라 뒤의 숫자가 달라진다. 001 ~ 
		String realFileName = fileName + "-" + String.format("%03d", alreadyFiles.length + 1);
		fileName = realFileName;
		
		try {
			UploadUtil.fileUpload(uploadFile, fileDirPath, fileName, fileType, true);
		} catch (IOException e) {
			e.printStackTrace();
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("ERROR OCCURED IN SERVER SIDE: " + e.getMessage());
			mdto.setResult(120);
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.EXPECTATION_FAILED);
		}
		
		logger.info("UPLOADING MOVIE STEELCUT SUCCESSED!");
		UploadMessageDTO mdto = new UploadMessageDTO();
		mdto.setFileDir(dto.getFileDir());
		mdto.setFileName(realFileName);
		mdto.setFileType(dto.getFileType());
		mdto.setPurpose(dto.getPurpose());
		mdto.setThumb("thumb_" + realFileName + "." + dto.getFileType());
		mdto.setThumbDir(dto.getFileDir() + File.separator + "thumb");
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD MOVIE STEELCUT FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
	}
	
	
	@RequestMapping(value="/movie/trailer", method=RequestMethod.POST)
	public ResponseEntity<UploadMessageDTO> uploadMovieTrailer(UploadFileDTO dto, MultipartHttpServletRequest request) {
		
		logger.info("===================================================");
		logger.info("UPLOAD MOVIE TRAILER FILE START");
		
		logger.info("REQUEST AJAX DATA= " + dto.toString());
		logger.info("CONTEXT PATH= " + request.getServletContext().getRealPath("/"));
		String contextPath = request.getServletContext().getRealPath("/");
		String trailerPathHome = "upload" + File.separator + "gigabox" + File.separator + "movie" + 
				File.separator + "trailer" + File.separator;
		logger.info("TRAILER PATH= " + trailerPathHome);
		MultipartFile uploadFile = request.getFile(request.getFileNames().next());
		
		// 1. "110"번 에러 : 파일 missing
		if (uploadFile.isEmpty()) {
			logger.info("ERROR : NO FILE UPLOADED!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILE");
			mdto.setResult(110);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 2. 목적 오류
		if (dto.getPurpose() == null || "".equals(dto.getPurpose())) {
			logger.info("ERROR : NO PURPOSE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!"TRAILER-UPLOAD".equals(dto.getPurpose())) {
			logger.info("ERROR : IMPROPER PURPOSE! : " + dto.getPurpose());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER PURPOSE");
			mdto.setResult(100);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 3. 파일 타입 오류 (JPG, GIF, PNG만)
		if (dto.getFileType() == null || "".equals(dto.getFileType())) {
			logger.info("ERROR : NO FILETYPE!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileType().equalsIgnoreCase("mp4"))) {
			logger.info("ERROR : IMPROPER FILETYPE! : " + dto.getFileType());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILETYPE");
			mdto.setResult(60);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
		}

		// 4. 파일 이름 체크
		if (dto.getFileName() == null || "".equals(dto.getFileName())) {
			logger.info("ERROR : NO FILENAME!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILENAME");
			mdto.setResult(90);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		// 5. 경로 체크
		if (dto.getFileDir() == null || "".equals(dto.getFileDir())) {
			logger.info("ERROR : NO FILEDIR!");
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS NO FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		} else if (!(dto.getFileDir().startsWith(trailerPathHome))) {
			logger.info("ERROR : IMPROPER FILEDIR! : " + dto.getFileDir());
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("REQUEST HAS IMPROPER FILEDIR");
			mdto.setResult(80);
			logger.info("UPLOAD MOVIE TRAILER FILE END");
			logger.info("===================================================");
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.BAD_REQUEST);
		}
		
		logger.info("UPLOADING FILE NAME= " + uploadFile.getName());
		logger.info("UPLOADING FILE TYPE= " + uploadFile.getContentType());
		logger.info("UPLOADING FILE ORIGINAL NAME= " + uploadFile.getOriginalFilename());
		logger.info("UPLOADING FILE SIZE= " + uploadFile.getSize());
		
		File fileDir = new File(contextPath + dto.getFileDir());
		if (!fileDir.exists()) {
			logger.info("MAKE DIRECTORY= " + fileDir.getAbsolutePath());
			fileDir.mkdir();
		}
		String fileDirPath = contextPath + dto.getFileDir();
		logger.info("FILEDIR PATH= " + fileDirPath);
		String fileName = dto.getFileName();
		String fileType = dto.getFileType();
		
		File[] alreadyFiles = new File(fileDirPath).listFiles();
		String fileList = "";
		for (int i = 0; i < alreadyFiles.length; i++) {
			if (i == alreadyFiles.length - 1) {
				fileList += alreadyFiles[i].getName();
			}
			fileList += alreadyFiles[i].getName() + ", ";
		}
		logger.info("FILE LIST IN FILEDIR PATH= " + fileList);
		// 개수 처리 : 파일 개수에 따라 뒤의 숫자가 달라진다. 001 ~ 
		String realFileName = fileName + "-" + String.format("%03d", alreadyFiles.length + 1);
		fileName = realFileName;
		
		try {
			UploadUtil.fileUpload(uploadFile, fileDirPath, fileName, fileType, false);
		} catch (IOException e) {
			e.printStackTrace();
			UploadMessageDTO mdto = new UploadMessageDTO();
			mdto.setMessage("ERROR OCCURED IN SERVER SIDE: " + e.getMessage());
			mdto.setResult(120);
			return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.EXPECTATION_FAILED);
		}
		
		logger.info("UPLOADING MOVIE TRAILER SUCCESSED!");
		UploadMessageDTO mdto = new UploadMessageDTO();
		mdto.setFileDir(dto.getFileDir());
		mdto.setFileName(realFileName);
		mdto.setFileType(dto.getFileType());
		mdto.setPurpose(dto.getPurpose());
		mdto.setMessage("SUCCESSE");
		mdto.setResult(20);
		
		logger.info("UPLOAD MOVIE TRAILER FILE END");
		logger.info("===================================================");
		return new ResponseEntity<UploadMessageDTO>(mdto, HttpStatus.OK);
	}
	
	
	
}
