Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD19280331
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 05:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118792; cv=none; b=e0DfHh1pES+/MoKbJE3dutxJeyG7AXj7aEGCjpgn8WJsjnZAalWb0OKByO1W/xxwovDCTAKqBNAWwVK3kOgUm1r2ngbfF8P/o7LU3Qny1qB6NflXjS+7h7RnlObywJ6JThq5oDKJRVUCNaENR9LpxAenvED5KwDxi1Yfec891LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118792; c=relaxed/simple;
	bh=R8y6mtYSfCZXQf5YOkyiXeAtTiU1+7YJbDicQ9MXe0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5xjAoaD1PPxGrzqvAJKHTiTku9aJ2xzsh+82wYU05BtJi5kc+uWcSZYh/qa0w49rJqK9ym8h9xST5HJu4qURc2+xemSV5XdSu6PV8ZzCVtMwRGK5qwuJiMHUDkKnQ3iLXqcnMEYL/SPU1nAh4TNKhd7cjhz8uQZOtrsAtZlk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 92143250AA389F; Tue, 18 Aug 2026 22:52:59 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 04/10] bpf: Handle R2 as a return register in precision backtracking
Date: Tue, 18 Aug 2026 22:52:59 -0700
Message-ID: <20260819055259.3295829-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819055239.3293449-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Precision backtracking treats only R0 as a return register at a
call/return boundary, so once the verifier starts modeling R2 that way,
marking the second half of such a return precise would trip the
"unexpected regs" checks in backtrack_insn() and reject a valid
program.

Marking the upper half precise, for example by branching on it after a
call to a static subprogram, walks backtracking into the callee and
reaches its BPF_EXIT with R2 still set in the mask. Handle R2 like R0
in boundaries where a call defines the return registers.

R2 differs from R0 in that it is an argument register as well, so it is
part of the BPF_REGMASK_ARGS check and has to be cleared before that chec=
k
rather than next to R0. Clear it unconditionally, rather than only where
the callee or the kfunc really does return a pair. That gives up the
"unexpected regs" assertion for R2, and in exchange keeps backtracking
free of any BTF lookup. Nothing is lost: a callee that does not return
a pair leaves the caller's R2 uninitialized, so the main verification
pass has already rejected any program that reads it, and backtracking
is never asked for its precision.

At BPF_EXIT the return registers are sampled before the callback path
clears R1-R5. That clear does not touch R0, but it does cover R2, and
running it first would drop a pair return whenever the instruction
following the call happens to be one that invokes a callback.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/backtrack.c | 46 +++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a2b18a9f1694..653db80bcc47 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -423,6 +423,10 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				 */
 				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
 						"extra insn from subprog");
+				/* global subprog always sets R0 */
+				bt_clear_reg(bt, BPF_REG_0);
+				/* and if it does not set R2, main pass would catch it */
+				bt_clear_reg(bt, BPF_REG_2);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -432,8 +436,6 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 						     bt_reg_mask(bt));
 					return -EFAULT;
 				}
-				/* global subprog always sets R0 */
-				bt_clear_reg(bt, BPF_REG_0);
 				return 0;
 			} else {
 				/* static subprog call instruction, which
@@ -506,6 +508,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			bt_clear_reg(bt, BPF_REG_0);
+			/* kfunc might also set R2 */
+			bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracking was looking for registers R1-R5
 				 * they should have been found already.
@@ -520,7 +524,25 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
-			bool r0_precise;
+			bool from_subprog_call, r0_precise, r2_precise;
+
+			/* BPF_EXIT in subprog or callback always returns
+			 * right after the call instruction, so by checking
+			 * whether the instruction at subseq_idx-1 is subprog
+			 * call or not we can distinguish actual exit from
+			 * *subprog* from exit from *callback*. In the former
+			 * case, we need to propagate the precision of the
+			 * return registers, if necessary. In the latter we
+			 * never do that.
+			 */
+			from_subprog_call =3D subseq_idx - 1 >=3D 0 &&
+					    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]);
+
+			/* Sample the return registers before the callback
+			 * handling below clears R1-R5.
+			 */
+			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
+			r2_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_2);
=20
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -533,30 +555,22 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
+
+			bt_clear_reg(bt, BPF_REG_0);
+			bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
 				return -EFAULT;
 			}
=20
-			/* BPF_EXIT in subprog or callback always returns
-			 * right after the call instruction, so by checking
-			 * whether the instruction at subseq_idx-1 is subprog
-			 * call or not we can distinguish actual exit from
-			 * *subprog* from exit from *callback*. In the former
-			 * case, we need to propagate r0 precision, if
-			 * necessary. In the former we never do that.
-			 */
-			r0_precise =3D subseq_idx - 1 >=3D 0 &&
-				     bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1]) &&
-				     bt_is_reg_set(bt, BPF_REG_0);
-
-			bt_clear_reg(bt, BPF_REG_0);
 			if (bt_subprog_enter(bt))
 				return -EFAULT;
=20
 			if (r0_precise)
 				bt_set_reg(bt, BPF_REG_0);
+			if (r2_precise)
+				bt_set_reg(bt, BPF_REG_2);
 			/* r6-r9 and stack slots will stay set in caller frame
 			 * bitmasks until we return back from callee(s)
 			 */
--=20
2.53.0-Meta

