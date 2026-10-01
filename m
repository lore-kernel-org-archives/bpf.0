Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15230C147
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861454; cv=none; b=fC0yLGOF+Qc/CqypkYB3c0WVK9yJ/hruZ5bdu5hcxY1mZQxyiCXmiH2evd6GEU5TFzUNrE2PfGO7HEKh+pBDgfdaEeQdFyyvImwRMK5l6frrIy7hgUPfIzFLh8+k6h7INPTH1UWJ4phSuIZmbeMFl9vkqoP8nLYHEc4QuJ6B5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861454; c=relaxed/simple;
	bh=V5N8LxoPsV1EyLGrtRzCqGvqZ2cMVXeBILLGpNzqnoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMCFGBqbx9W0mSbmMM/77fMf8ivX2zCD4A4c3sKLgzU5SulxqesrZRyDjoxrLqL/ZdEAXPGN7EHdptPrmwPmWPYZMInRtPVO4bAeeflpLJUmJN0E5pw7YFJUCp6+BvSi6KnVgOGZObknrZj8ogo3CoRl0UMzcz5b9clQA21caVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 6CBDD2E6E0B8CA; Thu,  1 Oct 2026 06:30:37 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v8 06/22] bpf: Make exception landing pads reachable in the CFG
Date: Thu,  1 Oct 2026 06:30:37 -0700
Message-ID: <20261001133037.1339037-1-yonghong.song@linux.dev>
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

A bpf_unwind() or a bpf2bpf call inside the [begin_off, end_off) range of=
 a
cleanup record can reach that record's landing pad. Add that edge to the
CFG walk, which explores the pad and makes both ends prune points, and to
bpf_insn_successors(), which liveness and the SCC passes walk.

The pad is pushed by itself: visit_func_call_insn() returns as soon as
visit_cleanup_pad_edge() has pushed one, and the call site is visited aga=
in
for its fall-through once the pad is explored. bpf_check_cfg() peeks the
top of its stack and re-visits until DONE_EXPLORING, so a visit pushing t=
wo
successors would leave the pad DISCOVERED while it is no longer on the pa=
th
being walked, and push_insn() reads DISCOVERED as a back-edge. A branch
from one pad into another -- how a frame with two regions chains them --
would be taken for one. The pad's own insn_state is what records that the
edge is done, so there is nothing else to remember.

Liveness needs one more thing. A frame suspended at a call normally keeps=
 a
stack slot alive only if something reads it once the call returns. A
landing pad is not on that path: it is reached from the call itself, not
from the instruction after it. So a slot that only the pad reads looks
dead, and clean_verifier_state() poisons it while the callee runs. Ask
whether the pad reads it too. The entry_var_stack selftest, added later
in the series, is the shape that needs this -- it stores to its frame
before the call, never reads that slot on the way back, and reloads it in
the pad.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/bpf/liveness.c | 26 +++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index d8a579680e5b..63afbc5fb296 100644
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
index cd9523f69298..b3091eac2cf1 100644
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
@@ -384,6 +386,20 @@ bpf_insn_successors(struct bpf_verifier_env *env, u3=
2 idx)
 			succ->items[succ->cnt++] =3D exit_idx;
 	}
=20
+	/*
+	 * A call a cleanup record covers can leave through its landing pad.
+	 * Only a call to a subprogram, direct or through callx, or to
+	 * bpf_unwind() is marked, none of which is an edge the block above
+	 * adds, so there are at most two successors, which env->succ is sized
+	 * for.
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
@@ -510,7 +526,8 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *en=
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
@@ -545,6 +562,13 @@ bool bpf_stack_slot_alive(struct bpf_verifier_env *e=
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

