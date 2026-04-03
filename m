Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFE34CFB9
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775184268; cv=none; b=qraS4t/0kDtneNmtXTSiPaDv90krftxoMSym8wN8uz53H3VRUtf12XM/M99D3OEJPD6/n6CY2KwyZsDnm//LKr6Qj9QCdbpLIL8ctEVGwOMlQrnv66qXEWM41nQSvrOXZPmQ3tD1VDg47H4AGIWMfaTW3m6HRW5uHgl5pKnnZKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775184268; c=relaxed/simple;
	bh=eH8zojZ3+sx/3ZMQPcmY+N2BAA63nZmLajpUHyqna60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szq8olnHhIqgMa7vDE5DI2/TNZzOsDm90JAtpEHPVdxZe1tOhiYqGEhz37NcCGvj969jRgODoz8pQi6JzSkBHrNYy/ssx7y1AAXuZ/Jzh5dzaCauTyBHyhUcazlxMVuUjWtnppig1rIeuJuA+Z+0COU/EjEhtV3yAuyv+PekSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek8TyQv4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek8TyQv4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab232cc803so6601535ad.3
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 19:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775184267; x=1775789067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=Ek8TyQv4RfrxCxQnroSBkjfX/t0y9tUtCcptUUfMnzcEffaJRLu+ZTr1PwvHWukc0E
         eLdMXeSjk5/u2D+7PSSD6H3XN/lTR0fJ7gysgqrMQp1Br4I3CArzGvNtkTCUJgfUt4cL
         +1LyC39ONg3zKQnmOvzGu5fJirqz/AOigsful2KP1Rn6LVgXTl0s/depbtYp/d50GnVh
         S5moKoH3cIHkJtT9/DN40+FCT6QZK91l9/Q9yKQ/LKJopq3tPYvYsvoKgOMa3Jq7tL7W
         nl0dr83N+fV4+Vr6wzhvbDSiV2+9dpNBCiDj+D5TDp55DXrL8ot7IcMLUITC0lu51lpN
         c7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775184267; x=1775789067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=tDJcRpwexYbkCYH5N+rVU7Tvoo6ykkCGuBXGP891LWz/aFArGVkhpYMPC1/ASPWS7m
         57qBQXBZV6LJJs39R4op0rsg9mo9K+hOb8deJr98PHhMhMj63G5rEcAZnrax3yHyGjYS
         WBoNU4L1jOdM12GIRTe8GNsPYP0NQaNIqEax+UQ4awfsQ3iCHBySrkJQiv5jfxfcaeFa
         ryT78JprFNxuUtRhnpztiAsdgJINp4WJ0lzBuOP7e8um+1+ZLOFaR/M9Yfhey598pMRO
         xI1FUvpeZJjQaz8xvOY7B2xeAOPf6d/wJj5SQjFkiooc1Wnh9RJZcDae7yNw5fbjlhCo
         2BXg==
X-Gm-Message-State: AOJu0YxOjwCBZZXVfM45Ej3I2JgS2l5i2w7duCNwcuqrdgna2YV8u2re
	Pl5O78YDYcWQDYzSudPiyxFEzPZ/n4NdGhX0Kmol2sRrwUWOLCJEDjBsODXG7A==
X-Gm-Gg: AeBDievEBvkazDGnjEcWJG1yOSNZUecyKBvDcARGc3Rv81dhxPqJ180wIwfqx6u1hky
	LIejOaeHcGgI/Ux8HMM7HC+SMbaPYazOrOtNXq+0N5pY6vY9T3r7QbvoTTLSs/bS1oNH+NrNovT
	fUViOTEtMokbCCuBWI6g+l+iaXwU033D7q4EufPgL/2/T7UnKgK8J8k7X8KDvs4u56x8KT4YAyO
	VP+7jaWHrNs6aadUdLSkNaMFOh/Bb9kCJZVxtbhDoFrYusD8qdGj3FBPvEZa4Co+RS5Fh+PmG18
	vmhvg8UEScxzgsGGyuo3/0XURVBGpj5dAfCjNin5q2l/WgvQglfP3i6eAiPE46WCu0hnfXoCUt2
	6k3OBQPee+TKhnZ6Bl72FsPW7rPWsna5Jg5zGef1BrSydwRO4XHllMzMkXOnkvkGw3j4ukk3QV1
	9xZ/TtD3EPy8BRKUIOGW24LGhPSVl+2DnfJtGXzneD876bGIygA83fkZd4oXUlw3Iz//n6vxaug
	TY9gcf3Q9DlAwtPr3267+Xdt9gkykbAk38wHERJs8g2wb9JfSkpWWIATGwAHxo7Udygss/M
X-Received: by 2002:a17:903:4b07:b0:2b2:6cab:3100 with SMTP id d9443c01a7336-2b2818360d5mr15759545ad.21.1775184266629;
        Thu, 02 Apr 2026 19:44:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749ecbd1sm67106975ad.83.2026.04.02.19.44.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 19:44:26 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v5 bpf-next 1/6] bpf: Do register range validation early
Date: Thu,  2 Apr 2026 19:44:16 -0700
Message-ID: <20260403024422.87231-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Instead of checking src/dst range multiple times during
the main verifier pass do them once.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c                         | 34 +++++--------------
 .../selftests/bpf/verifier/junk_insn.c        |  4 +--
 2 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c1cf2eb6cbb..8234d80b892a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2249,13 +2249,6 @@ static void __mark_reg_const_zero(const struct bpf_verifier_env *env, struct bpf
 static void mark_reg_known_zero(struct bpf_verifier_env *env,
 				struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_known_zero(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs */
-		for (regno = 0; regno < MAX_BPF_REG; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_known_zero(regs + regno);
 }
 
@@ -2908,13 +2901,6 @@ static void __mark_reg_unknown(const struct bpf_verifier_env *env,
 static void mark_reg_unknown(struct bpf_verifier_env *env,
 			     struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_unknown(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_unknown(env, regs + regno);
 }
 
@@ -2947,13 +2933,6 @@ static void __mark_reg_not_init(const struct bpf_verifier_env *env,
 static void mark_reg_not_init(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *regs, u32 regno)
 {
-	if (WARN_ON(regno >= MAX_BPF_REG)) {
-		verbose(env, "mark_reg_not_init(regs, %u)\n", regno);
-		/* Something bad happened, let's kill all regs except FP */
-		for (regno = 0; regno < BPF_REG_FP; regno++)
-			__mark_reg_not_init(env, regs + regno);
-		return;
-	}
 	__mark_reg_not_init(env, regs + regno);
 }
 
@@ -3958,11 +3937,6 @@ static int __check_reg_arg(struct bpf_verifier_env *env, struct bpf_reg_state *r
 	struct bpf_reg_state *reg;
 	bool rw64;
 
-	if (regno >= MAX_BPF_REG) {
-		verbose(env, "R%d is invalid\n", regno);
-		return -EINVAL;
-	}
-
 	mark_reg_scratched(env, regno);
 
 	reg = &regs[regno];
@@ -21953,6 +21927,14 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 		return err;
 
 	for (i = 0; i < insn_cnt; i++, insn++) {
+		if (insn->dst_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->dst_reg);
+			return -EINVAL;
+		}
+		if (insn->src_reg >= MAX_BPF_REG) {
+			verbose(env, "R%d is invalid\n", insn->src_reg);
+			return -EINVAL;
+		}
 		if (BPF_CLASS(insn->code) == BPF_LDX &&
 		    ((BPF_MODE(insn->code) != BPF_MEM && BPF_MODE(insn->code) != BPF_MEMSX) ||
 		    insn->imm != 0)) {
diff --git a/tools/testing/selftests/bpf/verifier/junk_insn.c b/tools/testing/selftests/bpf/verifier/junk_insn.c
index 89d690f1992a..7d10b0a48f51 100644
--- a/tools/testing/selftests/bpf/verifier/junk_insn.c
+++ b/tools/testing/selftests/bpf/verifier/junk_insn.c
@@ -28,7 +28,7 @@
 {
 	"junk insn4",
 	.insns = {
-	BPF_RAW_INSN(-1, -1, -1, -1, -1),
+	BPF_RAW_INSN(-1, 0, 0, -1, -1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "unknown opcode ff",
@@ -37,7 +37,7 @@
 {
 	"junk insn5",
 	.insns = {
-	BPF_RAW_INSN(0x7f, -1, -1, -1, -1),
+	BPF_RAW_INSN(0x7f, 0, 0, -1, -1),
 	BPF_EXIT_INSN(),
 	},
 	.errstr = "BPF_ALU uses reserved fields",
-- 
2.52.0

