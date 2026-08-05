Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4345A3EEAF8
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963880; cv=none; b=EclenkvR0MinTl5YZoJyHVraC00cCNCGrwhhVdE6dC0XSagsX/4FyIUDT1+4zJlYn7tH3ukP82JxJNwxdvRJ7sEj1mlBfyt6oX570gLgnW++uvpy7ZQOpYAwXfCtvR7ey75KHEbcqld9hSlWu5MF4lE4MCanfakEGSNj8nJRHiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963880; c=relaxed/simple;
	bh=jYGeUARekZ2I5+nVlfmVhEsMZCsrxAGNvlRYM5zSruA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt+Ek3PqKP0n6qUE6WjwPN9qxmSgxQmDhYr5n8tRJXdnkitGoqiJhIBgbWTZrZlsu//cBSmlgKYRk/1WSACIcnDmLWRzSBAOCOMFZklbJsV6u6JaZ1QJz6YP67asYIpNjlcdoLWYJUUUjzVafXjcZdv8376Ql7sbos/bMB3UuNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jp7tzmFe; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp7tzmFe"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-49242309566so3400915e9.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785963876; x=1786568676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tj5waCMkQQsc5tFGKGaavf5ndQSmqjxZT2CXudnW1H4=;
        b=Jp7tzmFeFzePx+3Awvz3mgq+PIk/5bewxv6OON0rqqV+/1Qdbjs3A3VV3byehqpMtM
         qpIhwwpcecz2xDnzs0/eBzbJSdtmm9oufjBfuzsyym02sjQRrGGi4QIdgSaDOVT51F+V
         Wotvo0tgDwUuJ0d+KcFtriJLmk5e3k3t60d9ffEqn23SR5cziuuUWHDfDYN1kS4GbkgP
         +/KH8dK+x8Xlr/ufs8XdwCcPaEPVsAKwVb28ZKnmQTXEI5Rwx2S3X1CiJB7+TrCPXE3i
         BQKb0jKQfEwpBD7xSrYwxkalT0vua1smMKi4KiigZqAlWJd5rpIkvClxHwxXV+CjaQvL
         NQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785963876; x=1786568676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tj5waCMkQQsc5tFGKGaavf5ndQSmqjxZT2CXudnW1H4=;
        b=IOufSd+1G8ffDymeuVxD8xzHLXnK9W9TtlBtT1ZB1P7ZN0sMD0qhS4DKLuKjgvZfHg
         5mWqn6PZ/H8JxXqqCzLPFHn1ddlmgSN4EpNvV9M5H521KNvHyJWD5oB14EBsvqmhIC6F
         qCFZyC5iEyDZekyPi9BW7fImooRW8Q4v7N+enUimJHwrdbJr4fXlHnPsuYQrk1+43INH
         Xp/a3PtmW1+/yWdU8O4rZUQSgXSdN62AnPLRHwEcHhipfJaAlSDavwZDUTpbvqmXul9d
         wEHntgQkUdYDn8fflvmdXGka26B7EYVopkNC5k0LiJOgwM2XQOl9KR70ClcApiTc38+T
         szxw==
X-Gm-Message-State: AOJu0YzCz8c4lmQSMGMs6N5xAyujA49nFq1VWJ3nT0FZ2CgduskgdwYc
	TT04xRwWolDdNMojxv2xy4N/YZ6WDJO+RnUBC7aAslNaasNCR8yhfS0no502JEhe
X-Gm-Gg: AR+sD12Q+8szOe2c441AW3VAXvg2nZct56z+Rck6oOFjMRefw4Smn3wON/InsMnmFWq
	fG/h5Qu1fJBXH+In4GRnGxA6Sa0hrBH+NR53uxzORtBCfdCsHuZ7M+a0P6IKM6nOv/EuJ+z+Pvd
	W3XEMpwY6F3jMXvMOacaLm4pCKlpZH7jJJob3kYBoI/Ty/dlzcfQ4UovX+HX8loC/Urv6xukwf7
	qmY7WRsmzzh76kIZ1sDlfWGX9xc1WFkQT5K1sXiB5cKGv0/D+v0x3Xs0MOG+A6N/hDWqtP6cOI6
	WFfHdVGPFkiokvf7qZeKo75Rg9RkbfhDBOPuIKeTJUqh1aHiV3zXwGvlk8VIR7++BkxcRMGaFOA
	3TCi5jQv4iAwQ1tqQXLrJktgSmYK323ZdKu4RYOXSfJPEj9vlxEsFeRRjB2O9Yao4+YS2sNuQEx
	ISxajGWTyGq7XE/SAIYTibfiwHRCYR6aht2ulVBU1rK7mzVaPgOYkZKaPEDXgWXvTJMWpiNETYD
	c9foeHXXmF+5vi8viKi20cFdpcghkLRltn9B2CDBOmifsrOYZrSzW9qm/znvVuvs9oAxOt+9bm4
	ZF7tnvGEz94vp+v7r/gt4wtdOVEs2k5Z+1zJLuY=
X-Received: by 2002:a05:600c:190a:b0:495:6a50:3fb8 with SMTP id 5b1f17b1804b1-4994e743275mr115625105e9.1.1785963876332;
        Wed, 05 Aug 2026 14:04:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b529fsm356140f8f.12.2026.08.05.14.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:04:35 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 07/13] bpf, x86: Convert struct_ops arena arguments in the trampoline
Date: Wed,  5 Aug 2026 23:04:18 +0200
Message-ID: <20260805210427.3218326-8-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805210427.3218326-1-memxor@gmail.com>
References: <20260805210427.3218326-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10581; i=memxor@gmail.com; h=from:subject; bh=rZrW7BBpVEmaoAuZdejnUbGKMAGXJj9IfZ/JtO0cH74=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIat40ZQlq2vy1Y6W7c4R2b/gsEBw38fGObHJfNk396Y4X fkeJ6XbUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlwKjIyTJy444C89sfChVfi mu73Tk7ytxS6tDOg9W/YOu6yAI/5dxkZNmzYrc2UtXMPl2Hoj0tf8/feMg9yUz94dY1C9a8HNgF LOQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

Implement the struct_ops arena argument conversion on x86. save_args()
receives the arena base from bpf_tramp_arena_base() and consults the
btf_func_model argument flags as it copies each native argument into the
BPF ctx, routing a marked argument through RAX:

  movl %esrc, %eax      /* truncate and clear the upper 32 bits */
  subl $base_lo, %eax
  movq %rax, ctx_slot

A nullable argument tests the full 64-bit kernel pointer first:

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
there.

Keeping arena and nullable classification in btf_func_model avoids a
parallel trampoline slot bitmap. bpf_tramp_arena_base() returns a base
only for a single-program struct_ops indirect trampoline; other
trampolines pass zero and perform no conversion. The size probe reruns
the same emission with the same model and nodes, so the image size
matches by construction.

With both the kfunc and struct_ops directions implemented, flip
bpf_jit_supports_arena_args() on for x86.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 57 +++++++++++++++++++++++++++++++++----
 include/linux/bpf.h         | 22 ++++----------
 kernel/bpf/bpf_struct_ops.c |  1 -
 kernel/bpf/trampoline.c     | 41 +++++++++++---------------
 4 files changed, 74 insertions(+), 47 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 817977797e59..cb8ee0f3a642 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3043,8 +3043,35 @@ static int get_nr_used_regs(const struct btf_func_model *m)
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
+		      u64 arena_base)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	bool use_jmp = bpf_trampoline_use_jmp(flags);
@@ -3056,6 +3083,9 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 	 * mov QWORD PTR [rbp-0x8],rsi
 	 */
 	for (i = 0; i < min_t(int, m->nr_args, MAX_BPF_FUNC_ARGS); i++) {
+		bool arena_arg = arena_base && (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG);
+		bool nullable = m->arg_flags[i] & BTF_FMODEL_NULLABLE_ARG;
+
 		arg_regs = (m->arg_size[i] + 7) / 8;
 
 		/* According to the research of Yonghong, struct members
@@ -3089,6 +3119,9 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
 					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
+				if (arena_arg)
+					emit_arena_arg_conv(prog, BPF_REG_0, nullable,
+							    (u32)arena_base);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3109,9 +3142,13 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 
 			/* copy the arguments from regs into stack */
 			for (j = 0; j < arg_regs; j++) {
-				emit_stx(prog, BPF_DW, BPF_REG_FP,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 -stack_size);
+				u32 src = nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs;
+
+				if (arena_arg) {
+					emit_arena_arg_conv(prog, src, nullable, (u32)arena_base);
+					src = BPF_REG_0;
+				}
+				emit_stx(prog, BPF_DW, BPF_REG_FP, src, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
 			}
@@ -3407,6 +3444,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
+	u64 arena_base;
 	u64 func_meta;
 	u8 *prog;
 	bool save_ret;
@@ -3419,6 +3457,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	WARN_ON_ONCE((flags & BPF_TRAMP_F_INDIRECT) &&
 		     (flags & ~(BPF_TRAMP_F_INDIRECT | BPF_TRAMP_F_RET_FENTRY_RET)));
 
+	arena_base = bpf_tramp_arena_base(m, tnodes, flags);
+
 	for (i = 0; i < m->nr_args; i++)
 		nr_regs += (m->arg_size[i] + 7) / 8 - 1;
 
@@ -3553,7 +3593,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -ip_off, (long)func_addr);
 	}
 
-	save_args(m, &prog, regs_off, false, flags);
+	save_args(m, &prog, regs_off, false, flags, arena_base);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3595,7 +3635,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true, flags);
+		save_args(m, &prog, arg_stack_off, true, flags, 0);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
@@ -4096,6 +4136,11 @@ bool bpf_jit_supports_stack_args(void)
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
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0d1773af8373..00aaa23b4f7e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1290,18 +1290,13 @@ struct bpf_tramp_nodes {
 };
 
 /*
- * Which 8-byte ctx slots of a struct_ops trampoline hold arena kernel
- * pointers that save_args() converts to the arena pointer form,
- * ctx[slot] = (u32)(kaddr - kern_vm_start).
+ * The arena base against which a struct_ops trampoline converts the
+ * arguments marked with BTF_FMODEL_ARENA_ARG while saving them into the BPF
+ * ctx, ctx[arg] = (u32)(kaddr - kern_vm_start). Zero when the trampoline
+ * converts nothing.
  */
-struct bpf_tramp_arena_args {
-	u32 slots;
-	u32 nullable_slots;	/* subset of @slots where NULL is preserved */
-	u64 kern_vm_start;
-};
-
-bool bpf_tramp_collect_arena_args(struct bpf_tramp_nodes *tnodes, u32 flags,
-				  struct bpf_tramp_arena_args *aargs);
+u64 bpf_tramp_arena_base(const struct btf_func_model *m,
+			 struct bpf_tramp_nodes *tnodes, u32 flags);
 
 struct bpf_tramp_run_ctx;
 
@@ -1704,11 +1699,6 @@ struct bpf_ctx_arg_aux {
 	u32 btf_id;
 	u32 ref_id;
 	bool refcounted;
-	/*
-	 * We don't encode NULL-ness in the type for the program, but still need
-	 * to distinguish it for the purposes of telling JITs what sequence to emit.
-	 */
-	bool arena_nullable;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ebfb7fff453e..ced7b18246a9 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -288,7 +288,6 @@ static int prepare_arg_info(struct btf *btf,
 			 * precision around it, since it has no safety implication.
 			 */
 			info->reg_type = PTR_TO_ARENA;
-			info->arena_nullable = is_arena_nullable;
 			model->arg_flags[arg_no] |= BTF_FMODEL_ARENA_ARG;
 			if (is_arena_nullable)
 				model->arg_flags[arg_no] |= BTF_FMODEL_NULLABLE_ARG;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 67d0ba8a05cd..b349e0817184 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -540,40 +540,33 @@ static bool bpf_prog_has_arena_ctx_arg(const struct bpf_prog *prog)
 }
 
 /*
- * Collect which ctx slots of a struct_ops trampoline hold arena kernel
- * pointers that save_args() must convert to the arena pointer form. Only
- * the struct_ops indirect trampoline converts: it dispatches to a single
- * prog whose arena is known at generation time. Return false when there
- * is nothing to convert.
+ * The arena base against which save_args() converts the arguments marked
+ * with BTF_FMODEL_ARENA_ARG. Only the struct_ops indirect trampoline
+ * converts: it dispatches to a single prog whose arena is known at
+ * generation time. Return 0 when there is nothing to convert.
  */
-bool bpf_tramp_collect_arena_args(struct bpf_tramp_nodes *tnodes, u32 flags,
-				  struct bpf_tramp_arena_args *aargs)
+u64 bpf_tramp_arena_base(const struct btf_func_model *m,
+			 struct bpf_tramp_nodes *tnodes, u32 flags)
 {
 	const struct bpf_prog *prog;
 	int i;
 
-	memset(aargs, 0, sizeof(*aargs));
-
 	if (!(flags & BPF_TRAMP_F_INDIRECT) ||
 	    tnodes[BPF_TRAMP_FENTRY].nr_nodes != 1)
-		return false;
+		return 0;
 
-	prog = tnodes[BPF_TRAMP_FENTRY].nodes[0]->link->prog;
-	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
-		const struct bpf_ctx_arg_aux *info = &prog->aux->ctx_arg_info[i];
+	for (i = 0; i < m->nr_args; i++)
+		if (m->arg_flags[i] & BTF_FMODEL_ARENA_ARG)
+			break;
+	if (i == m->nr_args)
+		return 0;
 
-		if (base_type(info->reg_type) != PTR_TO_ARENA)
-			continue;
-		aargs->slots |= BIT(info->offset / 8);
-		if (info->arena_nullable)
-			aargs->nullable_slots |= BIT(info->offset / 8);
-	}
-	if (!aargs->slots)
-		return false;
+	/* Verification rejects an arena argument without an arena. */
+	prog = tnodes[BPF_TRAMP_FENTRY].nodes[0]->link->prog;
 	if (WARN_ON_ONCE(!prog->aux->arena))
-		return false;
-	aargs->kern_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
-	return true;
+		return 0;
+
+	return bpf_arena_get_kern_vm_start(prog->aux->arena);
 }
 
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
-- 
2.53.0

