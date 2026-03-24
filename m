Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C038B318EDF
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355253; cv=none; b=FdMApkIRXHCy+7B1S0Vh/LGTY0pGRPbGh4EnLeT0U34sgQm+rUHRlJZ1vmsMrD/ze9QFb6i5HKOnSWSCRUTNjvj9l0E/CRm4ZjyuqjsEt7G0mG5zUDb34MbVS/RZiF8ViDZtoXB0YL3NlleSraCeEOELjge3bOJfKRFGvLc/MLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355253; c=relaxed/simple;
	bh=2hwBaiTYWPgPdvYP/SDJeV1QwJS7IHBoFcHIsCNSe3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gAOY28QyC3aSzPzJdtbf91mNKz7WLRpJiqBz6qslvV4EQZbbEwaILKzBAXzjwwjjuxIfKE1rR89ZsBSOfkwoHdyoiLHGt+anRBbQDHApBRndUr7w20BXJF8Z1Vz+HcytSdkEYxW+nGncJBfnXMshAGNoqNqspoqZSxm1K0MYvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+LQz+V2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+LQz+V2"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so1018250b3a.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 05:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355252; x=1774960052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwSnjFcjq1oUFhDGo0eVz8ywdnnal2i+ieo63wHrZYg=;
        b=g+LQz+V2qNOpDJuAPTHj1o2Yz3j29juTS1l3w829Ryt72+ExBfBiog4isQlFKkQfPp
         ymMffKKK1WURJSmrdMscXarjjIYU8+GAVDwzt+ACJqF1VbRJjzlaq+J1Uyaktj0zevBQ
         s5fVZig+27VAB44vebHbgdX2/K+wU9uW0a0VbZEHiAHz9qNwM3RUJ9+l7VYS1+nXsW34
         NvzKWR1VNg6v0KG/xuBd0sCQD8nUur2hGz6cSbAhiqwVFJLUSL1uMqwSodpMgMXYNCLq
         nZfYDzuyR6P5zD+V42t9Zba3N7QxzUhHO1RMuMgWqGH5Vg8SBGcDSqRQLhjzNoCjSFQn
         B6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355252; x=1774960052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwSnjFcjq1oUFhDGo0eVz8ywdnnal2i+ieo63wHrZYg=;
        b=GQJ2jCdRfsHwxHjlmbjXknCnG+bG8DPXUeLiUjGYGWaslwVcyaAi3a2wO/IHY6WT3k
         l6nCguqZLYk5FhXd1BWkjxVnCh4pJTMDAbGQyeHTfRfVneB18s4GsfHp8HSWTxe/A4od
         1uTnszNOwCHlxV5V94K/L8VGtCnBkLDfR/ptaPV92wxisIMZd4iaXuSH+iv3fXqKKkGz
         zlpHUgyh8mYk5ux8153et+bf/HktXiu+G2hnm9wxT4Jx0ranHRbjmCnfDmJPPgEr1WRc
         riN2uQRSZ45HbUPwx7wjWoJWhCkNE0PLdFRgN8qQBH5673yO7/FydaDcDp4uM0k1vFpb
         8urA==
X-Gm-Message-State: AOJu0YzyikEgbfsWj47JRF3/8nzG3Pk+Wyu9qAyxZcinz4TWzqV2GjY5
	PGuvExfuzntw56bC8Xkz7SwsfQwGOStBJeXbWAZ+EVmSN8i3R68CkAh7
X-Gm-Gg: ATEYQzwn31IqiJbDoR9dHqqpxaCYpHOwsdjfc7I6ApvqbkB2Bd6rI1Ccq2TvR/9MFTR
	R8Jq5EFSR05k6N/EG8Elam65JEcujYeh7gwQg7cM/bti/iPIq+IWaZnh/vJiTFfc48FpGTqifR3
	z6n3ffiotRxfbGVcG8tT+AR9poR12TR1Fy80G11w6Tg1Gm2lI7HXOOdITfR7qTC5sygXlhuUgj9
	sF2wqyW/WTZCIfa3SenjaZKlovEfog/uJYOvgg6QGw6yguQCQ0jWQPTo86lRR5L7qKkGV+RrDl4
	jh3X/SqL8AXPfmHbKsvGw2BLY/i6efapO4h9KF0edmMShQXTKyxppCTWXTF8MBzvBG5pUMgVzeC
	T5X5sZSM9YnVhYlF0uw7kGj7PflmiCBp5DC9vu1ZpoDpr8zGD4ZTDque/OYoOTUBZzFKeJvPYQi
	kfX2Qo7QRykdOH9MJA7v4C9qKdi6bTtf0A2OYjjULhHD2eydilmlLIPA==
X-Received: by 2002:a05:6a00:6c8d:b0:82a:7f28:c79b with SMTP id d2e1a72fcca58-82a8c2ef7bfmr13798915b3a.31.1774355252204;
        Tue, 24 Mar 2026 05:27:32 -0700 (PDT)
Received: from ZC-202510311500 ([61.185.217.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f409sm12224583b3a.31.2026.03.24.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:27:31 -0700 (PDT)
From: Haoyu Lu <hechushiguitu666@gmail.com>
To: arc@lists.infradead.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	"haoyu . lu" <hechushiguitu666@gmail.com>
Subject: [PATCH] arch/arc: bpf_jit: fix missing newline in pr_err messages
Date: Tue, 24 Mar 2026 20:27:02 +0800
Message-ID: <20260324122703.641-1-hechushiguitu666@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: haoyu.lu <hechushiguitu666@gmail.com>

Add missing newline to pr_err messages in arch/arc/net/bpf_jit_arcv2.c.

Fixes: f122668ddcce ("ARC: Add eBPF JIT support")
Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 arch/arc/net/bpf_jit_arcv2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
index 6d989b6d88c6..7ee50aeae5a4 100644
--- a/arch/arc/net/bpf_jit_arcv2.c
+++ b/arch/arc/net/bpf_jit_arcv2.c
@@ -2427,7 +2427,7 @@ u8 arc_prologue(u8 *buf, u32 usage, u16 frame_size)

 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2454,7 +2454,7 @@ u8 arc_epilogue(u8 *buf, u32 usage, u16 frame_size)

 #ifdef ARC_BPF_JIT_DEBUG
 	if ((usage & BIT(ARC_R_FP)) && frame_size == 0) {
-		pr_err("FP is being saved while there is no frame.");
+		pr_err("FP is being saved while there is no frame.\n");
 		BUG();
 	}
 #endif
@@ -2868,7 +2868,7 @@ u8 gen_jmp_64(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 		break;
 	default:
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("64-bit jump condition is not known.");
+		pr_err("64-bit jump condition is not known.\n");
 		BUG();
 #endif
 	}
@@ -2948,7 +2948,7 @@ u8 gen_jmp_32(u8 *buf, u8 rd, u8 rs, u8 cond, u32 curr_off, u32 targ_off)
 	 */
 	if (cond >= ARC_CC_LAST) {
 #ifdef ARC_BPF_JIT_DEBUG
-		pr_err("32-bit jump condition is not known.");
+		pr_err("32-bit jump condition is not known.\n");
 		BUG();
 #endif
 		return 0;
--
2.53.0.windows.1
