Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7230566F
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940536; cv=none; b=Frcn7jrpxqaYRXo0jbKrgm8itTXL86FZ1O2rgrCo3qJb5z7JHpQz6xc+MSui7t4BvN9Icb85LKopi7ftfAjsj9lgYpPhjgWUdTkXdjpQU//89iRBUTMMBb5igu5Yj4gJp7rz8xvq7s3uFx/pDXVNzGyhaj81CWVI36Js7z5pYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940536; c=relaxed/simple;
	bh=41atCl3e/EPnkj3qVUAOJsNGvDCR/yKKuw4F2NfzzeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBQ7DGj9fuRz1Qg4R17VzMRSOkPPFtCz8XAYr1sMCAUGex669rPR88fFtw+Fq9nxKDemNwZukBiWdyBXYk1Va+vw2Jh1HdqAYRKNmv4dZATgQEPUQS5IrYi1Ebm+MLYqa7a6e5BLdxJxl2IkIpXURrX8eSPap6E/1LaYBBaAe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0E95724982E77B; Sun, 16 Aug 2026 21:22:02 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 04/10] bpf: Handle R2 as a return register in precision backtracking
Date: Sun, 16 Aug 2026 21:22:02 -0700
Message-ID: <20260817042202.2288574-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817042141.2286086-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
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

