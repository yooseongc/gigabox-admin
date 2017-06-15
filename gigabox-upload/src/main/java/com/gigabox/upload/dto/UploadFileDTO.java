package com.gigabox.upload.dto;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class UploadFileDTO {
	
	@JsonIgnore
	private MultipartFile uploadFile; 
	private String fileDir;		// 파일 저장 경로
	private String fileName;	// 파일명
	private String fileType;	// 파일 확장자 : "jpg", "mp4", "xml"
	private String purpose;		// 목적 : "poster", "steelcut", "trailer", "seat"
	private int fileSize;		// 파일 크기 [byte]
	private int width;			// 이미지일 경우 넓이
	private int height;			// 이미지일 경우 높이
	
	public MultipartFile getUploadFile() {
		return uploadFile;
	}
	public void setUploadFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	
	
	@Override
	public String toString() {
		return "UploadFileDTO [uploadFile=" + uploadFile + ", fileDir=" + fileDir + ", fileName=" + fileName + ", fileType=" + fileType
				+ ", purpose=" + purpose + ", fileSize=" + fileSize + ", width=" + width + ", height=" + height
				+ "]";
	}
	public String getFileDir() {
		return fileDir;
	}
	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}

	
}
