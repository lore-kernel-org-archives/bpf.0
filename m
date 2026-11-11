Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401868;
	b=1vVWo1K07O8g8HjeWGZZaeM0RuVrxpAhTbR9RpeWC7rtoI4x+PDnCl3ky/vdm8/3g8Et
	 DgH3u7ROi4/J2Qp4evRAtRD7+2bOK5K+eCRl38slE96RUOuX0c1vbDR4e0b1fzBCiOSs5
	 Ne+2qkFoy4UNXoXkwQSnmOQce+tW7moKEFU/01fVK1C4y3ff0o2+XTx6F9AA8Kq5D4bVj
	 6wr+fuZNtrywKfUIojIdhW+q7FRsS9rHb5j6F3Gfxf7UhDy2b0f8Ua+J5sykEczR+ZwGs
	 TVUfjqzyTk/CT/6Fryozwah5Pvo6p2CRNbNa65wRLXeweo9CjkwNPDtuRM4bbEBxEeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401868;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=xMTN3mgG7LpdF0eM6BaFHa8gHHxSmkyxjKGJ5W5Kcvs=;
	b=UpXUC6JKalrG6pTs5WxbdXJ2Fw2A41EG+F6s5PGr1RXCh8SoxVZ/o7cY482aYXT5Yy8y
	 kj45mrNFDvI/eUtBzjfrDhLPs49u+p0Uuf0yqqRRsKkRE8LtL3Nmudsv4r3gDyX0132Lo
	 W+PDs6EJlSXipkmumRbtBpuO963/f6ec6KP3NYfc5TstJBO3pN5gT4ugnSeVXgSLTRlbP
	 MnvqP0iTUgFojjzsw/U9f04IIfdCA9v2hkmh/vU2S/DJvrpWxnltqpb791yEjqtCD/EBJ
	 IX47Nr1wqpoYoVPxH+w1zZeGxvWZy+lffNpv9EjqkORJqLDfAG3QB0WBZJAj/pnRUfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sk3oqeT9;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347A606A330
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1347A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sk3oqeT9
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b76ade741cso12338745e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401866; x=1795006666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xMTN3mgG7LpdF0eM6BaFHa8gHHxSmkyxjKGJ5W5Kcvs=;
        b=sk3oqeT9/nCm2qIAPsVXyu78Mvly4dOqwxgf6gpE92TqH1+28oY0KJbCvMhYr+JlxF
         4LLaE9tr+rIm1X47l8Uwxp8PmICWG8dSddLdOM1QjvVXImbKhlwpEUmD9bRpm/IZDtVT
         bXG/MziO42cF/XnXWoYIbHzb8aeDPkoxNiJkWfxP4uxi4AooNhdjgdEWOTRK6Rg62iSM
         Skbs72AksgevsJ6ze4i4WCzl0DoWGMQ0D0FZH50m8jyUyuO64LQeZaS42eV4m6sfOYJd
         WpRDSKVgO8ngc4VlfCTHQtT0NCpEfB/bdSVCMjWfQtXiz6v456iMKUSq/WjBpHLb9F49
         2lNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401866; x=1795006666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xMTN3mgG7LpdF0eM6BaFHa8gHHxSmkyxjKGJ5W5Kcvs=;
        b=1PP6hJ/U6rrRi/4zSIUXzNTUZIdhuVSAnn/HLtkT+RPqTOs0qWDjGRIENpIUfYrDFY
         PLFyfMjAFQv6ioG3XdEsfNUhfcGi6MIQK3MArMsJHrZoMtJHK3+Dp6Sw2L5WLMWpEUwK
         ToM77FXuYtthWLb9KzoKVSaeIKDrouR8irLmAj68f+56TuemNdvgpwUrdt/AQ8OUeUsg
         wFa20ZE8oZitAKMMLfulJjlXNcYUCB2hSUvJFc5TEzgvM4WqpKCx/emLYqvfVtkq7We2
         cD8kn/dxe4TYZw5t98d2J8aCO3/+ZXi0XaQYCm++jnu136Ls5bZo4kfudOgna2zNSMb+
         U9JA==
X-Gm-Message-State: APuU4Z/t3BTxm06KteGWaIbvw3kMsP5QoqWpNwH/SmD38M5D6jXwdMNi
	cefonWWNyTLjzcy8O1NdMcIOGf8yL3RofMLt5XbDUanqPU5VOx+CCxJBmGPW14nyRMI=
X-Gm-Gg: AYBFou32dJq66/BJI09MiuW0WD/xpZOHpvQ+5hjLy1hdZZgx2JYUTh8Pi8UJPFxvx1D
	aRbBepqDO6lVCOF7mO0klqb73zWnFrJHiNjIDVTBQvHGeza+uoeBXTy2hTAcTECQl9zqB0LZ2Qe
	2IKykLUNXz6XUgQ6b/RTvskhUcy2s+qhkgsZHU/zOfTu+Nb4vqOfpMmviCzzhkhO2/ZZ3fnMOd3
	x+sUCuQSifTxpDV2pl2/nUfTlifFRKnjRNMTDdlhmyoj6h1wdvKUy1JQt6vPeGch7Oaulzquffu
	scF1g5GlGNw8/PaQbRvUVbA2cddeHa69kWv31odlUeJczuijALGDJ+/f7acsG23J77KcHk1khj5
	tpoDvyje7jI+gqAmBeWnR/vfiPveFQkOmbzGkhpFQv3gV3cZOhDCjQBrNxMQ1wz7KphNd0kL8eg
	G7HgnGJYdKoZv4E0uHyAHdIA1lA9kor47bz6edY86Y2HexrwdMPpDwV/xQ+na/c7XIK7YyxLlYf
	t+0RzPkKMr+tuQGgd1F8wSPFEGeS7jJJORjEhUQkcHi/HtLmv7cZ6raD7nW8VcCYhkXWYYczgcB
	i7EzniQDm8VF4zy3yaVrxA5P+/uC5b+Llc3JYbpYw/p8gbB9JV33ui+DptCzZqeEE6s8b9yPPWN
	maCNivrPUAqCBBAvrybWhk82A7srGNjJGtgGTNSBKiItYIUCNqHs6blkQcJ7Gk4BPp0Wz
X-Received: by 2002:a05:6000:2508:b0:48e:6f84:2e8e with SMTP id ffacd0b85a97d-499c6cac68amr4593460f8f.39.1794401866430;
        Wed, 11 Nov 2026 04:57:46 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835d2c05dsm10747969f8f.25.2026.11.11.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 10/29] bpf: Record where JITed frames keep the BPF stack
Date: Wed, 11 Nov 2026 13:57:08 +0100
Message-ID: <7fa155ff502e01de86f30c53f842c6050a98ac65.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5413; i=memxor@gmail.com; h=from:subject:message-id; bh=3KSk1hg7TTy8rz/3lC6ZI91MO4XPDiL7aot3vidZyiQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzPz+Lg6rBQpye8pyn/3bY9J+VbdUUo/9SxznmR8JU wO53zV0lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLMwYwMt/fe5yy803R5yzHl +39i93hETReWFgycZROyzqTapfjBBEaGdt7S1UH7CnuOxdX2pOTW7H+ov6bq6dQiOyeP6RoPl6v wAAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

The unwinder will release resources that a frame keeps on its BPF stack.
The verifier gives their locations relative to the frame's R10. The stack
walk reports the native frame pointer of a frame, and the position of R10
relative to it depends on the architecture and on the stack that the
frame uses:

 - On x86-64, R10 is the native frame pointer.
 - On arm64, R10 is the stack pointer after the frame record, the tail
   call count pair and the callee-saved pairs are pushed. This is
   -16 - 16 * ceil(pushed / 2) below x29. Record the distance as
   frame_fp_off in the program's aux data. x86-64 leaves it 0.
 - A frame that uses a private stack keeps its BPF stack in the per-CPU
   private area, so its R10 is not derived from the frame pointer. The
   JIT knows that R10 is a fixed distance into the per-CPU private stack
   of the function. Record the distance as priv_frame_off.

The arm64 JIT sets up R10 only for a program that uses it, but records
the distances for every program.

Add bpf_jit_supports_exception_cleanup(), which tells the verifier
whether the JIT records these. The other JITs that support exceptions do
not record them yet, and keep the rule that bpf_throw() must be reached
with no resources held.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   |  7 +++++++
 include/linux/bpf.h           |  4 ++++
 include/linux/filter.h        |  1 +
 kernel/bpf/core.c             | 10 ++++++++++
 5 files changed, 38 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c9f851bd5003..418bda24020c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1055,6 +1055,16 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	/* Stack must be multiples of 16B */
 	ctx->stack_size = round_up(prog->aux->stack_depth, 16);
 
+	/*
+	 * Where the exception unwinder finds this frame's BPF stack: the
+	 * private stack, or below the frame record, the tail call count pair
+	 * and the pairs push_callee_regs() pushed.
+	 */
+	if (ctx->priv_sp_used)
+		prog->aux->priv_frame_off = PRIV_STACK_GUARD_SZ + ctx->stack_size;
+	else
+		prog->aux->frame_fp_off = -16 - 16 * DIV_ROUND_UP(ctx->nr_used_callee_reg, 2);
+
 	if (ctx->fp_used) {
 		if (ctx->priv_sp_used) {
 			/* Set up private stack pointer */
@@ -3904,6 +3914,12 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
 
+/* build_prologue() records where each frame keeps its BPF stack. */
+bool bpf_jit_supports_exception_cleanup(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_arena(void)
 {
 	return true;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9b7466ca1a82..9170cbe3fa16 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2425,6 +2425,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	priv_stack_ptr = bpf_prog->aux->priv_stack_ptr;
 	if (priv_stack_ptr) {
 		priv_frame_ptr = priv_stack_ptr + PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
+		bpf_prog->aux->priv_frame_off = PRIV_STACK_GUARD_SZ + round_up(stack_depth, 8);
 		stack_depth = 0;
 	}
 
@@ -5066,6 +5067,12 @@ bool bpf_jit_supports_exceptions(void)
 	return IS_ENABLED(CONFIG_UNWINDER_ORC);
 }
 
+/* On x86-64 R10 is the frame pointer; do_jit() records where a private stack has it. */
+bool bpf_jit_supports_exception_cleanup(void)
+{
+	return bpf_jit_supports_exceptions();
+}
+
 bool bpf_jit_supports_private_stack(void)
 {
 	return true;
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7f2db4e9afe0..17b13b16899d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2010,6 +2010,10 @@ struct bpf_prog_aux {
 	 * by the JIT; consumed by the exception unwinder.
 	 */
 	s16 callee_reg_off[BPF_THROW_NR_CALLEE_SAVED];
+	/* BPF frame pointer relative to the native frame pointer the stack walker reports */
+	s16 frame_fp_off;
+	/* With a private stack, the frame's R10 is this far into this CPU's priv_stack_ptr. */
+	u32 priv_frame_off;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 61448be53f8d..08ad906f649f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1391,6 +1391,7 @@ bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_exception_cleanup(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 7a25d1cb2c30..59478a08b247 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3896,6 +3896,16 @@ bool __weak bpf_jit_supports_exceptions(void)
 	return false;
 }
 
+/*
+ * Does the JIT record where each frame keeps its BPF stack, see
+ * bpf_prog_aux::frame_fp_off, so that the unwinder can release what a frame
+ * holds when bpf_throw() discards it?
+ */
+bool __weak bpf_jit_supports_exception_cleanup(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_private_stack(void)
 {
 	return false;
-- 
2.53.0

