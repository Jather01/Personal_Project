package test.gallery.dto;

public class GalleryDto {
	private int num;
	private String writer;
	private String caption;
	private String imagePath;
	private String regdate;
	private int nextNum;
	private int prevNum;
	// 페이징 처리에 필요한 필드
	private int startRowNum;
	private int endRowNum;
	
	public GalleryDto() {}
	public GalleryDto(int num, String writer, String caption, String imagePath, String regdate, int nextNum,
			int prevNum, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.writer = writer;
		this.caption = caption;
		this.imagePath = imagePath;
		this.regdate = regdate;
		this.nextNum = nextNum;
		this.prevNum = prevNum;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public int getNextNum() {
		return nextNum;
	}
	public void setNextNum(int nextNum) {
		this.nextNum = nextNum;
	}
	public int getPrevNum() {
		return prevNum;
	}
	public void setPrevNum(int prevNum) {
		this.prevNum = prevNum;
	}
	public int getStartRowNum() {
		return startRowNum;
	}
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}
	public int getEndRowNum() {
		return endRowNum;
	}
	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
}
