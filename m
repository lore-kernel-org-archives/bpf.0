Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AB635E1A9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885472; cv=none; b=e27mfV5CZb+mTHpfP1vNwJP+OXvkElg4dtDaKEbVJgGqlI6ORtU0C6hpkyEz07/EOaNNeK60NZ731h0H0QRgUbhGITjQDWdzpV7cu5uOYPEjHZnvi6Iq1iXFO7iAIV3isTAff0dPZRbwhy7ixrWH//sW5mvbWa34rG2xSzpI6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885472; c=relaxed/simple;
	bh=ppZ9RKBB2ZbtsIV8mMAIjkti/lN6Cr+0ORDRw3LBQz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pow80oLl+wnPpR0mm85p5HroNo2Pc/rQy9X9ljqSW/Pdmh7JMVskZTPjP1Yx8s6CduVYTXsSaBUhImFNnyUrzbpLSmlcgs9y5nfwaV2EMolY5eVC5i0uCULGCTl9UKSiwgg16CTZ0xaC+O7qT83FmlDapP/6TyGypGl8w+C8/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7C69EC061F4B7; Fri, 15 May 2026 15:51:06 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 6/7] bpf,x86: Fix exception unwinding with outgoing stack arguments
Date: Fri, 15 May 2026 15:51:06 -0700
Message-ID: <20260515225106.824804-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515225035.821178-1-yonghong.song@linux.dev>
References: <20260515225035.821178-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When a main program with exception_boundary has outgoing stack
arguments (e.g. from calling subprogs with >5 args), bpf_throw() fails
to correctly restore callee-saved registers, causing a kernel crash.

The x86 JIT allocates the outgoing stack arg area below the
callee-saved registers via 'sub rsp, outgoing_rsp' in the prologue.
When bpf_throw() unwinds, it captures the main program's sp (which
includes this outgoing area) and passes it to the exception callback.
The callback gets rsp and rbp, followed by pop_callee_regs, but rsp
points into the outgoing arg area rather than the callee-saved
registers, so the pops restore garbage values. Returning to the
kernel with corrupted callee-saved registers causes a crash.

Fix this by passing the main program's outgoing_rsp as the 4th
argument to the exception callback. The callback adjusts rsp with
'add rsp, rcx' before popping callee-saved registers, correctly
skipping the outgoing arg area. When outgoing_rsp is 0 (the common
case), this is a no-op.

Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments"=
)
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 9 ++++++++-
 include/linux/bpf.h         | 3 ++-
 kernel/bpf/fixups.c         | 1 +
 kernel/bpf/helpers.c        | 2 +-
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ceefefb4da21..f4fdceedaad7 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -557,10 +557,15 @@ static void emit_prologue(u8 **pprog, u8 *ip, u32 s=
tack_depth, bool ebpf_from_cb
 			/* Keep the same instruction layout. */
 			emit_nops(&prog, 3);     /* nop3 */
 	}
-	/* Exception callback receives FP as third parameter */
+	/*
+	 * Exception callback receives:
+	 *   rsi =3D main program's SP, rdx =3D main program's FP,
+	 *   rcx =3D main program's outgoing stack arg area size
+	 */
 	if (is_exception_cb) {
 		EMIT3(0x48, 0x89, 0xF4); /* mov rsp, rsi */
 		EMIT3(0x48, 0x89, 0xD5); /* mov rbp, rdx */
+		EMIT3(0x48, 0x01, 0xCC); /* add rsp, rcx */
 		/* The main frame must have exception_boundary as true, so we
 		 * first restore those callee-saved regs from stack, before
 		 * reusing the stack frame.
@@ -1789,6 +1794,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : =
0;
+	if (bpf_prog->aux->exception_boundary)
+		bpf_prog->aux->stack_arg_adjust =3D outgoing_rsp;
 	emit_sub_rsp(&prog, outgoing_rsp);
=20
 	if (arena_vm_start)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 242f9597d9ab..2a1616c769a9 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1735,7 +1735,8 @@ struct bpf_prog_aux {
 	int cgroup_atype; /* enum cgroup_bpf_attach_type */
 	struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
 	char name[BPF_OBJ_NAME_LEN];
-	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
+	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64 stack_arg_adjus=
t, u64);
+	u16 stack_arg_adjust;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2cec4e8cd4a0..52aaf2863648 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1265,6 +1265,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	prog->aux->real_func_cnt =3D env->subprog_cnt;
 	prog->aux->bpf_exception_cb =3D (void *)func[env->exception_callback_su=
bprog]->bpf_func;
 	prog->aux->exception_boundary =3D func[0]->aux->exception_boundary;
+	prog->aux->stack_arg_adjust =3D func[0]->aux->stack_arg_adjust;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index baa12b24bb64..53a0430f60b3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3301,7 +3301,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * which skips compiler generated instrumentation to do the same.
 	 */
 	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
-	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, 0, 0);
+	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp, ctx.aux->stack_arg_ad=
just, 0);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
=20
--=20
2.53.0-Meta

