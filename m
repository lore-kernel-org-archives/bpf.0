Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025B38C426
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398872; cv=none; b=EcFeiXCNcki9Em3WlgbBWsXfxPMjOtVJ8kFas69OPi53WrhaPFv3+leyw6eUADX7HSFBFnN+uvZ8g0UG3GR/oSt42I5Q9GqR9IzRx1VpHZ3ZkvoQ3IvX1fb/knP2P5QMtYmlDq7lLIfDbiVecfxNEvVoggoQDcqWkXBNqw3kPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398872; c=relaxed/simple;
	bh=Jt+sl1QfaHCJmaR0ZGzZliydo0/sRqJkxq6sKcPM/FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzY/oEfZOnCTHs+RGo7iLLDzsIsQojKLCKJgq/ta6eX7cUoQFaemE6sPEZmu87ABY43foJKFI5nUBkt7bpFg04UTjvuf5gBv4ChXJLkLpJ8F2AicvOm0wOyVlxYq2MKkczTfYXsAS8RwhyOKFGzH33pF3lVQGnjE+kj8R38P2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 936482D4590A1A; Fri, 25 Sep 2026 22:00:57 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 10/21] bpf: Dispatch cleanup pads by rewriting return addresses
Date: Fri, 25 Sep 2026 22:00:57 -0700
Message-ID: <20260926050057.2217436-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260926050006.2213110-1-yonghong.song@linux.dev>
References: <20260926050006.2213110-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

bpf_unwind() walks the BPF frames and, for each one, rewrites the saved
return address so that the frame resumes where the unwind needs it, then
returns. Nothing restores a register: every frame runs its own epilogue o=
n
the way out, which is what puts its caller's r6-r9 back, so the unwind
needs no spill area and no per-frame metadata beyond the table itself.

Two things a frame can be:

  - a record covers the call it is suspended at: resume at that pad, whic=
h
    the previous patch has made sure ends in a resume
  - nothing covers it: resume at the frame's epilogue, so it returns at
    once and its caller is reached with its registers already restored

The second needs an epilogue to exist. A frame need not carry a table of
its own to be on the path, so aux->epilogue_ip is recorded for every
program, and handed to the outer program along with the table when
jit_subprogs() compiles the main program as func[0]. And a frame whose on=
ly
exit followed the bpf_unwind() call loses it to the dead code sweep, so a=
n
exit is patched back in after every such call. That exit doubles as the
answer for the frame that called bpf_unwind() with no record over the cal=
l:
its return address already names the patched 'r0 =3D 0; exit', so the wal=
k
leaves that one alone and the unwind returns zero. A pad's own resume is
lowered to the same thing, so the frame returns and the rewritten address
carries the unwind to the next pad.

arch_bpf_stack_walk_ra() is the walk that also hands out the return-addre=
ss
slot. It is a second entry point rather than a change to
arch_bpf_stack_walk(), so that the architectures which do not dispatch pa=
ds
keep the walker they have.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  45 ++++++++++++++
 include/linux/bpf_verifier.h |   2 +
 include/linux/filter.h       |   2 +
 kernel/bpf/core.c            |  20 +++++-
 kernel/bpf/exception.c       | 102 +++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |   7 +++
 kernel/bpf/fixups.c          | 115 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  45 ++++++++++++++
 kernel/bpf/verifier.c        |   3 +
 9 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f..98de251037df 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1805,6 +1805,49 @@ enum bpf_sig_keyring {
 	BPF_SIG_KEYRING_BPF,
 };
=20
+/* One cleanup region of a JITed (sub)program. */
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
+};
+
+#ifdef CONFIG_BPF_SYSCALL
+bool bpf_exc_insn_is_pad(const struct bpf_verifier_env *env,
+			 const struct bpf_prog *prog, u32 idx);
+int bpf_exc_attach_main_prog(struct bpf_verifier_env *env, struct bpf_pr=
og *prog);
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image);
+void bpf_exc_free_info(struct bpf_prog_aux *aux);
+#else
+
+static inline bool bpf_exc_insn_is_pad(const struct bpf_verifier_env *en=
v,
+				       const struct bpf_prog *prog, u32 idx)
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
@@ -1885,6 +1928,8 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	struct bpf_exception_info *exc;
+	u64 epilogue_ip; /* native address of this (sub)program's epilogue */
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4174c7d0177e..1803225feb13 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -702,6 +702,7 @@ struct bpf_insn_aux_data {
 	u64 jump_target:1;
 	u64 in_cleanup_pad:1; /* reached with a landing pad running */
 	u64 outside_cleanup_pad:1; /* ... and the other way round */
+	u64 cleanup_pad_head:1; /* first insn of a landing pad */
=20
 	unsigned int orig_idx; /* original instruction index, initialized once =
*/
 	/*
@@ -1843,6 +1844,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ve=
rifier_env *env, const union
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
+int bpf_exc_keep_exits(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
=20
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 972b3ed2a51d..0d7d949a1baa 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1290,6 +1290,8 @@ u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg=
_abi *abi,
 			   struct bpf_jit_arg_move *moves);
 u64 bpf_arch_uaddress_limit(void);
 void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
+void arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 ip, u64=
 sp, u64 bp, u64 *ra),
+			    void *cookie);
 u64 arch_bpf_timed_may_goto(void);
 u64 bpf_check_timed_may_goto(struct bpf_timed_may_goto *);
 bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d813fdde29e3..60905643cb9c 100644
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
@@ -2632,9 +2633,14 @@ static struct bpf_prog *bpf_prog_jit_compile(struc=
t bpf_verifier_env *env, struc
 {
 #ifdef CONFIG_BPF_JIT
 	struct bpf_prog *orig_prog;
+	int ret;
=20
-	if (!bpf_prog_need_blind(prog))
+	if (!bpf_prog_need_blind(prog)) {
+		ret =3D bpf_exc_attach_main_prog(env, prog);
+		if (ret)
+			return ERR_PTR(ret);
 		return bpf_int_jit_compile(env, prog);
+	}
=20
 	orig_prog =3D prog;
 	prog =3D bpf_jit_blind_constants(env, prog);
@@ -2648,6 +2654,12 @@ static struct bpf_prog *bpf_prog_jit_compile(struc=
t bpf_verifier_env *env, struc
 		goto out_restore;
 	}
=20
+	ret =3D bpf_exc_attach_main_prog(env, prog);
+	if (ret) {
+		bpf_jit_prog_release_other(orig_prog, prog);
+		return ERR_PTR(ret);
+	}
+
 	prog =3D bpf_int_jit_compile(env, prog);
 	if (prog->jited) {
 		bpf_jit_prog_release_other(prog, orig_prog);
@@ -3511,6 +3523,12 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
(void *cookie, u64 ip, u64 sp,
 {
 }
=20
+void __weak arch_bpf_stack_walk_ra(bool (*consume_fn)(void *cookie, u64 =
ip, u64 sp, u64 bp,
+						      u64 *ra),
+				   void *cookie)
+{
+}
+
 bool __weak bpf_jit_supports_cleanup_pads(void)
 {
 	return false;
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index 86fdf847d33e..c4af82c103d7 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -5,6 +5,7 @@
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
+#include <linux/slab.h>
 #include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
@@ -156,3 +157,104 @@ int bpf_exc_pad_of_call(struct bpf_verifier_env *en=
v, u32 idx)
=20
 	return pad ? (int)pad - 1 : -1;
 }
+
+/*
+ * The record covering @ip, which is a return address: the call it belon=
gs to
+ * is the instruction before it, so a range matches on begin < ip <=3D e=
nd.
+ */
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
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index f3aff0fe8ecc..025d67dfa925 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -7,10 +7,17 @@
=20
 struct bpf_verifier_env;
 struct bpf_insn;
+struct bpf_cleanup_info;
+struct bpf_cleanup_range;
+struct bpf_prog;
+struct bpf_prog_aux;
=20
 int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
 int bpf_exc_pad_of_call(struct bpf_verifier_env *env, u32 idx);
 int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
 int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
+int bpf_exc_alloc_info(struct bpf_prog_aux *aux);
+int bpf_exc_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_inf=
o *recs, u32 cnt);
+const struct bpf_cleanup_range *bpf_exc_pad_for_ip(const struct bpf_prog=
 *prog, u64 ip);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 5b7fe4ba610b..c93a0311d1ea 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+#include <linux/bitmap.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/bpf_verifier.h>
@@ -11,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -1286,6 +1288,62 @@ static int resolve_func_ptrs(struct bpf_verifier_e=
nv *env, struct bpf_prog *prog
 	return 0;
 }
=20
+static int exc_info_for_subprog(struct bpf_verifier_env *env, struct bpf=
_prog *sub,
+				u32 subprog, u32 start, u32 end)
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
+	err =3D bpf_exc_attach_info(sub->aux, recs, cnt);
+	if (err)
+		return err;
+	return 0;
+}
+
+int bpf_exc_attach_main_prog(struct bpf_verifier_env *env, struct bpf_pr=
og *prog)
+{
+	if (!env || env->subprog_cnt > 1)
+		return 0;
+	return exc_info_for_subprog(env, prog, 0, 0, prog->len);
+}
+
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
@@ -1423,6 +1481,10 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
+		err =3D exc_info_for_subprog(env, func[i], i, subprog_start,
+					   subprog_end);
+		if (err)
+			goto out_free;
 		func[i] =3D bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err =3D -ENOTSUPP;
@@ -1532,6 +1594,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	prog->aux->bpf_exception_cb =3D (void *)func[env->exception_callback_su=
bprog]->bpf_func;
 	prog->aux->exception_boundary =3D func[0]->aux->exception_boundary;
 	prog->aux->stack_arg_sp_adjust =3D func[0]->aux->stack_arg_sp_adjust;
+	prog->aux->exc =3D func[0]->aux->exc;
+	func[0]->aux->exc =3D NULL;
+	prog->aux->epilogue_ip =3D func[0]->aux->epilogue_ip;
 	bpf_prog_jit_attempt_done(prog);
 	return 0;
 out_free:
@@ -1757,6 +1822,37 @@ static int may_goto_expand(struct bpf_insn *insn_b=
uf, int off, int stack_off,
 	return cnt + tail_cnt;
 }
=20
+/*
+ * Put an exit back after every bpf_unwind() call. Nothing reaches it, b=
ut it
+ * keeps the frame's epilogue, which is where the unwind sends a frame t=
hat
+ * has no landing pad.
+ */
+int bpf_exc_keep_exits(struct bpf_verifier_env *env)
+{
+	int insn_cnt =3D env->prog->len;
+	struct bpf_insn insn_buf[3];
+	struct bpf_prog *new_prog;
+	int i, delta =3D 0;
+
+	for (i =3D 0; i < insn_cnt; i++) {
+		struct bpf_insn *insn =3D env->prog->insnsi + i + delta;
+
+		if (!bpf_is_unwind_kfunc(insn))
+			continue;
+
+		insn_buf[0] =3D *insn;
+		insn_buf[1] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
+		insn_buf[2] =3D BPF_EXIT_INSN();
+
+		new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, 3);
+		if (!new_prog)
+			return -ENOMEM;
+		delta +=3D 2;
+		env->prog =3D new_prog;
+	}
+	return 0;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
@@ -2135,6 +2231,25 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
 			goto next_insn;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 			goto next_insn;
+		if (bpf_is_unwind_resume_kfunc(insn)) {
+			/*
+			 * A pad's resume is just the frame returning:
+			 * bpf_unwind() already pointed this frame's return
+			 * address at the next pad, so the ordinary epilogue
+			 * carries the unwind on. The verifier checked this exit
+			 * with r0 a known zero, so return zero.
+			 */
+			insn_buf[0] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
+			insn_buf[1] =3D BPF_EXIT_INSN();
+			cnt =3D 2;
+			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
+			if (!new_prog)
+				return -ENOMEM;
+			delta +=3D cnt - 1;
+			env->prog =3D prog =3D new_prog;
+			insn =3D new_prog->insnsi + i + delta;
+			goto next_insn;
+		}
 		if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
 			ret =3D bpf_fixup_kfunc_call(env, insn, insn_buf, i + delta, &cnt);
 			if (ret)
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f291611fe578..ea5c4d81f8b7 100644
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
@@ -3416,6 +3417,7 @@ static bool bpf_stack_walker(void *cookie, u64 ip, =
u64 sp, u64 bp)
 	if (!prog)
 		return !ctx->cnt;
 	ctx->cnt++;
+
 	if (bpf_is_subprog(prog))
 		return true;
 	ctx->aux =3D prog->aux;
@@ -3424,8 +3426,51 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
 	return false;
 }
=20
+struct bpf_unwind_ctx {
+	u32 cnt;
+};
+
+static bool bpf_unwind_rewrite(void *cookie, u64 ip, u64 sp, u64 bp, u64=
 *ra)
+{
+	const struct bpf_cleanup_range *rec;
+	struct bpf_unwind_ctx *ctx =3D cookie;
+	struct bpf_exception_info *exc;
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog =3D bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return !ctx->cnt;
+	ctx->cnt++;
+
+	exc =3D prog->aux->exc;
+	rec =3D (exc && exc->nr_ranges) ? bpf_exc_pad_for_ip(prog, ip) : NULL;
+	if (rec) {
+		*ra =3D rec->pad;
+	} else if (ctx->cnt =3D=3D 1) {
+		/*
+		 * The frame that called bpf_unwind(). Its return address
+		 * always names the 'r0 =3D 0; exit' that bpf_exc_keep_exits()
+		 * put after the call, so leave it alone and let the frame
+		 * return through that: running it is what sets the value
+		 * the unwind returns.
+		 */
+	} else if (prog->aux->epilogue_ip) {
+		*ra =3D prog->aux->epilogue_ip;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	return bpf_is_subprog(prog);
+}
+
 __bpf_kfunc void bpf_unwind(void)
 {
+	struct bpf_unwind_ctx ctx =3D {};
+
+	arch_bpf_stack_walk_ra(bpf_unwind_rewrite, &ctx);
 }
=20
 __bpf_kfunc void bpf_throw(u64 cookie)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 677bab92f624..f2a59716fdab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22781,6 +22781,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret =3D bpf_convert_ctx_accesses(env);
=20
+	if (ret =3D=3D 0)
+		ret =3D bpf_exc_keep_exits(env);
+
 	if (ret =3D=3D 0)
 		ret =3D bpf_do_misc_fixups(env);
=20
--=20
2.53.0-Meta

