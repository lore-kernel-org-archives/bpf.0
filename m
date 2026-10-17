Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB13ACA51
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205523; cv=none; b=O6Qu/dJUvrQTDDr8+XaZ5bWq+5pzZ1/lQq8LxKVJBvsxEM9Olza2dSdyecSMBhYm6MgOzDUIcaciJPohwN5XFvqBwBnTrwAB/WsbvITlhW4mPRQ61l/lWn+eUGVae/MC0x4DTVsOjhe/OrRRO0wn8ZAP2vUovU2HsNpuwPlq2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205523; c=relaxed/simple;
	bh=+duyO8FCwCgGXH3yDLqdntFs9w1ZEUNsUPnUeIcM3EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLLKPvIPVk1mqBAVOKoBB2pXPuT0NxNUT5UYOsNq2N0pj5bJKZ4pAHSZADVH8FYDa72XS5CIHf1xJcpCAPg1z+i606wagfpQCCtOdF/T3Yy7uvHNRP929pZglx2Ci7kcRqZjjGgAFeSXSvXNo1WwBGt1JFQOf8s8uuJr2JLQWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 145C731B3AFCE6; Fri, 16 Oct 2026 19:51:50 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 04/25] bpf: Mark covered call sites and check a program can take a table
Date: Fri, 16 Oct 2026 19:51:50 -0700
Message-ID: <20261017025150.1917920-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017025129.1914859-1-yonghong.song@linux.dev>
References: <20261017025129.1914859-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before the CFG walk, bpf_exc_mark_call_sites() records the landing pad
of every call in a cleanup record's range that can unwind: a BPF-to-BPF
call, direct or indirect, or a call to bpf_unwind().

bpf_exc_check_prog() refuses a table where pad dispatch cannot work. An
offloaded program cannot take one, and neither can a program without a
JIT that dispatches pads. Nor can a program whose verifier_ops has a
gen_epilogue, as bpf_qdisc's does: the epilogue is planted on the exits
bpf_convert_ctx_accesses() sees, and the exits an unwind returns through
are added after it. A table cannot be combined with an exception
callback or with a bpf_throw() anywhere in the program either, since a
throw leaves without rewriting return addresses, so no pad would run.

bpf_exc_check_prog() runs after check_attach_btf_id(), since a struct_ops
program's gen_epilogue is only known then, and marks a program that
passes it jit_required. bpf_jit_supports_cleanup_pads() says no until
the arch patches.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h |  1 +
 kernel/bpf/core.c      |  5 ++++
 kernel/bpf/exception.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h |  2 ++
 kernel/bpf/verifier.c  |  9 ++++++
 5 files changed, 81 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9339c6131f8f..c8ca863e352a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1248,6 +1248,7 @@ bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_cleanup_pads(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_arena_scalar(void);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 642f0ab8eb2d..a5a5463449c1 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3524,6 +3524,11 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
(void *cookie, u64 ip, u64 sp,
 {
 }
=20
+bool __weak bpf_jit_supports_cleanup_pads(void)
+{
+	return false;
+}
+
 bool __weak bpf_jit_supports_timed_may_goto(void)
 {
 	return false;
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 9ab29c73c44b..80d1edc19441 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -141,6 +141,70 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
 BTF_ID_LIST_SINGLE(bpf_unwind_id, func, bpf_unwind)
 BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
=20
+static int reject_throw(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->prog->len; i++) {
+		if (!bpf_is_throw_kfunc(&env->prog->insnsi[i]))
+			continue;
+		verbose(env,
+			"exception cleanup cannot be combined with bpf_throw at insn %u\n",
+			i);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+void bpf_exc_mark_call_sites(struct bpf_verifier_env *env)
+{
+	u32 i, j;
+
+	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
+		struct bpf_cleanup_info *rec =3D &env->cleanup_info[i];
+
+		for (j =3D rec->begin_off; j < rec->end_off; j++) {
+			struct bpf_insn *insn =3D &env->prog->insnsi[j];
+
+			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn) &&
+			    !bpf_is_unwind_kfunc(insn))
+				continue;
+			env->insn_aux_data[j].cleanup_pad =3D rec->landing_pad_off + 1;
+		}
+	}
+}
+
+int bpf_exc_check_prog(struct bpf_verifier_env *env)
+{
+	int err;
+
+	if (bpf_prog_is_offloaded(env->prog->aux)) {
+		verbose(env,
+			"exception cleanup is not supported for offloaded programs\n");
+		return -EINVAL;
+	}
+	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
+		verbose(env,
+			"exception cleanup needs a JIT that can dispatch landing pads\n");
+		return -EOPNOTSUPP;
+	}
+	if (env->ops->gen_epilogue) {
+		verbose(env,
+			"exception cleanup is not supported for a program with an epilogue\n"=
);
+		return -EOPNOTSUPP;
+	}
+	if (env->exception_callback_subprog) {
+		verbose(env,
+			"exception cleanup cannot be combined with an exception callback\n");
+		return -EINVAL;
+	}
+	err =3D reject_throw(env);
+	if (err)
+		return err;
+	env->prog->jit_required =3D 1;
+	return 0;
+}
+
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index d5c6ac459870..30918714a6e8 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -12,6 +12,8 @@ struct bpf_insn;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
+void bpf_exc_mark_call_sites(struct bpf_verifier_env *env);
+int bpf_exc_check_prog(struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1facec5485b3..eb60311b7d1f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23473,6 +23473,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* The CFG needs an edge from a call in a cleanup range to its pad. */
+	bpf_exc_mark_call_sites(env);
+
 	/* Validate instructions and resolve the program's referenced resources=
. */
 	ret =3D check_and_resolve_insns(env);
 	if (ret < 0)
@@ -23510,6 +23513,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret)
 		goto skip_full_check;
=20
+	if (env->cleanup_info_cnt) {
+		ret =3D bpf_exc_check_prog(env);
+		if (ret)
+			goto skip_full_check;
+	}
+
 	ret =3D bpf_compute_const_regs(env);
 	if (ret < 0)
 		goto skip_full_check;
--=20
2.53.0-Meta

