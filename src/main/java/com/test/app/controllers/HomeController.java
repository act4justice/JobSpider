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

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login(HttpSession session) {
		session.invalidate();
		return "login";
	}

	@RequestMapping(value = "searchZipcode", method = RequestMethod.GET)
	public @ResponseBody List<PostNumber> searchZipcode(String keyword) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<PostNumber> postList = dao.selectZipcode(keyword);
		return postList;
	}
	
	//회원가입_Personal
	@RequestMapping(value = "per_register", method = RequestMethod.POST)
	public String per_register(Personal p, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

	      dao.registerPersonal(p);
	      Map<String, String> map = new HashMap<String, String>();
	      map.put("per_interestcom", (String) session.getAttribute("per_interestcom"));
	      map.put("per_id", p.getPer_id());
	      dao.insertInterestcom(map);

	      return "login";
	}
	
	// 아이디중복확인_Personal
    @RequestMapping(value = "per_idCheck", method = RequestMethod.POST)
    public @ResponseBody String per_idCheck(String per_id) {
       MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

       if (dao.selectPersonal(per_id) != null) {
          return "fail";
       } else {
          return "success";
       }
    }
	
	//회원가입_Company
	@RequestMapping(value = "com_register", method = RequestMethod.POST)
	public String com_register(Company c, HttpSession session) {

		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		dao.registerCompany(c);

		return "login";
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
	
	// 아이디중복확인_Company
    @RequestMapping(value = "com_idCheck", method = RequestMethod.POST)
    public @ResponseBody String com_idCheck(String com_id) {
       MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
       if (dao.selectCompany(com_id) != null) {
          return "fail";
       } else {
          return "success";
       }
    }
	
	//기업_로그인 후 메인으로 가기
	@RequestMapping(value = "goTemp2")
	public String goTemp2(HttpSession session) {
		return "temp2";
	}
	
	// 뉴스피트전환버튼
	@RequestMapping(value = "changeTempView")
	public String changeTempView(HttpSession session, String per_interestcomBtn) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		session.setAttribute("interestcomBtn", per_interestcomBtn);

		return "redirect:goTemp";
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

	// 캘린더 test
	@RequestMapping(value = "calendar", method = RequestMethod.GET)
	public String calendarTest(Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<Recruiting> recruitList = dao.selectEmployInfoList();
		model.addAttribute("recruitList", recruitList);
		return "calendar";
	}

	// 이력서&자기소개서 폼으로 가기
	@RequestMapping(value = "goInsertResumeForm", method = RequestMethod.GET)
	public String resume(String per_id, Model model, HttpSession session) {

		per_id = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Personal personal = dao.selectPersonal(per_id);
		model.addAttribute("personal", personal);
		
		if (dao.seletEducation(per_id).size() != 0) {
			return "redirect:updateOfResume_form";
		}
		else if (dao.selectCareer(per_id).size() != 0) {
			return "redirect:updateOfResume_form";
		}
		else if (dao.selectCertificate(per_id).size() != 0) {
			return "redirect:updateOfResume_form";
		}
		else if (dao.selectAward(per_id).size() != 0) {
			return "redirect:updateOfResume_form";
		}
		else if (dao.selectOfIntroduce(per_id).size() != 0) {
			return "redirect:updateOfResume_form";
		}
		return "personal/resume_coverLetter";
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

	// 이력서 수정하기
	@RequestMapping(value = "updateOfResume", method = RequestMethod.POST)
	public @ResponseBody String updateOfResume(@RequestBody Map<String, Object> map, HttpSession session)
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

		// 삭제하기
		String per_id = (String) session.getAttribute("per_loginId");
		if (dao.seletEducation(per_id) != null) {
			dao.deleteEdu(per_id);
		}
		if (dao.selectCareer(per_id) != null) {
			dao.deleteCar(per_id);
		}
		if (dao.selectCertificate(per_id) != null) {
			dao.deleteCer(per_id);
		}
		if (dao.selectAward(per_id) != null) {
			dao.deleteAwa(per_id);
		}

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

		if (certificateList.size() != 0) {
			for (int i = 0; i < certificateList.size(); i++) {
				certificate.setPer_id((String) session.getAttribute("per_loginId"));
				certificate.setCer_cername((String) ((Map) certificateList.get(i)).get("cer_cername"));
				certificate.setCer_date((String) ((Map) certificateList.get(i)).get("cer_date"));
				certificate.setCer_grade((String) ((Map) certificateList.get(i)).get("cer_grade"));

				dao.insert_Certificate(certificate);
			}
		}

		if (awardList.size() != 0) {
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

	// 자기소개서 등록하기
	@RequestMapping(value = "insertOfCoverLetter", method = RequestMethod.POST)
	public @ResponseBody void insertOfCoverLetter(@RequestBody Map<String, Object> list, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String per_id = (String) session.getAttribute("per_loginId");
		Introduce introduce = new Introduce();

		Map<String, Object> data = (Map<String, Object>) list.get("data");
		ArrayList<Object> introduceList = (ArrayList<Object>) (data.get("Introduce"));

		if (introduceList.size() != 0) {
			for (int i = 0; i < introduceList.size(); i++) {
				introduce.setPer_id(per_id);
				introduce.setIntro_title((String) ((Map) introduceList.get(i)).get("intro_title"));
				introduce.setIntro_contents((String) ((Map) introduceList.get(i)).get("intro_contents"));
				dao.insert_Introduce(introduce);
			}
		}
	}

	// 자기소개서 수정하기
	@RequestMapping(value = "updateOfCoverLetter", method = RequestMethod.POST)
	public @ResponseBody void updateOfCoverLetter(@RequestBody Map<String, Object> list, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String per_id = (String) session.getAttribute("per_loginId");
		Introduce introduce = new Introduce();

		Map<String, Object> data = (Map<String, Object>) list.get("data");
		ArrayList<Object> introduceList = (ArrayList<Object>) (data.get("Introduce"));

		if (dao.selectOfIntroduce(per_id) != null) {
			dao.deleteOfIntroduce(per_id);
		}

		if (introduceList.size() != 0) {
			for (int i = 0; i < introduceList.size(); i++) {
				introduce.setPer_id(per_id);
				introduce.setIntro_title((String) ((Map) introduceList.get(i)).get("intro_title"));
				introduce.setIntro_contents((String) ((Map) introduceList.get(i)).get("intro_contents"));
				dao.insert_Introduce(introduce);
			}
		}
	}

	// 이력서 사진 update하기
	@RequestMapping(value = "updatePerImage", method = RequestMethod.POST)
	public String test(Personal p, HttpSession session, HttpServletRequest request) throws IOException {
		p.setPer_id((String) session.getAttribute("per_loginId"));

		String per_originalFile = p.getFile().getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String per_savedFile = uid.toString() + "_" + per_originalFile;

		p.setPer_originalfile(per_originalFile);
		p.setPer_savedfile(per_savedFile);

		String path = request.getServletContext().getRealPath("/upload2");
		String fpath = path + "\\" + per_savedFile;
		FileOutputStream fs = new FileOutputStream(fpath);
		fs.write(p.getFile().getBytes());
		fs.close();

		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		if (!per_originalFile.equals("")) {
			dao.insert_PerPhoto(p);
		}

		return "temp";
	}

	// 이력서&자기 소개서 수정 폼
	@RequestMapping(value = "updateOfResume_form", method = RequestMethod.GET)
	public String updateOfResume_form(Model model, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		String per_id = (String) session.getAttribute("per_loginId");

		// 기본정보(Personal)
		Personal personal = dao.selectPersonal(per_id);
		model.addAttribute("personal", personal);

		// 학력사항(Education)
		List<Education> eduList = dao.seletEducation(per_id);
		model.addAttribute("eduList", eduList);

		// 경력사항(Career)
		List<Career> carList = dao.selectCareer(per_id);
		model.addAttribute("carList", carList);

		// 자격증&면허증(Certificate)
		List<Certificate> cerList = dao.selectCertificate(per_id);
		model.addAttribute("cerList", cerList);

		// 수상경력(Award)
		List<Award> awaList = dao.selectAward(per_id);
		model.addAttribute("awaList", awaList);

		// 자기 소개서(Introduce)
		List<Introduce> introduceList = dao.selectOfIntroduce(per_id);
		model.addAttribute("introduceList", introduceList);

		return "personal/updateOfResume_form";
	}

	// 아이디 비번찾기 폼으로 가기
	@RequestMapping(value = "findView")
	public String findView() {

		return "findView";
	}

	// Personal 아이디&비번찾기
	@RequestMapping(value = "per_finder", method = RequestMethod.POST)
	public @ResponseBody Personal per_finder(@RequestBody Personal p) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		if (p.getPer_id().length() == 0) {
			p.setPer_id(dao.findPersonId(p));
		} else {
			p.setPer_pwd(dao.findPersonPwd(p));
			p.setPer_email(null);
		}

		return p;
	}

	// Company 아이디&비번찾기
	@RequestMapping(value = "com_finder", method = RequestMethod.POST)
	public @ResponseBody Company com_finder(@RequestBody Company c) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		if (c.getCom_id().length() == 0) {
			c.setCom_id(dao.findCompanyId(c));
		} else {
			c.setCom_pwd(dao.findCompanyPwd(c));
			c.setCom_num(0);
		}
		return c;
	}

	// 개인 정보 수정 form
	@RequestMapping(value = "updatePerInfo_form", method = RequestMethod.GET)
	public String updatePerInfo_form(Model model, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String per_id = (String) session.getAttribute("per_loginId");
		Personal personal = dao.selectPersonal(per_id);
		model.addAttribute("personal", personal);

		return "personal/updatePerInfo_form";
	}

	// 개인 정보 수정
	@RequestMapping(value = "updatePerInfo", method = RequestMethod.POST)
	public String updatePerInfo(Personal personal_update, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String per_id = (String) session.getAttribute("per_loginId");

		Personal personal_before = dao.selectPersonal(per_id);
		// 수정 이전 사진 파일 setting
		String per_originalfile = personal_before.getPer_originalfile();
		String per_savedfile = personal_before.getPer_savedfile();
		personal_update.setPer_originalfile(per_originalfile);
		personal_update.setPer_savedfile(per_savedfile);
		dao.updatePerInfo(personal_update);

		return "redirect:updatePerInfo_form";
	}

	// 회원탈퇴
	@RequestMapping(value = "secede", method = RequestMethod.GET)
	public String secede(String pwd, HttpSession session) {

		String loginId = (String) session.getAttribute("per_loginId");

		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (loginId != null) {
			Personal p = dao.per_login(loginId);

			if (p.getPer_pwd().equals(pwd)) {
				dao.per_secede(loginId);
				session.invalidate();
				return "main";
			}
		} else {
			loginId = (String) session.getAttribute("com_loginId");

			Company c = dao.com_login(loginId);

			if (c.getCom_pwd().equals(pwd)) {
				dao.com_secede(loginId);
				return "main";
			}
		}
		return "null";
	}

	// 채용정보 리스트 보기
   @RequestMapping(value = "employInfoList_per", method = RequestMethod.GET)
   public String employmentInfoList(Model model, HttpSession session) {
      String login_id = (String) session.getAttribute("per_loginId");
      MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
      List<Integer> likeList = dao.getInterestRec(login_id);
      List<Recruiting> recruitList = dao.selectEmployInfoList();
      for (int rec_index : likeList) {
         for (Recruiting r : recruitList) {
            if (r.getRec_index() == rec_index) {
               r.setLike(true);
            }
         }
      }
      model.addAttribute("recruitList", recruitList);

      // apply 여부 확인
      List<Apply> applyList = dao.getApplyListByPer(login_id);
      model.addAttribute("applyList", applyList);

      return "personal/employmentInfo_list_per";
   }

	// 채용정보 관심 등록
	@RequestMapping(value = "registInterestRec", method = RequestMethod.POST)
	public @ResponseBody void registInterestRec(int rec_index, HttpSession session) {
		String loginId = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("per_id", loginId);
		map.put("rec_index", rec_index);

		dao.insertInterestRec(map);
	}

	// 개인 관심채용정보 즐겨찾기 취소
	@RequestMapping(value = "deleteInterestRec", method = RequestMethod.POST)
	public @ResponseBody void deleteInterestRec(int rec_index, HttpSession session) {
		String loginId = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("per_id", loginId);
		map.put("rec_index", rec_index);

		dao.deleteInterestRec(map);
	}

	// 개인 채용정보 즐겨찾기 보기
	@RequestMapping(value = "myInterestRec", method = RequestMethod.GET)
	public String myInterestRec(Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("per_loginId");
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<Integer> inter_rec = dao.getInterestRec(loginId);
		List<Recruiting> recruitList = new ArrayList<Recruiting>();
		for (int rec : inter_rec) {
			Recruiting recruiting = dao.getRecruiting(rec);
			if (recruiting != null)
				recruiting.setLike(true);
			recruitList.add(recruiting);
		}

		model.addAttribute("recruitList", recruitList);

		// apply 여부 확인
		List<Apply> applyList = dao.getApplyListByPer(loginId);
		model.addAttribute("applyList", applyList);

		return "personal/interestCom_list";
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
	
	// 스크랩삭제
	@RequestMapping(value = "deleteScrap", method = RequestMethod.POST)
	public @ResponseBody void deleteScrap(int scr_seq) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		dao.deleteScrap(scr_seq);
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
	
	//댓글등록
   @RequestMapping(value = "insertReply", method = RequestMethod.GET)
   public @ResponseBody Reply insertReply(@RequestParam Map<String, Object> map, HttpSession session) {
      MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
      String per_loginId = (String) session.getAttribute("per_loginId");
         
      Personal personal = dao.selectPersonal(per_loginId);
      Reply reply = new Reply();
      
      if(personal.getPer_savedfile()!=null){
    	  map.put("per_savedfile", personal.getPer_savedfile());
      }
      map.put("per_id", per_loginId);
      map.put("per_name", personal.getPer_name());
      
      dao.insertReply(map);
      
      reply.setPer_savedfile(personal.getPer_savedfile());
      reply.setPer_name(personal.getPer_name());
      reply.setReply_content((String)map.get("reply_content"));
      
      List<Reply> replyList = dao.getReplyList(map);
      
      reply.setReply_date(replyList.get(replyList.size()-1).getReply_date());
      reply.setReply_index(replyList.get(replyList.size()-1).getReply_index());
      
      return reply;
   }
   
   //댓글삭제
   @RequestMapping(value = "deleteReply", method = RequestMethod.POST)
   public @ResponseBody void deleteReply(int reply_index) {
      MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
      
      dao.deleteReply(reply_index);      
   }

	// 메모지로 가기&메모 리스트 가져오기
	@RequestMapping(value = "pinboard")
	public String goPinboard(HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (session.getAttribute("per_loginId") != null) {
			List<Pinboard> pinboardList = dao.getPinboardPer((String) session.getAttribute("per_loginId"));
			model.addAttribute("pinboardList", pinboardList);
		} else if (session.getAttribute("com_loginId") != null) {
			List<Pinboard> pinboardList_com = dao.getPinboardCom((String) session.getAttribute("com_loginId"));
			model.addAttribute("pinboardList_com", pinboardList_com);
		}
		return "pinboard";
	}

	// 메모지 등록하기
	@RequestMapping(value = "insertPinboard", method = RequestMethod.POST)
	public String insertPinboard(Pinboard pinboard, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (session.getAttribute("per_loginId") != null) {
			pinboard.setPer_id((String) session.getAttribute("per_loginId"));
			dao.insertPinboard(pinboard);
		} else if (session.getAttribute("com_loginId") != null) {
			pinboard.setPer_id((String) session.getAttribute("com_loginId"));
			dao.insertPinboard_com(pinboard);
		}
		return "redirect:pinboard";
	}

	// 메모지 삭제하기
	@RequestMapping(value = "deletePinboard")
	public String deletePinboard(int pin_index, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);

		if (session.getAttribute("per_loginId") != null) {
			dao.deletePinboard(pin_index);
		} else if (session.getAttribute("com_loginId") != null) {
			dao.deletePinboard_com(pin_index);
		}
		return "redirect:pinboard";
	}

	// 지원하기
    @RequestMapping(value = "apply")
    public @ResponseBody void apply(int rec_index, HttpSession session) throws MessagingException {
       MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
       Recruiting rec = dao.selectEmployInfoDetail(rec_index);

       // 지원 등록
       Apply apply = new Apply();
       apply.setPer_id((String) session.getAttribute("per_loginId"));
       apply.setRec_index(rec_index);
       dao.registerApply(apply);

       // email 시작
       java.util.Properties props = new java.util.Properties();
       props.put("mail.smtp.auth", "true");
       props.put("mail.smtp.starttls.enable", "true");
       props.put("mail.smtp.host", "smtp.gmail.com");
       props.put("mail.smtp.port", "587");

       Session sessionEmail = Session.getInstance(props, new javax.mail.Authenticator() {
          protected PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication("khj78830109@gmail.com", "85529201");
          }
       });

       MimeMessage msg = new MimeMessage(sessionEmail);
       msg.setSubject("[NEW] 지원");
       msg.setFrom(new InternetAddress("khj78830109@gmail.com"));

       // rec.getCom_id()).getCom_email() : 지원한 회사 이메일
       msg.setRecipients(Message.RecipientType.TO, dao.selectCompany(rec.getCom_id()).getCom_email());

       Multipart mp = new MimeMultipart();
       MimeBodyPart htmlPart = new MimeBodyPart();

       String message = "<br><a href='http://203.233.196.79:8888/app/'>바로 가기</a>";

       htmlPart.setContent(message, "text/html; charset=utf-8");
       mp.addBodyPart(htmlPart);
       msg.setContent(mp);
       msg.setSentDate(new Date());
       Transport.send(msg);
       // email 끝
    }
	
	// DartCode얻어오기
	@RequestMapping(value = "selectDartCode")
	public @ResponseBody String selectDartCode(String comname) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String dartcode = dao.selectDartCode(comname);
		return dao.selectDartCode(comname);
	}
	
	//관심기업삭제
   @RequestMapping(value = "deleteInterestCom", method = RequestMethod.POST)
      public @ResponseBody void deleteInterestCom(String comName, HttpSession session) {
         MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
         
         String per_id = (String)session.getAttribute("per_loginId");
         Map<String, Object> map = new HashMap<String, Object>();
         
         map.put("per_id", per_id);
         map.put("per_interestCom", comName);
         dao.deleteInterestCom(map);
         
         session.removeAttribute("interestcomBtn");
      }
	
}
