Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D31314D34
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786215821; cv=none; b=qCE2SpKp3ZO8Iao+u+e0Apj9cUTEsiO6X1WFN8KZelA0KL/WoNfU3fvsU2WUSPzhag24UUhV6Xe1KSSJt6D+kMKl3kVvtJifbw1ZvxsI0ywsHydybmzPqhA4Dx2Fp1PWPk6zNsVXYP1ySZm1YlZDShb78KZ2iVcc/MTuN88vPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786215821; c=relaxed/simple;
	bh=O+ly/09oHBqfLZLh7Rr9ojMLBHPsTfTOf54jeUgmTqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrtH3ZLF8IStNfZnSEiUAonDckDOdj5/O2/TYz6CJzs3tFBsntMK14cpK5tupePY2XJJIgYLJwULXt+k1NoABtWDFOvhhAR7uFdbhOs1PNIwxomn+8wilGdK27gJc33/ztbC1lKKAhTUh2NJVaeSj8B9ySPsEOIlx/S1+zskv7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id AD55022CA31B27; Sat,  8 Aug 2026 12:03:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 03/13] bpf: Wire up JIT support for 16-byte kfunc returns
Date: Sat,  8 Aug 2026 12:03:37 -0700
Message-ID: <20260808190337.1898362-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808190322.1896580-1-yonghong.song@linux.dev>
References: <20260808190322.1896580-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
taught the verifier about that convention; wire up the JIT side so that t=
he
second half of the return value actually lands in R2.

A kfunc returning more than 8 bytes hands the second half of the result
back in RDX, the native x86-64 ABI's second return register. BPF R0 maps =
to
RAX so it needs no move, but BPF R2 maps to RSI, so emit a RDX->RSI move
after a BPF_PSEUDO_KFUNC_CALL whose function model reports ret_size > 8.

Placing the second return half into R2 is possible on any JIT, but it nee=
ds
architecture-specific JIT work. Rather than requiring every JIT to
implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
capability, defaulting to false in the generic core; an architecture opts
in once its JIT handles the R0:R2 pair, and the remaining ones are left f=
or
future work. The verifier enforces it in bpf_add_kfunc_call(), rejecting =
a
kfunc whose return is larger than 8 bytes with -EOPNOTSUPP when the JIT
lacks the capability. Only x86, arm64 and riscv are supported so far.

On arm64 and riscv the native second return register is already BPF R2 (x=
1
in bpf2a64[] and a1 in regmap[] respectively), so the value is in the R0:=
R2
register pair on return with no extra move, unlike x86 (RDX->RSI). This h=
as
been tested on x86 and arm64. The riscv path is expected to work by the
same register-mapping reasoning as arm64 but has not been tested.

bpf_add_kfunc_call() also rejects a kfunc that is marked KF_FASTCALL and
returns more than 8 bytes. The bpf_fastcall contract implemented by
mark_fastcall_pattern_for_call() assumes a call clobbers R0 plus the
registers holding its arguments, so a return in the R0:R2 pair would
clobber an R2 the caller expects the fastcall pattern to preserve. Such
a kfunc is rejected with -EOPNOTSUPP as well.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c   |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c |  5 +++++
 arch/x86/net/bpf_jit_comp.c     | 21 +++++++++++++++++++++
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               |  5 +++++
 kernel/bpf/verifier.c           | 13 +++++++++++++
 6 files changed, 50 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index d14d297ebb96..a1febb4c5718 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2330,6 +2330,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 6b9972b07c1b..c8e94d4657e9 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2111,6 +2111,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 8dddb5d7af21..01c34114c850 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2647,6 +2647,22 @@ st:			insn_off =3D insn->off;
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
+				if (!fm)
+					return -EFAULT;
+				if (fm->ret_size > 8)
+					emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
+			}
 			break;
 		}
=20
@@ -4137,6 +4153,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 4edba8182db1..f3c34fd70f2d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1213,6 +1213,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a3e1fae32eac..d98f4220e875 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3303,6 +3303,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
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
index 58a177d26c46..eed96a795e8a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2837,6 +2837,19 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
 	err =3D btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc=
.name, &func_model);
 	if (err)
 		return err;
+	if (func_model.ret_size > 8) {
+		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
+			verbose(env,
+				"kfunc %s with >8-byte return is not supported with KF_FASTCALL\n",
+				kfunc.name);
+			return -EOPNOTSUPP;
+		}
+		if (!bpf_jit_supports_kfunc_ret_reg_pair()) {
+			verbose(env, "kfunc %s with >8-byte return is not supported by JIT\n"=
,
+				kfunc.name);
+			return -EOPNOTSUPP;
+		}
+	}
=20
 	memset(&meta, 0, sizeof(meta));
 	meta.btf =3D kfunc.btf;
--=20
2.53.0-Meta

