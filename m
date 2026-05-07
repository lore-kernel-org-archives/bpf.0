Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18F3451A6
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 21:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189423; cv=none; b=PnVzDb1gInZSNL5fO2IuW4nIrnMklz3Rd+mcMBH2/sg6xstW8o0dX5CtDTko8SqIg+++t1oWA+4CHo12lJUQoQK6g4XC/t9nhxC2oL32y7+8dC6hEMo5HWCWMIkyKRL/0z2sjb1iSb8KxSs88E0oyMhyGX0mf2OtiBR/lXpGOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189423; c=relaxed/simple;
	bh=n27CiTElE7MYWl8Bu6oQ9w0e4Gd+aGeCUCI/qUue72A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Apgjh+8udtcBptbFFiMgh9yEKAljBDGyrmC+7X32kfjeV4Q9o7MEB4GoITCSmMO+9Y3EXu6os/QCTT5WaeqdsH4PVR5B9Bwas3Ak4p0g2gWLs035hZ8K1PMHjrFlMzB+zWEzQRzsM0504mY8kcxl/JHFdDIBedUqhzyqpMNWajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E16E792BAA32D; Thu,  7 May 2026 14:30:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 07/23] bpf: Add precision marking and backtracking for stack argument slots
Date: Thu,  7 May 2026 14:30:18 -0700
Message-ID: <20260507213018.1128602-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507212942.1122000-1-yonghong.song@linux.dev>
References: <20260507212942.1122000-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Extend the precision marking and backtracking infrastructure to
support stack argument slots (r11-based accesses). Without this,
precision demands for scalar values passed through stack arguments
are silently dropped, which could allow the verifier to incorrectly
prune states with different constant values in stack arg slots.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  8 +++++
 kernel/bpf/backtrack.c       | 64 +++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        | 32 +++++++++++++++---
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2d5c8f36f451..24171221f6cf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -443,6 +443,8 @@ enum {
=20
 	INSN_F_DST_REG_STACK =3D BIT(1), /* dst_reg is PTR_TO_STACK */
 	INSN_F_SRC_REG_STACK =3D BIT(2), /* src_reg is PTR_TO_STACK */
+
+	INSN_F_STACK_ARG_ACCESS =3D BIT(3),
 };
=20
 struct bpf_jmp_history_entry {
@@ -839,6 +841,7 @@ struct backtrack_state {
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
 	u64 stack_masks[MAX_CALL_FRAMES];
+	u8 stack_arg_masks[MAX_CALL_FRAMES];
 };
=20
 struct bpf_id_pair {
@@ -1237,6 +1240,11 @@ static inline void bpf_bt_set_frame_slot(struct ba=
cktrack_state *bt, u32 frame,
 	bt->stack_masks[frame] |=3D 1ull << slot;
 }
=20
+static inline void bt_set_frame_stack_arg_slot(struct backtrack_state *b=
t, u32 frame, u32 slot)
+{
+	bt->stack_arg_masks[frame] |=3D 1 << slot;
+}
+
 static inline bool bt_is_frame_reg_set(struct backtrack_state *bt, u32 f=
rame, u32 reg)
 {
 	return bt->reg_masks[frame] & (1 << reg);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 93738a076c88..17f254a02831 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -130,11 +130,21 @@ static inline u32 bt_empty(struct backtrack_state *=
bt)
 	int i;
=20
 	for (i =3D 0; i <=3D bt->frame; i++)
-		mask |=3D bt->reg_masks[i] | bt->stack_masks[i];
+		mask |=3D bt->reg_masks[i] | bt->stack_masks[i] | bt->stack_arg_masks[=
i];
=20
 	return mask =3D=3D 0;
 }
=20
+static inline void bt_clear_frame_stack_arg_slot(struct backtrack_state =
*bt, u32 frame, u32 slot)
+{
+	bt->stack_arg_masks[frame] &=3D ~(1 << slot);
+}
+
+static inline bool bt_is_frame_stack_arg_slot_set(struct backtrack_state=
 *bt, u32 frame, u32 slot)
+{
+	return bt->stack_arg_masks[frame] & (1 << slot);
+}
+
 static inline int bt_subprog_enter(struct backtrack_state *bt)
 {
 	if (bt->frame =3D=3D MAX_CALL_FRAMES - 1) {
@@ -195,6 +205,11 @@ static inline u64 bt_stack_mask(struct backtrack_sta=
te *bt)
 	return bt->stack_masks[bt->frame];
 }
=20
+static inline u8 bt_stack_arg_mask(struct backtrack_state *bt)
+{
+	return bt->stack_arg_masks[bt->frame];
+}
+
 static inline bool bt_is_reg_set(struct backtrack_state *bt, u32 reg)
 {
 	return bt->reg_masks[bt->frame] & (1 << reg);
@@ -336,6 +351,19 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			return 0;
 		bt_clear_reg(bt, load_reg);
=20
+		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
+			spi =3D hist->spi;
+			/*
+			 * Stack arg read: callee reads from r11+off, but
+			 * the data lives in the caller's stack_arg_regs.
+			 * Set the mask in the caller frame so precision
+			 * is marked in the caller's slot at the callee
+			 * entry checkpoint.
+			 */
+			bt_set_frame_stack_arg_slot(bt, bt->frame - 1, spi);
+			return 0;
+		}
+
 		/* scalars can only be spilled into stack w/o losing precision.
 		 * Load from any other memory can be zero extended.
 		 * The desire to keep that precision is already indicated
@@ -358,6 +386,17 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			 * encountered a case of pointer subtraction.
 			 */
 			return -ENOTSUPP;
+
+		if (hist && hist->flags & INSN_F_STACK_ARG_ACCESS) {
+			spi =3D hist->spi;
+			if (!bt_is_frame_stack_arg_slot_set(bt, bt->frame, spi))
+				return 0;
+			bt_clear_frame_stack_arg_slot(bt, bt->frame, spi);
+			if (class =3D=3D BPF_STX)
+				bt_set_reg(bt, sreg);
+			return 0;
+		}
+
 		/* scalars can only be spilled into stack */
 		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
@@ -426,6 +465,18 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
 					}
 				}
+				/*
+				 * propagate callee's incoming stack arg precision
+				 * to caller's outgoing stack arg slots
+				 */
+				if (bt_stack_arg_mask(bt)) {
+					for (i =3D 0; i < MAX_BPF_FUNC_ARGS - MAX_BPF_FUNC_REG_ARGS; i++) {
+						if (!bt_is_frame_stack_arg_slot_set(bt, bt->frame, i))
+							continue;
+						bt_clear_frame_stack_arg_slot(bt, bt->frame, i);
+						bt_set_frame_stack_arg_slot(bt, bt->frame - 1, i);
+					}
+				}
 				if (bt_subprog_exit(bt))
 					return -EFAULT;
 				return 0;
@@ -896,6 +947,17 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
 					*changed =3D true;
 				}
 			}
+			for (i =3D 0; i < func->out_stack_arg_cnt; i++) {
+				if (!bt_is_frame_stack_arg_slot_set(bt, fr, i))
+					continue;
+				reg =3D &func->stack_arg_regs[i];
+				if (reg->type !=3D SCALAR_VALUE || reg->precise) {
+					bt_clear_frame_stack_arg_slot(bt, fr, i);
+				} else {
+					reg->precise =3D true;
+					*changed =3D true;
+				}
+			}
 			if (env->log.level & BPF_LOG_LEVEL2) {
 				fmt_reg_mask(env->tmp_str_buf, TMP_STR_BUF_LEN,
 					     bt_frame_reg_mask(bt, fr));
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 010efdb766ac..4827df9f817c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -292,6 +292,11 @@ static int arg_from_argno(argno_t a)
 	return -1;
 }
=20
+static int arg_idx_from_argno(argno_t a)
+{
+	return arg_from_argno(a) - 1;
+}
+
 static const char *btf_type_name(const struct btf *btf, u32 id)
 {
 	return btf_name_by_offset(btf, btf_type_by_id(btf, id)->name_off);
@@ -4118,7 +4123,8 @@ static int check_stack_arg_write(struct bpf_verifie=
r_env *env, struct bpf_func_s
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
 	state->no_stack_arg_load =3D true;
-	return 0;
+	return bpf_push_jmp_history(env, env->cur_state,
+				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
 }
=20
 /*
@@ -4149,7 +4155,17 @@ static int check_stack_arg_read(struct bpf_verifie=
r_env *env, struct bpf_func_st
 	arg =3D &caller->stack_arg_regs[spi];
 	cur =3D vstate->frame[vstate->curframe];
 	cur->regs[dst_regno] =3D *arg;
-	return 0;
+	return bpf_push_jmp_history(env, env->cur_state,
+				    INSN_F_STACK_ARG_ACCESS, spi, 0, 0);
+}
+
+static int mark_stack_arg_precision(struct bpf_verifier_env *env, int ar=
g_idx)
+{
+	struct bpf_func_state *caller =3D cur_func(env);
+	int spi =3D arg_idx - MAX_BPF_FUNC_REG_ARGS;
+
+	bt_set_frame_stack_arg_slot(&env->bt, caller->frameno, spi);
+	return mark_chain_precision_batch(env, env->cur_state);
 }
=20
 static int check_outgoing_stack_args(struct bpf_verifier_env *env, struc=
t bpf_func_state *caller,
@@ -6878,8 +6894,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
 	}
 	err =3D check_helper_mem_access(env, mem_reg, mem_argno, reg_umax(size_=
reg),
 				      access_type, zero_size_allowed, meta);
-	if (!err)
-		err =3D mark_chain_precision(env, reg_from_argno(size_argno));
+	if (!err) {
+		int regno =3D reg_from_argno(size_argno);
+
+		if (regno >=3D 0)
+			err =3D mark_chain_precision(env, regno);
+		else
+			err =3D mark_stack_arg_precision(env, arg_idx_from_argno(size_argno))=
;
+	}
 	return err;
 }
=20
@@ -7328,7 +7350,7 @@ static int process_iter_arg(struct bpf_verifier_env=
 *env, struct bpf_reg_state *
 			    struct bpf_kfunc_call_arg_meta *meta)
 {
 	const struct btf_type *t;
-	u32 arg_idx =3D arg_from_argno(argno) - 1;
+	u32 arg_idx =3D arg_idx_from_argno(argno);
 	int spi, err, i, nr_slots, btf_id;
=20
 	if (reg->type !=3D PTR_TO_STACK) {
--=20
2.53.0-Meta

