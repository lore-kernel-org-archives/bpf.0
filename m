Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6D3E5A1C
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541409; cv=none; b=O9mGJybU6/Iz0fgX3y4WdQWQSgV9mwB7dGeo8AyQExK4pZM28M+2k2z4RqsuNFz5NYPZoAsUPcNhIavd8CBLE0qV+5hgUq7UjvahNrBsaa3fLeMuhXFfkuYtj9KryosVNtMjINjvHVxHqLs9ODbGz84decDvy4YVrBAbszTpT0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541409; c=relaxed/simple;
	bh=QBOHjkebzAgLCMypsYzyb0Tv5af92XiYv6D886UprEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1y0MEwQAdpfA7+Rhid7HSzvijXLY4OQh2VHQS7wehRA60hPRxFpX3kTz+g/5bTistbxENBBElKODMfml0nyAY/7oJR4/qR7DTazU84H+ozTxmrg04CxXOS71ao1vN9e2+b+ZefXIxcsVsWvyLSg1ozk7PdPtzwsuorLpR+uzj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 2D72C1D0B6F808; Wed,  8 Jul 2026 13:10:00 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 04/12] bpf: Track R2 of register-pair returns in precision backtracking
Date: Wed,  8 Jul 2026 13:10:00 -0700
Message-ID: <20260708201000.2157684-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708200939.2153664-1-yonghong.song@linux.dev>
References: <20260708200939.2153664-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A function returning a value larger than 8 bytes (a struct/union, or an
__int128) uses R2 as a second return register alongside R0. Previous
precision backtracking only treated R0 as a return register at a
call/return boundary, so marking the second half of such a return precise
would trip the "unexpected regs" checks in backtrack_insn() and reject a
valid program with -EFAULT.

Handle R2 like R0 in the three boundaries where a call defines the return
registers:

 - static subprog exit (BPF_EXIT): R2 is a return register, not a leftove=
r
   argument; clear it before the args check and propagate its precision
   into the callee.
 - global subprog call: a global subprog returning >8 bytes also sets R2;
   clear it before the args check.
 - kfunc call (BPF_CALL): a kfunc returning >8 bytes (model ret_size > 8)
   also sets R2; clear it like R0.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/backtrack.c       | 32 +++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        | 13 ++++++++++++-
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..fa255f326240 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1431,6 +1431,8 @@ int bpf_jmp_offset(struct bpf_insn *insn);
 struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx);
 void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
 bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subpr=
og);
+bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog);
+int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id, u16=
 offset);
=20
 int bpf_find_subprog(struct bpf_verifier_env *env, int off);
 bool bpf_is_throw_kfunc(struct bpf_insn *insn);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 2e4ae0ef0860..c46c2778bf60 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -424,6 +424,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 				 */
 				verifier_bug_if(idx + 1 !=3D subseq_idx, env,
 						"extra insn from subprog");
+				if (bpf_ret_reg_pair(env, subprog))
+					bt_clear_reg(bt, BPF_REG_2);
 				/* r1-r5 are invalidated after subprog call,
 				 * so for global func call it shouldn't be set
 				 * anymore
@@ -507,6 +509,12 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 				return -ENOTSUPP;
 			/* regular helper call sets R0 */
 			bt_clear_reg(bt, BPF_REG_0);
+			/* On error the return is negative, R2 stays set, and the
+			 * check below catches it as an unexpected register.
+			 */
+			if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL &&
+			    bpf_get_kfunc_ret_size(env->prog, insn->imm, insn->off) > 8)
+				bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				/* if backtracking was looking for registers R1-R5
 				 * they should have been found already.
@@ -521,7 +529,25 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					return -EFAULT;
 			}
 		} else if (opcode =3D=3D BPF_EXIT) {
-			bool r0_precise;
+			bool r0_precise, r2_precise =3D false;
+
+			/* A subprog returning a value larger than 8 bytes (a
+			 * struct/union or an __int128) uses R2 as a second
+			 * return register alongside R0. When exiting such a
+			 * subprog, R2 is a return register rather than a
+			 * leftover argument, so handle it like R0 below.
+			 */
+			if (subseq_idx - 1 >=3D 0 &&
+			    bpf_pseudo_call(&env->prog->insnsi[subseq_idx - 1])) {
+				int call_idx =3D subseq_idx - 1;
+				int tgt =3D call_idx + env->prog->insnsi[call_idx].imm + 1;
+				int subprog =3D bpf_find_subprog(env, tgt);
+
+				if (subprog >=3D 0 &&
+				    bpf_ret_reg_pair(env, subprog) &&
+				    bt_is_reg_set(bt, BPF_REG_2))
+					r2_precise =3D true;
+			}
=20
 			/* Backtracking to a nested function call, 'idx' is a part of
 			 * the inner frame 'subseq_idx' is a part of the outer frame.
@@ -534,6 +560,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 			if (subseq_idx >=3D 0 && bpf_calls_callback(env, subseq_idx))
 				for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 					bt_clear_reg(bt, i);
+			if (r2_precise)
+				bt_clear_reg(bt, BPF_REG_2);
 			if (bt_reg_mask(bt) & BPF_REGMASK_ARGS) {
 				verifier_bug(env, "backtracking exit unexpected regs %x",
 					     bt_reg_mask(bt));
@@ -558,6 +586,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
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
index e3f934cf702d..fcbf532159a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -424,7 +424,7 @@ static bool subprog_returns_void(struct bpf_verifier_=
env *env, int subprog)
 	return btf_type_is_void(type);
 }
=20
-static bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
+bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int subprog)
 {
 	const struct btf_type *type, *func, *func_proto;
 	const struct btf *btf =3D env->prog->aux->btf;
@@ -2521,6 +2521,17 @@ int bpf_get_kfunc_addr(const struct bpf_prog *prog=
, u32 func_id,
 	return 0;
 }
=20
+int bpf_get_kfunc_ret_size(const struct bpf_prog *prog, u32 func_id, u16=
 offset)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc =3D find_kfunc_desc(prog, func_id, offset);
+	if (!desc)
+		return -EFAULT;
+
+	return desc->func_model.ret_size;
+}
+
 #define BPF_FD_SLOT_BTF	1UL
=20
 static void fd_slot_set_map(struct bpf_fd_array *slot, struct bpf_map *m=
ap)
--=20
2.53.0-Meta

