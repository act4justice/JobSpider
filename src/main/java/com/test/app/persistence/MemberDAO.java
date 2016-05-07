package com.test.app.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

public interface MemberDAO {
   
   //개인모음-----------------------------------------------------------------
   List<PostNumber> selectZipcode(String zipcode);
   void registerPersonal(Personal p);
   Personal per_login(String id);
   Personal selectPersonal(String per_id);
   String findPersonId(Personal p);
   String findPersonPwd(Personal p);
   void per_secede(String loginId);
   
   void insert_Education(Education education);
   void insert_Career(Career career);
   void insert_Certificate(Certificate certificate);
   void insert_Award(Award award);
   void insert_PerPhoto(Personal p);
   void insert_Introduce(Introduce introduce);
   void insertInterestRec(Map<String, Object> map);
   
   List<Education> seletEducation(String per_id);
   List<Career> selectCareer(String per_id);
   List<Certificate> selectCertificate(String per_id);
   List<Award> selectAward(String per_id);
   List<Introduce> selectOfIntroduce(String per_id);
   List<Integer> getInterestRec(String loginId);
   ArrayList<Personal> selectPersonalList();
   
   void deleteEdu(String per_id);
   void deleteCar(String per_id);
   void deleteCer(String per_id);
   void deleteAwa(String per_id);
   void deleteOfIntroduce(String per_id);
   void deleteInterestRec(Map<String, Object> map);

   void updatePerInfo(Personal personal_update);
   void deleteInterestCom(Map<String, Object> map);
   //기업모음-------------------------------------------------------------------
   Company com_login(String id);
   Company selectCompany(String com_id);
   int registerCompany(Company c);
   int insertEmployInfo(Recruiting recruit);
   String selectComnum(String keyword);
   String findCompanyId(Company c);
   String findCompanyPwd(Company c);
   void com_secede(String loginId);
   void updateComInfo(Company company);
   void updateEmployInfo(Recruiting recruit);
   Recruiting getRecruiting(int rec);
   Recruiting selectEmployInfoDetail(int rec_index);
   List<Recruiting> selectEmployInfoList();
   List<String> getcomnameList();

   
   //뉴스피드모음----------------------------------------------------------------------------
   List<String> selectInterestcom(String per_id);
   List<Newsfeed> selectNewsfeed(String per_id);
   int duplicateUrlCount(String nf_url);
   void insertNewsfeed(Newsfeed newsfeed);
   void insertInterestcom(Map<String, String> map);
   Newsfeed selectOneNewsfeed(String url);
   List<String> selectAllInterestcom();
   String selectDartCode(String comname);
   
   //스크랩모음-------------------------------------------------------------------
   void insertScrap(Map<String, Object> map);
   void deleteScrap(int scr_seq);
   void insertReply(Map<String, Object> map);
   void deleteReply(int reply_index);
   String checkScrap(Map<String, Object> map);
   List<Scrap> selectScrapList(String per_id);
   List<Reply> getReplyList(Map<String, Object> map);
   Scrap selectOneScrap(String scr_seq);
   
   //메모지----------------------------------------------------------------------
   void insertPinboard(Pinboard pinboard);
   void deletePinboard(int pin_index);
   void deletePinboard_com(int pin_index);
   void insertPinboard_com(Pinboard pinboard);
   List<Pinboard> getPinboardPer(String per_id);
   List<Pinboard> getPinboardCom(String com_id);
   

   //기업에 지원하기---------------------------------------------------------------------
   void registerApply(Apply apply);
   List<Apply> getApplyStatusList(String com_id);
   List<Apply> getApplyListByPer(String login_id);






}