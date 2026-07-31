Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27533B6BFA
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785524882; cv=none; b=ojpkNoTUJqVpX+pbirTZZh/w6BJTHlIcKWdB0X6u4JDMYALzZswn54M0pI7/5UFBin0OSqzN3JZOzBVZ1CMrwCajg2cBIINneedcZqj46ty7xLb5BmzWvjPVz/yNJ260SYj7oGDZfPxxSDJbcXAlZRFHvltNdxrluye9fqG514c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785524882; c=relaxed/simple;
	bh=HP95oeqnVr1xhsWJv+QXMmxNKSl7vSBkRXGzioI4iLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpXvcNMnSgZvwW5vMKVq4zZ8/Otx/aRIycrn4mOZfizGCiOr2OxeK1qRcVZluoxwlVP9UfJzDpneWi9cTNMiRANNBk0ojJ1eLdvnWTzRP4JLqbtTrVsloqtT6g/lckxvuiUhSgYEfvmwkJ9RFW1VVcKodv8fDHXAMtspDTCArUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwsATogR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwsATogR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1028094a91.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785524880; x=1786129680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aY5U/dqsa3JkIEqamygtuvId49OwkWQIQQA8GiXFvyk=;
        b=QwsATogRbIMk1F/YpT9NVpmEWSlLoNPnHK9Zj5oSZ7ndM+6KSgHJkO5rcAIoiwRo4X
         Sr5w4ta3q30WGXZDmUm6IjeU2YfasB8Z4WzyGs066ycqpEqpK9znSvsxqj0pQSjHyA+z
         idmF6cIlx2YZ8HWKkfDpoxz024pLdvRlLFe+T5vR0fKK5607/iaY8FFEXINTngG6xFNZ
         oiE1YYDNjNNAxYCu0+I8lJYWwnRIq2vhOPTVJYP4ZCpU4NUDkW2LWoYNnPfmpn/jIBHz
         WAFz8F1v7A0ZHOOgfvG2GdWdPC7u0rLD4OP61qwJMg/91ZGcZf2N1bGriM2z/BZFJMew
         AurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785524880; x=1786129680;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aY5U/dqsa3JkIEqamygtuvId49OwkWQIQQA8GiXFvyk=;
        b=WngygbnGgzaINt3ZRmHUEHWst9DzTq+kBzOseQ5SeaqB9ZNqNfSTN9kvZMNcQn0Tf8
         tKddU68QdEbMpSDp/uvfGqwgSxsUHiUOHD1Q4854HHxfAOHKePDSQAJmvYfDqkArQMs/
         hbgjeVJq1LKYsF6Qu3m76q5s8F00OcvMLvNuYfnSNL8a1MsMFaW02YDCU1+oymifMx5N
         tIyomeKR5qnaH+O4tkfht7PE0kcZgYb/KwGtvOwdqDufYaC0cq4rZcYPkZTYLuRMNfp3
         e1FuWvu2fdaHulhtDe5bJVJjDGe4FHg30/HbBCGodW1HpD+LIs0nQgbg9O8SXN6aSQm7
         JWrw==
X-Gm-Message-State: AOJu0YzOLC23opnudDRyEyZ5mNRgE7tM/JQO3edZIbrZFuCILFpjqmUq
	8FGDHTSXfOKl5xb4NqL9y/NuT9/Ss0hQgCVfLmHlRQR/144gSNRUcB4GGnVBNQ==
X-Gm-Gg: AR+sD11bSxaL8Gs76d1J7n5L5LotVbq8ltU4hPOo8M77Q/WbKh0VLxcoflOq1E5jeyn
	yqHJPccK4AwX/EZvOySTfuOzTcOkk3bJueXiBF0QeLYwV3XfiCmdkXs+0CuIdvZUmw8uUR3+rXK
	Ewd+jMG0kQeVRsDonwH4V1DMRVvyfWhfCqBZZC5+fM2Jej0zirYMZWre4G8j4w3RzQ3elEYr6zI
	ktEHmDvMbu//b5p4Dc5jfRldzuUOay++HQEIdvppgvEvCCbzKKj1RYjLEmorQt2k+e8kCvUK4eW
	NHuLR9ZKZjGdWaAFG+p9F10/7ZD6d5eOfPyOFpbTTnxb1PmTlwvQ8wO4pST8zc214R0tmiOvW0v
	g2mX123MbY4WfiW4QgBM459/3xDGTlKZ2O2V4IxYkFY0M3uG5w1qeSrcjBU876JqG8ks6iCps6h
	9ouNhbsZoHDHAub1bCsq6MqOsKH/Nxyd3MbiOVIGSoI2dO1yqDldiD+sEUqd5oG5VPWTnlNjkUM
	WKzcHAWEKMXNrT/0Cw91UZKHNZ3JtUenIBDupIJysDO
X-Received: by 2002:a17:90b:3bc8:b0:38e:6497:ca45 with SMTP id 98e67ed59e1d1-38fbc59b19fmr794053a91.39.1785524880177;
        Fri, 31 Jul 2026 12:08:00 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab13255esm4815801c88.3.2026.07.31.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 12:07:59 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	iii@linux.ibm.com,
	gimm78064@gmail.com
Subject: [PATCH bpf-next 2/5] bpf: track upper 32-bit register halves' liveness in compute_live_registers()
Date: Fri, 31 Jul 2026 12:07:43 -0700
Message-ID: <20260731-static-zext-v1-2-98a4dc73e94b@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
References: <20260731-static-zext-v1-0-98a4dc73e94b@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Extend compute_live_registers() to track upper and lower register
halves' liveness separately. This is mostly straightforward:
- use/def masks are extended to track 2 bits per register;
- compute_insn_live_regs() is updated to properly track these
  2 bits according to the instruction semantics.

The only quirk is kfunc call processing logic, where we follow the
verifier.c:check_kfunc_call() and verifier.c:mark_btf_func_reg_size()
and infer whether the upper half of the parameter register is used by
the call based on the parameter's BTF type size.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 include/linux/bpf_verifier.h |   2 +
 kernel/bpf/liveness.c        | 119 +++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c        |   5 +-
 3 files changed, 93 insertions(+), 33 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 682c2cd3b844..d4bffed94e0a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1050,6 +1050,8 @@ static inline struct bpf_subprog_info *subprog_info(struct bpf_verifier_env *env
 }
 
 struct bpf_call_summary {
+	const struct btf *btf;
+	const struct btf_type *func_proto;
 	u8 num_params;
 	bool is_void;
 	bool fastcall;
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ff1e68cc4bd1..c996b8a03e79 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2047,29 +2047,67 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 
 /* Each field is a register bitmask */
 struct insn_live_regs {
-	u16 use;	/* registers read by instruction */
-	u16 def;	/* registers written by instruction */
-	u16 in;		/* registers that may be alive before instruction */
-	u16 out;	/* registers that may be alive after instruction */
+	u32 use;	/* registers read by instruction */
+	u32 def;	/* registers written by instruction */
+	u32 in;		/* registers that may be alive before instruction */
+	u32 out;	/* registers that may be alive after instruction */
 };
 
 /* Bitmask with 1s for all caller saved registers */
 #define ALL_CALLER_SAVED_REGS ((1u << CALLER_SAVED_REGS) - 1)
 
+static inline u32 reg32_mask(u32 n) { return BIT(n); }
+static inline u32 reg64_mask(u32 n) { return BIT(n) | BIT(n + 16); }
+static inline u32 mask_widen(u32 m) { return m | (m << 16); }
+static inline u16 mask_lo(u32 m) { return (u16)m; }
+static inline u16 mask_hi(u32 m) { return (u16)(m >> 16); }
+
+/* Infer use mask based on number and sizes of the function parameters. */
+static u32 call_use_mask(struct bpf_verifier_env *env, struct bpf_insn *insn)
+{
+	u32 i, use, size, reg_params_num;
+	struct bpf_call_summary cs;
+	const struct btf_param *p;
+	const struct btf_type *t;
+
+	if (!bpf_get_call_summary(env, insn, &cs))
+		/* e.g. a bpf-to-bpf call, assume that calls use full 64-bit for each param */
+		return mask_widen(ALL_CALLER_SAVED_REGS & ~BIT(BPF_REG_0));
+
+	if (cs.func_proto) {
+		use = 0;
+		p = btf_params(cs.func_proto);
+		reg_params_num = min(btf_type_vlen(cs.func_proto), MAX_BPF_FUNC_REG_ARGS);
+		for (i = 0; i < reg_params_num; i++) {
+			t = btf_type_by_id(cs.btf, p[i].type);
+			if (IS_ERR(btf_resolve_size(cs.btf, t, &size)))
+				goto fallback;
+			use |= size <= sizeof(u32) ? reg32_mask(i + 1) : reg64_mask(i + 1);
+		}
+		return use;
+	}
+
+fallback:
+	/* by default assume that calls use full 64-bit for each param */
+	return mask_widen(GENMASK(min_t(u8, cs.num_params, MAX_BPF_FUNC_REG_ARGS), 1));
+}
+
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info)
 {
-	struct bpf_call_summary cs;
-	u8 class = BPF_CLASS(insn->code);
-	u8 code = BPF_OP(insn->code);
-	u8 mode = BPF_MODE(insn->code);
-	u16 src = BIT(insn->src_reg);
-	u16 dst = BIT(insn->dst_reg);
-	u16 r0  = BIT(0);
-	u16 def = 0;
-	u16 use = 0xffff;
+	const u8 class = BPF_CLASS(insn->code);
+	const u8 code = BPF_OP(insn->code);
+	const u8 mode = BPF_MODE(insn->code);
+	const u8 size = BPF_SIZE(insn->code);
+	const u32 src = reg64_mask(insn->src_reg);
+	const u32 dst = reg64_mask(insn->dst_reg);
+	const u32 src32 = mask_lo(src);
+	const u32 dst32 = mask_lo(dst);
+	const u32 r0  = reg64_mask(0);
+	u32 def = 0;
+	u32 use = U32_MAX;
 
 	switch (class) {
 	case BPF_LD:
@@ -2080,8 +2118,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				use = 0;
 			}
 			break;
-		case BPF_LD | BPF_ABS:
-		case BPF_LD | BPF_IND:
+		case BPF_ABS:
+		case BPF_IND:
 			/* stick with defaults */
 			break;
 		}
@@ -2089,7 +2127,15 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	case BPF_LDX:
 		switch (mode) {
 		case BPF_MEM:
+			/* a narrow load still redefines the whole register */
+			def = dst;
+			use = src;
+			break;
 		case BPF_MEMSX:
+			/*
+			 * sign extension defines the whole register;
+			 * src holds a pointer, hence is used as 64-bit.
+			 */
 			def = dst;
 			use = src;
 			break;
@@ -2107,12 +2153,19 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 		switch (mode) {
 		case BPF_MEM:
 			def = 0;
-			use = dst | src;
+			use = dst | (size == BPF_DW ? src : src32);
 			break;
-		case BPF_ATOMIC:
+		case BPF_ATOMIC: {
+			/*
+			 * dst holds a pointer and is always used as 64-bit;
+			 * the value operand and r0 are read as 32-bit for BPF_W atomics.
+			 */
+			u32 srcv = size == BPF_DW ? src : src32;
+			u32 r0v  = size == BPF_DW ? r0 : mask_lo(r0);
+
 			switch (insn->imm) {
 			case BPF_CMPXCHG:
-				use = r0 | dst | src;
+				use = r0v | dst | srcv;
 				def = r0;
 				break;
 			case BPF_LOAD_ACQ:
@@ -2121,10 +2174,10 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				break;
 			case BPF_STORE_REL:
 				def = 0;
-				use = dst | src;
+				use = dst | srcv;
 				break;
 			default:
-				use = dst | src;
+				use = dst | srcv;
 				if (insn->imm & BPF_FETCH)
 					def = src;
 				else
@@ -2132,6 +2185,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			}
 			break;
 		}
+		}
 		break;
 	case BPF_ALU:
 	case BPF_ALU64:
@@ -2145,14 +2199,14 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			if (BPF_SRC(insn->code) == BPF_K)
 				use = 0;
 			else
-				use = src;
+				use = class == BPF_ALU64 ? src : src32;
 			break;
 		default:
 			def = dst;
 			if (BPF_SRC(insn->code) == BPF_K)
-				use = dst;
+				use = class == BPF_ALU64 ? dst : dst32;
 			else
-				use = dst | src;
+				use = class == BPF_ALU64 ? (dst | src) : (dst32 | src32);
 		}
 		break;
 	case BPF_JMP:
@@ -2174,17 +2228,15 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			use = r0;
 			break;
 		case BPF_CALL:
-			def = ALL_CALLER_SAVED_REGS;
-			use = def & ~BIT(BPF_REG_0);
-			if (bpf_get_call_summary(env, insn, &cs))
-				use = GENMASK(min_t(u8, cs.num_params, MAX_BPF_FUNC_REG_ARGS), 1);
+			def = mask_widen(ALL_CALLER_SAVED_REGS);
+			use = call_use_mask(env, insn);
 			break;
 		default:
 			def = 0;
 			if (BPF_SRC(insn->code) == BPF_K)
 				use = dst;
 			else
-				use = dst | src;
+				use = dst | (code == BPF_JMP32 ? src : src32);
 		}
 		break;
 	}
@@ -2249,8 +2301,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
 			struct bpf_iarray *succ;
-			u16 new_out = 0;
-			u16 new_in = 0;
+			u32 new_out = 0;
+			u32 new_in = 0;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2264,8 +2316,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		}
 	}
 
-	for (i = 0; i < insn_cnt; ++i)
-		insn_aux[i].live_regs_before = state[i].in;
+	for (i = 0; i < insn_cnt; ++i) {
+		u32 in = state[i].in;
+
+		insn_aux[i].live_regs_before = mask_lo(in) | mask_hi(in);
+	}
 
 	if (env->log.level & BPF_LOG_LEVEL2) {
 		verbose(env, "Live regs before insn:\n");
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6123e7e4a320..8304452edc0f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16730,10 +16730,11 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 	int i;
 
 	if (bpf_helper_call(call)) {
-
 		if (bpf_get_helper_proto(env, call->imm, &fn) < 0)
 			/* error would be reported later */
 			return false;
+		cs->btf = NULL;
+		cs->func_proto = NULL;
 		cs->fastcall = fn->allow_fastcall &&
 			       (bpf_verifier_inlines_helper_call(env, call->imm) ||
 				bpf_jit_inlines_helper_call(call->imm));
@@ -16754,6 +16755,8 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 		if (err < 0)
 			/* error would be reported later */
 			return false;
+		cs->btf = meta.btf;
+		cs->func_proto = meta.func_proto;
 		cs->num_params = btf_type_vlen(meta.func_proto);
 		cs->fastcall = meta.kfunc_flags & KF_FASTCALL;
 		cs->is_void = btf_type_is_void(btf_type_by_id(meta.btf, meta.func_proto->type));

-- 
2.55.0
