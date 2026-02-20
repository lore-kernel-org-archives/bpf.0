Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC33266B67;
	Fri, 20 Feb 2026 10:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771582075; cv=none; b=e0PUzTD3xnp/6s/xSF9QPr/WifQFilmNdYnj4R/lwhWPihW4O3+VWeVXuW1RtBO4F92Zm34S5wEcAEyox/7SGd4GdSF6ulpTa3EONc84WFFqFLwUdL9aHHU9D8hIQNSaYcAgPU9zPpQh2V/jaO8Hlh5VJIRbKuPKxk73895Xek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771582075; c=relaxed/simple;
	bh=NfxIviFqpdUPYoFvJdczyGxBCwxhTi1Joc+OtFr0j6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B17UE+l/bkSsOJgzAlMWWYinTvcOgTtlOu+CGMf8OUeT+/5yj2hn/OEZW3zJQm5WsnVXK/VPP8+oBrevJsMdqXj7LKusbg8KUEvDfj9WBFQXHFHm5G42NH6HhLDzAkSdxr75izRI859Qi+BfqHcNB9uAI22Ckv14ZBtCRSBEmMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWMWfjcZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWMWfjcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3504C116C6;
	Fri, 20 Feb 2026 10:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771582074;
	bh=NfxIviFqpdUPYoFvJdczyGxBCwxhTi1Joc+OtFr0j6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWMWfjcZOLTHgZJYxSGh3ywRCxlViR78OblPmyO0yE83OoQLzcI0TA/PC0SXjmXHK
	 6jqCmxoUuwcWkQccpWtWKCX2t7Nqjz80T/AvdTEEMpg28lKytIJvaktqsH/s0mV/8T
	 B2E4i2nwVLK5tbQKrAmCjav9StQUG7kKMEc4y0qtfdnMZYMBLmDpmUIyZqoufxyFU6
	 wcgYOETyVErha/tIEAJydoxXunalZkEXooqCq4MEgqhV93tRQuNjh7Zab8r5k51kvQ
	 padpsXjr5gdVFNo1Qn6yEQw06wfq4fZHAX2eJp3WtcRHPQsBjjmhA5YIRZlzYoLRZ8
	 307oatumK2IWw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCH bpf-next 04/17] bpf: Add struct bpf_tramp_node object
Date: Fri, 20 Feb 2026 11:06:36 +0100
Message-ID: <20260220100649.628307-5-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220100649.628307-1-jolsa@kernel.org>
References: <20260220100649.628307-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding struct bpf_tramp_node to decouple the link out of the trampoline
attachment info.

At the moment the object for attaching bpf program to the trampoline is
'struct bpf_tramp_link':

  struct bpf_tramp_link {
       struct bpf_link link;
       struct hlist_node tramp_hlist;
       u64 cookie;
  }

The link holds the bpf_prog pointer and forces one link - one program
binding logic. In following changes we want to attach program to multiple
trampolines but we want to keep just one bpf_link object.

Splitting struct bpf_tramp_link into:

  struct bpf_tramp_link {
       struct bpf_link link;
       struct bpf_tramp_node node;
  };

  struct bpf_tramp_node {
       struct bpf_link *link;
       struct hlist_node tramp_hlist;
       u64 cookie;
  };

The 'struct bpf_tramp_link' defines standard single trampoline link
and 'struct bpf_tramp_node' is the attachment trampoline object with
pointer to the bpf_link object.

This will allow us to define link for multiple trampolines, like:

  struct bpf_tracing_multi_link {
       struct bpf_link link;
       ...
       int nodes_cnt;
       struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
  };

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/arm64/net/bpf_jit_comp.c  |  58 +++++++++---------
 arch/s390/net/bpf_jit_comp.c   |  42 ++++++-------
 arch/x86/net/bpf_jit_comp.c    |  54 ++++++++---------
 include/linux/bpf.h            |  56 +++++++++++-------
 kernel/bpf/bpf_struct_ops.c    |  27 +++++----
 kernel/bpf/syscall.c           |  39 ++++++------
 kernel/bpf/trampoline.c        | 105 ++++++++++++++++-----------------
 net/bpf/bpf_dummy_struct_ops.c |  14 ++---
 8 files changed, 207 insertions(+), 188 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 7a530ea4f5ae..bca0e9df7767 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2288,24 +2288,24 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return true;
 }
 
-static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
+static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_node *node,
 			    int bargs_off, int retval_off, int run_ctx_off,
 			    bool save_ret)
 {
 	__le32 *branch;
 	u64 enter_prog;
 	u64 exit_prog;
-	struct bpf_prog *p = l->link.prog;
+	struct bpf_prog *p = node->link->prog;
 	int cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
 
 	enter_prog = (u64)bpf_trampoline_enter(p);
 	exit_prog = (u64)bpf_trampoline_exit(p);
 
-	if (l->cookie == 0) {
+	if (node->cookie == 0) {
 		/* if cookie is zero, one instruction is enough to store it */
 		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
 	} else {
-		emit_a64_mov_i64(A64_R(10), l->cookie, ctx);
+		emit_a64_mov_i64(A64_R(10), node->cookie, ctx);
 		emit(A64_STR64I(A64_R(10), A64_SP, run_ctx_off + cookie_off),
 		     ctx);
 	}
@@ -2355,7 +2355,7 @@ static void invoke_bpf_prog(struct jit_ctx *ctx, struct bpf_tramp_link *l,
 	emit_call(exit_prog, ctx);
 }
 
-static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
+static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_nodes *tn,
 			       int bargs_off, int retval_off, int run_ctx_off,
 			       __le32 **branches)
 {
@@ -2365,8 +2365,8 @@ static void invoke_bpf_mod_ret(struct jit_ctx *ctx, struct bpf_tramp_links *tl,
 	 * Set this to 0 to avoid confusing the program.
 	 */
 	emit(A64_STR64I(A64_ZR, A64_SP, retval_off), ctx);
-	for (i = 0; i < tl->nr_links; i++) {
-		invoke_bpf_prog(ctx, tl->links[i], bargs_off, retval_off,
+	for (i = 0; i < tn->nr_nodes; i++) {
+		invoke_bpf_prog(ctx, tn->nodes[i], bargs_off, retval_off,
 				run_ctx_off, true);
 		/* if (*(u64 *)(sp + retval_off) !=  0)
 		 *	goto do_fexit;
@@ -2497,10 +2497,10 @@ static void restore_args(struct jit_ctx *ctx, int bargs_off, int nregs)
 	}
 }
 
-static bool is_struct_ops_tramp(const struct bpf_tramp_links *fentry_links)
+static bool is_struct_ops_tramp(const struct bpf_tramp_nodes *fentry_nodes)
 {
-	return fentry_links->nr_links == 1 &&
-		fentry_links->links[0]->link.type == BPF_LINK_TYPE_STRUCT_OPS;
+	return fentry_nodes->nr_nodes == 1 &&
+		fentry_nodes->nodes[0]->link->type == BPF_LINK_TYPE_STRUCT_OPS;
 }
 
 static void store_func_meta(struct jit_ctx *ctx, u64 func_meta, int func_meta_off)
@@ -2521,7 +2521,7 @@ static void store_func_meta(struct jit_ctx *ctx, u64 func_meta, int func_meta_of
  *
  */
 static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
-			      struct bpf_tramp_links *tlinks, void *func_addr,
+			      struct bpf_tramp_nodes *tnodes, void *func_addr,
 			      const struct btf_func_model *m,
 			      const struct arg_aux *a,
 			      u32 flags)
@@ -2537,14 +2537,14 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	int run_ctx_off;
 	int oargs_off;
 	int nfuncargs;
-	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
-	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
-	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
 	bool save_ret;
 	__le32 **branches = NULL;
 	bool is_struct_ops = is_struct_ops_tramp(fentry);
 	int cookie_off, cookie_cnt, cookie_bargs_off;
-	int fsession_cnt = bpf_fsession_cnt(tlinks);
+	int fsession_cnt = bpf_fsession_cnt(tnodes);
 	u64 func_meta;
 
 	/* trampoline stack layout:
@@ -2590,7 +2590,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	cookie_off = stack_size;
 	/* room for session cookies */
-	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);
 	stack_size += cookie_cnt * 8;
 
 	ip_off = stack_size;
@@ -2687,20 +2687,20 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	cookie_bargs_off = (bargs_off - cookie_off) / 8;
-	for (i = 0; i < fentry->nr_links; i++) {
-		if (bpf_prog_calls_session_cookie(fentry->links[i])) {
+	for (i = 0; i < fentry->nr_nodes; i++) {
+		if (bpf_prog_calls_session_cookie(fentry->nodes[i])) {
 			u64 meta = func_meta | (cookie_bargs_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
 
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, fentry->links[i], bargs_off,
+		invoke_bpf_prog(ctx, fentry->nodes[i], bargs_off,
 				retval_off, run_ctx_off,
 				flags & BPF_TRAMP_F_RET_FENTRY_RET);
 	}
 
-	if (fmod_ret->nr_links) {
-		branches = kcalloc(fmod_ret->nr_links, sizeof(__le32 *),
+	if (fmod_ret->nr_nodes) {
+		branches = kcalloc(fmod_ret->nr_nodes, sizeof(__le32 *),
 				   GFP_KERNEL);
 		if (!branches)
 			return -ENOMEM;
@@ -2724,7 +2724,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	}
 
 	/* update the branches saved in invoke_bpf_mod_ret with cbnz */
-	for (i = 0; i < fmod_ret->nr_links && ctx->image != NULL; i++) {
+	for (i = 0; i < fmod_ret->nr_nodes && ctx->image != NULL; i++) {
 		int offset = &ctx->image[ctx->idx] - branches[i];
 		*branches[i] = cpu_to_le32(A64_CBNZ(1, A64_R(10), offset));
 	}
@@ -2735,14 +2735,14 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 		store_func_meta(ctx, func_meta, func_meta_off);
 
 	cookie_bargs_off = (bargs_off - cookie_off) / 8;
-	for (i = 0; i < fexit->nr_links; i++) {
-		if (bpf_prog_calls_session_cookie(fexit->links[i])) {
+	for (i = 0; i < fexit->nr_nodes; i++) {
+		if (bpf_prog_calls_session_cookie(fexit->nodes[i])) {
 			u64 meta = func_meta | (cookie_bargs_off << BPF_TRAMP_COOKIE_INDEX_SHIFT);
 
 			store_func_meta(ctx, meta, func_meta_off);
 			cookie_bargs_off--;
 		}
-		invoke_bpf_prog(ctx, fexit->links[i], bargs_off, retval_off,
+		invoke_bpf_prog(ctx, fexit->nodes[i], bargs_off, retval_off,
 				run_ctx_off, false);
 	}
 
@@ -2800,7 +2800,7 @@ bool bpf_jit_supports_fsession(void)
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr)
+			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct jit_ctx ctx = {
 		.image = NULL,
@@ -2814,7 +2814,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	if (ret < 0)
 		return ret;
 
-	ret = prepare_trampoline(&ctx, &im, tlinks, func_addr, m, &aaux, flags);
+	ret = prepare_trampoline(&ctx, &im, tnodes, func_addr, m, &aaux, flags);
 	if (ret < 0)
 		return ret;
 
@@ -2838,7 +2838,7 @@ int arch_protect_bpf_trampoline(void *image, unsigned int size)
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 				void *ro_image_end, const struct btf_func_model *m,
-				u32 flags, struct bpf_tramp_links *tlinks,
+				u32 flags, struct bpf_tramp_nodes *tnodes,
 				void *func_addr)
 {
 	u32 size = ro_image_end - ro_image;
@@ -2865,7 +2865,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	ret = calc_arg_aux(m, &aaux);
 	if (ret)
 		goto out;
-	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, m, &aaux, flags);
+	ret = prepare_trampoline(&ctx, im, tnodes, func_addr, m, &aaux, flags);
 
 	if (ret > 0 && validate_code(&ctx) < 0) {
 		ret = -EINVAL;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 579461d471bb..1cc8a642297a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2508,20 +2508,20 @@ static void load_imm64(struct bpf_jit *jit, int dst_reg, u64 val)
 
 static int invoke_bpf_prog(struct bpf_tramp_jit *tjit,
 			   const struct btf_func_model *m,
-			   struct bpf_tramp_link *tlink, bool save_ret)
+			   struct bpf_tramp_node *node, bool save_ret)
 {
 	struct bpf_jit *jit = &tjit->common;
 	int cookie_off = tjit->run_ctx_off +
 			 offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = tlink->link.prog;
+	struct bpf_prog *p = node->link->prog;
 	int patch;
 
 	/*
-	 * run_ctx.cookie = tlink->cookie;
+	 * run_ctx.cookie = node->cookie;
 	 */
 
-	/* %r0 = tlink->cookie */
-	load_imm64(jit, REG_W0, tlink->cookie);
+	/* %r0 = node->cookie */
+	load_imm64(jit, REG_W0, node->cookie);
 	/* stg %r0,cookie_off(%r15) */
 	EMIT6_DISP_LH(0xe3000000, 0x0024, REG_W0, REG_0, REG_15, cookie_off);
 
@@ -2603,12 +2603,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 					 struct bpf_tramp_jit *tjit,
 					 const struct btf_func_model *m,
 					 u32 flags,
-					 struct bpf_tramp_links *tlinks,
+					 struct bpf_tramp_nodes *nodes,
 					 void *func_addr)
 {
-	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
-	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
-	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_nodes *fmod_ret = &nodes[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_nodes *fentry = &nodes[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_nodes *fexit = &nodes[BPF_TRAMP_FEXIT];
 	int nr_bpf_args, nr_reg_args, nr_stack_args;
 	struct bpf_jit *jit = &tjit->common;
 	int arg, bpf_arg_off;
@@ -2767,12 +2767,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		EMIT6_PCREL_RILB_PTR(0xc0050000, REG_14, __bpf_tramp_enter);
 	}
 
-	for (i = 0; i < fentry->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fentry->links[i],
+	for (i = 0; i < fentry->nr_nodes; i++)
+		if (invoke_bpf_prog(tjit, m, fentry->nodes[i],
 				    flags & BPF_TRAMP_F_RET_FENTRY_RET))
 			return -EINVAL;
 
-	if (fmod_ret->nr_links) {
+	if (fmod_ret->nr_nodes) {
 		/*
 		 * retval = 0;
 		 */
@@ -2781,8 +2781,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		_EMIT6(0xd707f000 | tjit->retval_off,
 		       0xf000 | tjit->retval_off);
 
-		for (i = 0; i < fmod_ret->nr_links; i++) {
-			if (invoke_bpf_prog(tjit, m, fmod_ret->links[i], true))
+		for (i = 0; i < fmod_ret->nr_nodes; i++) {
+			if (invoke_bpf_prog(tjit, m, fmod_ret->nodes[i], true))
 				return -EINVAL;
 
 			/*
@@ -2849,8 +2849,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 
 	/* do_fexit: */
 	tjit->do_fexit = jit->prg;
-	for (i = 0; i < fexit->nr_links; i++)
-		if (invoke_bpf_prog(tjit, m, fexit->links[i], false))
+	for (i = 0; i < fexit->nr_nodes; i++)
+		if (invoke_bpf_prog(tjit, m, fexit->nodes[i], false))
 			return -EINVAL;
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
@@ -2902,7 +2902,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *orig_call)
+			     struct bpf_tramp_nodes *tnodes, void *orig_call)
 {
 	struct bpf_tramp_image im;
 	struct bpf_tramp_jit tjit;
@@ -2911,14 +2911,14 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 	memset(&tjit, 0, sizeof(tjit));
 
 	ret = __arch_prepare_bpf_trampoline(&im, &tjit, m, flags,
-					    tlinks, orig_call);
+					    tnodes, orig_call);
 
 	return ret < 0 ? ret : tjit.common.prg;
 }
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 				void *image_end, const struct btf_func_model *m,
-				u32 flags, struct bpf_tramp_links *tlinks,
+				u32 flags, struct bpf_tramp_nodes *tnodes,
 				void *func_addr)
 {
 	struct bpf_tramp_jit tjit;
@@ -2927,7 +2927,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	/* Compute offsets, check whether the code fits. */
 	memset(&tjit, 0, sizeof(tjit));
 	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
-					    tlinks, func_addr);
+					    tnodes, func_addr);
 
 	if (ret < 0)
 		return ret;
@@ -2941,7 +2941,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	tjit.common.prg = 0;
 	tjit.common.prg_buf = image;
 	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
-					    tlinks, func_addr);
+					    tnodes, func_addr);
 
 	return ret < 0 ? ret : tjit.common.prg;
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 070ba80e39d7..c5eab786780e 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2978,15 +2978,15 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 }
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
-			   struct bpf_tramp_link *l, int stack_size,
+			   struct bpf_tramp_node *node, int stack_size,
 			   int run_ctx_off, bool save_ret,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
 	u8 *jmp_insn;
 	int ctx_cookie_off = offsetof(struct bpf_tramp_run_ctx, bpf_cookie);
-	struct bpf_prog *p = l->link.prog;
-	u64 cookie = l->cookie;
+	struct bpf_prog *p = node->link->prog;
+	u64 cookie = node->cookie;
 
 	/* mov rdi, cookie */
 	emit_mov_imm64(&prog, BPF_REG_1, (long) cookie >> 32, (u32) (long) cookie);
@@ -3093,7 +3093,7 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 }
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
-		      struct bpf_tramp_links *tl, int stack_size,
+		      struct bpf_tramp_nodes *tl, int stack_size,
 		      int run_ctx_off, int func_meta_off, bool save_ret,
 		      void *image, void *rw_image, u64 func_meta,
 		      int cookie_off)
@@ -3101,13 +3101,13 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 	int i, cur_cookie = (cookie_off - stack_size) / 8;
 	u8 *prog = *pprog;
 
-	for (i = 0; i < tl->nr_links; i++) {
-		if (tl->links[i]->link.prog->call_session_cookie) {
+	for (i = 0; i < tl->nr_nodes; i++) {
+		if (tl->nodes[i]->link->prog->call_session_cookie) {
 			emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off,
 				func_meta | (cur_cookie << BPF_TRAMP_COOKIE_INDEX_SHIFT));
 			cur_cookie--;
 		}
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
+		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size,
 				    run_ctx_off, save_ret, image, rw_image))
 			return -EINVAL;
 	}
@@ -3116,7 +3116,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 }
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
-			      struct bpf_tramp_links *tl, int stack_size,
+			      struct bpf_tramp_nodes *tl, int stack_size,
 			      int run_ctx_off, u8 **branches,
 			      void *image, void *rw_image)
 {
@@ -3128,8 +3128,8 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	 */
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
-	for (i = 0; i < tl->nr_links; i++) {
-		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
+	for (i = 0; i < tl->nr_nodes; i++) {
+		if (invoke_bpf_prog(m, &prog, tl->nodes[i], stack_size, run_ctx_off, true,
 				    image, rw_image))
 			return -EINVAL;
 
@@ -3220,14 +3220,14 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_image,
 					 void *rw_image_end, void *image,
 					 const struct btf_func_model *m, u32 flags,
-					 struct bpf_tramp_links *tlinks,
+					 struct bpf_tramp_nodes *tnodes,
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
 	int regs_off, func_meta_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
-	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
-	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
-	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
+	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
+	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
 	int cookie_off, cookie_cnt;
 	u8 **branches = NULL;
@@ -3299,7 +3299,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	ip_off = stack_size;
 
-	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
+	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);
 	/* room for session cookies */
 	stack_size += cookie_cnt * 8;
 	cookie_off = stack_size;
@@ -3392,7 +3392,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
-	if (bpf_fsession_cnt(tlinks)) {
+	if (bpf_fsession_cnt(tnodes)) {
 		/* clear all the session cookies' value */
 		for (int i = 0; i < cookie_cnt; i++)
 			emit_store_stack_imm64(&prog, BPF_REG_0, -cookie_off + 8 * i, 0);
@@ -3400,15 +3400,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_store_stack_imm64(&prog, BPF_REG_0, -8, 0);
 	}
 
-	if (fentry->nr_links) {
+	if (fentry->nr_nodes) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off, func_meta_off,
 			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image,
 			       func_meta, cookie_off))
 			return -EINVAL;
 	}
 
-	if (fmod_ret->nr_links) {
-		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
+	if (fmod_ret->nr_nodes) {
+		branches = kcalloc(fmod_ret->nr_nodes, sizeof(u8 *),
 				   GFP_KERNEL);
 		if (!branches)
 			return -ENOMEM;
@@ -3447,7 +3447,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
 
-	if (fmod_ret->nr_links) {
+	if (fmod_ret->nr_nodes) {
 		/* From Intel 64 and IA-32 Architectures Optimization
 		 * Reference Manual, 3.4.1.4 Code Alignment, Assembly/Compiler
 		 * Coding Rule 11: All branch targets should be 16-byte
@@ -3457,7 +3457,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		/* Update the branches saved in invoke_bpf_mod_ret with the
 		 * aligned address of do_fexit.
 		 */
-		for (i = 0; i < fmod_ret->nr_links; i++) {
+		for (i = 0; i < fmod_ret->nr_nodes; i++) {
 			emit_cond_near_jump(&branches[i], image + (prog - (u8 *)rw_image),
 					    image + (branches[i] - (u8 *)rw_image), X86_JNE);
 		}
@@ -3465,10 +3465,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	/* set the "is_return" flag for fsession */
 	func_meta |= (1ULL << BPF_TRAMP_IS_RETURN_SHIFT);
-	if (bpf_fsession_cnt(tlinks))
+	if (bpf_fsession_cnt(tnodes))
 		emit_store_stack_imm64(&prog, BPF_REG_0, -func_meta_off, func_meta);
 
-	if (fexit->nr_links) {
+	if (fexit->nr_nodes) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off, func_meta_off,
 			       false, image, rw_image, func_meta, cookie_off)) {
 			ret = -EINVAL;
@@ -3542,7 +3542,7 @@ int arch_protect_bpf_trampoline(void *image, unsigned int size)
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
+				struct bpf_tramp_nodes *tnodes,
 				void *func_addr)
 {
 	void *rw_image, *tmp;
@@ -3557,7 +3557,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 		return -ENOMEM;
 
 	ret = __arch_prepare_bpf_trampoline(im, rw_image, rw_image + size, image, m,
-					    flags, tlinks, func_addr);
+					    flags, tnodes, func_addr);
 	if (ret < 0)
 		goto out;
 
@@ -3570,7 +3570,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 }
 
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr)
+			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct bpf_tramp_image im;
 	void *image;
@@ -3588,7 +3588,7 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 		return -ENOMEM;
 
 	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
-					    m, flags, tlinks, func_addr);
+					    m, flags, tnodes, func_addr);
 	bpf_jit_free_exec(image);
 	return ret;
 }
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 46bf3d86bdb2..9c7f5ab3c7ce 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1233,9 +1233,9 @@ enum {
 #define BPF_TRAMP_COOKIE_INDEX_SHIFT	8
 #define BPF_TRAMP_IS_RETURN_SHIFT	63
 
-struct bpf_tramp_links {
-	struct bpf_tramp_link *links[BPF_MAX_TRAMP_LINKS];
-	int nr_links;
+struct bpf_tramp_nodes {
+	struct bpf_tramp_node *nodes[BPF_MAX_TRAMP_LINKS];
+	int nr_nodes;
 };
 
 struct bpf_tramp_run_ctx;
@@ -1263,13 +1263,13 @@ struct bpf_tramp_run_ctx;
 struct bpf_tramp_image;
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
-				struct bpf_tramp_links *tlinks,
+				struct bpf_tramp_nodes *tnodes,
 				void *func_addr);
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
 int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-			     struct bpf_tramp_links *tlinks, void *func_addr);
+			     struct bpf_tramp_nodes *tnodes, void *func_addr);
 
 u64 notrace __bpf_prog_enter_sleepable_recur(struct bpf_prog *prog,
 					     struct bpf_tramp_run_ctx *run_ctx);
@@ -1453,10 +1453,10 @@ static inline int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u6
 }
 
 #ifdef CONFIG_BPF_JIT
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+int bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 			     struct bpf_trampoline *tr,
 			     struct bpf_prog *tgt_prog);
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+int bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 			       struct bpf_trampoline *tr,
 			       struct bpf_prog *tgt_prog);
 struct bpf_trampoline *bpf_trampoline_get(u64 key,
@@ -1865,12 +1865,17 @@ struct bpf_link_ops {
 	__poll_t (*poll)(struct file *file, struct poll_table_struct *pts);
 };
 
-struct bpf_tramp_link {
-	struct bpf_link link;
+struct bpf_tramp_node {
+	struct bpf_link *link;
 	struct hlist_node tramp_hlist;
 	u64 cookie;
 };
 
+struct bpf_tramp_link {
+	struct bpf_link link;
+	struct bpf_tramp_node node;
+};
+
 struct bpf_shim_tramp_link {
 	struct bpf_tramp_link link;
 	struct bpf_trampoline *trampoline;
@@ -2088,8 +2093,8 @@ void bpf_struct_ops_put(const void *kdata);
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff);
 int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
 				       void *value);
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
-				      struct bpf_tramp_link *link,
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
+				      struct bpf_tramp_node *node,
 				      const struct btf_func_model *model,
 				      void *stub_func,
 				      void **image, u32 *image_off,
@@ -2181,31 +2186,31 @@ static inline void bpf_struct_ops_desc_release(struct bpf_struct_ops_desc *st_op
 
 #endif
 
-static inline int bpf_fsession_cnt(struct bpf_tramp_links *links)
+static inline int bpf_fsession_cnt(struct bpf_tramp_nodes *nodes)
 {
-	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_nodes fentries = nodes[BPF_TRAMP_FENTRY];
 	int cnt = 0;
 
-	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
-		if (fentries.links[i]->link.prog->expected_attach_type == BPF_TRACE_FSESSION)
+	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
+		if (fentries.nodes[i]->link->prog->expected_attach_type == BPF_TRACE_FSESSION)
 			cnt++;
 	}
 
 	return cnt;
 }
 
-static inline bool bpf_prog_calls_session_cookie(struct bpf_tramp_link *link)
+static inline bool bpf_prog_calls_session_cookie(struct bpf_tramp_node *node)
 {
-	return link->link.prog->call_session_cookie;
+	return node->link->prog->call_session_cookie;
 }
 
-static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_links *links)
+static inline int bpf_fsession_cookie_cnt(struct bpf_tramp_nodes *nodes)
 {
-	struct bpf_tramp_links fentries = links[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_nodes fentries = nodes[BPF_TRAMP_FENTRY];
 	int cnt = 0;
 
-	for (int i = 0; i < links[BPF_TRAMP_FENTRY].nr_links; i++) {
-		if (bpf_prog_calls_session_cookie(fentries.links[i]))
+	for (int i = 0; i < nodes[BPF_TRAMP_FENTRY].nr_nodes; i++) {
+		if (bpf_prog_calls_session_cookie(fentries.nodes[i]))
 			cnt++;
 	}
 
@@ -2758,6 +2763,9 @@ void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_type type,
 			     const struct bpf_link_ops *ops, struct bpf_prog *prog,
 			     enum bpf_attach_type attach_type, bool sleepable);
+void bpf_tramp_link_init(struct bpf_tramp_link *link, enum bpf_link_type type,
+			 const struct bpf_link_ops *ops, struct bpf_prog *prog,
+			 enum bpf_attach_type attach_type, u64 cookie);
 int bpf_link_prime(struct bpf_link *link, struct bpf_link_primer *primer);
 int bpf_link_settle(struct bpf_link_primer *primer);
 void bpf_link_cleanup(struct bpf_link_primer *primer);
@@ -3123,6 +3131,12 @@ static inline void bpf_link_init_sleepable(struct bpf_link *link, enum bpf_link_
 {
 }
 
+static inline void bpf_tramp_link_init(struct bpf_tramp_link *link, enum bpf_link_type type,
+				       const struct bpf_link_ops *ops, struct bpf_prog *prog,
+				       enum bpf_attach_type attach_type, u64 cookie)
+{
+}
+
 static inline int bpf_link_prime(struct bpf_link *link,
 				 struct bpf_link_primer *primer)
 {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c43346cb3d76..73522559dc05 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -595,8 +595,8 @@ const struct bpf_link_ops bpf_struct_ops_link_lops = {
 	.dealloc = bpf_struct_ops_link_dealloc,
 };
 
-int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
-				      struct bpf_tramp_link *link,
+int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_nodes *tnodes,
+				      struct bpf_tramp_node *node,
 				      const struct btf_func_model *model,
 				      void *stub_func,
 				      void **_image, u32 *_image_off,
@@ -606,13 +606,13 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 	void *image = *_image;
 	int size;
 
-	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
-	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
+	tnodes[BPF_TRAMP_FENTRY].nodes[0] = node;
+	tnodes[BPF_TRAMP_FENTRY].nr_nodes = 1;
 
 	if (model->ret_size > 0)
 		flags |= BPF_TRAMP_F_RET_FENTRY_RET;
 
-	size = arch_bpf_trampoline_size(model, flags, tlinks, stub_func);
+	size = arch_bpf_trampoline_size(model, flags, tnodes, stub_func);
 	if (size <= 0)
 		return size ? : -EFAULT;
 
@@ -629,7 +629,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
 
 	size = arch_prepare_bpf_trampoline(NULL, image + image_off,
 					   image + image_off + size,
-					   model, flags, tlinks, stub_func);
+					   model, flags, tnodes, stub_func);
 	if (size <= 0) {
 		if (image != *_image)
 			bpf_struct_ops_image_free(image);
@@ -694,7 +694,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	const struct btf_type *module_type;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops_desc->type;
-	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_nodes *tnodes;
 	void *udata, *kdata;
 	int prog_fd, err;
 	u32 i, trampoline_start, image_off = 0;
@@ -721,8 +721,8 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	if (uvalue->common.state || refcount_read(&uvalue->common.refcnt))
 		return -EINVAL;
 
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks)
+	tnodes = kcalloc(BPF_TRAMP_MAX, sizeof(*tnodes), GFP_KERNEL);
+	if (!tnodes)
 		return -ENOMEM;
 
 	uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
@@ -821,8 +821,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 			err = -ENOMEM;
 			goto reset_unlock;
 		}
-		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
-			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type);
+		bpf_tramp_link_init(link, BPF_LINK_TYPE_STRUCT_OPS,
+			      &bpf_struct_ops_link_lops, prog, prog->expected_attach_type, 0);
+
 		*plink++ = &link->link;
 
 		ksym = kzalloc(sizeof(*ksym), GFP_USER);
@@ -833,7 +834,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*pksym++ = ksym;
 
 		trampoline_start = image_off;
-		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+		err = bpf_struct_ops_prepare_trampoline(tnodes, &link->node,
 						&st_ops->func_models[i],
 						*(void **)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
@@ -911,7 +912,7 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	memset(uvalue, 0, map->value_size);
 	memset(kvalue, 0, map->value_size);
 unlock:
-	kfree(tlinks);
+	kfree(tnodes);
 	mutex_unlock(&st_map->lock);
 	if (!err)
 		bpf_struct_ops_map_add_ksyms(st_map);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index dd89bf809772..e9d482c59977 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3209,6 +3209,15 @@ void bpf_link_init(struct bpf_link *link, enum bpf_link_type type,
 	bpf_link_init_sleepable(link, type, ops, prog, attach_type, false);
 }
 
+void bpf_tramp_link_init(struct bpf_tramp_link *link, enum bpf_link_type type,
+			 const struct bpf_link_ops *ops, struct bpf_prog *prog,
+			 enum bpf_attach_type attach_type, u64 cookie)
+{
+	bpf_link_init(&link->link, type, ops, prog, attach_type);
+	link->node.link = &link->link;
+	link->node.cookie = cookie;
+}
+
 static void bpf_link_free_id(int id)
 {
 	if (!id)
@@ -3502,7 +3511,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link,
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&tr_link->link.node,
 						tr_link->trampoline,
 						tr_link->tgt_prog));
 
@@ -3515,8 +3524,7 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
 {
-	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+	struct bpf_tracing_link *tr_link = container_of(link, struct bpf_tracing_link, link.link);
 
 	kfree(tr_link);
 }
@@ -3524,8 +3532,8 @@ static void bpf_tracing_link_dealloc(struct bpf_link *link)
 static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 					 struct seq_file *seq)
 {
-	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+	struct bpf_tracing_link *tr_link = container_of(link, struct bpf_tracing_link, link.link);
+
 	u32 target_btf_id, target_obj_id;
 
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
@@ -3538,17 +3546,16 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 		   link->attach_type,
 		   target_obj_id,
 		   target_btf_id,
-		   tr_link->link.cookie);
+		   tr_link->link.node.cookie);
 }
 
 static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 					   struct bpf_link_info *info)
 {
-	struct bpf_tracing_link *tr_link =
-		container_of(link, struct bpf_tracing_link, link.link);
+	struct bpf_tracing_link *tr_link = container_of(link, struct bpf_tracing_link, link.link);
 
 	info->tracing.attach_type = link->attach_type;
-	info->tracing.cookie = tr_link->link.cookie;
+	info->tracing.cookie = tr_link->link.node.cookie;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
 				  &info->tracing.target_obj_id,
 				  &info->tracing.target_btf_id);
@@ -3635,9 +3642,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 
 		fslink = kzalloc(sizeof(*fslink), GFP_USER);
 		if (fslink) {
-			bpf_link_init(&fslink->fexit.link, BPF_LINK_TYPE_TRACING,
-				      &bpf_tracing_link_lops, prog, attach_type);
-			fslink->fexit.cookie = bpf_cookie;
+			bpf_tramp_link_init(&fslink->fexit, BPF_LINK_TYPE_TRACING,
+					    &bpf_tracing_link_lops, prog, attach_type,
+					    bpf_cookie);
 			link = &fslink->link;
 		} else {
 			link = NULL;
@@ -3649,10 +3656,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		err = -ENOMEM;
 		goto out_put_prog;
 	}
-	bpf_link_init(&link->link.link, BPF_LINK_TYPE_TRACING,
-		      &bpf_tracing_link_lops, prog, attach_type);
-
-	link->link.cookie = bpf_cookie;
+	bpf_tramp_link_init(&link->link, BPF_LINK_TYPE_TRACING,
+			    &bpf_tracing_link_lops, prog, attach_type, bpf_cookie);
 
 	mutex_lock(&prog->aux->dst_mutex);
 
@@ -3738,7 +3743,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	if (err)
 		goto out_unlock;
 
-	err = bpf_trampoline_link_prog(&link->link, tr, tgt_prog);
+	err = bpf_trampoline_link_prog(&link->link.node, tr, tgt_prog);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
 		link = NULL;
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index e9f0152289a4..f4acf3771600 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -489,30 +489,29 @@ static struct bpf_trampoline_ops trampoline_ops = {
 	.modify_fentry     = modify_fentry,
 };
 
-static struct bpf_tramp_links *
+static struct bpf_tramp_nodes *
 bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_arg)
 {
-	struct bpf_tramp_link *link;
-	struct bpf_tramp_links *tlinks;
-	struct bpf_tramp_link **links;
+	struct bpf_tramp_node *node, **nodes;
+	struct bpf_tramp_nodes *tnodes;
 	int kind;
 
 	*total = 0;
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks)
+	tnodes = kcalloc(BPF_TRAMP_MAX, sizeof(*tnodes), GFP_KERNEL);
+	if (!tnodes)
 		return ERR_PTR(-ENOMEM);
 
 	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
-		tlinks[kind].nr_links = tr->progs_cnt[kind];
+		tnodes[kind].nr_nodes = tr->progs_cnt[kind];
 		*total += tr->progs_cnt[kind];
-		links = tlinks[kind].links;
+		nodes = tnodes[kind].nodes;
 
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			*ip_arg |= link->link.prog->call_get_func_ip;
-			*links++ = link;
+		hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
+			*ip_arg |= node->link->prog->call_get_func_ip;
+			*nodes++ = node;
 		}
 	}
-	return tlinks;
+	return tnodes;
 }
 
 static void bpf_tramp_image_free(struct bpf_tramp_image *im)
@@ -660,14 +659,14 @@ static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct
 				     struct bpf_trampoline_ops *ops, void *data)
 {
 	struct bpf_tramp_image *im;
-	struct bpf_tramp_links *tlinks;
+	struct bpf_tramp_nodes *tnodes;
 	u32 orig_flags = tr->flags;
 	bool ip_arg = false;
 	int err, total, size;
 
-	tlinks = bpf_trampoline_get_progs(tr, &total, &ip_arg);
-	if (IS_ERR(tlinks))
-		return PTR_ERR(tlinks);
+	tnodes = bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	if (IS_ERR(tnodes))
+		return PTR_ERR(tnodes);
 
 	if (total == 0) {
 		err = ops->unregister_fentry(tr, orig_flags, tr->cur_image->image, data);
@@ -679,8 +678,8 @@ static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct
 	/* clear all bits except SHARE_IPMODIFY and TAIL_CALL_CTX */
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
-	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
-	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
+	if (tnodes[BPF_TRAMP_FEXIT].nr_nodes ||
+	    tnodes[BPF_TRAMP_MODIFY_RETURN].nr_nodes) {
 		/* NOTE: BPF_TRAMP_F_RESTORE_REGS and BPF_TRAMP_F_SKIP_FRAME
 		 * should not be set together.
 		 */
@@ -711,7 +710,7 @@ static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct
 #endif
 
 	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
-					tlinks, tr->func.addr);
+					tnodes, tr->func.addr);
 	if (size < 0) {
 		err = size;
 		goto out;
@@ -729,7 +728,7 @@ static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct
 	}
 
 	err = arch_prepare_bpf_trampoline(im, im->image, im->image + size,
-					  &tr->func.model, tr->flags, tlinks,
+					  &tr->func.model, tr->flags, tnodes,
 					  tr->func.addr);
 	if (err < 0)
 		goto out_free;
@@ -767,7 +766,7 @@ static int bpf_trampoline_update_ops(struct bpf_trampoline *tr, bool lock_direct
 	/* If any error happens, restore previous flags */
 	if (err)
 		tr->flags = orig_flags;
-	kfree(tlinks);
+	kfree(tnodes);
 	return err;
 
 out_free:
@@ -822,7 +821,7 @@ static int bpf_freplace_check_tgt_prog(struct bpf_prog *tgt_prog)
 	return 0;
 }
 
-static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+static int __bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 				      struct bpf_trampoline *tr,
 				      struct bpf_prog *tgt_prog,
 				      struct bpf_trampoline_ops *ops,
@@ -830,12 +829,12 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 {
 	struct bpf_fsession_link *fslink = NULL;
 	enum bpf_tramp_prog_type kind;
-	struct bpf_tramp_link *link_exiting;
+	struct bpf_tramp_node *node_existing;
 	struct hlist_head *prog_list;
 	int err = 0;
 	int cnt = 0, i;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(node->link->prog);
 	if (tr->extension_prog)
 		/* cannot attach fentry/fexit if extension prog is attached.
 		 * cannot overwrite extension prog either.
@@ -852,10 +851,10 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 		err = bpf_freplace_check_tgt_prog(tgt_prog);
 		if (err)
 			return err;
-		tr->extension_prog = link->link.prog;
+		tr->extension_prog = node->link->prog;
 		return bpf_arch_text_poke(tr->func.addr, BPF_MOD_NOP,
 					  BPF_MOD_JUMP, NULL,
-					  link->link.prog->bpf_func);
+					  node->link->prog->bpf_func);
 	}
 	if (kind == BPF_TRAMP_FSESSION) {
 		prog_list = &tr->progs_hlist[BPF_TRAMP_FENTRY];
@@ -865,31 +864,31 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	}
 	if (cnt >= BPF_MAX_TRAMP_LINKS)
 		return -E2BIG;
-	if (!hlist_unhashed(&link->tramp_hlist))
+	if (!hlist_unhashed(&node->tramp_hlist))
 		/* prog already linked */
 		return -EBUSY;
-	hlist_for_each_entry(link_exiting, prog_list, tramp_hlist) {
-		if (link_exiting->link.prog != link->link.prog)
+	hlist_for_each_entry(node_existing, prog_list, tramp_hlist) {
+		if (node_existing->link->prog != node->link->prog)
 			continue;
 		/* prog already linked */
 		return -EBUSY;
 	}
 
-	hlist_add_head(&link->tramp_hlist, prog_list);
+	hlist_add_head(&node->tramp_hlist, prog_list);
 	if (kind == BPF_TRAMP_FSESSION) {
 		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
-		fslink = container_of(link, struct bpf_fsession_link, link.link);
-		hlist_add_head(&fslink->fexit.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
+		fslink = container_of(node, struct bpf_fsession_link, link.link.node);
+		hlist_add_head(&fslink->fexit.node.tramp_hlist, &tr->progs_hlist[BPF_TRAMP_FEXIT]);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]++;
 	} else {
 		tr->progs_cnt[kind]++;
 	}
 	err = bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 	if (err) {
-		hlist_del_init(&link->tramp_hlist);
+		hlist_del_init(&node->tramp_hlist);
 		if (kind == BPF_TRAMP_FSESSION) {
 			tr->progs_cnt[BPF_TRAMP_FENTRY]--;
-			hlist_del_init(&fslink->fexit.tramp_hlist);
+			hlist_del_init(&fslink->fexit.node.tramp_hlist);
 			tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		} else {
 			tr->progs_cnt[kind]--;
@@ -898,19 +897,19 @@ static int __bpf_trampoline_link_prog(struct bpf_tramp_link *link,
 	return err;
 }
 
-int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
+int bpf_trampoline_link_prog(struct bpf_tramp_node *node,
 			     struct bpf_trampoline *tr,
 			     struct bpf_prog *tgt_prog)
 {
 	int err;
 
 	trampoline_lock(tr);
-	err = __bpf_trampoline_link_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
+	err = __bpf_trampoline_link_prog(node, tr, tgt_prog, &trampoline_ops, NULL);
 	trampoline_unlock(tr);
 	return err;
 }
 
-static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+static int __bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 					struct bpf_trampoline *tr,
 					struct bpf_prog *tgt_prog,
 					struct bpf_trampoline_ops *ops,
@@ -919,7 +918,7 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 	enum bpf_tramp_prog_type kind;
 	int err;
 
-	kind = bpf_attach_type_to_tramp(link->link.prog);
+	kind = bpf_attach_type_to_tramp(node->link->prog);
 	if (kind == BPF_TRAMP_REPLACE) {
 		WARN_ON_ONCE(!tr->extension_prog);
 		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
@@ -931,26 +930,26 @@ static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
 		return err;
 	} else if (kind == BPF_TRAMP_FSESSION) {
 		struct bpf_fsession_link *fslink =
-			container_of(link, struct bpf_fsession_link, link.link);
+			container_of(node, struct bpf_fsession_link, link.link.node);
 
-		hlist_del_init(&fslink->fexit.tramp_hlist);
+		hlist_del_init(&fslink->fexit.node.tramp_hlist);
 		tr->progs_cnt[BPF_TRAMP_FEXIT]--;
 		kind = BPF_TRAMP_FENTRY;
 	}
-	hlist_del_init(&link->tramp_hlist);
+	hlist_del_init(&node->tramp_hlist);
 	tr->progs_cnt[kind]--;
 	return bpf_trampoline_update_ops(tr, true /* lock_direct_mutex */, ops, data);
 }
 
 /* bpf_trampoline_unlink_prog() should never fail. */
-int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
+int bpf_trampoline_unlink_prog(struct bpf_tramp_node *node,
 			       struct bpf_trampoline *tr,
 			       struct bpf_prog *tgt_prog)
 {
 	int err;
 
 	trampoline_lock(tr);
-	err = __bpf_trampoline_unlink_prog(link, tr, tgt_prog, &trampoline_ops, NULL);
+	err = __bpf_trampoline_unlink_prog(node, tr, tgt_prog, &trampoline_ops, NULL);
 	trampoline_unlock(tr);
 	return err;
 }
@@ -965,7 +964,7 @@ static void bpf_shim_tramp_link_release(struct bpf_link *link)
 	if (!shim_link->trampoline)
 		return;
 
-	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link, shim_link->trampoline, NULL));
+	WARN_ON_ONCE(bpf_trampoline_unlink_prog(&shim_link->link.node, shim_link->trampoline, NULL));
 	bpf_trampoline_put(shim_link->trampoline);
 }
 
@@ -1011,8 +1010,8 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 	p->type = BPF_PROG_TYPE_LSM;
 	p->expected_attach_type = BPF_LSM_MAC;
 	bpf_prog_inc(p);
-	bpf_link_init(&shim_link->link.link, BPF_LINK_TYPE_UNSPEC,
-		      &bpf_shim_tramp_link_lops, p, attach_type);
+	bpf_tramp_link_init(&shim_link->link, BPF_LINK_TYPE_UNSPEC,
+		      &bpf_shim_tramp_link_lops, p, attach_type, 0);
 	bpf_cgroup_atype_get(p->aux->attach_btf_id, cgroup_atype);
 
 	return shim_link;
@@ -1021,15 +1020,15 @@ static struct bpf_shim_tramp_link *cgroup_shim_alloc(const struct bpf_prog *prog
 static struct bpf_shim_tramp_link *cgroup_shim_find(struct bpf_trampoline *tr,
 						    bpf_func_t bpf_func)
 {
-	struct bpf_tramp_link *link;
+	struct bpf_tramp_node *node;
 	int kind;
 
 	for (kind = 0; kind < BPF_TRAMP_MAX; kind++) {
-		hlist_for_each_entry(link, &tr->progs_hlist[kind], tramp_hlist) {
-			struct bpf_prog *p = link->link.prog;
+		hlist_for_each_entry(node, &tr->progs_hlist[kind], tramp_hlist) {
+			struct bpf_prog *p = node->link->prog;
 
 			if (p->bpf_func == bpf_func)
-				return container_of(link, struct bpf_shim_tramp_link, link);
+				return container_of(node, struct bpf_shim_tramp_link, link.node);
 		}
 	}
 
@@ -1082,7 +1081,7 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
 		goto err;
 	}
 
-	err = __bpf_trampoline_link_prog(&shim_link->link, tr, NULL, &trampoline_ops, NULL);
+	err = __bpf_trampoline_link_prog(&shim_link->link.node, tr, NULL, &trampoline_ops, NULL);
 	if (err)
 		goto err;
 
@@ -1397,7 +1396,7 @@ bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog)
 int __weak
 arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 			    const struct btf_func_model *m, u32 flags,
-			    struct bpf_tramp_links *tlinks,
+			    struct bpf_tramp_nodes *tnodes,
 			    void *func_addr)
 {
 	return -ENOTSUPP;
@@ -1431,7 +1430,7 @@ int __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
 }
 
 int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
-				    struct bpf_tramp_links *tlinks, void *func_addr)
+				    struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	return -ENOTSUPP;
 }
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 812457819b5a..8f58c1f5a039 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -132,7 +132,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
 	const struct btf_type *func_proto;
 	struct bpf_dummy_ops_test_args *args;
-	struct bpf_tramp_links *tlinks = NULL;
+	struct bpf_tramp_nodes *tnodes = NULL;
 	struct bpf_tramp_link *link = NULL;
 	void *image = NULL;
 	unsigned int op_idx;
@@ -158,8 +158,8 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err)
 		goto out;
 
-	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
-	if (!tlinks) {
+	tnodes = kcalloc(BPF_TRAMP_MAX, sizeof(*tnodes), GFP_KERNEL);
+	if (!tnodes) {
 		err = -ENOMEM;
 		goto out;
 	}
@@ -171,11 +171,11 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	}
 	/* prog doesn't take the ownership of the reference from caller */
 	bpf_prog_inc(prog);
-	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops, prog,
-		      prog->expected_attach_type);
+	bpf_tramp_link_init(link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_link_lops,
+			    prog, prog->expected_attach_type, 0);
 
 	op_idx = prog->expected_attach_type;
-	err = bpf_struct_ops_prepare_trampoline(tlinks, link,
+	err = bpf_struct_ops_prepare_trampoline(tnodes, &link->node,
 						&st_ops->func_models[op_idx],
 						&dummy_ops_test_ret_function,
 						&image, &image_off,
@@ -198,7 +198,7 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	bpf_struct_ops_image_free(image);
 	if (link)
 		bpf_link_put(&link->link);
-	kfree(tlinks);
+	kfree(tnodes);
 	return err;
 }
 
-- 
2.52.0

