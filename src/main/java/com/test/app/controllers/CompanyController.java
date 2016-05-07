package com.test.app.controllers;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.app.persistence.MemberDAO;
import com.test.app.vo.Apply;
import com.test.app.vo.Award;
import com.test.app.vo.Career;
import com.test.app.vo.Certificate;
import com.test.app.vo.Company;
import com.test.app.vo.Education;
import com.test.app.vo.Introduce;
import com.test.app.vo.Personal;
import com.test.app.vo.Recruiting;
import com.test.app.vo.ResumeData;

/**
 * Handles requests for the application home page.
 */
@Controller
public class CompanyController {

	@Autowired
	SqlSession sqlSession;

	private static final Logger logger = LoggerFactory.getLogger(CompanyController.class);

	@RequestMapping(value = "searchComnum", method = RequestMethod.GET)
	public @ResponseBody String searchComnum(String keyword) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String comnum = dao.selectComnum(keyword);
		String message = null;

		if (comnum != null) {
			message = "success";
		} else {
			message = "fail";
		}
		return message;
	}

	// 채용정보 리스트 보기
	@RequestMapping(value = "EmployInfoList", method = RequestMethod.GET)
	public String employmentInfoList(Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<Recruiting> recruitList = dao.selectEmployInfoList();
		model.addAttribute("recruitList", recruitList);
		return "company/employmentInfo_list";
	}

	// 채용정보 자세히보기
	@RequestMapping(value = "EmployInfoDetail", method = RequestMethod.GET)
	public @ResponseBody Recruiting employmentInfoDetail(int rec_index) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Recruiting recruiting = dao.selectEmployInfoDetail(rec_index);
		return recruiting;
	}

	// 채용정보 등록폼으로 가기
	@RequestMapping(value = "goEmploymentReg", method = RequestMethod.GET)
	public String employmentInfo_reg(HttpSession session) {
		return "company/employmentInfo_reg";
	}

	// 채용정보 등록하기
	@RequestMapping(value = "insertEmployInfo", method = RequestMethod.POST)
	public String employmentInfo_insert(Recruiting recruit, HttpServletRequest request, HttpSession session)
			throws IOException, MessagingException {
		// 기업로고 등록하기
		if (!recruit.getFile().isEmpty()) {
			String rec_originalFile = recruit.getFile().getOriginalFilename();// multipartfile
			UUID uid = UUID.randomUUID();// 랜덤이름값을 준다.(아직 String값은 아님)
			String rec_savedFile = uid.toString() + "_" + rec_originalFile;

			recruit.setRec_originalfile(rec_originalFile);
			recruit.setRec_savedfile(rec_savedFile);

			// 실제 파일이 deploy되는 실제 물리적인 경로를 알아냄
			String path = request.getServletContext().getRealPath("/upload");
			String fpath = path + "\\" + rec_savedFile;// 파일이 저장되어있는 전체 경로가 나옴
			// 사용자로부터 저장된 파일을 서버에서 하드디스크로 파일을 내보냄
			FileOutputStream fs = new FileOutputStream(fpath);
			fs.write(recruit.getFile().getBytes());
			fs.close();
		}

		// com_id는 session에 등록된 것 받기
		recruit.setCom_id((String) session.getAttribute("com_loginId"));
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		int result = dao.insertEmployInfo(recruit);

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
	      msg.setSubject("[NEW] 공채 소식");
	      msg.setFrom(new InternetAddress("khj78830109@gmail.com"));

	      ArrayList<Personal> personalList = dao.selectPersonalList();
	      for (int i = 0; i < personalList.size(); i++) {
	         if (personalList.get(i).getPer_emailsetting().equals("agree")) {
	            msg.setRecipients(Message.RecipientType.TO, personalList.get(i).getPer_email());

	            Multipart mp = new MimeMultipart();
	            MimeBodyPart htmlPart = new MimeBodyPart();

	            Company company = dao.com_login((String) session.getAttribute("com_loginId"));

	            String message = company.getCom_name() + "의 채용 정보가 등록되었습니다.";
	            message += "<br><a href='http://203.233.196.79:8888/app/'>바로 가기</a>";

	            htmlPart.setContent(message, "text/html; charset=utf-8");
	            mp.addBodyPart(htmlPart);
	            msg.setContent(mp);
	            msg.setSentDate(new Date());
	            Transport.send(msg);
	         }
	      }
	      // email 끝

		return "redirect:employInfoList_com";
	}

	// 채용정보 list
	@RequestMapping(value = "employInfoList_com", method = RequestMethod.GET)
	public String employInfoList_com(Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		List<Recruiting> recruitList = dao.selectEmployInfoList();
		model.addAttribute("recruitList", recruitList);

		return "company/employmentInfo_list_com";
	}

	// 채용정보 update form
	@RequestMapping(value = "updateEmployInfo_form", method = RequestMethod.GET)
	public String updateEmployInfo_form(Model model, int rec_index) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		Recruiting recruit = dao.selectEmployInfoDetail(rec_index);
		model.addAttribute("recruit", recruit);

		return "company/employmentInfo_update";
	}

	// 채용정보 update
	@RequestMapping(value = "updateEmployInfo", method = RequestMethod.POST)
	public String updateEmployInfo(Recruiting recruit, HttpServletRequest request) throws Exception {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		System.out.println(recruit);
		dao.updateEmployInfo(recruit);
		
		String rec_originalFile = recruit.getFile().getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String rec_savedFile = uid.toString() + "_" + rec_originalFile;
		
		recruit.setRec_originalfile(rec_originalFile);
		recruit.setRec_savedfile(rec_savedFile);
		
		String path = request.getServletContext().getRealPath("/upload");
		String fpath = path + "\\" + rec_savedFile;
		FileOutputStream fs = new FileOutputStream(fpath);
		fs.write(recruit.getFile().getBytes());
		fs.close();

		if (!rec_originalFile.equals("")) {
			dao.updateEmployInfo(recruit);
		}		

		return "redirect:employInfoList_com";
	}

	// 기업 정보 update form
	@RequestMapping(value = "updateComInfo_form", method = RequestMethod.GET)
	public String updateComInfo_form(Model model, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String com_id = (String) session.getAttribute("com_loginId");
		Company company = dao.selectCompany(com_id);
		model.addAttribute("company", company);

		return "company/updateComInfo_form";
	}

	// 기업 정보 update
	@RequestMapping(value = "updateComInfo", method = RequestMethod.POST)
	public String updateComInfo(Company company, HttpSession session) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		dao.updateComInfo(company);

		return "redirect:goTemp2";
	}

	// 지원현황보기Form
	@RequestMapping(value = "applyStatusForm", method = RequestMethod.GET)
	public String applyStatusForm(HttpSession session, Model model) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		String com_id = (String) session.getAttribute("com_loginId");
		List<Apply> appplyList = dao.getApplyStatusList(com_id);
		model.addAttribute("applyList", appplyList);

		return "company/applyStatus_form";
	}

	// 지원현황보기Form
	@RequestMapping(value = "applyStatusResume", method = RequestMethod.GET)
	public @ResponseBody ResumeData applyStatusResume(String per_id) {
		MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
		// 기본사항
		Personal personal = dao.selectPersonal(per_id);
		// 학력사항(Education)
		List<Education> eduList = dao.seletEducation(per_id);
		// 경력사항(Career)
		List<Career> carList = dao.selectCareer(per_id);
		// 자격증&면허증(Certificate)
		List<Certificate> cerList = dao.selectCertificate(per_id);
		// 수상경력(Award)
		List<Award> awaList = dao.selectAward(per_id);
		// 자기 소개서(Introduce)
		List<Introduce> introduceList = dao.selectOfIntroduce(per_id);

		ResumeData resumeDate = new ResumeData();
		resumeDate.setPersonal(personal);
		resumeDate.setEduList(eduList);
		resumeDate.setCarList(carList);
		resumeDate.setCerList(cerList);
		resumeDate.setAwaList(awaList);
		resumeDate.setIntroduceList(introduceList);

		return resumeDate;
	}
	
	// 지원자들에게 email
   @RequestMapping(value = "sendEmailToApplicants", method = RequestMethod.POST)
   public @ResponseBody void sendEmailToApplicants(@RequestBody Map<String, Object> list, HttpSession session) throws MessagingException {
      //email setting start
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
      msg.setFrom(new InternetAddress("khj78830109@gmail.com"));
      //email setting end
      
      MemberDAO dao = sqlSession.getMapper(MemberDAO.class);
      
      Map<String, Object> data = (Map<String, Object>) list.get("data");
      ArrayList<Object> resultList = (ArrayList<Object>) (data.get("list"));
      
      if (resultList.size() != 0) {
         for (int i = 0; i < resultList.size(); i++) {
            String message = null;
            
            String per_id = (String) ((Map) resultList.get(i)).get("per_id");
            int rec_index = Integer.parseInt((String) ((Map) resultList.get(i)).get("rec_index"));
            
            Personal personal = dao.per_login(per_id);
            Recruiting recruiting = dao.getRecruiting(rec_index);
            
            msg.setSubject("[서류 합격]" + personal.getPer_name() + "님 합격을 축하합니다.");
            message = personal.getPer_name() + "님";
            message += "<br/>" + recruiting.getCom_name() + " " + recruiting.getRec_duty(); 
            message += "<br/>서류 합격을 축하드립니다.";
            message += "<br/><a href='http://203.233.196.79:8888/app/'>바로 가기</a>";
            
            msg.setRecipients(Message.RecipientType.TO, personal.getPer_email());
            
            Multipart mp = new MimeMultipart();
            MimeBodyPart htmlPart = new MimeBodyPart();
   
            htmlPart.setContent(message, "text/html; charset=utf-8");
            mp.addBodyPart(htmlPart);
            msg.setContent(mp);
            msg.setSentDate(new Date());
            
            Transport.send(msg);
         }
      }
   }

}
