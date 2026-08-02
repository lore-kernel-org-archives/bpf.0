Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8726F2B0
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 20:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702277; cv=none; b=CaCL/Uc5FBQmKww5l4ZxJO0/eq86JT2bnnvVsmjIYCqd0xm3s3rXDlxpQYCeyKldYt4jDZly6CvoAwkLqXTe6ldI2XVtkIXY1CxT2CrmOBKU8NwmpmTajrz88hVOx6PTRam/FbDvOE3t5kAafmRx1l2YQxGMLGwVk7rodlhwrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702277; c=relaxed/simple;
	bh=6o86MKCj6ByToELSO7Q4NkfGkdDUtrIKg9LbjdOWtuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9Od4oM/aLf7st7SnhNAGwOxOE7VAIDvIclYV/3dQsqe5evR64uq7kF6HA0k+0S8GCNpMUyFSQV0/25ueC14umT0FR9mwGAyVaQtnduCb/HKot10CrKRz/H3EeT3CIJ5IXXFbVEhjertkcRGYQomnvVvjW5CZkD2tTfJcM32gJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKeWPqKH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKeWPqKH"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf50c6f235so30044955ad.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 13:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785702275; x=1786307075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PZdPoti1zP9J40yq7PC2nnHEEAtir07WjZpdt5U6Xls=;
        b=BKeWPqKH4635DLzhKXuRuFrc9MZqwe2b92aIpvNng6M+S3tymLRpqXBJ5W0+ILvuLx
         L7jBzbiljd2xpNZybs3s+8hcBF4lpaZJHXGefOs359GLFh5IUybqeo+yL4b0EwzDc6D4
         q7XH9HI5VrtT+JF4o6Szi54infFn7YYNNC3iGHeP1Gaez5rvR5oDuixPKjcbSvqbXgJd
         nRVjz6Lamo/teYusx3zUXtI04vPdwZlxctr10niLCA5bnjRIHkDkE0p7ntRwAHE8ZItt
         ckFTFM4WrmxXa+WQAUMqoLypvG5GC0bW8nFCciIB2ukjv4U/mEjz7HZJ36H+AoNPYlG/
         RvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785702275; x=1786307075;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PZdPoti1zP9J40yq7PC2nnHEEAtir07WjZpdt5U6Xls=;
        b=gfS3T1UMJ6rrpyUo3DRtJe0rRvTWcexio3bglA1yX0z7UMWEYgywdwiGsqIaXyG0EI
         SBGzwvxrbW7hXr9DXc0zw6EOUmdXi3nDLzy6E+yu5rKsCQZzYxlQ0cXgUKZ/F2tCZ19/
         uJ4wCWxfg1/Fc2Uq6E39P6yzj/wQJqe8DFGK9ECJreKafK86upImdmf9FW6fG36aOCFL
         r+7Y0aefjFGwuKHrAShVNNiDMTcNU3rbpuFhu81HOq2AouFUyAsbRobeLwA+L/XMrCVc
         IMAY/Rzg9mLrCLEwJcoNwOWigkg29qTvjvwkTflTRbr33BAlDDaI/9o3UnbmwnMfzRCx
         CDZA==
X-Gm-Message-State: AOJu0YxJ5raN0/iHvHIBhfzd59fyRh6oncTmIy+wZvj30vPTwPgU9Chr
	qy23ani9c0qiP87FKysmqczw/eG7PsdZ6bDK7kGWXgUroUg0d8rkEzxRfTRQpg==
X-Gm-Gg: AR+sD11UQvfaht+whFlIhG/e1+SldROkiXrkn6QhOXYwT0Qf46l6LXbpymL7aTdnNo+
	61YgF6U2rvuEBD7sMp1qcVyPH4z1uLYzG3WtRv/Ht4tdcr6cfuMtdSePBGASIH9gO6r1Fpk51gF
	SvCYi5sE5A7mgegQsh5t/CIDedXE45/+fNdgtNZZF4Zn5GhikEFv9CnqqiVAn2xzgb+5AA7Bxg3
	9zeRj7GC+Mg/8kbuBCZT8VzAbIobFv/+gFTxtYXR2BDTwSPr6fCrRLHNo61gM2DoBQgxef6GgLq
	vHrsvNnVigSEYUtxXNpLM6Srxd3os0viJ4xO9bq/dmtZ+FQZz1t4dxO34dU4iRO4B8g/jHC1hro
	C1ZVkZXM90+VGhRuAq/DJxKKbCYpNf6/zIRETteax54XDVUzNLvn8yCApsMA/9jqT45g5KZ9u1C
	UCj1+OrJl/Q4Fxrdpjsn23kiPaPRPz49VbXSXuDfAxFTxuFMyWM/s+wZGOxTj22nutSQ95l4gUh
	fXR4Q==
X-Received: by 2002:a17:903:2ac7:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d0521eac7amr75192305ad.3.1785702274737;
        Sun, 02 Aug 2026 13:24:34 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0ea128sm28590865ad.40.2026.08.02.13.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 13:24:34 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	iii@linux.ibm.com,
	gimm78064@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v3 2/5] bpf: track upper 32-bit register halves' liveness in compute_live_registers()
Date: Sun,  2 Aug 2026 13:24:18 -0700
Message-ID: <20260802-static-zext-v3-2-3456b2604574@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
References: <20260802-static-zext-v3-0-3456b2604574@gmail.com>
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

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c | 89 ++++++++++++++++++++++++++++++++++-----------------
 kernel/bpf/verifier.c |  1 -
 2 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ff1e68cc4bd1..edfc2480b0f0 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2047,29 +2047,38 @@ int bpf_compute_subprog_arg_access(struct bpf_verifier_env *env)
 
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
 /* Compute info->{use,def} fields for the instruction */
 static void compute_insn_live_regs(struct bpf_verifier_env *env,
 				   struct bpf_insn *insn,
 				   struct insn_live_regs *info)
 {
 	struct bpf_call_summary cs;
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
@@ -2080,8 +2089,8 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
@@ -2089,7 +2098,15 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
@@ -2107,12 +2124,19 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
@@ -2121,10 +2145,10 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
@@ -2132,6 +2156,7 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			}
 			break;
 		}
+		}
 		break;
 	case BPF_ALU:
 	case BPF_ALU64:
@@ -2145,14 +2170,14 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
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
@@ -2178,13 +2203,14 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			use = def & ~BIT(BPF_REG_0);
 			if (bpf_get_call_summary(env, insn, &cs))
 				use = GENMASK(min_t(u8, cs.num_params, MAX_BPF_FUNC_REG_ARGS), 1);
+			def = mask_widen(def);
+			use = mask_widen(use);
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
@@ -2249,8 +2275,8 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 			int insn_idx = env->cfg.insn_postorder[i];
 			struct insn_live_regs *live = &state[insn_idx];
 			struct bpf_iarray *succ;
-			u16 new_out = 0;
-			u16 new_in = 0;
+			u32 new_out = 0;
+			u32 new_in = 0;
 
 			succ = bpf_insn_successors(env, insn_idx);
 			for (int s = 0; s < succ->cnt; ++s)
@@ -2264,8 +2290,11 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
index 6123e7e4a320..896bc5aaaaaf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16730,7 +16730,6 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 	int i;
 
 	if (bpf_helper_call(call)) {
-
 		if (bpf_get_helper_proto(env, call->imm, &fn) < 0)
 			/* error would be reported later */
 			return false;

-- 
2.53.0
