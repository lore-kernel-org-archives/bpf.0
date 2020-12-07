Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C46CC197BF
	for <bpf@archiver.kernel.org>; Mon,  7 Dec 2020 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA411239A4
	for <bpf@archiver.kernel.org>; Mon,  7 Dec 2020 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgLGQdk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Dec 2020 11:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgLGQdj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 11:33:39 -0500
From:   Lorenzo Bianconi <lorenzo@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, shayagr@amazon.com, sameehj@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, lorenzo.bianconi@redhat.com,
        jasowang@redhat.com
Subject: [PATCH v5 bpf-next 01/14] xdp: introduce mb in xdp_buff/xdp_frame
Date:   Mon,  7 Dec 2020 17:32:30 +0100
Message-Id: <7e7dbe0c739640b053c930d3cd22ab7588d6aa3c.1607349924.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1607349924.git.lorenzo@kernel.org>
References: <cover.1607349924.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce multi-buffer bit (mb) in xdp_frame/xdp_buffer data structure
in order to specify if this is a linear buffer (mb = 0) or a multi-buffer
frame (mb = 1). In the latter case the shared_info area at the end of the
first buffer is been properly initialized to link together subsequent
buffers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h | 8 ++++++--
 net/core/xdp.c    | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 700ad5db7f5d..70559720ff44 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -73,7 +73,8 @@ struct xdp_buff {
 	void *data_hard_start;
 	struct xdp_rxq_info *rxq;
 	struct xdp_txq_info *txq;
-	u32 frame_sz; /* frame size to deduce data_hard_end/reserved tailroom*/
+	u32 frame_sz:31; /* frame size to deduce data_hard_end/reserved tailroom*/
+	u32 mb:1; /* xdp non-linear buffer */
 };
 
 /* Reserve memory area at end-of data area.
@@ -97,7 +98,8 @@ struct xdp_frame {
 	u16 len;
 	u16 headroom;
 	u32 metasize:8;
-	u32 frame_sz:24;
+	u32 frame_sz:23;
+	u32 mb:1; /* xdp non-linear frame */
 	/* Lifetime of xdp_rxq_info is limited to NAPI/enqueue time,
 	 * while mem info is valid on remote CPU.
 	 */
@@ -154,6 +156,7 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 	xdp->data_end = frame->data + frame->len;
 	xdp->data_meta = frame->data - frame->metasize;
 	xdp->frame_sz = frame->frame_sz;
+	xdp->mb = frame->mb;
 }
 
 static inline
@@ -180,6 +183,7 @@ int xdp_update_frame_from_buff(struct xdp_buff *xdp,
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
+	xdp_frame->mb = xdp->mb;
 
 	return 0;
 }
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 17ffd33c6b18..79dd45234e4d 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -509,6 +509,7 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 	xdpf->headroom = 0;
 	xdpf->metasize = metasize;
 	xdpf->frame_sz = PAGE_SIZE;
+	xdpf->mb = xdp->mb;
 	xdpf->mem.type = MEM_TYPE_PAGE_ORDER0;
 
 	xsk_buff_free(xdp);
-- 
2.28.0

