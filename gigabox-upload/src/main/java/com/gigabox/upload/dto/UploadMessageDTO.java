package com.gigabox.upload.dto;

public class UploadMessageDTO {

	/*
	 *  result 결과
	 *  10 : 목록 회신 성공
	 *  20 : 업로드 성공
	 *  30 : 서버 인증키 에러
	 *  40 : 사이트 인증키 에러
	 *  50 : 파일 업로드 용량 제한
	 *  60 : 파일 형식 제한 (허용되지 않는 확장자)
	 *  70 : 업로드 개수 초과
	 *  80 : 파일 경로 오류
	 *  90 : 파일 이름 오류
	 *  100 : 목적 오류
	 *  110 : 파일 missing
	 *  120 : 서버 처리 오류
	 */
	private int result;      
	private String message;  		// 메시지: 오류 내용
	private String purpose; 		// 요청 종류
	private String fileType;
	private String fileName;
	private String fileDir;
	private String thumbDir;		// 썸네일 파일 경로
	private String thumb;			// 썸네일 파일명
	
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileDir() {
		return fileDir;
	}
	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}
	public String getThumbDir() {
		return thumbDir;
	}
	public void setThumbDir(String thumbDir) {
		this.thumbDir = thumbDir;
	}
	public String getThumb() {
		return thumb;
	}
	public void setThumb(String thumb) {
		this.thumb = thumb;
	}
	
	@Override
	public String toString() {
		return "UploadMessageDTO [result=" + result + ", message=" + message + ", purpose=" + purpose + ", fileType="
				+ fileType + ", fileName=" + fileName + ", fileDir=" + fileDir + ", thumbDir=" + thumbDir + ", thumb="
				+ thumb + "]";
	}
	
}
