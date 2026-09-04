Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB083B2FE4
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 05:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498647; cv=none; b=C1YtJLT6mufZLQ7PsExLxbNqUrO7Sl8CCZJF+dFs7ldOf6DdlleW1TMjDFJ8GyNpl3WPjSl8ISoXG4v1fI+gYNzIzF1Rg9T5c7EzadPVTKpVCFqMj++2qV1yCMZTYf0zg3crFFa05F19uKK2YjwCPrNRWcZITeC3dZfRhy/ywuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498647; c=relaxed/simple;
	bh=T3RVL1FmmhrWEtUC9zdeJ1nODk9HtF5Ky6LoKooKBSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0GIsFd5TOymSWxnRV2e/hhGmGqyHgRyeML33fYLd2QFCMre8kbqGixD6U6SBJvAQX233gSU2fh1x0SisxVQaHwlN7GK/hqr9BLbe0QoFL2MKi4rbbV3tQt9frZE6D4Ut+m/0Z1v4rl0L2Z+m/yTOlCuOCzfDkpyy8JXNgHMUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7E038288131780; Thu,  3 Sep 2026 22:10:33 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 07/12] bpf, x86: Place kfunc arguments per the SysV calling convention
Date: Thu,  3 Sep 2026 22:10:33 -0700
Message-ID: <20260904051033.3979978-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904050957.3976119-1-yonghong.song@linux.dev>
References: <20260904050957.3976119-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The JIT hands each eightbyte the BPF calling convention passes an
argument in to the argument position of the same number, registers first,
so the two conventions agree unless the kernel one places an argument
somewhere else. Compute where SysV wants each eightbyte, and move the
ones that differ before the call.

SysV disagrees over an argument that the registers left cannot hold: it
moves the whole of it to the stack and leaves the registers to the
arguments that follow, while the BPF convention splits it and keeps
filling slots in order. So for

  u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);

the BPF convention puts s in the last argument register and the first
stack slot, while SysV puts it wholly on the stack. Add an argument after
s and it takes the register s vacated, which makes the moves a cycle, so
one value at a time waits in RAX, dead before a call.

The outgoing argument area is sized for both conventions, as SysV can put
on the stack an argument the BPF slots kept in a register, and
bpf_jit_supports_kfunc_arg_slot() can now answer yes to any placement.

In addition, the arena argument walk counts eightbytes rather than
parameters, as an argument may take two registers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 185 +++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 48429fae0641..0b07320ad011 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1682,6 +1682,164 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u=
8 *ip,
 	return 0;
 }
=20
+/* The kernel ABI hands the first six eightbytes of arguments to registe=
rs. */
+static const u32 x86_arg_reg[6] =3D {
+	BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5, X86_REG_R9,
+};
+
+/* Fill argument positions based on the kernel calling convention. */
+static int kfunc_arg_layout(const struct btf_func_model *fm, u8 *pos, in=
t max)
+{
+	int i, k, nregs =3D 0, nstack =3D 0, slot =3D 0;
+
+	for (i =3D 0; i < fm->nr_args; i++) {
+		int n =3D (fm->arg_size[i] + 7) / 8;
+
+		if (slot + n > max)
+			return -EINVAL;
+		if (nregs + n <=3D 6)
+			for (k =3D 0; k < n; k++)
+				pos[slot++] =3D nregs++;
+		else
+			for (k =3D 0; k < n; k++)
+				pos[slot++] =3D 6 + nstack++;
+	}
+	return slot;
+}
+
+static u16 kfunc_arg_stack_bytes(const struct bpf_prog *prog)
+{
+	return bpf_jit_kfunc_stack_slots(prog, 6, kfunc_arg_layout) * 8;
+}
+
+static void emit_arg_pos_load(u8 **pprog, u32 reg, u8 pos, s32 stack_bas=
e)
+{
+	if (pos < 6)
+		emit_mov_reg(pprog, true, reg, x86_arg_reg[pos]);
+	else
+		emit_ldx(pprog, BPF_DW, reg, BPF_REG_FP,
+			 stack_base + (pos - 6) * 8);
+}
+
+static void emit_arg_pos_store(u8 **pprog, u8 pos, u32 reg, s32 stack_ba=
se)
+{
+	if (pos < 6)
+		emit_mov_reg(pprog, true, x86_arg_reg[pos], reg);
+	else
+		emit_stx(pprog, BPF_DW, BPF_REG_FP, reg,
+			 stack_base + (pos - 6) * 8);
+}
+
+static void emit_arg_pos_move(u8 **pprog, u8 to, u8 from, s32 stack_base=
)
+{
+	if (from < 6) {
+		emit_arg_pos_store(pprog, to, x86_arg_reg[from], stack_base);
+		return;
+	}
+	if (to < 6) {
+		emit_arg_pos_load(pprog, x86_arg_reg[to], from, stack_base);
+		return;
+	}
+	emit_arg_pos_load(pprog, AUX_REG, from, stack_base);
+	emit_arg_pos_store(pprog, to, AUX_REG, stack_base);
+}
+
+/*
+ * Put the arguments of a kfunc call where the kernel ABI expects them, =
given
+ * that the BPF ABI has already put them in its own slots. Returns the n=
umber
+ * of emitted bytes, or a negative error.
+ *
+ * This is the parallel move problem: emit every move whose destination =
no
+ * longer holds a value, then break each remaining cycle with one tempor=
ary.
+ * See Rideau, Serpette and Leroy, "Tilting at Windmills with Coq: Forma=
l
+ * Verification of a Compilation Algorithm for Parallel Moves", Journal =
of
+ * Automated Reasoning 45(2), 2010.
+ *
+ * For
+ *
+ *   u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s);
+ *
+ *     slot     0 1 2 3 4 5 6
+ *     position 0 1 2 3 4 6 7
+ *     final    0 1 2 3 4 ? 6 7
+ *
+ * the BPF ABI splits s between the last register and the stack while th=
e
+ * kernel one takes it wholly on the stack, so each of its eightbytes mo=
ves up
+ * one position, the last one first, and position 5 (R9) is left unused.
+ * Adding an argument after s,
+ *
+ *   u64 g(u64 a, u64 b, u64 c, u64 d, u64 e, struct pair s, u64 f);
+ *
+ *     slot     0 1 2 3 4 5 6 7
+ *     position 0 1 2 3 4 6 7 5
+ *     final    0 1 2 3 4 5 6 7
+ *
+ * gives f the register s vacated, and 5 -> 6 -> 7 -> 5 is a cycle: slot=
 5
+ * waits in PARK_REG while slots 7 and 6 move, and is stored last. AUX_R=
EG
+ * carries a value between two stack positions and cannot be the one tha=
t
+ * waits, while RAX is dead before a call, being where the return value
+ * arrives.
+ */
+#define PARK_REG BPF_REG_0
+
+static int emit_kfunc_args(const struct btf_func_model *fm, u8 **pprog,
+			   s32 stack_base)
+{
+	u8 *prog =3D *pprog, *start =3D prog;
+	bool done[MAX_BPF_FUNC_ARGS] =3D {};
+	u8 pos[MAX_BPF_FUNC_ARGS];
+	int i, j, n, todo =3D 0, parked =3D -1;
+
+	n =3D kfunc_arg_layout(fm, pos, ARRAY_SIZE(pos));
+	if (n < 0)
+		return 0;
+	for (i =3D 0; i < n; i++)
+		if (pos[i] !=3D i)
+			todo++;
+	if (!todo)
+		return 0;
+
+	while (todo) {
+		bool moved =3D false;
+
+		for (i =3D 0; i < n; i++) {
+			if (done[i] || pos[i] =3D=3D i)
+				continue;
+			/* Writing there would lose a value still to be moved. */
+			for (j =3D 0; j < n; j++)
+				if (!done[j] && j !=3D parked && pos[j] !=3D j && j =3D=3D pos[i])
+					break;
+			if (j < n)
+				continue;
+			if (i =3D=3D parked) {
+				emit_arg_pos_store(&prog, pos[i], PARK_REG, stack_base);
+				parked =3D -1;
+			} else {
+				emit_arg_pos_move(&prog, pos[i], i, stack_base);
+			}
+			done[i] =3D true;
+			todo--;
+			moved =3D true;
+		}
+		if (moved)
+			continue;
+
+		/* Every move left would clobber a value: break a cycle. */
+		if (parked >=3D 0)
+			return -EFAULT;
+		for (i =3D 0; i < n; i++)
+			if (!done[i] && pos[i] !=3D i)
+				break;
+		if (i =3D=3D n)
+			return -EFAULT;
+		emit_arg_pos_load(&prog, PARK_REG, i, stack_base);
+		parked =3D i;
+	}
+
+	*pprog =3D prog;
+	return prog - start;
+}
+
 /*
  * Rebase the __arena args of a kfunc call to arena kernel addresses,
  * rN =3D kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nul=
lable
@@ -1693,11 +1851,21 @@ static int emit_kfunc_arena_args(struct bpf_prog =
*bpf_prog,
 {
 	u8 *prog =3D *pprog;
 	u8 *start =3D prog;
-	int i;
+	int i, slot;
=20
-	for (i =3D 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) =
{
+	for (i =3D 0, slot =3D 0; i < fm->nr_args; i++) {
+		u32 arg_regs =3D (fm->arg_size[i] + 7) / 8;
 		u8 flags =3D fm->arg_flags[i];
-		u32 reg =3D BPF_REG_1 + i;
+		u32 reg;
+
+		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS) {
+			/* The verifier refuses an arena pointer past the registers. */
+			if (WARN_ON_ONCE(flags & BTF_FMODEL_ARENA_ARG))
+				return -EFAULT;
+			break;
+		}
+		reg =3D BPF_REG_1 + slot;
+		slot +=3D arg_regs;
=20
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
@@ -1832,6 +2000,7 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 	 * Arg 6 goes into r9 register, not on stack.
 	 */
 	outgoing_rsp =3D out_stack_arg_cnt > 1 ? (out_stack_arg_cnt - 1) * 8 : =
0;
+	outgoing_rsp =3D max(outgoing_rsp, kfunc_arg_stack_bytes(bpf_prog));
 	if (bpf_prog->aux->exception_boundary)
 		bpf_prog->aux->stack_arg_sp_adjust =3D outgoing_rsp;
 	emit_sub_rsp(&prog, outgoing_rsp);
@@ -2656,6 +2825,11 @@ st:			insn_off =3D insn->off;
 				if (err < 0)
 					return err;
 				ip +=3D err;
+				err =3D emit_kfunc_args(fm, &prog,
+						      outgoing_arg_base - outgoing_rsp);
+				if (err < 0)
+					return err;
+				ip +=3D err;
 			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
@@ -4169,6 +4343,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
=20
+bool bpf_jit_supports_kfunc_arg_slot(u32 slots_used, u32 nslots, u32 ali=
gn)
+{
+	return true;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
--=20
2.53.0-Meta

