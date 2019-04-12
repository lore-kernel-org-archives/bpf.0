Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDCC10F14
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A560218D2
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 22:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BoHHBDqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDLWAW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 18:00:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36885 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfDLWAU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 18:00:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so13753040wrm.4
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 15:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=BoHHBDqSo9hYv0bkI611gzs7drYaYY98UgiHOhpRkui7YtSrsec1ln6rGGvug6NAYQ
         sps7qnbUecCFq81vL5n50ALFCCJiNkmrxyc1zqjo1sdjBcVUP/1GCTUPW/cN+kfQlfvF
         ZvQ/6n3300/0iqhWAmFna7p1h3BCi7P2XeQarh79q393JlCnIGhsMs0sIKqhgMHgGoHk
         bvIhvXVOvVWANqv/YnBq7cik2mzFgnOnXf/Vr64Z1D+IpDi85/hdTPCdusBop+HQlHqB
         2bF1sFqjrM+YRzaJMtdkK9q2Edjic9YBVKlQRARPululNxm/Y5gcXEGso2IxN+5lK/HY
         TmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=aXEVkAeKjucN9djH4On/pgRo0qB16US9H1nPPTJxcT4Jo/IgooT9o1YYwxnHvutI7F
         Z2eM3pvWe05xuxBHPGNMxxx95/jmrcgP/OyEcyHNPFaeoaqVxQ7RNAaK9FwVV/q4AyaW
         0Kl3lHyQtuoLi/CwwN7Pk7xePNAW/TUQVn1ON8RE7JR7e/MaH2sZHc4u/28S/LyxkiK4
         ebY4esC+YlOafC+ag5lUfkj3wGW6+py2l9dIFjCzhR4glyjKx9y4J0t8HS2c+M3vFNTK
         3wckynBbkpZP1T0Ay462lqGth0eP3bv42Qr5Z0jN24MRM+IwAsiuHq2utH2yXLcRlU24
         bc5w==
X-Gm-Message-State: APjAAAWzDf1v4AbW8xt4VuMHrbn34AuaOHeYV7TO+Fu6Gtw8p4/ZxkPZ
        H7ORT4xtGoVHQ828qw5a6VSnug==
X-Google-Smtp-Source: APXvYqzrxDF22KbtqLIyFMfNsKL/hMb0KNXMx9QPeLg6JA5ur1aUZwyF1It0qkQSPIBfhk5gQpHUwg==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr12063138wrm.300.1555106418532;
        Fri, 12 Apr 2019 15:00:18 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id f1sm8490764wml.28.2019.04.12.15.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 15:00:17 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH v3 bpf-next 15/19] s390: bpf: eliminate zero extension code-gen
Date:   Fri, 12 Apr 2019 22:59:48 +0100
Message-Id: <1555106392-20117-16-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com>
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

