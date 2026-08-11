Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3131B197A7D
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406972; cv=none; b=c4hGLPMR5VB+xAfrZloW9HjuYZkfTBXw+02HuGkm+CmEEjLTZy4PFb3J62vow1G4SwNeMCD66A0CJNxBk0ndwqpnpon58rGqjm0xuXLL4qL0G/txYfoEvehqWkTnhdWgEJkDH7iMTLCbiIa7WyXj6RHQm8XRIm8yawwuG8F2DRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406972; c=relaxed/simple;
	bh=tyOL2UvhPlseh1qTr5D/T6/4Il29+UaPVFvdK2fBmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIIXh1nshh0SxrZDsqaegkBv4tLtYlQjCAG3iadkR7yxRLv99/P9k0EVjHF1IPCKxeKxTAbqRACKj6+FaPpMcQ4rlBhG0r4FoCcxyZNawDdAbWPvlfqSlJOQS/fdTv4CaSlvuB2sbRG72A8w5eFrvJCeTEOlFKsUdbRZcIDpL6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0FEAE233CF262C; Mon, 10 Aug 2026 17:09:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 02/13] bpf: Add helpers to describe the R0:R2 return register pair
Date: Mon, 10 Aug 2026 17:09:22 -0700
Message-ID: <20260811000922.2380171-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811000911.2378679-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
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
the same question: does this subprogram return its value in a register
pair? Add the shared helpers up front so that those patches can be ordere=
d
independently of each other:

 - subprog_ret_type() resolves a subprogram's BTF return type. It is
   factored out of subprog_returns_void(). The verifier_bug_if(!func) and
   !func_proto checks it replaces are redundant, since
   check_btf_func_early() already rejects a func_info record whose type_i=
d
   is not a BTF_KIND_FUNC pointing at a BTF_KIND_FUNC_PROTO. A check on
   prog->aux->{btf,func_info} is added instead: unlike
   subprog_returns_void(), which is only used for global subprograms, lat=
er
   callers ask about static subprograms too, and those may belong to a
   program loaded without BTF.

 - ret_regs_cnt() maps the size of a return value to the number of
   registers holding it.

 - bpf_ret_reg_pair() answers the question above. Its users query it at
   every subprogram call and at every subprogram exit, that is once per
   verifier state rather than once per subprogram, so the answer is
   precomputed into bpf_subprog_info->ret_reg_pair by
   bpf_compute_subprog_ret_regs() and the helper itself is a flag test.
   It lives in bpf_verifier.h because kernel/bpf/backtrack.c and
   kernel/bpf/liveness.c need it as well.

bpf_compute_subprog_ret_regs() runs in bpf_check() right before
bpf_compute_live_registers(), which is the first of those users: by then
BTF func_info has been validated and the subprogram list is final.

No functional change, bpf_ret_reg_pair() has no callers yet.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h | 12 ++++++++
 kernel/bpf/verifier.c        | 55 ++++++++++++++++++++++++++++--------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 93f7c2075eea..79680f3b4c74 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -811,6 +811,8 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	/* true if the return value is passed in the R0:R2 register pair */
+	bool ret_reg_pair: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
@@ -1044,6 +1046,16 @@ static inline struct bpf_subprog_info *subprog_inf=
o(struct bpf_verifier_env *env
 	return &env->subprog_info[subprog];
 }
=20
+/*
+ * True if @subprog returns its value in the R0:R2 register pair. Cached=
 by
+ * bpf_compute_subprog_ret_regs(), since this is queried on hot paths: a=
t
+ * every subprogram call and at every subprogram exit.
+ */
+static inline bool bpf_ret_reg_pair(struct bpf_verifier_env *env, int su=
bprog)
+{
+	return subprog_info(env, subprog)->ret_reg_pair;
+}
+
 struct bpf_call_summary {
 	u8 num_params;
 	bool is_void;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40150390dd50..58a177d26c46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -382,27 +382,57 @@ bool bpf_subprog_is_global(const struct bpf_verifie=
r_env *env, int subprog)
 	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
 }
=20
-static bool subprog_returns_void(struct bpf_verifier_env *env, int subpr=
og)
+/* Return type of a subprogram, NULL if it cannot be resolved */
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
=20
-	return btf_type_is_void(type);
+	return type && btf_type_is_void(type);
+}
+
+/*
+ * Number of registers holding a function return value: a value of up to=
 8
+ * bytes is returned in R0, a value of more than 8 bytes and no more tha=
n 16
+ * bytes (an __int128 or a struct/union of such size) is returned in the=
 R0:R2
+ * register pair, with R2 holding the upper half.
+ */
+static u32 ret_regs_cnt(u32 size)
+{
+	return size > 8 && size <=3D 16 ? 2 : 1;
+}
+
+/*
+ * Resolve the return convention of every subprogram once, so that
+ * bpf_ret_reg_pair() is a plain flag test on the hot paths that use it.
+ */
+static void bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
+{
+	const struct btf_type *type;
+	int subprog;
+
+	for (subprog =3D 0; subprog < env->subprog_cnt; subprog++) {
+		type =3D subprog_ret_type(env, subprog);
+		if (type && (btf_type_is_struct(type) || btf_type_is_scalar(type)))
+			subprog_info(env, subprog)->ret_reg_pair =3D ret_regs_cnt(type->size)=
 > 1;
+	}
 }
=20
 static const char *subprog_name(const struct bpf_verifier_env *env, int =
subprog)
@@ -20288,6 +20318,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
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

