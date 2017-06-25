package com.gigabox.upload.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/gigabox")
public class DeleteController {

	private static final Logger logger = LoggerFactory.getLogger(DeleteController.class);

	@RequestMapping(value = "/movie/{purpose}/{movieCode}/{fileName}.{fileType}/delete", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteFile(@PathVariable String purpose, @PathVariable String movieCode,
			@PathVariable String fileName, @PathVariable String fileType, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		logger.info("===========================================================");
		logger.info("DELETE CONTROLLER : DELETE FILE START");

		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("PURPOSE= " + purpose);
		logger.info("movieCode= " + movieCode);
		logger.info("fileName= " + fileName);
		logger.info("fileType= " + fileType);
		logger.info("CONTEXT PATH= " + contextPath);

		File targetFolder = new File(contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
				+ File.separator + purpose + File.separator + movieCode);
		logger.info("TARGET FOLDER= " + targetFolder.getAbsolutePath());

		Map<String, Object> resultMap = new HashMap<>();

		if (!targetFolder.exists()) {
			logger.info("TARGET FOLDER EXIST? ==> " + targetFolder.exists());
			resultMap.put("errorMessage", "TARGET FOLDER IS NOT EXISTS");
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.BAD_REQUEST);
		}

		File target = new File(contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
				+ File.separator + purpose + File.separator + movieCode + File.separator + fileName + "." + fileType);
		if (!target.exists()) {
			logger.info("TARGET FILE EXIST? ==> " + target.exists());
			resultMap.put("errorMessage", "TARGET FILE IS NOT EXISTS");
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.BAD_REQUEST);
		}

		logger.info("TARGET FILE= " + target.getAbsolutePath());

		if (purpose.equals("poster") || purpose.equals("steelcut")) {

			File thumb = new File(contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
					+ File.separator + purpose + File.separator + movieCode + File.separator + "thumb" + File.separator
					+ "thumb_" + fileName + "." + fileType);
			if (!thumb.exists()) {
				logger.info("TARGET FILE EXIST? ==> " + thumb.exists());
				resultMap.put("errorMessage", "THUMB OF TARGET FILE IS NOT EXISTS");
				resultMap.put("message", "FAIL");
				return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.BAD_REQUEST);
			}
			try {
				target.delete();
			} catch (Exception e) {
				e.printStackTrace();
				resultMap.put("errorMessage", e.getMessage());
				resultMap.put("message", "FAIL");
				return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
			}

		} else if (purpose.equals("trailer")) {
			try {
				target.delete();
			} catch (Exception e) {
				e.printStackTrace();
				resultMap.put("errorMessage", e.getMessage());
				resultMap.put("message", "FAIL");
				return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
			}

		}

		resultMap.put("message", "SUCCESS");
		resultMap.put("fileName", fileName + "." + fileType);
		resultMap.put("fileDir", contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
				+ File.separator + purpose + File.separator + movieCode + File.separator);
		logger.info("DELETE CONTROLLER : DELETE FILE END");
		logger.info("===========================================================");
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}

	@RequestMapping(value="/movie/{purpose}/{movieCode}/deleteAll", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteFileAll(@PathVariable String purpose, @PathVariable String movieCode,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("DELETE CONTROLLER : DELETE ALL FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("PURPOSE= " + purpose);
		logger.info("movieCode= " + movieCode);
		logger.info("CONTEXT PATH= " + contextPath);
		
		File targetFolder = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + "movie" + File.separator + purpose + 
				File.separator + movieCode);
		logger.info("TARGET FOLDER= " + targetFolder.getAbsolutePath());
		
		Map<String, Object> resultMap = new HashMap<>();
		
		if (!targetFolder.exists()) {
			logger.info("TARGET FOLDER EXIST? ==> " + targetFolder.exists());
			resultMap.put("errorMessage", "TARGET FOLDER IS NOT EXISTS");
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			deleteDirectory(targetFolder);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("errorMessage", e.getMessage());
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		resultMap.put("message", "SUCCESS");
		resultMap.put("fileDir", contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
				+ File.separator + purpose + File.separator + movieCode + File.separator);
		logger.info("DELETE CONTROLLER : DELETE FILE END");
		logger.info("===========================================================");
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}
	
	@RequestMapping(value="/branch/{branchNumber}/delete", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> deleteBranchPictureFile( @PathVariable String branchNumber,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("DELETE CONTROLLER : DELETE BRANCH PICTURE FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("branchNumber= " + branchNumber);
		logger.info("CONTEXT PATH= " + contextPath);
		
		File targetFolder = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + "branch" + File.separator + branchNumber);
		logger.info("TARGET FOLDER= " + targetFolder.getAbsolutePath());
		
		Map<String, Object> resultMap = new HashMap<>();
		
		if (!targetFolder.exists()) {
			logger.info("TARGET FOLDER EXIST? ==> " + targetFolder.exists());
			resultMap.put("errorMessage", "TARGET FOLDER IS NOT EXISTS");
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.BAD_REQUEST);
		}
		
		try {
			deleteDirectory(targetFolder);
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("errorMessage", e.getMessage());
			resultMap.put("message", "FAIL");
			return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		resultMap.put("message", "SUCCESS");
		resultMap.put("fileDir", contextPath + "upload" + File.separator + "gigabox" + File.separator + "movie"
				+ File.separator + branchNumber + File.separator);
		logger.info("DELETE CONTROLLER : DELETE FILE END");
		logger.info("===========================================================");
		return new ResponseEntity<Map<String, Object>>(resultMap, HttpStatus.OK);
	}

	private static boolean deleteDirectory(File dir) throws Exception {
		if (!dir.exists()) {
			return false;
		}
		File[] files = dir.listFiles();
		for (File file : files) {
			if (file.isDirectory()) {
				deleteDirectory(file);
			} else {
				file.delete();
			}
		}
		return dir.delete();
	}

}
