Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3393B389F
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165343; cv=none; b=Ba5kROf6D0WOBOLaOVaSTyB9zDXILOa6/UQQWcY+sdQvbDVTqDMzETO2MxjqIRACUEa+mYNG9x+v+NShWEvJCItc4zE6GPF0wYPmClcBuu9GCA96syJ9EaIcQuN8CCLNWR8oOGt/HzDzDWjPdBeWK7RggA4f9yIIGmYHt4ZmrEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165343; c=relaxed/simple;
	bh=eH8zojZ3+sx/3ZMQPcmY+N2BAA63nZmLajpUHyqna60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPWDmRIv++8WUzTI0JIEQPW5Uh9VNP01ytwwUfPJCrYdGN3zbfr3JRkO30VsqiNVB9/9gacoGPCPI8jRl/TPXCXFmvhBY4XFf/+tBEuona7ZvEhCEWhISqlhPQSK7f+htqwD/xLj0PfnBcVh8LgPw9xtUC+SI0wOqCZzKHyhlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxEaCvl7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxEaCvl7"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2addb31945aso9786225ad.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775165341; x=1775770141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=XxEaCvl7T5kyts9zy6C4KzE4nT4D4gwydcK+ErJUrHY0EZrsSmrjHv8oa5X2NEHoY7
         QPvfZjr8z/i4E1LoV2byHH/Do9/1fzxAc3OXRtKmlSEqWwvmVu257pWCMM6K4DEMqszf
         sbsbQ0ZCc5lT60K1UG/uc94KIHivCLPc8gTf4OWwKKkiz8jVcPTMeHCX5Kh/uwQqB5Z1
         oLnNFs0+GS366jjEYYttB6/7TAjqcKkVoKePyTiVMfeHWqr2qnIHrPIoyeox32qy2zV6
         CRBfLuJMbjg9WFLcyk6QqngURo+TwToRKx3BrBLCJjxi+udcNByPwc+EQkmP8Ie0yjwp
         gePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165341; x=1775770141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylTMPo7C/Mxi4W2xEwrnAvHsgYE+KYb+qesL2j3kHoc=;
        b=fC8RtQSk2BiBS46yCq3asJXep7V9AY2DGaHZJTLeu6NiT5O1LKFmSJKjHYmWSLlE7y
         Bizb9w1zaZ0mpqzw7WO9Pf54v9ujIOowl7QfhgmwPMD127mW5BmegAaLC/nGbvNxlSF7
         qxmjupmMlFDGW+dZPPAr70tvSji+3cKR9jSSWLnGGY4DOhV0HZEwXmYU8j+hhN6Taddt
         JE3SD/t+DZss0GTOp/F9ggal9DgJD5dS01sBwYLPmCECD1bxdQMciAayLvIEfT2A1/eR
         Iu30lZw0J8LpCqRREkW4kiluLGOTXVW7jcJMUjUidwvW+j/+SqbubSgsNZeXScC+D5MG
         ZNZg==
X-Gm-Message-State: AOJu0YzzmDL+mGy5eOkW5sZTltg552brNkYNYXagqvv353sDck0RU2sY
	544g02uePAS3dpmq6JOEUh88EP0XSaL1qFYmpCp2C67b64NkaPfBJ/kv+yLujA==
X-Gm-Gg: AeBDiesJBvcEtr3EwZSHlQ0MSw6g0gTo+BNwEJU/kuov2GZra9DKoyuIEVCfHpNxdFa
	1Pkts3roD5hAbKt9wBuxKh0Or4VTSDH5tXJXZEziHMCHCqyHuoOsMHW71j/7r5aHnJLOToehijO
	UytcawQtTS/Q4PeHxJiKf87C3M/pig4LA36Ed7JFsOhQzTtpcwWw7q9N3/F0MXlWNoXI3vma4aF
	QvH6WSqmR11BrrnOugjuYSgiIl44HNqhz/2nxK0h09Frw+eUlMIw6Qk8NJCK6NQNUY1lpgqX29X
	XJFsi4Jqn7xwjSE7d3cPKUXGEIkHnezSl74lIXKv2Fpt2siXqXh7ejnKd0HESvJObGDehlkUFc8
	rBdIfUB58BYI9GYQ/nF4OsXxo3sGi46teyw9V92W+G60d2sa8LoYNc49sYWR9y/LQUaLkE0AGfr
	LjE1bnYVu1y2VDx3QvwkLKvpjDTqE8ej/eNKOA/OxevZtAWd3PyABgkDD4+G3xr8y9YvkD1rBG4
	VMLU25SMNz5ac/1zHgQxfFeuch8lHItK2TUORKm/oPM0TJ/gFUSKUEhVHdu+jeFXrqyQtIu
X-Received: by 2002:a17:902:ef4f:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b281999af3mr7025605ad.45.1775165341102;
        Thu, 02 Apr 2026 14:29:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478b658sm41419065ad.31.2026.04.02.14.29.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Apr 2026 14:29:00 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v3 bpf-next 1/6] bpf: Do register range validation early
Date: Thu,  2 Apr 2026 14:28:51 -0700
Message-ID: <20260402212856.86606-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
References: <20260402212856.86606-1-alexei.starovoitov@gmail.com>
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

