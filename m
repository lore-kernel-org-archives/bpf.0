Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6A3C10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8C020820
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CauEe20b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfDJTvN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 15:51:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37156 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfDJTu6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 15:50:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so4369104wrm.4
        for <bpf@vger.kernel.org>; Wed, 10 Apr 2019 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=CauEe20bVPVPu+dhpUHLI0ywZsDC1Ms1bKy0bR2cIZpEtQjjscwA9urHJkNu57aJV+
         3we51tgocA2matiPupOzyt9K1J1YoycRqSSS3vA1nOsftesGBnKeEavX1MGosJvXLeXU
         oAW9tTd1iEvWpZO1Y1hJx8PO5a1J2x/g9TdpTQ9PTbdohZofPnpbmLODhQrOQFCEAFmK
         qT7o8eWYf3BXgSb1vccPkacDnmJju+pzcqFaULdLMS+2A1LMrGJAUBDGNbSIbgiqGobS
         ETS6nwOGj2AhVQaOi/BunTPuXiCkeHgW2JfApF373nhD+pkwuTKskQdXi+bnPHG29By7
         61iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/wylRhv97waN1hLNQRjtw5HFd7aLKXwfbfkeZTfcGns=;
        b=QjDhVsJzyNlsg5nBLzidKZoONWF5YU2+S/vfsUt/t/Yng5K+OYjWAj1N1bXSOCU8Nr
         FEKiu+nMHiBB8FUytG6ypva06Icl7ZGBL6JvQk5onLupflAJdxngyBLTBvpHY91gBdZf
         HqDiPjBk6zvAF9McCTBH7YK23JFdLFJBOdUrsKZDTBqaLgEaOvsp46I70X2c4LO1O5dL
         5ZV0nfl90uWXaqz0jwIzqigYT3mueI47Ico4wR9dTnVTiPRyd6G2s+uymWXWfilLJ3AY
         z67ug5ZMjVnI/XNG1aYYTTqn7aHOoiLnrlfJzHdjlfBsBa+jXjsqp/30Ho86StIz82l9
         JWYQ==
X-Gm-Message-State: APjAAAVyIqXXCaQlTA58Jbubb2g+yVcu9Yo5X3t54YByVYmdyKGHrApK
        pK5mBpI9fLY6MA7DtLxmLuaJBw==
X-Google-Smtp-Source: APXvYqzJyHpIKxagu00hYmm6kuJ65OpcVvnScKF15xs1KyaLICKK9F+zdy0J9U1OJIr1KAEqw5QEig==
X-Received: by 2002:adf:82c9:: with SMTP id 67mr6586210wrc.261.1554925856263;
        Wed, 10 Apr 2019 12:50:56 -0700 (PDT)
Received: from cbtest28.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id 4sm2288540wmg.12.2019.04.10.12.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Apr 2019 12:50:55 -0700 (PDT)
From:   Jiong Wang <jiong.wang@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, Jiong Wang <jiong.wang@netronome.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC v2 bpf-next 15/19] s390: bpf: eliminate zero extension code-gen
Date:   Wed, 10 Apr 2019 20:50:29 +0100
Message-Id: <1554925833-7333-16-git-send-email-jiong.wang@netronome.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
References: <1554925833-7333-1-git-send-email-jiong.wang@netronome.com>
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

