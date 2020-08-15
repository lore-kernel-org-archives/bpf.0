Return-Path: <SRS0=c7WN=BZ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B5C433E1
	for <bpf@archiver.kernel.org>; Sat, 15 Aug 2020 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C898A2065C
	for <bpf@archiver.kernel.org>; Sat, 15 Aug 2020 23:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jkISz9//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgHOX3x (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 15 Aug 2020 19:29:53 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:39479 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbgHOX3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Aug 2020 19:29:52 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 17dbf29d;
        Sat, 15 Aug 2020 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=ZIFPDsMaam/KKfRH8s4z6SGuX7w=; b=jkISz9//M14wD6i5jF3L
        z06/aSM1xT7iqBBx3dLvKjgtn2LPG9fjcA/u9z/jadujcTgp/4wCBqtOXpJ79v5c
        dlaD9RVc8alTLcJgBrLvuPAq1EHIqG63qXsvSdlVHg6esEXLtXeVoMcaRkenoz1e
        0eYdJK/QqYV83Qo61Bqr7cyi0RaXuj0uZIx+z9C1X9kmhsl0Gp1jaFWo9SQ2Mn5G
        OQj8UDovrYIU4neWq/Auw3t6MY9YbA8hjWkqqGsr1bqLy+SAB8ZQHnonLz2vCVu6
        7DXljHGWJETdvpsaqmFK+GeQwGtMqm2irDI7ZxBubzJB4ReprNndQKJgT9B7lNEV
        yA==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b64639ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 15 Aug 2020 07:03:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH net] net: xdp: pull ethernet header off packet after computing skb->protocol
Date:   Sat, 15 Aug 2020 09:29:30 +0200
Message-Id: <20200815072930.4564-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When an XDP program changes the ethernet header protocol field,
eth_type_trans is used to recalculate skb->protocol. In order for
eth_type_trans to work correctly, the ethernet header must actually be
part of the skb data segment, so the code first pushes that onto the
head of the skb. However, it subsequently forgets to pull it back off,
making the behavior of the passed-on packet inconsistent between the
protocol modifying case and the static protocol case. This patch fixes
the issue by simply pulling the ethernet header back off of the skb
head.

Fixes: 297249569932 ("net: fix generic XDP to handle if eth header was mangled")
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7df6c9617321..151f1651439f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4676,6 +4676,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff *skb,
 	    (orig_bcast != is_multicast_ether_addr_64bits(eth->h_dest))) {
 		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, skb->dev);
+		__skb_pull(skb, ETH_HLEN);
 	}
 
 	switch (act) {
-- 
2.28.0

