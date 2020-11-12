Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C7EC55ABD
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 11:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6134D22228
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 11:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq1RYIYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgKLLno (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Nov 2020 06:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgKLLl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 06:41:58 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E8C061A49;
        Thu, 12 Nov 2020 03:41:56 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i7so3957756pgh.6;
        Thu, 12 Nov 2020 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjXiaJJaFcfh/d5Hg7T1ivvJjPLwr7C0xxhr2qpyt5M=;
        b=oq1RYIYtZ+UUsWNLnlie3I5ZJoeVCUDg/V42d/J3N2ap21e8Cs6h1rU0SpV1gRchJY
         af6tuRiccEYRnM6IifD+9Rq8VFJ9tbKbjIgmPsPOXAHWo5QaN5k+NFP8xQwXdt7JeH1C
         fzaDRuiZ6hrppOf5833u2v+SbiUtdYps1feiTIRO5TY4vnj8OfH5YS70d20nUbl6FIHz
         M+AnfjBZZco0v/n9coIjI/wzVncA+vDWwmZozIStnzSXLKezFH1ucDtyzPFdbpvOf37h
         VtD3bmaEJxxwP04RMW/yE5FJvNPUy5E6WZANiJv241Li7Sssl1okohi+z02vB58bZgD2
         XPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjXiaJJaFcfh/d5Hg7T1ivvJjPLwr7C0xxhr2qpyt5M=;
        b=Cv4SUmHq/IFzKrwS6Zy3JZQQPgMP/B6KpwPZo9JqUgVJTJQ4TFf7myJ1IGztoDS6Ja
         MQ0CDPh5F3f35c9pQ3rZ22DL+vR81f2esi3BK2QU/r/mcWX/3i4BLntFjnqFpfiWPPfu
         HKLkR+VL/QsN/2pVL8dlfvBazqnbgr8yNwjQcFHped6WtditmGOPtavbmn6800eIW3yb
         z241sCNGA4uVdR+DHlRCMyNDTJ92sz4jjdYSCXd3c+5mKydVuVoldEL4uzui7n6Obtc8
         5S3mQGQ1yvbrWxf7bzUlUWSyJDcyvqM4ol/PN+tGP8fAtlUnx/A0YuUH719dTnDkYTGK
         EU2g==
X-Gm-Message-State: AOAM533nPRZpMOXTDbuddQM+DujcQE9VkoP6nQdZDDNt5/GVMZNVfCwA
        ka4CLLRYETOgBumkERPsBQfG0WqlpIpfvKjL
X-Google-Smtp-Source: ABdhPJwE6gxKMqA0Dl8OgDY6y1pRLk9oO2yurtbhQeVbir9MK0hUiPgJOvYpqDRxj82lVzw7QR28IA==
X-Received: by 2002:a65:5c4c:: with SMTP id v12mr26281741pgr.119.1605181316094;
        Thu, 12 Nov 2020 03:41:56 -0800 (PST)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id y8sm6161629pfe.33.2020.11.12.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 03:41:54 -0800 (PST)
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, ast@kernel.org, daniel@iogearbox.net,
        maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
        jesse.brandeburg@intel.com, qi.z.zhang@intel.com, kuba@kernel.org,
        edumazet@google.com, jonathan.lemon@gmail.com, maximmi@nvidia.com
Subject: [PATCH bpf-next 7/9] samples/bpf: use recvfrom() in xdpsock
Date:   Thu, 12 Nov 2020 12:40:39 +0100
Message-Id: <20201112114041.131998-8-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201112114041.131998-1-bjorn.topel@gmail.com>
References: <20201112114041.131998-1-bjorn.topel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Björn Töpel <bjorn.topel@intel.com>

Start using recvfrom() the rxdrop scenario.

Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
---
 samples/bpf/xdpsock_user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/xdpsock_user.c b/samples/bpf/xdpsock_user.c
index 1149e94ca32f..96d0b6482ac4 100644
--- a/samples/bpf/xdpsock_user.c
+++ b/samples/bpf/xdpsock_user.c
@@ -1172,7 +1172,7 @@ static inline void complete_tx_only(struct xsk_socket_info *xsk,
 	}
 }
 
-static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
+static void rx_drop(struct xsk_socket_info *xsk)
 {
 	unsigned int rcvd, i;
 	u32 idx_rx = 0, idx_fq = 0;
@@ -1182,7 +1182,7 @@ static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
 	if (!rcvd) {
 		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.rx_empty_polls++;
-			ret = poll(fds, num_socks, opt_timeout);
+			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
 		return;
 	}
@@ -1193,7 +1193,7 @@ static void rx_drop(struct xsk_socket_info *xsk, struct pollfd *fds)
 			exit_with_error(-ret);
 		if (xsk_ring_prod__needs_wakeup(&xsk->umem->fq)) {
 			xsk->app_stats.fill_fail_polls++;
-			ret = poll(fds, num_socks, opt_timeout);
+			recvfrom(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, NULL);
 		}
 		ret = xsk_ring_prod__reserve(&xsk->umem->fq, rcvd, &idx_fq);
 	}
@@ -1235,7 +1235,7 @@ static void rx_drop_all(void)
 		}
 
 		for (i = 0; i < num_socks; i++)
-			rx_drop(xsks[i], fds);
+			rx_drop(xsks[i]);
 
 		if (benchmark_done)
 			break;
-- 
2.27.0

