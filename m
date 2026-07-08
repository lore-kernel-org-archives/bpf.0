Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14A2D97A6
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541398; cv=none; b=gsFtk5FDnH2dW5NNjwCZx8wjtxyOFoEc/FiMgwH0FTHafhgf/fvyiqNkyAvQxSY2NVIlfA7z4qpr3HEwMXSsh7I/mg4m8Sy0GZbNo5RW2H2LjU+/8oWi/JWdyp83DwlAblh8p3/rYxp0qzStUggSvzklMUfcTzG91Vqd+3iJ91M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541398; c=relaxed/simple;
	bh=9sWl0RNKAUmppV/GW8f7Ioz2ivrrJHLDN2uK95w5aYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJaiXl3DLIld8+GROtuA4Nd3hJ8qNxVs8smdfb3gnG5/hz28P8S70iumQLZ5wewe7rsOgppWTqn3SR/0Hsf2e/sXNR45TCHUSPxR8SEoKoKOclxnSyE6LemSNpaZK2upr0SZrEzaUDl992H5Vwb9wJUlMLLeY7FoFY4qhoqCsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0D1141D0B6F7C0; Wed,  8 Jul 2026 13:09:55 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 03/12] bpf: Wire up JIT support for 16-byte kfunc returns
Date: Wed,  8 Jul 2026 13:09:55 -0700
Message-ID: <20260708200955.2156484-1-yonghong.song@linux.dev>
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

Continue preparing <=3D16 byte aggregate return support by wiring up the =
JIT
side of the R0:R2 return convention for kfuncs.

A kfunc returning more than 8 bytes (a small aggregate or an __int128)
hands the second half of the result back in RDX, the native x86-64 ABI's
second return register. BPF instead expects a 16-byte return in the
R0:R2 register pair. BPF R0 maps to RAX so it needs no move, but BPF R2
maps to RSI, so emit a RDX->RSI move after a BPF_PSEUDO_KFUNC_CALL whose
function model reports ret_size > 8.

Placing the second return half into R2 is possible on any JIT, but it
needs architecture-specific JIT work. Rather than requiring every JIT to
implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
capability, defaulting to false in the generic core; an architecture opts
in once its JIT handles the R0:R2 pair, and the remaining ones are left
for future work. The verifier enforces it in bpf_add_kfunc_call(),
rejecting a kfunc whose return is larger than 8 bytes with -EOPNOTSUPP
when the JIT lacks the capability. Only x86, arm64 and riscv are
supported so far.

On arm64 and riscv the native second return register is already BPF R2
(x1 in bpf2a64[] and a1 in regmap[] respectively), so the value is in the
R0:R2 register pair on return with no extra move, unlike x86 (RDX->RSI).
This has been tested on x86 and arm64. The riscv path is expected to work
by the same register-mapping reasoning as arm64 but has not been tested.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c   |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c |  5 +++++
 arch/x86/net/bpf_jit_comp.c     | 19 +++++++++++++++++++
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               |  5 +++++
 kernel/bpf/verifier.c           |  5 +++++
 6 files changed, 40 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index b0075ece4a6e..a4292e9ec075 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2312,6 +2312,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_kfunc_ret_reg_pair(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
index f9d5347ba966..68faa7016d30 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2107,6 +2107,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_kfunc_ret_reg_pair(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_ptr_xchg(void)
 {
 	return true;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de7515ea1bea..0c685c93df15 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2592,6 +2592,20 @@ st:			insn_off =3D insn->off;
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
+				const struct btf_func_model *fm;
+
+				/*
+				 * A kfunc returning a >8 byte aggregate hands the
+				 * second half back in RDX (the native ABI's second
+				 * return reg), but BPF expects it in R0:R2. BPF R0
+				 * is RAX (no move needed), while BPF R2 is RSI, so
+				 * copy RDX into RSI.
+				 */
+				fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
+				if (fm && fm->ret_size > 8)
+					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
+			}
 			break;
 		}
=20
@@ -4045,6 +4059,11 @@ bool bpf_jit_supports_kfunc_call(void)
 	return true;
 }
=20
+bool bpf_jit_supports_kfunc_ret_reg_pair(void)
+{
+	return true;
+}
+
 bool bpf_jit_supports_stack_args(void)
 {
 	return true;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 14acb2455746..308a0e2d5988 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1182,6 +1182,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e19a030da6f..73dc3ee879de 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3294,6 +3294,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
 	return false;
 }
=20
+bool __weak bpf_jit_supports_kfunc_ret_reg_pair(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_stack_args(void)
 {
 	return false;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03ffb5f839fa..e3f934cf702d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2851,6 +2851,11 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
 	err =3D btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc=
.name, &func_model);
 	if (err)
 		return err;
+	if (func_model.ret_size > 8 && !bpf_jit_supports_kfunc_ret_reg_pair()) =
{
+		verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n",
+			kfunc.name);
+		return -EOPNOTSUPP;
+	}
=20
 	desc =3D &tab->descs[tab->nr_descs++];
 	desc->func_id =3D func_id;
--=20
2.53.0-Meta

