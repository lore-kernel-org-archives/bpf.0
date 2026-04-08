Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1670C192D8A
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775614452; cv=none; b=pqd574A7XyTUgoJjnkcilJ4Y90DANEXDxtOe0rBjYQuaFuZQB2aEyYzHSyTMi8nbPb5lJL0MZL2utKsp/rxEbh9bBxyizAoI7f2CvXQ98uIPWa1ovLV7GXOcFaAd3mZAHzBMvLy8ALr/cQAIEFCKUTrF52XW0r6phEGqSFWF4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775614452; c=relaxed/simple;
	bh=XrkQcWqs7AP85csRWXc5TFKAZ+AkLwAi0B25wslTDII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrZxAx0UkpGrOJp0sj7OlwcvzlxGnQyV2wbU4oT5aml5WiX4rxcol599Ok8s1QsQriyEnF2Tunn+rSPm+PbjfsnfxgI/8prVVD13t7Xf5e52iOJ5KsQBWAYOfIKMPvdBXPQEYKNH8x+StOw1l6NvQuurUhWlbfZiQdT74OHqS88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsEnMi84; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsEnMi84"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-47018d34159so3069957b6e.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 19:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775614449; x=1776219249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8CnhZIJ5K2VlXLB1GGRjRZedba+V9qPysWfN1PNd1Y=;
        b=IsEnMi84VOXua72AiSdC97nccfQQ6vOG7pLI7n1VkAwvZ6srT7TQSlpTyIjrOtSj6z
         8isHfF/zX3r7s+Te+HEzXA3Z78MXPxgzLpv+a3GsgFdkENlqNEgN+CT5lXwWJiUfLMIG
         bgKbWXcXzbLMdiAAeTPPnAeAdL4ijqIp7EWfrYNZK9YCcx+ZWL4J059xRbE+hwApm+F1
         Hst2IBHJKNsFsYVstkqi2z0BWGVQgsUqvQMGPnZeSgfxBwqGVm63D54QtGecHmv1ir9/
         xz6FpasgnDgU/1h53xDVZT/MOrNwzWHiTQiSBDzV95I8KSfmIuRdlOVnQhiaYSrybX9c
         H7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775614449; x=1776219249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8CnhZIJ5K2VlXLB1GGRjRZedba+V9qPysWfN1PNd1Y=;
        b=Q5IP0YaaWlUuJJfZmSF/VSazAxoBXeY87pV4lumlPxF6bognbwdDRKeDFLuxE6fCms
         SdV4iNSwuS1obl1VC6RfzXgM/36LCm1ZdmIjZwnqdmEnQ8bhJdTYpsRKk4SrrZKTx00f
         eOIZmr46EFvWzNivZJ10TTH7Px+Y8uAAbGnR3nGKEAGKpL01klbuXGlo+FyUh4+Xmfla
         h1/J/ZJktxzvWjcR4pRskjACVv14BzEbEaGzfZijKiAkKluRpm80y74rWjLNTwTakavE
         ADiFTwRgj0+GuDgPurIDAkcV1KF9vmRq7EQ7DaC3yON1SVANlp2aQBk/sGtQxDNtI5CF
         bdtQ==
X-Gm-Message-State: AOJu0YyVa2ZmqlvvnUDMMoCq5D6sIXB+o6PDVH4PYlGsjwr1GjZgt527
	Zo6M5cjAoBnvQabaPdx0jLUTvH+6+NE/ayh55mX7Ge0UB4NMZiyW/cEh0yhjPt5q6OI=
X-Gm-Gg: AeBDievg93knc2qomwu7oj0myjGRsJhyGe4gbncqNK1A8KLbxZt/KNztSSZKjjjUGcQ
	U68o7w/0sKQS359Jfqjeml3iAlC+M/Zx8gEZqLqttKp55lzB4TzcD5veBuwEUAruL9E85z6TsRv
	tV1OfjaFYyrTkyGENFokfbcmgfgSIufZBpgBBPwGu/x85FN13ElSFrsLVOGsINmuQPCbP8faPqA
	61t/Ay1QDzBoks/8HJulIRni/RHbt/Nwi5MPsFyXW8KKgkkOcCIQdoN4x+AdHAlXpl1D75+jxdu
	FayA1BgfHWGZZP1H3oKbpqpC4nN3Y1ttj8/ruW9Rz1BbX0/1iAvjH4DmYGqqRUZ31xfl9SbX+bX
	KQl39H880a7ktTFO4ofjVfOfiyH4+bgwRjl4aPB1Q1+K+nQVubloUYWvcGv9qMGmbhvy/x3dUGh
	tTkX6sqRcgDdFYHFp7OhyGXTkvgjbH/wfTt4EmMp/3fPaG
X-Received: by 2002:a05:6808:66d6:b0:471:f036:7926 with SMTP id 5614622812f47-471f0367af3mr4003154b6e.28.1775614449641;
        Tue, 07 Apr 2026 19:14:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47551804168sm1500793b6e.5.2026.04.07.19.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 19:14:08 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/6] bpf: Make find_linfo widely available
Date: Wed,  8 Apr 2026 04:13:54 +0200
Message-ID: <20260408021359.3786905-4-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
References: <20260408021359.3786905-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4510; h=from:subject; bh=XrkQcWqs7AP85csRWXc5TFKAZ+AkLwAi0B25wslTDII=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfPqzmObNIWWJpeKtCfM40r8bRjt8T7vjUz9onRBX+2Hce1+ 2652lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCKpNgz/lKNVZVmuOl14IrfJltv9oM Xd+axfNaRfNZrsS7ww4UPML4b/lRcnif3fdEDk7MQ3x1i+c2tvLpLjvbJxK+vrJNUFf7QtWQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Move find_linfo() as bpf_find_linfo() into core.c to allow for its use
in the verifier in subsequent patches.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 37 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/log.c    | 43 +------------------------------------------
 3 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d8fb9d61f5ce..0136a108d083 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3945,6 +3945,7 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off);
 void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
 			     const char **filep, const char **linep, int *nump);
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index ada76f997177..066b86e7233c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3335,6 +3335,43 @@ void bpf_get_linfo_file_line(struct btf *btf, const struct bpf_line_info *linfo,
 		*nump = BPF_LINE_INFO_LINE_NUM(linfo->line_col);
 }
 
+const struct bpf_line_info *bpf_find_linfo(const struct bpf_prog *prog, u32 insn_off)
+{
+	const struct bpf_line_info *linfo;
+	u32 nr_linfo;
+	int l, r, m;
+
+	nr_linfo = prog->aux->nr_linfo;
+	if (!nr_linfo || insn_off >= prog->len)
+		return NULL;
+
+	linfo = prog->aux->linfo;
+	/* Loop invariant: linfo[l].insn_off <= insns_off.
+	 * linfo[0].insn_off == 0 which always satisfies above condition.
+	 * Binary search is searching for rightmost linfo entry that satisfies
+	 * the above invariant, giving us the desired record that covers given
+	 * instruction offset.
+	 */
+	l = 0;
+	r = nr_linfo - 1;
+	while (l < r) {
+		/* (r - l + 1) / 2 means we break a tie to the right, so if:
+		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
+		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
+		 * r becomes 1 and we exit the loop with correct l==1.
+		 * If the tie was broken to the left, m=1 would end us up in
+		 * an endless loop where l and m stay at 1 and r stays at 2.
+		 */
+		m = l + (r - l + 1) / 2;
+		if (linfo[m].insn_off <= insn_off)
+			l = m;
+		else
+			r = m - 1;
+	}
+
+	return &linfo[l];
+}
+
 int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
 			   const char **linep, int *nump)
 {
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index c67fbbbd5768..48931d4e5a68 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -327,47 +327,6 @@ __printf(2, 3) void bpf_log(struct bpf_verifier_log *log,
 }
 EXPORT_SYMBOL_GPL(bpf_log);
 
-static const struct bpf_line_info *
-find_linfo(const struct bpf_verifier_env *env, u32 insn_off)
-{
-	const struct bpf_line_info *linfo;
-	const struct bpf_prog *prog;
-	u32 nr_linfo;
-	int l, r, m;
-
-	prog = env->prog;
-	nr_linfo = prog->aux->nr_linfo;
-
-	if (!nr_linfo || insn_off >= prog->len)
-		return NULL;
-
-	linfo = prog->aux->linfo;
-	/* Loop invariant: linfo[l].insn_off <= insns_off.
-	 * linfo[0].insn_off == 0 which always satisfies above condition.
-	 * Binary search is searching for rightmost linfo entry that satisfies
-	 * the above invariant, giving us the desired record that covers given
-	 * instruction offset.
-	 */
-	l = 0;
-	r = nr_linfo - 1;
-	while (l < r) {
-		/* (r - l + 1) / 2 means we break a tie to the right, so if:
-		 * l=1, r=2, linfo[l].insn_off <= insn_off, linfo[r].insn_off > insn_off,
-		 * then m=2, we see that linfo[m].insn_off > insn_off, and so
-		 * r becomes 1 and we exit the loop with correct l==1.
-		 * If the tie was broken to the left, m=1 would end us up in
-		 * an endless loop where l and m stay at 1 and r stays at 2.
-		 */
-		m = l + (r - l + 1) / 2;
-		if (linfo[m].insn_off <= insn_off)
-			l = m;
-		else
-			r = m - 1;
-	}
-
-	return &linfo[l];
-}
-
 static const char *ltrim(const char *s)
 {
 	while (isspace(*s))
@@ -388,7 +347,7 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifier_env *env,
 		return;
 
 	prev_linfo = env->prev_linfo;
-	linfo = find_linfo(env, insn_off);
+	linfo = bpf_find_linfo(env->prog, insn_off);
 	if (!linfo || linfo == prev_linfo)
 		return;
 
-- 
2.52.0

