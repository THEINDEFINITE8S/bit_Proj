package kr.co.fedal.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.fedal.dao.ArtistDAO;
import kr.co.fedal.dao.FestivalDAO;
import kr.co.fedal.dao.MusicDAO;
import kr.co.fedal.vo.ArtistVO;
import kr.co.fedal.vo.FestivalVO;
import kr.co.fedal.vo.MusicVO;

@Service
public class FestivalServiceImpl implements FestivalService {

	@Autowired
	private FestivalDAO festivalDao;
	
	@Autowired
	private ArtistDAO artistDao;
	
	@Autowired
	private MusicDAO musicDao;
	
	@Override
	public List<FestivalVO> selectAll() {
		List<FestivalVO> list = festivalDao.selectAllFestival();
		return list;
	}

	@Override
	public FestivalVO selectDetail(String fid) {
		FestivalVO vo = festivalDao.selectDetailFestival(fid);
		return vo;
	}

	@Override
	public List<ArtistVO> selectAllArtist(String fid) {
		List<ArtistVO> list = artistDao.selectAllArtist(fid);
		return list;
	}

	@Override
	public List<MusicVO> selectAllMusic(String aid) {
		List<MusicVO> list = musicDao.selectAllMusic(aid);
		return list;
	}

	@Override
	public ArtistVO selectArtist(String aid) {
		ArtistVO vo = artistDao.selectArtist(aid);
		return vo;
	}

	@Override
	public List<FestivalVO> searchAllFestival(String keyword) {
		List<FestivalVO> list = festivalDao.searchFestival(keyword);
		return list;
	}

	@Override
	public List<ArtistVO> searchAllArtist(String keyword) {
		List<ArtistVO> list = artistDao.searchArtist(keyword);
		return list;
	}


	@Override
	public Map<String, List<FestivalVO>> partiFestival(List<ArtistVO> fidList) {
		Map<String, List<FestivalVO>> map = new HashMap<>();
		for(ArtistVO a: fidList) {
			List<String> aidList = festivalDao.findFids(a.getAid());
			List<FestivalVO> festVOList = new ArrayList<>();
			for(String s: aidList) {
				festVOList.add(festivalDao.searchRes(s));
			}
			map.put(a.getAid(), festVOList);
		}
		
		return map;
		
	}
	
	
/*	@Override
	public Map<String, List<FestivalVO>> partiAllFestival(List<ArtistVO> artistList) {
		Map<String, List<FestivalVO>> map = new HashMap<>();
		
		for(ArtistVO e: artistList) {
			System.out.println("jj: " + e.getAid());
			map.put(e.getAid(),festivalDao.partiFestival(e.getAid()));
			
		}
		System.out.println("map: " + map);
		return map;
		
	}*/

}
