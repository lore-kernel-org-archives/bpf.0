Return-Path: <SRS0=RZwz=SR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF45C10F12
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7E52183F
	for <bpf@archiver.kernel.org>; Mon, 15 Apr 2019 17:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="1rFRMcPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfDOR0u (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:26:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53102 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbfDOR0t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Apr 2019 13:26:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id a184so21665319wma.2
        for <bpf@vger.kernel.org>; Mon, 15 Apr 2019 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=1rFRMcPMkLXAdQWYIG4OQZyv5lTUdPNUUFk+bSUMS0PNHIbjIfudJ2LMnAeYwuQviZ
         0UpeZrJ4nUZMbE/uPJtvdFdhJvzfkbh4Gw9qokrUlIuvuZfFppeBve/JcALp7IBPWaXd
         gTlEdNyxIJy61JkUzB23LgZccjW/sgNJrj+Bc0qEaDnVOkPFOx637B8iP0SfVKAVfRPK
         mWMfvRiGI3VlEdwUpv9xZZ99bz7HL6Gp/c1grwZlwG57cjyHFkilevY0cF35l0LAWf+L
         ETtXAuqNy8uDJo+NiJXrIr10Or3vN6G/NsqnFY0JWEHV/5ngKFZbYfCcj6QvgSWqGXMu
         dpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=fq9bkBe1l5DiNWctidCiXecaTweRf4L7K9ZSiVnfNwKH19CESx3KcUXuBlwYlCl2SQ
         n+zrFsVkbCuF5EwL7wc/fHvoxR4khRZs801kLmYo6Fz+pLJqtjgxgESRzAc1yE54GLYm
         tNgh3e0IBaB81BL+TGnTM5deaNGt8jyc7FDxklhiQzUusEzo2tXrHWpIcLjtuayygGrI
         cLaDRoyQ8JVRxBStb3A9CrHfHxoXhyusOkK7/6PYS/7wy5ImQGgfHbbVLf0iTe/yDgq0
         th1N9GVQQa0HuaHBkn9lHAlC3aW5K8QW+ormm5taRbavbjLUinoKJXJxlk/IaMmdg9ks
         32pA==
X-Gm-Message-State: APjAAAW1F1ikIjGsQ7ToPdXibOphHU0WVvGW2fJJHhHcYZE3/mEZBNIH
        49z0SeIJZcJ/Y5fcABjSq+iOBg==
X-Google-Smtp-Source: APXvYqz/QT58iBJa8jehbPPJU47dajP4i3GDxrmy5OLV/3ph0RCMz9QjhWw7jm9L3rgJlXvgtekYnA==
X-Received: by 2002:a1c:7e8a:: with SMTP id z132mr24087701wmc.92.1555349208789;
        Mon, 15 Apr 2019 10:26:48 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id v190sm27094232wme.18.2019.04.15.10.26.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 10:26:48 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH v4 bpf-next 11/15] s390: bpf: eliminate zero extension code-gen
Date:   Mon, 15 Apr 2019 18:26:21 +0100
Message-Id: <1555349185-12508-12-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
References: <1555349185-12508-1-git-send-email-jiong.wang@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
---
 arch/s390/net/bpf_jit_comp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 51dd026..59592d7 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -299,9 +299,11 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 
 #define EMIT_ZERO(b1)						\
 ({								\
-	/* llgfr %dst,%dst (zero extend to 64 bit) */		\
-	EMIT4(0xb9160000, b1, b1);				\
-	REG_SET_SEEN(b1);					\
+	if (fp->aux->no_verifier_zext) {			\
+		/* llgfr %dst,%dst (zero extend to 64 bit) */	\
+		EMIT4(0xb9160000, b1, b1);			\
+		REG_SET_SEEN(b1);				\
+	}							\
 })
 
 /*
@@ -1282,6 +1284,11 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
 	return 0;
 }
 
+bool bpf_jit_hardware_zext(void)
+{
+	return false;
+}
+
 /*
  * Compile eBPF program "fp"
  */
-- 
2.7.4

