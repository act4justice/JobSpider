package com.test.app.persistence;


import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.test.app.vo.Newsfeed;




public class NewsfeedGetter {

	private String naverNewsUrl = "https://search.naver.com/search.naver?where=news&sm=tab_jum&ie=utf8&query=";
	private List<String> urlList = new ArrayList<String>();
	private List<Newsfeed> newsfeedList = new ArrayList<Newsfeed>();

	private String tag_content;
	private String tag_title;
	private String tag_subtitle;
	private String tag_date;
	private StringBuffer buffer = new StringBuffer();

	public NewsfeedGetter() {
	}

	public void NaverUrl(String keyword) {
		newsfeedList.clear();
		try {		
			String tempUrl = "";
			int pageNumber = 1;
			while (newsfeedList.size() < 10) {
				String option = "&sm=tab_pge&sort=0&photo=0&field=1&reporter_article=&pd=0&ds=&de=&docid=&nso=so:r,p:all,a:t&mynews=0&cluster_rank=28&start="
						+ pageNumber + "&refresh_start=0";
				String inputText = "%22" + keyword + "%22" + "%2B" + keyword + "+-증시" + "+-종목" + "+-주가" + "+-주식"
						+ "+-코스피" + "+-코스닥" + "+-시총" + "+-매수" + "+-매도" + "+-기관" + "+-추천주" + "+-특징주";
				Document mainDoc = Jsoup.connect(naverNewsUrl + inputText + option).ignoreHttpErrors(true).timeout(1000*10).get();
				Elements atags = mainDoc.select("a");
				
				buffer.append(atags.outerHtml());
				while (!(buffer.indexOf(" _sp") == -1)) {

					int firstIndex = buffer.indexOf(" _sp");
					buffer.replace(firstIndex, firstIndex + 1, "");
					
				}
				Elements linkElements = Jsoup.parse(buffer.toString()).select("a[class=_sp_each_title]");
				linkElements.addAll((Jsoup.parse(buffer.toString()).select("a[class=_sp_each_url_sp_each_title]")));
				
				for (Element element : linkElements) {
					urlList.add(element.attr("href"));
				}
				if(urlList.size()==0){
					return;
				}
				if(urlList.get(0).equals(tempUrl)){
					return;
				}
				
				for (String url : urlList) {
					System.out.println(url);
					if (url.contains("biz.khan")) {
						// 경향신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#sub_cntTopTxt");
						elements.select("#article_bottom_ad").remove();

						tag_content = elements.html();
						tag_title = doc.select(".tit_subject").html();
						tag_date = doc.select(".newsinfo").html();

					}else if (url.contains("sedaily")) {
						// 서울경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".view_con");
						elements.select("span").remove();
						elements = doc.select(".view_top > ul");
						elements.select("li").unwrap();

						tag_title = doc.select("#v-left-scroll-in > h2").html();
						tag_subtitle = doc.select(".subject_info").html();
						tag_content = doc.select(".view_con").html();
						tag_date = doc.select(".view_top > ul").html();
					}
					if (tag_content != null) {
						Document doc = Jsoup.parse(tag_content);
						buffer = null;
						buffer = new StringBuffer();
						buffer.append(doc.text());

						if (buffer.length() >= 200) {
							Newsfeed newsfeed = new Newsfeed();
							newsfeed.setNf_content(tag_content);
							newsfeed.setNf_title(tag_title);
							newsfeed.setNf_subtitle(tag_subtitle);
							newsfeed.setNf_date(tag_date);
							newsfeed.setNf_url(url);
							newsfeed.setPer_interestcom(keyword);
							if (newsfeedList.size() < 10) {
								newsfeedList.add(newsfeed);
							}
						}
					}

					// 초기화
					tag_title = null;
					tag_subtitle = null;
					tag_content = null;
					tag_date = null;
				}
				pageNumber = pageNumber + 10;
				tempUrl = urlList.get(0);
				urlList.clear();
				buffer = null;
				buffer = new StringBuffer();
				
			}

		} catch (Exception e) { // if an HTTP/connection error
								// occurs,handle JauntException.
			System.err.println(e);
			e.printStackTrace();
		}

	}

	public String getNaverNewsUrl() {
		return naverNewsUrl;
	}

	public void setNaverNewsUrl(String naverNewsUrl) {
		this.naverNewsUrl = naverNewsUrl;
	}

	public List<String> getUrlList() {
		return urlList;
	}

	public void setUrlList(List<String> urlList) {
		this.urlList = urlList;
	}

	public List<Newsfeed> getNewsfeedList() {
		return newsfeedList;
	}

	public void setNewsfeedList(List<Newsfeed> newsfeedList) {
		this.newsfeedList = newsfeedList;
	}

	public String getTag_content() {
		return tag_content;
	}

	public void setTag_content(String tag_content) {
		this.tag_content = tag_content;
	}

	public String getTag_title() {
		return tag_title;
	}

	public void setTag_title(String tag_title) {
		this.tag_title = tag_title;
	}

	public String getTag_subtitle() {
		return tag_subtitle;
	}

	public void setTag_subtitle(String tag_subtitle) {
		this.tag_subtitle = tag_subtitle;
	}

	public String getTag_date() {
		return tag_date;
	}

	public void setTag_date(String tag_date) {
		this.tag_date = tag_date;
	}

	public StringBuffer getBuffer() {
		return buffer;
	}

	public void setBuffer(StringBuffer buffer) {
		this.buffer = buffer;
	}

}
