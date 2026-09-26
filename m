Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336F38F926
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790398852; cv=none; b=RHSKYISczB87Yb55/sa5d+4O3/BV+p5WJf9hWYTLcpWkk3Yqyd0ihgjlf2YUc1qHV8b7PC3tyn9i0AfwGS13wYHOW2GvctolwCl+LyrDmkJ1FWg0bVd5UyYDdTG8Vvv4V5PuWjh8XfM64TeMIdfPpuC3zXE4RD41sEy/TeVjtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790398852; c=relaxed/simple;
	bh=E5Zusk7lGX7Ab/KVkis5/1vxQhdWY7Pfak+mA74P4OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvgJHUfDufqlajSxBfSkuo6zgyLEAKDm1z1ntvQY20TJR6r3k8/eAGfE0OTILVe6efP4AJa1Eso1DpjXYkMEDVk3/HEiaSp7kCgNUC70gh2AjgBL4qvNgqqC8x8Yej8bCpeavAkjyyPcvZETMxx41iFJdeC21xxdDgai1aaSQLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 21CD92D459015A; Fri, 25 Sep 2026 22:00:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 06/21] bpf: Make exception landing pads reachable in the CFG
Date: Fri, 25 Sep 2026 22:00:37 -0700
Message-ID: <20260926050037.2216265-1-yonghong.song@linux.dev>
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

A bpf_unwind() or a bpf2bpf call inside the [begin_off, end_off) range of=
 a
cleanup record can reach that record's landing pad. Add that edge to the
CFG walk, which explores the pad and makes both ends prune points, and to
bpf_insn_successors(), which liveness and the SCC passes walk.

Liveness needs one more thing. When bpf_stack_slot_alive()'s
is_live_before() says an outer frame's slot has no reader after the call
the frame is suspended at, the landing pad can still be one. Ask about th=
e
pad as well when the call site names one; otherwise clean_verifier_state(=
)
poisons the slot while the callee runs and the pad is rejected for readin=
g
it.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cfg.c      | 54 ++++++++++++++++++++++++++++++++++++++++---
 kernel/bpf/liveness.c | 21 +++++++++++++++++
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index b0bd9ba951df..4e2b6985bc96 100644
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
@@ -160,17 +161,64 @@ static int push_insn(int t, int w, int e, struct bp=
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
+	w =3D bpf_exc_pad_of_call(env, t);
+	if (w < 0)
+		return DONE_EXPLORING;
+
+	/*
+	 * @t is a call that may branch here, and @w is the target of that
+	 * branch, so both are prune points. @w especially: every covered call
+	 * site in a region unwinds to the same pad, and without a prune point
+	 * at its head the verifier walks the pad again for each of them.
+	 */
+	mark_prune_point(env, t);
+	mark_prune_point(env, w);
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
@@ -182,7 +230,7 @@ static int visit_func_call_insn(int t, struct bpf_ins=
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
index cd9523f69298..4e0273a8ceee 100644
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
 /*
@@ -384,6 +386,18 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
 			succ->items[succ->cnt++] =3D exit_idx;
 	}
=20
+	/*
+	 * A call a cleanup record covers can leave through its landing pad.
+	 * Only a call to a subprogram or to bpf_unwind() is marked, neither of
+	 * which is an edge the block above adds, so succ still holds two.
+	 */
+	if (unlikely(env->cleanup_info_cnt)) {
+		int pad =3D bpf_exc_pad_of_call(env, idx);
+
+		if (pad >=3D 0)
+			succ->items[succ->cnt++] =3D pad;
+	}
+
 	return succ;
 }
=20
@@ -545,6 +559,13 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *e=
nv, u32 frameno, u32 half_sp
 		alive =3D callee_stack_access_at_callsite(env, callsite)
 			? is_live_before(instance, callsite, rel, half_spi)
 			: is_live_before(instance, callsite + 1, rel, half_spi);
+
+		if (!alive && unlikely(env->cleanup_info_cnt)) {
+			int pad =3D bpf_exc_pad_of_call(env, callsite);
+
+			if (pad >=3D 0)
+				alive =3D is_live_before(instance, pad, rel, half_spi);
+		}
 		if (alive)
 			return true;
 	}
--=20
2.53.0-Meta

