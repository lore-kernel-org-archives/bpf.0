Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A71836607F
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477606; cv=none; b=QSYNzqpuZX1MMYOmTghNhOmPe1JYAQCUhlNauYX6vgWN/5liwbJgAfNomB3BmA9NRN+tqNCxbb8kPaFan4n+LOU75aOvH9PfwyPK1W+/yJ+Oi/W0cZT9DR+IoziOoxP4TikqUtkuWvDCkazWm4V5ChrVFgvxJEVc+AoxbQTMV94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477606; c=relaxed/simple;
	bh=8JQqSHt5S/N1w0F7EGKbOvzbXZZTiZbBVzVrafOfnCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EQouF2XaFCffnkCJEW75BgA8+K0tuutUAJnPiWBZJ/NgaUj3RQ24KKNdR9D08KS4a+mFQXslZVbJxJNiCbs7F70NmgQWwLWW1CR5oRGcQ9umWXAmRpJL6rk/0CYLOUc+mQT1iQ4gUsTO65l22dpWonbp2/MlHSSjtbCWzBkQQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 436F3A59DB74C; Sun, 10 May 2026 22:33:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 02/24] bpf: Remove copy_register_state wrapper function
Date: Sun, 10 May 2026 22:33:12 -0700
Message-ID: <20260511053312.1881536-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260511053301.1878610-1-yonghong.song@linux.dev>
References: <20260511053301.1878610-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove the copy_register_state() helper which was just a plain struct
assignment wrapper and replace all call sites with direct struct
assignment. This simplifies the code in preparation for upcoming stack
argument support.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 44 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 11054ad89c14..3bafb7ad2ba7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3410,12 +3410,6 @@ static void assign_scalar_id_before_mov(struct bpf=
_verifier_env *env,
 		src_reg->id =3D ++env->id_gen;
 }
=20
-/* Copy src state preserving dst->parent and dst->live fields */
-static void copy_register_state(struct bpf_reg_state *dst, const struct =
bpf_reg_state *src)
-{
-	*dst =3D *src;
-}
-
 static void save_register_state(struct bpf_verifier_env *env,
 				struct bpf_func_state *state,
 				int spi, struct bpf_reg_state *reg,
@@ -3423,7 +3417,7 @@ static void save_register_state(struct bpf_verifier=
_env *env,
 {
 	int i;
=20
-	copy_register_state(&state->stack[spi].spilled_ptr, reg);
+	state->stack[spi].spilled_ptr =3D *reg;
=20
 	for (i =3D BPF_REG_SIZE; i > BPF_REG_SIZE - size; i--)
 		state->stack[spi].slot_type[i - 1] =3D STACK_SPILL;
@@ -3822,7 +3816,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 					 * with the destination register on fill.
 					 */
 					assign_scalar_id_before_mov(env, reg);
-				copy_register_state(&state->regs[dst_regno], reg);
+				state->regs[dst_regno] =3D *reg;
 				state->regs[dst_regno].subreg_def =3D subreg_def;
=20
 				/* Break the relation on a narrowing fill.
@@ -3877,7 +3871,7 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 				 * with the destination register on fill.
 				 */
 				assign_scalar_id_before_mov(env, reg);
-			copy_register_state(&state->regs[dst_regno], reg);
+			state->regs[dst_regno] =3D *reg;
 			/* mark reg as written since spilled pointer state likely
 			 * has its liveness marks cleared by is_state_visited()
 			 * which resets stack/reg liveness for state transitions
@@ -6031,7 +6025,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
 						     size);
 					return -EACCES;
 				}
-				copy_register_state(&regs[value_regno], reg);
+				regs[value_regno] =3D *reg;
 				add_scalar_to_reg(&regs[value_regno], off);
 				regs[value_regno].type =3D PTR_TO_INSN;
 			} else {
@@ -13248,7 +13242,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_e=
nv *env,
 	 */
 	if (!ptr_is_dst_reg) {
 		tmp =3D *dst_reg;
-		copy_register_state(dst_reg, ptr_reg);
+		*dst_reg =3D *ptr_reg;
 	}
 	err =3D sanitize_speculative_path(env, NULL, env->insn_idx + 1, env->in=
sn_idx);
 	if (err < 0)
@@ -14698,7 +14692,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 					 * copy register state to dest reg
 					 */
 					assign_scalar_id_before_mov(env, src_reg);
-					copy_register_state(dst_reg, src_reg);
+					*dst_reg =3D *src_reg;
 					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
 				} else {
 					/* case: R1 =3D (s8, s16 s32)R2 */
@@ -14713,7 +14707,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
 						no_sext =3D reg_umax(src_reg) < (1ULL << (insn->off - 1));
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
-						copy_register_state(dst_reg, src_reg);
+						*dst_reg =3D *src_reg;
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
 						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
@@ -14735,7 +14729,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
=20
 						if (is_src_reg_u32)
 							assign_scalar_id_before_mov(env, src_reg);
-						copy_register_state(dst_reg, src_reg);
+						*dst_reg =3D *src_reg;
 						/* Make sure ID is cleared if src_reg is not in u32
 						 * range otherwise dst_reg min/max could be incorrectly
 						 * propagated into src_reg by sync_linked_regs()
@@ -14749,7 +14743,7 @@ static int check_alu_op(struct bpf_verifier_env *=
env, struct bpf_insn *insn)
=20
 						if (no_sext)
 							assign_scalar_id_before_mov(env, src_reg);
-						copy_register_state(dst_reg, src_reg);
+						*dst_reg =3D *src_reg;
 						if (!no_sext)
 							clear_scalar_id(dst_reg);
 						dst_reg->subreg_def =3D env->insn_idx + 1;
@@ -15629,7 +15623,7 @@ static void sync_linked_regs(struct bpf_verifier_=
env *env, struct bpf_verifier_s
 		    reg->delta =3D=3D known_reg->delta) {
 			s32 saved_subreg_def =3D reg->subreg_def;
=20
-			copy_register_state(reg, known_reg);
+			*reg =3D *known_reg;
 			reg->subreg_def =3D saved_subreg_def;
 		} else {
 			s32 saved_subreg_def =3D reg->subreg_def;
@@ -15640,7 +15634,7 @@ static void sync_linked_regs(struct bpf_verifier_=
env *env, struct bpf_verifier_s
 			__mark_reg_known(&fake_reg, (s64)reg->delta - (s64)known_reg->delta);
=20
 			/* reg =3D known_reg; reg +=3D delta */
-			copy_register_state(reg, known_reg);
+			*reg =3D *known_reg;
 			/*
 			 * Must preserve off, id and subreg_def flag,
 			 * otherwise another sync_linked_regs() will be incorrect.
@@ -15743,10 +15737,10 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 	}
=20
 	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
-	copy_register_state(&env->false_reg1, dst_reg);
-	copy_register_state(&env->false_reg2, src_reg);
-	copy_register_state(&env->true_reg1, dst_reg);
-	copy_register_state(&env->true_reg2, src_reg);
+	env->false_reg1 =3D *dst_reg;
+	env->false_reg2 =3D *src_reg;
+	env->true_reg1 =3D *dst_reg;
+	env->true_reg2 =3D *src_reg;
 	pred =3D is_branch_taken(env, dst_reg, src_reg, opcode, is_jmp32);
 	if (pred >=3D 0) {
 		/* If we get here with a dst_reg pointer type it is because
@@ -15815,11 +15809,11 @@ static int check_cond_jmp_op(struct bpf_verifie=
r_env *env,
 	if (err)
 		return err;
=20
-	copy_register_state(dst_reg, &env->false_reg1);
-	copy_register_state(src_reg, &env->false_reg2);
-	copy_register_state(&other_branch_regs[insn->dst_reg], &env->true_reg1)=
;
+	*dst_reg =3D env->false_reg1;
+	*src_reg =3D env->false_reg2;
+	other_branch_regs[insn->dst_reg] =3D env->true_reg1;
 	if (BPF_SRC(insn->code) =3D=3D BPF_X)
-		copy_register_state(&other_branch_regs[insn->src_reg], &env->true_reg2=
);
+		other_branch_regs[insn->src_reg] =3D env->true_reg2;
=20
 	if (BPF_SRC(insn->code) =3D=3D BPF_X &&
 	    src_reg->type =3D=3D SCALAR_VALUE && src_reg->id &&
--=20
2.53.0-Meta

