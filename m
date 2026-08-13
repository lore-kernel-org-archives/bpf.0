Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F035636194E
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651363; cv=none; b=IQcYg9p52wyMyGV6Ittjr7TOODQA4aMvh4VqtGPn2CQDWvkD/4IsAZPyJDyky2BNMIwBIFX5CQ09OY3ewvY/IMutj3/B+fJcWBTDk1zOM0hUQMjlSRALHmlWnOzckPULItQqlwmN5g2BfhJniiTRwzHWt8MGmFcuoiPMvJaK5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651363; c=relaxed/simple;
	bh=6AHs7L1ZFI8xPzvhf9II0gDyaI1cqmeKJPZbC2b7Beg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tlt6l9kpHA65V2swd9YOnlN0xFq1rCfUX3kZAuFb9m13g+3JTOboWkhjQ1Is7hiicFA1bOU4knalbsG5uGCuX5FlT5vWvpN5/68UeRRfEXDqU/03cRrQOV6Z8IAXE1l5vuy5xdc0JT3vS3Wc6iL2Wiw3AexCbpVgIa7m+ZVyTQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 8840C23E02EF8F; Thu, 13 Aug 2026 13:02:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 04/11] bpf: Track R2 of register-pair returns in precision backtracking
Date: Thu, 13 Aug 2026 13:02:30 -0700
Message-ID: <20260813200230.1995389-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
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

R2 differs from R0 in that it is an argument register as well, which
makes two things worth spelling out:

 - R2 is only excused from the BPF_REGMASK_ARGS check where the callee
   or kfunc really does return a pair, as reported by
   bpf_ret_reg_pair()/bpf_kfunc_ret_reg_pair(). Any other call leaves R2
   uninitialized, so a request for its precision cannot be legitimate,
   and clearing it unconditionally would turn that verifier bug from a
   loud -EFAULT into a silently dropped precision request.

 - at BPF_EXIT the return registers are sampled before the callback path
   clears R1-R5. That clear does not touch R0, but it does cover R2, and
   running it first would drop a pair return whenever the instruction
   following the call happens to be one that invokes a callback.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/backtrack.c | 78 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index a2b18a9f1694..0c8e05a7e175 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -423,6 +423,16 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				 */
 				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
 						"extra insn from subprog");
+				/* a global subprog returning more than 8 bytes
+				 * sets R2 as well. R2 is part of the args mask
+				 * checked just below, so clear it here rather
+				 * than next to R0. Only a subprog that does
+				 * return a pair defines R2, so leave the mask
+				 * alone otherwise and let the check below catch
+				 * an R2 that has no business being set.
+				 */
+				if (bpf_ret_reg_pair(env, subprog))
+					bt_clear_reg(bt, BPF_REG_2);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -506,6 +516,17 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			bt_clear_reg(bt, BPF_REG_0);
+			/* a kfunc returning more than 8 bytes also sets R2.
+			 * R2 is part of the args mask checked just below, so
+			 * clear it here rather than next to R0. The prototype
+			 * lookup is only worth doing when R2 is requested at
+			 * all; any other call leaves R2 uninitialized, so a
+			 * request for it is caught by the check below.
+			 */
+			if (bt_is_reg_set(bt, BPF_REG_2) &&
+			    insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
+			    bpf_kfunc_ret_reg_pair(env, insn))
+				bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracking was looking for registers R1-R5
 				 * they should have been found already.
@@ -520,7 +541,41 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
-			bool r0_precise;
+			bool from_subprog_call, r0_precise, r2_precise;
+			struct bpf_insn *call;
+			int subprog;
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
+			 * handling below clears R1-R5: unlike R0, R2 is an
+			 * argument register as well, so that clear would drop
+			 * a pair return on the floor.
+			 */
+			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
+			r2_precise =3D false;
+			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
+				call =3D &env->prog->insnsi[subseq_idx - 1];
+				subprog =3D bpf_find_subprog(env, subseq_idx + call->imm);
+				if (subprog < 0)
+					return -EFAULT;
+				/* Only a callee that does return a pair defines
+				 * R2. Leave the mask alone otherwise, so that
+				 * the check below still catches an R2 that has
+				 * no business being set.
+				 */
+				r2_precise =3D bpf_ret_reg_pair(env, subprog);
+			}
=20
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -533,30 +588,27 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
+
+			/* a callee returning more than 8 bytes sets R2 as well;
+			 * R2 is part of the args mask checked just below, so
+			 * clear it here rather than next to R0.
+			 */
+			if (r2_precise)
+				bt_clear_reg(bt, BPF_REG_2);
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
 			bt_clear_reg(bt, BPF_REG_0);
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

