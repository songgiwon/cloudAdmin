package kr.co.hivesys.charge.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.charge.vo.ChargeVo;
import kr.co.hivesys.company.vo.CompanyVo;

@Mapper("chargeMapper")
public interface ChargeMapper {


	List<ChargeVo> selectPriceList(ChargeVo thvo);

	int chargeInsert(ChargeVo thvo);

	void deleteCharge();
}
