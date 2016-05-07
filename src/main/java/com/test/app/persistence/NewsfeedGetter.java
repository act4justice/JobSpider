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

					} else if (url.contains("news.kmib")) {
						// 국민일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_content = doc.select(".nws_arti").html();
						tag_title = doc.select(".nwsti span").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("naeil.com")) {
						// 내일신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".articleArea h3").html();
						tag_content = doc.select("#contents").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("news.donga")) {
						// 동아일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".article_txt");
						elements.select(".sub_cont_AD08").remove();
						elements.select(".sub_cont_AD09").remove();
						elements.select(".article_relation").remove();
						elements.select(".recommend").remove();

						tag_title = doc.select(".article_title02 > h1").html();
						tag_content = elements.select(".article_txt").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("m-i.kr")) {
						// 매일일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table[align=center]").remove();

						tag_title = doc.select(".headline-title").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".info > span").html();
					} else if (url.contains("economytalk")) {
						// 경제풍월
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".tit_article");
						elements.select("a").remove();
						tag_title = elements.select(".tit_article").html();
						elements = doc.select(".txt_article");
						elements.select("div[style=float:right;padding-left:10px;]").remove();

						tag_content = elements.html();
						tag_date = doc.select(".txt_editing").html();

					} else if (url.contains("economy.mk.co.kr")) {
						// 매경이코노미
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".top_title").html();
						tag_content = doc.select("#article_body").html();
						tag_date = doc.select(".lasttime").html();
					} else if (url.contains("moneyweek")) {
						// 머니위크
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#article h1").html();
						tag_content = doc.select("#textBody").html();
						tag_date = doc.select(".info3 .num").html();
					} else if (url.contains("sisaon")) {
						// 시사오늘
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;]");
						elements.select("img").remove();

						tag_title = doc.select(".view_t").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = elements.select("span[style=font-size:8pt; letter-spacing:-0.3;]").html();
					} else if (url.contains("sisapress")) {
						// 시사저널
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table").remove();

						tag_title = doc.select(".headline-title").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".newsinfo").html();
					} else if (url.contains("shindonga.donga")) {
						// 신동아(월간)
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".title").html();
						tag_content = doc.select("#article_text").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("engdaily.com")) {
						// 엔지니어링데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("jmagazine.joins.com/monthly")) {
						// 월간중앙
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".tia01");
						elements.select("a").remove();

						tag_title = doc.select(".tit_area > h3").html();
						tag_subtitle = doc.select(".tit_area > h4").html();
						tag_content = doc.select("#M_htmlBody").html();
						tag_date = doc.select(".tia01").html();
					} else if (url.contains("weeklytoday")) {
						// 위클리오늘
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("div[style=float:right; padding-top:20px; padding-left:20px;]").remove();

						tag_title = doc.select(".View_Title").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("jmagazine.joins.com/economist")) {
						// 이코노미스트(월간중앙)
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#M_htmlBody");
						elements.select(".img_border02").remove();
						elements = doc.select(".tia01");
						elements.select("a").remove();

						tag_title = doc.select(".tit_area > h3").html();
						tag_subtitle = doc.select(".tit_area > h4").html();
						tag_content = doc.select("#M_htmlBody").html();
						tag_date = doc.select(".tia01").html();
					} else if (url.contains("econovill.com")) {
						// 이코노믹리뷰
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("div[itemprop=articleBody]");
						elements.select("div[style=float:right; width:300px;height:250px; margin-left:10px;]").remove();
						elements.select("div[style=float:left; width:300px;height:250px; margin-left:10px;]").remove();

						tag_title = doc.select(".View_Title > strong").html();
						tag_subtitle = doc.select(".View_Title > span").html();
						tag_content = doc.select("div[itemprop=articleBody]").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("interview365.mk")) {
						// 인터뷰365
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#IDTitle").html();
						tag_content = doc.select("#IDContents").html();
						tag_date = doc.select("span[style=color:#666666;font-size:8pt;font-family:돋움] > span").html();
					} else if (url.contains("weekly.khan")) {
						// 주간경향
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".title").html();
						tag_content = doc.select("#NewsAdContent").html();
						tag_date = doc.select(".article_date").html();
					} else if (url.contains("weekly.donga")) {
						// 주간동아
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".title > h2").html();
						tag_subtitle = doc.select(".title > .text").html();
						tag_content = doc.select(".view").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("weekly.chosun")) {
						// 주간조선
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select(".article_img_c").remove();
						elements.select("table").remove();

						tag_title = doc.select(".title_title > h2").html();
						tag_subtitle = doc.select(".title_title > h3").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".edition").html();
					} else if (url.contains("weekly.hankooki")) {
						// 주간한국
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".tit").html();
						tag_content = doc.select(".cont").html();
						tag_date = doc.select("dd").html();
					} else if (url.contains("jobnjoy.com")) {
						// 캠퍼스잡앤조이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_title_wrap > h4").html();
						tag_content = doc.select("#cont_area").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("jmagazine.joins.com/forbes")) {
						// 포브스코리아
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#M_htmlBody");
						elements.select(".img_border02").remove();
						elements = doc.select(".tia01");
						elements.select("a").remove();

						tag_title = doc.select(".tit_area > h3").html();
						tag_subtitle = doc.select(".tit_area > h4").html();
						tag_content = doc.select("#M_htmlBody").html();
						tag_date = doc.select(".tia01").html();
					} else if (url.contains("h21.hani")) {
						// 한겨레21
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".article_body");
						elements.select(".image0").remove();
						tag_title = doc.select(".article_head > h1").html();
						tag_subtitle = doc.select(".article_head > h3").html();
						tag_content = doc.select(".article_body").html();
						tag_date = doc.select(".datebox").html();
					} else if (url.contains("magazine.hankyung.com/business")) {
						// 한경매거진
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".newbody");
						elements.select("#action_view_container").remove();
						elements.select(".journalist").remove();

						tag_title = doc.select("#newsview > h3").html();
						tag_subtitle = doc.select("#newsview > h4").html();
						tag_content = doc.select(".newbody").html();
						tag_date = doc.select(".issue").html();
					} else if (url.contains("yonhapnews.co.kr/economy")) {
						// 연합뉴스=============================
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".article");
						elements.select(".banner-0-wrap").remove();
						tag_title = doc.select(".tit-article").html();
						tag_content = doc.select(".article").html();
						tag_date = doc.select(".tt").html();
					} else if (url.contains("anewsa")) {
						// 아시아뉴스통신
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#subSec01 > div");
						elements.select(".viewAddRDiv").remove();
						elements.select(".viewAddL").remove();
						elements.select("a").remove();
						elements.select("iframe").remove();

						tag_title = doc.select("#subSec01 > h5").html();
						tag_content = doc.select("#subSec01 > div").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("newsis")) {
						// 뉴시스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".viewnewstitle").html();
						if (doc.select(".text-000063-14B").size() != 0) {
							tag_title = doc.select(".text-000063-14B").html();
						}
						if (doc.select("#imgReTouchLoc_1").size() == 0) {
							tag_content = doc.select("#articleBody").html();
						} else {
							tag_content = doc.select(".center_img").append(doc.select("#articleBody").html()).html();
						}
						tag_date = doc.select(".text-666666-11").html();
						if (doc.select(".text-666666-12").size() != 0) {
							tag_date = doc.select(".text-666666-12").html();
						}
					} else if (url.contains("news1.kr/articles")) {
						// 뉴스1
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".title > h2").html();
						tag_subtitle = doc.select(".title > h3").html();
						tag_content = doc.select("#articles_detail").html();
						tag_date = doc.select(".info").html();
					} else if (url.contains("gukjenews")) {
						// 국제뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("heraldcorp.com")) {
						// 헤럴드경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleText");
						elements.select(
								"span[style=width:640px; height:70px; text-align:center; margin:0 10px; padding:10px 10px 15px 10px; clear:both;]")
								.remove();

						tag_title = doc.select(".article_text").html();
						tag_content = doc.select("#articleText").html();
						tag_date = doc.select(".new_time").html();
					} else if (url.contains("technoa")) {
						// 테크노아
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title > strong").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("biz.chosun")) {
						// 조선비즈
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#article_2011");
						tag_date = doc.select("#date_text").html();
						elements.select(".date_ctrl_2011").remove();

						tag_title = doc.select("#title_text").html();
						tag_content = doc.select("#article_2011").html();

					} else if (url.contains("www.edaily.co.kr/")) {
						// 이데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						if (doc.select("#imgReTouchLoc_1").size() == 0) {
							tag_content = doc.select("span[itemprop=articleBody]").html();
						} else {
							tag_content = doc.select("#imgReTouchLoc_1")
									.append(doc.select("span[itemprop=articleBody]").html()).html();
						}
						tag_title = doc.select(".newstitle").html();
						tag_subtitle = doc.select(".subtitle").html();

						tag_date = doc.select(".newsdate").html();
					} else if (url.contains("ecomedia")) {
						// 환경미디어
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#viewConts");
						elements.select("#imgcap_21234").remove();

						tag_title = doc.select(".viewTitle h3").html();
						tag_subtitle = doc.select(".subtitle").html();
						tag_content = doc.select("#viewConts").html();
						tag_date = doc.select(".viewTitle dl > dd:eq(2)").html();
					} else if (url.contains("weekly.cnbnews")) {
						// cnb저널
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".c011_arv");
						elements.select(".imgframe").remove();
						elements.select("img").remove();
						elements.select(".articlein_ad").remove();

						tag_title = doc.select(".hbox > h2").html();
						tag_content = doc.select(".smartOutput").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("m-economynews")) {
						// m이노코미
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();

						tag_title = doc.select(".art_top > h2").html();
						tag_content = doc.select("#news_body_area").html();
						tag_date = doc.select(".art_info > li:eq(1)").html();
					} else if (url.contains("biz.newdaily")) {
						// 뉴데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".c011_arv");
						elements.select(".imgframe").remove();
						elements.select("a").remove();

						tag_title = doc.select(".hbox > h2").html();
						tag_subtitle = doc.select(".hbox > h3").html();
						tag_content = doc.select(".smartOutput").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("newstapa")) {
						// 뉴스타파
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".row");
						elements.select("a").remove();

						tag_title = doc.select(".entry-title").html();
						tag_content = doc.select("#content_commence").html();
						tag_date = doc.select("article > span").html();
					} else if (url.contains("dailian")) {
						// 데일리안
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_titlebox_r1").html();
						tag_subtitle = doc.select(".view_subtitle").html();
						tag_content = doc.select("#view_con").html();
						tag_date = doc.select("#view_titlebox2_3 > span").html();
					} else if (url.contains("mediatoday")) {
						// 미디어오늘
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("body");
						elements.select("a").remove();

						tag_title = doc.select(".arl_view_title").html();
						tag_subtitle = doc.select(".arl_view_sub_title").html();
						tag_content = doc.select("#talklink_contents").html();
						tag_date = doc.select(".arl_view_date").html();
					} else if (url.contains("siminilbo")) {
						// 시민일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".headline > h3").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select(".info > span:eq(5)").html();
					} else if (url.contains("nextdaily")) {
						// 넥스트데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".con_box");
						elements.select("#sns_btn_div").remove();

						tag_title = doc.select(".v_tit").html();
						tag_content = doc.select(".con_box").html();
						tag_date = doc.select("em").html();
					} else if (url.contains("thebell")) {
						// 더벨
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#article_main");
						elements.select(".article_banner").remove();

						tag_title = doc.select(".title").html();
						tag_subtitle = doc.select(".list h2").html();
						tag_content = doc.select("#article_main").html();
						tag_date = doc.select(".left").html();
					} else if (url.contains("dt.co.kr")) {
						// 디지털타임스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#news_names p");
						elements.select("a").unwrap();
						elements = doc.select("#NewsAdContent");
						elements.select("a").remove();

						tag_title = doc.select("#news_names h1").html();
						tag_subtitle = doc.select("#news_names h3").html();
						tag_content = doc.select("#NewsAdContent").html();
						tag_date = doc.select("#news_names p").html();
					} else if (url.contains("news.mt.co.kr")) {
						// 머니투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#article > h1").html();
						tag_subtitle = doc.select("#article > h2").html();
						tag_content = doc.select("#textBody").html();
						tag_date = doc.select(".infobox1 > span").html();
					} else if (url.contains("bloter.net")) {
						// 블로터
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".pf-content");
						elements.select(".printfriendly").remove();

						tag_title = doc.select(".entry-title").html();
						tag_content = doc.select(".pf-content").html();
						tag_date = doc.select(".thetime").html();
					} else if (url.contains("seoulfn")) {
						// 서울파이낸스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#font_title").html();
						tag_content = doc.select("#CmAdContent").html();
						tag_date = doc.select("#font_date").html();
					} else if (url.contains("itdaily.kr")) {
						// 아이티데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".view_r_data > li:eq(0)");
						elements.select("img").remove();
						elements.select("span").remove();
						elements.select("a").remove();

						tag_title = doc.select(".View_Title_USER > strong").html();
						tag_subtitle = doc.select(".View_Title_USER > span").html();
						tag_content = doc.select("#CmAdContent").html();
						tag_date = doc.select(".view_r_data > li:eq(0)").html();
					} else if (url.contains("ekn.kr")) {
						// 에너지경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".c011_arv");
						elements.select("a").remove();
						elements.select("img").remove();
						elements.select(".imgframe").remove();
						elements.select(".imgcaption2").remove();

						tag_title = doc.select(".hbox >h2").html();
						tag_content = doc.select("#news_body_area").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("e2news")) {
						// 이투뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_t").html();
						tag_subtitle = doc.select(".view_sub_t").html();
						tag_content = doc.select("div.view_r").html();
						tag_date = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;] > font").html();
					} else if (url.contains("smedaily")) {
						// 중소기업신문(위에꺼랑 똑같음)
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_t").html();
						tag_subtitle = doc.select(".view_sub_t").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;] > font").html();
					} else if (url.contains("techholic")) {
						// 테크홀릭
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".entry");
						elements.select(".tags").remove();
						elements.select(".cats").remove();
						elements = doc.select(".post-title:eq(0)");
						elements.select("a").unwrap();

						tag_title = doc.select(".post-title:eq(0)").html();
						tag_content = doc.select(".entry-content > p").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("newsprime")) {
						// 프라임경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".arvdate");
						elements.select("a").unwrap();

						tag_title = doc.select(".hbox > h2").html();
						tag_subtitle = doc.select(".hbox > h3").html();
						tag_content = doc.select("#news_body_area").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("newstomato")) {
						// 뉴스토마토
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".rn_stitle").html();
						tag_subtitle = doc.select(".rn_sstitle").html();
						tag_content = doc.select(".rns_text").html();
						tag_date = doc.select(".rn_sdate").html();
					} else if (url.contains("datanet")) {
						// 데이터넷
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("div").remove();
						elements.select("img").remove();
						elements = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;]");
						elements.select("a").remove();

						tag_title = doc.select(".view_t").html();
						tag_subtitle = doc.select(".view_sub_t").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;]").html();
					} else if (url.contains("betanews")) {
						// 베타뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("img").remove();

						tag_title = doc.select("#titles").html();
						tag_content = doc.select("#articleBody > p").html();
						tag_date = doc.select("#content_information").html();
					} else if (url.contains("bizwatch")) {
						// 비즈니스워치
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".news-view-info");
						elements.select("p:has(img)").remove();

						tag_title = doc.select(".modal-scrollbx h1").html();
						tag_subtitle = doc.select(".news-view > h2").html();
						tag_content = doc.select(".news-view-info").html();
						tag_date = doc.select(".news-info").html();
					} else if (url.contains("ittoday")) {
						// 아이티투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("kr.aving.net")) {
						// 에이빙뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("h1").html();
						tag_content = doc.select("#news_view > .content").html();
						tag_date = doc.select(".writer td.f9_6gray").html();
					} else if (url.contains("etoday")) {
						// 이투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("h1").html();
						tag_subtitle = doc.select(".SubTit").html();
						tag_content = doc.select("#newsContent").html();
						tag_date = doc.select(".view_data > span > p").html();
					} else if (url.contains("choicenews")) {
						// 초이스경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("todayenergy")) {
						// 에너지투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;]");
						elements.select("a").remove();

						tag_title = doc.select(".view_t").html();
						tag_subtitle = doc.select(".view_sub_t").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;]").html();
					} else if (url.contains("www.hankyung.com/news")) {
						// 한국경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".hk-news-view");
						elements.select(".atc-widg-group").remove();
						elements.select("a[target=view_frame]").remove();

						tag_title = doc.select(".atc-tit").html();
						tag_content = doc.select(".hk-news-view").html();
						tag_date = doc.select(".atc-info").html();
					} else if (url.contains("cctvnews")) {
						// cctv뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#CmAdContent");
						elements.select("table").remove();
						elements.select("div:gt(0)").remove();

						tag_title = doc.select(".headline h3").html();
						tag_subtitle = doc.select(".headline strong").html();
						tag_content = doc.select("#CmAdContent ").html();
						tag_date = doc.select(".info").html();
					} else if (url.contains("sisaweek")) {
						// 시사위크
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("sisafocus")) {
						// 시사포커스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#CmAdContent").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("pressian")) {
						// 프레시안
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#CmAdContent");
						elements.select(".imgframe").remove();

						tag_title = doc.select(".hboxtitle").html();
						tag_subtitle = doc.select(".hboxsubtitle").html();
						tag_content = doc.select("#CmAdContent").html();
						tag_date = doc.select(".byother_w span").html();
					} else if (url.contains("finomy")) {
						// 현대경제신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("segye")) {
						// 세계일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".titleh1 > h1").html();
						tag_content = doc.select("#article_txt").html();
						tag_date = doc.select(".article_date").html();
					} else if (url.contains("asiatoday")) {
						// 아시아투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".article_head > dt").html();
						tag_content = doc.select(".article_body > .news_bm").html();
						tag_date = doc.select(".wr_day").html();
					} else if (url.contains("news.chosun.com/site/data")) {
						// 조선일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#news_title_text_id").html();
						tag_subtitle = doc.select(".news_subtitle").html();
						tag_content = doc.select(".ext_embed, .par").html();
						tag_date = doc.select(".news_date").html();
					} else if (url.contains("news.joins")) {
						// 중앙일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".article_body");
						elements.select(".ab_photo").remove();

						tag_title = doc.select("#article_title").html();
						tag_content = doc.select(".article_body").html();
						tag_date = doc.select(".byline").html();
					} else if (url.contains("hani")) {
						// 한겨레
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("span.title:eq(0)").html();
						tag_content = doc.select(".article-text").html();
						tag_date = doc.select(".date-time").html();
					} else if (url.contains("hankookilbo")) {
						// 한국일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#article-body");
						elements.select(".article-ad-align-left").remove();

						tag_title = doc.select(".titGroup > h4").html();
						tag_content = doc.select("#article-body").html();
						tag_date = doc.select(".writeOption:gt(1)").html();
					} else if (url.contains("constimes")) {
						// 건설타임즈
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table iframe").remove();

						tag_title = doc.select(".view_t").html();
						tag_subtitle = doc.select(".view_sub_t").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select("span[style=font-size:8pt; letter-spacing:-0.3;] > font").html();
					} else if (url.contains("ikld")) {
						// 국토일보
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("datanews")) {
						// 데이터뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".arvdate");
						elements.select("a").unwrap();

						tag_title = doc.select(".hbox > h2").html();
						tag_subtitle = doc.select(".hbox > h3").html();
						tag_content = doc.select("#news_body_area").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("dailysecu")) {
						// 데일리시큐
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".news_text");
						elements.select("div").remove();

						tag_title = doc.select(".new_title").html();
						tag_subtitle = doc.select(".news_mtitle").html();
						tag_content = doc.select(".news_text").html();
						tag_date = doc.select(".new_write").html();
					} else if (url.contains("dongascience")) {
						// 동아사이언스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".news_contents");
						elements.select(".bottom").remove();
						elements.select(".letter_apply").remove();

						tag_title = doc.select(".cont > .tle h3").html();
						tag_subtitle = doc.select(".cont > .tle h4").html();
						tag_content = doc.select(".news_contents").html();
						tag_date = doc.select(".view-info > .date").html();
					} else if (url.contains("klnews")) {
						// 물류신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#font_title").html();
						tag_subtitle = doc.select(".subartView-sub-title").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select("#font_date").html();
					} else if (url.contains("futurekorea")) {
						// 미래한국
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table").remove();

						tag_title = doc.select(".headline > h3").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".info").html();
					} else if (url.contains("intn")) {
						// 일간NTN
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title strong").html();
						tag_subtitle = doc.select(".View_Title span").html();
						tag_content = doc.select("#CmAdContent").html();
						tag_date = doc.select(".View_Time > .View_Time").html();
					} else if (url.contains("news.kbiz")) {
						// 중소기업뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("cstimes")) {
						// 컨슈머타임스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#_article");
						elements.select(
								"div[style=float:left; width:250px; margin-right:10px; margin-bottom:5px; clear:left;]")
								.remove();
						elements.select("a").remove();

						tag_title = doc.select("#font_title").html();
						tag_subtitle = doc.select("#font_subtitle").html();
						tag_content = doc.select("#_article").html();
						tag_date = doc.select("#font_date").html();
					} else if (url.contains("ksg")) {
						// 코리아쉬핑가제트
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".editor_txt");
						elements.select("img").remove();

						tag_title = doc.select(".maintit").html();
						tag_subtitle = doc.select("#newsSubTitle1").html();
						tag_content = doc.select(".editor_txt").html();
						tag_date = doc.select(".subtit").html();
					} else if (url.contains("koreatimes")) {
						// 코리아타임스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_page_news_header_wrapper > h1").html();
						tag_content = doc.select(".view_page_news_article_wrapper").html();
						tag_date = doc.select(".view_page_news_header_wrapper > span").html();
					} else if (url.contains("khnews.kheraldm")) {
						// 코리아헤럴드
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".title_sec").html();
						tag_content = doc.select(".content_view").html();
						tag_date = doc.select(".date").html();
					} else if (url.contains("news.unn.net")) {
						// 한국대학신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title > strong").html();
						tag_subtitle = doc.select(".View_Title > span").html();
						tag_content = doc.select("#_article").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("itnews")) {
						// IT NEWS
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".td-post-title > .entry-title").html();
						tag_content = doc.select(".td-post-content").html();
						tag_date = doc.select(".entry-date").html();
					} else if (url.contains("it.donga")) {
						// IT동아
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("header.contents > h1").html();
						tag_content = doc.select("article > p").html();
						tag_date = doc.select("header.contents time").html();
					} else if (url.contains("koreaittimes")) {
						// korea IT Times
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select("#content-header").html();
						tag_content = doc.select(".node-inner > .clear-block > p").html();
						tag_date = doc.select(".date-display-single").html();
					} else if (url.contains("pdjournal")) {
						// PD저널
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table").remove();

						tag_title = doc.select(".headline > h3").html();
						tag_subtitle = doc.select(".headline > strong").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".info").html();
					} else if (url.contains("platum.kr")) {
						// 플래텀
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".entry");
						elements.select(".share-post").remove();
						elements.select("a").remove();
						elements.select(".wp_rp_wrap").remove();

						elements = doc.select(".post-meta");
						elements.select("a").unwrap();

						tag_title = doc.select(".post-title").html();
						tag_content = doc.select(".entry").html();
						tag_date = doc.select(".post-meta").html();
					} else if (url.contains("gvalley.etnews")) {
						// G밸리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table").remove();

						tag_title = doc.select(".headline > h3").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".info").html();
					} else if (url.contains("greendaily")) {
						// 그린데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".view_t").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select("span[style=font-size:9pt; letter-spacing:-0.3;]:eq(0) > font").html();
					} else if (url.contains("newspim")) {
						// 뉴스핌
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".bodynews_title > h1").html();
						tag_subtitle = doc.select(".bodynews_title > h2").html();
						tag_content = doc.select("#news_contents").html();
						tag_date = doc.select(".bodynews_time").html();
					} else if (url.contains("boannews")) {
						// 보안뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#news_util01");
						elements.select("img").remove();

						tag_title = doc.select("#news_title").html();
						tag_content = doc.select("#news_content").html();
						tag_date = doc.select("#news_util01").html();
					} else if (url.contains("businesspost")) {
						// 비즈니스포스트
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".View_Title > strong").html();
						tag_subtitle = doc.select(".View_Title > span").html();
						tag_content = doc.select(".view_r").html();
						tag_date = doc.select(".View_Time").html();
					} else if (url.contains("view.asiae")) {
						// 아시아경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".txt");
						elements.select("div:gt(0)").remove();
						elements.select("a").unwrap();

						tag_title = doc.select(".area_title > h1").html();
						tag_content = doc.select(".txt").html();
						tag_date = doc.select(".area_title > p").html();
					} else if (url.contains("ajunews")) {
						// 아주경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("div[style=width:200px;height:200px;margin:0 0 10px 10px;float:right;]")
								.remove();

						tag_title = doc.select("h2.tit").html();
						tag_subtitle = doc.select(".sub-title").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select(".regi_date, .modi_date").html();
					} else if (url.contains("enewstoday")) {
						// 이뉴스투데이
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#articleBody");
						elements.select("table").remove();

						tag_title = doc.select(".headline-title").html();
						tag_subtitle = doc.select(".headline-sub").html();
						tag_content = doc.select("#articleBody").html();
						tag_date = doc.select("#head-info > .info").html();
					} else if (url.contains("kbench")) {
						// 케이벤치
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".content h1").html();
						tag_content = doc.select("#contents_area").html();
						tag_date = doc.select("div[style=padding-right:15px;]").html();
					} else if (url.contains("fnnews")) {
						// 파이낸셜뉴스
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select("#article_body");
						elements.select("a").remove();

						tag_title = doc.select(".txt_tit > strong").html();
						tag_content = doc.select("#article_body").html();
						tag_date = doc.select(".news_data > .list_02").html();
					} else if (url.contains("fntimes")) {
						// 한국금융신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".fr");
						elements.select(".text_size").remove();
						elements.select(".view_ico").remove();

						tag_title = doc.select(".view_tit_txt > p").html();
						tag_content = doc.select(".word_break").html();
						tag_date = doc.select(".fr").html();
					} else if (url.contains("ciokorea")) {
						// CIO Korea
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".container .node_title").html();
						tag_content = doc.select(".container .node_body").html();
						tag_date = doc.select(".container .news_list_time").html();
					} else if (url.contains("sbscnbc.sbs")) {
						// SBS CNBC
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						tag_title = doc.select(".text34").html();
						tag_content = doc.select("#content").html();
						tag_date = doc.select(".lastDate").html();
					} else if (url.contains("g-enews")) {
						// 글로벌 이코노믹
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".contxt");
						elements.select("div:not(:has(img)").remove();
						elements.select("article").remove();

						tag_title = doc.select("header > h2").html();
						tag_content = doc.select(".contxt").html();
						tag_date = doc.select("div.date").html();
					} else if (url.contains("joongboo")) {
						// 대한금융신문
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();

						tag_title = doc.select(".arl_view_title").html();
						tag_subtitle = doc.select(".arl_view_sub_title").html();
						tag_content = doc.select(".arl_view_content").html();
						tag_date = doc.select(".arl_view_date").html();
					} else if (url.contains("ddaily")) {
						// 디지털데일리
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".smartOutput");
						elements.select("b").remove();
						elements.select("img").remove();

						tag_title = doc.select(".hbox > h2").html();
						tag_content = doc.select(".smartOutput").html();
						tag_date = doc.select(".arvdate").html();
					} else if (url.contains("viva100")) {
						// 브릿지경제
						Document doc = Jsoup.connect(url).ignoreHttpErrors(true).timeout(1000*10).get();
						Elements elements = doc.select(".left_text_box:eq(0)");
						elements.select(".gija_gisa").remove();

						tag_title = doc.select(".view_top_title").html();
						tag_content = doc.select(".left_text_box:eq(0)").html();
						tag_date = doc.select(".view_top_days").html();
					} else if (url.contains("sedaily")) {
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
