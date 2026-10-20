Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792470822;
	b=jq8xA/jxEsu7dFFXZuka2WsEpF49qje4ey8gyQ4o8djkw770nGbLqrluU6i89lWHizSf
	 P0Bvpm104ON4kd/e1ukAwT1y9LOvwzBOdMmEJdVWfC+i7Sa/WXyr9FSbKeF6xQ7z6BqaM
	 brTOmp5hohs6iY8AsdLx07Seegb4G68BOemHZ+MtY7/1EMn7RSBqkvslWhA0sQPi36CPb
	 hKESm6Y4oTBM7X9y6+/IT/3fUD3/mupuDr1tfNt5x1Y3/PFeE7bHzQ3n8uZt8dJeRrKKk
	 BoG+x9v9dwC2q/oqzb5SzMx8D0N2zGAJk8jUTn0ysaBhkK9gR5Ww3Fi4IULktqKVCqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792470822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89FvP4NK72A0Z5tcFIioJBca4+6CQEWT6pDkwJpwKb0=;
	b=OXxxUosIAoYO5dC4Z8EQmwfYjnas+7HibvUVbEez0aVMGry/AHs3RAcFbHF5bMtWKtra
	 cwYMyF0+9pZGg8DWuDbNC62P0MJlzn9z446kf0o9+BZkdXdLzrTgEqAU5RpmC00RKaA+a
	 AjhYlQma575P0cUoLA5CZgQBQUahA6GL+Pc9jC65GIDBO6si+Ta30BlI0XvG87yrp4YPz
	 I+FhyWzRj4EuprR2Vrc/LAbBm8ZNUsgIBGOB30paogpLWhOZkXS9ZjfPXyprbtGyz5frV
	 nKv8b074bwGmCAH4+PbOa8vXofwavj8SjKAAvhyanvR+V+ZriamS60/B0OBL4iAvjNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UMjWFMyY;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2291606A31A
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 04:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2291606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UMjWFMyY
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1481233a91.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 21:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792470821; x=1793075621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89FvP4NK72A0Z5tcFIioJBca4+6CQEWT6pDkwJpwKb0=;
        b=UMjWFMyY7RXQVsC+u4Jmg/B8Dro+D2glbhnmJDetIdv0VTMDsTcBPyhBHy4TS7gINW
         mCr5BaS6umHH4ktPOZzHHFoTs2v5xUvFPOxcz7L0ng9hW3klQrcxzX4jzoixPUVZgRDQ
         X2ESwMlenGyZu8kq080I+YdUXxGOMvnbyB68y+1Yy1MDnJkMG/EjM1/2Ie/pyugUpI5H
         MrgS2MJfMnLomVEpAaG+oqn3agTqs78gnZ009LzgJx4a1XvHZe/vNy+ekzss7GHVnyop
         AwPN7T3gIFeN/r2G0Q7aOn7+Pw5P0/dfncNyCj7txcxlXvkBL+fwXVjKbGvgqpLK3aWm
         /mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792470821; x=1793075621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=89FvP4NK72A0Z5tcFIioJBca4+6CQEWT6pDkwJpwKb0=;
        b=Is3Mg8U83dfYqxxsIzbw34JyyN5KmJruFhDHgPFU76UPFw+xzTknwc3yvGpqUt+c3e
         I5letT2eoidG0kk7+bE5kwCQt5drQFo7Zx9Xt1Bq8m6Gl9VjASdpV3On7HO9T1KvR61b
         DhmDxFOew60usgsEe5p2DYXJxJJuy1LrPc8EMv64S/mBWvkCrLMn8j55QL1sxqFYkn5b
         0Xa+Qg8PZiWkboCJpd/jLnWxI18zW4y9xXyvvWC/LBw2RIuwooQCjysl2OA6/JWYsYNn
         3mS/lKGsIzLtamhh17RfIIw3VwFqrgTJD1e8z5Tpv2G4/xLKfH20Ryo5Q3vZ2F6eBFDI
         Yx/w==
X-Gm-Message-State: AFq9FYI4H5TF5UiVZ6oOtNu4hzuboURBsV6jhhjcDoj6nxOImqiRz2JL
	7aVGSaNsUmhkNQ9ug51I2vwS5N7LauiZ2YEVPP6TpqAeopu8wZx5MhQJj9FaZw==
X-Gm-Gg: AYBFou1tWi/H7an/zODkDqT+8f7i+upop3lH7TJzX+CJfUDZ0M+6tT9L7jLA6yibl4+
	m4u5PJGRSDcGBt53rH/YGq/dCAnehibT7z4CaDKdqcN63PTsT9r+AIDPDPv8zbH48REZ0T5bLah
	ECuj48+lxhRta8iNHIWlcqoF783PDA0j3xx8z+xPDpArsqCvOedXYjHedgCu+Q7qRx2Q52v62j2
	ytVBBPoboYMfgPlMxA4OWnx2aBvTVoAkskCouweskTezKRoz8GiK8ekMopqtrGt8FeM1FzJVUdo
	Ztw/QRBZEInSdTsZjbCuLpcLf+2EBgYJ0Zueu4e3+Q0eZ8l/SKyEr2hXqQ/YdK4MLhOqlqUkUEp
	8ymcK3llVFuuX8z5k/0cxl4Gu1gKgTXnfLFrMTzorj9YKqJ31KPpVtUJJv3sNHkEwROWdCQx54n
	jlENGUMztvXfbY7RXB+wUgs4Vc7A1cZX5Sw7EiPpRGBARyuafROqABoNBKHZLOOzjpk7KH+pvmO
	4XjbCmOkTcBWqHTn7uXCr1rbvnTwGUX3HowxzWPe8M6hoc/zW/GcJt4pa7ysopVo06XhKpcSWrr
	MRLyRALFZYHNMeXw74lkFoXgaThE10mLA2d7yj/DtWc=
X-Received: by 2002:a17:90a:2cf:b0:3ad:4a8b:c6fd with SMTP id 98e67ed59e1d1-3ad4a8be0bamr1887002a91.28.1792470821012;
        Mon, 19 Oct 2026 21:33:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd05c9255sm9652102a91.2.2026.10.19.21.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 21:33:40 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev
Subject: [PATCH v3 bpf-next 3/6] bpf, arm64: Support unwind_goto and unwind_exit
Date: Tue, 20 Oct 2026 04:33:16 +0000
Message-ID: <20261020043319.3031996-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

  bpf                         arm64
  call inner                  bl inner
                              mov x8, x0
  unwind_goto pad
  w0 = w6                     mov w8, w19

Like on x86 unwind_goto is an extable entry and no code.
unwind_exit returns to the pad past 'mov x8, x0'. That's fine: r0 is x8,
and the epilogue of the callee copies it to x0 and leaves x8 as it is.

unwind_exit fixes LR in its frame record. With pointer authentication it's
signed with SP at the entry of the prog, which is FP + 16:

  stp x8, x1, [sp, #-16]!
  ldr x17, [x29, #8]
  add x16, x29, #16
  autia1716
  mov x0, x17
  bl bpf_unwind_target
  mov x17, x0
  add x16, x29, #16
  pacia1716
  str x17, [x29, #8]
  ldp x8, x1, [sp], #16

So the lookup gets an authenticated address, and autiasp in the epilogue
checks the new one. autia1716 and pacia1716 are hints like paciasp and
autiasp: nops when the cpu doesn't have pointer authentication.
RET is not subject to BTI.
r0 and r2 are what a subprog returns, so x8 and x1 are saved around the
lookup.

Like on x86 unwind_exit of the main prog is exit, unless it's an extension.

The private stack pointer is in a callee saved register. Unlike x86 there
is nothing to undo after the call.

Tested in qemu with -cpu max and -cpu cortex-a72, i.e. with and without
pointer authentication.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/arm64/net/bpf_jit.h      |  2 +
 arch/arm64/net/bpf_jit_comp.c | 93 +++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
index b2fe6e6dcf44..50029dd9baa6 100644
--- a/arch/arm64/net/bpf_jit.h
+++ b/arch/arm64/net/bpf_jit.h
@@ -316,6 +316,8 @@
 
 #define A64_PACIASP A64_HINT(AARCH64_INSN_HINT_PACIASP)
 #define A64_AUTIASP A64_HINT(AARCH64_INSN_HINT_AUTIASP)
+#define A64_PACIA1716 A64_HINT(AARCH64_INSN_HINT_PACIA_1716)
+#define A64_AUTIA1716 A64_HINT(AARCH64_INSN_HINT_AUTIA_1716)
 
 /* BTI */
 #define A64_BTI_C  A64_HINT(AARCH64_INSN_HINT_BTIC)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 1d5f4cf88d33..45ed69b83265 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/bpf.h>
 #include <linux/cfi.h>
+#include <linux/extable.h>
 #include <linux/filter.h>
 #include <linux/memory.h>
 #include <linux/printk.h>
@@ -1221,6 +1222,85 @@ static int add_exception_handler(const struct bpf_insn *insn,
 	return 0;
 }
 
+/*
+ * There is no branch for unwind_goto, only an extable entry
+ *   { .insn = ret_addr - 1, .fixup = pad - ret_addr }
+ * where ret_addr is the return address of the call in front of it. unwind_exit
+ * replaces LR in its frame record with bpf_unwind_target() of it.
+ * ret_addr - 1, because what follows the call can have an entry of its own.
+ * No insn starts there, so a fault cannot hit the entry.
+ * 'bl foo; mov x8, x0' is in front of unwind_goto. The pad doesn't miss the mov:
+ * r0 is x8 and the epilogue of the callee copies it to x0 and leaves x8 as it is.
+ */
+static int add_unwind_exentry(struct jit_ctx *ctx, int pad)
+{
+	int ret_addr = ctx->idx - 1;
+	struct exception_table_entry *ex;
+	off_t ins_offset;
+
+	if (!ctx->image)
+		/* First pass */
+		return 0;
+
+	if (!ctx->prog->aux->extable ||
+	    WARN_ON_ONCE(ctx->exentry_idx >= ctx->prog->aux->num_exentries))
+		return -EINVAL;
+
+	ex = &ctx->prog->aux->extable[ctx->exentry_idx];
+	ins_offset = (long)&ctx->ro_image[ret_addr] - 1 - (long)&ex->insn;
+	if (WARN_ON_ONCE(ins_offset >= 0 || ins_offset < INT_MIN))
+		return -ERANGE;
+
+	/* switch ex to rw buffer for writing */
+	ex = (void *)ctx->image + ((void *)ex - (void *)ctx->ro_image);
+	ex->insn = ins_offset;
+	ex->fixup = (ctx->offset[pad] - ret_addr) * AARCH64_INSN_SIZE;
+	ex->type = EX_TYPE_BPF;
+
+	ctx->exentry_idx++;
+	return 0;
+}
+
+static u64 bpf_unwind_target(u64 ret_addr)
+{
+	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+
+	/* The verifier made sure that unwind_goto follows the call */
+	if (WARN_ON_ONCE(!e))
+		return ret_addr;
+	return ret_addr + e->fixup;
+}
+
+/*
+ * unwind_exit: fix LR in the frame record. It's signed with SP at the entry of
+ * the prog, which is FP + 16. The x16/x17 forms are hints like PACIASP: nops
+ * without pointer auth. r0 and r2 are returned.
+ */
+static void emit_unwind_ret_addr(struct jit_ctx *ctx)
+{
+	const bool ptr_auth = IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL);
+	const u8 r0 = bpf2a64[BPF_REG_0];
+	const u8 r2 = bpf2a64[BPF_REG_2];
+
+	emit(A64_PUSH(r0, r2, A64_SP), ctx);
+
+	emit(A64_LDR64I(A64_R(17), A64_FP, 8), ctx);
+	if (ptr_auth) {
+		emit(A64_ADD_I(1, A64_R(16), A64_FP, 16), ctx);
+		emit(A64_AUTIA1716, ctx);
+	}
+	emit(A64_MOV(1, A64_R(0), A64_R(17)), ctx);
+	emit_call((u64)bpf_unwind_target, ctx);
+	emit(A64_MOV(1, A64_R(17), A64_R(0)), ctx);
+	if (ptr_auth) {
+		emit(A64_ADD_I(1, A64_R(16), A64_FP, 16), ctx);
+		emit(A64_PACIA1716, ctx);
+	}
+	emit(A64_STR64I(A64_R(17), A64_FP, 8), ctx);
+
+	emit(A64_POP(r0, r2, A64_SP), ctx);
+}
+
 static const struct bpf_jit_arg_abi arm64_arg_abi = {
 	.nr_arg_regs		= 8,
 	.even_reg_align		= true,
@@ -1806,8 +1886,16 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		if (emit_bpf_tail_call(ctx))
 			return -EFAULT;
 		break;
+	/* unwind_goto. The verifier expanded may_goto. */
+	case BPF_JMP | BPF_JCOND:
+		ret = add_unwind_exentry(ctx, i + 1 + off);
+		if (ret)
+			return ret;
+		break;
 	/* function return */
 	case BPF_JMP | BPF_EXIT:
+		if (bpf_is_unwind_exit(insn) && bpf_prog_can_unwind(ctx->prog))
+			emit_unwind_ret_addr(ctx);
 		/* Optimization: when last instruction is EXIT,
 		   simply fallthrough to epilogue. */
 		if (i == ctx->prog->len - 1)
@@ -2466,6 +2554,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
 
+bool bpf_jit_supports_unwind(void)
+{
+	return true;
+}
+
 const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
 {
 	return &arm64_arg_abi;
-- 
2.55.0

