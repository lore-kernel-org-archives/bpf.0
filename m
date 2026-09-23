Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713C40860A
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790139599; cv=none; b=LRr4WXjzQ4Yt1RqrdIWJuxCN3jbAmYyZbNQFu3qKnf9F09kWKTiK1iA2F4yGLO13CTt1vO0jZPRmQzr/XA6TIC8Vu3VyNLs/mXb1IoCbCdwKlJ+NHuCRhf/BFgtoDC1HdrYI1h/8rjlV+O6q0B/3Z0pag05J8xVTGy5hMWwjtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790139599; c=relaxed/simple;
	bh=fJoY1FPXq6osAmlFS5edjv9c33bd94sAYgkzN5mRBt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6Ghp96UENedElHky2HsQRfr8AyJXE9q5C1e25kF7sGMTwrWaLfRbZhUn2fGcMxQ7gd8k5tSXgCI8wlo56ABSySTZo+Db3AWp36G75WHd1WVL+qAZNSyCvumvbRho7noRKjzTZloyyM9dc42lbZI6whbi8U8KvzMLf0vBbG+Db0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 0DBDA2C8DA7EC7; Tue, 22 Sep 2026 21:59:43 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 11/21] bpf: Dispatch exception cleanup pads from bpf_throw()
Date: Tue, 22 Sep 2026 21:59:43 -0700
Message-ID: <20260923045943.2420109-1-yonghong.song@linux.dev>
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

Stop discarding the frames an exception unwinds through. bpf_throw()
already walks the BPF call stack with arch_bpf_stack_walk() to find the
exception boundary; have it look each frame's return address up in that
(sub)program's cleanup table on the way and run the landing pad a matchin=
g
record names.

A pad is run as a subroutine of the walker, not jumped to. It executes wi=
th
the unwinding frame's frame pointer and BPF callee-saved registers, so
everything it reads is that frame's, but on the current stack far below i=
t,
so nothing it calls can disturb the frame it is cleaning up after. It end=
s
in what the JIT emits for its bpf_unwind_resume(), which hands control ba=
ck
to the walker rather than to the frame's caller. That is exactly the
procedure the LLVM commit emitting the section describes.

Restoring the frame's r6-r9 is what makes this work, and it is only
possible because the callee about to be discarded spilled them in its own
prologue. bpf_exc_force_spill() tells a JIT to make that spill
unconditional and of a known shape for every subprogram of a program
carrying a cleanup table, and aux->exc->spill_off records where it starts=
,
so the walker needs no per-frame metadata. The frame that called
bpf_throw() has no callee to have spilled anything and never runs its own
epilogue, so the JIT spills that frame's registers at the throw site
instead, in the area aux->exc->throw_spill_off names.

The main program needs the table handed to it rather than built for it.
jit_subprogs() compiles it as func[0], but the ksym covering that image i=
s
the one bpf_prog_load() registers for the outer bpf_prog, and that is wha=
t
the walker finds -- so without the handover a landing pad in the main
program's own frame is never dispatched, silently, since the exception
still reaches the boundary and the cookie still comes back.

Which instructions a JIT has to lower its own way -- a bpf_throw(), a
resume, the head and the body of a pad -- it reads from insn_aux_data,
which bpf_int_jit_compile() already has and which instruction patching
keeps in step. A subprogram's instructions are indexed from its
aux->subprog_start.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  88 ++++++++++++++++++++++
 include/linux/bpf_verifier.h |   1 +
 include/linux/filter.h       |   1 +
 kernel/bpf/core.c            |  30 +++++++-
 kernel/bpf/exception.c       | 141 +++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |   7 ++
 kernel/bpf/fixups.c          |  65 ++++++++++++++++
 kernel/bpf/helpers.c         |  34 +++++++++
 8 files changed, 364 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e7c5e203eddd..c11dc224973e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1787,6 +1787,93 @@ enum bpf_sig_keyring {
 	BPF_SIG_KEYRING_BPF,
 };
=20
+/*
+ * One cleanup region of a JITed (sub)program: @pad is the landing pad t=
o run
+ * for a return address in (begin, end], the native code of its call sit=
es.
+ */
+struct bpf_cleanup_range {
+	u64 begin;
+	u64 end;
+	u64 pad;
+};
+
+struct bpf_exception_info {
+	struct bpf_cleanup_info *info;
+	struct bpf_cleanup_range *ranges;
+	u32 nr_info;
+	u32 nr_ranges;
+	/* Set if any instruction of this subprogram calls bpf_throw(). */
+	bool has_throw;
+	/* Offset from a frame's FP to the caller's spilled r6-r9. */
+	s32 spill_off;
+	/* Likewise, to the registers a frame spills before calling bpf_throw()=
. */
+	s32 throw_spill_off;
+};
+
+#ifdef CONFIG_BPF_SYSCALL
+bool bpf_exc_force_spill(const struct bpf_prog *prog);
+bool bpf_exc_needs_throw_spill(const struct bpf_prog *prog);
+bool bpf_exc_insn_is_pad(const struct bpf_verifier_env *env,
+			 const struct bpf_prog *prog, u32 idx);
+bool bpf_exc_insn_in_pad(const struct bpf_verifier_env *env,
+			 const struct bpf_prog *prog, u32 idx);
+bool bpf_exc_insn_is_throw(const struct bpf_verifier_env *env,
+			   const struct bpf_prog *prog, u32 idx);
+bool bpf_exc_insn_is_resume(const struct bpf_verifier_env *env,
+			    const struct bpf_prog *prog, u32 idx);
+int bpf_exc_attach_main_prog(struct bpf_verifier_env *env, struct bpf_pr=
og *prog);
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image);
+void bpf_exc_free_info(struct bpf_prog_aux *aux);
+#else
+static inline bool bpf_exc_force_spill(const struct bpf_prog *prog)
+{
+	return false;
+}
+
+static inline bool bpf_exc_needs_throw_spill(const struct bpf_prog *prog=
)
+{
+	return false;
+}
+
+static inline bool bpf_exc_insn_is_pad(const struct bpf_verifier_env *en=
v,
+				       const struct bpf_prog *prog, u32 idx)
+{
+	return false;
+}
+
+static inline bool bpf_exc_insn_in_pad(const struct bpf_verifier_env *en=
v,
+				       const struct bpf_prog *prog, u32 idx)
+{
+	return false;
+}
+
+static inline bool bpf_exc_insn_is_throw(const struct bpf_verifier_env *=
env,
+					 const struct bpf_prog *prog, u32 idx)
+{
+	return false;
+}
+
+static inline bool bpf_exc_insn_is_resume(const struct bpf_verifier_env =
*env,
+					  const struct bpf_prog *prog, u32 idx)
+{
+	return false;
+}
+
+static inline int bpf_exc_attach_main_prog(struct bpf_verifier_env *env,
+					   struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static inline void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32=
 *addrs, void *image)
+{
+}
+
+static inline void bpf_exc_free_info(struct bpf_prog_aux *aux)
+{
+}
+#endif
+
 struct bpf_prog_aux {
 	atomic64_t refcnt;
 	u32 used_map_cnt;
@@ -1867,6 +1954,7 @@ struct bpf_prog_aux {
 	char name[BPF_OBJ_NAME_LEN];
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
+	struct bpf_exception_info *exc;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 736304d912af..500a1e253579 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -700,6 +700,7 @@ struct bpf_insn_aux_data {
 	u64 resume_call:1; /* call to bpf_unwind_resume() */
 	u64 in_cleanup_pad:1; /* runs with an exception in flight, in the pad's=
 frame */
 	u64 outside_cleanup_pad:1; /* ... and the other way round */
+	u64 cleanup_pad_head:1; /* first insn of a landing pad */
=20
 	/* below flags are initialized once */
 	u64 jmp_point:1;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 2582a7606e46..b0c495e94f74 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1243,6 +1243,7 @@ bool bpf_jit_supports_arena_args(void);
 bool bpf_jit_supports_far_kfunc_call(void);
 bool bpf_jit_supports_exceptions(void);
 bool bpf_jit_supports_cleanup_pads(void);
+void arch_bpf_run_cleanup_pad(u64 pad, u64 frame_fp, u64 spill_base);
 bool bpf_jit_supports_ptr_xchg(void);
 bool bpf_jit_supports_arena(void);
 bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index a379cd1ec4c6..16e5210a56d5 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -292,6 +292,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->dst_mutex);
 		mutex_destroy(&fp->aux->st_ops_assoc_mutex);
 		kfree(fp->aux->poke_tab);
+		bpf_exc_free_info(fp->aux);
 		kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
@@ -2625,13 +2626,21 @@ static bool bpf_prog_select_interpreter(struct bp=
f_prog *fp)
 	return select_interpreter;
 }
=20
-static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog)
+static struct bpf_prog *bpf_prog_jit_compile(struct bpf_verifier_env *en=
v, struct bpf_prog *prog,
+					     int *err)
 {
 #ifdef CONFIG_BPF_JIT
 	struct bpf_prog *orig_prog;
+	int ret;
=20
-	if (!bpf_prog_need_blind(prog))
+	if (!bpf_prog_need_blind(prog)) {
+		ret =3D bpf_exc_attach_main_prog(env, prog);
+		if (ret) {
+			*err =3D ret;
+			return prog;
+		}
 		return bpf_int_jit_compile(env, prog);
+	}
=20
 	orig_prog =3D prog;
 	prog =3D bpf_jit_blind_constants(env, prog);
@@ -2642,6 +2651,13 @@ static struct bpf_prog *bpf_prog_jit_compile(struc=
t bpf_verifier_env *env, struc
 	if (IS_ERR(prog))
 		goto out_restore;
=20
+	ret =3D bpf_exc_attach_main_prog(env, prog);
+	if (ret) {
+		*err =3D ret;
+		bpf_jit_prog_release_other(orig_prog, prog);
+		goto out_restore;
+	}
+
 	prog =3D bpf_int_jit_compile(env, prog);
 	if (prog->jited) {
 		bpf_jit_prog_release_other(prog, orig_prog);
@@ -2681,8 +2697,10 @@ struct bpf_prog *__bpf_prog_select_runtime(struct =
bpf_verifier_env *env, struct
 		if (*err)
 			return fp;
=20
-		fp =3D bpf_prog_jit_compile(env, fp);
+		fp =3D bpf_prog_jit_compile(env, fp, err);
 		bpf_prog_jit_attempt_done(fp);
+		if (*err)
+			return fp;
 		if (!fp->jited && jit_needed) {
 			*err =3D -ENOTSUPP;
 			return fp;
@@ -3480,6 +3498,12 @@ bool __weak bpf_jit_supports_cleanup_pads(void)
 	return false;
 }
=20
+/* Call @pad with the frame pointer @frame_fp and r6-r9 spilled at @spil=
l_base. */
+void __weak arch_bpf_run_cleanup_pad(u64 pad, u64 frame_fp, u64 spill_ba=
se)
+{
+	WARN_ON_ONCE(1);
+}
+
 bool __weak bpf_jit_supports_timed_may_goto(void)
 {
 	return false;
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 3aafbb612e7f..28aba6788847 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -1,11 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/bpf_verifier.h>
+#include <linux/bsearch.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
@@ -185,3 +188,141 @@ int bpf_exc_pad_of_call(struct bpf_verifier_env *en=
v, u32 idx)
=20
 	return pad ? (int)pad - 1 : -1;
 }
+
+/*
+ * Every subprogram of a cleanup-carrying program spills the BPF callee-=
saved
+ * registers, even one that never throws: a frame's spill holds its call=
er's
+ * registers, and that is what the walker restores before running the ca=
ller's
+ * pad. The exception callback does not, because it reuses the boundary =
frame
+ * rather than building one of its own.
+ */
+bool bpf_exc_force_spill(const struct bpf_prog *prog)
+{
+	return prog->aux->exc && !prog->aux->exception_cb;
+}
+
+bool bpf_exc_needs_throw_spill(const struct bpf_prog *prog)
+{
+	return bpf_exc_force_spill(prog) && prog->aux->exc->has_throw;
+}
+
+const struct bpf_cleanup_range *bpf_exc_pad_for_ip(const struct bpf_prog=
 *prog, u64 ip)
+{
+	const struct bpf_exception_info *exc =3D prog->aux->exc;
+	u32 l =3D 0, r =3D exc ? exc->nr_ranges : 0;
+
+	while (l < r) {
+		u32 m =3D l + (r - l) / 2;
+		const struct bpf_cleanup_range *rec =3D &exc->ranges[m];
+
+		if (ip <=3D rec->begin)
+			r =3D m;
+		else if (ip > rec->end)
+			l =3D m + 1;
+		else
+			return rec;
+	}
+	return NULL;
+}
+
+int bpf_exc_alloc_info(struct bpf_prog_aux *aux)
+{
+	if (aux->exc)
+		return 0;
+	aux->exc =3D kzalloc_obj(struct bpf_exception_info, GFP_KERNEL_ACCOUNT =
| __GFP_NOWARN);
+	return aux->exc ? 0 : -ENOMEM;
+}
+
+int bpf_exc_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_inf=
o *recs, u32 cnt)
+{
+	struct bpf_exception_info *exc =3D aux->exc;
+	struct bpf_cleanup_range *ranges;
+
+	ranges =3D kvcalloc(cnt, sizeof(*ranges), GFP_KERNEL_ACCOUNT | __GFP_NO=
WARN);
+	if (!ranges) {
+		kvfree(recs);
+		return -ENOMEM;
+	}
+
+	exc->info =3D recs;
+	exc->nr_info =3D cnt;
+	exc->ranges =3D ranges;
+	/* Withheld until the JIT has filled the table in. */
+	exc->nr_ranges =3D 0;
+	return 0;
+}
+
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image)
+{
+	struct bpf_exception_info *exc =3D prog->aux->exc;
+	u32 i, n;
+
+	if (!exc || !exc->nr_info || !exc->ranges)
+		return;
+
+	n =3D exc->nr_info;
+	for (i =3D 0; i < n; i++) {
+		const struct bpf_cleanup_info *rec =3D &exc->info[i];
+
+		if (WARN_ON_ONCE(rec->begin_off >=3D prog->len ||
+				 rec->end_off > prog->len ||
+				 rec->landing_pad_off >=3D prog->len))
+			return;
+		exc->ranges[i].begin =3D (u64)(long)image + addrs[rec->begin_off];
+		exc->ranges[i].end =3D (u64)(long)image + addrs[rec->end_off];
+		exc->ranges[i].pad =3D (u64)(long)image + addrs[rec->landing_pad_off];
+	}
+	exc->nr_ranges =3D n;
+}
+
+void bpf_exc_free_info(struct bpf_prog_aux *aux)
+{
+	struct bpf_exception_info *exc =3D aux->exc;
+
+	if (!exc)
+		return;
+	kvfree(exc->ranges);
+	kvfree(exc->info);
+	kfree(exc);
+	aux->exc =3D NULL;
+}
+
+static const struct bpf_insn_aux_data *subprog_insn_aux(const struct bpf=
_verifier_env *env,
+							const struct bpf_prog *prog, u32 idx)
+{
+	if (!env || !prog->aux->exc)
+		return NULL;
+	return &env->insn_aux_data[idx + prog->aux->subprog_start];
+}
+
+bool bpf_exc_insn_is_pad(const struct bpf_verifier_env *env,
+			 const struct bpf_prog *prog, u32 idx)
+{
+	const struct bpf_insn_aux_data *aux =3D subprog_insn_aux(env, prog, idx=
);
+
+	return aux && aux->cleanup_pad_head;
+}
+
+bool bpf_exc_insn_is_throw(const struct bpf_verifier_env *env,
+			   const struct bpf_prog *prog, u32 idx)
+{
+	const struct bpf_insn_aux_data *aux =3D subprog_insn_aux(env, prog, idx=
);
+
+	return aux && aux->throw_call;
+}
+
+bool bpf_exc_insn_is_resume(const struct bpf_verifier_env *env,
+			    const struct bpf_prog *prog, u32 idx)
+{
+	const struct bpf_insn_aux_data *aux =3D subprog_insn_aux(env, prog, idx=
);
+
+	return aux && aux->resume_call;
+}
+
+bool bpf_exc_insn_in_pad(const struct bpf_verifier_env *env,
+			 const struct bpf_prog *prog, u32 idx)
+{
+	const struct bpf_insn_aux_data *aux =3D subprog_insn_aux(env, prog, idx=
);
+
+	return aux && aux->in_cleanup_pad;
+}
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index 0872a3f70583..7a4bfc201e1c 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -5,6 +5,10 @@
=20
 #include <linux/types.h>
=20
+struct bpf_cleanup_info;
+struct bpf_cleanup_range;
+struct bpf_prog;
+struct bpf_prog_aux;
 struct bpf_insn;
 struct bpf_verifier_env;
=20
@@ -12,5 +16,8 @@ int bpf_prepare_cleanup_exceptions(struct bpf_verifier_=
env *env);
 int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
 int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
+int bpf_exc_alloc_info(struct bpf_prog_aux *aux);
+int bpf_exc_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_inf=
o *recs, u32 cnt);
+const struct bpf_cleanup_range *bpf_exc_pad_for_ip(const struct bpf_prog=
 *prog, u64 ip);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 53a737c88dcc..02e65c57bf0a 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/bpf_verifier.h>
@@ -10,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <net/xdp.h>
 #include "disasm.h"
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -1126,6 +1128,61 @@ static void bpf_restore_subprog_starts(struct bpf_=
verifier_env *env, u32 *orig_s
 	env->subprog_info[env->subprog_cnt].start =3D env->prog->len;
 }
=20
+static int exc_info_for_subprog(struct bpf_verifier_env *env, struct bpf=
_prog *sub,
+				u32 start, u32 end)
+{
+	struct bpf_cleanup_info *recs;
+	u32 i, cnt =3D 0;
+	int err;
+
+	if (!env->cleanup_info_cnt)
+		return 0;
+
+	err =3D bpf_exc_alloc_info(sub->aux);
+	if (err)
+		return err;
+
+	for (i =3D start; i < end; i++) {
+		if (env->insn_aux_data[i].throw_call)
+			sub->aux->exc->has_throw =3D true;
+		if (env->insn_aux_data[i].cleanup_pad)
+			cnt++;
+	}
+	if (!cnt)
+		return 0;
+
+	recs =3D kvmalloc_array(cnt, sizeof(*recs), GFP_KERNEL_ACCOUNT | __GFP_=
NOWARN);
+	if (!recs)
+		return -ENOMEM;
+
+	for (i =3D start, cnt =3D 0; i < end; i++) {
+		u32 pad =3D env->insn_aux_data[i].cleanup_pad;
+
+		if (!pad)
+			continue;
+		pad--;
+		if (verifier_bug_if(pad < start || pad >=3D end, env,
+				    "insn %u is covered by a landing pad at %u outside its subprog [=
%u, %u)",
+				    i, pad, start, end)) {
+			kvfree(recs);
+			return -EFAULT;
+		}
+		env->insn_aux_data[pad].cleanup_pad_head =3D true;
+		recs[cnt].begin_off =3D i - start;
+		recs[cnt].end_off =3D i - start + 1;
+		recs[cnt].landing_pad_off =3D pad - start;
+		cnt++;
+	}
+	return bpf_exc_attach_info(sub->aux, recs, cnt);
+}
+
+int bpf_exc_attach_main_prog(struct bpf_verifier_env *env, struct bpf_pr=
og *prog)
+{
+	if (!env || env->subprog_cnt > 1)
+		return 0;
+	return exc_info_for_subprog(env, prog, 0, prog->len);
+}
+
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
@@ -1263,6 +1320,10 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
+		err =3D exc_info_for_subprog(env, func[i], subprog_start,
+					   subprog_end);
+		if (err)
+			goto out_free;
 		func[i] =3D bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err =3D -ENOTSUPP;
@@ -1367,6 +1428,8 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	prog->aux->bpf_exception_cb =3D (void *)func[env->exception_callback_su=
bprog]->bpf_func;
 	prog->aux->exception_boundary =3D func[0]->aux->exception_boundary;
 	prog->aux->stack_arg_sp_adjust =3D func[0]->aux->stack_arg_sp_adjust;
+	prog->aux->exc =3D func[0]->aux->exc;
+	func[0]->aux->exc =3D NULL;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
@@ -1947,6 +2010,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env=
)
 			goto next_insn;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 			goto next_insn;
+		if (env->insn_aux_data[i + delta].resume_call)
+			goto next_insn;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
 			ret =3D bpf_fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 5eadab4dfa3f..03af739b9909 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -31,6 +31,7 @@
 #include <linux/buildid.h>
=20
 #include "../../lib/kstrtox.h"
+#include "exception.h"
=20
 /* If kernel subsystem is allowing eBPF programs to call this function,
  * inside its own verifier_ops->get_func_proto() callback it should retu=
rn
@@ -3398,8 +3399,36 @@ struct bpf_throw_ctx {
 	u64 sp;
 	u64 bp;
 	int cnt;
+	const struct bpf_prog *callee;
+	u64 callee_fp;
 };
=20
+static void bpf_run_cleanup_pad(struct bpf_throw_ctx *ctx, const struct =
bpf_prog *prog,
+				u64 ip, u64 fp)
+{
+	const struct bpf_exception_info *exc =3D prog->aux->exc;
+	const struct bpf_cleanup_range *rec;
+	u64 spill_base;
+
+	if (!exc || !exc->nr_ranges)
+		return;
+	rec =3D bpf_exc_pad_for_ip(prog, ip);
+	if (!rec)
+		return;
+
+	/*
+	 * The callee is always another subprogram of this program -- the walk
+	 * ends at any frame that is not one -- so its prologue spilled these
+	 * registers and its exc is there to say where.
+	 */
+	if (ctx->callee)
+		spill_base =3D ctx->callee_fp + ctx->callee->aux->exc->spill_off;
+	else
+		spill_base =3D fp + exc->throw_spill_off;
+
+	arch_bpf_run_cleanup_pad(rec->pad, fp, spill_base);
+}
+
 static bool bpf_stack_walker(void *cookie, u64 ip, u64 sp, u64 bp)
 {
 	struct bpf_throw_ctx *ctx =3D cookie;
@@ -3416,6 +3445,11 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
 	if (!prog)
 		return !ctx->cnt;
 	ctx->cnt++;
+
+	bpf_run_cleanup_pad(ctx, prog, ip, bp);
+	ctx->callee =3D prog;
+	ctx->callee_fp =3D bp;
+
 	if (bpf_is_subprog(prog))
 		return true;
 	ctx->aux =3D prog->aux;
--=20
2.53.0-Meta

