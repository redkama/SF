package org.zerock.dto;

import lombok.*;

@Setter
@Getter
@ToString
@AllArgsConstructor
@Builder
public class PageDTO {

    /** 현재 페이지 (1부터 시작) */
    private int page;

    /** 페이지당 게시글 수 */
    private int size;

    /** SQL LIMIT 시작 위치 */
    private int offset;

    /** 전체 게시글 수 */
    private int totalCount;

    /** 전체 페이지 수 */
    private int totalPage;

    /** 페이징 블록 시작/끝 */
    private int startPage;
    private int endPage;

    /** 이전/다음 블록 존재 여부 */
    private boolean hasPrev;
    private boolean hasNext;

    /** 한 블록에 보여줄 페이지 수 */
    private int blockSize;

    public PageDTO() {
        this(1, 10);
    }

    public PageDTO(int page, int size) {
        this.page = page <= 0 ? 1 : page;
        this.size = size <= 0 ? 10 : size;
        this.offset = (this.page - 1) * this.size;
        this.blockSize = 10;
    }

    /** totalCount 세팅하면 나머지 계산 */
    public void setTotalCount(int totalCount) {
        this.totalCount = Math.max(totalCount, 0);

        this.totalPage = (int) Math.ceil((double) this.totalCount / this.size);
        if (this.totalPage == 0) this.totalPage = 1;

        int currentBlock = (int) Math.ceil((double) this.page / this.blockSize);
        this.startPage = (currentBlock - 1) * this.blockSize + 1;
        this.endPage = Math.min(this.startPage + this.blockSize - 1, this.totalPage);

        this.hasPrev = this.startPage > 1;
        this.hasNext = this.endPage < this.totalPage;
    }

    public void setPage(int page) {
        this.page = page <= 0 ? 1 : page;
        this.offset = (this.page - 1) * this.size;
    }

    public void setSize(int size) {
        this.size = size <= 0 ? 10 : size;
        this.offset = (this.page - 1) * this.size;
    }
}
