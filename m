Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD93750D5
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477617; cv=none; b=JILGl67FTs+IRUSnzFRj+dC91jk6mG0W5XxSibb1au7Pcn/JteuKaa28XdKpUg7CT0jDeJBQEXVpUEadB4ShbsjNSrb3X+lbib+7dC3mads/C1g2GJwOLnJSGw/+4+hIZS8CNvbCLR+UrqjzprOwT7LkFSZ6484An3ap1+SUZ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477617; c=relaxed/simple;
	bh=q3yyc+19TiJ3S0GX+QxO5VE6wg3P8k9J1fdMP4Et7UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqhNO46/LBdYlxOTgfl+OVYtuuQm/bkT9V01QQH8pKittmjnJk1GF8FjrBMIs/0b2Cst3xUdflDRJXDPxQw1/KEJNzCvjJOOUXZvHpb9yR7KJ0QmHDzESK6niYeKIDAIYazwncmtE9bSJpdhzD2te+Z4k4lgYRiyL2fa63ubW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id B881DA59DB7EC; Sun, 10 May 2026 22:33:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 06/24] bpf: Refactor jmp history to use dedicated spi/frame fields
Date: Sun, 10 May 2026 22:33:32 -0700
Message-ID: <20260511053332.1884123-1-yonghong.song@linux.dev>
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

Move stack slot index (spi) and frame number out of the flags field
in bpf_jmp_history_entry into dedicated bitfields. This simplifies
the encoding and makes room for new flags.

Previously, spi and frame were packed into the lower 9 bits of the
12-bit flags field (3 bits frame + 6 bits spi), with INSN_F_STACK_ACCESS
at BIT(9) and INSN_F_DST/SRC_REG_STACK at BIT(10)/BIT(11).
But this has no room for an INSN_F_* flag for stack arguments.

To resolve this issue, bpf_jmp_history_entry field idx is narrowed to
20 bits (sufficient for insn indices up to 1M), and the freed bits hold
spi (6 bits) and frame (3 bits) as dedicated struct fields. The flags
enum is simplified accordingly:
  INSN_F_STACK_ACCESS  -> BIT(0)
  INSN_F_DST_REG_STACK -> BIT(1)
  INSN_F_SRC_REG_STACK -> BIT(2)
which allows more room for additional INSN_F_* flags.

bpf_push_jmp_history() now takes explicit spi and frame parameters
instead of encoding them into flags. The insn_stack_access_flags(),
insn_stack_access_spi(), and insn_stack_access_frameno() helpers are
removed.

No functional change.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 34 ++++++++++++++--------------------
 kernel/bpf/backtrack.c       | 24 +++++++++---------------
 kernel/bpf/states.c          |  2 +-
 kernel/bpf/verifier.c        | 23 +++++++++++------------
 4 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f9020a4ea005..adf00585a627 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -435,31 +435,22 @@ struct bpf_func_state {
=20
 #define MAX_CALL_FRAMES 8
=20
-/* instruction history flags, used in bpf_jmp_history_entry.flags field =
*/
+/* instruction history flags, used in bpf_jmp_history_entry.flags field.
+ * Frame number and SPI are stored in dedicated fields of bpf_jmp_histor=
y_entry.
+ */
 enum {
-	/* instruction references stack slot through PTR_TO_STACK register;
-	 * we also store stack's frame number in lower 3 bits (MAX_CALL_FRAMES =
is 8)
-	 * and accessed stack slot's index in next 6 bits (MAX_BPF_STACK is 512=
,
-	 * 8 bytes per slot, so slot index (spi) is [0, 63])
-	 */
-	INSN_F_FRAMENO_MASK =3D 0x7, /* 3 bits */
-
-	INSN_F_SPI_MASK =3D 0x3f, /* 6 bits */
-	INSN_F_SPI_SHIFT =3D 3, /* shifted 3 bits to the left */
+	INSN_F_STACK_ACCESS =3D BIT(0),
=20
-	INSN_F_STACK_ACCESS =3D BIT(9),
-
-	INSN_F_DST_REG_STACK =3D BIT(10), /* dst_reg is PTR_TO_STACK */
-	INSN_F_SRC_REG_STACK =3D BIT(11), /* src_reg is PTR_TO_STACK */
-	/* total 12 bits are used now. */
+	INSN_F_DST_REG_STACK =3D BIT(1), /* dst_reg is PTR_TO_STACK */
+	INSN_F_SRC_REG_STACK =3D BIT(2), /* src_reg is PTR_TO_STACK */
 };
=20
-static_assert(INSN_F_FRAMENO_MASK + 1 >=3D MAX_CALL_FRAMES);
-static_assert(INSN_F_SPI_MASK + 1 >=3D MAX_BPF_STACK / 8);
-
 struct bpf_jmp_history_entry {
-	u32 idx;
 	/* insn idx can't be bigger than 1 million */
+	u32 idx : 20;
+	u32 frame : 3;	/* stack access frame number */
+	u32 spi : 6;	/* stack slot index (0..63) */
+	u32 : 3;
 	u32 prev_idx : 20;
 	/* special INSN_F_xxx flags */
 	u32 flags : 12;
@@ -469,6 +460,9 @@ struct bpf_jmp_history_entry {
 	u64 linked_regs;
 };
=20
+static_assert(MAX_CALL_FRAMES <=3D (1 << 3));
+static_assert(MAX_BPF_STACK / 8 <=3D (1 << 6));
+
 /* Maximum number of register states that can exist at once */
 #define BPF_ID_MAP_SIZE ((MAX_BPF_REG + MAX_BPF_STACK / BPF_REG_SIZE) * =
MAX_CALL_FRAMES)
 struct bpf_verifier_state {
@@ -1180,7 +1174,7 @@ struct list_head *bpf_explored_state(struct bpf_ver=
ifier_env *env, int idx);
 void bpf_free_verifier_state(struct bpf_verifier_state *state, bool free=
_self);
 void bpf_free_backedges(struct bpf_scc_visit *visit);
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifi=
er_state *cur,
-			 int insn_flags, u64 linked_regs);
+			 int insn_flags, int spi, int frame, u64 linked_regs);
 void bpf_bt_sync_linked_regs(struct backtrack_state *bt, struct bpf_jmp_=
history_entry *hist);
 void bpf_mark_reg_not_init(const struct bpf_verifier_env *env,
 			   struct bpf_reg_state *reg);
diff --git a/kernel/bpf/backtrack.c b/kernel/bpf/backtrack.c
index 854731dc93fe..5e93e57fb7ae 100644
--- a/kernel/bpf/backtrack.c
+++ b/kernel/bpf/backtrack.c
@@ -9,7 +9,7 @@
=20
 /* for any branch, call, exit record the history of jmps in the given st=
ate */
 int bpf_push_jmp_history(struct bpf_verifier_env *env, struct bpf_verifi=
er_state *cur,
-			 int insn_flags, u64 linked_regs)
+			 int insn_flags, int spi, int frame, u64 linked_regs)
 {
 	u32 cnt =3D cur->jmp_history_cnt;
 	struct bpf_jmp_history_entry *p;
@@ -25,6 +25,8 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, =
struct bpf_verifier_state
 				env, "insn history: insn_idx %d cur flags %x new flags %x",
 				env->insn_idx, env->cur_hist_ent->flags, insn_flags);
 		env->cur_hist_ent->flags |=3D insn_flags;
+		env->cur_hist_ent->spi =3D spi;
+		env->cur_hist_ent->frame =3D frame;
 		verifier_bug_if(env->cur_hist_ent->linked_regs !=3D 0, env,
 				"insn history: insn_idx %d linked_regs: %#llx",
 				env->insn_idx, env->cur_hist_ent->linked_regs);
@@ -43,6 +45,8 @@ int bpf_push_jmp_history(struct bpf_verifier_env *env, =
struct bpf_verifier_state
 	p->idx =3D env->insn_idx;
 	p->prev_idx =3D env->prev_insn_idx;
 	p->flags =3D insn_flags;
+	p->spi =3D spi;
+	p->frame =3D frame;
 	p->linked_regs =3D linked_regs;
 	cur->jmp_history_cnt =3D cnt;
 	env->cur_hist_ent =3D p;
@@ -64,16 +68,6 @@ static bool is_atomic_fetch_insn(const struct bpf_insn=
 *insn)
 	       (insn->imm & BPF_FETCH);
 }
=20
-static int insn_stack_access_spi(int insn_flags)
-{
-	return (insn_flags >> INSN_F_SPI_SHIFT) & INSN_F_SPI_MASK;
-}
-
-static int insn_stack_access_frameno(int insn_flags)
-{
-	return insn_flags & INSN_F_FRAMENO_MASK;
-}
-
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
  * Return -ENOENT if we exhausted all instructions within given state.
@@ -353,8 +347,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 		 * that [fp - off] slot contains scalar that needs to be
 		 * tracked with precision
 		 */
-		spi =3D insn_stack_access_spi(hist->flags);
-		fr =3D insn_stack_access_frameno(hist->flags);
+		spi =3D hist->spi;
+		fr =3D hist->frame;
 		bpf_bt_set_frame_slot(bt, fr, spi);
 	} else if (class =3D=3D BPF_STX || class =3D=3D BPF_ST) {
 		if (bt_is_reg_set(bt, dreg))
@@ -366,8 +360,8 @@ static int backtrack_insn(struct bpf_verifier_env *en=
v, int idx, int subseq_idx,
 		/* scalars can only be spilled into stack */
 		if (!hist || !(hist->flags & INSN_F_STACK_ACCESS))
 			return 0;
-		spi =3D insn_stack_access_spi(hist->flags);
-		fr =3D insn_stack_access_frameno(hist->flags);
+		spi =3D hist->spi;
+		fr =3D hist->frame;
 		if (!bt_is_frame_slot_set(bt, fr, spi))
 			return 0;
 		bt_clear_frame_slot(bt, fr, spi);
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index c249eb40c6d6..45d86bfe3b68 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -1400,7 +1400,7 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
 			 */
 			err =3D 0;
 			if (bpf_is_jmp_point(env, env->insn_idx))
-				err =3D bpf_push_jmp_history(env, cur, 0, 0);
+				err =3D bpf_push_jmp_history(env, cur, 0, 0, 0, 0);
 			err =3D err ? : propagate_precision(env, &sl->state, cur, NULL);
 			if (err)
 				return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4ba7510bc87c..3e65dd0edbf9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3198,11 +3198,6 @@ static int check_reg_arg(struct bpf_verifier_env *=
env, u32 regno,
 	return __check_reg_arg(env, state->regs, regno, t);
 }
=20
-static int insn_stack_access_flags(int frameno, int spi)
-{
-	return INSN_F_STACK_ACCESS | (spi << INSN_F_SPI_SHIFT) | frameno;
-}
-
 static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 {
 	env->insn_aux_data[idx].indirect_target =3D true;
@@ -3517,7 +3512,8 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE, err;
 	struct bpf_insn *insn =3D &env->prog->insnsi[insn_idx];
 	struct bpf_reg_state *reg =3D NULL;
-	int insn_flags =3D insn_stack_access_flags(state->frameno, spi);
+	int insn_flags =3D INSN_F_STACK_ACCESS;
+	int hist_spi =3D spi, hist_frame =3D state->frameno;
=20
 	/* caller checked that off % size =3D=3D 0 and -MAX_BPF_STACK <=3D off =
< 0,
 	 * so it's aligned access and [off, off + size) are within stack limits
@@ -3613,7 +3609,8 @@ static int check_stack_write_fixed_off(struct bpf_v=
erifier_env *env,
 	}
=20
 	if (insn_flags)
-		return bpf_push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
+					    hist_spi, hist_frame, 0);
 	return 0;
 }
=20
@@ -3809,7 +3806,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 	int i, slot =3D -off - 1, spi =3D slot / BPF_REG_SIZE;
 	struct bpf_reg_state *reg;
 	u8 *stype, type;
-	int insn_flags =3D insn_stack_access_flags(reg_state->frameno, spi);
+	int insn_flags =3D INSN_F_STACK_ACCESS;
+	int hist_spi =3D spi, hist_frame =3D reg_state->frameno;
=20
 	stype =3D reg_state->stack[spi].slot_type;
 	reg =3D &reg_state->stack[spi].spilled_ptr;
@@ -3940,7 +3938,8 @@ static int check_stack_read_fixed_off(struct bpf_ve=
rifier_env *env,
 		insn_flags =3D 0; /* we are not restoring spilled register */
 	}
 	if (insn_flags)
-		return bpf_push_jmp_history(env, env->cur_state, insn_flags, 0);
+		return bpf_push_jmp_history(env, env->cur_state, insn_flags,
+					    hist_spi, hist_frame, 0);
 	return 0;
 }
=20
@@ -15903,7 +15902,7 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 	}
=20
 	if (insn_flags) {
-		err =3D bpf_push_jmp_history(env, this_branch, insn_flags, 0);
+		err =3D bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, 0);
 		if (err)
 			return err;
 	}
@@ -15967,7 +15966,7 @@ static int check_cond_jmp_op(struct bpf_verifier_=
env *env,
 	if (dst_reg->type =3D=3D SCALAR_VALUE && dst_reg->id)
 		collect_linked_regs(env, this_branch, dst_reg->id, &linked_regs);
 	if (linked_regs.cnt > 1) {
-		err =3D bpf_push_jmp_history(env, this_branch, 0, linked_regs_pack(&li=
nked_regs));
+		err =3D bpf_push_jmp_history(env, this_branch, 0, 0, 0, linked_regs_pa=
ck(&linked_regs));
 		if (err)
 			return err;
 	}
@@ -17273,7 +17272,7 @@ static int do_check(struct bpf_verifier_env *env)
 		}
=20
 		if (bpf_is_jmp_point(env, env->insn_idx)) {
-			err =3D bpf_push_jmp_history(env, state, 0, 0);
+			err =3D bpf_push_jmp_history(env, state, 0, 0, 0, 0);
 			if (err)
 				return err;
 		}
--=20
2.53.0-Meta

