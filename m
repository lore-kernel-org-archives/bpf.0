Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9D23905EA
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789242775; cv=none; b=K5zUSAYbcmGyOb981pMr5jE5NMzcK68BiXr8cMlhFXHc49rc9bdN8VhaDqXHJa1/lNw3EOEESQC3gCvuTMoFK6F5v2s6ZMy5AMAzg4WUvMxCrPgXQR/YQ4UceqyEpuo1RMeMYgTbDxDpiNnX+uu4FljV/LgXBySZ3nHCLH4hpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789242775; c=relaxed/simple;
	bh=Wx6hH3JvV7BSM9YcpwaZyr5uQ9DrVVosFsKBGqiScec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpJI31sbLfsZdVnRny9fsHwRVN0z43upbFuABEv2gmGKF1McEPg3MCjxKzN9cYYUxtF5yifGIT2kmBW1LUtKWEn4Tou7KuTQ/WCn/eQ+6eKwP5IEGwDc5i9GVsm5EoC9Gkd8RrQXVir74CkXcQr2hKbtbBa13qLB9x/rL70SDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 892482A58A0DA2; Sat, 12 Sep 2026 12:52:47 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 10/15] bpf, x86: Move kfunc arguments into the x86-64 calling convention
Date: Sat, 12 Sep 2026 12:52:47 -0700
Message-ID: <20260912195247.989857-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
References: <20260912195156.980886-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The x86-64 allows 6 register arguments and then stack arguments, but
backfilling the 6th register is possible, as in the following example:

	/* s is a 16-byte struct */
	void kfunc(u64 a, u64 b, u64 c, u64 d, u64 e, struct big s, u64 f)

BPF puts s in slots 5 and 6, R9 and the first stack slot, and f in slot
7, while x86-64 puts s in the two stack slots and f in R9. Emit the
moves bpf_jit_plan_arg_moves() plans to bridge the two.

Only one argument ever moves down, as an argument frees one register at
most, so carrying that single value in the scratch register past its own
destination is enough.

In addition, the arena argument walk counts eightbytes rather than
parameters, as an argument may take two registers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 78 +++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bba351944202..2671e4118d00 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1839,6 +1839,65 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8=
 *ip,
 	return 0;
 }
=20
+static const struct bpf_jit_arg_abi x86_arg_abi =3D {
+	.nr_arg_regs		=3D 6,
+	.backfill_after_stack	=3D true,
+	.even_stack_align	=3D true,
+};
+
+static const u8 x86_arg_reg[] =3D {
+	BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5, X86_REG_R9,
+};
+
+/*
+ * Move the arguments the x86-64 ABI places somewhere other than the arg=
ument
+ * slot the BPF calling convention gave them. @stack_base addresses the
+ * outgoing stack argument area from RBP. Return the number of emitted b=
ytes.
+ */
+static int emit_kfunc_arg_moves(const struct btf_func_model *fm, s32 sta=
ck_base, u8 **pprog)
+{
+	struct bpf_jit_arg_move moves[BPF_JIT_MAX_ARG_MOVES];
+	const u8 nreg =3D x86_arg_abi.nr_arg_regs;
+	u8 *prog =3D *pprog, *start =3D prog;
+	u32 i, n;
+
+	n =3D bpf_jit_plan_arg_moves(&x86_arg_abi, fm, moves);
+
+	for (i =3D 0; i < n; i++) {
+		u8 dst =3D moves[i].dst, src =3D moves[i].src, reg;
+		bool dst_mem =3D dst !=3D BPF_JIT_ARG_TMP && dst >=3D nreg;
+		bool src_mem =3D src !=3D BPF_JIT_ARG_TMP && src >=3D nreg;
+
+		/*
+		 * Take the value into a register: the one it belongs in, the
+		 * scratch when it is carried past its own destination, and
+		 * BPF_REG_AX only to pass one stack slot to another.
+		 */
+		if (src =3D=3D BPF_JIT_ARG_TMP) {
+			reg =3D AUX_REG;
+		} else if (src_mem) {
+			reg =3D dst =3D=3D BPF_JIT_ARG_TMP ? AUX_REG :
+			      dst_mem ? BPF_REG_AX : x86_arg_reg[dst];
+			emit_ldx(&prog, BPF_DW, reg, BPF_REG_FP,
+				 stack_base + (src - nreg) * 8);
+		} else {
+			reg =3D x86_arg_reg[src];
+		}
+
+		/* And leave it where the argument belongs. */
+		if (dst =3D=3D BPF_JIT_ARG_TMP)
+			emit_mov_reg(&prog, true, AUX_REG, reg);
+		else if (dst_mem)
+			emit_stx(&prog, BPF_DW, BPF_REG_FP, reg,
+				 stack_base + (dst - nreg) * 8);
+		else if (reg !=3D x86_arg_reg[dst])
+			emit_mov_reg(&prog, true, x86_arg_reg[dst], reg);
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
@@ -1850,11 +1909,17 @@ static int emit_kfunc_arena_args(struct bpf_prog =
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
+		if (slot + arg_regs > MAX_BPF_FUNC_REG_ARGS)
+			break;
+		reg =3D BPF_REG_1 + slot;
+		slot +=3D arg_regs;
=20
 		if (!(flags & BTF_FMODEL_ARENA_ARG))
 			continue;
@@ -2837,6 +2902,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip +=3D err;
+				ip +=3D emit_kfunc_arg_moves(fm, outgoing_arg_base -
+							   outgoing_rsp, &prog);
 			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
@@ -4351,6 +4418,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
 	return true;
 }
=20
+const struct bpf_jit_arg_abi *bpf_jit_arg_abi(void)
+{
+	return &x86_arg_abi;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
--=20
2.53.0-Meta

