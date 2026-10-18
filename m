Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CC299931
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792285382; cv=none; b=JSpukj94OcUgOj7vOaBN+sIJIz/ilMI2Vb1fKaJ4qeoofzgqTkippuKpCJHNbXLHIb1QWLM2zbx18+GIrJYoliEIrTMu1+EkitUAxG2Kx0mSouupEdGIpi1AvZuaUMjiPT4AuGzERxTjncV+b0Uc6XCko0uM34ylq+RehVFrjpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792285382; c=relaxed/simple;
	bh=W2WO1LqME4DA1NbAQI1AB1AgLE42XQrpiigc+Wx0aD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WfsCmPsacuARlU6EilzN35HCxlNHt9PuonLp0RAHf7FUzu5PkFlAaMNLG/jiBA2J4wO57ocYFqWdmDpBFqrgW2BDavHkyU1bMCCFIOIF2DNNsgGP4Hy21DCuYZYjALsyiL1+Ou9M4wbhkvpHsnq30A9qnSySEzRFb3ERzZRi1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/eZDhCW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/eZDhCW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e987a2ba0cso7576575ad.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792285380; x=1792890180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PDSaiW6yi2HsLKVHYlGTlI0czRqtyJtcEw0T5DPCGnk=;
        b=A/eZDhCWA4mB7ZTzeMHdP/B9Gw55o5syKoJAqNI8RWceWAUVjSyerwd+l1jYo+V+q4
         k80WiMpcJm/4CYn4DsONFkm0odmFxn+L/6j0vnoaq3OpYge4HVWuBpHYOL+1nBWjFPVK
         sQLZJalbI8LnKNQ53Ix7B2UbPxLcL7ljOlCZuI82V69SThwSkBtTq8PPooC3+9SNfFRZ
         RbGTZJhZsJGDNWMUWC32pISTPAinl3Zn2ufdm/6KNxqbmLZ15PPHFBBN8d4IdfWO7RuH
         vastb/1pVEurchqYvHIKfL7ewwbEGRMmBRt5GHGxqAHGj+l/E8rgpvXUbe00rPoMwVUc
         mjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792285380; x=1792890180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PDSaiW6yi2HsLKVHYlGTlI0czRqtyJtcEw0T5DPCGnk=;
        b=tSlrjGFpvlOzRnDyKmCBkLiSZe1UIA/cYyRGsxhWVvVk6B2qGJrJj+gqtFSUJc+Y2N
         WMjCM7hNlsKND6My34m2dCZGREnc8+ZoU33h0J97MkXKMOLWsS1UAMH9SCYEZ75ti3hf
         6HqpKHy6epImV346HhDbqHPvCHSliKzyWL6ouZhzT+c6qixF8CUjPpB3Efk59PWdGoV1
         4Io49ESioWnWRDh1QkOw+oP4zruZr4nLczSvJEzUtNRmiPNjKiZ5L1ZxW/vJG3oCIw6n
         uDaCXGaJUlZ5dKhtVHOi9S8c5gn7DF2kK925DgZi/hxMxO5JbusZa0ODj3syeLPVWJnr
         +PYw==
X-Gm-Message-State: AFq9FYKuarLJn4aIQcXbIT3KiFIW/Pvu4SyBMqVCzR+CjOVFJ6fhpeAG
	Dr5Aq0OICy0lkouqtuwdP04F+gEo0jTrx0QTjqJ/7oUfzv1QeiDBEJ1JWxE0tA==
X-Gm-Gg: AYBFou1WeX9JIpjJKExI7AfzzzA2pwYcLNguUZFrHKBz7j8FlYT7r6n2by0lmTe1YJj
	iChhNk4TRHaKdmU8mFgwOpTrAbi79UmbSLpGPyGNHItDdJ7odvNOnoCDiVJW4skzLUGquR7HmGh
	QVSBP9iExLnj/V1EfpnCqzjLxz1zX9nUP70RkY+YWB23KpZwsvVwLe6NKXbY068Qfjh3V1PTjDA
	vjhujEKG7csonPOqQ6kYTilDErXMDafLT8DhngptwNYE7ZxczHcfwyilAoWiKErqE0nTILcG8wv
	1BidCbHOBeTVecKv4tqbDQTjnXBhL3EirE7KuGUpuIHOWk2Ov9JuYWAs/xp2MCxpZLGpks/aKiQ
	zyE2V572B6DtHJcCR1LZqWrAR0LTrJflr1BCfJvrtpb50VSIPBJVY6C8W4rogfJIqdDIKJDkxs5
	9+8UN9J9RpYFl8OWWZau3hK5jpKBn4LXLsGDutGeBYEGNDPh2zUT9Pa1EFXtT1oJZ5QTzmzOfI5
	sWVuZQkuxD8nBuKo0SQFipFnD8MxA0M0+y+DbM//I9iY9N3ZPt90cz+MNpMP7RpNuod63Iaxp5g
	m0wJ3SiX35VyapJ9cKuh3GH4+mmCb4glVATY175s0pU=
X-Received: by 2002:a17:902:e547:b0:2e8:93b5:c555 with SMTP id d9443c01a7336-2e9a6e5296emr33675535ad.61.1792285380094;
        Sat, 17 Oct 2026 18:03:00 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm24893765ad.65.2026.10.17.18.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 18:02:59 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/5] bpf, x86: Replace 'if r3 != 0 goto pad' after a call with an extable entry
Date: Sun, 18 Oct 2026 01:02:42 +0000
Message-ID: <20261018010246.1643877-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
References: <20261018010246.1643877-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

A subprog that can unwind says so in r3 and its caller does
'if r3 != 0 goto pad' after the call. Keep that off the normal path.

  bpf                         x86 before                  x86 after
  call inner                  call inner                  call inner
  if r3 != 0 goto pad         test rdx, rdx               mov eax, ebx
  w0 = w6                     jne pad
                              mov eax, ebx

  at 'call foo; if r3 != 0 goto pad':
	emit(call foo)
	extable[n++] = { ret_addr -> pad }

  at 'r3 = 1; exit':
	my_ret_addr = bpf_unwind_target(my_ret_addr)
	epilogue

  bpf_unwind_target(ret_addr)
  {
	e = search_bpf_extables(ret_addr - 1);
	return e ? ret_addr + e->fixup : ret_addr;
  }

Every frame fixes only its own return address. There is no stack walk and
no ORC. The lookup is what the page fault handler does for bpf progs.
- 1, because what follows the call can have an entry of its own, and
no insn starts at that address, so a fault cannot hit the entry.

The verifier doesn't know about any of that.

When there is no entry the callee returns as usual and the branch does the
job. That's the case when:
- the branch is a jump target
- constant blinding rewrote the branch
- the prog uses private stack: 'pop r9' after the call has to run on the
  way to the pad too

When 'exit' doesn't follow 'r3 = imm' the JIT emits 'test rdx, rdx; je'
around the lookup.

bpf_jit_unwind_site() and bpf_jit_unwind_exit() look at bpf insns only.
They're in core.c for other JITs to use.

I couldn't measure the branch in a microbenchmark [1]. In rust it follows
every indirect call and a third of direct calls of subprogs.

[1] https://lore.kernel.org/bpf/DM7FULA7L0GQ.R21A648X547X@gmail.com/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c  | 102 ++++++++++++++++++++++++++++++++++-
 include/linux/bpf_verifier.h |   2 +-
 include/linux/filter.h       |  10 ++++
 kernel/bpf/core.c            |  44 +++++++++++++++
 4 files changed, 155 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 16e847c615bc..1b8c4708ba6f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -15,6 +15,7 @@
 #include <linux/memory.h>
 #include <linux/sort.h>
 #include <linux/execmem.h>
+#include <linux/extable.h>
 #include <asm/extable.h>
 #include <asm/ftrace.h>
 #include <asm/set_memory.h>
@@ -2511,6 +2512,71 @@ static void adjust_cmp_imm(u32 *op, s32 *imm)
 	}
 }
 
+/* See bpf_jit_unwind_site() */
+static bool unwind_site(struct bpf_verifier_env *env, struct bpf_prog *prog, int i)
+{
+	/* 'pop r9' after the call has to run on the way to the pad too */
+	return !prog->aux->priv_stack_ptr && bpf_jit_unwind_site(env, prog, i);
+}
+
+/* The branch after the call is not emitted. Remember where it goes. */
+static int add_unwind_exentry(struct bpf_prog *prog, u8 *image, u8 *rw_image, int *excnt,
+			      int ret_addr, int pad)
+{
+	struct exception_table_entry *ex;
+	s64 delta;
+
+	if (!prog->aux->extable)
+		return 0;
+	if (*excnt >= prog->aux->num_exentries) {
+		pr_err("unwind extable bug\n");
+		return -EFAULT;
+	}
+	ex = &prog->aux->extable[(*excnt)++];
+	delta = image + ret_addr - 1 - (u8 *)&ex->insn;
+	if (!is_simm32(delta)) {
+		pr_err("extable->insn doesn't fit into 32-bit\n");
+		return -EFAULT;
+	}
+	/* switch ex to rw buffer for writes */
+	ex = (void *)rw_image + ((void *)ex - (void *)image);
+	ex->insn = delta;
+	ex->fixup = pad - ret_addr;
+	ex->data = EX_TYPE_BPF;
+	return 0;
+}
+
+static u64 bpf_unwind_target(u64 ret_addr)
+{
+	const struct exception_table_entry *e = search_bpf_extables(ret_addr - 1);
+
+	return e ? ret_addr + e->fixup : ret_addr;
+}
+
+/* r0, r2 and r3 are what the caller may look at */
+static int emit_unwind_ret_addr(u8 **pprog, u8 *ip, bool look_at_r3)
+{
+	u8 *prog = *pprog, *start = prog, *jmp = NULL;
+
+	if (look_at_r3) {
+		EMIT3(0x48, 0x85, 0xD2);	/* test rdx, rdx */
+		EMIT2(X86_JE, 0);
+		jmp = prog;
+	}
+	EMIT3(0x50, 0x56, 0x52);		/* push rax; push rsi; push rdx */
+	EMIT4(0x48, 0x8B, 0x7D, 0x08);		/* mov rdi, [rbp + 8] */
+	ip += prog - start;
+	ip += x86_call_depth_emit_accounting(&prog, bpf_unwind_target, ip);
+	if (emit_call(&prog, bpf_unwind_target, ip))
+		return -EINVAL;
+	EMIT4(0x48, 0x89, 0x45, 0x08);		/* mov [rbp + 8], rax */
+	EMIT3(0x5A, 0x5E, 0x58);		/* pop rdx; pop rsi; pop rax */
+	if (jmp)
+		jmp[-1] = prog - jmp;
+	*pprog = prog;
+	return 0;
+}
+
 static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		  u8 *rw_image, int oldproglen, struct jit_context *ctx, bool jmp_padding)
 {
@@ -2518,7 +2584,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	struct bpf_insn *insn = bpf_prog->insnsi;
 	bool callee_regs_used[4] = {};
 	int insn_cnt = bpf_prog->len;
-	bool seen_exit = false;
+	bool seen_exit = false, skip_branch = false;
 	u8 temp[BPF_MAX_INSN_SIZE + BPF_INSN_SAFETY];
 	void __percpu *priv_frame_ptr = NULL;
 	u16 out_stack_arg_cnt, outgoing_rsp;
@@ -2655,6 +2721,12 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		int nops;
 		u32 jmp_op = BPF_OP(insn->code);
 		s32 cmp_imm;
+		enum bpf_unwind_exit unw;
+
+		if (skip_branch) {
+			skip_branch = false;
+			goto insn_done;
+		}
 
 		if (priv_frame_ptr) {
 			if (src_reg == BPF_REG_FP)
@@ -3460,6 +3532,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
 			if (emit_call(&prog, func, ip))
 				return -EINVAL;
+			if (unwind_site(env, bpf_prog, i - 1)) {
+				skip_branch = true;
+				err = add_unwind_exentry(bpf_prog, image, rw_image, &excnt,
+							 proglen + (prog - temp),
+							 addrs[i + 1 + insn[1].off]);
+				if (err)
+					return err;
+				break;
+			}
 			if (priv_frame_ptr)
 				pop_r9(&prog);
 			/*
@@ -3487,6 +3568,15 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			}
 			if (emit_indirect_call(&prog, insn->dst_reg, ip))
 				return -EINVAL;
+			if (unwind_site(env, bpf_prog, i - 1)) {
+				skip_branch = true;
+				err = add_unwind_exentry(bpf_prog, image, rw_image, &excnt,
+							 proglen + (prog - temp),
+							 addrs[i + 1 + insn[1].off]);
+				if (err)
+					return err;
+				break;
+			}
 			if (priv_frame_ptr)
 				pop_r9(&prog);
 			break;
@@ -3772,13 +3862,17 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			break;
 
 		case BPF_JMP | BPF_EXIT:
+			unw = bpf_jit_unwind_exit(env, bpf_prog, i - 1);
+			if (unw != BPF_EXIT_RETURNS &&
+			    emit_unwind_ret_addr(&prog, ip, unw == BPF_EXIT_LOOK_AT_R3))
+				return -EINVAL;
 			if (seen_exit) {
 				jmp_offset = ctx->cleanup_addr - addrs[i];
 				goto emit_jmp;
 			}
 			seen_exit = true;
 			/* Update cleanup_addr */
-			ctx->cleanup_addr = proglen;
+			ctx->cleanup_addr = proglen + (prog - temp);
 			if (bpf_prog_was_classic(bpf_prog) &&
 			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
@@ -3811,6 +3905,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 			return -EINVAL;
 		}
 
+insn_done:
 		ilen = prog - temp;
 		if (ilen > BPF_MAX_INSN_SIZE) {
 			pr_err("bpf_jit: fatal insn size error\n");
@@ -4864,6 +4959,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		    is_atomic_fetch_op(insn))
 			prog->aux->num_exentries++;
 	}
+	for (i = 0; i < prog->len; i++)
+		if (unwind_site(env, prog, i))
+			prog->aux->num_exentries++;
 
 	addrs = kvmalloc_objs(*addrs, prog->len + 1);
 	if (!addrs)
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0f25454094a7..e38e4b87d9d2 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1326,7 +1326,7 @@ static inline void mark_jump_target(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].jump_target = true;
 }
 
-static inline bool bpf_is_jump_target(struct bpf_verifier_env *env, int insn_idx)
+static inline bool bpf_is_jump_target(const struct bpf_verifier_env *env, int insn_idx)
 {
 	return env->insn_aux_data[insn_idx].jump_target;
 }
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 15600d0e1b57..6e4f07093c7c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1245,6 +1245,16 @@ bool bpf_jit_supports_kfunc_call(void);
 bool bpf_jit_supports_callx(void);
 bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_unwind(void);
+
+enum bpf_unwind_exit {
+	BPF_EXIT_RETURNS,
+	BPF_EXIT_UNWINDS,
+	BPF_EXIT_LOOK_AT_R3,
+};
+
+bool bpf_jit_unwind_site(const struct bpf_verifier_env *env, const struct bpf_prog *prog, int i);
+enum bpf_unwind_exit bpf_jit_unwind_exit(const struct bpf_verifier_env *env,
+					 const struct bpf_prog *prog, int i);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b16d74d2681a..14696555e8a5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3331,6 +3331,50 @@ bool __weak bpf_jit_supports_unwind(void)
 	return false;
 }
 
+/*
+ * A subprog that can unwind says so in r3 and its caller does
+ * 'if r3 != 0 goto pad' after the call. A JIT can keep that off the normal path.
+ * It doesn't emit the branch and adds an extable entry instead:
+ *   insn  = return address of the call - 1
+ *   fixup = pad - return address of the call
+ * - 1, because what follows the call can have an entry of its own.
+ * An exit with r3 != 0 looks its own return address up and returns to the pad.
+ * When there is no entry it returns as usual and the branch is there.
+ *
+ * Is insn i of the prog such a call?
+ */
+bool bpf_jit_unwind_site(const struct bpf_verifier_env *env, const struct bpf_prog *prog, int i)
+{
+	const struct bpf_insn *insn = &prog->insnsi[i];
+
+	if (!env || i + 1 >= prog->len)
+		return false;
+	if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn))
+		return false;
+	/*
+	 * No need to know the callee: the verifier lets r3 be read after
+	 * a call only when every callee seen there says something in it.
+	 */
+	return insn[1].code == (BPF_JMP | BPF_JNE | BPF_K) && !insn[1].imm &&
+	       insn[1].dst_reg == BPF_REG_UNWIND &&
+	       !bpf_is_jump_target(env, prog->aux->subprog_start + i + 1);
+}
+
+/* What does 'exit' at insn i of the prog do? */
+enum bpf_unwind_exit bpf_jit_unwind_exit(const struct bpf_verifier_env *env,
+					 const struct bpf_prog *prog, int i)
+{
+	const struct bpf_insn *insn = &prog->insnsi[i];
+
+	if (!env || !prog->aux->ret_unwind)
+		return BPF_EXIT_RETURNS;
+	if (!i || bpf_is_jump_target(env, prog->aux->subprog_start + i) ||
+	    insn[-1].code != (BPF_ALU64 | BPF_MOV | BPF_K) ||
+	    insn[-1].dst_reg != BPF_REG_UNWIND)
+		return BPF_EXIT_LOOK_AT_R3;
+	return insn[-1].imm ? BPF_EXIT_UNWINDS : BPF_EXIT_RETURNS;
+}
+
 /*
  * How this arch places a by-value kfunc argument, or NULL for one that has
  * not opted in and so only takes an argument of a single eightbyte, which
-- 
2.55.0

