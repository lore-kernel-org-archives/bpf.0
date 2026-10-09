Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC54FECCD
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577725; cv=none; b=KdHGoARUTKxhBEjd+ql8EONO4WUdLgu4g5F7izr5G9Undo5Mew7W/RJCL0/8FsuJUvW/BeuyiDEd35dOXFeahEXud2rH4AN0GyOD84sFA1i+izwt/RDQCIGhMrPYKNuFrZyKZtovGwkQ8py4ClPBN/2Fku9Ou6Ynk8I1gryoVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577725; c=relaxed/simple;
	bh=qIT7wGuTjriYnOfA2SxNY2edI9frw23hkgMBXld7w8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IS7QWB0P0LbpM4kHRZ2PwoqaMsNNluHLG/PPfyYm1RBP0ofIz1GiAlILknVKsEgW45AEFJslKmGEhLXLxx6f5Xnsy8lIuFCJtxDUpT47J+DGDjBHgBdnvHOchlHVcx5zc382W5Eunec0M17c4kf+LNf/6NhayFmfTc+6bm8n+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IGSbXdA5; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IGSbXdA5"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qIT7wGuTjriYnOfA2SxNY2edI9frw23hkgMBXld7w8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577721; v=1; x=1792182521;
 b=IGSbXdA50jKT+zZwXzsDL0t/wyZcHKKunUMvwW2YT6wx9F19Vof6cjqncX0TU0ijCrbl3/rj
 xT0WogfSop/H1/NYkiRqiodtZH4cmHqt9qfpTlrAoL9JzNHlvn89POrxsOuOgL90JkC266e/Cso
 TuG/+MsZFLB/5D6xUgeVsPrw=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 605ec0ba45d85f84;
	Fri, 09 Oct 2026 20:28:40 +0000
X-Mizu-Trace-ID: 605ec0ba45d85f84
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 07/11] bpf: Introduce REF_TYPE_FRAME in the verifier
Date: Fri,  9 Oct 2026 13:27:54 -0700
Message-ID: <20261009202759.50520-8-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009202759.50520-1-ihor.solodrai@linux.dev>
References: <20261009202759.50520-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A callback-calling helper can pass its callback a pointer that is only
valid for the duration of the callback invocation.

A callback can save such a value, or something derived from it, and
make it outlive the frame. The BPF program can then reuse it after the
helper returns.

The verifier tracks the argument's register type, but does not tie its
lifetime to the callback frame. Invalidating a value together with
everything derived from it is what invalidate_reference() already does,
walking reg->parent_id across every frame and stack slot. What is
missing is a type of reference that is not an object the program
acquired and releases.

Introduce REF_TYPE_FRAME: a reference owned by a callee frame.
A set_callee_state_fn can anchor an argument to such a reference with
mark_frame_scoped_arg(), and prepare_func_exit() drops it when the
frame is popped, invalidating the argument and everything derived from
it through the existing walk. The anchored register is its own parent,
so invalidate_reference() no longer queues a register as a descendant of
itself.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf.h          |  2 +
 include/linux/bpf_verifier.h |  6 +--
 kernel/bpf/diagnostics.c     |  3 ++
 kernel/bpf/diagnostics.h     |  1 +
 kernel/bpf/states.c          |  4 ++
 kernel/bpf/verifier.c        | 80 +++++++++++++++++++++++++++++++++++-
 6 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d5de9d49a168..e4498e6fa88a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3188,6 +3188,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
+int mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			  struct bpf_func_state *callee, u32 regno);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c51083c761cf..54a4f440c33b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -272,15 +272,13 @@ struct bpf_stack_state {
 };
 
 struct bpf_reference_state {
-	/* Each reference object has a type. Ensure REF_TYPE_PTR is zero to
-	 * default to pointer reference on zero initialization of a state.
-	 */
 	enum ref_state_type {
 		REF_TYPE_PTR		= (1 << 1),
 		REF_TYPE_IRQ		= (1 << 2),
 		REF_TYPE_LOCK		= (1 << 3),
 		REF_TYPE_RES_LOCK 	= (1 << 4),
 		REF_TYPE_RES_LOCK_IRQ	= (1 << 5),
+		REF_TYPE_FRAME		= (1 << 6),
 		REF_TYPE_LOCK_MASK	= REF_TYPE_LOCK | REF_TYPE_RES_LOCK | REF_TYPE_RES_LOCK_IRQ,
 	} type;
 	/* Track each reference created with a unique id, even if the same
@@ -298,6 +296,8 @@ struct bpf_reference_state {
 		 * it matches on unlock.
 		 */
 		void *ptr;
+		/* For REF_TYPE_FRAME */
+		u32 frameno;
 	};
 };
 
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 857b668212fb..ba1a3f07d58e 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -2238,6 +2238,9 @@ static void diag_print_mod(struct bpf_verifier_env *env, const struct bpf_diag_h
 								   "resource release invalidated "
 								   "this value";
 		break;
+	case BPF_DIAG_MOD_FRAME_RELEASE:
+		reason = "the callback that owned this value returned";
+		break;
 	case BPF_DIAG_MOD_PKT_DATA_CHANGE:
 		reason = "packet data may have moved";
 		break;
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index a4102fb049ec..b5cab4d79c1a 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -22,6 +22,7 @@ enum bpf_diag_mod_reason {
 	BPF_DIAG_MOD_SPILL,
 	BPF_DIAG_MOD_VAR_WRITE,
 	BPF_DIAG_MOD_REF_RELEASE,
+	BPF_DIAG_MOD_FRAME_RELEASE,
 	BPF_DIAG_MOD_PKT_DATA_CHANGE,
 	BPF_DIAG_MOD_NON_OWN_REF,
 	BPF_DIAG_MOD_CALLER_SAVED,
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 18bf7b660c2f..1291824a3a7d 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -899,6 +899,10 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
 			break;
 		case REF_TYPE_IRQ:
 			break;
+		case REF_TYPE_FRAME:
+			if (old->refs[i].frameno != cur->refs[i].frameno)
+				return false;
+			break;
 		case REF_TYPE_LOCK:
 		case REF_TYPE_RES_LOCK:
 		case REF_TYPE_RES_LOCK_IRQ:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 67a61570a9ab..c969fef2d452 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1529,6 +1529,49 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	return id;
 }
 
+/* Acquire a reference owned by frame @frameno of @state */
+static int acquire_frame_reference(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+				   int insn_idx, u32 frameno)
+{
+	struct bpf_reference_state ref = {
+		.type = REF_TYPE_FRAME,
+		.id = ++env->id_gen,
+		.insn_idx = insn_idx,
+		.frameno = frameno,
+	};
+
+	return acquire_reference_state(state, &ref);
+}
+
+/*
+ * Anchor @regno in @callee to a reference owned by the callee frame, so the
+ * value and everything derived from it is invalidated when the frame is
+ * popped. @state owns @callee; for a callback it is not env->cur_state.
+ */
+int mark_frame_scoped_arg(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+			  struct bpf_func_state *callee, u32 regno)
+{
+	int id;
+
+	if (verifier_bug_if(!callee->frameno, env,
+			    "cannot scope an argument to frame 0"))
+		return -EFAULT;
+
+	id = acquire_frame_reference(env, state, callee->callsite, callee->frameno);
+	if (id < 0)
+		return id;
+	/*
+	 * The value is its own lifetime anchor: there is no associated
+	 * object to borrow from, only the frame. parent_id = id here
+	 * covers both possible derived references:
+	 *  - through the id (e.g. dynptr slice)
+	 *  - through parent_id (e.g. dynptr clone)
+	 */
+	callee->regs[regno].id = id;
+	callee->regs[regno].parent_id = id;
+	return 0;
+}
+
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
@@ -10705,7 +10748,7 @@ static int invalidate_reference(struct bpf_verifier_env *env, int id,
 				continue;
 
 			/* Free objects derived from the current object */
-			if (reg->parent_id == id) {
+			if (reg->parent_id == id && reg->id != id) {
 				err = idstack_push(idstack, reg->id);
 				if (err)
 					return err;
@@ -10745,6 +10788,27 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return invalidate_reference(env, id, BPF_DIAG_MOD_REF_RELEASE);
 }
 
+static int release_frame_references(struct bpf_verifier_env *env, u32 frameno)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int i, id, err;
+
+	for (i = 0; i < state->acquired_refs;) {
+		if (state->refs[i].type != REF_TYPE_FRAME ||
+		    state->refs[i].frameno != frameno) {
+			i++;
+			continue;
+		}
+		id = state->refs[i].id;
+		release_reference_state(state, i);
+		err = invalidate_reference(env, id, BPF_DIAG_MOD_FRAME_RELEASE);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
@@ -11629,6 +11693,15 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
+
+	/*
+	 * Values the caller only guaranteed for the duration of the call stop
+	 * being valid here.
+	 */
+	err = release_frame_references(env, callee->frameno);
+	if (err)
+		return err;
+
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
@@ -11806,6 +11879,11 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
 		return 0;
 
 	for (i = 0; i < state->acquired_refs; i++) {
+		if (!exception_exit && state->refs[i].type == REF_TYPE_FRAME) {
+			verifier_bug(env, "frame %u reference id=%d alive at program exit",
+				     state->refs[i].frameno, state->refs[i].id);
+			return -EFAULT;
+		}
 		if (state->refs[i].type != REF_TYPE_PTR)
 			continue;
 		/* Allow struct_ops programs to return a referenced kptr back to
-- 
2.56.0

