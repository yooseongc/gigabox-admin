package com.gigabox.admin.tag;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class MovieroomTypeTag extends TagSupport {

	
	private static final long serialVersionUID = -7862432099012578510L;

	private String movieroom2D;
	private String movieroom3D;
	private String movieroom4D;
	
	
	
	@Override
	public int doStartTag() throws JspException {
		try {
			pageContext.getOut().println(getTypeTags());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return super.doStartTag();
	}
	
	private char[] getTypeTags() {
		
		StringBuilder result = new StringBuilder();
		if ("Y".equals(movieroom2D)) {
			result.append("<span class='label label-default'>");
			result.append("2D");
			result.append("</span>&nbsp;");
		} 
		if ("Y".equals(movieroom3D)) {
			result.append("<span class='label label-info'>");
			result.append("3D");
			result.append("</span>&nbsp;");
		}
		if ("Y".equals(movieroom4D)) {
			result.append("<span class='label label-warning'>");
			result.append("4D");
			result.append("</span>&nbsp;");
		}
		
		return result.toString().toCharArray();
	}

	public String getMovieroom2D() {
		return movieroom2D;
	}

	public void setMovieroom2D(String movieroom2d) {
		movieroom2D = movieroom2d;
	}

	public String getMovieroom3D() {
		return movieroom3D;
	}

	public void setMovieroom3D(String movieroom3d) {
		movieroom3D = movieroom3d;
	}

	public String getMovieroom4D() {
		return movieroom4D;
	}

	public void setMovieroom4D(String movieroom4d) {
		movieroom4D = movieroom4d;
	}


}
