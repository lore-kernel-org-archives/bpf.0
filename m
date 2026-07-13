Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25C372EFA;
	Mon, 13 Jul 2026 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910662; cv=none; b=lgZNHC/MaDeZ3+WK+/4ed5CNWqWBirzsSxbkpXydH3Y2kVIIAfanQZXrnkJf4gdUHYdKzLwUAO8U/h406B28Xw4itW+3q8CUQUl6mafq6il+EAMCvrn8U8Cp442Yys24uRHJUWyWcWZBEB3er63zpdI/h0QrreOCwpPDg7c2yW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910662; c=relaxed/simple;
	bh=Y9+cwQQeNxjog3uzK5caVDzDAsbLvZ9nr4LrJufZAxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fT8lTxebpGLF0m/HVCRSsCUAkJOvQ/ZBmxqgjF3zgCN5R9hR4KrGz7vIA0R65udFeEYA5+iQAQuIosg+ZlNl+Slsg4zntYEX3Gx1urDdYUs5NX9p78ssmmB4V+UPoZKYAfiTn9PM1gb0SKhm1YgVeU7F+5i0VSJs1ZWAP0B6JPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa+f1YRy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa+f1YRy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201A81F00A3A;
	Mon, 13 Jul 2026 02:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910659;
	bh=Ui0Ha97l+bh1ebfuqnlTP5ETnG66Xz70Sx4zFAQWnSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fa+f1YRyWyj7gRC4+MiJrwHDvy/JagMrqKIOUk4goZnVNM/G+Dgo1XX7msBgJ4cf6
	 owUObGRgghpp1k/CeQL/aMebxrhe+SFbgQFQ7d7t7FMEae+ApT0n4uEof/wSawOVxZ
	 ULuHCNceVBtTCybg5PVpE7wrlUqfSRWFkkVORYt/jc/Kgi4ZEi5ruR0PqnD0jyiT8B
	 kVuPnUi6q/mJgx+1JKoozGU+eNbxRn4AXDlIf2VGR+LTPI6HlHfwG2f+BdroI5YNAe
	 Y4/8HwFwv5lpVvnYs7vB9S5MsKwojDsBIavIUqTLv6HibNPbTXZAN9rLJr249R1ZPF
	 OVF76Q7VLndnw==
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET SLOP RFC 3/6] bpf: Support __arena suffix on struct_ops stub arguments
Date: Sun, 12 Jul 2026 16:44:11 -1000
Message-ID: <20260713024414.3759854-4-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713024414.3759854-1-tj@kernel.org>
References: <20260713024414.3759854-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A struct_ops callback cannot receive an arena pointer directly, so
passing one takes two steps. The pointer arrives as a bare u64 that the
callback casts, and because the two sides address the arena through
different bases it also has to be rebased by hand on the way in.

Add the __arena stub argument suffix and both steps go away. The callback
declares the parameter as an arena pointer, receives it as a PTR_TO_ARENA
register, and dereferences it directly, while the kernel caller just passes
the natural kernel arena address (kaddr). An entry prologue injected into
the program rebases each such ctx slot once, arena = (u32)(kaddr -
kern_vm_start) with NULL preserved, keyed by argument position. The rebased
value keeps the upper 32 bits clear as the JITs require of arena pointer
registers and behaves like any cast_kern'ed arena pointer, so cast_user
recovers the full user-visible address.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 Documentation/bpf/kfuncs.rst |  5 +++
 kernel/bpf/bpf_struct_ops.c  | 17 ++++++---
 kernel/bpf/btf.c             | 10 ++++--
 kernel/bpf/fixups.c          | 70 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c        | 17 ++++++---
 5 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index bad2ac85b318..84726f5830c5 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -270,6 +270,11 @@ Calling such a kfunc requires the program to use an arena map. The program
 can pass any value without compromising the kernel. A value that does not
 point into the arena is a program bug.
 
+The suffix has the same meaning on the arguments of struct_ops stub
+functions. The kernel caller passes the kernel arena address and the
+argument arrives in the BPF program as an arena pointer that can be
+dereferenced directly, with NULL preserved.
+
 .. _BPF_kfunc_nodef:
 
 2.4 Using an existing kernel function
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..a702fb39a238 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -147,6 +147,7 @@ void bpf_struct_ops_image_free(void *image)
 
 #define MAYBE_NULL_SUFFIX "__nullable"
 #define REFCOUNTED_SUFFIX "__ref"
+#define ARENA_SUFFIX "__arena"
 
 /* Prepare argument info for every nullable argument of a member of a
  * struct_ops type.
@@ -159,7 +160,7 @@ void bpf_struct_ops_image_free(void *image)
  * to provide an array of struct bpf_ctx_arg_aux, which in turn provides
  * the information that used by the verifier to check the arguments of the
  * BPF struct_ops program assigned to the member. Here, we only care about
- * the arguments that are marked as __nullable.
+ * the arguments that are marked as __nullable, __ref or __arena.
  *
  * The array of struct bpf_ctx_arg_aux is eventually assigned to
  * prog->aux->ctx_arg_info of BPF struct_ops programs and passed to the
@@ -175,7 +176,7 @@ static int prepare_arg_info(struct btf *btf,
 			    struct bpf_struct_ops_arg_info *arg_info)
 {
 	const struct btf_type *stub_func_proto, *pointed_type;
-	bool is_nullable = false, is_refcounted = false;
+	bool is_nullable = false, is_refcounted = false, is_arena = false;
 	const struct btf_param *stub_args, *args;
 	struct bpf_ctx_arg_aux *info, *info_buf;
 	u32 nargs, arg_no, info_cnt = 0;
@@ -226,26 +227,30 @@ static int prepare_arg_info(struct btf *btf,
 	info = info_buf;
 	for (arg_no = 0; arg_no < nargs; arg_no++) {
 		/* Skip arguments that is not suffixed with
-		 * "__nullable or __ref".
+		 * "__nullable", "__ref" or "__arena".
 		 */
 		is_nullable = btf_param_match_suffix(btf, &stub_args[arg_no],
 						     MAYBE_NULL_SUFFIX);
 		is_refcounted = btf_param_match_suffix(btf, &stub_args[arg_no],
 						       REFCOUNTED_SUFFIX);
+		is_arena = btf_param_match_suffix(btf, &stub_args[arg_no],
+						  ARENA_SUFFIX);
 
 		if (is_nullable)
 			suffix = MAYBE_NULL_SUFFIX;
 		else if (is_refcounted)
 			suffix = REFCOUNTED_SUFFIX;
+		else if (is_arena)
+			suffix = ARENA_SUFFIX;
 		else
 			continue;
 
-		/* Should be a pointer to struct */
+		/* Should be a pointer to struct, or any pointer for __arena */
 		pointed_type = btf_type_resolve_ptr(btf,
 						    args[arg_no].type,
 						    &arg_btf_id);
 		if (!pointed_type ||
-		    !btf_type_is_struct(pointed_type)) {
+		    (!is_arena && !btf_type_is_struct(pointed_type))) {
 			pr_warn("stub function %s has %s tagging to an unsupported type\n",
 				stub_fname, suffix);
 			goto err_out;
@@ -273,6 +278,8 @@ static int prepare_arg_info(struct btf *btf,
 		} else if (is_refcounted) {
 			info->reg_type = PTR_TRUSTED | PTR_TO_BTF_ID;
 			info->refcounted = true;
+		} else if (is_arena) {
+			info->reg_type = PTR_TO_ARENA;
 		}
 
 		info++;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8c04c340f499..c6349915dc1f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6961,15 +6961,19 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		return false;
 	}
 
-	/* check for PTR_TO_RDONLY_BUF_OR_NULL or PTR_TO_RDWR_BUF_OR_NULL */
+	/*
+	 * Check for PTR_TO_RDONLY_BUF_OR_NULL, PTR_TO_RDWR_BUF_OR_NULL or
+	 * PTR_TO_ARENA.
+	 */
 	for (i = 0; i < prog->aux->ctx_arg_info_size; i++) {
 		const struct bpf_ctx_arg_aux *ctx_arg_info = &prog->aux->ctx_arg_info[i];
 		u32 type, flag;
 
 		type = base_type(ctx_arg_info->reg_type);
 		flag = type_flag(ctx_arg_info->reg_type);
-		if (ctx_arg_info->offset == off && type == PTR_TO_BUF &&
-		    (flag & PTR_MAYBE_NULL)) {
+		if (ctx_arg_info->offset == off &&
+		    (type == PTR_TO_ARENA ||
+		     (type == PTR_TO_BUF && (flag & PTR_MAYBE_NULL)))) {
 			info->reg_type = ctx_arg_info->reg_type;
 			return true;
 		}
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d3be972714b2..fde39088e4d0 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -680,6 +680,64 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/*
+ * Rebase every PTR_TO_ARENA struct_ops ctx argument to the arena pointer
+ * form once at entry: arena = (u32)(kaddr - kern_vm_start), NULL preserved.
+ * Keyed by argument position (ctx_arg_info.offset), so the source ctx slot
+ * is converted once and every later load sees it.
+ *
+ * Runs post-verification, so the ctx store and the kern_vm_start constant
+ * need no re-verification. Constant blinding (on under bpf_jit_harden)
+ * forces the safe form: the constant in R0 (an AX-destined LD_IMM64 would
+ * be corrupted), NULL tested against BPF_REG_AX = 0. Off, the cheaper AX
+ * constant and immediate test are used.
+ *
+ * Return the prologue length, INSN_BUF_SIZE if it would not fit, or 0 if
+ * there is nothing to do.
+ */
+static int gen_arena_arg_prologue(struct bpf_verifier_env *env,
+				  struct bpf_insn *insn_buf)
+{
+	struct bpf_prog_aux *aux = env->prog->aux;
+	bool blinding = env->prog->blinding_requested;
+	int base_reg = blinding ? BPF_REG_0 : BPF_REG_AX;
+	struct bpf_insn ld[2] = {
+		BPF_LD_IMM64(base_reg, bpf_arena_get_kern_vm_start(aux->arena))
+	};
+	int i, cnt = 0, nslots = 0;
+
+	for (i = 0; i < aux->ctx_arg_info_size; i++)
+		if (base_type(aux->ctx_arg_info[i].reg_type) == PTR_TO_ARENA)
+			nslots++;
+	if (!nslots)
+		return 0;
+	/* LD_IMM64(2) + MOV(1) + 5 per slot + chained entry insn(1) */
+	if (4 + 5 * nslots > INSN_BUF_SIZE)
+		return INSN_BUF_SIZE;
+
+	insn_buf[cnt++] = ld[0];
+	insn_buf[cnt++] = ld[1];
+	if (blinding)
+		insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_AX, 0);
+
+	for (i = 0; i < aux->ctx_arg_info_size; i++) {
+		int off;
+
+		if (base_type(aux->ctx_arg_info[i].reg_type) != PTR_TO_ARENA)
+			continue;
+		off = aux->ctx_arg_info[i].offset;
+		insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_2, BPF_REG_1, off);
+		insn_buf[cnt++] = blinding ?
+			BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_AX, 2) :
+			BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 2);
+		insn_buf[cnt++] = BPF_ALU64_REG(BPF_SUB, BPF_REG_2, base_reg);
+		insn_buf[cnt++] = BPF_ZEXT_REG(BPF_REG_2);
+		insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_1, BPF_REG_2, off);
+	}
+	insn_buf[cnt++] = env->prog->insnsi[0];
+	return cnt;
+}
+
 /* convert load instructions that access fields of a context type into a
  * sequence of instructions that access fields of the underlying structure:
  *     struct __sk_buff    -> struct sk_buff
@@ -749,6 +807,18 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		}
 	}
 
+	cnt = gen_arena_arg_prologue(env, insn_buf);
+	if (cnt >= INSN_BUF_SIZE) {
+		verifier_bug(env, "arena arg prologue is too long");
+		return -EFAULT;
+	} else if (cnt) {
+		new_prog = bpf_patch_insn_data(env, 0, insn_buf, cnt);
+		if (!new_prog)
+			return -ENOMEM;
+		env->prog = new_prog;
+		delta += cnt - 1;
+	}
+
 	if (delta)
 		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2b00a612e58..a70f66ef227a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -18789,6 +18789,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 {
 	const struct btf_type *t, *func_proto;
 	const struct bpf_struct_ops_desc *st_ops_desc;
+	const struct bpf_struct_ops_arg_info *arg_info;
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
@@ -18867,10 +18868,17 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EACCES;
 	}
 
-	for (i = 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
-		if (st_ops_desc->arg_info[member_idx].info[i].refcounted) {
+	arg_info = &st_ops_desc->arg_info[member_idx];
+	for (i = 0; i < arg_info->cnt; i++) {
+		const struct bpf_ctx_arg_aux *info = &arg_info->info[i];
+
+		if (info->refcounted)
 			has_refcounted_arg = true;
-			break;
+		if (base_type(info->reg_type) == PTR_TO_ARENA && !prog->aux->arena) {
+			verbose(env,
+				"arena argument of %s requires a program with an associated arena\n",
+				mname);
+			return -EINVAL;
 		}
 	}
 
@@ -18891,8 +18899,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
 
-	return bpf_prog_ctx_arg_info_init(prog, st_ops_desc->arg_info[member_idx].info,
-					  st_ops_desc->arg_info[member_idx].cnt);
+	return bpf_prog_ctx_arg_info_init(prog, arg_info->info, arg_info->cnt);
 }
 #define SECURITY_PREFIX "security_"
 
-- 
2.55.0

