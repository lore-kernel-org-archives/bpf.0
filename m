Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0703F4829
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624652; cv=none; b=ghsLLYMS5KG2vnrR82UT4YoixNSwhArGbMH0Z/+zY8MGT7n5MiZBVboOMkEuLK3HWQrIl+SrUw8ZhW9MX43oh9dE3Anp0UYqKUOgmBzIpxJC5ug5bd6Rb01M4y24ReYQ7DZwiCnh7OPLLfCf0cIObPdwRLOege6MZcRAt6Tj4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624652; c=relaxed/simple;
	bh=OE5egod7eL+r7OqcCglTeotwfxV8yI5ts3t+CYFObuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6bWUbKtlfrHBqyv/+V6qa4zkYAawJSQ7TRHurIi2LSxplUqsx4OI3vmVstjATs4+EPZ6LMwxb3/RPt119xkV+nsvNtg9O7lbgkUHQ2y5yL5W5bV+KgswRrk6btsVPERWGlFDuf/Vq4ru1kTj5YUDx8DsL58+Aje+XTIYWJYn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 7779D2B487A405; Wed, 16 Sep 2026 22:57:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 07/20] bpf: Refuse exception cleanup shapes bpf_throw() cannot dispatch
Date: Wed, 16 Sep 2026 22:57:21 -0700
Message-ID: <20260917055721.3930090-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917055645.3926444-1-yonghong.song@linux.dev>
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The table is on the instructions and the landing pads are in the control
flow graph. What is left before bpf_throw() can be taught to dispatch the=
m
is to work out what that walk will need, and refuse the shapes it could n=
ot
handle.

bpf_check_cleanup_exceptions() runs after bpf_check_cfg(). Everything it
needs is control flow, so it reads what that walk has already worked out
rather than working it out again:

  subprog_info.might_throw   which subprograms an exception may leave,
                             closed over the call graph by
                             merge_callee_effects() as the walk pops each
                             callee
  cleanup_reachability()     what each instruction can reach -- a resume,=
 a
                             plain exit, a throw, an indirect jump
  cleanup_mark_pad_bodies()  which instructions only ever run with an
                             exception already in flight

What it refuses:

  - a pad that reaches both a resume and a plain exit, or neither: nothin=
g
    says whether it is a cleanup pad or a catch pad
  - a catch pad, which ends in a plain exit: the walker calls a pad as a
    subroutine and cannot hand a frame back its own execution
  - a throw in a pad, or a call from a pad to a subprogram that can throw=
:
    a second unwind over frames the first is still discarding
  - a bpf_unwind_resume() outside a pad body
  - a subprogram that may unwind used as a helper callback: the helper's
    own kernel frame would end the walk before it found a boundary
  - a tail call, an indirect jump, or an outgoing on-stack call argument =
in
    a pad body, all of which touch a stack the pad does not own

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/bpf_verifier.h |   1 +
 kernel/bpf/exception.c       | 397 +++++++++++++++++++++++++++++++++++
 kernel/bpf/exception.h       |   2 +
 kernel/bpf/fixups.c          |   1 +
 kernel/bpf/verifier.c        |   8 +
 5 files changed, 409 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 7463e86d15ee..fe8b26351a15 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -682,6 +682,7 @@ struct bpf_insn_aux_data {
 	bool non_sleepable; /* helper/kfunc may be called from non-sleepable co=
ntext */
 	bool is_iter_next; /* bpf_iter_<type>_next() kfunc call */
 	bool cleanup_throw_site; /* call to bpf_throw() */
+	bool in_cleanup_pad; /* only runs with an exception in flight */
 	/*
 	 * 1 + the instruction index of the exception cleanup landing pad this
 	 * call site unwinds to, or 0 for none.
diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
index dfe9c2a9ce7d..b2bf831242b8 100644
--- a/kernel/bpf/exception.c
+++ b/kernel/bpf/exception.c
@@ -6,6 +6,7 @@
 #include <linux/btf_ids.h>
 #include <linux/filter.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
@@ -23,6 +24,130 @@ static bool insn_is_exc_kfunc(const struct bpf_insn *=
insn, int kf)
 	       insn->imm =3D=3D exc_kfunc_list[kf];
 }
=20
+/* What an instruction does to intra-subprog control flow. */
+enum cleanup_insn_kind {
+	CLEANUP_INSN_PLAIN,	/* the next insn runs */
+	CLEANUP_INSN_JUMP,	/* unconditional jump */
+	CLEANUP_INSN_COND,	/* the next insn runs, or the branch target */
+	CLEANUP_INSN_EXIT,
+	CLEANUP_INSN_THROW,	/* call bpf_throw: nothing after it runs */
+	CLEANUP_INSN_RESUME,	/* call bpf_unwind_resume: likewise */
+	CLEANUP_INSN_CALL,	/* call to another subprog */
+	CLEANUP_INSN_GOTOX,	/* indirect jump: successors not known here */
+};
+
+/* What each instruction can reach, computed once by cleanup_reachabilit=
y(). */
+#define CLEANUP_REACH_RESUME	BIT(0)	/* a bpf_unwind_resume() call */
+#define CLEANUP_REACH_EXIT	BIT(1)	/* a plain BPF_EXIT */
+#define CLEANUP_REACH_UNKNOWN	BIT(2)	/* an indirect jump */
+#define CLEANUP_REACH_THROW	BIT(3)	/* a bpf_throw() call */
+
+/* Scratch shared by the analyses, sized once so no walker has to alloca=
te. */
+struct cleanup_ctx {
+	struct bpf_verifier_env *env;
+	u8 *reach;		/* per insn: CLEANUP_REACH_* mask */
+	u32 *stack;		/* per insn: DFS stack */
+	void *scratch;		/* the one allocation all of the above live in */
+};
+
+static bool in_pad(struct bpf_verifier_env *env, u32 i)
+{
+	return env->insn_aux_data[i].in_cleanup_pad;
+}
+
+/* One scratch array for cleanup_alloc() to hand out. */
+struct cleanup_alloc_req {
+	void **dst;
+	size_t n, sz;
+};
+
+static void *cleanup_alloc(const struct cleanup_alloc_req *tab, u32 cnt)
+{
+	size_t total =3D 0;
+	char *block, *p;
+	u32 i;
+
+	for (i =3D 0; i < cnt; i++)
+		total +=3D round_up(tab[i].n * tab[i].sz, 8);
+
+	block =3D kvzalloc(total, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	if (!block)
+		return NULL;
+
+	for (i =3D 0, p =3D block; i < cnt; i++) {
+		*tab[i].dst =3D p;
+		p +=3D round_up(tab[i].n * tab[i].sz, 8);
+	}
+	return block;
+}
+
+static int cleanup_subprog_of(struct bpf_verifier_env *env, u32 off)
+{
+	struct bpf_subprog_info *info =3D bpf_find_containing_subprog(env, off)=
;
+
+	return info ? info - env->subprog_info : -1;
+}
+
+/* The subprogram a linear pass is currently in. */
+struct cleanup_cursor {
+	u32 start, end;		/* [start, end) of the current subprogram */
+	int sub;		/* its index */
+};
+
+#define CLEANUP_CURSOR_INIT { .sub =3D -1 }
+
+static void cleanup_cursor_to(struct bpf_verifier_env *env, struct clean=
up_cursor *c, u32 i)
+{
+	while (i >=3D c->end) {
+		c->sub++;
+		c->start =3D env->subprog_info[c->sub].start;
+		c->end =3D env->subprog_info[c->sub + 1].start;
+	}
+}
+
+static enum cleanup_insn_kind cleanup_classify(struct bpf_verifier_env *=
env, u32 i,
+					       int *next, int *target)
+{
+	struct bpf_insn *insn =3D &env->prog->insnsi[i];
+	u8 class =3D BPF_CLASS(insn->code);
+
+	*next =3D i + 1;
+	*target =3D -1;
+
+	if (insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW)) {
+		*next =3D i + 2;
+		return CLEANUP_INSN_PLAIN;
+	}
+	if (class !=3D BPF_JMP && class !=3D BPF_JMP32)
+		return CLEANUP_INSN_PLAIN;
+
+	switch (BPF_OP(insn->code)) {
+	case BPF_EXIT:
+		*next =3D -1;
+		return CLEANUP_INSN_EXIT;
+	case BPF_JA:
+		*next =3D -1;
+		if (BPF_SRC(insn->code) =3D=3D BPF_X)
+			return CLEANUP_INSN_GOTOX;
+		*target =3D class =3D=3D BPF_JMP32 ? i + insn->imm + 1 : i + insn->off=
 + 1;
+		return CLEANUP_INSN_JUMP;
+	case BPF_CALL:
+		if (bpf_is_throw_kfunc(insn)) {
+			*next =3D -1;
+			return CLEANUP_INSN_THROW;
+		}
+		if (insn_is_exc_kfunc(insn, EXC_KF_bpf_unwind_resume)) {
+			*next =3D -1;
+			return CLEANUP_INSN_RESUME;
+		}
+		return bpf_pseudo_call(insn) ? CLEANUP_INSN_CALL : CLEANUP_INSN_PLAIN;
+	default:
+		/* Conditional jump, including BPF_JCOND. */
+		*target =3D i + insn->off + 1;
+		return CLEANUP_INSN_COND;
+	}
+}
+
 static void cleanup_mark_throw_sites(struct bpf_verifier_env *env)
 {
 	u32 i;
@@ -32,6 +157,247 @@ static void cleanup_mark_throw_sites(struct bpf_veri=
fier_env *env)
 			env->insn_aux_data[i].cleanup_throw_site =3D true;
 }
=20
+int bpf_cleanup_check_callback(struct bpf_verifier_env *env, int subprog=
)
+{
+	if (!env->cleanup_info_cnt || !env->subprog_info[subprog].might_throw)
+		return 0;
+
+	verbose(env, "subprog %d may unwind and is used as a callback\n", subpr=
og);
+	return -EINVAL;
+}
+
+/* Intra-subprog successors of @i, or -1 each when absent. */
+static enum cleanup_insn_kind cleanup_succ(struct bpf_verifier_env *env,=
 u32 i,
+					   u32 start, u32 end, int *next, int *target)
+{
+	enum cleanup_insn_kind kind =3D cleanup_classify(env, i, next, target);
+
+	if (*next < (int)start || *next >=3D (int)end)
+		*next =3D -1;
+	if (*target < (int)start || *target >=3D (int)end)
+		*target =3D -1;
+	return kind;
+}
+
+static void cleanup_add_pred(u32 *head, u32 *link, u32 to, u32 e)
+{
+	link[e] =3D head[to];
+	head[to] =3D e + 1;
+}
+
+/* What every instruction can reach along intra-subprog edges, for
+ * cleanup_pad_is_catch(). One backward walk over a predecessor index, r=
ather
+ * than a forward walk from each landing pad, which would be quadratic.
+ */
+static int cleanup_reachability(struct cleanup_ctx *ctx)
+{
+	struct bpf_verifier_env *env =3D ctx->env;
+	u32 len =3D env->prog->len;
+	struct cleanup_cursor c =3D CLEANUP_CURSOR_INIT;
+	u32 *head =3D NULL, *link =3D NULL;
+	bool *queued =3D NULL;
+	u32 i, sp =3D 0;
+	void *scratch;
+	const struct cleanup_alloc_req tab[] =3D {
+		{ (void **)&head,   len,             sizeof(*head) },
+		{ (void **)&link,   2 * (size_t)len, sizeof(*link) },
+		{ (void **)&queued, len,             sizeof(*queued) },
+	};
+
+	scratch =3D cleanup_alloc(tab, ARRAY_SIZE(tab));
+	if (!scratch)
+		return -ENOMEM;
+
+	/* Index the predecessors, and seed the walk at the terminators. */
+	for (i =3D 0; i < len; i++) {
+		enum cleanup_insn_kind kind;
+		int next, target;
+
+		cleanup_cursor_to(env, &c, i);
+		kind =3D cleanup_succ(env, i, c.start, c.end, &next, &target);
+
+		if (kind =3D=3D CLEANUP_INSN_RESUME)
+			ctx->reach[i] |=3D CLEANUP_REACH_RESUME;
+		else if (kind =3D=3D CLEANUP_INSN_EXIT)
+			ctx->reach[i] |=3D CLEANUP_REACH_EXIT;
+		else if (kind =3D=3D CLEANUP_INSN_GOTOX)
+			ctx->reach[i] |=3D CLEANUP_REACH_UNKNOWN;
+		else if (kind =3D=3D CLEANUP_INSN_THROW)
+			ctx->reach[i] |=3D CLEANUP_REACH_THROW;
+
+		if (next >=3D 0)
+			cleanup_add_pred(head, link, next, 2 * i);
+		if (target >=3D 0)
+			cleanup_add_pred(head, link, target, 2 * i + 1);
+
+		if (ctx->reach[i]) {
+			queued[i] =3D true;
+			ctx->stack[sp++] =3D i;
+		}
+	}
+
+	/* Each instruction re-enters the worklist at most once per bit it
+	 * gains, so this is linear in the number of edges.
+	 */
+	while (sp) {
+		u32 j =3D ctx->stack[--sp];
+		u8 flags =3D ctx->reach[j];
+		u32 e;
+
+		queued[j] =3D false;
+		for (e =3D head[j]; e; e =3D link[e - 1]) {
+			u32 p =3D (e - 1) / 2;
+
+			if ((ctx->reach[p] | flags) =3D=3D ctx->reach[p])
+				continue;
+			ctx->reach[p] |=3D flags;
+			if (!queued[p]) {
+				queued[p] =3D true;
+				ctx->stack[sp++] =3D p;
+			}
+		}
+	}
+	kvfree(scratch);
+	return 0;
+}
+
+static int cleanup_pad_is_catch(struct cleanup_ctx *ctx, u32 pad)
+{
+	u8 reach =3D ctx->reach[pad];
+
+	if (reach & CLEANUP_REACH_UNKNOWN) {
+		verbose(ctx->env, "cleanup landing pad %u reaches an indirect jump\n",=
 pad);
+		return -EINVAL;
+	}
+	if (reach & CLEANUP_REACH_THROW) {
+		verbose(ctx->env,
+			"cleanup landing pad %u can throw while an exception is in flight\n",
+			pad);
+		return -EINVAL;
+	}
+	if (!(reach & CLEANUP_REACH_RESUME) =3D=3D !(reach & CLEANUP_REACH_EXIT=
)) {
+		verbose(ctx->env, "cleanup landing pad %u %s\n", pad,
+			(reach & CLEANUP_REACH_RESUME) ?
+			"reaches both bpf_unwind_resume() and a plain exit" :
+			"reaches neither bpf_unwind_resume() nor an exit");
+		return -EINVAL;
+	}
+	return !!(reach & CLEANUP_REACH_EXIT);
+}
+
+static int cleanup_check_pad_insn(struct bpf_verifier_env *env, u32 i)
+{
+	struct bpf_insn *insn =3D &env->prog->insnsi[i];
+
+	if (bpf_helper_call(insn) && insn->imm =3D=3D BPF_FUNC_tail_call) {
+		verbose(env,
+			"bpf_tail_call() at insn %u is in an exception cleanup landing pad\n"=
,
+			i);
+		return -EINVAL;
+	}
+	/* Stack arguments are not supported. */
+	if (is_stack_arg_st(insn) || is_stack_arg_stx(insn)) {
+		verbose(env,
+			"insn %u passes an on-stack call argument in an exception cleanup lan=
ding pad\n",
+			i);
+		return -EINVAL;
+	}
+	/* Likewise, stack arguments are not supported. */
+	if (bpf_pseudo_kfunc_call(insn)) {
+		struct bpf_call_summary cs;
+
+		if (bpf_get_call_summary(env, insn, &cs) &&
+		    cs.arg_slot_cnt > MAX_BPF_FUNC_REG_ARGS) {
+			verbose(env,
+				"insn %u passes an on-stack call argument in an exception cleanup la=
nding pad\n",
+				i);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+static int cleanup_mark_pad_bodies(struct cleanup_ctx *ctx)
+{
+	struct bpf_verifier_env *env =3D ctx->env;
+	u32 i, sp =3D 0;
+	int ret;
+
+	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
+		u32 pad =3D env->cleanup_info[i].landing_pad_off;
+
+		if (in_pad(env, pad))
+			continue;
+
+		ret =3D cleanup_pad_is_catch(ctx, pad);
+		if (ret < 0)
+			return ret;
+		if (ret) {
+			verbose(env,
+				"catch landing pad %u is not supported yet, only cleanup pads that r=
esume\n",
+				pad);
+			return -EOPNOTSUPP;
+		}
+		env->insn_aux_data[pad].in_cleanup_pad =3D true;
+		ctx->stack[sp++] =3D pad;
+	}
+
+	while (sp) {
+		u32 j =3D ctx->stack[--sp];
+		enum cleanup_insn_kind kind;
+		int next, target, sub;
+		u32 start, end;
+
+		ret =3D cleanup_check_pad_insn(env, j);
+		if (ret)
+			return ret;
+
+		sub =3D cleanup_subprog_of(env, j);
+		start =3D env->subprog_info[sub].start;
+		end =3D env->subprog_info[sub + 1].start;
+		kind =3D cleanup_succ(env, j, start, end, &next, &target);
+
+		if (kind =3D=3D CLEANUP_INSN_CALL) {
+			int callee =3D cleanup_subprog_of(env, j + env->prog->insnsi[j].imm +=
 1);
+
+			if (env->subprog_info[callee].might_throw) {
+				verbose(env,
+					"cleanup landing pad calls subprog %d at insn %u, which can throw w=
hile an exception is in flight\n",
+					callee, j);
+				return -EINVAL;
+			}
+		}
+
+		if (next >=3D 0 && !in_pad(env, next)) {
+			env->insn_aux_data[next].in_cleanup_pad =3D true;
+			ctx->stack[sp++] =3D next;
+		}
+		if (target >=3D 0 && !in_pad(env, target)) {
+			env->insn_aux_data[target].in_cleanup_pad =3D true;
+			ctx->stack[sp++] =3D target;
+		}
+	}
+	return 0;
+}
+
+static int cleanup_check_resumes(struct cleanup_ctx *ctx)
+{
+	struct bpf_verifier_env *env =3D ctx->env;
+	u32 i;
+
+	for (i =3D 0; i < env->prog->len; i++) {
+		if (!insn_is_exc_kfunc(&env->prog->insnsi[i], EXC_KF_bpf_unwind_resume=
))
+			continue;
+		if (in_pad(env, i))
+			continue;
+		verbose(env,
+			"bpf_unwind_resume() at insn %u is not in an exception cleanup landin=
g pad\n",
+			i);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static void cleanup_mark_call_sites(struct bpf_verifier_env *env)
 {
 	u32 i, j;
@@ -78,6 +444,37 @@ int bpf_prepare_cleanup_exceptions(struct bpf_verifie=
r_env *env)
 	return 0;
 }
=20
+int bpf_check_cleanup_exceptions(struct bpf_verifier_env *env)
+{
+	u32 len =3D env->prog->len;
+	struct cleanup_ctx ctx =3D { .env =3D env };
+	const struct cleanup_alloc_req tab[] =3D {
+		{ (void **)&ctx.reach, len, sizeof(*ctx.reach) },
+		{ (void **)&ctx.stack, len, sizeof(*ctx.stack) },
+	};
+	int ret;
+
+	if (!env->cleanup_info_cnt)
+		return 0;
+
+	ctx.scratch =3D cleanup_alloc(tab, ARRAY_SIZE(tab));
+	if (!ctx.scratch)
+		return -ENOMEM;
+
+	ret =3D cleanup_reachability(&ctx);
+	if (ret)
+		goto out;
+
+	ret =3D cleanup_mark_pad_bodies(&ctx);
+	if (ret)
+		goto out;
+
+	ret =3D cleanup_check_resumes(&ctx);
+out:
+	kvfree(ctx.scratch);
+	return ret;
+}
+
 bool bpf_is_unwind_resume_kfunc(const struct bpf_insn *insn)
 {
 	return insn_is_exc_kfunc(insn, EXC_KF_bpf_unwind_resume);
diff --git a/kernel/bpf/exception.h b/kernel/bpf/exception.h
index f51383fd775c..7313dd2b65a1 100644
--- a/kernel/bpf/exception.h
+++ b/kernel/bpf/exception.h
@@ -8,6 +8,8 @@
 struct bpf_verifier_env;
=20
 int bpf_prepare_cleanup_exceptions(struct bpf_verifier_env *env);
+int bpf_check_cleanup_exceptions(struct bpf_verifier_env *env);
+int bpf_cleanup_check_callback(struct bpf_verifier_env *env, int subprog=
);
 int bpf_cleanup_pad_of_call(struct bpf_verifier_env *env, u32 idx);
=20
 #endif /* _LINUX_BPF_EXCEPTION_H */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 82b00fac6bd6..f120ae66dbbc 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -252,6 +252,7 @@ static void adjust_insn_aux_data(struct bpf_verifier_=
env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen =3D old_seen;
 		data[i].zext_dst =3D bpf_insn_def32(new_prog, insn + i) >=3D 0;
+		data[i].in_cleanup_pad =3D data[off + cnt - 1].in_cleanup_pad;
 		if (!memcmp(insn + i, original_insn, sizeof(struct bpf_insn))) {
 			data[i].non_stack_access =3D
 				data[off + cnt - 1].non_stack_access;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6496c30a10f7..9cbdb8339701 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10485,6 +10485,10 @@ static int push_callback_call(struct bpf_verifie=
r_env *env, struct bpf_insn *ins
 	 * callbacks
 	 */
 	env->subprog_info[subprog].is_cb =3D true;
+	err =3D bpf_cleanup_check_callback(env, subprog);
+	if (err)
+		return err;
+
 	if (bpf_pseudo_kfunc_call(insn) &&
 	    !is_callback_calling_kfunc(insn->imm)) {
 		verifier_bug(env, "kfunc %s#%d not marked as callback-calling",
@@ -21664,6 +21668,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
=20
+	ret =3D bpf_check_cleanup_exceptions(env);
+	if (ret < 0)
+		goto skip_full_check;
+
 	ret =3D bpf_compute_postorder(env);
 	if (ret < 0)
 		goto skip_full_check;
--=20
2.53.0-Meta

