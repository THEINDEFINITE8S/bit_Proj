package kr.co.fedal.vo;

public class AreviewVO {
	private int no;
	private String url;
	private int cnt;
	private String content;
	private String reg_Date;
	private String writer;
	private String aid;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(String reg_Date) {
		this.reg_Date = reg_Date;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	@Override
	public String toString() {
		return "AreviewVO [no=" + no + ", url=" + url + ", cnt=" + cnt + ", content=" + content + ", reg_Date="
				+ reg_Date + ", writer=" + writer + ", aid=" + aid + "]";
	}
	
	
	
}
