Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C17CC10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96E7218A3
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HwKdVsjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfDLWAW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37341 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfDLWAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so12644705wmf.2
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=HwKdVsjZ+lKkcdRiB7Sd+PAgUvTf9Ik/ylIbnc9ioyPXpFQZ58fK0VEHrj0HC4Gh9M
         3V7ZhulYxqUA8PKA3vgJhhMKRYGYWfde06D1ZdY9bfn1b2L2bAYhN+300Lga1fwtm/8h
         eDD5I9HluoqXq8ne14lJ/CRo+VVfA+nR5hDYXvMmGtsEAHzFmY4x0GCB/KZRYz2QD65M
         rAQUByulZq6V9Q/PrQ4fesAP81q/MZOLC10OCUNi9bMd01ZCoF3+UpQs/SNlTP0iwcgu
         9hD+d+M35MFHf5vCXycIWDvrjKGHvawTnr/uZR7hevXcPbpm15rRpw7FRzxX5J4qkY3h
         Q2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pi+jMPgfzj2fBkAwzCkG0vyOGnD4cZfJGlYpVzkjSMY=;
        b=mJUGo2sHoFNzJkDp5y0qb5bzZDNftuwxSx6T7LC/8bwlFJ1PqOSa25jfqvogWg2xT5
         jPWnd40zjiouw3Fe4b6sOzQBU0O3PG8b4M6q6xMrBCAg4p92riRF8IJN2q0/U0KSti2D
         nGkEuelJUusgIaWrhRoLgLYIkkhlZ6RY+zzX5ni8rMgpd0e3JQVTLjGv4qePwLZBuYgm
         WCkrsSiLnePSu7qtSaxkY3571PKPmOsuA0bmwWUv7JPzqW6KNC66FTLjUcWKRbgnpRkR
         Td7uJBeFJZVR0JfgEvW4U8ApopJWBC/luEPicwt8/NMyJ5DH6w/A47sIiosw8dGWvFKi
         dG/Q==
X-Gm-Message-State: APjAAAWPL3p6kyWdZ7RJsauBcH0Nb84vJ4doIekQUrvDP+4g77JdG9d4
        tICBFaRIVsLYSHiA0ruZX6pITQ==
X-Google-Smtp-Source: APXvYqyLyRHzjd9TagkWVLihgtpSoDoJ9UIdJAxZAMG91CJi5vc5zuovv2Y90ro7onQq+SuTM/zaRw==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr13692229wme.24.1555106419277;
        Fri, 12 Apr 2019 15:00:19 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:18 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v3 bpf-next 16/19] sparc: bpf: eliminate zero extension code-gen
Date:   Fri, 12 Apr 2019 22:59:49 +0100
Message-Id: <1555106392-20117-17-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 65428e7..e58f84e 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1144,7 +1144,8 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 
 	do_alu32_trunc:
-		if (BPF_CLASS(code) == BPF_ALU)
+		if (BPF_CLASS(code) == BPF_ALU &&
+		    ctx->prog->aux->no_verifier_zext)
 			emit_alu_K(SRL, dst, 0, ctx);
 		break;
 
@@ -1432,6 +1433,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 		*ptr++ = 0x91d02005; /* ta 5 */
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 struct sparc64_jit_data {
 	struct bpf_binary_header *header;
 	u8 *image;
-- 
2.7.4

