Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1543A7597
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 06:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935170; cv=none; b=SPeRpMLTGpnlPHtyhBguH2hnXDN9Sng6FwlvBT5rvE7MD7Uxuac4dJeIry5dER4DVI0W3YLutDTUGa8HZYiHAHE+fYgHMj96Xl3NDjzVzm2GKAl8lv6ofENYUsBae+VS7PJFd5fLoyeVjxSIoz5mZEQ7Rxwr9SXdYorczfRHW3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935170; c=relaxed/simple;
	bh=Cxku0LX2QaQRhMeFywGV9vuIrF2BuZ0p6kqPuBDjvlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rGfN/RXMlhfx3QZYiuDIYSUAthkUD/7tdtDnrSTg48PYd1vJz7vSCLzf94WWnge39eKoQgdLmA5ul0TfTATKovqYW25VySbAxK9CdEX5w+9jIPM8pCwqiRgv/M1QDAQxUIYoLrBB3H95MqusV8HmMUVMd1yowjj1xZGIsHmGBVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BFA6A299486F85; Tue,  8 Sep 2026 23:26:04 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 08/12] bpf, x86: Move kfunc arguments into the x86-64 calling convention
Date: Tue,  8 Sep 2026 23:26:04 -0700
Message-ID: <20260909062604.4008177-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909062522.4001896-1-yonghong.song@linux.dev>
References: <20260909062522.4001896-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Do proper move from bpf calling convention to x86_64 calling convention
to satisfy native requirement.

In addition, the arena argument walk counts eightbytes rather than
parameters, as an argument may take two registers.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 73 +++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index bba351944202..0496607a7003 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1839,6 +1839,60 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u8=
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
+		/* Take the value into a register. */
+		if (src =3D=3D BPF_JIT_ARG_TMP) {
+			reg =3D AUX_REG;
+		} else if (src_mem) {
+			reg =3D dst_mem || dst =3D=3D BPF_JIT_ARG_TMP ? BPF_REG_AX : x86_arg_=
reg[dst];
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
@@ -1850,11 +1904,17 @@ static int emit_kfunc_arena_args(struct bpf_prog =
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
@@ -2837,6 +2897,8 @@ static int do_jit(struct bpf_verifier_env *env, str=
uct bpf_prog *bpf_prog, int *
 				if (err < 0)
 					return err;
 				ip +=3D err;
+				ip +=3D emit_kfunc_arg_moves(fm, outgoing_arg_base -
+							   outgoing_rsp, &prog);
 			}
 			if (priv_frame_ptr) {
 				push_r9(&prog);
@@ -4351,6 +4413,11 @@ bool bpf_jit_supports_kfunc_ret_reg_pair(void)
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

