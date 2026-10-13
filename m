Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A6384242
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791851730; cv=none; b=XQTio8kWMRy/uPH5nJheqslf6REeWk7F8lVLp9uSsnP369RZq+JQ3qulBWXwMP2sSrHV6d+u05OnL3uwdJ+ngqjC3AE9YOt9eZrb1me36L5luBglD9ZHs4S+jOFkF2D+k22MWHc4uhvbXtgSVt1WvTSfGj26FC1KEWivlMzFJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791851730; c=relaxed/simple;
	bh=ZmvkXdyIVPmC/I+Pl8RboACKSOivKy9braxgltSeAnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYRjFIiEHSRXRB8eflYrp28NEjngMRq7/kxQrxe2wP1m4LcHnye9HDiWgx+0Y3sbFfqRRjWQjZ4FVc5RWFQyaypiSx++PdcCQVuKTFgLeXbGhRi+WTi+dgCBcNGvhLQs/E/ufkofOeyQ/KKDmn7N7ns2igaSO39SXdhuMr6wXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7AC1330D78EDA0; Mon, 12 Oct 2026 17:35:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 10/11] bpf, x86: Pass a kfunc's 16-byte aligned stack argument 16-byte aligned
Date: Mon, 12 Oct 2026 17:35:20 -0700
Message-ID: <20261013003520.1860874-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013003429.1853052-1-yonghong.song@linux.dev>
References: <20261013003429.1853052-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An argument aligned to 16 bytes, an __int128 or a struct holding one,
goes in a 16-byte aligned stack slot in the x86-64 calling convention.
The kernel keeps its stack only 8-byte aligned, being built with
-mpreferred-stack-boundary=3D3, yet a caller still realigns RSP before it
passes such an argument on the stack, and the callee can take the
alignment for granted. For

	u64 f(u64 a, u64 b, u64 c, u64 d, u64 e, u64 f, __int128 g)

both GCC and clang fold ((unsigned long)&g & 15) =3D=3D 0 to true, and GC=
C
passes &g on as an aligned __int128 pointer without copying g.

The JIT places a kfunc's stack arguments at the offsets from RSP that
the convention gives them, holes included, but RSP itself is only 8-byte
aligned in a BPF program, so a kfunc can get such an argument at an
address that is not 16-byte aligned.

When a kfunc call passes an argument aligned to 16 bytes on the stack,
test RSP before the call, and if it is off by 8, copy the stack argument
slots to the first 16-byte aligned place below them. A push of each slot
does that in four bytes: it takes the address of its operand before it
moves RSP, so one push instruction, repeated, copies the slots from the
top down. After the call, put RSP back from RBP. The arm64 JIT keeps SP
16-byte aligned, so only x86-64 needs this.

bpf_jit_stack_slots_to_align(), next to bpf_jit_place_args(), returns
how many stack slots a call has to realign, from where its arguments
are placed. The x86-64 JIT now places a kfunc's arguments once, for it
and for bpf_jit_plan_slot_moves(), the half of bpf_jit_plan_arg_moves()
that plans the moves from a given placement. bpf_jit_plan_arg_moves()
keeps placing the arguments itself, for arm64.

Fixes: a3195057406f ("bpf, x86: Move kfunc arguments into the x86-64 call=
ing convention")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 65 ++++++++++++++++++++++++++++++++++---
 include/linux/filter.h      |  5 +++
 kernel/bpf/core.c           | 50 +++++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 13 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 9bf29dc39498..ad1e1187154f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1918,17 +1918,19 @@ static s32 x86_arg_stack_off(u8 pos)
=20
 /*
  * Move the arguments the x86-64 ABI places somewhere other than the arg=
ument
- * slot the BPF calling convention gave them. @stack_base addresses the
+ * slot the BPF calling convention gave them, @pos_of_slot being where
+ * bpf_jit_place_args() put each of the @nslots slots. @stack_base addre=
sses the
  * outgoing stack argument area from RBP. Return the number of emitted b=
ytes.
  */
-static int emit_kfunc_arg_moves(const struct btf_func_model *fm, s32 sta=
ck_base, u8 **pprog)
+static int emit_kfunc_arg_moves(const u8 *pos_of_slot, u32 nslots, s32 s=
tack_base,
+				u8 **pprog)
 {
 	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
 	const u8 nreg =3D x86_arg_abi.nr_arg_regs;
 	u8 *prog =3D *pprog, *start =3D prog;
 	u32 i, n;
=20
-	n =3D bpf_jit_plan_arg_moves(&x86_arg_abi, fm, moves);
+	n =3D bpf_jit_plan_slot_moves(pos_of_slot, nslots, moves);
=20
 	for (i =3D 0; i < n; i++) {
 		u8 dst =3D moves[i].dst, src =3D moves[i].src, reg;
@@ -1965,6 +1967,36 @@ static int emit_kfunc_arg_moves(const struct btf_f=
unc_model *fm, s32 stack_base,
 	return prog - start;
 }
=20
+/*
+ * When RSP is not 16-byte aligned, copy the @n on-stack argument slots =
at RSP
+ * to the first 16-byte aligned place below them. A push takes the addre=
ss of
+ * its memory operand before it moves RSP, so the same push copies each =
slot in
+ * turn, from the top down. The caller puts RSP back after the call. Ret=
urn the
+ * number of emitted bytes.
+ */
+static int emit_kfunc_align_stack_args(u32 n, u8 **pprog)
+{
+	u8 *prog =3D *pprog, *start =3D prog, *skip;
+	/* a kfunc takes MAX_BPF_FUNC_ARGS slots at most: disp fits in a disp8 =
*/
+	u8 disp =3D (n - 1) * 8;
+	u32 i;
+
+	EMIT4(0x40, 0xF6, 0xC4, 0x08);		/* test spl, 8 */
+	EMIT2(X86_JE, 0);			/* je over the copy */
+	skip =3D prog;
+	if (!(n & 1)) {
+		/* an even number of slots keeps RSP's alignment */
+		EMIT4(0x48, 0x83, 0xEC, 8);	/* sub rsp, 8 */
+		disp +=3D 8;
+	}
+	for (i =3D 0; i < n; i++)
+		EMIT4(0xFF, 0x74, 0x24, disp);	/* push qword ptr [rsp + disp] */
+	skip[-1] =3D prog - skip;
+
+	*pprog =3D prog;
+	return prog - start;
+}
+
 /*
  * Rebase the __arena args of a kfunc call to arena kernel addresses,
  * rN =3D kern_vm_start + (u32)rN, with R12 holding kern_vm_start. A nul=
lable
@@ -2953,6 +2985,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 			/* call */
 		case BPF_JMP | BPF_CALL: {
 			const struct btf_func_model *fm =3D NULL;
+			u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
+			u32 nslots, align_slots =3D 0;
=20
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
@@ -2969,8 +3003,20 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip +=3D err;
-				ip +=3D emit_kfunc_arg_moves(fm, outgoing_arg_base -
-							   outgoing_rsp, &prog);
+				nslots =3D bpf_jit_place_args(&x86_arg_abi, fm, pos_of_slot);
+				ip +=3D emit_kfunc_arg_moves(pos_of_slot, nslots,
+							   outgoing_arg_base - outgoing_rsp,
+							   &prog);
+				/*
+				 * The kernel keeps the stack only 8-byte aligned,
+				 * but a caller realigns RSP to pass an argument
+				 * aligned to 16 bytes on the stack, and the callee
+				 * may rely on its slot's alignment.
+				 */
+				align_slots =3D bpf_jit_stack_slots_to_align(&x86_arg_abi, fm,
+									   pos_of_slot);
+				if (align_slots)
+					ip +=3D emit_kfunc_align_stack_args(align_slots, &prog);
 			}
 			if (func =3D=3D (u8 *)arch_bpf_timed_may_goto) {
 				u32 fp =3D priv_frame_ptr ? X86_REG_R9 : BPF_REG_FP;
@@ -2993,6 +3039,15 @@ static int do_jit(struct bpf_verifier_env *env, st=
ruct bpf_prog *bpf_prog, int *
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (align_slots) {
+				s32 off =3D outgoing_arg_base - outgoing_rsp;
+
+				/* lea rsp, [rbp + off], wherever the copy left it */
+				if (is_imm8(off))
+					EMIT4(0x48, 0x8D, 0x65, (u8)off);
+				else
+					EMIT3_off32(0x48, 0x8D, 0xA5, off);
+			}
 			/*
 			 * A kfunc returning more than 8 bytes hands the second
 			 * half back in RDX (the native ABI's second return reg),
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..55875f3a1510 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1285,9 +1285,14 @@ struct bpf_jit_arg_move {
 	u8 src;
 };
=20
+u32 bpf_jit_plan_slot_moves(const u8 *pos_of_slot, u32 nslots,
+			    struct bpf_jit_arg_move *moves);
 u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
 			   const struct btf_func_model *fm,
 			   struct bpf_jit_arg_move *moves);
+u32 bpf_jit_stack_slots_to_align(const struct bpf_jit_arg_abi *abi,
+				 const struct btf_func_model *fm,
+				 const u8 *pos_of_slot);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
 u64 arch_bpf_timed_may_goto(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 05c89396119a..3d6d504cdb5f 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3379,15 +3379,10 @@ u32 bpf_jit_place_args(const struct bpf_jit_arg_a=
bi *abi,
 	return slot;
 }
=20
-u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
-			   const struct btf_func_model *fm,
-			   struct bpf_jit_arg_move *moves)
+u32 bpf_jit_plan_slot_moves(const u8 *pos_of_slot, u32 nslots,
+			    struct bpf_jit_arg_move *moves)
 {
-	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
-	u32 nslots, n =3D 0, s, back;
-
-	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);
-	back =3D nslots;
+	u32 n =3D 0, s, back =3D nslots;
=20
 	/*
 	 * An argument is two eightbytes at most, so it frees one register at
@@ -3420,6 +3415,45 @@ u32 bpf_jit_plan_arg_moves(const struct bpf_jit_ar=
g_abi *abi,
 	return n;
 }
=20
+u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg_abi *abi,
+			   const struct btf_func_model *fm,
+			   struct bpf_jit_arg_move *moves)
+{
+	u8 pos_of_slot[MAX_BPF_FUNC_ARG_SLOTS];
+	u32 nslots;
+
+	nslots =3D bpf_jit_place_args(abi, fm, pos_of_slot);
+	return bpf_jit_plan_slot_moves(pos_of_slot, nslots, moves);
+}
+
+/*
+ * Return how many stack slots a call passes when one of its stack argum=
ents is
+ * aligned to 16 bytes, or 0 otherwise. @pos_of_slot is where
+ * bpf_jit_place_args() put each argument slot. Such an argument goes in=
 a
+ * 16-byte aligned stack slot, so a JIT whose stack is only 8-byte align=
ed has
+ * to realign that many slots before the call.
+ */
+u32 bpf_jit_stack_slots_to_align(const struct bpf_jit_arg_abi *abi,
+				 const struct btf_func_model *fm,
+				 const u8 *pos_of_slot)
+{
+	u32 i, k, slot =3D 0, top =3D 0;
+	bool align16 =3D false;
+
+	for (i =3D 0; i < fm->nr_args; i++) {
+		u32 nslots =3D btf_func_model_arg_slots(fm, i);
+
+		if ((fm->arg_flags[i] & BTF_FMODEL_ALIGN16_ARG) &&
+		    pos_of_slot[slot] >=3D abi->nr_arg_regs)
+			align16 =3D true;
+		for (k =3D 0; k < nslots; k++, slot++)
+			if (pos_of_slot[slot] >=3D abi->nr_arg_regs)
+				top =3D max_t(u32, top, pos_of_slot[slot] - abi->nr_arg_regs + 1);
+	}
+
+	return align16 ? top : 0;
+}
+
 bool __weak bpf_jit_supports_stack_args(void)
 {
 	return false;
--=20
2.53.0-Meta

