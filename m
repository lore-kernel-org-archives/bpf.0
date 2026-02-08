Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86492C11F9
	for <bpf@vger.kernel.org>; Sun,  8 Feb 2026 05:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770528832; cv=none; b=VV/be1bZ3cVILxBsVZwdrtQxDw93nJTF9GODCwG4E8MpazTfeGVLa2uRwDqbLU3360p2t3lEDdfyvLT2+YrBFr/NyBbrCIcid46Z59R5e4U5k1izwjlmTB2f2cKb353IcF61hwOnYe+Soxv/gPsBrmbB2XOIuk9CFemvFkPsi24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770528832; c=relaxed/simple;
	bh=NdJfE6UGkldmnYF5SJP0QfORXRuqGjkBEOg/jafjqns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr6bg6zgd6iLYQhA+0uqbt9EOxA2GVRUGSn9LpSmsKUUG2/PLZT+9Ji/8bWi3KfwyBfhmN4dESp5MumnoaNGY8ZaCCgtfczado3bcSCqL1N2r1fq8z5j26XEDN6xJFpAaHSO8izI79HbGJevRz4QGGpbnd588k4lf0b+nQmmo5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwreA6id; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwreA6id"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-81e821c3d4eso2974719b3a.3
        for <bpf@vger.kernel.org>; Sat, 07 Feb 2026 21:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770528831; x=1771133631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uauA93iGE6XFs9gPgdNEdhBRsdXEO6OJ0ct51+bwGaI=;
        b=JwreA6idY1BlNaV5d+8ayDx3Z2DRsxd4NpIUri49PJTyMbzxJh+aDksR/gMhX6JAjE
         Pv18FNuStEo10nJ/01A34V9CsM7XPd3Jo+5LYgDf/ZJiWEdXApyRWZO7z9nqNCFspLOL
         I7rZr9NK5yodI5/tZ7IY8wwC480AtIHMxxYrR7PaxFsHrRSObP0/orloqz4iwQUzKx0M
         Fz4h+SQS3e0HEsWdwphh2BdINkenVgpYLiGTY/mUwTgPJ+lckt1w5Dw4Qdp94ygmA5T6
         7ppKGV+mjZqKMxtfYR3MBXOmGm5MZSq0qDRWR+Uc19XiHIaaB9LFvXXld1Z5EHoyZNrI
         rFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770528831; x=1771133631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uauA93iGE6XFs9gPgdNEdhBRsdXEO6OJ0ct51+bwGaI=;
        b=MZHmojE2lxYt7vedvOw8N3OYtn7eoggibpCkqJ1psdFN+bUup+u9UuxkNQYZ6QlP1h
         KlZmkhtzDPmC7wJJ79rZDzzUHAoFLN/nKmZDqpmyNFKoEYYxASFHwG6S1yTDJnaxUhAV
         C5mvHhA6tHIubWHjlz8lRv+4J6RWJE4010DA23tfUYxgKERAK3lh2JDC0BHUiA5YtXis
         9WlW8vd9cfo7Ywj7rFwe2Jh3uPWPUlD/vcvzZ0S2pohUQwnjqe/hpIFtIuw8xkE6Ib5c
         C0ml0gnQVYMl2EpURS+FGThO93sg8ftr6BlWO0Vrbph73u4Ym2klgJV2Xsef4lb8iTwl
         1xrw==
X-Forwarded-Encrypted: i=1; AJvYcCV2zZg3A8XeIvZCdgFkqID/+9YZgwrHlN+/kUywDE+F+HC5Pp3kyugOytdHYpcJNq8fK4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ggq5vlJCVcng5WRtMiVTe/9V5mUa+SY1dtLIsIkCwze/o99f
	XJCcKNM7gyEGEcjZYct1Uf1d6znfQsO3iS1HkY2CGwolh0cMBh15IqT/
X-Gm-Gg: AZuq6aK0Id2mkPGKiJ62Bn9SnE6zo+L0/fqdVOx3CbSCt68Zqx/sT05u6sS12eQ9vif
	VaOlOAvkeb5bGM/q9DeHjuRLBDAUaaBV24m09oXN7BAE9+N9I/5qRd1Gi1vcHpbYbGTniAZ7UmE
	qFECYc28S5UTL9eiExQsciOhDL175urfzRM24xB/qzoVqRUNSfQeemKcUILJqy/FId5GwVIL7vn
	Y3Jmz88V0ZSdglVRBw+7fAyZeYAaUAG4ulTfO6lTvmxcG9b9FvNl6nmGjhAO80MjYa+q9vGgf1q
	P70gJK7yWdijVAhiS7liXK7jiaN/5exxO06ImYxEToCoiGWEpIIJhm0ONisnc6JZzz5Zop+wD8T
	7VJKn40Evr2tDIQUvvRXRxwZz7TDJ0p691Esho00Vk8rOE5iMGV7bbQORjkSXQabwf5eEYb4a3Z
	+xMmb9o1DHNk2+3pTG6J0=
X-Received: by 2002:a05:6a00:3981:b0:81f:517a:56e7 with SMTP id d2e1a72fcca58-82441655315mr6790986b3a.30.1770528831225;
        Sat, 07 Feb 2026 21:33:51 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418de80dsm6067700b3a.62.2026.02.07.21.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 21:33:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	bjorn@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH bpf-next v4 2/3] bpf, riscv: add fsession support for trampolines
Date: Sun,  8 Feb 2026 13:33:10 +0800
Message-ID: <20260208053311.698352-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260208053311.698352-1-dongml2@chinatelecom.cn>
References: <20260208053311.698352-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement BPF_TRACE_FSESSION support in the RISC-V trampoline JIT. The
logic here is similar to what we did in x86_64.

In order to simply the logic, we factor out the function invoke_bpf() for
fentry and fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Tested-by: Björn Töpel <bjorn@kernel.org>
Acked-by: Björn Töpel <bjorn@kernel.org>
---
v4:
- fix the build error

v3:
- remove the "always" from the comment

v2:
- use bpf_prog_calls_session_cookie() in invoke_bpf()
---
 arch/riscv/net/bpf_jit_comp64.c | 74 ++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index e4f45e2e7e2f..f065b45e8d8f 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -996,6 +996,29 @@ static int invoke_bpf_prog(struct bpf_tramp_link *l, int args_off, int retval_of
 	return ret;
 }
 
+static int invoke_bpf(struct bpf_tramp_links *tl, int args_off, int retval_off,
+		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
+		      int cookie_off, struct rv_jit_context *ctx)
+{
+	int i, cur_cookie = (cookie_off - args_off) / 8;
+
+	for (i = 0; i < tl->nr_links; i++) {
+		int err;
+
+		if (bpf_prog_calls_session_cookie(tl->links[i])) {
+			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
+			cur_cookie--;
+		}
+		err = invoke_bpf_prog(tl->links[i], args_off, retval_off, run_ctx_off,
+				      save_ret, ctx);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 					 const struct btf_func_model *m,
 					 struct bpf_tramp_links *tlinks,
@@ -1005,13 +1028,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	int i, ret, offset;
 	int *branches_off = NULL;
 	int stack_size = 0, nr_arg_slots = 0;
-	int retval_off, args_off, nregs_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
+	int retval_off, args_off, func_meta_off, ip_off, run_ctx_off, sreg_off, stk_arg_off;
+	int cookie_off, cookie_cnt;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	bool save_ret;
+	u64 func_meta;
 	u32 insn;
 
 	/* Two types of generated trampoline stack layout:
@@ -1042,10 +1067,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	 *                  [ ...               ]
 	 * FP - args_off    [ arg1              ]
 	 *
-	 * FP - nregs_off   [ regs count        ]
+	 * FP - func_meta_off [ regs count, etc ]
 	 *
 	 * FP - ip_off      [ traced func	] BPF_TRAMP_F_IP_ARG
 	 *
+	 *                  [ stack cookie N    ]
+	 *                  [ ...               ]
+	 * FP - cookie_off  [ stack cookie 1    ]
+	 *
 	 * FP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 *
 	 * FP - sreg_off    [ callee saved reg	]
@@ -1077,14 +1106,20 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
+	/* function metadata, such as regs count */
 	stack_size += 8;
-	nregs_off = stack_size;
+	func_meta_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG) {
 		stack_size += 8;
 		ip_off = stack_size;
 	}
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
 	run_ctx_off = stack_size;
 
@@ -1132,10 +1167,19 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		emit_store_stack_imm64(RV_REG_T1, -ip_off, (u64)func_addr, ctx);
 
-	emit_store_stack_imm64(RV_REG_T1, -nregs_off, nr_arg_slots, ctx);
+	func_meta = nr_arg_slots;
+	emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
 
 	store_args(nr_arg_slots, args_off, ctx);
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all session cookies' value */
+		for (i = 0; i < cookie_cnt; i++)
+			emit_sd(RV_REG_FP, -cookie_off + 8 * i, RV_REG_ZERO, ctx);
+		/* clear return value to make sure fentry always get 0 */
+		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
+	}
+
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
@@ -1143,9 +1187,9 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			return ret;
 	}
 
-	for (i = 0; i < fentry->nr_links; i++) {
-		ret = invoke_bpf_prog(fentry->links[i], args_off, retval_off, run_ctx_off,
-				      flags & BPF_TRAMP_F_RET_FENTRY_RET, ctx);
+	if (fentry->nr_links) {
+		ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
+				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off, ctx);
 		if (ret)
 			return ret;
 	}
@@ -1192,9 +1236,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		*(u32 *)(ctx->insns + branches_off[i]) = insn;
 	}
 
-	for (i = 0; i < fexit->nr_links; i++) {
-		ret = invoke_bpf_prog(fexit->links[i], args_off, retval_off,
-				      run_ctx_off, false, ctx);
+	/* set "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
+
+	if (fexit->nr_links) {
+		ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
+				 false, func_meta, cookie_off, ctx);
 		if (ret)
 			goto out;
 	}
@@ -2094,3 +2143,8 @@ bool bpf_jit_inlines_helper_call(s32 imm)
 		return false;
 	}
 }
+
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
-- 
2.53.0

