package com.test.app.controllers;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.app.persistence.MemberDAO;
import com.test.app.persistence.NewsfeedGetter;
import com.test.app.vo.Apply;
import com.test.app.vo.Award;
import com.test.app.vo.Career;
import com.test.app.vo.Certificate;
import com.test.app.vo.Company;
import com.test.app.vo.Education;
import com.test.app.vo.Introduce;
import com.test.app.vo.Newsfeed;
import com.test.app.vo.Personal;
import com.test.app.vo.Pinboard;
import com.test.app.vo.PostNumber;
import com.test.app.vo.Recruiting;
import com.test.app.vo.Reply;
import com.test.app.vo.Scrap;

@Controller
public class HomeController {

	@Autowired
	SqlSession sqlSession;

	private NewsfeedGetter getter = new NewsfeedGetter();
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	   public String home(HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
	      List<String> comList = dao.getcomnameList();
	      model.addAttribute("comList", comList);
	      
	      if (session.getAttribute("per_loginId") != null || session.getAttribute("com_loginId") != null) {
	         if (session.getAttribute("per_loginId") != null) {
	            List<String> interestcomList = dao.selectInterestcom((String)session.getAttribute("per_loginId"));
	            if(interestcomList.size() != 0){
	               model.addAttribute("interestcomList", interestcomList);
	               model.addAttribute("newsfeedList", dao.selectNewsfeed(interestcomList.get(0)));
	            } else{
	            	model.addAttribute("interestcomList", interestcomList);
	            	model.addAttribute("newsfeedList", new ArrayList<Newsfeed>());
	            		
	            }
	            return "temp";
	         } else {
	            return "temp2";
	         }
	      }
	      return "main";
	   }

	@RequestMapping(value = "main", method = RequestMethod.GET)
	public String main(HttpSession session, Model model) {
		session.invalidate();
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
        List<String> comList =  dao.getcomnameList();
        model.addAttribute("comList", comList);
		return "main";
	}


	// 로그인 후 메인으로 가기
	@RequestMapping(value = "goTemp")
	public String goTemp(Model model, HttpSession session) {
		String per_id = (String) session.getAttribute("per_loginId");
	      MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

	      List<String> interestcomList = dao.selectInterestcom(per_id);
	      List<Newsfeed> newsfeedList;
	      model.addAttribute("interestcomList", interestcomList);
	      
	      System.out.println(interestcomList);
	      
	      if(interestcomList.size() != 0){
	         if(session.getAttribute("interestcomBtn") != null){
	            newsfeedList = dao.selectNewsfeed((String)session.getAttribute("interestcomBtn"));
	         } else{
	            newsfeedList = dao.selectNewsfeed(interestcomList.get(0));
	         }
	      } else {
	         newsfeedList = new ArrayList<Newsfeed>();
	      }
	      
	      model.addAttribute("newsfeedList", newsfeedList);
	      
	        List<String> comList =  dao.getcomnameList();
	        model.addAttribute("comList", comList);
	      return "temp";
	}
	
	

	/* 개인 login */
	@RequestMapping(value = "per_login", method = RequestMethod.POST)
	public @ResponseBody String per_login(String per_id, String per_pwd, HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Personal p = dao.per_login(per_id);
		if (p != null) {
			if (p.getPer_pwd().equals(per_pwd)) {
				session.setAttribute("per_loginId", p.getPer_id());
				session.setAttribute("per", p);

				// 뉴스피드 불러오기
				List<String> interestcomList = dao.selectInterestcom(per_id);
				if(interestcomList.size()!=0){
					session.setAttribute("newsfeedList", dao.selectNewsfeed(interestcomList.get(0)));
					session.setAttribute("interestcomList", interestcomList);
				}
				List<String> comList =  dao.getcomnameList();
		        model.addAttribute("comList", comList);
				
				return "success";
			} else {
				return "error";
			}
		} else {
			return "error";
		}
	}

	/* 기업 login */
	@RequestMapping(value = "com_login", method = RequestMethod.POST)
	public @ResponseBody String com_login(String com_id, String com_pwd, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Company c = dao.com_login(com_id);
		if (c != null) {
			if (c.getCom_pwd().equals(com_pwd)) {
				session.setAttribute("com_loginId", c.getCom_id());
				session.setAttribute("com", c);
				return "success";
			} else {
				return "error";
			}
		} else {
			return "error";
		}
	}

	// logout
	@RequestMapping(value = "logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "login";
	}

	// 가입하기전 뉴스피드 보여주기
	@RequestMapping(value = "before_join", method = RequestMethod.POST)
	public String before_join(String per_interestcom, HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

	      // 새로운 기업이름이면
	      if (dao.selectNewsfeed(per_interestcom).size() == 0) {
	         getter.NaverUrl(per_interestcom);
	         ArrayList<Newsfeed> newsfeedList = (ArrayList<Newsfeed>) getter.getNewsfeedList();

	         // 새로운 기업 검색후 바로 newsfeed에 저장
	         for (Newsfeed newsfeed : newsfeedList) {
	            if (dao.duplicateUrlCount(newsfeed.getNf_url()) == 0) {
	               dao.insertNewsfeed(newsfeed);
	            }
	         }
	         model.addAttribute("newsfeedList", newsfeedList);
	      }
	      // newsfeed테이블에 기업이름이 없으면
	      else {
	         model.addAttribute("newsfeedList", dao.selectNewsfeed(per_interestcom));
	      }
	      session.setAttribute("per_interestcom", per_interestcom);
	      return "before_join";
	}

	// 이력서 등록하기
	@RequestMapping(value = "saveOfResume", method = RequestMethod.POST)
	public @ResponseBody String saveOfResume(@RequestBody Map<String, Object> map, HttpSession session)
			throws IOException {
		Map<String, Object> data = (Map<String, Object>) map.get("data");

		// 리스트로 먼저 받기
		ArrayList<Object> educationList = (ArrayList<Object>) data.get("education");
		ArrayList<Object> careerList = (ArrayList<Object>) data.get("career");
		ArrayList<Object> certificateList = (ArrayList<Object>) data.get("certificate");
		ArrayList<Object> awardList = (ArrayList<Object>) data.get("award");

		// 객체 생성
		Education education = new Education();
		Career career = new Career();
		Certificate certificate = new Certificate();
		Award award = new Award();

		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (educationList.size() != 0) {
			for (int i = 0; i < educationList.size(); i++) {
				education.setPer_id((String) session.getAttribute("per_loginId"));
				education.setEdu_startdate((String) ((Map) educationList.get(i)).get("edu_startdate"));
				education.setEdu_enddate((String) ((Map) educationList.get(i)).get("edu_enddate"));
				education.setEdu_scname((String) ((Map) educationList.get(i)).get("edu_scname"));
				education.setEdu_major((String) ((Map) educationList.get(i)).get("edu_major"));
				education.setEdu_graduation((String) ((Map) educationList.get(i)).get("edu_graduation"));

				dao.insert_Education(education);
			}
		}

		if (careerList.size() != 0) {
			for (int i = 0; i < careerList.size(); i++) {
				career.setPer_id((String) session.getAttribute("per_loginId"));
				career.setCar_comname((String) ((Map) careerList.get(i)).get("car_comname"));
				career.setCar_startdate((String) ((Map) careerList.get(i)).get("car_startdate"));
				career.setCar_enddate((String) ((Map) careerList.get(i)).get("car_enddate"));
				career.setCar_department((String) ((Map) careerList.get(i)).get("car_department"));
				career.setCar_duty((String) ((Map) careerList.get(i)).get("car_duty"));

				dao.insert_Career(career);
			}
		}

		if (careerList.size() != 0) {
			for (int i = 0; i < certificateList.size(); i++) {
				certificate.setPer_id((String) session.getAttribute("per_loginId"));
				certificate.setCer_cername((String) ((Map) certificateList.get(i)).get("cer_cername"));
				certificate.setCer_date((String) ((Map) certificateList.get(i)).get("cer_date"));
				certificate.setCer_grade((String) ((Map) certificateList.get(i)).get("cer_grade"));

				dao.insert_Certificate(certificate);
			}
		}

		if (!((String) ((Map) awardList.get(0)).get("awa_name")).equals("")) {
			for (int i = 0; i < awardList.size(); i++) {
				award.setPer_id((String) session.getAttribute("per_loginId"));
				award.setAwa_name((String) ((Map) awardList.get(i)).get("awa_name"));
				award.setAwa_date((String) ((Map) awardList.get(i)).get("awa_date"));
				award.setAwa_detail((String) ((Map) awardList.get(i)).get("awa_detail"));

				dao.insert_Award(award);
			}
		}

		return "success";
	}



	// 기사스크랩
	@RequestMapping(value = "insertScrap", method = RequestMethod.POST)
	public @ResponseBody String insertScrap(@RequestParam Map<String, Object> map, HttpSession session) {
		String loginId = (String) session.getAttribute("per_loginId");

		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String url = (String) map.get("url");
		Newsfeed nf = dao.selectOneNewsfeed(url);
		map.put("per_id", loginId);
		map.put("nf_title", nf.getNf_title());
		String title = dao.checkScrap(map);
		if (title == null) {
			map.put("per_id", loginId);
			map.put("nf_title", nf.getNf_title());
			map.put("nf_subtitle", nf.getNf_subtitle());
			map.put("nf_content", nf.getNf_content());
			map.put("nf_date", nf.getNf_date());

			dao.insertScrap(map);
		}
		return "success";
	}

	// 스크랩모아보기
	@RequestMapping(value = "scrapList", method = RequestMethod.GET)
	public String scrapList(HttpSession session) {

		String per_id = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<Scrap> scrapList = dao.selectScrapList(per_id);
		session.setAttribute("scrapList", scrapList);
		return "personal/scrap_view";
	}

	// 스크랩자세히보기
	@RequestMapping(value = "scrapDetail", method = RequestMethod.GET)
	public String scrapDetail(String scr_seq, HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Scrap scrap = dao.selectOneScrap(scr_seq);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("scr_seq", scrap.getScr_seq());
		map.put("scr_title", scrap.getScr_title());
		List<Reply> replyList = dao.getReplyList(map);
		System.out.println(scrap);
		System.out.println(replyList);
		
		model.addAttribute(scrap);
		model.addAttribute(replyList);
		return "personal/scrap_detail";
	}

	// 뉴스피드-관심기업 추가
	@RequestMapping(value = "addInterestcom", method = RequestMethod.POST)
	public String addInterestcom(String newInterestcom, HttpSession session) {
		String per_id = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (dao.selectInterestcom(per_id).contains(newInterestcom)) {
			return "error";
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("per_id", per_id);
			map.put("per_interestcom", newInterestcom);
			// 아이디-관심기업 테이블에 저장
			dao.insertInterestcom(map);

			// 새로운 기업이라면 긁어와야함
			if (dao.selectNewsfeed(newInterestcom).size() == 0) {
				getter.NaverUrl(newInterestcom);
				List<Newsfeed> newsfeedList = getter.getNewsfeedList();

				for (Newsfeed newsfeed : newsfeedList) {
					if (dao.duplicateUrlCount(newsfeed.getNf_url()) == 0) {
						dao.insertNewsfeed(newsfeed);
					}
				}
			}
			session.setAttribute("interestcomBtn", newInterestcom);
		}
		return "redirect:goTemp";
	}
	
}
