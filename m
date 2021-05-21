Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B000C433B4
	for <bpf@archiver.kernel.org>; Fri, 21 May 2021 08:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1A861363
	for <bpf@archiver.kernel.org>; Fri, 21 May 2021 08:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhEUIex (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 21 May 2021 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEUIew (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 May 2021 04:34:52 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1725EC061574;
        Fri, 21 May 2021 01:33:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i17so20157147wrq.11;
        Fri, 21 May 2021 01:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaMvOvlMFartTSlXCuGI5oDB8r1cP0ShwB/1QsbOHFE=;
        b=kEbWh2d5EFThb/znUlZNvo0e51WApWFRwJXV8ie7hfbdm+iDOY7T6sBPA3wf4G8o5h
         mUZGUiaK4xkk4r7IhK9hyr4OGoPFHmZu5qLAyhw/raAUNu1Ku0w7f6BumGB5vp4gn6jz
         vzxbpqRq2U1VpvP55MDSWO2j5G1l0QVAyN6wNieOQpf+cun/oyl8O0cIrAbt93KaTL3f
         MnLz8dJE9El58tGjxYWNHh4dVpo01OSqNBaC/nkjUiBjkEIho1bS47jMul2wWZuRzUSt
         UR+4wNAv4JXYbtV84Hosi9nUGaassmaOEL2NaTm8knTyunFjZuPo0IEwiASVpisYgNja
         J/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WaMvOvlMFartTSlXCuGI5oDB8r1cP0ShwB/1QsbOHFE=;
        b=CmMkGeOPZEtKPrZwp6xcPNYJr+o4YPlyWoso5GI0dAtatH/EQEaQYDyixSrKiQUGch
         joGMoOCUCpydwTRlKjcvVhkBpiBDY1KWkFswjR992E279FDSJFvq4zfc4Lfagn7PybCx
         HJsSEvmUR6wPLHJLfRnHH5G0kJYc0ANbES1H/KR7sV4V/mGFExXA+T/cXMbQ1rSgL+06
         042tV7A6ClARbKgFXu50pFdZde/XffuEFujVAGIZ4ZnpSIFydRCCQ3Y3BdltQSx+rtqN
         G+D+txAUmG6QZrQN/XCmuAoyVpnaNnS5vktxRrzlGwS4bPo3kAaYJ3QxWqvgR4S6fui9
         vXEA==
X-Gm-Message-State: AOAM530/pNHjvLZrixd2981pWICi7XIfG6MTNA7sBPHEls7HwHzClKGO
        S4qI+T+q1OGG5sleiPV/WBY=
X-Google-Smtp-Source: ABdhPJwHqbFY8xKHMjxiYie1AtD09LqOk6ROpGzKQ4wy3WD6T/H0NeSA7biLlETeV3ZUKrDhXkJs6Q==
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr7936264wrt.319.1621586008662;
        Fri, 21 May 2021 01:33:28 -0700 (PDT)
Received: from localhost.localdomain (h-46-59-47-246.A165.priv.bahnhof.se. [46.59.47.246])
        by smtp.gmail.com with ESMTPSA id a17sm1231200wrt.53.2021.05.21.01.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 May 2021 01:33:28 -0700 (PDT)
From:   Magnus Karlsson <magnus.karlsson@gmail.com>
To:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        maciej.fijalkowski@intel.com
Cc:     jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        Dan Siemon <dan@coverfire.com>
Subject: [PATCH bpf-next] xsk: use kvcalloc to support large umems
Date:   Fri, 21 May 2021 10:33:01 +0200
Message-Id: <20210521083301.26921-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Magnus Karlsson <magnus.karlsson@intel.com>

Use kvcalloc() instead of kcalloc() to support large umems with, on my
server, one million pages or more in the umem.

Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reported-by: Dan Siemon <dan@coverfire.com>
---
 net/xdp/xdp_umem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 56a28a686988..f01ef6bda390 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -27,7 +27,7 @@ static void xdp_umem_unpin_pages(struct xdp_umem *umem)
 {
 	unpin_user_pages_dirty_lock(umem->pgs, umem->npgs, true);
 
-	kfree(umem->pgs);
+	kvfree(umem->pgs);
 	umem->pgs = NULL;
 }
 
@@ -99,8 +99,7 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 	long npgs;
 	int err;
 
-	umem->pgs = kcalloc(umem->npgs, sizeof(*umem->pgs),
-			    GFP_KERNEL | __GFP_NOWARN);
+	umem->pgs = kvcalloc(umem->npgs, sizeof(*umem->pgs), GFP_KERNEL | __GFP_NOWARN);
 	if (!umem->pgs)
 		return -ENOMEM;
 
@@ -123,7 +122,7 @@ static int xdp_umem_pin_pages(struct xdp_umem *umem, unsigned long address)
 out_pin:
 	xdp_umem_unpin_pages(umem);
 out_pgs:
-	kfree(umem->pgs);
+	kvfree(umem->pgs);
 	umem->pgs = NULL;
 	return err;
 }

base-commit: a49e72b3bda73d36664a084e47da9727a31b8095
-- 
2.29.0

