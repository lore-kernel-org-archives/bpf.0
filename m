Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FAE2AE8D
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775110671; cv=none; b=eVp5J5FPXfZnfsAuunZyZrAW09IvyUJxT0cklJ08LTjTqv+poAEkDd2oul1RFUcS2iUXEdZmnkvxlqIkZ+hsEZGFx06o830S3CF5lxRjKHcmgNMuEJgzd+27/M88Vrld3FIzH9bfl6GPQssztNdVztYm6r8ghhpgnerEoUg4mQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775110671; c=relaxed/simple;
	bh=ICOm7SRfF51T6NB9HwxH/EDq4SZWQLbdXlbaLzDWnK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IgTaxjVSd70+lNaCxpamt9rTw3td2qQxi1S8rWYbpGN8y6ip1MPFUwWFPioR3mcXDLOjptBs5gf6Ygj9Ss17ejm2RkdOzHlvz9gI/0lUkZR6bnfo3yhs9SPf6vcCyMD54obwQUYANRAHr1EMYipIEf6/bY0K0lWXYzJUTCxc17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po2v8fv+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po2v8fv+"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35c1d101355so181731a91.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 23:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775110669; x=1775715469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66voDUVqfa1WT9lm//xs/hM1bmHKoUg/kMTrXgeZVX0=;
        b=Po2v8fv+H6rDdloDTJXZzYHc/HqwS97zG8E3zZ2PagnY6v8uNjpzarouKlmzXEoYWQ
         jLBL+GSYdv2ASm1GtmeiWcnzpZK8oS25qB4S/a8XQ+XkyFYMbMK5y/7xsEJWHDbwzMjO
         UamMiQWOY59ok0qWWmzm+mVXFKPB8Q7ieJ5Elpu/IdXdeXalJGkuMW5iPz/3Mrcw944G
         +OUaYPfktwh4vXiOZ7AfVEzFZqb+pFIuf2VoVWuAYCGvYvEAc2CLU27I87TLNRhS82yT
         A+UYpDmHoiaX0+fnGsDEIPi85rooa1YWsEfNREiypRnzNlAu6eIqAO4Qne8558lnD9s4
         J92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775110669; x=1775715469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66voDUVqfa1WT9lm//xs/hM1bmHKoUg/kMTrXgeZVX0=;
        b=SWMmyaZqE6LfVWI+xSjIYEv7jMuSmbdIekrgRgk9ktRp0Cv67U9lWLiChuws1ZHLyY
         ZnHNjwNyGsoIMsig5+46DjV3A1MOJl7BBZNQdgnYKfvLk+JJGmhW4r5WypxU09PbkcFw
         y6hxEiqkMeBOSJUqlmcHmoAg5qBo2nsfxBU5eACYp6gCpCnzh0FczBAEplzITDGiF8vX
         uzSYMD6q0R0vu5SqewrhzgeB1pmNSG38yea0g5xRDa9IOUJOWZyifs8RRRyC/FUqwpq+
         TYR5wqgmcc76uBqAMI2OYx056QYOKVi5Hw1UTFVhhZY9CNfzqcLFlJj83ueT0LX3XOeg
         GypA==
X-Gm-Message-State: AOJu0Yy6sJxvqA7hB1/LsacLpa/MWk1yHAFhmohtZePX/datuberbsvR
	izOXXnjJcZ1iRdhZpqzOvb9DMv8Jlj48Z/EsSUAKK4IvjZe7eOkB1iJgpCSjOQ==
X-Gm-Gg: AeBDievc/ZjFX+4eyIXKP11llEil9xhPBktfolTDJGi39pWs1EPxIEH8eW3SWyQFX73
	DzPFUlYYllLFvXp0Bt8J4KaQp6BRmiCrPCF8yekGjV+SV0BtmB6JJJ58W2cZTJfxb/13dyCC9fs
	J6OY+AKKw8uca6dgFZwo5+TvHEv7QoeTyVOLONbQ6hEgXij8KYWsSKeIlqkB8/rgbC0sgD5dWy9
	qKQfWwC7ng/I+GqII0iPoQZ56qSNiud9srHLvTL9WvEn8JvoWbCkylunM7N3eeWp/gpOZfs9tSx
	6lZvKAXRMab6N2OExlG4ZHWo0Hs1WDoL/A7O/wostPaukvqRxKJ5TVjMJMuKIL8ihH1FNHhLBxx
	sF/gmg/sR9bFnSP2Tp2Sxg0Djuupa9E8NB77eO4wxEoBAB3I7WAbBooEyouLH9aQFx4WhLws03w
	5jXuWNjlVrPgL1BL9rDuy2Z61+uDRI1IsaDhqP+you/vjwlk4UKGra7E0ZQ/OI3oFoPQECFDqCf
	XJBmSY+nd+AwZT3JAVlYdcxYjLwMW7Mr6fqyrpSU6LcZRBwA9b0r2INCAFAYw==
X-Received: by 2002:a17:902:e785:b0:2b2:4fc1:f657 with SMTP id d9443c01a7336-2b269a9ce58mr65267655ad.6.1775110668820;
        Wed, 01 Apr 2026 23:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497c0f3sm17217255ad.41.2026.04.01.23.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Apr 2026 23:17:48 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com
Subject: [PATCH v2 bpf-next 1/6] bpf: Do register range validation early
Date: Wed,  1 Apr 2026 23:17:39 -0700
Message-ID: <20260402061744.10885-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-1-alexei.starovoitov@gmail.com>
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

