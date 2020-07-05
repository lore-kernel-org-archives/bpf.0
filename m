Return-Path: <SRS0=q05f=AQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA45C433DF
	for <bpf@archiver.kernel.org>; Sun,  5 Jul 2020 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5E820870
	for <bpf@archiver.kernel.org>; Sun,  5 Jul 2020 09:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593942859;
	bh=TCfmtM1TWRRmjCPXPoHi2E42e61IF3B52TN3qoLXr9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZDRHfidvRPTcA6r9eckJJpa4RXs1+1az7WUWc3sxtGzdfyonEzNE6Cjn1e6j4JI1W
	 xMxSN6yUB+Dog/Sl52/DyQX9n0vUrRPMRTlH1QJswLNNfbHdykEHwXRVBXOfmepnyV
	 wHC32HSalbIo1BAuF6YIL4dYxBlWTRPdGy7Rac0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGEJyS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 5 Jul 2020 05:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgGEJyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Jul 2020 05:54:18 -0400
Received: from localhost.localdomain (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AE12082F;
        Sun,  5 Jul 2020 09:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593942858;
        bh=TCfmtM1TWRRmjCPXPoHi2E42e61IF3B52TN3qoLXr9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEwQ1g4yusmuZuDhZbT02uAry5lsmCbk3pkNUjlVgnRzmJYcoPZZndfWqVrathxeR
         QkazhlXpVvrrmTRI6g710OM/WT33ClobkgIIKk2XqAbxymUFHdWI6IEuFJCW7SbLRc
         5evrMpVeAG0FW5v9QdV85DRG23FP/xNNvmO3OlOg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, brouer@redhat.com,
        daniel@iogearbox.net, toke@redhat.com, lorenzo.bianconi@redhat.com,
        dsahern@kernel.org, andrii.nakryiko@gmail.com
Subject: [PATCH v6 bpf-next 2/9] net: refactor xdp_convert_buff_to_frame
Date:   Sun,  5 Jul 2020 11:53:53 +0200
Message-Id: <15d16b4db87b2c916b8f3b7d5e0fdff4d6c09e15.1593941896.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593941895.git.lorenzo@kernel.org>
References: <cover.1593941895.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: David Ahern <dsahern@kernel.org>

Move the guts of xdp_convert_buff_to_frame to a new helper,
xdp_update_frame_from_buff so it can be reused removing code duplication

Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: David Ahern <dsahern@kernel.org>
---
 include/net/xdp.h | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 609f819ed08b..5b383c450858 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -121,39 +121,48 @@ void xdp_convert_frame_to_buff(struct xdp_frame *frame, struct xdp_buff *xdp)
 	xdp->frame_sz = frame->frame_sz;
 }
 
-/* Convert xdp_buff to xdp_frame */
 static inline
-struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
+int xdp_update_frame_from_buff(struct xdp_buff *xdp,
+			       struct xdp_frame *xdp_frame)
 {
-	struct xdp_frame *xdp_frame;
-	int metasize;
-	int headroom;
-
-	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
-		return xdp_convert_zc_to_xdp_frame(xdp);
+	int metasize, headroom;
 
 	/* Assure headroom is available for storing info */
 	headroom = xdp->data - xdp->data_hard_start;
 	metasize = xdp->data - xdp->data_meta;
 	metasize = metasize > 0 ? metasize : 0;
 	if (unlikely((headroom - metasize) < sizeof(*xdp_frame)))
-		return NULL;
+		return -ENOSPC;
 
 	/* Catch if driver didn't reserve tailroom for skb_shared_info */
 	if (unlikely(xdp->data_end > xdp_data_hard_end(xdp))) {
 		XDP_WARN("Driver BUG: missing reserved tailroom");
-		return NULL;
+		return -ENOSPC;
 	}
 
-	/* Store info in top of packet */
-	xdp_frame = xdp->data_hard_start;
-
 	xdp_frame->data = xdp->data;
 	xdp_frame->len  = xdp->data_end - xdp->data;
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
 
+	return 0;
+}
+
+/* Convert xdp_buff to xdp_frame */
+static inline
+struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdp_frame;
+
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return xdp_convert_zc_to_xdp_frame(xdp);
+
+	/* Store info in top of packet */
+	xdp_frame = xdp->data_hard_start;
+	if (unlikely(xdp_update_frame_from_buff(xdp, xdp_frame) < 0))
+		return NULL;
+
 	/* rxq only valid until napi_schedule ends, convert to xdp_mem_info */
 	xdp_frame->mem = xdp->rxq->mem;
 
-- 
2.26.2

