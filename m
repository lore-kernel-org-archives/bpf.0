Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC4C43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F920811
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 07:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh54UpQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfCHH6d (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 8 Mar 2019 02:58:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41377 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfCHH63 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Mar 2019 02:58:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so13556226pfn.8;
        Thu, 07 Mar 2019 23:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0z6IyR8uHfnPhHjwVxX0mfo3QGVFEzkTrFIFzkjuyMA=;
        b=Dh54UpQJ01OBgi4rfz/D1s6Uzbj5sv1mVb4vzjnwkTSHo6goS0ve8O0Qr/CP/u/VoQ
         KQJCR5muTQ5nfpwxzrowbB+tB+OXgrMmE3tp6u8/ZPbwL0T3DmRgm3kd+jhA1B/CZQX7
         Y5xOt8731N1YRYObJnwPxLwo+duECtUFx6IE+aJ8hP7gH7jVDXdQwogmbiPJBwK6mHth
         PRLnP74AL1cjKW3vhAuXx1TF9KFvJUJdmraR7xvpHsJQi4lOEqSY0AicONhjl5EupsBV
         ss1JxSfgEMKQ+BjCAx/SOyEkQ6et9Cbob1yrjgh9zNNwvbj2woiJw2S20VCJOFF99Dru
         L45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0z6IyR8uHfnPhHjwVxX0mfo3QGVFEzkTrFIFzkjuyMA=;
        b=oqW7GPLio7PnDYDQ15nQckHwiQL9ySywqTziPacIE17yC4UMRic1UWfRDGpS1PzqW2
         hXhU8ll9LSPnDB8jW/9kmBrZZMrix6IEeDedxgQB5hrZvAoZV+ntijHlCPI4M/pFFTFU
         58W+bUfGNY6AcwmdVeqYmMGeb/tb5/LIRjhfxD9aByreiH8+mqPnLTsEnwX0L7MjN5C7
         IA0t+/ViDH7pWGTTU4/0sdCSWY3kt3yAdjz8DdoVPNxo83BAmVIzOQB4yEQcHg5Qg1Km
         /Jr33bN2Rv5qPxQLq54A0OtDbLIKH/R/0cCeA9iBBlDH3EYOEx29SRWUU4pqKJ2niprD
         sQQQ==
X-Gm-Message-State: APjAAAWH4y1RYv05kIUw0okUzwpxWHZMmIJJWCJX7P5oP3564WsGVvKV
        zDPvUISLfBgOV7lFlyZBScMfLIpi78wS0A==
X-Google-Smtp-Source: APXvYqzmL5i6mBi4oJdtrXnFlVKX8R7Emyk6NnxLtRithrrkFXy3XoA083/u0QaT5QPkJRUjW6SzLA==
X-Received: by 2002:a62:1706:: with SMTP id 6mr16885140pfx.28.1552031909034;
        Thu, 07 Mar 2019 23:58:29 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id y14sm17066471pgs.47.2019.03.07.23.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 23:58:28 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
Subject: [PATCH bpf 1/2] xsk: fix to reject invalid flags in xsk_bind
Date:   Fri,  8 Mar 2019 08:57:26 +0100
Message-Id: <20190308075727.19358-2-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190308075727.19358-1-bjorn.topel@gmail.com>
References: <20190308075727.19358-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Passing a non-existing flag in the sxdp_flags member of struct
sockaddr_xdp was, incorrectly, silently ignored. This patch addresses
that behavior, and rejects any non-existing flags.

We have examined existing user space code, and to our best knowledge,
no one is relying on the current incorrect behavior. AF_XDP is still
in its infancy, so from our perspective, the risk of breakage is very
low, and addressing this problem now is important.

Fixes: 965a99098443 ("xsk: add support for bind for Rx")
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 net/xdp/xsk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6697084e3fdf..a14e8864e4fa 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -407,6 +407,10 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	if (sxdp->sxdp_family != AF_XDP)
 		return -EINVAL;
 
+	flags = sxdp->sxdp_flags;
+	if (flags & ~(XDP_SHARED_UMEM | XDP_COPY | XDP_ZEROCOPY))
+		return -EINVAL;
+
 	mutex_lock(&xs->mutex);
 	if (xs->dev) {
 		err = -EBUSY;
@@ -425,7 +429,6 @@ static int xsk_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
 	}
 
 	qid = sxdp->sxdp_queue_id;
-	flags = sxdp->sxdp_flags;
 
 	if (flags & XDP_SHARED_UMEM) {
 		struct xdp_sock *umem_xs;
-- 
2.19.1

