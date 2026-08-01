Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0481C395DBE
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 01:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785546609; cv=none; b=Nk7uvQ/fe7ZZ0sP8jNGHohx+Z3YAxdGmlWH98pWuitiiD8UBV41EkpKvF9MwUXQ8GZjc9PrNfnVYODv/S3qoZ6dattrAuiBs4PUHTNdkdI0X1i9V5zNqGQ+Ghnl79KZ+ZdSxldFFVXYDxJLTmksaNBsJt5HPpjEmqMf6ypzYu3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785546609; c=relaxed/simple;
	bh=O4sqdXWDu7AQMxPnEgxnMkipAS/cOw7AnbYAM0EIpgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XP2HfoC+OAptLB+5xwroO6XkC5kTuFpmruW4CjkCn9v+h0hJ3+/KhgSNNjiCNLq/5tI80hPV15BsFgiPHDFocy70y/Exg571sXRa4xS30CTbcS2n/7SiEojo08Elj8cJffK1wNRru2I5tzAvtPJfRdYX0S5TEGQiCtiIOawUatQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb+4xI8s; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb+4xI8s"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so962312a12.0
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785546607; x=1786151407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c+fvhUqxNrvcBjyIC+idb7/r/ZAWzlNLaXiPWaqxxUw=;
        b=Mb+4xI8sEir6apdrqSNnQeFGbKRRivAY/SxwS4UghWkR7WT0elj+tao5UlM4mKYn35
         UYsqhpvjwzWoa926bvooCuxG+NsHy2I4ZvSVrmxAABTAzpKRxAlRCNp6OHSMu008K5x2
         RlGjLQQtY1UwYjZ3895hsBrAg1xRM9pCwE4NmU17xRrIvn29/v42XVzjiEwCjfbO9WRQ
         9eXBZTRXOlgCrM9nW3JrNdu5gFi2vQ8u8GBaHcuPizLKQvKhRPjLIkrRCu+n8bTH9FN+
         cCcrqXgYkoLBGzl9FVYWMIxgEVRKs6qdkJWkZVS65Apqh6kvWPEUzu7NebCbEzmB61k3
         Nfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785546607; x=1786151407;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+fvhUqxNrvcBjyIC+idb7/r/ZAWzlNLaXiPWaqxxUw=;
        b=EYgcHr9tTcqyxmxLahYV680xpS3DbXczVijg1HRpRoF4oa8X8p6r4jQZ7tRQqWttX1
         5IY4rfpjlDxvq7MKo6c0vhEVUJoP/milw10KHXPXRbIzIMBah1yiMSjHOdyk0fsT95mh
         k5Gy61o8QnQDvL1oAkLteLwzilAydOEsRMVz1SRQmm5Uq3jtzX2sTfgA/sx68RcJ6srB
         bdTFBsMmAN/zPfG9PNkeLgYAJ8mBQhWIR4bIoRluLTWwXFgnvj6yd1gcxp/6o01OWTe2
         h93WvRlFp9hiMV23vJD6DsnqZ0XVOusfpJELdLWen4948qxUDPC+azg24lp/ru2hJoE3
         lmFw==
X-Gm-Message-State: AOJu0YyJHY2d9q24nj+kZRhN4DO51k1h73PB8PwZeDQUD/1gN2/WnDW1
	CkyU6ROFZTSlpDqSei0JAO+GrNtaIoIAzqlU7nk0yacqlxRTeq0hmWHmx2PNoDa/
X-Gm-Gg: AR+sD12ggvzdcwnCENqHCiePSpUuA7O5MNdp+h8mOZTuHK8K2bc0wXs5JgEmJ3Mf7WB
	QvRmWYcl2kZ+HHt8EZtM3ULrFScSrvDDyKuMA9V9Td+Ya76YX96bDWhFwNBMmBXtIpnlGF98xMB
	z+m/mM5ClUghhUv5/FsCqv+p+xF6BbI/NBNwJoHuIwQ2ai5d1hAV6D3R2oWw5jSR6yXOQ5euTs5
	1zMk6MqFHNA1wZaH0VGda4b4SwCjFBeaxWvyBzAKhp+dYrSHA1ULEV9CVd2aF8FPNTYyN6BjGot
	d9UXqSHTkrlmJK5gwJFEwQXKAHxDqwgpLVW3a+ofU35yHSKbtPbXmqw4YAwuRLxoANZL9LGZEBg
	TIe/D3W0KYadxqeJWk45ylelXw9CkXm+9Hm7IQ8hmUXLm/xJ5MEIVWGxp/PMHCtp7TOhUtqc1Y4
	gdseQLJDTDbC317P9ZdIkxU8s0W6Fw5pAt3AaCQYBMgRXFVylAdKYw5WVpk1mEpLAb0AxkePseg
	pehQeXtKnPmO3bIS3GCieS71avMvWr87xcqv9ORE+x0
X-Received: by 2002:a05:6a20:7484:b0:3c3:7195:fd47 with SMTP id adf61e73a8af0-3c91a9020e5mr3903779637.24.1785546607191;
        Fri, 31 Jul 2026 18:10:07 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:7346])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e29a126sm11234052eec.31.2026.07.31.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 18:10:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/5] bpf: track upper 32-bit register halves' liveness in compute_live_registers()
Date: Fri, 31 Jul 2026 18:09:50 -0700
Message-ID: <20260731-static-zext-v2-2-da4aa161e8c5@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
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
 kernel/bpf/liveness.c        | 124 +++++++++++++++++++++++++++++++------------
 kernel/bpf/verifier.c        |   5 +-
 3 files changed, 95 insertions(+), 36 deletions(-)

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
index ff1e68cc4bd1..d0bd94c60fee 100644
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
@@ -2174,17 +2228,14 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
-			if (BPF_SRC(insn->code) == BPF_K)
-				use = dst;
-			else
-				use = dst | src;
+			use = class == BPF_JMP ? dst : dst32;
+			if (BPF_SRC(insn->code) == BPF_X)
+				use |= class == BPF_JMP ? src : src32;
 		}
 		break;
 	}
@@ -2249,8 +2300,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
 			struct bpf_iarray *succ;
-			u16 new_out = 0;
-			u16 new_in = 0;
+			u32 new_out = 0;
+			u32 new_in = 0;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2264,8 +2315,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
