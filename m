Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA7137F8BA
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624640; cv=none; b=V6CIkYJLR6DZgATpgtdlYDu9z7sNbm/CKTlJOmRDLymcFbhDpvvAdzSsEOBgIIu+CkLY74wOZyqBc30zFjIAeINzFC9Q8DslUT0pJ8qORN4yl0fu9jgyGXwot1+J6mkzLIDH/ChZMyZTfK8j84/CFTgjcEQhjs4tqwNFXogfL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624640; c=relaxed/simple;
	bh=dgE6h5cLZ51TLU0oHKqE7BnZJ7lEN/IZykvJ0eDotAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdPwRWcJDCpMzzhUHbbd0Ct3MZ7YGdNAWJH2x9VamvZK0/CUTKouWQCR5A2pniFP1vqgALVNhUTPYcno12zoysebFdg3uZAua/rf+pz7R4Dmr54TrCF4O2sc+PqBeXe7yAhRdMuClE1DnA65s5Cu8gBpZw3QQi9KEqQ9TgpsJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id F0EE82B4872DAF; Wed, 16 Sep 2026 22:57:10 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next 05/20] bpf: Make exception landing pads reachable in the CFG
Date: Wed, 16 Sep 2026 22:57:10 -0700
Message-ID: <20260917055710.3929202-1-yonghong.song@linux.dev>
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

Both the CFG walk and liveness are involved. A bpf_throw() or a bpf2bpf
call inside the [begin_off, end_off) range of a cleanup record can reach
that record's landing pad, so both grow that edge; and a
bpf_unwind_resume() reaches nothing after it, so it has no successors.

Liveness needs one more thing. bpf_stack_slot_alive() decides whether an
outer frame's stack slot is still read after the call the frame is
suspended at by looking at the instruction after the call. A slot whose
only remaining reader is the landing pad -- which is every slot a
compiler-generated pad reloads, since only four registers survive a call =
--
is dead by that measure, so clean_verifier_state() poisons it while the
callee runs and the pad is then rejected for reading it. Ask about the pa=
d
as well when the call site names one.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cfg.c      | 47 ++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/liveness.c | 20 ++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..9f8b8b54d5ea 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -6,6 +6,7 @@
 #include <linux/sort.h>
=20
 #include "diagnostics.h"
+#include "exception.h"
=20
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
@@ -158,17 +159,57 @@ static int push_insn(int t, int w, int e, struct bp=
f_verifier_env *env)
 	return DONE_EXPLORING;
 }
=20
+static int visit_cleanup_pad_edge(int t, struct bpf_verifier_env *env)
+{
+	int *insn_stack =3D env->cfg.insn_stack;
+	int *insn_state =3D env->cfg.insn_state;
+	int w;
+
+	if (!env->cleanup_info_cnt)
+		return DONE_EXPLORING;
+	w =3D bpf_cleanup_pad_of_call(env, t);
+	if (w < 0)
+		return DONE_EXPLORING;
+
+	mark_prune_point(env, t);
+	mark_jmp_point(env, w);
+	mark_jump_target(env, w);
+
+	if (insn_state[w])
+		return DONE_EXPLORING;
+	if (env->cfg.cur_stack >=3D env->prog->len)
+		return -E2BIG;
+	insn_stack[env->cfg.cur_stack++] =3D w;
+	insn_state[w] |=3D DISCOVERED;
+	return KEEP_EXPLORING;
+}
+
+static int merge_visit_ret(int a, int b)
+{
+	if (a < 0)
+		return a;
+	if (b < 0)
+		return b;
+	if (a =3D=3D KEEP_EXPLORING || b =3D=3D KEEP_EXPLORING)
+		return KEEP_EXPLORING;
+	return DONE_EXPLORING;
+}
+
 static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
 {
-	int ret, insn_sz;
+	int ret, insn_sz, pad_ret;
 	int w;
=20
+	pad_ret =3D visit_cleanup_pad_edge(t, env);
+	if (pad_ret < 0)
+		return pad_ret;
+
 	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	if (ret)
-		return ret;
+		return merge_visit_ret(pad_ret, ret);
=20
 	mark_prune_point(env, t + insn_sz);
 	/* when we exit from subprog, we need to record non-linear history */
@@ -180,7 +221,7 @@ static int visit_func_call_insn(int t, struct bpf_ins=
n *insns,
 		merge_callee_effects(env, t, w);
 		ret =3D push_insn(t, w, BRANCH, env);
 	}
-	return ret;
+	return merge_visit_ret(pad_ret, ret);
 }
=20
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_e=
lem)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 44ecdc5b4ec2..9cfd05f970bc 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -8,6 +8,8 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
=20
+#include "exception.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
=20
 struct per_frame_masks {
@@ -256,6 +258,9 @@ bpf_insn_successors(struct bpf_verifier_env *env, u32=
 idx)
 	succ =3D env->succ;
 	succ->cnt =3D 0;
=20
+	if (unlikely(bpf_is_unwind_resume_kfunc(insn)))
+		return succ;
+
 	opcode_info =3D &opcode_info_tbl[BPF_CLASS(insn->code) | BPF_OP(insn->c=
ode)];
 	insn_sz =3D bpf_is_ldimm64(insn) ? 2 : 1;
 	if (opcode_info->can_fallthrough)
@@ -264,6 +269,13 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
 	if (opcode_info->can_jump)
 		succ->items[succ->cnt++] =3D idx + bpf_jmp_offset(insn) + 1;
=20
+	if (unlikely(env->cleanup_info_cnt)) {
+		int pad =3D bpf_cleanup_pad_of_call(env, idx);
+
+		if (pad >=3D 0)
+			succ->items[succ->cnt++] =3D pad;
+	}
+
 	return succ;
 }
=20
@@ -397,6 +409,14 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *e=
nv, u32 frameno, u32 half_sp
 		alive =3D bpf_calls_callback(env, callsite)
 			? is_live_before(instance, callsite, rel, half_spi)
 			: is_live_before(instance, callsite + 1, rel, half_spi);
+
+		/* Control may also go to the landing pad. */
+		if (!alive && unlikely(env->cleanup_info_cnt)) {
+			int pad =3D bpf_cleanup_pad_of_call(env, callsite);
+
+			if (pad >=3D 0)
+				alive =3D is_live_before(instance, pad, rel, half_spi);
+		}
 		if (alive)
 			return true;
 	}
--=20
2.53.0-Meta

