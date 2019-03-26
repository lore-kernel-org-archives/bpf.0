Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D7C10F05
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765272084B
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 18:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="C8BAAlG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbfCZSHH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:07:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46535 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbfCZSGu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 14:06:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so15466691wrs.13
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 11:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=C8BAAlG4HEv42kHlnrcjpi2XqGSGKgawPiv1cUHm1oaeWHBrcvSDSc5QF3VEzD4iKN
         cP/J8O7wQ/m5tSSUxofchGX68sX+EwskQ39M++NtnCD+OKOsHCdOOZ2FRmA9FDtE4Q5O
         pC3Qib6NFHJ3XfANiFbHqnzsBZU7FtOc31Zp3UI9IYXy74Yic8+kUL+i/LEJtT5ssRGs
         YVKkGZR5KM/dEkUnMMO5qe+I/7z3gJOZsQUqpdv4fhsAdgft1tuZxPDVMVCa4upDgbzF
         vlP94ZNYu7JfIvc77VI8sL48ItMwwT1nXkndlA3ifyo9JgqE4aHOliCbVsciPGb5gQJB
         5/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=f++m2iGQyu6iCBpLfBUJY0vnuy85Q5RrAux45hq/xtW7LgyYdEmDC5TucODf5DZAo0
         eFBjdel7oG40/r+eU9J7eM/w9uLtpZ6mI9eL034D8FSXS/dtz81aXdeEHxKTWDjK8GUe
         MYMKFwHgJVw6RmxQe9Bn33p/rtXVILU2dkJyHFpGdxGo0nfZRO4YBKXL2a7dHQShtomI
         twAdJ+rk6n/pKu3DaqGUAzZgAUSpMs5QrSzbDauDn78rKLIOtL6N3Vs/HUhDi/cZs5LW
         XjuXEo2GHZIsjcVMnJIan8Y5dMawR63OctS46O8TLoIGKtt0VyodQij3TLquI6guVZ0n
         82kQ==
X-Gm-Message-State: APjAAAW/PMX829Ahky1FsoT61h0WOFx93LqDWlUqX/55WAok/aL7AYsn
        Xlp3fV3pZn9ba1v9oyoHB+Fzzw==
X-Google-Smtp-Source: APXvYqwbtrejR3KCst2sQRjESvX6YZZCTbRkCOolq/qhQ3zuJEC1s5hVXN92fwZnDA7m3oOf0RSnEw==
X-Received: by 2002:adf:f286:: with SMTP id k6mr11712543wro.137.1553623608337;
        Tue, 26 Mar 2019 11:06:48 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id i28sm36697534wrc.32.2019.03.26.11.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Mar 2019 11:06:46 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC bpf-next 10/16] s390: bpf: eliminate zero extension code-gen
Date:   Tue, 26 Mar 2019 18:05:33 +0000
Message-Id: <1553623539-15474-11-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
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

