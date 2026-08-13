Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A6F2F8E98
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 20:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651354; cv=none; b=a4CfNv5IN2RrLn3PoXGXIzqAb6p+6/zddyf/Tm6pEYsAawpQQOyMNot7R7IL2BnVU1bnedVRrsWhZ7wJoICIhcwFncKaZyjAgIdl6sXgUa1O8hMr/qDi2IaSR3AZvO/1WLu6oZlJh5qNmGc0HL9aZ1vuoWTQxSmLe6ucLOn5bdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651354; c=relaxed/simple;
	bh=8Mky89L9VthCB7NSJ3dzkYeED4SCX78KyniTtlGV7TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWK4hEtwqBGgAnS9m6HMlGpq1nOWE+jQmBgQ9k1m8hHFxFTJFiM0mKphKrPqCsjESxk7hiujWGetFOh/KKy27JZniU3TrzrPXbT2fQtJS9ggH4JetkJqT3KtsveMt6K/FhYTdzweVW59NH16iJPkhuKONYZgiJVkz/KymsfYuRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5073023E02E85C; Thu, 13 Aug 2026 13:02:20 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 02/11] bpf: Add helpers to describe the R0:R2 return register pair
Date: Thu, 13 Aug 2026 13:02:20 -0700
Message-ID: <20260813200220.1994468-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813200210.1991507-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

LLVM 23 added support for returning a value in two registers for an
__int128, or a struct/union whose size is greater than 8 but not more tha=
n
16 bytes: such a value comes back in the R0:R2 register pair, with R2
holding the upper half. See LLVM patches [1] and [2].

Later patches teach the JIT, precision backtracking, live register analys=
is
and the verifier itself about that convention. All of them need to answer
the same question: does this call return its value in a register pair? Ad=
d
the shared helpers up front so they can be used in subsequent patches:

 - bpf_ret_reg_pair() for a BPF subprogram, answered from a per-subprogra=
m
   flag that bpf_compute_subprog_ret_regs() derives once from the BTF
   prototype;
 - bpf_kfunc_ret_reg_pair() for a kfunc call site, answered from the
   btf_func_model that bpf_add_kfunc_call() already built, which is the
   same ret_size the JIT keys the second return register off, so the
   verifier and the generated code cannot disagree.

It also sets jit_required, from the same place the convention is decided
rather than from each site that later comes to model R2, so that no such
site can be missed.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  9 +++++
 kernel/bpf/verifier.c        | 73 ++++++++++++++++++++++++++++++------
 2 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 27b43fda9b17..bffd32dca068 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -814,6 +814,8 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	/* true if the return value is passed in the R0:R2 register pair */
+	bool ret_reg_pair: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
@@ -1048,6 +1050,13 @@ static inline struct bpf_subprog_info *subprog_inf=
o(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
=20
+static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int su=
bprog)
+{
+	return subprog_info(env, subprog)->ret_reg_pair;
+}
+
+bool bpf_kfunc_ret_reg_pair(struct bpf_verifier_env *env, struct bpf_ins=
n *insn);
+
 struct bpf_call_summary {
 	u8 num_params;
 	bool is_void;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03570c693d35..57d14480ded2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -382,27 +382,60 @@ bool bpf_subprog_is_global(const struct bpf_verifie=
r_env *env, int subprog)
 	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
 }
=20
-static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
+static const struct btf_type *subprog_ret_type(struct bpf_verifier_env *=
env, int subprog)
 {
-	const struct btf_type *type, *func, *func_proto;
+	const struct btf_type *func, *func_proto;
 	const struct btf *btf =3D env->prog->aux->btf;
 	u32 btf_id;
=20
+	if (!btf || !env->prog->aux->func_info)
+		return NULL;
+
 	btf_id =3D env->prog->aux->func_info[subprog].type_id;
=20
+	/* Both already validated by prepare_btf_func() at prog load. */
 	func =3D btf_type_by_id(btf, btf_id);
-	if (verifier_bug_if(!func, env, "btf_id %u not found", btf_id))
-		return false;
-
 	func_proto =3D btf_type_by_id(btf, func->type);
-	if (!func_proto)
-		return false;
=20
-	type =3D btf_type_skip_modifiers(btf, func_proto->type, NULL);
-	if (!type)
-		return false;
+	return btf_type_skip_modifiers(btf, func_proto->type, NULL);
+}
+
+static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
+{
+	const struct btf_type *type =3D subprog_ret_type(env, subprog);
+
+	return type && btf_type_is_void(type);
+}
+
+static u32 ret_regs_cnt(u32 size)
+{
+	return size > 8 && size <=3D 16 ? 2 : 1;
+}
+
+static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
+{
+	const struct btf *btf =3D env->prog->aux->btf;
+	const struct btf_type *type;
+	int subprog;
+	u32 size;
=20
-	return btf_type_is_void(type);
+	for (subprog =3D 0; subprog < env->subprog_cnt; subprog++) {
+		type =3D subprog_ret_type(env, subprog);
+		if (!type || !(btf_type_is_struct(type) || btf_type_is_scalar(type)))
+			continue;
+		if (IS_ERR(btf_resolve_size(btf, type, &size)))
+			continue;
+		if (ret_regs_cnt(size) > 1) {
+			subprog_info(env, subprog)->ret_reg_pair =3D true;
+			/*
+			 * The R0:R2 return convention is only implemented in
+			 * the JIT: the interpreter propagates BPF_R0 alone out
+			 * of a subprogram, so a caller reading R2 would see a
+			 * stale value.
+			 */
+			env->prog->jit_required =3D 1;
+		}
+	}
 }
=20
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
@@ -2456,6 +2489,21 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 f=
unc_id, u16 offset)
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
=20
+/*
+ * True if the kfunc called by @insn returns its value in the R0:R2 pair=
.
+ * Reads the same btf_func_model.ret_size that bpf_add_kfunc_call() vali=
dated
+ * and that the JIT keys the second return register off, so the verifier=
 and
+ * the generated code cannot disagree about the convention.
+ */
+bool bpf_kfunc_ret_reg_pair(struct bpf_verifier_env *env, struct bpf_ins=
n *insn)
+{
+	const struct bpf_kfunc_desc *desc;
+
+	desc =3D find_kfunc_desc(env->prog, insn->imm, insn->off);
+
+	return desc && ret_regs_cnt(desc->func_model.ret_size) > 1;
+}
+
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
 		       u16 btf_fd_idx, u8 **func_addr)
 {
@@ -20333,6 +20381,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* must precede the first bpf_ret_reg_pair() user below */
+	bpf_compute_subprog_ret_regs(env);
+
 	ret =3D bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
--=20
2.53.0-Meta

