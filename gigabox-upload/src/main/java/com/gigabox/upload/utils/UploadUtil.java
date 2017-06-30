package com.gigabox.upload.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class UploadUtil {

	public static void fileUpload(MultipartFile file, String fileDirPath, String fileName, String fileType, boolean thumb) throws IOException {

		File uploadFile = new File(fileDirPath + File.separator + fileName + "." + fileType);
		FileCopyUtils.copy(file.getBytes(), uploadFile);
		if (thumb) {
			makeThumbnail(fileDirPath, fileName, fileType);
		}
		
	}
	
	private static void makeThumbnail(String fileDirPath, String fileName, String fileType) throws IOException {
		
		File thumbDir = new File(fileDirPath + File.separator + "thumb");
		if (!thumbDir.exists()) {
			thumbDir.mkdir();
		}
		
		BufferedImage sourceImg = 
				ImageIO.read(new File(fileDirPath + File.separator + fileName + "." + fileType));
		
		BufferedImage destImg = 
				Scalr.resize(sourceImg, Scalr.Method.ULTRA_QUALITY, Scalr.Mode.FIT_TO_HEIGHT, 100);
		String thumbName = fileDirPath + File.separator + "thumb" + File.separator + "thumb_" + fileName + "." + fileType;
		File thumbFile = new File(thumbName);
		
		ImageIO.write(destImg, fileType, thumbFile);
	}

	/*public static void fileDelete(String fileName, HttpServletRequest request) throws IOException {
		boolean result = false;
		String docRoot = request.getSession().getServletContext().getRealPath("/uploadStorage");

		File fileDelete = new File(docRoot + "/" + fileName);
		if (fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
	}*/
}
