package kr.co.hivesys.company.web;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.company.vo.MspVo;
import kr.co.hivesys.user.vo.UserVO;




@Controller
public class CompanyController {

	public static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	public String url="";
	
	//권한조회 후 최초 주소
	@RequestMapping(value= "/admin/client/company.do")
	public String firstAuth(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		return "redirect:/admin/client/company/companyList.do";
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/admin/client/**/*.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//서비스 현황 수치 계산
	@RequestMapping(value= "/admin/client/company/serviceCnt.ajax")
	public ModelAndView serviceCnt(HttpSession httpSession
			, HttpServletRequest request,Model model
			,@ModelAttribute("companyVO") CompanyVo thvo
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		mav.addObject("serviceCnt",companyService.serviceCnt(thvo));
		return mav;
	}
	
	//회사번호 생성
	@RequestMapping(value= "/admin/client/company/creComId.ajax")
	public ModelAndView creComId(HttpSession httpSession
			, HttpServletRequest request,Model model
			
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		mav.addObject("creComId",companyService.creComId());
		
		return mav;
	}
	
	//사용자 목록 조회
	@RequestMapping(value="/admin/client/company/companyList.ajax")
	public @ResponseBody ModelAndView userList( 
			@ModelAttribute("companyVO") CompanyVo thvo
			,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		CompanyVo newVo = new CompanyVo();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<CompanyVo> sList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			sList = companyService.selectCompanyList(thvo);
			mav.addObject("data", sList);
			mav.addObject("serviceCnt",companyService.serviceCnt(thvo));
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 등록 화면
	@RequestMapping(value="/admin/client/company/companyInsert.do")
	public @ResponseBody ModelAndView userInsert ( @ModelAttribute("companyVO") CompanyVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView(url);
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			thvo.setCOMPANY_ID(companyService.creComId());
			mav.addObject("data",thvo);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//고객사 저장
	@RequestMapping(value= "/admin/client/company/insertComapny.ajax")
	public ModelAndView insertComapny(HttpSession httpSession, 
			HttpServletRequest request,Model model
			,@ModelAttribute CompanyVo cmsVo
			,@RequestPart(value = "fCONTRACT", required = false) List<MultipartFile> fCONTRACT
			,@RequestPart(value = "fEVIDENCE", required = false) List<MultipartFile> fEVIDENCE
			//,@RequestParam(required=false, value="mspList[]") List<MspVo> mspList
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//msp
			try {
				
				if(cmsVo.getMspList()!=null) {
					companyService.subListInsert(cmsVo.getMspList());	
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","동일 클라우드일 경우에는 다른 요금제를 선택해주세요");
				return mav;
			}
			
			try {/*계약서 업로드 관련*/
				if(fCONTRACT.size()!=0) {
					//화면에 따른 변경부분
					//경로,원본id
					String inputPath = "resources/contract/" +cmsVo.getCOMPANY_ID()+ "/";
					String oriId = cmsVo.getCOMPANY_ID();
					/*공통 적용 부분*/
					FileVo fvo = new FileVo();
					fvo.setFILE_DIR(inputPath);
					fvo.setFILE_ORIGIN(oriId);
					fus.fileUploadMultiple(fCONTRACT,fvo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","계약서 업로드에 실패했습니다");
				return mav;
			}
			
			try {/*증빙서 업로드 관련*/
				//if(fEVIDENCE.size()!=0) {
				if(fEVIDENCE.size()!=0) {
					//화면에 따른 변경부분
					//경로,원본id
					String inputPath = "resources/evidence/" +cmsVo.getCOMPANY_ID()+ "/";
					String oriId = cmsVo.getCOMPANY_ID();
					/*공통 적용 부분*/
					FileVo fvo = new FileVo();
					fvo.setFILE_DIR(inputPath);
					fvo.setFILE_ORIGIN(oriId);
					fus.fileUploadMultiple(fEVIDENCE,fvo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","증빙서 업로드에 실패했습니다");
				return mav;
			}
			
			int cnt=companyService.insertCompany(cmsVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}

	//사용자 상세 조회
	@RequestMapping(value= {"/admin/client/company/companyDetail.do","/admin/client/company/companyUpdate.do"})
	public @ResponseBody ModelAndView userDetail( @ModelAttribute("companyVO") CompanyVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		CompanyVo inputVo= null;
		MspVo mspvo = new MspVo();
		List<MspVo> mspList = new ArrayList<>();
		try {
			inputVo = companyService.selectCompany(thvo);
			mspvo.setCOMPANY_ID(thvo.getCOMPANY_ID());
			mspList = companyService.selectMspOne(mspvo);
			
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+inputVo);
			//계약서 증빙서
			FileVo fvo1 = new FileVo();
			fvo1.setFILE_DIR("/contract/");
			fvo1.setFILE_ORIGIN(thvo.getCOMPANY_ID());
			FileVo fvo2 = new FileVo();
			fvo2.setFILE_ORIGIN(thvo.getCOMPANY_ID());
			fvo2.setFILE_DIR("/evidence/");
			List<FileVo> contractList=fileService.selectFileList(fvo1);
			List<FileVo> evidenceList=fileService.selectFileList(fvo2);
			
			mav.addObject("data", inputVo);
			mav.addObject("mspList", mspList);
			mav.addObject("contractList", contractList);
			mav.addObject("evidenceList", evidenceList);
			mav.setViewName(url);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}

	
	//사용자 수정 반영
	@RequestMapping(value="/admin/client/company/companyUpdate.ajax")
	public @ResponseBody ModelAndView userUpdateForm( 
			@ModelAttribute("companyVO") CompanyVo thvo
			,HttpServletRequest request
			,@RequestPart(value = "fCONTRACT", required = false) List<MultipartFile> fCONTRACT
			,@RequestPart(value = "fEVIDENCE", required = false) List<MultipartFile> fEVIDENCE
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			try {
				//msp 요금제 관련
				if(thvo.getMspList()!=null) {
					companyService.deleteMsp(thvo);
					companyService.subListInsert(thvo.getMspList());
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","동일 클라우드일 경우에는 다른 요금제를 선택해주세요");
				return mav;
			}
			
			try {/*계약서 업로드 관련*/
				if(fCONTRACT.size()!=0) {
					//화면에 따른 변경부분
					//경로,원본id
					String inputPath = "resources/contract/" +thvo.getCOMPANY_ID()+ "/";
					String oriId = thvo.getCOMPANY_ID();
					/*공통 적용 부분*/
					FileVo fvo = new FileVo();
					fvo.setFILE_DIR(inputPath);
					fvo.setFILE_ORIGIN(oriId);
					fus.fileUploadMultiple(fCONTRACT,fvo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","계약서 업로드에 실패했습니다");
				return mav;
			}
			
			try {/*증빙서 업로드 관련*/
				//if(fEVIDENCE.size()!=0) {
				if(fEVIDENCE.size()!=0) {
					//화면에 따른 변경부분
					//경로,원본id
					String inputPath = "resources/evidence/" +thvo.getCOMPANY_ID()+ "/";
					String oriId = thvo.getCOMPANY_ID();
					/*공통 적용 부분*/
					FileVo fvo = new FileVo();
					fvo.setFILE_DIR(inputPath);
					fvo.setFILE_ORIGIN(oriId);
					fus.fileUploadMultiple(fEVIDENCE,fvo);
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","증빙서 업로드에 실패했습니다");
				return mav;
			}
			
			int cnt=companyService.updateCompany(thvo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	//사용자 삭제
	@RequestMapping(value="/admin/client/company/companyDelete.do")
	public @ResponseBody ModelAndView userDelete( @RequestParam(value="idArr[]")List<String> listArr,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//삭제대상이 '0000' 하이브시스템일 경우 삭제 못하도록 방지
			if(listArr.contains("0000")) {
				mav.addObject("msg","해당 고객사('하이브시스템')는 삭제하실수 없습니다");
			}else {
				companyService.deleteCompany(listArr);
			}
		} catch (Exception e) {
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
}
