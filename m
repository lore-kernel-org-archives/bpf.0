Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2711D6DA9
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 23:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776900269; cv=none; b=D4SIoQD8OLd/c67X4u3/IiNwwS3O5PqoNEa9gBRylt9kU+LohpzdZZ97jZ2QGRNHFR09BfgOSOV1HX0Nf8queoVIHMBGv2RuninbmlsL6itt/oqVwY4LbUTp+Qz3GcF5lIh/DZauX7Z4q3JNW4C/PXpCnxQiDWn0RmxJrb4bQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776900269; c=relaxed/simple;
	bh=2SD7C06aIlY+PlgvKSyFuJ3iRHdIBT/MB46iapy6m7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kd58I5kIp+bpvxDRDxlMkoTIDw2Ki5xAE/Xs5n66zZxEvVfynLbSSyUp0Q4XHc/X7Bh682CHk7eIef2Z+8uN+Hs37e4DoPuozzRFa7GuOUEGEdZyydVH+WyC80ryP2cpaorDkwGTWWJ90wQ+Exrol6hjBeBeNveHyd/E8vmdxLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2ACrQ3J; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2ACrQ3J"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c741692db4cso1839766a12.1
        for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 16:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776900268; x=1777505068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0R2qmTyepTiJeg+SaIo8gF0Yv8AkGZOmj8L6mypNCv0=;
        b=j2ACrQ3JIIhTnY/64EO6FFbBbzZyDQOfdyF3p1Qg75/4HFaAsrxqYVKrgimYBiy5o+
         5WHN9rik+Jf1chUKZOiUGpdGeTPK8iwL7UxBsKOFn9GY3+jA0eawbfRbzhsnK90rawL5
         JqySPhvy+8sUGX+8PVJO6aLT98bOLBHiGaNDEpiHrNuxegeB1AKjJV2T5wOMVvXYlviZ
         Ml87l45XXOGHI+pW/FbLEQQAbNuqvRAf+xw8VSeODfbobsj6L+uTJUR158GWampNAPIa
         v3TNj6VSivJuAS1GhnkVOUCGnplG42kcs8q51hng7MGYMAKusmsAXlXb1L0dmNmokS6M
         stEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776900268; x=1777505068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0R2qmTyepTiJeg+SaIo8gF0Yv8AkGZOmj8L6mypNCv0=;
        b=husQr8zEHDZbSE2YHZuKiRfGZNn4YupEunfoF6WnZ5gPQWeDmuozMzWTfKdO6QgBnl
         MMFQl4uiNEM0DZYLqMdY3VnzdewdQ9yvNq30PEIhTCrfg4hyvFpVmPap1pWXdVqd+zgl
         DrnkNFfwNRoESwbchV/7viTnoTapdWqLZd7i2SoWgid2G811rNnSyGW068haiQwUoY3S
         q0MvwPawn+fpbDgzUkdsJb060ZCocpIzGJe8ru2+x7b7AlaE4ry6Pt3nWkcrQ2mp5RP3
         s9K/S6e+RyS1smz5sVmyRkC8rbUiF4S0lSc/3rzN1XoFSHgghY8FJ0TjtecijPl3CS4P
         PJjg==
X-Forwarded-Encrypted: i=1; AFNElJ8o6ODoMVuOU6wPKYLCd8t6tbzOcLAsidr9az2rZari6rz8Szdanm6o+PNINaLCUE7FFKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAa4AQmYmSpMkH7Af1MXb3nJp4YZC6CvCYhvurUZWkpl0MAeO
	LTufyMWjGdU6KQWsspl778cFydlqdxRPsgrFoLURJSz5YC2OS7/S078C
X-Gm-Gg: AeBDieseTgagyFDqOv5bFtdvgtMDr00HWs84cKpc76gCbUvGqYuc/As4MovwuWGkyiV
	qQOnbNqLm/Uzk5kqZSc+ll4fSto7LboeBZSdhwYbGPcETRACXSM96WN4ZkPTnvg0IKCT7SN4gO9
	jgg4X8TZY1/B62PujuvgTQmwk7HXUpAKGCY2C8urqHFRl+ngjZZc3yQJ3QXTKYcdgdKfHF8pV5e
	iSI/MDCpYC+p1KqlF6ZzkD2kyaWIaHLk+NCXPbQtpuy02rnaFcOUyKEWj7yvtY4ECgUyVyGM4DJ
	djtCroQ1+4omtQH+wVO0pP+VjPnXe8OTBWHxKYvi/PQ22qVuMxGZGEcufBVMDVn5bu6ZTHHCVSZ
	qYvHuD700cTFqEqPe7CCyTK/Hmi6FyqBa1+3fnBb7z62/c3J4wGm1WjRKnbhmC20FdxUEMxTDBz
	5XsXWS2uIF4o0lknUmkeuqvG+tsLONhoTvWUqyjjbRHg==
X-Received: by 2002:a05:6300:6d04:b0:3a0:babd:b959 with SMTP id adf61e73a8af0-3a0babdbda5mr11656873637.9.1776900267918;
        Wed, 22 Apr 2026 16:24:27 -0700 (PDT)
Received: from VM-0-17-ubuntu.. ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f920e1sm13776248a12.2.2026.04.22.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:24:27 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
X-Google-Original-From: Hengqi Chen <chenhengqi@outlook.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	menglong8.dong@gmail.com
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 2/2] LoongArch: BPF: Add fsession support for trampolines
Date: Thu, 23 Apr 2026 07:24:07 +0800
Message-Id: <20260422232407.3862942-3-chenhengqi@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260422232407.3862942-1-chenhengqi@outlook.com>
References: <20260422232407.3862942-1-chenhengqi@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hengqi Chen <hengqi.chen@gmail.com>

Implement BPF_TRACE_FSESSION support in LoongArch BPF JIT.
The logic here is almost identical to what has been done in
RISC-V JIT.

The key changes are:
  - Allocate stack space for function meta and session cookies
  - Introduce invoke_bpf() as a wrapper around invoke_bpf_prog()
    that populates session cookies before each invocation
  - Implement bpf_jit_supports_fsession() callback

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 77 +++++++++++++++++++++++++++++++-----
 1 file changed, 67 insertions(+), 10 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 49dd3e1fedfe..5c4871adeb0e 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1737,6 +1737,31 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	return ret;
 }
 
+static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
+		      int args_off, int retval_off, int run_ctx_off,
+		      int func_meta_off, bool save_ret, u64 func_meta,
+		      int cookie_off)
+{
+	int i, cur_cookie = (cookie_off - args_off) / 8;
+
+	for (i = 0; i < tl->nr_links; i++) {
+		int err;
+
+		if (bpf_prog_calls_session_cookie(tl->links[i])) {
+			u64 meta = func_meta | ((u64)cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT);
+
+			emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, meta);
+			cur_cookie--;
+		}
+		err = invoke_bpf_prog(ctx, tl->links[i], args_off, retval_off,
+				      run_ctx_off, save_ret);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 void *arch_alloc_bpf_trampoline(unsigned int size)
 {
 	return bpf_prog_pack_alloc(size, jit_fill_hole);
@@ -1789,13 +1814,15 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 {
 	int i, ret, save_ret;
 	int stack_size, args_off, stk_args_off, nr_arg_slots = 0;
-	int retval_off, nregs_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
+	int retval_off, func_meta_off, ip_off, run_ctx_off, sreg_off, tcc_ptr_off;
+	int cookie_off, cookie_cnt;
 	bool is_struct_ops = flags & BPF_TRAMP_F_INDIRECT;
 	void *orig_call = func_addr;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	u32 **branches = NULL;
+	u64 func_meta;
 
 	/*
 	 * FP + 8       [ RA to parent func ] return address to parent
@@ -1813,10 +1840,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	 *                   [ ...               ]
 	 * FP - args_off     [ arg reg1          ]
 	 *
-	 * FP - nregs_off    [ arg regs count    ]
+	 * FP - func_meta_off [ regs count, etc ]
 	 *
 	 * FP - ip_off       [ traced func       ] BPF_TRAMP_F_IP_ARG
 	 *
+	 *                   [ stack cookie N    ]
+	 *                   [ ...               ]
+	 * FP - cookie_off   [ stack cookie 1    ]
+	 *
 	 * FP - run_ctx_off  [ bpf_tramp_run_ctx ]
 	 *
 	 * FP - sreg_off     [ callee saved reg  ]
@@ -1859,9 +1890,9 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	stack_size += nr_arg_slots * 8;
 	args_off = stack_size;
 
-	/* Room of trampoline frame to store args number */
+	/* function metadata, such as regs count */
 	stack_size += 8;
-	nregs_off = stack_size;
+	func_meta_off = stack_size;
 
 	/* Room of trampoline frame to store ip address */
 	if (flags & BPF_TRAMP_F_IP_ARG) {
@@ -1869,6 +1900,11 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		ip_off = stack_size;
 	}
 
+	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	/* room for session cookies */
+	stack_size += cookie_cnt * 8;
+	cookie_off = stack_size;
+
 	/* Room of trampoline frame to store struct bpf_tramp_run_ctx */
 	stack_size += round_up(sizeof(struct bpf_tramp_run_ctx), 8);
 	run_ctx_off = stack_size;
@@ -1929,10 +1965,19 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -ip_off, (u64)func_addr);
 
 	/* store arg regs count */
-	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -nregs_off, nr_arg_slots);
+	func_meta = nr_arg_slots;
+	emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
 
 	store_args(ctx, nr_arg_slots, args_off);
 
+	if (bpf_fsession_cnt(tlinks)) {
+		/* clear all session cookies' value */
+		for (i = 0; i < cookie_cnt; i++)
+			emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -cookie_off + 8 * i);
+		/* clear return value to make sure fentry always get 0 */
+		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval_off);
+	}
+
 	/* To traced function */
 	/* Ftrace jump skips 2 NOP instructions */
 	if (is_kernel_text((unsigned long)orig_call) ||
@@ -1949,9 +1994,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 			return ret;
 	}
 
-	for (i = 0; i < fentry->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
-				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
+	if (fentry->nr_links) {
+		ret = invoke_bpf(ctx, fentry, args_off, retval_off, run_ctx_off,
+				 func_meta_off, flags & BPF_TRAMP_F_RET_FENTRY_RET,
+				 func_meta, cookie_off);
 		if (ret)
 			return ret;
 	}
@@ -1995,8 +2041,14 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		*branches[i] = larch_insn_gen_bne(LOONGARCH_GPR_T1, LOONGARCH_GPR_ZERO, offset);
 	}
 
-	for (i = 0; i < fexit->nr_links; i++) {
-		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
+	/* set "is_return" flag for fsession */
+	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
+	if (bpf_fsession_cnt(tlinks))
+		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
+
+	if (fexit->nr_links) {
+		ret = invoke_bpf(ctx, fexit, args_off, retval_off, run_ctx_off,
+				 func_meta_off, false, func_meta, cookie_off);
 		if (ret)
 			goto out;
 	}
@@ -2336,3 +2388,8 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_fsession(void)
+{
+	return true;
+}
-- 
2.43.5

