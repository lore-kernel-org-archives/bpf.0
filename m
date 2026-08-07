Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711B36896D
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136405; cv=none; b=XCK6NWX3qq+4J1tq6cyfwwCsLp6+UuiTC4ENnfVt/xdMZb8HtYQL4vAd5k8W+UifePeiLVNVeCwzaAEiQa+6PExF2My8w7uv3onUjPg5GgI5tuA+PfVRBp9YUfspEsYbBo01+PkG1y4Kh9Ms5dQ2+I2Mvi95Bsn7ThbfGooyecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136405; c=relaxed/simple;
	bh=3TKALwOCKJ3ipMjMEi/g7jA88to5igyfH95zY1QfxgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwT6OiTZ1Fh1rPQhb9l7xk2YmlLQgLtzjfQxTmxmydLvH4pbg3OGJSckYIfpZvDr9se2By/oIksGT+u5tjo75jpJ+u0G8nf2n32qEliuV5xdLd93/NMN0Kpduk5y/fCNdnWYtayz7C9udfIOj4Y2mTwMRjBXTPdxSmCVFQq7qDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbzV/5Aj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbzV/5Aj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso298285ad.1
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2026 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786136403; x=1786741203; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CdZa85gJfYH6H1+xLuhjn/AzyWROQHnBYBz1VB8OUs4=;
        b=mbzV/5AjQ2GH6aq5/t5BCfJ15sk4yxtEybvmTXdpLC2vZxB8/I0EnB9dXEGvQ1V+9h
         RMC1COWlwcuDYSg+8g3qfOmXDMlT1Mt7yBDqCq1Lu6d5gI/x5JLnRMo6bIDl+w9vdDea
         Q5fVGy5+oztrCBpSAQPGV4ivjCvmNtr+Sr1hnkUNdKIYXRmiDteshy46n0gKdjWbS6+b
         pTjFT6rErNybS2foT+sAhiWC0YB4NoUruOjMaV1CG51zGpYMa5F6BDeqi2WIGCrWVrd2
         Xfuc4A6Pn3AqsZXXJHMmNikQ3mprODihXfQ3Y11N6GG8/CVFsT/rPs6/7q6YtJrwMoFu
         zcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136403; x=1786741203;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CdZa85gJfYH6H1+xLuhjn/AzyWROQHnBYBz1VB8OUs4=;
        b=rg0QDZ6bvWKsaPl/4wyhrZV78eryk+1JK/rVKMK+Xl0UFhzmH0fIpTvc/BuWM/sFCN
         NYeh/YIFjsiIwAlA52ja+N7nEvR+z5A5F3IvjAGZhMdz/271L8BQKW1ut42Qp3arw2yy
         aSHAZCJNhsyLNeeKea0Iz8ZfSEXxY3MeN3EIYdlMSZqy4uR8w7VTYhEW48JiVrLLxQGQ
         FrU7Q6FVK7eEcbm70q3KstgAUTHHaYl5VQX6jJ8k0bsjsoTQ8WdTBIW7JiUiH8ierMzx
         Z7IMrQVal/LZpGHoatJ9zxJdrJBNDzKeIv4pmgY4y3cRzsj9SG9wkSKJyn6tSHMapmf7
         GYyQ==
X-Gm-Message-State: AOJu0YyBMRvNxcXPwg1mApSF/tNQhMkV5mQ/YPCyw4sxIEPGJ6486gTX
	Sdo3WfeSd0zRSzGeby5exR8KQCb+hOaeWsiWUL+T5cRVTYDVefgS6dAPyoeFLhCQ
X-Gm-Gg: AR+sD11EWbxnCXdKlEe0A8pbEGgnfIgZmx5h7TkIkrozhLy8UcUebPh+odtrFiS+ami
	iYw9zk5U5SP6b6zIM+izjT5zDVWnDYNOMByv9N9HoswHNLTrwGFAsYeVagjYWgocaFLsH6sH/iV
	5/dALeWpc2eeq4mAw26l0rL7Bp5O7GiCgakDJJoikJpmS6Y4b1o4xmss5P9yyVuIy8HBxEzdPGZ
	JqZrjOqa+ZJ7agalTicMu5TqBBPg2Kc3f4TptNy2UkAfD8ugdWDxXb7yoMgBnDycomdfBOSaT0l
	3aHgGi07+6eK+kGu8fFWghpQkdlgV90pYe+/9diGXdAXEbyqwz5iKWTYJNWNNJlNz1d5TCZOFda
	MASgfyXI7iZCf5PBvHVtTGbVl5Ox55GENoYH7sBj07+LQJUhZztvvP139psPxhbHZQLzC4Me/3/
	ZWJ2gxmLRn9IXstOHivpbbC+U4i/ptq7+JBaURqoTEfw6xwONfJz5WmSgq/F9c507EpP2xAJRHM
	Hn/ahwbcN/xd3pkvi/u2ZnnHFXcKRi1bp97SKRHswAh
X-Received: by 2002:a17:90a:d2c3:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-3908361a861mr11804821a91.7.1786136403129;
        Fri, 07 Aug 2026 14:00:03 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::5:1cba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm9799783c88.4.2026.08.07.14.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:02 -0700 (PDT)
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
	gimm78064@gmail.com,
	info@starlabs.sg
Subject: [PATCH bpf-next v4 4/7] bpf: track upper 32-bit register halves' liveness in compute_live_registers()
Date: Fri,  7 Aug 2026 13:59:33 -0700
Message-ID: <20260807-static-zext-v4-4-b6c270013c77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
References: <20260807-static-zext-v4-0-b6c270013c77@gmail.com>
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
index 784216d834af..cc97f008d977 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16703,7 +16703,6 @@ bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
 	int i;
 
 	if (bpf_helper_call(call)) {
-
 		if (bpf_get_helper_proto(env, call->imm, &fn) < 0)
 			/* error would be reported later */
 			return false;

-- 
2.55.0
