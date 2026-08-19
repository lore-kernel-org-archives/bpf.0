Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC3138B124
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 05:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118783; cv=none; b=sVSOkxfQZQuHniAEszTpY1zqnA3ARgv7Vad7OvnAVtnCfbHjswoTin09ItRC6OPQIJfp2/zwc3Qf78edOf2aA2QsH1ZBIS/aAK/C1xQHFy6myUL0cQy9ILKzcGJ+uT/Bu0JRTuygD95QxwRY0b44jB1Uc/WOoRKl4slPeU73Mxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118783; c=relaxed/simple;
	bh=VZGflafE2M3P3EDWgU8LVos0ZvJQreRtMPeHMDZU/h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU6HQWBpLKT8E/iAotiSSHKkED31VV3AR9xIUsVy5+qq6+brvVZ+Vaqb0NUt6EpA1V7/F07fvTw6jREzJA3uaJB/idSQ5aVUo5LvDd3U0hrLvqZqurON5PKL76gKaJiHtPHKEDI6M0J6FShgtmJVSeupEvQj7UM2PhPm+hosScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5B572250AA37F2; Tue, 18 Aug 2026 22:52:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v7 02/10] bpf: Add helpers to describe the R0:R2 return register pair
Date: Tue, 18 Aug 2026 22:52:49 -0700
Message-ID: <20260819055249.3295283-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819055239.3293449-1-yonghong.song@linux.dev>
References: <20260819055239.3293449-1-yonghong.song@linux.dev>
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

Later patches teach the JIT, live register analysis and the verifier itse=
lf
about that convention. They need to answer the same question: does this
subprogram return its value in a register pair? Add bpf_ret_reg_pair() up
front so it can be used in subsequent patches. It is answered from a
per-subprogram flag that bpf_compute_subprog_ret_regs() derives once from
the BTF prototype.

jit_requested only says that the JIT is enabled, not that it succeeded:
bpf_fixup_call_args() falls back to the interpreter when bpf_jit_subprogs=
()
fails with anything other than -EFAULT. So jit_required is still set once
the pair is modelled, which turns that fallback into a load failure rathe=
r
than a silent divergence from what was verified.

  [1] https://github.com/llvm/llvm-project/pull/190894
  [2] https://github.com/llvm/llvm-project/pull/206876

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  7 ++++
 kernel/bpf/verifier.c        | 66 ++++++++++++++++++++++++++++++------
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5fad59fdab0d..953d8191563a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -819,6 +819,8 @@ struct bpf_subprog_info {
 	bool is_async_cb: 1;
 	bool is_exception_cb: 1;
 	bool args_cached: 1;
+	/* true if the return value is passed in the R0:R2 register pair */
+	bool ret_reg_pair: 1;
 	/* true if bpf_fastcall stack region is used by functions that can't be=
 inlined */
 	bool keep_fastcall_stack: 1;
 	bool changes_pkt_data: 1;
@@ -1055,6 +1057,11 @@ static inline struct bpf_subprog_info *subprog_inf=
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
 struct bpf_call_summary {
 	u8 num_params;
 	bool is_void;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8bf897460ea..2b5e88fdda07 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -385,27 +385,66 @@ bool bpf_subprog_is_global(const struct bpf_verifie=
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
=20
-	return btf_type_is_void(type);
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
+static int bpf_compute_subprog_ret_regs(struct bpf_verifier_env *env)
+{
+	const struct btf *btf =3D env->prog->aux->btf;
+	const struct btf_type *type;
+	int subprog;
+	u32 size;
+
+	if (!env->prog->jit_requested || bpf_prog_is_offloaded(env->prog->aux))
+		return 0;
+
+	/*
+	 * Skip the main program: its return value is the program's exit code,
+	 * read out of R0, so it never uses the register pair. An extension doe=
s
+	 * have a real prototype for subprog 0, but bpf_check_attach_target()
+	 * refuses to replace a function returning more than 8 bytes.
+	 */
+	for (subprog =3D 1; subprog < env->subprog_cnt; subprog++) {
+		type =3D subprog_ret_type(env, subprog);
+		if (!type || btf_type_is_void(type))
+			continue;
+		if (verifier_bug_if(IS_ERR(btf_resolve_size(btf, type, &size)), env,
+				    "cannot size return type of subprog %d", subprog))
+			return -EFAULT;
+		if (ret_regs_cnt(size) > 1) {
+			subprog_info(env, subprog)->ret_reg_pair =3D true;
+			env->prog->jit_required =3D 1;
+		}
+	}
+
+	return 0;
 }
=20
 const char *bpf_subprog_name(const struct bpf_verifier_env *env, int sub=
prog)
@@ -21159,6 +21198,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* must precede the first bpf_ret_reg_pair() user below */
+	ret =3D bpf_compute_subprog_ret_regs(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret =3D bpf_compute_live_registers(env);
 	if (ret < 0)
 		goto skip_full_check;
--=20
2.53.0-Meta

