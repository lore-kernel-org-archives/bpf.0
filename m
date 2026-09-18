Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA21A3172
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789706551; cv=none; b=usadUGdoGY8uU/xdddkiZna6M6yKdiYvb7vugb87UViZrIVvnMITFe0Us4GUjKR4GAeFXXBKWqbeRqrYT4DjCFYYbvM/6WUldGgFSfPA+KKkWu1++sm+W8kBUkxhKmrEekkIFS1HWegoci4DSzCu8rbxIonrkOeBG0cfxNUcDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789706551; c=relaxed/simple;
	bh=bG4udEpYdGrBrzkXGB+ZtU+pCWkYVTh541eGtPeJOWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/c3VRLoSaLq2TtiSgwLGX7D0zBBc8raDrItfbveD+A1ZUzE6IdyfQ5mBnQnZ4VN54yLQtFQJDjIdst5bkW0N30aN51wCsf+k8o5HMzELqC7LOTVRdN6pybFS52YVwn2hVB7MFIAgLGXVKV6V1Uw2B8L+ZG6Tfj+3XFhvIaXa8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 79DE92B7C4C0F3; Thu, 17 Sep 2026 21:42:16 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 04/20] bpf: Mark the call sites an exception cleanup table covers
Date: Thu, 17 Sep 2026 21:42:16 -0700
Message-ID: <20260918044216.3287185-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918044156.3283973-1-yonghong.song@linux.dev>
References: <20260918044156.3283973-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some plumbing work is done before bpf_check_cfg(). More specifically,
insn_aux_data records cleanup_throw_site for every bpf_throw(), and
cleanup_pad, the landing pad a frame resumes at, for every call within th=
e
[begin_off, end_off) range of a cleanup record. Subsequent commits consum=
e
both.

bpf_prepare_cleanup_exceptions() runs before bpf_check_cfg(), because wha=
t
it produces is what the CFG walk consumes. It refuses a table on an
offloaded program, on a program whose JIT cannot dispatch landing pads or
which the JIT was not asked to compile, and on a program that also instal=
ls
an exception callback -- two different answers to what runs on the way ou=
t.
bpf_jit_supports_cleanup_pads() is weak here and says no; the arch patche=
s
provide the real ones.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  1 +
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 ++++
 kernel/bpf/exception.c       | 55 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  1 +
 kernel/bpf/verifier.c        |  6 ++++
 6 files changed, 69 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f9bccd3e0f4d..7463e86d15ee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -681,6 +681,7 @@ struct bpf_insn_aux_data {
 	bool needs_zext; /* alu op needs to clear upper bits */
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool cleanup_throw_site; /* call to bpf_throw() */
 	/*
 	 * 1 + the instruction index of the exception cleanup landing pad this
 	 * call site unwinds to, or 0 for none.
diff --git a/include/linux/filter.h b/include/linux/filter.h
index b17222db2efc..9682b98ad890 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1242,6 +1242,7 @@ bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_cleanup_pads(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4e208cc94752..f0dd851264f4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3470,6 +3470,11 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
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
index 3895b9453639..dfe9c2a9ce7d 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -23,6 +23,61 @@ static bool insn_is_exc_kfunc(const struct bpf_insn *i=
nsn, int kf)
 	       insn->imm =3D=3D exc_kfunc_list[kf];
 }
=20
+static void cleanup_mark_throw_sites(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->prog->len; i++)
+		if (bpf_is_throw_kfunc(&env->prog->insnsi[i]))
+			env->insn_aux_data[i].cleanup_throw_site =3D true;
+}
+
+static void cleanup_mark_call_sites(struct bpf_verifier_env *env)
+{
+	u32 i, j;
+
+	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
+		struct bpf_cleanup_info *rec =3D &env->cleanup_info[i];
+
+		for (j =3D rec->begin_off; j < rec->end_off; j++) {
+			struct bpf_insn *insn =3D &env->prog->insnsi[j];
+
+			if (!bpf_pseudo_call(insn) && !bpf_is_throw_kfunc(insn))
+				continue;
+			env->insn_aux_data[j].cleanup_pad =3D rec->landing_pad_off + 1;
+		}
+	}
+}
+
+int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env)
+{
+	if (!env->cleanup_info_cnt)
+		return 0;
+
+	if (bpf_prog_is_offloaded(env->prog->aux)) {
+		verbose(env,
+			"exception cleanup is not supported for offloaded programs\n");
+		return -EINVAL;
+	}
+
+	if (!bpf_jit_supports_cleanup_pads() || !env->prog->jit_requested) {
+		verbose(env,
+			"exception cleanup needs a JIT that can dispatch landing pads\n");
+		return -EOPNOTSUPP;
+	}
+	env->prog->jit_required =3D 1;
+
+	if (env->exception_callback_subprog) {
+		verbose(env,
+			"exception cleanup table cannot be combined with an exception callbac=
k\n");
+		return -EINVAL;
+	}
+
+	cleanup_mark_throw_sites(env);
+	cleanup_mark_call_sites(env);
+	return 0;
+}
+
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
 {
 	return insn_is_exc_kfunc(insn, EXC_KF_bpf_unwind_resume);
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 0f2b9624a2ce..f51383fd775c 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -7,6 +7,7 @@
=20
 struct bpf_verifier_env;
=20
+int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
 int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c65ff2e326bf..6496c30a10f7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -37,6 +37,7 @@
=20
 #include "diagnostics.h"
 #include "disasm.h"
+#include "exception.h"
=20
 static const struct bpf_verifier_ops * const bpf_verifier_ops[] =3D {
 #define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type) \
@@ -21638,6 +21639,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* The CFG needs an edge from a call in a cleanup range to its pad. */
+	ret =3D bpf_prepare_cleanup_exceptions(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Validate instructions and resolve the program's referenced resources=
. */
 	ret =3D check_and_resolve_insns(env);
 	if (ret < 0)
--=20
2.53.0-Meta

