Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9203101A9
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786940531; cv=none; b=eWgK7U1KjT5o0zT+JH5fZYJCbEezby44juB7dDui+tTFSdLbp5Nk5FCtRrRKOMHq+PVZ35CCgdD+MFjdnDFv6sCPobnYsC84BRJeGlF15ueBrv4b2FNcOMKm2uruBVDsGxVRT2sgV0+EWWMSEzszcaU1KJwbU0cNHBO1XEqen9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786940531; c=relaxed/simple;
	bh=pok4xajfmzHl8n92o7BFALBA5WnXlCCQOnsQLz1hH7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mry0qRfTtYe/rdKm1PQZAxLO1QCQcxOMyxKqhst5C9wHHo+t5OSKBWxYU1vhm+w5PtnARPHILaI5Fes7GGByX+Ht3qdFk+bCTlpRg+V1PVvQpFH38dzpMnoVSUKp1hkhOEYQ0EIPYQxD71KgxeA/x4xs1DXJOGh+RqwL7bquiGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E5CCF24982E709; Sun, 16 Aug 2026 21:21:56 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 03/10] bpf: Wire up JIT support for 16-byte kfunc returns
Date: Sun, 16 Aug 2026 21:21:56 -0700
Message-ID: <20260817042156.2287455-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817042141.2286086-1-yonghong.song@linux.dev>
References: <20260817042141.2286086-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
added the shared helpers describing that convention; wire up the JIT side
so that the second half of the return value actually lands in R2.

Placing the second return half into R2 is possible on any JIT, but it nee=
ds
architecture-specific JIT work. Rather than requiring every JIT to
implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
capability, defaulting to false in the generic core; an architecture opts
in once its JIT handles the R0:R2 pair, and the remaining ones are left f=
or
future work. Only the x86-64, arm64 and riscv64 JITs opt in so far.

On arm64 and riscv64 the native second return register is already BPF R2
(x1 in bpf2a64[] and a1 in regmap[] respectively), so the upper half need=
s
no move at all, unlike x86-64's RDX->RSI. The lower half is covered by th=
e
move into BPF R0 that those JITs already emit after every call, from x0
into x8 and from a0 into a5. This has been tested on x86-64 and arm64. Th=
e
riscv64 path is expected to work by the same register-mapping reasoning a=
s
arm64 but has not been tested.

bpf_add_kfunc_call() also rejects a kfunc that is marked KF_FASTCALL and
returns more than 8 bytes. The bpf_fastcall contract implemented by
mark_fastcall_pattern_for_call() assumes a call clobbers R0 plus the
registers holding its arguments, so a return in the R0:R2 pair would
clobber an R2 the caller expects the fastcall pattern to preserve. Such
a kfunc is rejected with -EOPNOTSUPP as well.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c   |  5 +++++
 arch/riscv/net/bpf_jit_comp64.c |  5 +++++
 arch/x86/net/bpf_jit_comp.c     | 27 ++++++++++++++++++++-------
 include/linux/filter.h          |  1 +
 kernel/bpf/core.c               |  5 +++++
 kernel/bpf/verifier.c           | 12 ++++++++++++
 6 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index c18e005a41db..3aa3ea0bc30b 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2388,6 +2388,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 74efe4b138d2..47c7bf431ba8 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -2121,6 +2121,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 1a9fb530adc3..48429fae0641 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1689,17 +1689,12 @@ static int emit_spectre_bhb_barrier(u8 **pprog, u=
8 *ip,
  * arena NULL is offset 0. Return the number of emitted bytes.
  */
 static int emit_kfunc_arena_args(struct bpf_prog *bpf_prog,
-				 const struct bpf_insn *insn, u8 **pprog)
+				 const struct btf_func_model *fm, u8 **pprog)
 {
-	const struct btf_func_model *fm;
 	u8 *prog =3D *pprog;
 	u8 *start =3D prog;
 	int i;
=20
-	fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
-	if (!fm)
-		return -EINVAL;
-
 	for (i =3D 0; i < min_t(int, fm->nr_args, MAX_BPF_FUNC_REG_ARGS); i++) =
{
 		u8 flags =3D fm->arg_flags[i];
 		u32 reg =3D BPF_REG_1 + i;
@@ -2644,6 +2639,8 @@ st:			insn_off =3D insn->off;
=20
 			/* call */
 		case BPF_JMP | BPF_CALL: {
+			const struct btf_func_model *fm =3D NULL;
+
 			func =3D (u8 *) __bpf_call_base + imm32;
 			if (src_reg =3D=3D BPF_PSEUDO_CALL && tail_call_reachable) {
 				LOAD_TAIL_CALL_CNT_PTR(stack_depth);
@@ -2652,7 +2649,10 @@ st:			insn_off =3D insn->off;
 			if (!imm32)
 				return -EINVAL;
 			if (src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
-				err =3D emit_kfunc_arena_args(bpf_prog, insn, &prog);
+				fm =3D bpf_jit_find_kfunc_model(bpf_prog, insn);
+				if (!fm)
+					return -EINVAL;
+				err =3D emit_kfunc_arena_args(bpf_prog, fm, &prog);
 				if (err < 0)
 					return err;
 				ip +=3D err;
@@ -2666,6 +2666,14 @@ st:			insn_off =3D insn->off;
 				return -EINVAL;
 			if (priv_frame_ptr)
 				pop_r9(&prog);
+			/*
+			 * A kfunc returning more than 8 bytes hands the second
+			 * half back in RDX (the native ABI's second return reg),
+			 * but BPF expects it in R0:R2. BPF R0 is RAX (no move
+			 * needed), while BPF R2 is RSI, so copy RDX into RSI.
+			 */
+			if (fm && fm->ret_size > 8)
+				emit_mov_reg(&prog, true, BPF_REG_2, BPF_REG_3);
 			break;
 		}
=20
@@ -4156,6 +4164,11 @@ bool bpf_jit_supports_kfunc_call(void)
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
index 4a9bc6a848f2..6e746b0a0930 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1237,6 +1237,7 @@ bool bpf_jit_inlines_helper_call(s32 imm);
 bool bpf_jit_supports_subprog_tailcalls(void);
 bool bpf_jit_supports_percpu_insn(void);
 bool bpf_jit_supports_kfunc_call(void);
+bool bpf_jit_supports_kfunc_ret_reg_pair(void);
 bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d55e737ed75a..5db77d7915df 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3287,6 +3287,11 @@ bool __weak bpf_jit_supports_kfunc_call(void)
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
index f1f1268d29c6..54aca6c30506 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2920,6 +2920,18 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *en=
v, u32 func_id, u16 offset)
 	err =3D btf_distill_func_proto(&env->log, kfunc.btf, kfunc.proto, kfunc=
.name, &func_model);
 	if (err)
 		return err;
+	if (func_model.ret_size > 8) {
+		if (kfunc.flags && (*kfunc.flags & KF_FASTCALL)) {
+			verbose(env, "kfunc %s with >8-byte return is not supported with KF_F=
ASTCALL\n",
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

