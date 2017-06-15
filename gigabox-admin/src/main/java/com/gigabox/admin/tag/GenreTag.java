package com.gigabox.admin.tag;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class GenreTag extends TagSupport {

	private static final long serialVersionUID = 4729350399794976335L;

	private String genre;
	
	private static final String prefix = "<span class='label label-primary'>";
	private static final String suffix = "</span> ";
	
	@Override
	public int doStartTag() throws JspException {
		try {
			pageContext.getOut().println(getGenreTags());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return super.doStartTag();
	}


	public List<String> getGenreArray() {
		if (genre == null || "".equals(genre.trim())) {
			return null;
		}
		String genreTrim = genre.replaceAll(" ", "");
		ArrayList<String> genreList = new ArrayList<>();
		if (!genreTrim.contains(",")) {
			genreList.add(genreTrim);
			return genreList;
		} else {
			String[] genreStringArray = genreTrim.split(",");
			for (String genreSingleString : genreStringArray) {
				genreList.add(genreSingleString);
			}
			return genreList;
		}
	}
	
	private String getGenreTags() {
		if (genre == null || "".equals(genre.trim())) {
			return "";
		}
		String genreTrim = genre.replaceAll(" ", "");
		
		if (!genreTrim.contains(",")) {
			return prefix + genreTrim + suffix;
		} else {
			String[] genreStringArray = genreTrim.split(",");
			StringBuilder genreList = new StringBuilder();
			for (String genreSingleString : genreStringArray) {
				genreList.append(prefix + genreSingleString + suffix);
			}
			return genreList.toString();
		}
	}



	public String getGenre() {
		return genre;
	}



	public void setGenre(String genre) {
		this.genre = genre;
	}
	
}
