Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8252269F
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911372; cv=none; b=sHWrpd6MP46D1l+lSpM+tgvZ5WyQ45iAO4VaObNcNuZDOMveiiyGmOTbzF4a7nJt03AZ1sroGGbk+xs9mzoJHYyUhhb9oJBBlefKNH9rbHJ/G3/rHvXm6SFwvubPpUVwK0URN8IiXtTptAVNVflyOi2Dt32Wizsw91PP5QXZqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911372; c=relaxed/simple;
	bh=zXMLm7/vzPhDyOb2V+/t9dW0Ujl9MRkXLNf+qHnZXns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3OJaHXv30L4p191DJ84wJvzo+Dl4P2KEH9x39qgmNDBp/7Dsd+AuaUdQ53l8RKJWAuqLIBTFf5sKizgMaTGAC3U31pKtNI4hL7rJZhGWSd2Wq1EAPsaXh2s2b0O/K8AwaDKI8LcQ0BAiVzQUdzM6hPzDAKcVcLaBLT21V5lhBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F401A30FB5C335; Tue, 13 Oct 2026 10:09:15 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 01/11] bpf, x86: Pass a trampoline's stack arguments by the calling convention
Date: Tue, 13 Oct 2026 10:09:15 -0700
Message-ID: <20261013170915.2128212-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013170910.2126673-1-yonghong.song@linux.dev>
References: <20261013170910.2126673-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A trampoline on a function of a program that can tail call keeps the
tail call counter pointer by pushing rax after allocating its frame.
When it calls the original function, for fexit, fmod_ret or fsession,
the push sits between the stack arguments and the return address, which
the x86-64 calling convention does not allow. For example, in

	run() -> call_stack() -> callee_stack(a, b, c, d, e, f, g, h)
	run() -> subprog_tail() -> bpf_tail_call()

callee_stack() is not on the path to the tail call, so the verifier
allows its stack arguments g and h. fexit on it builds, with T the
trampoline's rbp:

	T-120  h                  save_args()
	T-128  g                  save_args(), RSP after sub rsp, 128
	T-136  tail_call_cnt_ptr  push rax, RSP at the call
	T-144  return address     call orig_call

and callee_stack() finds the counter pointer where g belongs, at 8(%rsp)
on entry, and g where h belongs.

Keep the pointer in a slot of the frame instead, so that the stack
arguments sit right above the return address again:

	T-120  tail_call_cnt_ptr  mov [rbp - 120], rax
	T-128  (pad to 16)
	T-136  h                  save_args()
	T-144  g                  save_args(), RSP at the call
	T-152  return address     call orig_call

Fixes: 324c3ca6eed6 ("bpf,x86: Implement JIT support for stack arguments"=
)
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 083fcd6cf15b..3982507d54ca 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3743,9 +3743,9 @@ static int invoke_bpf_mod_ret(const struct btf_func=
_model *m, u8 **pprog,
 	return 0;
 }
=20
-/* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
-#define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
-	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
+/* mov rax, qword ptr [rbp - off] */
+#define LOAD_TRAMP_TAIL_CALL_CNT_PTR(off)	\
+	__LOAD_TCC_PTR(-(off))
=20
 /* Example:
  * __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev);
@@ -3815,6 +3815,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 {
 	int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
 	int regs_off, func_meta_off, ip_off, run_ctx_off, arg_stack_off, rbx_of=
f;
+	int tcc_off =3D 0;
 	struct bpf_tramp_nodes *fentry =3D &tnodes[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_nodes *fexit =3D &tnodes[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_nodes *fmod_ret =3D &tnodes[BPF_TRAMP_MODIFY_RETURN];
@@ -3865,11 +3866,12 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
 	 *
 	 * RBP - run_ctx_off [ bpf_tramp_run_ctx ]
 	 *
+	 * RBP - tcc_off   [ tail_call_cnt_ptr ]  BPF_TRAMP_F_TAIL_CALL_CTX
+	 *
 	 *                     [ stack_argN ]  BPF_TRAMP_F_CALL_ORIG
 	 *                     [ ...        ]
 	 *                     [ stack_arg2 ]
 	 * RBP - arg_stack_off [ stack_arg1 ]
-	 * RSP                 [ tail_call_cnt_ptr ] BPF_TRAMP_F_TAIL_CALL_CTX
 	 */
=20
 	/* room for return value of orig_call or fentry prog */
@@ -3900,6 +3902,11 @@ static int __arch_prepare_bpf_trampoline(struct bp=
f_tramp_image *im, void *rw_im
 	stack_size +=3D (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
 	run_ctx_off =3D stack_size;
=20
+	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
+		stack_size +=3D 8;
+		tcc_off =3D stack_size;
+	}
+
 	if (nr_regs > 6 && (flags & BPF_TRAMP_F_CALL_ORIG)) {
 		/* the space that used to pass arguments on-stack */
 		stack_size +=3D (nr_regs - get_nr_used_regs(m)) * 8;
@@ -3957,7 +3964,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 		EMIT4(0x48, 0x83, 0xEC, stack_size);
 	}
 	if (flags & BPF_TRAMP_F_TAIL_CALL_CTX)
-		EMIT1(0x50);		/* push rax */
+		/* mov QWORD PTR [rbp - tcc_off], rax */
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -tcc_off);
 	/* mov QWORD PTR [rbp - rbx_off], rbx */
 	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_6, -rbx_off);
=20
@@ -4018,7 +4026,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 			/* Before calling the original function, load the
 			 * tail_call_cnt_ptr from stack to rax.
 			 */
-			LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
+			LOAD_TRAMP_TAIL_CALL_CNT_PTR(tcc_off);
 		}
=20
 		if (flags & BPF_TRAMP_F_ORIG_STACK) {
@@ -4082,7 +4090,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 		/* Before running the original function, load the
 		 * tail_call_cnt_ptr from stack to rax.
 		 */
-		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
+		LOAD_TRAMP_TAIL_CALL_CNT_PTR(tcc_off);
 	}
=20
 	/* restore return value of orig_call or fentry prog back into RAX */
--=20
2.53.0-Meta

