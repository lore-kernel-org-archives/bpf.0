Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A543B42EB
	for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036940; cv=none; b=r39yXZBuIDUChauBhdPdX2HMK6kLD+bW4V6h7f/CPjT/eYP1Vwb9zIumJXLMkJWXth/kCStVgKcsVQuges1xWUoKW37RNTiD1QGoecP0MYZV7PUOW8LY3IyeF1a9Hszm3d5bwg5xXsVfdRjg4a9mbgr6mr8xThCGXXij/CSPY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036940; c=relaxed/simple;
	bh=zL7BouOG5JWCCACAbYz4X9YrtCVwVCbswVIrz71VFuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1Zv+s+gBfQZVw0045ITVs++5ka/5eW3YsBhsvLOXpigScj3qOQywmFZa0F4GzZPUqYIOajUL/5RVBqTOuYXF3aOXbYphbbE5im0k/CnoAh5H6YiYEgoyVYfAi2KDMYdXMx6pSqXFdIdWD7/Xaq+/e4nD+YxN4MydvFHT2kZuWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 79D8D31498E305; Wed, 14 Oct 2026 21:02:14 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v11 06/26] bpf: Make exception landing pads reachable in the CFG
Date: Wed, 14 Oct 2026 21:02:14 -0700
Message-ID: <20261015040214.857736-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015040143.854070-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A call that a cleanup record covers can also reach the record's landing
pad. Add that edge to the CFG walk, to bpf_insn_successors(), and to
stack liveness, where a slot is alive across a call when the call's pad
reads it.

The CFG walk pushes the pad in a visit of its own, and the fall-through
on the next visit. bpf_check_cfg() re-visits the top of its stack until
DONE_EXPLORING, so a visit pushing both would leave the pad DISCOVERED
off the current path, and push_insn() would take a branch from one pad
into another -- how a frame with two regions chains them -- for a
back-edge.

Without the liveness change, a slot only the pad reads looked dead, and
clean_verifier_state() poisoned it while the callee ran.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/liveness.c | 24 +++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index bce7b5abcfda..ad7ea08f3b15 100644
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
@@ -160,6 +161,38 @@ static int push_insn(int t, int w, int e, struct bpf=
_verifier_env *env)
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
 static int visit_func_call_insn(int t, struct bpf_insn *insns,
 				struct bpf_verifier_env *env,
 				bool visit_callee)
@@ -167,6 +200,11 @@ static int visit_func_call_insn(int t, struct bpf_in=
sn *insns,
 	int ret, insn_sz;
 	int w;
=20
+	/* One push per visit: @t is revisited once the pad is explored. */
+	ret =3D visit_cleanup_pad_edge(t, env);
+	if (ret !=3D DONE_EXPLORING)
+		return ret;
+
 	insn_sz =3D bpf_is_ldimm64(&insns[t]) ? 2 : 1;
 	ret =3D push_insn(t, t + insn_sz, FALLTHROUGH, env);
 	if (ret)
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..8b7ee551ff6f 100644
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
@@ -404,6 +406,18 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
 			succ->items[succ->cnt++] =3D exit_idx;
 	}
=20
+	/*
+	 * A covered call can also leave through its landing pad. Only a call t=
o
+	 * a subprog or to bpf_unwind() is covered, so the two entries of
+	 * env->succ are enough.
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
@@ -530,7 +544,8 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *en=
v, u32 frameno, u32 half_sp
 	 * Slot is alive if it is read before q->insn_idx in current func insta=
nce,
 	 * or if for some outer func instance:
 	 * - alive before callsite if callsite calls callback or is callx, othe=
rwise
-	 * - alive after callsite
+	 * - alive after callsite,
+	 * - or alive at the landing pad a cleanup record gives the callsite
 	 */
 	struct live_stack_query *q =3D &env->liveness->live_stack_query;
 	struct func_instance *instance, *curframe_instance;
@@ -565,6 +580,13 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *e=
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

