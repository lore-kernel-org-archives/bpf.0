Return-Path: <SRS0=dSfD=A3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3288FC433DF
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 23:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A9A206F4
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 23:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594942518;
	bh=DH8W/hh60f/yucHMLcmPgq4bufUV9mRBqjqUBraxbyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CgKrRK8Wm07XFmE2xdemPXgivZXZVs8YJgt6UX7skqTMx6hN+tDbUTldVs0OqwiwU
	 SKLThexaPYjT9UMS9zQp7Q9wAJ9h1/pgdo8kIBvVJViGGb46Ub4YBwxxX592f8gS0m
	 dpsVFWxUqFCjYGdPBilZKCwv2CCV0/sxdVC4296E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGPXfR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgGPXfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 19:35:17 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D516B207FB;
        Thu, 16 Jul 2020 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594937823;
        bh=DH8W/hh60f/yucHMLcmPgq4bufUV9mRBqjqUBraxbyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3lTC/ZknJc5U1fwCnniqkFGCXu2TCRNOkEKrxt4IU8j6qis4yBhUWqck+pVpwImz
         SLKkNibEA8wGTBENNOd2W6j5D6nYujr+SOQ2PTtDLOQo8VaA4qKFIyH61r3EQ3kKp4
         I5S+cHUYzDWpjRZyn8MrJDlOPBZUAOIwcCxmj2zA=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, bpf@vger.kernel.org, kuba@kernel.org,
        ilias.apalodimas@linaro.org, lorenzo.bianconi@redhat.com,
        brouer@redhat.com, echaudro@redhat.com, sameehj@amazon.com
Subject: [PATCH v2 net-next 1/6] xdp: introduce xdp_get_shared_info_from_{buff,frame} utility routines
Date:   Fri, 17 Jul 2020 00:16:29 +0200
Message-Id: <45a48fd7b97a3ada0bbbf017ec9c4b74ac6e5798.1594936660.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1594936660.git.lorenzo@kernel.org>
References: <cover.1594936660.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce xdp_get_shared_info_from_{buff,frame} utility routines to get
skb_shared_info from xdp buffer/frame pointer.
xdp_get_shared_info_from_{buff,frame} will be used to implement xdp
multi-buffer support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/xdp.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 609f819ed08b..d3005bef812f 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -85,6 +85,12 @@ struct xdp_buff {
 	((xdp)->data_hard_start + (xdp)->frame_sz -	\
 	 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+static inline struct skb_shared_info *
+xdp_get_shared_info_from_buff(struct xdp_buff *xdp)
+{
+	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
+}
+
 struct xdp_frame {
 	void *data;
 	u16 len;
@@ -98,6 +104,15 @@ struct xdp_frame {
 	struct net_device *dev_rx; /* used by cpumap */
 };
 
+static inline struct skb_shared_info *
+xdp_get_shared_info_from_frame(struct xdp_frame *frame)
+{
+	void *data_hard_start = frame->data - frame->headroom - sizeof(*frame);
+
+	return (struct skb_shared_info *)(data_hard_start + frame->frame_sz -
+				SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+}
+
 /* Clear kernel pointers in xdp_frame */
 static inline void xdp_scrub_frame(struct xdp_frame *frame)
 {
-- 
2.26.2

