Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EA3E3C51
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050897; cv=none; b=ZttNY6nT6pHu5PBr87PUs9Jne9gzVtigIeoV79hqvYN9wdHDfdlDDPb7lDSvFZPvA2IR0JOTBovxmb+sCu+HWWrmPfevi22lHirZyNFNBe5OHcegs1P2KImhXjt20DmerBZK+KPlvssY6J/rb9ruqIR8gWAdbsQGFg3ZNmjzTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050897; c=relaxed/simple;
	bh=wKs8cDMSvNQlqifwbZnEua/J4WuAhI+/lPomajgj5SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEQ8C4SaRc9d7Bn1PmHUmKWUaHfgRfRQu0Tm29lUl+tsCgNYr282TuWdu8g6BPEF7ghHposL0nimJH3sRrReCMM/EDIdG1dZte9q4lyJB+ArdifrBNumNT2o4fVJ6piMKModxyG+Hqf8mPUTjuTAH2T+oIGt4+h9WrR1CLRWYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id EC6F1474A6434; Fri, 24 Apr 2026 10:14:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 02/18] bpf: Add precision marking and backtracking for stack argument slots
Date: Fri, 24 Apr 2026 10:14:43 -0700
Message-ID: <20260424171443.2034958-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260424171433.2034470-1-yonghong.song@linux.dev>
References: <20260424171433.2034470-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Extend the precision marking and backtracking infrastructure to
support stack argument slots (r11-based accesses). Without this,
precision demands for scalar values passed through stack arguments
are silently dropped, which could allow the verifier to incorrectly
prune states with different constant values in stack arg slots.

INSN_F_STACK_ARG_ACCESS is encoded as INSN_F_STACK_ACCESS |
INSN_F_DST_REG_STACK (BIT(9) | BIT(10)). This is safe because
INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns while
INSN_F_DST_REG_STACK is only used for JMP insns =E2=80=94 they never appe=
ar
on the same instruction. This keeps the total within the 12-bit
jmp_history flags budget.

Three components are added:

1. Jump history recording for stack arg accesses:
   - check_stack_arg_write() records INSN_F_STACK_ARG_ACCESS for
     outgoing stores.
   - check_stack_arg_read() records INSN_F_STACK_ARG_ACCESS for
     incoming loads.

2. backtrack_insn() handling:
   - BPF_LDX: when backtracking through an incoming stack arg load,
     transfer precision demand from the destination register to the
     stack arg slot mask.
   - BPF_STX/BPF_ST: when backtracking through an outgoing stack arg
     store, transfer precision demand from the stack arg slot to the
     source register.
   - Call boundary: when exiting a callee back to the caller,
     propagate the callee's incoming stack arg precision bits to the
     caller's outgoing stack arg slots. The slot index maps directly
     (slot i in callee corresponds to slot i in caller) since the
     caller's stack_arg_regs only contains outgoing slots.

3. bpf_mark_chain_precision() state walking:
   - When iterating parent states, mark stack_arg_regs[spi].precise
     for slots that have pending precision demand.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 13 ++++++++
 kernel/bpf/backtrack.c       | 61 ++++++++++++++++++++++++++++++++++--
 kernel/bpf/verifier.c        | 30 +++++++++++++++---
 3 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2cc349d7fc17..735f33ad3db7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -393,6 +393,13 @@ enum {
 	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
=20
 	INSN_F_STACK_ACCESS =3D BIT(9),
+	/*
+	 * INSN_F_STACK_ARG_ACCESS uses INSN_F_STACK_ACCESS | INSN_F_DST_REG_ST=
ACK.
+	 * This is safe because INSN_F_DST_REG_STACK is only used for JMP insns
+	 * while INSN_F_STACK_ACCESS is only used for ST/STX/LDX insns =E2=80=94=
 they
+	 * never appear on the same instruction.
+	 */
+	INSN_F_STACK_ARG_ACCESS =3D BIT(9) | BIT(10),
=20
 	INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
 	INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
@@ -775,6 +782,7 @@ struct backtrack_state {
 	u32 frame;
 	u32 reg_masks[MAX_CALL_FRAMES];
 	u64 stack_masks[MAX_CALL_FRAMES];
+	u8 stack_arg_masks[MAX_CALL_FRAMES];
 };
=20
 struct bpf_id_pair {
@@ -1173,6 +1181,11 @@ static inline void bpf_bt_set_frame_slot(struct ba=
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
index 854731dc93fe..73da7eaac47f 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -135,11 +135,21 @@ static inline u32 bt_empty(struct backtrack_state *=
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
@@ -200,6 +210,11 @@ static inline u64 bt_stack_mask(struct backtrack_sta=
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
@@ -341,6 +356,13 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			return 0;
 		bt_clear_reg(bt, load_reg);
=20
+		if (hist && (hist->flags & INSN_F_STACK_ARG_ACCESS) =3D=3D INSN_F_STAC=
K_ARG_ACCESS) {
+			spi =3D insn_stack_access_spi(hist->flags);
+			fr =3D insn_stack_access_frameno(hist->flags);
+			bt_set_frame_stack_arg_slot(bt, fr, spi);
+			return 0;
+		}
+
 		/* scalars can only be spilled into stack w/o losing precision.
 		 * Load from any other memory can be zero extended.
 		 * The desire to keep that precision is already indicated
@@ -363,6 +385,18 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 			 * encountered a case of pointer subtraction.
 			 */
 			return -ENOTSUPP;
+
+		if (hist && (hist->flags & INSN_F_STACK_ARG_ACCESS) =3D=3D INSN_F_STAC=
K_ARG_ACCESS) {
+			spi =3D insn_stack_access_spi(hist->flags);
+			fr =3D insn_stack_access_frameno(hist->flags);
+			if (!bt_is_frame_stack_arg_slot_set(bt, fr, spi))
+				return 0;
+			bt_clear_frame_stack_arg_slot(bt, fr, spi);
+			if (class =3D=3D BPF_STX)
+				bt_set_reg(bt, sreg);
+			return 0;
+		}
+
 		/* scalars can only be spilled into stack */
 		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
@@ -431,6 +465,17 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 						bpf_bt_set_frame_reg(bt, bt->frame - 1, i);
 					}
 				}
+				/* propagate callee's incoming stack arg precision
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
@@ -453,9 +498,10 @@ static int backtrack_insn(struct bpf_verifier_env *e=
nv, int idx, int subseq_idx,
 					     bt_stack_mask(bt));
 				return -EFAULT;
 			}
-			/* clear r1-r5 in callback subprog's mask */
+			/* clear r1-r5 and stack arg slots in callback subprog's mask */
 			for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++)
 				bt_clear_reg(bt, i);
+			bt->stack_arg_masks[bt->frame] =3D 0;
 			if (bt_subprog_exit(bt))
 				return -EFAULT;
 			return 0;
@@ -901,6 +947,17 @@ int bpf_mark_chain_precision(struct bpf_verifier_env=
 *env,
 					*changed =3D true;
 				}
 			}
+			for (i =3D 0; i < func->out_stack_arg_depth / BPF_REG_SIZE; i++) {
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
index bcf81692a22b..e041c182c614 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3563,6 +3563,11 @@ static int insn_stack_access_flags(int frameno, in=
t spi)
 	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
 }
=20
+static int insn_stack_arg_access_flags(int frameno, int spi)
+{
+	return INSN_F_STACK_ARG_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
+}
+
 static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].indirect_target =3D true;
@@ -4484,7 +4489,8 @@ static int check_stack_arg_write(struct bpf_verifie=
r_env *env, struct bpf_func_s
 		__mark_reg_known(arg, env->prog->insnsi[env->insn_idx].imm);
 	}
 	state->no_stack_arg_load =3D true;
-	return 0;
+	return bpf_push_jmp_history(env, env->cur_state,
+				    insn_stack_arg_access_flags(state->frameno, spi), 0);
 }
=20
 /*
@@ -4519,7 +4525,17 @@ static int check_stack_arg_read(struct bpf_verifie=
r_env *env, struct bpf_func_st
 		copy_register_state(&cur->regs[dst_regno], arg);
 	else
 		mark_reg_unknown(env, cur->regs, dst_regno);
-	return 0;
+	return bpf_push_jmp_history(env, env->cur_state,
+				    insn_stack_arg_access_flags(state->frameno, spi), 0);
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
@@ -7269,8 +7285,14 @@ static int check_mem_size_reg(struct bpf_verifier_=
env *env,
 	}
 	err =3D check_helper_mem_access(env, mem_reg, mem_argno, size_reg->umax=
_value,
 				      access_type, zero_size_allowed, meta);
-	if (!err)
-		err =3D mark_chain_precision(env, reg_from_argno(size_argno));
+	if (!err) {
+		int regno =3D reg_from_argno(size_argno);
+
+		if (regno >=3D 0)
+			err =3D mark_chain_precision(env, regno);
+		else
+			err =3D mark_stack_arg_precision(env, arg_from_argno(size_argno) - 1)=
;
+	}
 	return err;
 }
=20
--=20
2.52.0

