Return-Path: <SRS0=YLVI=R6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC1CC43381
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CB0206C0
	for <bpf@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714809;
	bh=u2gYrfJBu25SovInffio7GBUBKv8Fo1qUfGtX/mMjKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Li1H3J9yzqfjB3Ib049wCIvx8PIBPWOrqIvrhv5UU4p+j3prwo0DU1YeHMqz4mtvN
	 ztBcBUvqMihGM81Hb5OAft8QRgSv0GWH79WJfRHdr9FeWGY5R8y+qYJbe3RnVk52cP
	 P8RD/TBmuCxeQzsUjm2Nn3ndxvxxXc5ICvCGHNl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbfC0SFA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387515AbfC0SE5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3596621738;
        Wed, 27 Mar 2019 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709897;
        bh=u2gYrfJBu25SovInffio7GBUBKv8Fo1qUfGtX/mMjKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zuuvnBgrwA2+kHchUr4d6L3r7asylkRf+7IFlKMKE4q1cb72WMiCMrZ26W6zNeoYV
         m3dC2HvaHc8W+3+V39HA60SZVG/LsrS4ySOPRu2IIHo1vFlQNKd+V/b6MOlRTZIJNd
         GR8FLOBpTsFf0MD2AXR/NmksdVTCOdEAFn4ioick=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 095/262] veth: Fix -Wformat-truncation
Date:   Wed, 27 Mar 2019 13:59:10 -0400
Message-Id: <20190327180158.10245-95-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit abdf47aab4123ece48877cab4153db44fe4dc340 ]

Provide a precision hint to snprintf() in order to eliminate a
-Wformat-truncation warning provided below. A maximum of 11 characters
is allowed to reach a maximum of 32 - 1 characters given a possible
maximum value of queues using up to UINT_MAX which occupies 10
characters. Incidentally 11 is the number of characters for
"xdp_packets" which is the largest string we append.

drivers/net/veth.c: In function 'veth_get_strings':
drivers/net/veth.c:118:47: warning: '%s' directive output may be
truncated writing up to 31 bytes into a region of size between 12 and 21
[-Wformat-truncation=]
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
                                               ^~
drivers/net/veth.c:118:5: note: 'snprintf' output between 12 and 52
bytes into a destination of size 32
     snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       i, veth_rq_stats_desc[j].desc);
       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index f412ea1cef18..b203d1867959 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -115,7 +115,8 @@ static void veth_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 		p += sizeof(ethtool_stats_keys);
 		for (i = 0; i < dev->real_num_rx_queues; i++) {
 			for (j = 0; j < VETH_RQ_STATS_LEN; j++) {
-				snprintf(p, ETH_GSTRING_LEN, "rx_queue_%u_%s",
+				snprintf(p, ETH_GSTRING_LEN,
+					 "rx_queue_%u_%.11s",
 					 i, veth_rq_stats_desc[j].desc);
 				p += ETH_GSTRING_LEN;
 			}
-- 
2.19.1

