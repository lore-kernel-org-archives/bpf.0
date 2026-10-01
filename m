Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC44A3862
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861475; cv=none; b=Jw8Fkeyawr6aVYUkgL6yGXuag7mWL1gKLA8berOWxUVTaXPDtDDlnB1ta5GkTX62NFH4xgtN2S2LDkHD68zzg+v/Oy0H52MXZxRaJ3QQQHVgIUmOTPLyYjNGaVO1oApaocY+cDJ7cgk51oId4VMVIL3i+2JhxHl2JyfFo+vQeaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861475; c=relaxed/simple;
	bh=FKnczfNIG5lLe8JCi8jsr3v//zcw0YQMyoYoQWxjIho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlFR71DMG0T9NBZ+QqbvQUjbeTRVlChoVIsxuhYLxrrAEuXFe/WU7jRS/L4FyAQNT1ZBl/HQFSm5ZOwoFHvhHhVJE9K0ZTnhtQS3sxgmKRrvwlfZPj81Ll0zxFuGKv7C6F7TaVPogYsQCPOoyPSyyjnP5+Im5br/BU+tTDWAZ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 253A02E6E0BCB3; Thu,  1 Oct 2026 06:31:03 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 11/22] bpf: Dispatch cleanup pads by rewriting return addresses
Date: Thu,  1 Oct 2026 06:31:03 -0700
Message-ID: <20261001133103.1340994-1-yonghong.song@linux.dev>
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

bpf_unwind() walks the BPF frames and, for each one above the frame that
called it, rewrites the saved return address so the frame resumes where
the unwind needs it, then returns. The frame that called it goes on after
the call, where the fixups put 'r0 =3D 0' and then a jump to its pad, or =
an
exit where no record covers the call, so the pad starts with r0 at a know=
n
zero rather than whatever bpf_unwind() left in the return register.
bpf_unwind() restores no register itself: every frame runs its own
epilogue on the way out, which is what puts its caller's r6-r9 back, so
the unwind needs no spill area and no per-frame metadata beyond the table
itself.

Where a record covers the call a frame is suspended at, it resumes at tha=
t
pad, which an earlier patch made sure ends in a resume. Where none does,
it resumes at the frame's epilogue and returns at once, its caller reache=
d
with registers already restored. A pad's resume lowers to 'r0 =3D 0; exit=
',
so that frame returns too and the rewritten address carries the unwind on
to the next pad.

For the verifier patch's example, main -> A -> B -> C with only A's call
to B covered, bpf_unwind() in C rewrites the return addresses it finds:

  slot                    points into               rewritten to
  ----------------------  ------------------------  ---------------------
  bpf_unwind()'s return   C, after its unwind call  left alone
  C's return              B, after 'call C'         B's epilogue
  B's return              A, after 'call B'         P, A's pad
  A's return              main, after 'call A'      main's epilogue
  main's return           the kernel                left alone

Each address is looked up in the frame it points into: a record over that
call gives its pad, none gives that frame's epilogue. Then every frame
just returns:

  frame   runs
  -----   ----------------------------------------------------------
  C       'r0 =3D 0; exit', patched in after its bpf_unwind()
  B       its epilogue, putting back A's r6-r9
  A       P, which drops A's resources; its resume is 'r0 =3D 0; exit'
  main    its epilogue, returning 0 to the kernel

An epilogue therefore has to exist for every frame the walk can pass, not
only for those carrying a table: the JITs record aux->epilogue_ip for eve=
ry
program in the patches that follow, and this one hands it to the outer
program with the table when jit_subprogs() compiles the main program as
func[0].

x86 emits the epilogue at a subprogram's first exit, so one the dead code
sweep leaves exitless gets none. Two shapes do that. The frame that calle=
d
bpf_unwind() loses the code after the call; the exit patched back in ther=
e
where no record covers the call is also what that frame returns through.
And a frame above one that never comes back loses its exit with
no bpf_unwind() to hang a new one on, so the last exit of every subprogra=
m
an unwind can pass through is kept, searched for since a subprogram may
end in a jump or a gotox. One with no exit at all is refused: nothing is
left an epilogue could be emitted at. arm64 emits an epilogue either way.

Both kfuncs become callable here rather than earlier: until the walk and
the lowering exist, bpf_unwind() would return to instructions the verifie=
r
never explored and bpf_unwind_resume() would reach its WARN_ONCE body.

arch_bpf_stack_walk_ra() hands out the return-address slot as well as the
address. It is a second entry point rather than a change to
arch_bpf_stack_walk(), so architectures that do not dispatch pads keep th=
e
walker they have -- where it is the weak stub, the walk does nothing, so
process_bpf_unwind() now asks bpf_exc_check_prog() whether this program m=
ay
unwind at all. A cleanup table was held to that before the CFG walk; a
bpf_unwind() with no table had not been.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf.h          |  37 ++++++++++
 include/linux/bpf_verifier.h |   1 +
 include/linux/filter.h       |   2 +
 kernel/bpf/core.c            |  20 ++++-
 kernel/bpf/exception.c       |  86 ++++++++++++++++++++++
 kernel/bpf/exception.h       |   6 ++
 kernel/bpf/fixups.c          | 138 +++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c         |  45 ++++++++++++
 kernel/bpf/verifier.c        |   7 ++
 9 files changed, 341 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4bae3796c42f..94005cd3ad0f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1805,6 +1805,41 @@ enum bpf_sig_keyring {
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
+int bpf_exc_attach_main_prog(struct bpf_verifier_env *env, struct bpf_pr=
og *prog);
+void bpf_exc_fill_native_ranges(struct bpf_prog *prog, u32 *addrs, void =
*image);
+void bpf_exc_free_info(struct bpf_prog_aux *aux);
+#else
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
@@ -1885,6 +1920,8 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	struct bpf_exception_info *exc;
+	u64 epilogue_ip; /* native address of this (sub)program's epilogue */
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index ccac422737fb..7cede13f8bee 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1863,6 +1863,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ve=
rifier_env *env, const union
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
+int bpf_exc_patch_unwind_calls(struct bpf_verifier_env *env);
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
index e824883d3981..bbe64887e069 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -402,3 +402,89 @@ int bpf_exc_pad_of_call(struct bpf_verifier_env *env=
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
+		/*
+		 * exc_info_for_subprog() built the records from insn_aux_data
+		 * inside this subprog, so this cannot fire; if it does, no
+		 * pad is dispatched rather than one read past addrs[].
+		 */
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
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index e72e68ebfe85..b97ac04785c3 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -11,6 +11,10 @@ struct bpf_verifier_env;
 struct bpf_verifier_state;
 struct bpf_func_state;
 struct bpf_insn;
+struct bpf_cleanup_info;
+struct bpf_cleanup_range;
+struct bpf_prog;
+struct bpf_prog_aux;
=20
 int bpf_exc_check_info(struct bpf_verifier_env *env, const union bpf_att=
r *attr,
 		       bpfptr_t uattr);
@@ -25,5 +29,7 @@ bool bpf_is_unwind_kfunc(const struct bpf_insn *insn);
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
index 5b7fe4ba610b..fc1d98eddf36 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -11,6 +11,7 @@
 #include <linux/sched/signal.h>
 #include <net/xdp.h>
 #include "disasm.h"
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -739,6 +740,32 @@ static void keep_funcs_with_addr_taken(struct bpf_ve=
rifier_env *env)
 	}
 }
=20
+static int keep_subprog_exits(struct bpf_verifier_env *env)
+{
+	u32 i, j;
+
+	for (i =3D 0; i < env->subprog_cnt; i++) {
+		bool found =3D false;
+		u32 start;
+
+		if (!env->subprog_info[i].might_unwind)
+			continue;
+		start =3D env->subprog_info[i].start;
+		for (j =3D env->subprog_info[i + 1].start; j-- > start; ) {
+			if (env->prog->insnsi[j].code !=3D (BPF_JMP | BPF_EXIT))
+				continue;
+			env->insn_aux_data[j].seen =3D env->pass_cnt;
+			found =3D true;
+			break;
+		}
+		if (!found) {
+			verbose(env, "subprog %u can be unwound through but has no exit\n", i=
);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env)
 {
 	struct bpf_insn_aux_data *aux_data =3D env->insn_aux_data;
@@ -746,6 +773,9 @@ int bpf_opt_remove_dead_code(struct bpf_verifier_env =
*env)
 	int i, err;
=20
 	keep_funcs_with_addr_taken(env);
+	err =3D keep_subprog_exits(env);
+	if (err)
+		return err;
=20
 	for (i =3D 0; i < insn_cnt; i++) {
 		int j;
@@ -1286,6 +1316,53 @@ static int resolve_func_ptrs(struct bpf_verifier_e=
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
+		if (verifier_bug_if(pad < start || pad >=3D end, env,
+				    "insn %u is covered by a landing pad at %u outside its subprog [=
%u, %u)",
+				    i, pad, start, end)) {
+			kvfree(recs);
+			return -EFAULT;
+		}
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
@@ -1423,6 +1500,8 @@ static int jit_subprogs(struct bpf_verifier_env *en=
v)
 		func[i]->aux->token =3D prog->aux->token;
 		if (!i)
 			func[i]->aux->exception_boundary =3D env->seen_exception;
+		if (exc_info_for_subprog(env, func[i], subprog_start, subprog_end))
+			goto out_free;
 		func[i] =3D bpf_int_jit_compile(env, func[i]);
 		if (!func[i]->jited) {
 			err =3D -ENOTSUPP;
@@ -1532,6 +1611,9 @@ static int jit_subprogs(struct bpf_verifier_env *en=
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
@@ -1757,6 +1839,43 @@ static int may_goto_expand(struct bpf_insn *insn_b=
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
+	for (i =3D 0; i < insn_cnt; i++) {
+		struct bpf_insn *insn =3D env->prog->insnsi + i + delta;
+		u32 pad =3D env->insn_aux_data[i + delta].cleanup_pad;
+
+		if (!bpf_is_unwind_kfunc(insn))
+			continue;
+
+		insn_buf[0] =3D *insn;
+		insn_buf[1] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
+		insn_buf[2] =3D BPF_EXIT_INSN();
+		if (pad) {
+			/* Stored as index + 1; a pad after the call moves with it. */
+			pad--;
+			off =3D (pad > i + delta ? pad + 2 : pad) - (i + delta + 3);
+			insn_buf[2] =3D off =3D=3D (s16)off ? BPF_JMP_A(off) : BPF_JMP32_A(of=
f);
+		}
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
@@ -2135,6 +2254,25 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
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
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4eccd6742eba..c6894d6185ab 100644
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
@@ -3424,8 +3425,50 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
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
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog =3D bpf_prog_ksym_find(ip);
+	rcu_read_unlock();
+	if (!prog)
+		return !ctx->cnt;
+	ctx->cnt++;
+
+	/*
+	 * The frame that called bpf_unwind(): bpf_exc_patch_unwind_calls()
+	 * put 'r0 =3D 0' and a jump to its pad, or an exit, after the call,
+	 * so leave its return address alone and let it go on there. The pad
+	 * then starts with r0 at a known zero.
+	 */
+	if (ctx->cnt =3D=3D 1)
+		return bpf_is_subprog(prog);
+
+	rec =3D bpf_exc_pad_for_ip(prog, ip);
+	if (rec) {
+		*ra =3D rec->pad;
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
@@ -5095,6 +5138,8 @@ BTF_ID_FLAGS(func, bpf_task_get_cgroup1, KF_ACQUIRE=
 | KF_RCU | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_pid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_task_from_vpid, KF_ACQUIRE | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_throw)
+BTF_ID_FLAGS(func, bpf_unwind)
+BTF_ID_FLAGS(func, bpf_unwind_resume)
 #ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_send_signal_task)
 #endif
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 488ceb9dae1b..917635adb5f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19299,6 +19299,10 @@ static int process_bpf_unwind(struct bpf_verifie=
r_env *env, int *insn_idx,
 	int pad =3D bpf_exc_pad_of_call(env, *insn_idx);
 	int err;
=20
+	err =3D bpf_exc_check_prog(env);
+	if (err)
+		return err;
+
 	if (pad < 0) {
 		if (!env->cur_state->curframe) {
 			err =3D check_resource_leak(env, false, true,
@@ -22898,6 +22902,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
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

