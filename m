Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2CF3368BF
	for <bpf@vger.kernel.org>; Mon, 31 Aug 2026 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176811; cv=none; b=A+nsryZdUOdJ6zv2Yvm0eOnFrVTxU4c1BcNW6xmm6TMeO/lWJaljnAjQcQkp8ojiBA2KmWhMITvwflJ1vqmtSZq9lT13XegM51Z08OA5kCXJ0oEJzgXkkhFhIK7u/m/MAkYkSMNO1FHVDn0bKpPIdvz1vPz4ugq4e0p1eaf6qHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176811; c=relaxed/simple;
	bh=aCarmlMFKpWhCP0YPqDjy+lcl1DTgMkb2oJMsLf1J2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUBOhCK+ebIa2Zpg8f52DZK0UbN4KFWKK20033Z4L4gRilHo5s3uOaLVqhTyEdifEbE8hQ/cmVGdst8D/dqZPt76QbuhjiUe6klvTt/zQszJZCWzyu1PwEsvW7ZUcI3yogHCl/hjeHiBaJxudXYnhWU1CBjSG4PNPL/gpYDTCf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgmVsFuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgmVsFuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CE1F000E9;
	Mon, 31 Aug 2026 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788176809;
	bh=9b+Wx+L5SQW5TiXdN+bRQswTn+CZnk/Ty4+VI4G965M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YgmVsFucv0v7X2JH2k20WIkHQP2UaTaLPEcv321GPzW4TxRl2CLnSI0anLAZL7hNS
	 03+5DMH9jc1wD4JYYL6mGnnbgwvsY9OqdasT0z/P1MWhfwC4C5t31Qv9bGbpMR0Fu8
	 8BYaeCZM7YpP063fDl8yYiKAKbppxqwu/rrmzJKRPEwrFHQduFMy1e15w/MTDX8OU2
	 pbrRESgT7D4CvWKakufBeYwqHLiNDRYN9tMLPZWUFjcH0iL7yZ6RkQ9LzGe5kVTdVJ
	 w+psmTVgMjhHWtyu2ixFMGZM7n6ScJz4537actxGj39Z99COOQfHFpmQWxa70NO4ti
	 oFwCcIziuWbzA==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>
Subject: [PATCH bpf-next 3/3] bpf, x86: Add support for jit dry run
Date: Mon, 31 Aug 2026 13:46:14 +0200
Message-ID: <20260831114614.157277-4-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831114614.157277-1-jolsa@kernel.org>
References: <20260831114614.157277-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding support to run jit code generation in dry_run mode that won't
store any code and only returns the jir code size.

The dry_run is enabled when __arch_prepare_bpf_trampoline is called
with rw_image argument as NULL.

It's used in arch_bpf_trampoline_size where it allows to skip the
image allocation, that gives speed up for tracing_multi attachment.

With current code:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55227 functions
  serial_test_tracing_multi_bench_attach: attached in   1.563s
  serial_test_tracing_multi_bench_attach: detached in   0.256s

With the fix:

  # ./test_progs -t tracing_multi_bench_attach -v
  ...
  serial_test_tracing_multi_bench_attach: found 55235 functions
  serial_test_tracing_multi_bench_attach: attached in   0.798s
  serial_test_tracing_multi_bench_attach: detached in   0.258s

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 42 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index eff0523161c3..2ec734c69b69 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -25,6 +25,7 @@ static bool all_callee_regs_used[4] = {true, true, true, true};
 
 struct jit_emit_context {
 	u8 *prog;
+	bool dry_run;
 };
 
 static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
@@ -42,7 +43,10 @@ static u8 *emit_code(u8 *ptr, u32 bytes, unsigned int len)
 
 static void emit_code_jit(struct jit_emit_context *jit, u32 bytes, unsigned int len)
 {
-	jit->prog = emit_code(jit->prog, bytes, len);
+	if (jit->dry_run)
+		jit->prog += len;
+	else
+		jit->prog = emit_code(jit->prog, bytes, len);
 }
 
 #define EMIT(bytes, len) \
@@ -164,7 +168,8 @@ static int bpf_call_depth_emit_accounting(struct jit_emit_context *jit, void *fu
 	int size;
 
 	size = x86_call_depth_emit_accounting(insn_buff, func, ip);
-	memcpy(jit->prog, insn_buff, size);
+	if (!jit->dry_run)
+		memcpy(jit->prog, insn_buff, size);
 
 	jit->prog += size;
 	return size;
@@ -567,7 +572,8 @@ static int emit_patch(struct jit_emit_context *jit, void *func, void *ip, u8 opc
 	s64 offset;
 
 	offset = func - (ip + X86_PATCH_SIZE);
-	if (!is_simm32(offset)) {
+	/* We do not have meaningful ip value in the dry run, skip the check. */
+	if (!jit->dry_run && !is_simm32(offset)) {
 		pr_err("Target call %p is out of range\n", func);
 		return -ERANGE;
 	}
@@ -1648,6 +1654,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	int err;
 
 	jit->prog = temp;
+	jit->dry_run = false;
 
 	stack_depth = bpf_prog->aux->stack_depth;
 	out_stack_arg_cnt = bpf_out_stack_arg_cnt(env, bpf_prog);
@@ -3191,8 +3198,10 @@ static int invoke_bpf_prog(const struct btf_func_model *m, struct jit_emit_conte
 		emit_stx(jit, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
 
 	/* replace 2 nops with JE insn, since jmp target is known */
-	jmp_insn[0] = X86_JE;
-	jmp_insn[1] = jit->prog - jmp_insn - 2;
+	if (!jit->dry_run) {
+		jmp_insn[0] = X86_JE;
+		jmp_insn[1] = jit->prog - jmp_insn - 2;
+	}
 
 	/* arg1: mov rdi, progs[i] */
 	emit_mov_imm64(jit, BPF_REG_1, (long) p >> 32, (u32) (long) p);
@@ -3473,6 +3482,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	jit->prog = rw_image;
+	jit->dry_run = !rw_image;
 
 	if (flags & BPF_TRAMP_F_INDIRECT) {
 		/*
@@ -3594,6 +3604,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		for (i = 0; i < fmod_ret->nr_nodes; i++) {
 			struct jit_emit_context branch_jit = {
 				.prog = branches[i],
+				.dry_run = jit->dry_run,
 			};
 
 			emit_cond_near_jump(&branch_jit, image + (jit->prog - (u8 *)rw_image),
@@ -3652,7 +3663,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 	emit_return(jit, image + (jit->prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
-	if (WARN_ON_ONCE(jit->prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
+	if (!jit->dry_run &&
+	    WARN_ON_ONCE(jit->prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
 		goto cleanup;
 	}
@@ -3711,23 +3723,9 @@ int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_nodes *tnodes, void *func_addr)
 {
 	struct bpf_tramp_image im;
-	void *image;
-	int ret;
 
-	/* Allocate a temporary buffer for __arch_prepare_bpf_trampoline().
-	 *
-	 * We cannot use kvmalloc here, because we need image to be in
-	 * module memory range.
-	 * Since it must be writable use bpf_jit_alloc_exec_rw().
-	 */
-	image = bpf_jit_alloc_exec_rw(PAGE_SIZE);
-	if (!image)
-		return -ENOMEM;
-
-	ret = __arch_prepare_bpf_trampoline(&im, image, image + PAGE_SIZE, image,
-					    m, flags, tnodes, func_addr);
-	bpf_jit_free_exec(image);
-	return ret;
+	return __arch_prepare_bpf_trampoline(&im, NULL, NULL, NULL, m, flags,
+					     tnodes, func_addr);
 }
 
 static int emit_bpf_dispatcher(struct jit_emit_context *jit, int a, int b, s64 *progs, u8 *image,
-- 
2.54.0

