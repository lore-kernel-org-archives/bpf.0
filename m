Return-Path: <SRS0=DuKs=AK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B2C433E1
	for <bpf@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81886206F1
	for <bpf@archiver.kernel.org>; Mon, 29 Jun 2020 19:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DOW+nDlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgF2TIs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbgF2TCm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:42 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D271C02A555;
        Mon, 29 Jun 2020 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MUpR3vxb/3x7pTgYotaCnl85fDRP0t+XWiQf/ROkfg0=; b=DOW+nDlKUSsiGmK5DH33nDnu+G
        WQD2B/v3z8dljEfR8h8SR5xiWTW0ipG8Wiz7Gp4w3ZkYZAnLqHLVRsBh5RdKZ7JcCu+FqDm5lqGms
        WIOQU9BqRysseIn7+alAM3ekaP6gzbrQvU9qIyhm0sTrYtrdSrmbi7ys3nIZaieB7dkOdHIsGgvZ+
        i0ZxE45pWYhPHfkPiBOpqTXdf4I/frWWCsctA+aiESgiY8Mkw3YG/6U7BI0NIeKcFOb6LMXK8GLix
        gPLLcd1n+bfPSALMaQyoZB4IBXEZEXNxBWcAgu/4T+YMv0eHMzD5eCJbRYSF8BDoQW3wVUsCJgzWH
        +4JMo08Q==;
Received: from [2001:4bb8:184:76e3:c71:f334:376b:cf5f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jptSA-0004Xh-2X; Mon, 29 Jun 2020 13:04:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Cc:     Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] xsk: remove a double pool->dev assignment in xp_dma_map
Date:   Mon, 29 Jun 2020 15:03:58 +0200
Message-Id: <20200629130359.2690853-4-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629130359.2690853-1-hch@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

->dev is already assigned at the top of the function, remove the duplicate
one at the end.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/xdp/xsk_buff_pool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 9fe84c797a7060..6733e2c59e4835 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -193,7 +193,6 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	if (pool->unaligned)
 		xp_check_dma_contiguity(pool);
 
-	pool->dev = dev;
 	pool->dma_need_sync = !xp_check_cheap_dma(pool);
 	return 0;
 }
-- 
2.26.2

