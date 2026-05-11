Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD6363C53
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778477671; cv=none; b=mxH+JEMNB4VpyUoav7GYuA+LzWsMuZvVWNcOewU5BPxLAyCvRySPn5oXliUGVBuZueU0LWelhW5ON3R85b+iDi1Wd765zExtZ/t8b1mL1T2fJcW+ItagXCrqfubG3vMUI8Iqs+nzH4m0k8NxThu+uT6rEUWf5ITUAzCCHQKGwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778477671; c=relaxed/simple;
	bh=Zam+w5rhZimIYZ44Q4Tdaw8xwwIjh+aIng75IbqeTFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcZ1lvAU+mRKKirfxPpZsGr+q86M1ox3xuETCsDT13UEL0Nc8Ijk9chW3ch8kFseAwhpELdKxXeTsjAizdz5ahOadoZc/qrP5BUmi89woYCfV7jN+AnOhsoAk5h8IgGgKcN1tpKfBCR57AIOkhaXl/aR9HUdok+souh5B6/A1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id D28D0A59DC6BE; Sun, 10 May 2026 22:34:18 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v3 15/24] bpf: Pass bpf_subprog_info to bpf_int_jit_compile()
Date: Sun, 10 May 2026 22:34:18 -0700
Message-ID: <20260511053418.1888759-1-yonghong.song@linux.dev>
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

Add a bpf_subprog_info parameter to bpf_int_jit_compile() so that
JIT backends can access per-subprog metadata directly, such as
stack_arg_cnt and arg_cnt, without encoding them into bpf_prog_aux.

Previously, subprog properties needed by the JIT were copied into
bpf_prog_aux fields (e.g., out_stack_arg_cnt). Passing
bpf_subprog_info directly avoids adding more fields to bpf_prog_aux
and gives JIT backends a single place to query subprog metadata.

In jit_subprogs(), each subprog's corresponding bpf_subprog_info
is passed to bpf_int_jit_compile(). For the single-subprog path
in bpf_prog_jit_compile(), &env->subprog_info[0] is passed when
env is available, or NULL when env is NULL. The env is NULL for
internal kernel BPF programs created via bpf_prog_create() (e.g.,
the PTP packet classifier in net/core/ptp_classifier.c) which
bypass the verifier and never use stack arguments.

All architecture JIT implementations are updated to accept the new
parameter. No functional change for architectures that do not yet
use subprog_info.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 arch/arc/net/bpf_jit_core.c      | 3 ++-
 arch/arm/net/bpf_jit_32.c        | 3 ++-
 arch/arm64/net/bpf_jit_comp.c    | 3 ++-
 arch/loongarch/net/bpf_jit.c     | 3 ++-
 arch/mips/net/bpf_jit_comp.c     | 3 ++-
 arch/parisc/net/bpf_jit_core.c   | 3 ++-
 arch/powerpc/net/bpf_jit_comp.c  | 3 ++-
 arch/riscv/net/bpf_jit_core.c    | 3 ++-
 arch/s390/net/bpf_jit_comp.c     | 3 ++-
 arch/sparc/net/bpf_jit_comp_64.c | 3 ++-
 arch/x86/net/bpf_jit_comp.c      | 3 ++-
 arch/x86/net/bpf_jit_comp32.c    | 3 ++-
 include/linux/filter.h           | 4 +++-
 kernel/bpf/core.c                | 9 ++++++---
 kernel/bpf/fixups.c              | 4 ++--
 15 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/arc/net/bpf_jit_core.c b/arch/arc/net/bpf_jit_core.c
index 639a2736f029..771de9a8147d 100644
--- a/arch/arc/net/bpf_jit_core.c
+++ b/arch/arc/net/bpf_jit_core.c
@@ -1400,7 +1400,8 @@ static struct bpf_prog *do_extra_pass(struct bpf_pr=
og *prog)
  * (re)locations involved that their addresses are not known
  * during the first run.
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	vm_dump(prog);
=20
diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..17692af0f11f 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2148,7 +2148,8 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct bpf_binary_header *header;
 	struct jit_ctx ctx;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
index 0816c40fc7af..c9bdeef31ab9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2003,7 +2003,8 @@ struct arm64_jit_data {
 	struct jit_ctx ctx;
 };
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	int image_size, prog_size, extable_size, extable_align, extable_offset;
 	struct bpf_binary_header *header;
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 24913dc7f4e8..416dabe9947f 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2166,7 +2166,8 @@ int arch_bpf_trampoline_size(const struct btf_func_=
model *m, u32 flags,
 	return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	bool extra_pass =3D false;
 	u8 *image_ptr, *ro_image_ptr;
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index 6ee4abe6a1f7..2f85c90bba07 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -909,7 +909,8 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct bpf_binary_header *header =3D NULL;
 	struct jit_context ctx;
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_cor=
e.c
index 172770132440..b24275aef8db 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -41,7 +41,8 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	unsigned int prog_size =3D 0, extable_size =3D 0;
 	bool extra_pass =3D false;
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
index 53ab97ad6074..5a414da47e4e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -162,7 +162,8 @@ static void priv_stack_check_guard(void __percpu *pri=
v_stack_ptr, int alloc_size
 	}
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp,
+				     struct bpf_subprog_info *subprog_info)
 {
 	u32 proglen;
 	u32 alloclen;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.=
c
index 4365d07aaf54..3ae8adf0f697 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -41,7 +41,8 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	unsigned int prog_size =3D 0, extable_size =3D 0;
 	bool extra_pass =3D false;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 14eaaa5b2185..bc29f405161a 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2337,7 +2337,8 @@ static struct bpf_binary_header *bpf_jit_alloc(stru=
ct bpf_jit *jit,
 /*
  * Compile eBPF program "fp"
  */
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *fp,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct bpf_binary_header *header;
 	struct s390_jit_data *jit_data;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_co=
mp_64.c
index 2fa0e9375127..90bc01d069fe 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1477,7 +1477,8 @@ struct sparc64_jit_data {
 	struct jit_ctx ctx;
 };
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct sparc64_jit_data *jit_data;
 	struct bpf_binary_header *header;
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index ea9e707e8abf..e9718faa0124 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3715,7 +3715,8 @@ struct x64_jit_data {
 #define MAX_PASSES 20
 #define PADDING_PASSES (MAX_PASSES - 5)
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct bpf_binary_header *rw_header =3D NULL;
 	struct bpf_binary_header *header =3D NULL;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.=
c
index 852baf2e4db4..e89558a27834 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2518,7 +2518,8 @@ bool bpf_jit_needs_zext(void)
 	return true;
 }
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog)
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info)
 {
 	struct bpf_binary_header *header =3D NULL;
 	int proglen, oldproglen =3D 0;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a515a9769078..3576ee523bee 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -37,6 +37,7 @@ struct xdp_buff;
 struct sock_reuseport;
 struct ctl_table;
 struct ctl_table_header;
+struct bpf_subprog_info;
=20
 /* ArgX, context and stack frame pointer register positions. Note,
  * Arg1, Arg2, Arg3, etc are used as argument mappings of function
@@ -1177,7 +1178,8 @@ u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4,=
 u64 r5);
 	((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
 	 (void *)__bpf_call_base)
=20
-struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog);
+struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struc=
t bpf_prog *prog,
+				     struct bpf_subprog_info *subprog_info);
 void bpf_jit_compile(struct bpf_prog *prog);
 bool bpf_jit_needs_zext(void);
 bool bpf_jit_inlines_helper_call(s32 imm);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e6b836f846eb..dcba6f166a91 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2547,7 +2547,8 @@ static struct bpf_prog *bpf_prog_jit_compile(struct=
 bpf_verifier_env *env, struc
 	struct bpf_insn_aux_data *orig_insn_aux;
=20
 	if (!bpf_prog_need_blind(prog))
-		return bpf_int_jit_compile(env, prog);
+		return bpf_int_jit_compile(env, prog,
+					   env ? &env->subprog_info[0] : NULL);
=20
 	if (env) {
 		/*
@@ -2569,7 +2570,8 @@ static struct bpf_prog *bpf_prog_jit_compile(struct=
 bpf_verifier_env *env, struc
 	if (IS_ERR(prog))
 		goto out_restore;
=20
-	prog =3D bpf_int_jit_compile(env, prog);
+	prog =3D bpf_int_jit_compile(env, prog,
+				   env ? &env->subprog_info[0] : NULL);
 	if (prog->jited) {
 		bpf_jit_prog_release_other(prog, orig_prog);
 		if (env)
@@ -3145,7 +3147,8 @@ const struct bpf_func_proto bpf_tail_call_proto =3D=
 {
  * It is encouraged to implement bpf_int_jit_compile() instead, so that
  * eBPF and implicitly also cBPF can get JITed!
  */
-struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog)
+struct bpf_prog * __weak bpf_int_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog,
+					     struct bpf_subprog_info *subprog_info)
 {
 	return prog;
 }
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 19056016eed8..62f1823f089e 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1162,7 +1162,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
-		func[i] =3D bpf_int_jit_compile(env, func[i]);
+		func[i] =3D bpf_int_jit_compile(env, func[i], &env->subprog_info[i]);
 		if (!func[i]->jited) {
 			err =3D -ENOTSUPP;
 			goto out_free;
@@ -1206,7 +1206,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	}
 	for (i =3D 0; i < env->subprog_cnt; i++) {
 		old_bpf_func =3D func[i]->bpf_func;
-		tmp =3D bpf_int_jit_compile(env, func[i]);
+		tmp =3D bpf_int_jit_compile(env, func[i], &env->subprog_info[i]);
 		if (tmp !=3D func[i] || func[i]->bpf_func !=3D old_bpf_func) {
 			verbose(env, "JIT doesn't support bpf-to-bpf calls\n");
 			err =3D -ENOTSUPP;
--=20
2.53.0-Meta

