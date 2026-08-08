Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF873812E1
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215837; cv=none; b=KZs59k1h+62MsWIDmWt7Sbu4yD7ojt1OJxkJMqkK4KCH40cJ822iLfVZYDfi1uoJ+g7Ow2RyNPjymaN3oaY7uHDmo6lhOB3IFZOkpRakvAYKrydLQ9dlYW25YvVZaTmdRC11R8p7DMilEOEaZSaJXtmLse6piwOeyqBBq/hb7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215837; c=relaxed/simple;
	bh=SJXDY5VsZy3h4i4YNYKmDPfO9qO6iBbWiShU6wXGvbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlT7qGo80K6M1tGIg8PlAO14TNmsrpJfx0Ve5wFg9pKBR32bjtFQcaFaNhsXFLFqruDdCC3dILLMJp1Lc0ZMha20xKT5QyV4s93bWOUogztm9L0quEj6oEYEjaHZppmjO4uAKivz9XyJFOh8rEXHHPY9Obk2jdR+Zba0gKZ/Dz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CAFD022CA31C73; Sat,  8 Aug 2026 12:03:42 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 04/13] bpf: Track R2 of register-pair returns in precision backtracking
Date: Sat,  8 Aug 2026 12:03:42 -0700
Message-ID: <20260808190342.1898844-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A function returning a value larger than 8 bytes (a struct/union, or an
__int128) uses R2 as a second return register alongside R0. Precision
backtracking treats only R0 as a return register at a call/return boundar=
y,
so once the verifier starts modeling R2 that way, marking the second half
of such a return precise would trip the "unexpected regs" checks in
backtrack_insn() and reject a valid program with -EFAULT. Handle it here,
ahead of the patch that introduces the modeling.

Marking the upper half precise, for example by branching on it after a
call to a static subprogram, walks backtracking into the callee and
reaches its BPF_EXIT with R2 still set in the mask. R2 is part of
BPF_REGMASK_ARGS, so this hits "backtracking exit unexpected regs".
Returning the pair from a global subprogram or from a kfunc instead hits
the equivalent check at the call site.

Handle R2 like R0 in the three boundaries where a call defines the return
registers:

 - static subprog exit (BPF_EXIT): when the callee returns a pair, R2 is =
a
   return register rather than a clobbered argument, so its precision has=
 to
   cross the frame boundary just like R0's: clear it from the caller's ma=
sk
   before the R1-R5 check, then set it again in the callee's mask after
   bt_subprog_enter().

   The clear has to be conditional, which is why the subprogram containin=
g
   the exit insn is looked up and queried. For a callee that does not ret=
urn
   a pair, check_func_call() has already invalidated the caller's R1-R5 a=
nd
   prepare_func_exit() copies back only R0, so nothing after the call can
   depend on R2 and backtracking should never still be asking for it here=
.
   Clearing it unconditionally would turn that into a silent no-op instea=
d
   of reporting it through the existing "backtracking exit unexpected reg=
s"
   check.
 - global subprog call: a global subprog returning >8 bytes also sets R2;
   clear it before the args check.
 - kfunc call (BPF_CALL): a kfunc returning >8 bytes (model ret_size > 8)
   also sets R2; clear it like R0.

All three are gated on R2 actually being in the mask, so the extra BTF an=
d
kfunc descriptor lookups stay off the common backtracking path.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/backtrack.c       | 61 +++++++++++++++++++++++++++++-------
 kernel/bpf/verifier.c        | 13 ++++++++
 3 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 79680f3b4c74..911d57ce2488 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1447,6 +1447,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
+int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id,
+			   u16 btf_fd_idx, u8 *ret_size);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 40bd04421a99..9b112bf427a5 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -425,6 +425,14 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				 */
 				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
 						"extra insn from subprog");
+				/* a global subprog returning more than 8 bytes
+				 * sets R2 as well. R2 is part of the args mask
+				 * checked just below, so it has to be cleared
+				 * here rather than next to R0.
+				 */
+				if (bt_is_reg_set(bt, BPF_REG_2) &&
+				    bpf_ret_reg_pair(env, subprog))
+					bt_clear_reg(bt, BPF_REG_2);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -508,6 +516,19 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			bt_clear_reg(bt, BPF_REG_0);
+			/* a kfunc returning more than 8 bytes also sets R2 */
+			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
+			    bt_is_reg_set(bt, BPF_REG_2)) {
+				u8 ret_size;
+				int err;
+
+				err =3D bpf_get_kfunc_ret_size(env->prog, insn->imm, insn->off,
+							     &ret_size);
+				if (verifier_bug_if(err, env, "no kfunc desc for insn %d", idx))
+					return -EFAULT;
+				if (ret_size > 8)
+					bt_clear_reg(bt, BPF_REG_2);
+			}
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracking was looking for registers R1-R5
 				 * they should have been found already.
@@ -522,7 +543,29 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
-			bool r0_precise;
+			bool from_subprog_call, r0_precise, r2_precise =3D false;
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
+			if (from_subprog_call && bt_is_reg_set(bt, BPF_REG_2)) {
+				struct bpf_subprog_info *callee;
+
+				/* 'idx' is the exit insn, so it is in the callee */
+				callee =3D bpf_find_containing_subprog(env, idx);
+				if (verifier_bug_if(!callee, env,
+						    "no subprog contains exit insn %d", idx))
+					return -EFAULT;
+				r2_precise =3D bpf_ret_reg_pair(env, callee - env->subprog_info);
+			}
=20
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -535,23 +578,15 @@ static int backtrack_insn(struct bpf_verifier_env *=
env, int idx, int subseq_idx,
 			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
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
+			r0_precise =3D from_subprog_call && bt_is_reg_set(bt, BPF_REG_0);
=20
 			bt_clear_reg(bt, BPF_REG_0);
 			if (bt_subprog_enter(bt))
@@ -559,6 +594,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
=20
 			if (r0_precise)
 				bt_set_reg(bt, BPF_REG_0);
+			if (r2_precise)
+				bt_set_reg(bt, BPF_REG_2);
 			/* r6-r9 and stack slots will stay set in caller frame
 			 * bitmasks until we return back from callee(s)
 			 */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index eed96a795e8a..f9a6c3c2132b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2500,6 +2500,19 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog=
, u32 func_id,
 	return 0;
 }
=20
+int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id,
+			   u16 btf_fd_idx, u8 *ret_size)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc =3D find_kfunc_desc(prog, func_id, btf_fd_idx);
+	if (!desc)
+		return -EFAULT;
+
+	*ret_size =3D desc->func_model.ret_size;
+	return 0;
+}
+
 #define BPF_FD_SLOT_BTF	1UL
=20
 static void fd_slot_set_map(struct bpf_fd_array *slot, struct bpf_map *m=
ap)
--=20
2.53.0-Meta

