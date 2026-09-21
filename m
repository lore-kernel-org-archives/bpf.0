Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FD4F96A8
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024469; cv=none; b=ru+afTnnAWLdM0MJBL6zd1oNV3K45pSVJl/ZzgPHp8uBmT1mXwQCsE79OKv3cC2Ijq2SinIBZS0RqNrnPT7JhcmusPbJDFxThWcrozmkmp+IhbSip0UIhTf8bcv7/OCLLIRQxW/mai7Z86vUQUdLgFHE8LY5wJJ+uIjvtHFrTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024469; c=relaxed/simple;
	bh=q5i5SRzSnJcVQXpVZQrAuc+X5sJ1UcZrkmnkF3xbAjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGSr+53M9jxjYkWYK1q87LS3y/j4W6/yyjxormnQ19/yQzNqGbRKtQrVjgVmYausd9z9V9s1tdG2VihcWzCbTAAShYg5t4ZUqXkA67fE4w3E1l5fD97cE2U1D7vcwrF3/8q3RnAMdtlkwF1bt4ecysfdNByBFE0dol22K4twk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DDCC72C448F9C5; Mon, 21 Sep 2026 14:00:53 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v4 04/20] bpf: Prepare for an exception cleanup table before the CFG walk
Date: Mon, 21 Sep 2026 14:00:53 -0700
Message-ID: <20260921210053.1717603-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260921210033.1715000-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some plumbing work is done before bpf_check_cfg(). More specifically,
insn_aux_data records cleanup_throw_site for every bpf_throw() and
cleanup_resume_site for every bpf_unwind_resume() -- the two calls a JIT
lowers its own way rather than as calls -- and cleanup_pad, the landing p=
ad
a frame resumes at, for every call within the [begin_off, end_off) range =
of
a cleanup record. Subsequent commits consume all three.

Marking the two calls here, rather than recognising them in the JIT, is
what makes the recognition exact: by the time a JIT runs,
bpf_fixup_kfunc_call() has rewritten every other kfunc's imm into an offs=
et
from __bpf_call_base, and a BTF id compared against one of those offsets
could match an unrelated call.

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
 include/linux/bpf_verifier.h |  2 ++
 include/linux/filter.h       |  1 +
 kernel/bpf/core.c            |  5 +++
 kernel/bpf/exception.c       | 60 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |  1 +
 kernel/bpf/fixups.c          |  6 ++++
 kernel/bpf/verifier.c        |  6 ++++
 7 files changed, 81 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 325a80ffcbe2..fdee9da6b45d 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -686,6 +686,8 @@ struct bpf_insn_aux_data {
 	bool needs_zext; /* alu op needs to clear upper bits */
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
+	bool cleanup_throw_site; /* call to bpf_throw() */
+	bool cleanup_resume_site; /* call to bpf_unwind_resume() */
 	bool call_with_percpu_alloc_ptr; /* {this,per}_cpu_ptr() with prog perc=
pu alloc */
 	u8 alu_state; /* used in combination with alu_limit */
 	/* true if STX or LDX instruction is a part of a spill/fill
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
index 4b3ac93e98c1..67af78baa558 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -18,6 +18,66 @@ static bool insn_is_unwind_resume(const struct bpf_ins=
n *insn)
 	       insn->imm =3D=3D bpf_unwind_resume_id[0];
 }
=20
+static void cleanup_mark_kfunc_sites(struct bpf_verifier_env *env)
+{
+	u32 i;
+
+	for (i =3D 0; i < env->prog->len; i++) {
+		struct bpf_insn *insn =3D &env->prog->insnsi[i];
+
+		if (bpf_is_throw_kfunc(insn))
+			env->insn_aux_data[i].cleanup_throw_site =3D true;
+		else if (insn_is_unwind_resume(insn))
+			env->insn_aux_data[i].cleanup_resume_site =3D true;
+	}
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
+	cleanup_mark_kfunc_sites(env);
+	cleanup_mark_call_sites(env);
+	return 0;
+}
+
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
 {
 	return insn_is_unwind_resume(insn);
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
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5e257d5fc0ef..18b8812f88a7 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -256,6 +256,12 @@ static void adjust_insn_aux_data(struct bpf_verifier=
_env *env,
 			data[i].non_stack_access =3D
 				data[off + cnt - 1].non_stack_access;
 			data[off + cnt - 1].non_stack_access =3D false;
+			data[i].cleanup_throw_site =3D
+				data[off + cnt - 1].cleanup_throw_site;
+			data[off + cnt - 1].cleanup_throw_site =3D false;
+			data[i].cleanup_resume_site =3D
+				data[off + cnt - 1].cleanup_resume_site;
+			data[off + cnt - 1].cleanup_resume_site =3D false;
 			data[i].cleanup_pad =3D data[off + cnt - 1].cleanup_pad;
 			data[off + cnt - 1].cleanup_pad =3D 0;
 		} else if (bpf_is_mem_insn(insn + i)) {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f6878f903bc1..a7a3c4b4d975 100644
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
@@ -21712,6 +21713,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
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

