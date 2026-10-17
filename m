Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB83AD516
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205547; cv=none; b=t2+fPOHc1R0OtbXFnker8bIVktg3K1YKUDQTUq5ppATG1zKmyeBD2GYS/5q+cVfP04uAIcj5lWVbJYA9yen22QLo0JfgzU89fQE6FjpxNtXiUyFgwOxrj7wcfePZT/rCR26EcIhiplsFTq4UC3nZBR1UB4T9p0ETAvoVyVY7WBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205547; c=relaxed/simple;
	bh=1YHNqIqlVc0xsNZ/9Dp7FyV+1gniIGC7PfOXDsBhaGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXnQaePfGyMFs4/tQoCqZilb387F0WGhcV4MxADRvOVKO90tWl3O9lbV1E3iXMNK5br3B+Gg41+z4GmzVfKTxBu6OIJNNIk67/1F5gzeoFA5UWia8KSZM/H9vLUoJWosHWukYz2lAIEjugPk5ANhbRoLpeTZEfCdNvDTfTN4QWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9678631B3AFEEA; Fri, 16 Oct 2026 19:52:22 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v12 10/25] bpf: Prepare JITed programs for dispatching cleanup pads
Date: Fri, 16 Oct 2026 19:52:22 -0700
Message-ID: <20261017025222.1922399-1-yonghong.song@linux.dev>
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

A following patch makes bpf_unwind() rewrite the saved return address
of each frame above its caller: to the pad covering the call, else to the
frame's epilogue. Every frame then just returns, its epilogue restoring
its caller's r6-r9. This patch adds most of what that relies on:

 - Each bpf_unwind() call is followed by 'r0 =3D 0' and a jump to its pad=
,
   or an exit: the walk leaves the calling frame alone.
 - A pad's resume lowers to 'r0 =3D 0; exit'.
 - Each JITed function gets a table of its covered calls as native
   address ranges, looked up by bpf_exc_pad_for_ip(). The main
   function's table, and its epilogue_ip, go to the outer program.
 - arch_bpf_stack_walk_ra() walks the stack handing out each
   return-address slot. Where an arch has only the weak stub, nothing is
   dispatched, so any program that can unwind, table or not, is now held
   to bpf_exc_check_prog().

The next patch makes sure that every function the walk can pass has an
epilogue.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  30 ++++++++++
 include/linux/bpf_verifier.h |   1 +
 include/linux/filter.h       |   2 +
 kernel/bpf/core.c            |   7 +++
 kernel/bpf/exception.c       |  77 +++++++++++++++++++++++++
 kernel/bpf/exception.h       |   6 ++
 kernel/bpf/fixups.c          | 106 ++++++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        |   5 +-
 8 files changed, 232 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 54144372281c..7f23f4efde01 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1841,6 +1841,34 @@ enum bpf_sig_keyring {
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
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image);
+void bpf_exc_free_info(struct bpf_prog_aux *aux);
+#else
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
@@ -1922,6 +1950,8 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	struct bpf_exception_info *exc;
+	u64 epilogue_ip; /* native address of this (sub)program's epilogue */
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 4ca943c37e3c..1c33b2cf29cf 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2003,6 +2003,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ve=
rifier_env *env, const union
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
+int bpf_exc_patch_unwind_calls(struct bpf_verifier_env *env);
 int bpf_do_misc_fixups(struct bpf_verifier_env *env);
 int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn);
=20
diff --git a/include/linux/filter.h b/include/linux/filter.h
index c8ca863e352a..a61a78675d11 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1291,6 +1291,8 @@ u32 bpf_jit_plan_arg_moves(const struct bpf_jit_arg=
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
index a5a5463449c1..3af8e8272691 100644
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
@@ -3524,6 +3525,12 @@ void __weak arch_bpf_stack_walk(bool (*consume_fn)=
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
index 5945fdf5f75c..e06f2606b41e 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -300,3 +300,80 @@ int bpf_exc_pad_of_call(struct bpf_verifier_env *env=
, u32 idx)
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
+int bpf_exc_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_inf=
o *recs, u32 cnt)
+{
+	struct bpf_cleanup_range *ranges;
+	struct bpf_exception_info *exc;
+
+	exc =3D kzalloc_obj(struct bpf_exception_info, GFP_KERNEL_ACCOUNT | __G=
FP_NOWARN);
+	ranges =3D kvcalloc(cnt, sizeof(*ranges), GFP_KERNEL_ACCOUNT | __GFP_NO=
WARN);
+	if (!exc || !ranges) {
+		kfree(exc);
+		kvfree(ranges);
+		kvfree(recs);
+		return -ENOMEM;
+	}
+
+	exc->info =3D recs;
+	exc->nr_info =3D cnt;
+	exc->ranges =3D ranges;
+	/* Withheld until the JIT has filled the table in. */
+	exc->nr_ranges =3D 0;
+	aux->exc =3D exc;
+	return 0;
+}
+
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image)
+{
+	struct bpf_exception_info *exc =3D prog->aux->exc;
+	u32 i, n;
+
+	if (!exc)
+		return;
+
+	n =3D exc->nr_info;
+	for (i =3D 0; i < n; i++) {
+		const struct bpf_cleanup_info *rec =3D &exc->info[i];
+
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
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index ecbca25dabef..09bbcd0a09de 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -9,6 +9,10 @@
 union bpf_attr;
 struct bpf_verifier_env;
 struct bpf_insn;
+struct bpf_cleanup_info;
+struct bpf_cleanup_range;
+struct bpf_prog;
+struct bpf_prog_aux;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
@@ -20,5 +24,7 @@ bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn);
 int bpf_exc_check_callback(struct bpf_verifier_env *env, int subprog);
 int bpf_exc_check_insn(struct bpf_verifier_env *env, struct bpf_insn *in=
sn);
+int bpf_exc_attach_info(struct bpf_prog_aux *aux, struct bpf_cleanup_inf=
o *recs, u32 cnt);
+const struct bpf_cleanup_range *bpf_exc_pad_for_ip(const struct bpf_prog=
 *prog, u64 ip);
=20
 #endif /* __BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index feb3b079dfbb..1970069d6957 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -9,6 +9,7 @@
 #include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -1273,6 +1274,40 @@ static int resolve_func_ptrs(struct bpf_verifier_e=
nv *env, struct bpf_prog *prog
 	return 0;
 }
=20
+static int exc_info_for_subprog(struct bpf_verifier_env *env, struct bpf=
_prog *sub,
+				u32 start, u32 end)
+{
+	struct bpf_cleanup_info *recs;
+	u32 i, cnt =3D 0;
+
+	if (!env->cleanup_info_cnt)
+		return 0;
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
+		recs[cnt].begin_off =3D i - start;
+		recs[cnt].end_off =3D i - start + 1;
+		recs[cnt].landing_pad_off =3D pad - start;
+		cnt++;
+	}
+	return bpf_exc_attach_info(sub->aux, recs, cnt);
+}
+
 static int jit_subprogs(struct bpf_verifier_env *env)
 {
 	struct bpf_prog *prog =3D env->prog, **func, *tmp;
@@ -1280,7 +1315,7 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 	struct bpf_map *map_ptr;
 	struct bpf_insn *insn;
 	void *old_bpf_func;
-	int err, num_exentries;
+	int err, exc_err, num_exentries;
=20
 	for (i =3D 0, insn =3D prog->insnsi; i < prog->len; i++, insn++) {
 		if (!bpf_pseudo_func(insn) && !bpf_pseudo_call(insn))
@@ -1410,6 +1445,11 @@ static int jit_subprogs(struct bpf_verifier_env *e=
nv)
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
+		exc_err =3D exc_info_for_subprog(env, func[i], subprog_start, subprog_=
end);
+		if (exc_err) {
+			err =3D exc_err;
+			goto out_free;
+		}
 		func[i] =3D bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err =3D -ENOTSUPP;
@@ -1519,6 +1559,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
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
@@ -1744,6 +1787,48 @@ static int may_goto_expand(struct bpf_insn *insn_b=
uf, int off, int stack_off,
 	return cnt + tail_cnt;
 }
=20
+/*
+ * Follow each bpf_unwind() call with 'r0 =3D 0; exit', or with
+ * 'r0 =3D 0; goto pad' where a record covers the call.
+ */
+int bpf_exc_patch_unwind_calls(struct bpf_verifier_env *env)
+{
+	int insn_cnt =3D env->prog->len;
+	struct bpf_insn insn_buf[3];
+	struct bpf_prog *new_prog;
+	int i, off, delta =3D 0;
+
+	if (!bpf_prog_may_unwind(env))
+		return 0;
+
+	for (i =3D 0; i < insn_cnt; i++) {
+		int call =3D i + delta, pad;
+		struct bpf_insn *insn =3D env->prog->insnsi + call;
+
+		if (!bpf_is_unwind_kfunc(insn))
+			continue;
+
+		insn_buf[0] =3D *insn;
+		insn_buf[1] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
+		insn_buf[2] =3D BPF_EXIT_INSN();
+		pad =3D bpf_exc_pad_of_call(env, call);
+		if (pad >=3D 0) {
+			/* The goto is at call + 2; a pad after the call moves down by 2. */
+			if (pad > call)
+				pad +=3D 2;
+			off =3D pad - (call + 3);
+			insn_buf[2] =3D off =3D=3D (s16)off ? BPF_JMP_A(off) : BPF_JMP32_A(of=
f);
+		}
+
+		new_prog =3D bpf_patch_insn_data(env, call, insn_buf, 3);
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
@@ -2136,6 +2221,25 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
 			goto next_insn;
 		if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
 			goto next_insn;
+		if (bpf_is_unwind_resume_kfunc(insn)) {
+			/*
+			 * A pad's resume is just the frame returning, to
+			 * where bpf_unwind() pointed its return address: its
+			 * caller's pad or epilogue, or the kernel from the main
+			 * program. The verifier checked this exit with r0 a
+			 * known zero, so return zero.
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
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c512ed5d1dc..85542afcc369 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23683,7 +23683,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 	if (ret)
 		goto skip_full_check;
=20
-	if (env->cleanup_info_cnt) {
+	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env)) {
 		ret =3D bpf_exc_check_prog(env);
 		if (ret)
 			goto skip_full_check;
@@ -23783,6 +23783,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret =3D bpf_convert_ctx_accesses(env);
=20
+	if (ret =3D=3D 0)
+		ret =3D bpf_exc_patch_unwind_calls(env);
+
 	if (ret =3D=3D 0)
 		ret =3D bpf_do_misc_fixups(env);
=20
--=20
2.53.0-Meta

