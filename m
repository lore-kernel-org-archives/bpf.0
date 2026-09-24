Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FDB3DEFFB
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269558; cv=none; b=nwsHkSpzib0xgFBjznMitgBDF8aLQVZKfahJkwlUBA5DVGLXJxrah8bu1X7TlnzLQTvm3Eu9bwfAIYTZ3dQRGBBTBLSrGI2qD2vbvWf0+BkwYogdZ3gUkYs+X6OtXloVDDIzITCxCVCB+KZ/S+YuVoFHD+vqM/5iKffSJfGixo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269558; c=relaxed/simple;
	bh=iqBxYjagAMtLIuwhCjcao597qfTADeUUEVSR7cNbCHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4LZCnx+55RGny8yQls/fz/hjjxZOSRjxSqWdn+Xac9lFRcJRlm29ahblCouS16LTo2ombj1gxfwV9luJSgHjy9KnUTg53Y8Af6AMxkQYGdgVdNGXF3PgRoJZUVRYHVTNVumrXvzN4qcmruhGjliZ5cBQkkqYk96H7Qvzo9S5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kODyHaov; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kODyHaov"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=iqBxYjagAMtLIuwhCjcao597qfTADeUUEVSR7cNbCHA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790269553; v=1; x=1790874353;
 b=kODyHaovSjnZ9d3y6a0JeL5IP/L96O1sNwP2Ni2hwdT8PMJEaNvRfohVnr8JWULrZ0KYHr/0
 ddb6oamx5venXQlogrqTCP7bHD2k8D+F4YfmLn/9sPSRPhIew41bMQUl29c8sKa0pHt99TCesIE
 6W+ebb2aEv3Vu5t7Lq6SHmd8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6959aa49f6b346f4;
	Thu, 24 Sep 2026 17:05:52 +0000
X-Mizu-Trace-ID: 6959aa49f6b346f4
X-Migadu-Flow: FLOW_OUT
From: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Junseo Lim <zirajs7@gmail.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 2/3] bpf: Skip the progs of trampoline images that are being freed
Date: Thu, 24 Sep 2026 17:05:39 +0000
Message-ID: <20260924170543.1017048-3-florent.revest@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924170543.1017048-1-florent.revest@linux.dev>
References: <20260924170543.1017048-1-florent.revest@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_tramp_image_put() makes sure a trampoline image is not freed while
a task may still be running in it, but nothing similar is done for the
progs called by that image. Detach drops the last prog reference right
away and the prog is freed after grace periods, on the basis that a
task still in the traced function skips the fexit progs once the nop at
ip_after_call is patched to a jump.

That leaves out a task sleeping in a sleepable prog that runs before
the detached one, which no grace period waits for:

  CPU 0                               CPU 1
  in image I, sleeping in prog S
                                      detach P from I's trampoline
                                       -> new image, bpf_tramp_image_put(I)
                                      bpf_prog_put(P), last ref
                                      grace periods, P freed
  back from S
  __bpf_prog_enter(P)
  call P->bpf_func

If S and P are fexit progs the task is already past the patched jump,
and fentry only images don't have one. On x86 this is an int3 in
poisoned bpf_prog_pack memory:

  Oops: int3: 0000 [#1] SMP NOPTI
  CPU: 18 UID: 0 PID: 94573 Comm: x169 Not tainted 6.18.44 #1 PREEMPT(lazy)
  RIP: 0010:0xffffffffc0601d8d
  Call Trace:
   <TASK>
   ? bpf_trampoline_6442515411+0x1a4/0x21b
   bpf_lsm_bprm_committed_creds+0x5/0x10
   security_bprm_committed_creds+0x5f/0x70
   begin_new_exec+0x2d6/0x410
   ...

We hit this in production when progs attached through trampolines got
detached while their hooks were busy, and it was independently found
with a fuzzer and KASAN.

Extend what ip_after_call does to every prog: have the JITs emit a
patchable nop in front of each prog call sequence and record it in the
image, and have bpf_tramp_image_put() patch them all to jumps over the
call sequences, which replaces ip_after_call. Tasks that are still in an
image that was put skip all of its progs from then on, including the
ones that are still attached, like they already skipped its fexit
progs. The call to the original function is left alone, a task that is
before it in the image still has to run it.

With the extra nops, BPF_MAX_TRAMP_LINKS progs no longer fit in a page
on arm64 and loongarch (and already didn't on powerpc), so lower the
limit there like s390 does.

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>
Closes: https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: Claude:unspecified
Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c   | 33 ++++++++++++-----------
 arch/loongarch/net/bpf_jit.c    | 45 +++++++++++++++++---------------
 arch/powerpc/net/bpf_jit_comp.c | 45 ++++++++++++++++----------------
 arch/riscv/net/bpf_jit_comp64.c | 39 ++++++++++++++++------------
 arch/s390/net/bpf_jit_comp.c    | 46 +++++++++++++++++++++------------
 arch/x86/net/bpf_jit_comp.c     | 26 ++++++++++++-------
 include/linux/bpf.h             | 35 ++++++++++++++++++++++---
 kernel/bpf/trampoline.c         | 36 +++++++++++++++++---------
 8 files changed, 188 insertions(+), 117 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5f55d6161fe..e3a8e7e12127 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2418,10 +2418,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
-static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
-			    int bargs_off, int retval_off, int run_ctx_off,
-			    bool save_ret)
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			    struct bpf_tramp_node *node, int bargs_off,
+			    int retval_off, int run_ctx_off, bool save_ret)
 {
+	void *skip;
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
@@ -2431,6 +2432,10 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 	enter_prog = (u64)bpf_trampoline_enter(p);
 	exit_prog = (u64)bpf_trampoline_exit(p);
 
+	/* nop, patched to skip this prog when the image is put */
+	skip = ctx->ro_image + ctx->idx;
+	emit(A64_NOP, ctx);
+
 	if (node->cookie == 0) {
 		/* if cookie is zero, one instruction is enough to store it */
 		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
@@ -2483,11 +2488,13 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 	emit(A64_ADD_I(1, A64_R(2), A64_SP, run_ctx_off), ctx);
 
 	emit_call(exit_prog, ctx);
+
+	bpf_tramp_image_add_skip(im, skip, ctx->ro_image + ctx->idx);
 }
 
-static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_nodes *tn,
-			       int bargs_off, int retval_off, int run_ctx_off,
-			       __le32 **branches)
+static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			       struct bpf_tramp_nodes *tn, int bargs_off,
+			       int retval_off, int run_ctx_off, __le32 **branches)
 {
 	int i;
 
@@ -2496,7 +2503,7 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_nodes *tn,
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
 	for (i = 0; i < tn->nr_nodes; i++) {
-		invoke_bpf_prog(ctx, tn->nodes[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, im, tn->nodes[i], bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -2882,7 +2889,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, fentry->nodes[i], bargs_off,
+		invoke_bpf_prog(ctx, im, fentry->nodes[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 	}
@@ -2893,7 +2900,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		if (!branches)
 			return -ENOMEM;
 
-		invoke_bpf_mod_ret(ctx, fmod_ret, bargs_off, retval_off,
+		invoke_bpf_mod_ret(ctx, im, fmod_ret, bargs_off, retval_off,
 				   run_ctx_off, branches);
 	}
 
@@ -2906,9 +2913,6 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		emit(A64_RET(A64_R(10)), ctx);
 		/* store return value */
 		emit(A64_STR64I(A64_R(0), A64_SP, retval_off), ctx);
-		/* reserve a nop for bpf_tramp_image_put */
-		im->ip_after_call = ctx->ro_image + ctx->idx;
-		emit(A64_NOP, ctx);
 	}
 
 	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
@@ -2930,12 +2934,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, fexit->nodes[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, im, fexit->nodes[i], bargs_off, retval_off,
 				run_ctx_off, false);
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->ro_image + ctx->idx;
 		/* for the first pass, assume the worst case */
 		if (!ctx->image)
 			ctx->idx += 4;
@@ -2994,7 +2997,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		.image = NULL,
 		.idx = 0,
 	};
-	struct bpf_tramp_image im;
+	struct bpf_tramp_image im = {};
 	struct arg_aux aaux;
 	int ret;
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 4da278900938..d8a5ab288570 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1696,13 +1696,19 @@ static void restore_stk_args(struct jit_ctx *ctx, int nr_stk_args, int args_off,
 	}
 }
 
-static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
-			   int args_off, int retval_off, int run_ctx_off, bool save_ret)
+static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+			   struct bpf_tramp_node *n, int args_off, int retval_off,
+			   int run_ctx_off, bool save_ret)
 {
-	int ret;
+	int i, ret;
 	u32 *branch;
 	struct bpf_prog *p = n->link->prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+	void *skip = ctx->ro_image + ctx->idx;
+
+	/* nops for move_imm+jirl, patched to skip this prog when the image is put */
+	for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
+		emit_insn(ctx, nop);
 
 	if (n->cookie)
 		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1,
@@ -1755,13 +1761,17 @@ static int invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *n,
 	/* arg3: &run_ctx */
 	emit_insn(ctx, addid, LOONGARCH_GPR_A2, LOONGARCH_GPR_FP, -run_ctx_off);
 	ret = emit_call(ctx, (const u64)bpf_trampoline_exit(p));
+	if (ret)
+		return ret;
 
-	return ret;
+	bpf_tramp_image_add_skip(im, skip, ctx->ro_image + ctx->idx);
+	return 0;
 }
 
-static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_nodes *tn,
-		      int args_off, int retval_off, int run_ctx_off,
-		      int func_meta_off, bool save_ret, u64 func_meta, int cookie_off)
+static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_image *im,
+		      struct bpf_tramp_nodes *tn, int args_off, int retval_off,
+		      int run_ctx_off, int func_meta_off, bool save_ret,
+		      u64 func_meta, int cookie_off)
 {
 	int i, cur_cookie = (cookie_off - args_off) / 8;
 
@@ -1774,7 +1784,8 @@ static int invoke_bpf(struct jit_ctx *ctx, struct bpf_tramp_nodes *tn,
 			emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, meta);
 			cur_cookie--;
 		}
-		err = invoke_bpf_prog(ctx, tn->nodes[i], args_off, retval_off, run_ctx_off, save_ret);
+		err = invoke_bpf_prog(ctx, im, tn->nodes[i], args_off, retval_off,
+				      run_ctx_off, save_ret);
 		if (err)
 			return err;
 	}
@@ -2017,7 +2028,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	}
 
 	if (fentry->nr_nodes) {
-		ret = invoke_bpf(ctx, fentry, args_off, retval_off, run_ctx_off, func_meta_off,
+		ret = invoke_bpf(ctx, im, fentry, args_off, retval_off, run_ctx_off, func_meta_off,
 				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off);
 		if (ret)
 			return ret;
@@ -2029,7 +2040,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 
 		emit_insn(ctx, std, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_FP, -retval_off);
 		for (i = 0; i < fmod_ret->nr_nodes; i++) {
-			ret = invoke_bpf_prog(ctx, fmod_ret->nodes[i],
+			ret = invoke_bpf_prog(ctx, im, fmod_ret->nodes[i],
 					      args_off, retval_off, run_ctx_off, true);
 			if (ret)
 				goto out;
@@ -2051,10 +2062,6 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 			goto out;
 		emit_insn(ctx, std, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
 		emit_insn(ctx, std, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
-		im->ip_after_call = ctx->ro_image + ctx->idx;
-		/* Reserve space for the move_imm + jirl instruction */
-		for (i = 0; i < LOONGARCH_LONG_JUMP_NINSNS; i++)
-			emit_insn(ctx, nop);
 	}
 
 	for (i = 0; ctx->image && i < fmod_ret->nr_nodes; i++) {
@@ -2068,14 +2075,13 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 		emit_store_stack_imm64(ctx, LOONGARCH_GPR_T1, -func_meta_off, func_meta);
 
 	if (fexit->nr_nodes) {
-		ret = invoke_bpf(ctx, fexit, args_off, retval_off, run_ctx_off,
+		ret = invoke_bpf(ctx, im, fexit, args_off, retval_off, run_ctx_off,
 				 func_meta_off, false, func_meta, cookie_off);
 		if (ret)
 			goto out;
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->ro_image + ctx->idx;
 		move_addr(ctx, LOONGARCH_GPR_A0, (const u64)im);
 		ret = emit_call(ctx, (const u64)__bpf_tramp_exit);
 		if (ret)
@@ -2177,11 +2183,8 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	int ret;
-	struct jit_ctx ctx;
-	struct bpf_tramp_image im;
-
-	ctx.image = NULL;
-	ctx.idx = 0;
+	struct jit_ctx ctx = {};
+	struct bpf_tramp_image im = {};
 
 	ret = __arch_prepare_bpf_trampoline(&ctx, &im, m, tnodes, func_addr, flags);
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7b07b43575f1..5b71ae6f1014 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -602,14 +602,18 @@ int arch_protect_bpf_trampoline(void *image, unsigned int size)
 }
 
 static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ctx,
-			   struct bpf_tramp_node *n, int regs_off, int retval_off,
-			   int run_ctx_off, bool save_ret)
+			   struct bpf_tramp_image *im, struct bpf_tramp_node *n,
+			   int regs_off, int retval_off, int run_ctx_off, bool save_ret)
 {
 	struct bpf_prog *p = n->link->prog;
 	ppc_inst_t branch_insn;
-	u32 jmp_idx;
+	u32 jmp_idx, skip_idx;
 	int ret = 0;
 
+	/* nop, patched to skip this prog when the image is put */
+	skip_idx = ctx->idx;
+	EMIT(PPC_RAW_NOP());
+
 	/* Save cookie */
 	if (IS_ENABLED(CONFIG_PPC64)) {
 		PPC_LI64(_R3, n->cookie);
@@ -679,13 +683,17 @@ static int invoke_bpf_prog(u32 *image, u32 *ro_image, struct codegen_context *ct
 	EMIT(PPC_RAW_ADDI(_R5, _R1, run_ctx_off));
 	ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 					 (unsigned long)bpf_trampoline_exit(p));
+	if (ret)
+		return ret;
 
-	return ret;
+	if (ro_image) /* image is NULL for dummy pass */
+		bpf_tramp_image_add_skip(im, &ro_image[skip_idx], &ro_image[ctx->idx]);
+	return 0;
 }
 
 static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context *ctx,
-			      struct bpf_tramp_nodes *tn, int regs_off, int retval_off,
-			      int run_ctx_off, u32 *branches)
+			      struct bpf_tramp_image *im, struct bpf_tramp_nodes *tn,
+			      int regs_off, int retval_off, int run_ctx_off, u32 *branches)
 {
 	int i;
 
@@ -696,8 +704,8 @@ static int invoke_bpf_mod_ret(u32 *image, u32 *ro_image, struct codegen_context
 	EMIT(PPC_RAW_LI(_R3, 0));
 	EMIT(PPC_RAW_STL(_R3, _R1, retval_off));
 	for (i = 0; i < tn->nr_nodes; i++) {
-		if (invoke_bpf_prog(image, ro_image, ctx, tn->nodes[i], regs_off, retval_off,
-				    run_ctx_off, true))
+		if (invoke_bpf_prog(image, ro_image, ctx, im, tn->nodes[i], regs_off,
+				    retval_off, run_ctx_off, true))
 			return -EINVAL;
 
 		/*
@@ -1043,8 +1051,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			cookie_ctx_off--;
 		}
 
-		if (invoke_bpf_prog(image, ro_image, ctx, fentry->nodes[i], regs_off, retval_off,
-				    run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
+		if (invoke_bpf_prog(image, ro_image, ctx, im, fentry->nodes[i], regs_off,
+				    retval_off, run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
 	}
 
@@ -1053,7 +1061,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		if (!branches)
 			return -ENOMEM;
 
-		if (invoke_bpf_mod_ret(image, ro_image, ctx, fmod_ret, regs_off, retval_off,
+		if (invoke_bpf_mod_ret(image, ro_image, ctx, im, fmod_ret, regs_off, retval_off,
 				       run_ctx_off, branches)) {
 			ret = -EINVAL;
 			goto cleanup;
@@ -1090,11 +1098,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/* Restore updated tail_call_cnt */
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
 			bpf_trampoline_restore_tail_call_cnt(image, ctx, bpf_frame_size, r4_off);
-
-		/* Reserve space to patch branch instruction to skip fexit progs */
-		if (ro_image) /* image is NULL for dummy pass */
-			im->ip_after_call = &((u32 *)ro_image)[ctx->idx];
-		EMIT(PPC_RAW_NOP());
 	}
 
 	/* Update branches saved in invoke_bpf_mod_ret with address of do_fexit */
@@ -1123,16 +1126,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			cookie_ctx_off--;
 		}
 
-		if (invoke_bpf_prog(image, ro_image, ctx, fexit->nodes[i], regs_off, retval_off,
-				    run_ctx_off, false)) {
+		if (invoke_bpf_prog(image, ro_image, ctx, im, fexit->nodes[i], regs_off,
+				    retval_off, run_ctx_off, false)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		if (ro_image) /* image is NULL for dummy pass */
-			im->ip_epilogue = &((u32 *)ro_image)[ctx->idx];
 		PPC_LI_ADDR(_R3, im);
 		ret = bpf_jit_emit_func_call_rel(image, ro_image, ctx,
 						 (unsigned long)__bpf_tramp_exit);
@@ -1192,7 +1193,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
-	struct bpf_tramp_image im;
+	struct bpf_tramp_image im = {};
 	int ret;
 
 	ret = __arch_prepare_bpf_trampoline(&im, NULL, NULL, NULL, m, flags, tnodes, func_addr);
@@ -1320,7 +1321,7 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 
 	/*
 	 * If we are not poking at bpf prog entry, then we are simply patching in/out
-	 * an unconditional branch instruction at im->ip_after_call
+	 * an unconditional branch instruction in a trampoline image
 	 */
 	if (offset) {
 		if (old_t == BPF_MOD_CALL || new_t == BPF_MOD_CALL) {
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 151031e97a24..a4c6c4db23e0 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -904,12 +904,18 @@ static void emit_store_stack_imm64(u8 reg, int stack_off, u64 imm64,
 	emit_sd(RV_REG_FP, stack_off, reg, ctx);
 }
 
-static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, int retval_off,
-			   int run_ctx_off, bool save_ret, struct rv_jit_context *ctx)
+static int invoke_bpf_prog(struct bpf_tramp_image *im, struct bpf_tramp_node *node,
+			   int args_off, int retval_off, int run_ctx_off, bool save_ret,
+			   struct rv_jit_context *ctx)
 {
 	int ret, branch_off;
 	struct bpf_prog *p = node->link->prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
+	void *skip = ctx->ro_insns + ctx->ninsns;
+
+	/* 2 nops for auipc+jalr, patched to skip this prog when the image is put */
+	emit(rv_nop(), ctx);
+	emit(rv_nop(), ctx);
 
 	if (node->cookie)
 		emit_store_stack_imm64(RV_REG_T1, -run_ctx_off + cookie_off, node->cookie, ctx);
@@ -962,13 +968,17 @@ static int invoke_bpf_prog(struct bpf_tramp_node *node, int args_off, int retval
 	/* arg3: &run_ctx */
 	emit_addi(RV_REG_A2, RV_REG_FP, -run_ctx_off, ctx);
 	ret = emit_call((const u64)bpf_trampoline_exit(p), true, ctx);
+	if (ret)
+		return ret;
 
-	return ret;
+	bpf_tramp_image_add_skip(im, skip, ctx->ro_insns + ctx->ninsns);
+	return 0;
 }
 
-static int invoke_bpf(struct bpf_tramp_nodes *tn, int args_off, int retval_off,
-		      int run_ctx_off, int func_meta_off, bool save_ret, u64 func_meta,
-		      int cookie_off, struct rv_jit_context *ctx)
+static int invoke_bpf(struct bpf_tramp_image *im, struct bpf_tramp_nodes *tn,
+		      int args_off, int retval_off, int run_ctx_off, int func_meta_off,
+		      bool save_ret, u64 func_meta, int cookie_off,
+		      struct rv_jit_context *ctx)
 {
 	int i, cur_cookie = (cookie_off - args_off) / 8;
 
@@ -981,8 +991,8 @@ static int invoke_bpf(struct bpf_tramp_nodes *tn, int args_off, int retval_off,
 			emit_store_stack_imm64(RV_REG_T1, -func_meta_off, meta, ctx);
 			cur_cookie--;
 		}
-		err = invoke_bpf_prog(tn->nodes[i], args_off, retval_off, run_ctx_off,
-				      save_ret, ctx);
+		err = invoke_bpf_prog(im, tn->nodes[i], args_off, retval_off,
+				      run_ctx_off, save_ret, ctx);
 		if (err)
 			return err;
 	}
@@ -1170,7 +1180,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	}
 
 	if (fentry->nr_nodes) {
-		ret = invoke_bpf(fentry, args_off, retval_off, run_ctx_off, func_meta_off,
+		ret = invoke_bpf(im, fentry, args_off, retval_off, run_ctx_off, func_meta_off,
 				 flags & BPF_TRAMP_F_RET_FENTRY_RET, func_meta, cookie_off, ctx);
 		if (ret)
 			return ret;
@@ -1184,7 +1194,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* cleanup to avoid garbage return value confusion */
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_ZERO, ctx);
 		for (i = 0; i < fmod_ret->nr_nodes; i++) {
-			ret = invoke_bpf_prog(fmod_ret->nodes[i], args_off, retval_off,
+			ret = invoke_bpf_prog(im, fmod_ret->nodes[i], args_off, retval_off,
 					      run_ctx_off, true, ctx);
 			if (ret)
 				goto out;
@@ -1211,10 +1221,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 			emit_sd(RV_REG_FP, -tcc_off, RV_REG_TCC, ctx);
 		emit_sd(RV_REG_FP, -retval_off, RV_REG_A0, ctx);
 		emit_sd(RV_REG_FP, -(retval_off - 8), regmap[BPF_REG_0], ctx);
-		im->ip_after_call = ctx->ro_insns + ctx->ninsns;
-		/* 2 nops reserved for auipc+jalr pair */
-		emit(rv_nop(), ctx);
-		emit(rv_nop(), ctx);
 	}
 
 	/* update branches saved in invoke_bpf_mod_ret with bnez */
@@ -1230,14 +1236,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_store_stack_imm64(RV_REG_T1, -func_meta_off, func_meta, ctx);
 
 	if (fexit->nr_nodes) {
-		ret = invoke_bpf(fexit, args_off, retval_off, run_ctx_off, func_meta_off,
+		ret = invoke_bpf(im, fexit, args_off, retval_off, run_ctx_off, func_meta_off,
 				 false, func_meta, cookie_off, ctx);
 		if (ret)
 			goto out;
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = ctx->ro_insns + ctx->ninsns;
 		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
 		ret = emit_call((const u64)__bpf_tramp_exit, true, ctx);
 		if (ret)
@@ -1299,7 +1304,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
-	struct bpf_tramp_image im;
+	struct bpf_tramp_image im = {};
 	struct rv_jit_context ctx;
 	int ret;
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index c4b47070bb59..2c18f2a142a9 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2566,6 +2566,8 @@ struct bpf_tramp_jit {
 	int r14_off;		/* Offset of saved %r14, has to be at the
 				 * bottom */
 	int do_fexit;		/* do_fexit: label */
+	int skip[BPF_MAX_TRAMP_LINKS];	/* skip: labels after each prog */
+	int nr_progs;
 };
 
 static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
@@ -2584,6 +2586,7 @@ static void emit_store_stack_imm64(struct bpf_jit *jit, int tmp_reg, int stack_o
 }
 
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
+			   struct bpf_tramp_image *im,
 			   const struct btf_func_model *m,
 			   struct bpf_tramp_node *node, bool save_ret)
 {
@@ -2591,8 +2594,20 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	int cookie_off = tjit->run_ctx_off +
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p = node->link->prog;
+	void *skip = jit->prg_buf + jit->prg;
+	int idx = tjit->nr_progs++;
 	int patch;
 
+	if (idx >= ARRAY_SIZE(tjit->skip))
+		return -E2BIG;
+
+	/*
+	 * nop, patched to skip this prog when the image is put
+	 */
+
+	/* brcl 0,skip */
+	EMIT6_PCREL_RILC(0xc0040000, 0, tjit->skip[idx]);
+
 	/*
 	 * run_ctx.cookie = node->cookie;
 	 */
@@ -2652,10 +2667,15 @@ static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 	/* brasl %r14,__bpf_prog_exit */
 	EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, bpf_trampoline_exit(p));
 
+	/* skip: */
+	tjit->skip[idx] = jit->prg;
+	bpf_tramp_image_add_skip(im, skip, jit->prg_buf + jit->prg);
+
 	return 0;
 }
 
 static int invoke_bpf(struct bpf_tramp_jit *tjit,
+		      struct bpf_tramp_image *im,
 		      const struct btf_func_model *m,
 		      struct bpf_tramp_nodes *tn, bool save_ret,
 		      u64 func_meta, int cookie_off)
@@ -2670,7 +2690,7 @@ static int invoke_bpf(struct bpf_tramp_jit *tjit,
 			emit_store_stack_imm64(jit, REG_0, tjit->func_meta_off, meta);
 			cur_cookie--;
 		}
-		if (invoke_bpf_prog(tjit, m, tn->nodes[i], save_ret))
+		if (invoke_bpf_prog(tjit, im, m, tn->nodes[i], save_ret))
 			return -EINVAL;
 	}
 
@@ -2712,6 +2732,11 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 	u64 func_meta;
 	int i, j;
 
+	/* The skip labels are taken from the previous pass. */
+	tjit->nr_progs = 0;
+	if (im)
+		im->nr_skips = 0;
+
 	/* Support as many stack arguments as "mvc" instruction can handle. */
 	nr_reg_args = min_t(int, m->nr_args, MAX_NR_REG_ARGS);
 	nr_stack_args = m->nr_args - nr_reg_args;
@@ -2875,7 +2900,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		emit_store_stack_imm64(jit, REG_0, tjit->retval_off, 0);
 	}
 
-	if (invoke_bpf(tjit, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
+	if (invoke_bpf(tjit, im, m, fentry, flags & BPF_TRAMP_F_RET_FENTRY_RET,
 		       func_meta, cookie_off))
 		return -EINVAL;
 
@@ -2889,7 +2914,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		       0xf000 | tjit->retval_off);
 
 		for (i = 0; i < fmod_ret->nr_nodes; i++) {
-			if (invoke_bpf_prog(tjit, m, fmod_ret->nodes[i], true))
+			if (invoke_bpf_prog(tjit, im, m, fmod_ret->nodes[i], true))
 				return -EINVAL;
 
 			/*
@@ -2943,15 +2968,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		/* mvc tccnt_off(%r15),tail_call_cnt(4,%r15) */
 		_EMIT6(0xd203f000 | tjit->tccnt_off,
 		       0xf000 | offsetof(struct prog_frame, tail_call_cnt));
-
-		im->ip_after_call = jit->prg_buf + jit->prg;
-
-		/*
-		 * The following nop will be patched by bpf_tramp_image_put().
-		 */
-
-		/* brcl 0,im->ip_epilogue */
-		EMIT6_PCREL_RILC(0xc0040000, 0, (u64)im->ip_epilogue);
 	}
 
 	/* Set the "is_return" flag for fsession. */
@@ -2962,12 +2978,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
-	if (invoke_bpf(tjit, m, fexit, false, func_meta, cookie_off))
+	if (invoke_bpf(tjit, im, m, fexit, false, func_meta, cookie_off))
 		return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = jit->prg_buf + jit->prg;
-
 		/*
 		 * __bpf_tramp_exit(im);
 		 */
@@ -3016,7 +3030,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *orig_call)
 {
-	struct bpf_tramp_image im;
+	struct bpf_tramp_image im = {};
 	struct bpf_tramp_jit tjit;
 	int ret;
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2853e87797a7..7ef5c8efc882 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3217,16 +3217,21 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
+			   struct bpf_tramp_image *im,
 			   struct bpf_tramp_node *node, int stack_size,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
-	u8 *jmp_insn;
+	u8 *jmp_insn, *skip;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 	struct bpf_prog *p = node->link->prog;
 	u64 cookie = node->cookie;
 
+	/* nop, patched to skip this prog when the image is put */
+	skip = image + (prog - (u8 *)rw_image);
+	emit_nops(&prog, X86_PATCH_SIZE);
+
 	/* mov rdi, cookie */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
 
@@ -3301,6 +3306,8 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	if (emit_rsb_call(&prog, bpf_trampoline_exit(p), image + (prog - (u8 *)rw_image)))
 		return -EINVAL;
 
+	bpf_tramp_image_add_skip(im, skip, image + (prog - (u8 *)rw_image));
+
 	*pprog = prog;
 	return 0;
 }
@@ -3332,6 +3339,7 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
+		      struct bpf_tramp_image *im,
 		      struct bpf_tramp_nodes *tl, int stack_size,
 		      int run_ctx_off, int func_meta_off, bool save_ret,
 		      void *image, void *rw_image, u64 func_meta,
@@ -3346,7 +3354,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 				func_meta | (cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT));
 			cur_cookie--;
 		}
-		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size,
+		if (invoke_bpf_prog(m, &prog, im, tl->nodes[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
@@ -3355,6 +3363,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 }
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
+			      struct bpf_tramp_image *im,
 			      struct bpf_tramp_nodes *tl, int stack_size,
 			      int run_ctx_off, u8 **branches,
 			      void *image, void *rw_image)
@@ -3368,7 +3377,7 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 	for (i = 0; i < tl->nr_nodes; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size, run_ctx_off, true,
+		if (invoke_bpf_prog(m, &prog, im, tl->nodes[i], stack_size, run_ctx_off, true,
 				    image, rw_image))
 			return -EINVAL;
 
@@ -3640,7 +3649,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (fentry->nr_nodes) {
-		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, func_meta_off,
+		if (invoke_bpf(m, &prog, im, fentry, regs_off, run_ctx_off, func_meta_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
 			       func_meta, cookie_off))
 			return -EINVAL;
@@ -3652,7 +3661,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		if (!branches)
 			return -ENOMEM;
 
-		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
+		if (invoke_bpf_mod_ret(m, &prog, im, fmod_ret, regs_off,
 				       run_ctx_off, branches, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
@@ -3682,8 +3691,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-		im->ip_after_call = image + (prog - (u8 *)rw_image);
-		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 
 	if (fmod_ret->nr_nodes) {
@@ -3708,7 +3715,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
 
 	if (fexit->nr_nodes) {
-		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, func_meta_off,
+		if (invoke_bpf(m, &prog, im, fexit, regs_off, run_ctx_off, func_meta_off,
 			       false, image, rw_image, func_meta, cookie_off)) {
 			ret = -EINVAL;
 			goto cleanup;
@@ -3723,7 +3730,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 * restored to R0.
 	 */
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		im->ip_epilogue = image + (prog - (u8 *)rw_image);
 		/* arg1: mov rdi, im */
 		emit_mov_imm64(&prog, BPF_REG_1, (long) im >> 32, (u32) (long) im);
 		if (emit_rsb_call(&prog, __bpf_tramp_exit, image + (prog - (u8 *)rw_image))) {
@@ -3811,7 +3817,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
-	struct bpf_tramp_image im;
+	struct bpf_tramp_image im = {};
 	void *image;
 	int ret;
 
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d4f732996b47..9c61803380c2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1258,11 +1258,15 @@ struct btf_func_model {
 #define BPF_TRAMP_F_INDIRECT		BIT(8)
 
 /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
- * bytes on x86.
+ * bytes on x86. The trampoline image has to fit in PAGE_SIZE.
  */
 enum {
-#if defined(__s390x__)
+#if defined(__s390x__) || defined(__powerpc64__)
 	BPF_MAX_TRAMP_LINKS = 27,
+#elif defined(__loongarch__)
+	BPF_MAX_TRAMP_LINKS = 33,
+#elif defined(__aarch64__)
+	BPF_MAX_TRAMP_LINKS = 37,
 #else
 	BPF_MAX_TRAMP_LINKS = 38,
 #endif
@@ -1363,19 +1367,42 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_FSESSION,
 };
 
+/*
+ * Each prog call in a trampoline image is preceded by a nop. When the image is
+ * put, the nops are patched to jumps to target, right after each call, so that
+ * tasks still running in the image skip the progs, which can be freed by then.
+ */
+struct bpf_tramp_skip {
+	void *nop;
+	void *target;
+};
+
 struct bpf_tramp_image {
 	void *image;
 	int size;
 	struct bpf_ksym ksym;
 	struct percpu_ref pcref;
-	void *ip_after_call;
-	void *ip_epilogue;
+	bool call_orig;
+	int nr_skips;
+	struct bpf_tramp_skip *skips;
 	union {
 		struct rcu_head rcu;
 		struct work_struct work;
 	};
 };
 
+static inline void bpf_tramp_image_add_skip(struct bpf_tramp_image *im, void *nop, void *target)
+{
+	struct bpf_tramp_skip *skip;
+
+	/* struct_ops trampolines and arch_bpf_trampoline_size() have no image */
+	if (!im || !im->skips)
+		return;
+	skip = &im->skips[im->nr_skips++];
+	skip->nop = nop;
+	skip->target = target;
+}
+
 struct bpf_trampoline {
 	/* hlist for trampoline_key_table */
 	struct hlist_node hlist_key;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 9d69c066a817..0d7aa1b0fe30 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -565,6 +565,7 @@ static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 	arch_free_bpf_trampoline(im->image, im->size);
 	bpf_jit_uncharge_modmem(im->size);
 	percpu_ref_exit(&im->pcref);
+	kfree(im->skips);
 	kfree_rcu(im, rcu);
 }
 
@@ -601,7 +602,7 @@ static void __bpf_tramp_image_put_rcu_tasks(struct rcu_head *rcu)
 	struct bpf_tramp_image *im;
 
 	im = container_of(rcu, struct bpf_tramp_image, rcu);
-	if (im->ip_after_call)
+	if (im->call_orig)
 		/* the case of fmod_ret/fexit trampoline and CONFIG_PREEMPTION=y */
 		percpu_ref_kill(&im->pcref);
 	else
@@ -611,6 +612,8 @@ static void __bpf_tramp_image_put_rcu_tasks(struct rcu_head *rcu)
 
 static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 {
+	int i, err;
+
 	/* The trampoline image that calls original function is using:
 	 * rcu_read_lock_trace to protect sleepable bpf progs
 	 * rcu_read_lock to protect normal bpf progs
@@ -621,10 +624,17 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	 *
 	 * The trampoline is unreachable before bpf_tramp_image_put().
 	 *
-	 * First, patch the trampoline to avoid calling into fexit progs.
-	 * The progs will be freed even if the original function is still
-	 * executing or sleeping.
-	 * In case of CONFIG_PREEMPT=y use call_rcu_tasks() to wait on
+	 * First, patch the trampoline to avoid calling into progs. The progs
+	 * will be freed even if a task is still in the trampoline, e.g.
+	 * sleeping in the original function or in a sleepable prog.
+	 */
+	for (i = 0; i < im->nr_skips; i++) {
+		err = bpf_arch_text_poke(im->skips[i].nop, BPF_MOD_NOP,
+					 BPF_MOD_JUMP, NULL, im->skips[i].target);
+		WARN_ON_ONCE(err);
+	}
+
+	/* In case of CONFIG_PREEMPT=y use call_rcu_tasks() to wait on
 	 * first few asm instructions to execute and call into
 	 * __bpf_tramp_enter->percpu_ref_get.
 	 * Then use percpu_ref_kill to wait for the trampoline and the original
@@ -637,11 +647,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	 * percpu_ref_kill will be waiting for. Hence the first
 	 * call_rcu_tasks() is not necessary.
 	 */
-	if (im->ip_after_call) {
-		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_NOP,
-					     BPF_MOD_JUMP, NULL,
-					     im->ip_epilogue);
-		WARN_ON(err);
+	if (im->call_orig) {
 		if (IS_ENABLED(CONFIG_TASKS_RCU))
 			call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 		else
@@ -658,7 +664,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 }
 
-static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
+static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size, int nr_progs)
 {
 	struct bpf_tramp_image *im;
 	struct bpf_ksym *ksym;
@@ -669,6 +675,10 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 	if (!im)
 		goto out;
 
+	im->skips = kzalloc_objs(*im->skips, nr_progs);
+	if (!im->skips)
+		goto out_free_im;
+
 	err = bpf_jit_charge_modmem(size);
 	if (err)
 		goto out_free_im;
@@ -695,6 +705,7 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
 out_uncharge:
 	bpf_jit_uncharge_modmem(size);
 out_free_im:
+	kfree(im->skips);
 	kfree(im);
 out:
 	return ERR_PTR(err);
@@ -771,11 +782,12 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		goto out;
 	}
 
-	im = bpf_tramp_image_alloc(tr->key, size);
+	im = bpf_tramp_image_alloc(tr->key, size, total);
 	if (IS_ERR(im)) {
 		err = PTR_ERR(im);
 		goto out;
 	}
+	im->call_orig = tr->flags & BPF_TRAMP_F_CALL_ORIG;
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
 					  &tr->func.model, tr->flags, tnodes,
-- 
2.55.0

