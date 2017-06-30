package com.gigabox.upload.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.RandomAccessFile;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/gigabox")
public class ViewController {

	private final static Logger logger = LoggerFactory.getLogger(ViewController.class);
	
	
	@ResponseBody
	@RequestMapping(value="/movie/{purpose}/{movieCode}/fileList", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> showFileList(@PathVariable String purpose, @PathVariable String movieCode,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET FILE LIST START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("PURPOSE= " + purpose);
		logger.info("movieCode= " + movieCode);
		logger.info("CONTEXT PATH= " + contextPath);
		
		File targetFolder = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + "movie" + File.separator + purpose + 
				File.separator + movieCode);
		logger.info("TARGET FOLDER= " + targetFolder.getAbsolutePath());
		logger.info("TARGET FOLDER EXIST? ==> " + targetFolder.isDirectory());
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("rootPath", "/upload/gigabox/movie/" + purpose + "/" + movieCode + "/");
		
		logger.info("========= FILE IN THIS TARGET FOLDER ==========");
		String[] fileList = targetFolder.list();
		for (int i = 0; i < fileList.length; i++) {
			logger.info("FILE " + (i+1) + "= " + fileList[i]);
		}
		logger.info("==============================================");
		resultMap.put("fileList", fileList);
		
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	@RequestMapping(value="/movie/poster/{movieCode}/{fileName}.{fileType}", method=RequestMethod.GET)
	public void showPosterImage(@PathVariable String movieCode, 
			@PathVariable String fileName, @PathVariable String fileType, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET IMAGE FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("FILE NAME= " + fileName);
		logger.info("FILE TYPE= " + fileType);
		logger.info("CONTEXT PATH= " + contextPath);
		File target = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + 
				"movie" + File.separator + 
				"poster" + File.separator + movieCode + File.separator + 
				fileName + "." + fileType);
		logger.info("TARGET FILE= " + target.getAbsolutePath());
		
		byte[] image = FileUtils.readFileToByteArray(target);
		if (fileType.equalsIgnoreCase("PNG")) {
			response.setContentType(MediaType.IMAGE_PNG_VALUE);
		} else if (fileType.equalsIgnoreCase("JPG") || fileType.equalsIgnoreCase("JPEG")) {
			response.setContentType(MediaType.IMAGE_JPEG_VALUE);
		} else if (fileType.equalsIgnoreCase("GIF")) {
			response.setContentType(MediaType.IMAGE_GIF_VALUE);
		}
		response.setContentLength(image.length);
	   
	    ServletOutputStream responseOutputStream = response.getOutputStream();
	    responseOutputStream.write(image);
	    responseOutputStream.flush();
	    responseOutputStream.close();
	    
	    logger.info("VIEW CONTROLLER : GET IMAGE FILE END");
	    logger.info("===========================================================");
	}
	
	@RequestMapping(value="/movie/steelcut/{movieCode}/{fileName}.{fileType}", method=RequestMethod.GET)
	public void showSteelcutImage(@PathVariable String movieCode, 
			@PathVariable String fileName, @PathVariable String fileType, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET IMAGE FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("FILE NAME= " + fileName);
		logger.info("FILE TYPE= " + fileType);
		logger.info("CONTEXT PATH= " + contextPath);
		File target = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + 
				"movie" + File.separator + 
				"steelcut" + File.separator + movieCode + File.separator + 
				"thumb" + File.separator + "thumb_" + fileName + "." + fileType);
		logger.info("TARGET FILE= " + target.getAbsolutePath());
		
		byte[] image = FileUtils.readFileToByteArray(target);
		if (fileType.equalsIgnoreCase("PNG")) {
			response.setContentType(MediaType.IMAGE_PNG_VALUE);
		} else if (fileType.equalsIgnoreCase("JPG") || fileType.equalsIgnoreCase("JPEG")) {
			response.setContentType(MediaType.IMAGE_JPEG_VALUE);
		} else if (fileType.equalsIgnoreCase("GIF")) {
			response.setContentType(MediaType.IMAGE_GIF_VALUE);
		}
		response.setContentLength(image.length);
	   
	    ServletOutputStream responseOutputStream = response.getOutputStream();
	    responseOutputStream.write(image);
	    responseOutputStream.flush();
	    responseOutputStream.close();
	    
	    logger.info("VIEW CONTROLLER : GET IMAGE FILE END");
	    logger.info("===========================================================");
	}
	
	@RequestMapping(value="/movie/trailer/{movieCode}/{fileName}.{fileType}", method=RequestMethod.GET)
	public void showTrailerVideoStreaming(@PathVariable String movieCode, 
			@PathVariable String fileName, @PathVariable String fileType, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET VIDEO FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("FILE NAME= " + fileName);
		logger.info("FILE TYPE= " + fileType);
		logger.info("CONTEXT PATH= " + contextPath);
		File target = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + 
				"movie" + File.separator + 
				"trailer" + File.separator + movieCode + File.separator + 
				fileName + "." + fileType);
		logger.info("TARGET FILE= " + target.getAbsolutePath());
		
		RandomAccessFile randomFile = new RandomAccessFile(target, "r");
		long rangeStart = 0; // 요청 범위 시작
		long rangeEnd = 0;   // 요청 범위 끝
		boolean isPart = false; // 부분 요청 : true, 전체 요청 : false
		
		try {
			long movieSize = randomFile.length(); // 영상 파일 크기 (byte)
			String range = request.getHeader("range");  // 스트링 요청 범위
			
			// range : bytes={start}-{end} 형식
			if (range != null) {
				if (range.endsWith("-")) {
					// end 값이 없는 경우 넣어줌
					range = range + (movieSize - 1);
				}
				int idxm = range.trim().indexOf("-");  // -의 위치
				rangeStart = Long.parseLong(range.substring(6, idxm));
				rangeEnd = Long.parseLong(range.substring(idxm + 1));
				if (rangeStart > 0) {
					isPart = true;
				}
			} else {
				// range가 null인 경우는 동영상 전체 크기로 초기값을 넣어줌
				rangeStart = 0;
				rangeEnd = movieSize - 1;
			}
			
			long partSize = rangeEnd - rangeStart + 1;  // 전송 파일 크기 (byte)
			
			// 전송 시작
			response.reset();
			response.setStatus(isPart ? 206 : 200);  // 부분 요청의 경우  206코드를 보냄
			response.setContentType("video/mp4");
			
			response.setHeader("Content-Range", "bytes " + rangeStart + "-" + rangeEnd + "/" + movieSize);
			response.setHeader("Accept-Ranges", "bytes");
			response.setHeader("Content-Length", "" + partSize);
			
			OutputStream out = response.getOutputStream();
			randomFile.seek(rangeStart);
			
			int bufferSize = 8 * 1024;	// 8kByte로 자름
			byte[] buf = new byte[bufferSize];
			do {
				int block = partSize > bufferSize ? bufferSize : (int) partSize;
				int len = randomFile.read(buf, 0, block);
				out.write(buf, 0, len);
				partSize -= block;
			} while (partSize > 0);
			
			
		} catch (IOException e) {
			
			logger.info("ERROR OCCURRED");
			e.printStackTrace();
			
		} finally {
			randomFile.close();
		}

	    logger.info("VIEW CONTROLLER : GET VIDEO FILE END");
	    logger.info("===========================================================");
	}
	
	
	@RequestMapping(value="/branch/{branchNumber}/{fileName}.{fileType}", method=RequestMethod.GET)
	public void showBranchPicture(@PathVariable String branchNumber, 
			@PathVariable String fileName, @PathVariable String fileType, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET IMAGE FILE START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("FILE NAME= " + fileName);
		logger.info("FILE TYPE= " + fileType);
		logger.info("CONTEXT PATH= " + contextPath);
		File target = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + 
				"branch" + File.separator + branchNumber + File.separator + 
				fileName + "." + fileType);
		logger.info("TARGET FILE= " + target.getAbsolutePath());
		
		byte[] image = FileUtils.readFileToByteArray(target);
		if (fileType.equalsIgnoreCase("PNG")) {
			response.setContentType(MediaType.IMAGE_PNG_VALUE);
		} else if (fileType.equalsIgnoreCase("JPG") || fileType.equalsIgnoreCase("JPEG")) {
			response.setContentType(MediaType.IMAGE_JPEG_VALUE);
		} else if (fileType.equalsIgnoreCase("GIF")) {
			response.setContentType(MediaType.IMAGE_GIF_VALUE);
		}
		response.setContentLength(image.length);
	   
	    ServletOutputStream responseOutputStream = response.getOutputStream();
	    responseOutputStream.write(image);
	    responseOutputStream.flush();
	    responseOutputStream.close();
	    
	    logger.info("VIEW CONTROLLER : GET IMAGE FILE END");
	    logger.info("===========================================================");
	}
	
	
	@ResponseBody
	@RequestMapping(value="/branch/{branchNumber}/pictureName", method=RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> showFileList(@PathVariable String branchNumber,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET FILE LIST START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("branchName= " + branchNumber);
		logger.info("CONTEXT PATH= " + contextPath);
		
		File targetFolder = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + "branch" + File.separator + branchNumber);
		logger.info("TARGET FOLDER= " + targetFolder.getAbsolutePath());
		logger.info("TARGET FOLDER EXIST? ==> " + targetFolder.isDirectory());
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("rootPath", "/upload/gigabox/branch/" + branchNumber + "/");
		
		logger.info("========= FILE IN THIS TARGET FOLDER ==========");
		String[] fileList = targetFolder.list();
		for (int i = 0; i < fileList.length; i++) {
			logger.info("FILE " + (i+1) + "= " + fileList[i]);
		}
		logger.info("==============================================");
		resultMap.put("pictureName", fileList[0]);
		
		return new ResponseEntity<Map<String,Object>>(resultMap, HttpStatus.OK);
	}
	
	@ResponseBody
	@RequestMapping(value="/movieroom/{movieroomNumber}/seatdata", method=RequestMethod.GET)
	public ResponseEntity<JSONObject> downloadSeatdata(@PathVariable String movieroomNumber, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.info("===========================================================");
		logger.info("VIEW CONTROLLER : GET SEAT JSON DATA START");
		
		String contextPath = request.getSession().getServletContext().getRealPath("/");
		logger.info("CONTEXT PATH= " + contextPath);
		File target = new File(contextPath + "upload" + File.separator + 
				"gigabox" + File.separator + 
				"movieroom" + File.separator + movieroomNumber + ".txt");
		logger.info("TARGET FILE= " + target.getAbsolutePath());
		
		JSONParser parser = new JSONParser();
		
		
		try {
	 
			Object obj = parser.parse(new FileReader(target));
			JSONObject jsonObject = (JSONObject) obj;
			logger.info("VIEW CONTROLLER : SEAT JSON DATA END");
		    logger.info("===========================================================");
			return new ResponseEntity<JSONObject>(jsonObject, HttpStatus.OK);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		logger.info("ERROR SENDING DATA");
		logger.info("VIEW CONTROLLER : SEAT JSON DATA END");
	    logger.info("===========================================================");
	    return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    
	}
	
}
