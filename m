Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B23F4DE6
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139572; cv=none; b=oOb0MDaUiAVRXItftPSnbYHOEkj5Ibxz07AZcZZNhqPbguW6feIEsrgNyRjxnIoC7tWR7OD3TDRU6tw+rsd8zEGaKZMFql4n2SM1GFppNcBfo8Qy30UHkiJhSy77J8Vnqh7sxtmvH6Y+y4VJTHRysOY7WigUebTIh3ahTp3Aw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139572; c=relaxed/simple;
	bh=3xk9UUykp9uGfBTbpiUTGt4wKgbkG1EYDl22VBqvsAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSvn1jb7SSkWfDHFSqb+14I7VOLXeI4z+boSWVH7xCnq84HPgwxqGnZxexVWOJmquasUX8rFtI8mFa/lVEHrmpVodXL445mTeJ+Ei+81NimHra1emOXJlDKw3r7jhoVhAyhQU12VfU9aj7TS9361QA77KZNaEvqdNd8BuRkAufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 1B8492C8DA16F9; Tue, 22 Sep 2026 21:59:12 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 05/21] bpf: Prepare for an exception cleanup table before the CFG walk
Date: Tue, 22 Sep 2026 21:59:12 -0700
Message-ID: <20260923045912.2417059-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923045846.2414643-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Record in insn_aux_data what the later passes need from the cleanup table=
:
throw_call for every bpf_throw() and resume_call for every
bpf_unwind_resume() -- the two calls a JIT lowers its own way rather than
as calls -- and cleanup_pad, the landing pad a frame resumes at, for ever=
y
call within the [begin_off, end_off) range of a cleanup record. Subsequen=
t
commits consume all three.

Marking the two calls here, rather than recognising them in the JIT, is
what makes the recognition exact: by the time a JIT runs,
bpf_fixup_kfunc_call() has rewritten every other kfunc's imm into an offs=
et
from __bpf_call_base, and a BTF id compared against one of those offsets
could match an unrelated call.

bpf_prepare_cleanup_exceptions() runs before bpf_check_cfg(), whose walk
consumes what it produces. It refuses a table on an offloaded program, on
one whose JIT cannot dispatch landing pads or was not asked to compile it=
,
and on one that also installs an exception callback -- two different
answers to what runs on the way out. What survives is marked jit_required=
:
the interpreter cannot dispatch a pad. bpf_jit_supports_cleanup_pads() is
weak here and says no; the arch patches provide the real ones.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 +++
 kernel/bpf/exception.c       | 62 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  1 +
 kernel/bpf/fixups.c          |  6 ++++
 kernel/bpf/verifier.c        |  6 ++++
 7 files changed, 83 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 666c73308b32..e12ec91b8150 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -692,6 +692,8 @@ struct bpf_insn_aux_data {
 	 */
 	u64 fastcall_spills_num:3;
 	u64 arg_prog:4;
+	u64 throw_call:1; /* call to bpf_throw() */
+	u64 resume_call:1; /* call to bpf_unwind_resume() */
=20
 	/* below flags are initialized once */
 	u64 jmp_point:1;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 422284b4fa96..2582a7606e46 100644
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
index 227211166dcc..a379cd1ec4c6 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3475,6 +3475,11 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
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
index 6989f31aa6c9..244ea1b5417c 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -7,8 +7,70 @@
 #include <linux/filter.h>
 #include "exception.h"
=20
+#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
+
 BTF_ID_LIST_SINGLE(bpf_unwind_resume_id, func, bpf_unwind_resume)
=20
+static void mark_kfunc_sites(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->prog->len; i++) {
+		struct bpf_insn *insn =3D &env->prog->insnsi[i];
+
+		if (bpf_is_throw_kfunc(insn))
+			env->insn_aux_data[i].throw_call =3D true;
+		else if (bpf_is_unwind_resume_kfunc(insn))
+			env->insn_aux_data[i].resume_call =3D true;
+	}
+}
+
+static void mark_call_sites(struct bpf_verifier_env *env)
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
+	mark_kfunc_sites(env);
+	mark_call_sites(env);
+	return 0;
+}
+
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 634cb2c15ffc..b96b2c429e22 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -7,6 +7,7 @@
=20
 struct bpf_verifier_env;
=20
+int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index e3459123803c..fed5b66ed3b7 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -256,6 +256,12 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
 			data[i].non_stack_access =3D
 				data[off + cnt - 1].non_stack_access;
 			data[off + cnt - 1].non_stack_access =3D false;
+			data[i].throw_call =3D
+				data[off + cnt - 1].throw_call;
+			data[off + cnt - 1].throw_call =3D false;
+			data[i].resume_call =3D
+				data[off + cnt - 1].resume_call;
+			data[off + cnt - 1].resume_call =3D false;
 			data[i].cleanup_pad =3D data[off + cnt - 1].cleanup_pad;
 			data[off + cnt - 1].cleanup_pad =3D 0;
 		} else if (bpf_is_mem_insn(insn + i)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c65103152320..8163c75ec3fa 100644
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
@@ -21792,6 +21793,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
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

