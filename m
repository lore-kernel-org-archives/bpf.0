Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CE9332EBD
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785029473; cv=none; b=jwHq2opVSPwAP+pe+WAzYsWFOmbd/fkEgLotFp1uEgbfbv758MFcxGnc/3zhztMBvJzI5zIYCNbyuAvQKgjE2ytZDYpdRRutQyZtHDAJ5UtJ2XcFd7ODl/l7WdQFoqlg7Ozt/Jy46uKsV/TsyQWJZpBpB4EI5LfvvpGUB/W/EXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785029473; c=relaxed/simple;
	bh=8DoAHwZ2eo62VwmrGuQ96OyMwF4QcBksnWHBO8KLSJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrP6oOBSrobx7Zkv924tFWBd+vILmEw5zDYUOYIyPm/6nEMqdlYW4zBCLDSDQwO/8RLAOAERWJBAUkTyTPnzkPJcIKVofYpYgzuAB+f4ByJq1h6fBlTt1wrVxXr7gAB4arhPjN125cDzND+YboV2UDwowsHnMBG9dxIyLn+SvVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qPtJe27u; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPtJe27u"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so3408355e9.1
        for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 18:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785029470; x=1785634270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+02nmBuYRTLmRBXgT7XMZ8JUgbaFxD+UPIIgCA4PWk=;
        b=qPtJe27uRw36iZCCFBrXY3JqO+TbakF7izOH+HkTkh1UrsNRlI6UqlHtsl9X35Q9bj
         Gc1SdO3aX40TuCJh8NnqSPc6D0WrapyV/b7I/RnD+SB26kNDCU2ecQALxVlf8oPR87U7
         ykyEy7vHyyG6h8T3ASKi11BgIkFp/Bey/t6iNdtBH2tHH1tb2CLzVbxL0qUgkJI2Ivvk
         gP2X+9TQJZy3jkkH+UT0s/xfCDsWdKL6WVHOjx+wAd/lRWxtsVjppKjRTbnoRcpVOk3m
         xrLfe6fBRSSiGrbkWRpxinGShzoZ/Jp2+hoch3jmOSD7LUO8hMAZtZzbcO220gUzGZ/I
         nAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785029470; x=1785634270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+02nmBuYRTLmRBXgT7XMZ8JUgbaFxD+UPIIgCA4PWk=;
        b=reoIIz8/KAR5afHESs/FR/vTV5lQpOyrSWsBylGtQQoCiyvTCy3FKZtozQIHw+c8Br
         vMmt7KqM4Qku1U784AMhrwmF83izMMh/HP7LJ8Yi2QLBBe1LjahSzNyVBTfLi2RLZRPG
         lxV8dCoiD9DiC5+dU5bNZIXsfKkigx2tV/C0QV/ZKFqT9C0JqAgB4ea4g8DIhjwY9rHc
         rL+SWn9ejZE1UZcNnaQSnOu4vN4FDMe+HuhcybYcIREsQQ4s74OReIi4RiINuJV92Eqi
         4mGOuB+GA4CzmNsP8/vO4deq9LNwvFkUD/OnONUr4Q4UZCf0JizL15rV69v5KSMOEvu5
         WyRw==
X-Gm-Message-State: AOJu0YzU87OoMoavGRPGnW9dlSLx7pHU6V+PSWt16Txl71ZPGtddBTti
	IEs4doyT0eP+V3Kz/IXQVatnnkYQMcIVW1c6FpZkcdxJ/opl76gt9He7HiUkf8Rm
X-Gm-Gg: AR+sD11b91EMvmuSm4LAJAUvqpRVAoSjHj/fYxwF4eQSRC6ZZ6VD8GkPevfrALifMp+
	JWtqb5ca0JIFWUKnFeoHK4dA6ftrFC3N6iJ3lCzrnapXZyEGsUhqUAtLUyruiYk0R7takkeuzKz
	YczW+81/t3/qWUdg3n7PboM9kCQurdvohFxYv5JGudfAQnCoMeEGdLmL3+DPoAbuX6q/VsSySl5
	G8r0ZqRgoUsJnhGdegm6ALh+nmfiWO6mM+27A6vpNi/WH+K9Lw6dKvOkq5xPtGKeU3Q/SpvPdaM
	2TdnnPkDbQMQtd8pObb97BgpvoCX4kama8BGny4JqCpG6K45vgB1MwOaQl0GUelkiOwIuJqfsMa
	0IFzFIknJZCmavJE0HuZ1sKa/LA8ZuzluicC3quaUujL9oFqmdzmRdd4Nj4OvAkMU5FValS+SC6
	jsHhZah9i1R0dBgkmJiJVMU3Edu0Jb5vIu2Mllrl5HPlGRR5Yfh2J5E8X2D8DeW6+d1uZhwWWPb
	lhEnnbLyClReGlWdOHeoq0d47SD+odS7OS9x+yndBb2
X-Received: by 2002:a05:600c:c177:b0:495:4056:9473 with SMTP id 5b1f17b1804b1-496b5754455mr47246055e9.28.1785029470332;
        Sat, 25 Jul 2026 18:31:10 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c532d4sm35050895f8f.22.2026.07.25.18.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 18:31:09 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/9] bpf, x86: Convert struct_ops arena arguments in the trampoline
Date: Sun, 26 Jul 2026 03:30:57 +0200
Message-ID: <20260726013105.3689867-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726013105.3689867-1-memxor@gmail.com>
References: <20260726013105.3689867-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6640; i=memxor@gmail.com; h=from:subject; bh=/c5HYBpzSp89t29rRL3JNld8fZSsnaOiIqecJ0VrfwY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISs12bJi1tEQPo0thkbf1hjKrirh2rzrtau+mYMQe+9f3 01Tv4p2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLf9jL8D9/5Ougd9yPXjWUd H7KW1u7WPnK8K3bSA5WjW+v6z7FkhDIyHDFovTxTljva9UZiw4/bWw6kbvPYsShf+aPW5dZ0XRZ ZFgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Implement the struct_ops arena argument conversion on x86. save_args()
gains the conversion map from bpf_tramp_collect_arena_args() and, as it
copies each native argument into the BPF ctx, routes a marked slot
through RAX:

  movl %esrc, %eax      /* truncate and clear the upper 32 bits */
  subl $base_lo, %eax
  movq %rax, ctx_slot

A nullable slot tests the full 64-bit kernel pointer first:

  movq  %rsrc, %rax
  testq %rax, %rax
  jz    1f
  subl  $base_lo, %eax
1:
  movq  %rax, ctx_slot

The 32-bit subtraction is sufficient since (u32)(kaddr - base) ==
(u32)kaddr - (u32)base, and it clears the upper half as the JITs require
of arena pointer registers. Stack-passed arguments already reload
through RAX, so only the subtraction (and the NULL test) is inserted
there. The marked slots are tracked with a running slot counter shared
by the register and stack branches, matching the flattened ctx offsets
in ctx_arg_info. The size probe reruns the same emission with the same
tnodes, so the image size matches by construction.

With both the kfunc and struct_ops directions implemented, flip
bpf_jit_supports_arena_args() on for x86.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 08013c2fcfaa..dfb5335ad837 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3043,12 +3043,39 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 	return nr_used_regs;
 }
 
+/*
+ * Convert an arena kernel address into the arena pointer form on its way
+ * into the BPF ctx, rax = (u32)(src - kern_vm_start). A nullable arg
+ * preserves NULL, tested on the full 64-bit kernel pointer. The 32-bit
+ * subtraction both truncates and clears the upper half, so the stored
+ * value satisfies the JIT invariant for arena pointer registers.
+ */
+static void emit_arena_arg_conv(u8 **pprog, u32 src_reg, bool nullable, u32 base_lo)
+{
+	u8 *prog = *pprog;
+
+	if (nullable) {
+		if (src_reg != BPF_REG_0)
+			emit_mov_reg(&prog, true, BPF_REG_0, src_reg);
+		/* test rax, rax; jz over the 5-byte sub */
+		EMIT3(0x48, 0x85, 0xC0);
+		EMIT2(X86_JE, 5);
+	} else if (src_reg != BPF_REG_0) {
+		emit_mov_reg(&prog, false, BPF_REG_0, src_reg);
+	}
+	/* sub eax, base_lo */
+	EMIT1_off32(0x2D, base_lo);
+
+	*pprog = prog;
+}
+
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin, u32 flags)
+		      int stack_size, bool for_call_origin, u32 flags,
+		      const struct bpf_tramp_arena_args *aargs)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
-	int i, j;
+	int i, j, slot = 0;
 
 	/* Store function arguments to stack.
 	 * For a function that accepts two pointers the sequence will be:
@@ -3089,6 +3116,10 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+				if (aargs && (aargs->slots & BIT(slot)))
+					emit_arena_arg_conv(prog, BPF_REG_0,
+							    aargs->nullable_slots & BIT(slot),
+							    (u32)aargs->kern_vm_start);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3096,6 +3127,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 					first_off = stack_size;
 				stack_size -= 8;
 				nr_stack_slots++;
+				slot++;
 			}
 		} else {
 			/* Only copy the arguments on-stack to current
@@ -3104,16 +3136,24 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 */
 			if (for_call_origin) {
 				nr_regs += arg_regs;
+				slot += arg_regs;
 				continue;
 			}
 
 			/* copy the arguments from regs into stack */
 			for (j = 0; j < arg_regs; j++) {
-				emit_stx(prog, BPF_DW, BPF_REG_FP,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 -stack_size);
+				u32 src = nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
+
+				if (aargs && (aargs->slots & BIT(slot))) {
+					emit_arena_arg_conv(prog, src,
+							    aargs->nullable_slots & BIT(slot),
+							    (u32)aargs->kern_vm_start);
+					src = BPF_REG_0;
+				}
+				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
+				slot++;
 			}
 		}
 	}
@@ -3404,11 +3444,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_arena_args aargs;
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
 	u64 func_meta;
 	u8 *prog;
+	bool has_aargs;
 	bool save_ret;
 
 	/*
@@ -3419,6 +3461,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
+	has_aargs = bpf_tramp_collect_arena_args(tnodes, flags, &aargs);
+
 	/* extra registers for struct arguments */
 	for (i = 0; i < m->nr_args; i++) {
 		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
@@ -3556,7 +3600,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags);
+	save_args(m, &prog, regs_off, false, flags,
+		  has_aargs ? &aargs : NULL);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3598,7 +3643,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags);
+		save_args(m, &prog, arg_stack_off, true, flags, NULL);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4099,6 +4144,11 @@ bool bpf_jit_supports_stack_args(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_args(void)
+{
+	return true;
+}
+
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	if (text_poke_copy(dst, src, len) == NULL)
-- 
2.53.0

