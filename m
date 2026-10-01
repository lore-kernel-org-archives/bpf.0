Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF7353A9F
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861440; cv=none; b=M0b/sll5Qvhdr5cu0NlBcQDKqEtW2ExI86ox/0vjPcIg3xjrM8PRrX/dVpLixwjOjqgdby7XYRJ1X0ekKPDpnsjVFEEudTk8sg35yL0CXuw17TztzeGKysfH4gHISUE+5jZxeI9/RqmZpHbPt2jsPhOxSVgAEeNh/XxZU6CgSII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861440; c=relaxed/simple;
	bh=Vhx32KtHA1y7mpV40Wa/HVWo/WwLib/5kBeqx4spTLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7XTi/JoqGvsQc0xvTPQBZmGsRMgEpHMO1OIq0mlcZsDBc3EsCWZnIx2+Ox9v8sc+qsOb/fn4uxmuvnPfWkkwL+nZg6ncl7jKKDTCaXJFeCQ5yiBDhParW+s5y9DxwZNer3IF0iaK1sNPjyLa/Afu/w9YJSPLo6gYClEGbZB3HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5017C2E6E0B8BC; Thu,  1 Oct 2026 06:30:32 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 05/22] bpf: Prepare for an exception cleanup table before the CFG walk
Date: Thu,  1 Oct 2026 06:30:32 -0700
Message-ID: <20261001133032.1338455-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001133006.1335369-1-yonghong.song@linux.dev>
References: <20261001133006.1335369-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Record in insn_aux_data what the later passes need from the cleanup table=
:
cleanup_pad, the landing pad a frame resumes at, for every call that can
unwind -- a BPF-to-BPF call, direct or indirect, or bpf_unwind() -- withi=
n
the [begin_off, end_off) range of a cleanup record. Helper and other kfun=
c
calls in the range cannot unwind and are skipped. Subsequent commits
consume it.

bpf_exc_prepare() runs before bpf_check_cfg(), whose walk consumes what i=
t
produces. It refuses a table on an offloaded program, and on one whose JI=
T
cannot dispatch landing pads or was not asked to compile it. What survive=
s
is marked jit_required: the interpreter cannot dispatch a pad.
bpf_jit_supports_cleanup_pads() is weak here and says no; the arch patche=
s
provide the real ones.

A table is refused for a program whose verifier_ops has a gen_epilogue, a=
s
bpf_qdisc's do. That epilogue is planted by rewriting the exits a program
has when bpf_convert_ctx_accesses() runs, and the exits an unwind returns
through are added after it, so they would skip it. A struct_ops program's
ops, and with them gen_epilogue, are only known after the CFG walk; there
it is the same check made again when bpf_unwind() is verified, from a lat=
er
patch, that refuses it.

A table is also refused alongside bpf_throw(), a second answer to what ru=
ns
on the way out: it leaves for the exception boundary without rewriting th=
e
return addresses of the frames it passes, so no pad between the two would
run. Both the tagged exception callback and the throw itself are checked =
--
either can appear without the other -- over the whole instruction stream,
so a throw in a subprogram is caught as well. The checks sit in
bpf_exc_check_prog(), which a later patch also runs at every bpf_unwind()=
,
so they hold for a program that unwinds with no table too.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h |  1 +
 kernel/bpf/core.c      |  5 +++
 kernel/bpf/exception.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h |  2 ++
 kernel/bpf/verifier.c  |  5 +++
 5 files changed, 92 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index e42eccb0990e..972b3ed2a51d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1248,6 +1248,7 @@ bool bpf_jit_supports_stack_args(void);
 bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
+bool bpf_jit_supports_cleanup_pads(void);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d3b8b626ec0f..d813fdde29e3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3511,6 +3511,11 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
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
index 3ea1bff5cc90..e12cdb12cde3 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -141,6 +141,85 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
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
+int bpf_exc_prepare(struct bpf_verifier_env *env)
+{
+	int err;
+
+	if (!env->cleanup_info_cnt)
+		return 0;
+
+	err =3D bpf_exc_check_prog(env);
+	if (err)
+		return err;
+
+	mark_call_sites(env);
+	return 0;
+}
+
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn)
 {
 	return bpf_pseudo_kfunc_call(insn) && insn->off =3D=3D 0 &&
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index d5c6ac459870..96dac3037d75 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -12,6 +12,8 @@ struct bpf_insn;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
+int bpf_exc_prepare(struct bpf_verifier_env *env);
+int bpf_exc_check_prog(struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index efc516e5ee4d..80034429fdd0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22550,6 +22550,11 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	/* The CFG needs an edge from a call in a cleanup range to its pad. */
+	ret =3D bpf_exc_prepare(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	/* Validate instructions and resolve the program's referenced resources=
. */
 	ret =3D check_and_resolve_insns(env);
 	if (ret < 0)
--=20
2.53.0-Meta

