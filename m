Received: from mta1.migadu.com (out-210.mta1.migadu.com [95.215.58.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAF835DA40
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039037; cv=none; b=ODWOjZdpcQI3uaeqIrdOW4jQCYakB9vDq7C7EbTZCDuYOiXlp0UZgONgHmPITt8jdpQ9vQgm/ETNNZbtYxV59vfbj8g9U+YVAyTIwtiqflv8ISPcJNGYUj9zgjGrKyrT2y1JYDeQcSBEu/+AZqzz4AkdNPJoSyX1JjXV7/S/1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039037; c=relaxed/simple;
	bh=/3JbCIKnBZH40TkdFYl0W7WZ17knx7zjRr3o1DGPnAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dJdf48K1vrA5DXuFEpoe6Z5mICfOQ603zCmhOENcrDNXekSHNjma4R0OBo9uh95E2NHNinGEdOrzZriXQIDTZwucqDEgZfq7m2adaALj993qYO9GbppAiTGLUld4gSCFBIS9lM9EvQhXwz8kTrj3ceYPfPOPzawCidmtmBFPLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PfiL9rL/; arc=none smtp.client-ip=95.215.58.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PfiL9rL/"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/3JbCIKnBZH40TkdFYl0W7WZ17knx7zjRr3o1DGPnAU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039032; v=1; x=1790643832;
 b=PfiL9rL/lxMUmscT56JKP1E6QTikKKn47o3BrYWKG1hNePCA/CWSg0XQkGwUCJG+EdYwhYYZ
 /GNFoE0MuJ5ptSJqV/gqhMqPePxxHe2Et+IhNy1MIgKDuI3uk1lwPrG2wFUweYnu8+EqL7Xnkc5
 SEpKwOnmeWd8uEVHoqgfEYjM=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 7d36f3c3f44034d2;
	Tue, 22 Sep 2026 01:03:52 +0000
X-Mizu-Trace-ID: 7d36f3c3f44034d2
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
Subject: [PATCH bpf-next v1 1/6] bpf: Introduce REF_TYPE_FRAME in the verifier
Date: Mon, 21 Sep 2026 18:03:28 -0700
Message-ID: <20260922010333.1226537-2-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A callback-calling helper can pass its callback a pointer that is only
valid for the duration of the call. The verifier just gives such an
argument a register type, which allows the callback to park the value,
or something derived from it, and make it outlive the frame. The BPF
program then can reuse it after the helper returns.

Invalidating a value together with everything derived from it is what
release_reference() already does, walking reg->parent_id across every
frame and stack slot. What is missing is a type of reference that is
not an object the program acquired and releases.

Introduce REF_TYPE_FRAME: a reference owned by a callee frame.
A set_callee_state_fn can declare an argument frame-scoped, and
setup_func_entry() turns the declaration into a reference, and
prepare_func_exit() drops it when the frame is popped, invalidating
the argument and everything derived from it through the existing walk.

Keep the new type invisible to find_reference_state(). release_reg()
and ref_convert_owning_non_owning() look up purely by id and could
otherwise destroy the anchor.

Fix up a few pre-existing comments while at it.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

---

This patch only introduces the mechanism: no helper declares a
frame-scoped argument yet. It is used in the subsequent patches in the
series, each fixing a separate bug.

---
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  11 +++-
 kernel/bpf/states.c          |   4 ++
 kernel/bpf/verifier.c        | 121 ++++++++++++++++++++++++++++++++---
 4 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fd22db8bc6c5..d849e4873417 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3118,6 +3118,7 @@ int bpf_iter_map_fill_link_info(const struct bpf_iter_aux_info *aux,
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
+void mark_frame_scoped_arg(struct bpf_func_state *callee, u32 regno);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..51c310ea4e82 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -307,15 +307,13 @@ struct bpf_stack_state {
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
@@ -333,6 +331,8 @@ struct bpf_reference_state {
 		 * it matches on unlock.
 		 */
 		void *ptr;
+		/* For REF_TYPE_FRAME */
+		u32 frameno;
 	};
 };
 
@@ -387,6 +387,11 @@ struct bpf_func_state {
 	u32 callback_depth;
 	/* Instructions processed in this frame and callees on the current path. */
 	u32 insns_subtotal;
+	/*
+	 * Set for arguments valid until the frame is popped.
+	 * Consumed by setup_func_entry().
+	 */
+	u16 frame_scoped_args;
 
 	/* The following fields should be last. See copy_func_state() */
 	/* The state of the stack. Each element of the array describes BPF_REG_SIZE
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index 66fb11b6c6a7..bf7efe5bcdca 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -898,6 +898,10 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
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
index d62c0f74cff5..a0a9d3d18f63 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1474,14 +1474,13 @@ static int grow_stack_arg_slots(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Acquire a pointer id from the env and update the state->refs to include
- * this new pointer reference.
- * On success, returns a valid pointer id to associate with the register
- * On failure, returns a negative errno.
+/* Append an entry to @state->refs and record the instruction that created it.
+ * The caller fills in the type and the id.
+ * On success, returns the new entry. On failure, returns NULL.
  */
-static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
+static struct bpf_reference_state *__acquire_reference_state(struct bpf_verifier_state *state,
+							     int insn_idx)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	int new_ofs = state->acquired_refs;
 	int err;
 
@@ -1493,6 +1492,12 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 	return &state->refs[new_ofs];
 }
 
+static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env,
+							   int insn_idx)
+{
+	return __acquire_reference_state(env->cur_state, insn_idx);
+}
+
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id)
 {
 	struct bpf_reference_state *s;
@@ -1507,6 +1512,31 @@ static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int par
 	return s->id;
 }
 
+/* Acquire a reference owned by frame @frameno of @state */
+static int acquire_frame_reference(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
+				   int insn_idx, u32 frameno)
+{
+	struct bpf_reference_state *s;
+
+	s = __acquire_reference_state(state, insn_idx);
+	if (!s)
+		return -ENOMEM;
+	s->type = REF_TYPE_FRAME;
+	s->id = ++env->id_gen;
+	s->frameno = frameno;
+	return s->id;
+}
+
+/*
+ * Declare that @regno in @callee holds a value that stops being valid once the
+ * frame is popped. setup_func_entry() turns each declaration into a frame-owned
+ * reference.
+ */
+void mark_frame_scoped_arg(struct bpf_func_state *callee, u32 regno)
+{
+	callee->frame_scoped_args |= BIT(regno);
+}
+
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
@@ -10175,7 +10205,7 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 				continue;
 
 			/* Free objects derived from the current object */
-			if (reg->parent_id == id) {
+			if (reg->parent_id == id && reg->id != id) {
 				err = idstack_push(idstack, reg->id);
 				if (err)
 					return err;
@@ -10206,6 +10236,34 @@ static int release_reference(struct bpf_verifier_env *env, int id)
 	return 0;
 }
 
+/* Find the first reference owned by frame @frameno, or 0 if it owns none. */
+static u32 frame_reference_id(struct bpf_verifier_state *state, u32 frameno)
+{
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++)
+		if (state->refs[i].type == REF_TYPE_FRAME &&
+		    state->refs[i].frameno == frameno)
+			return state->refs[i].id;
+
+	return 0;
+}
+
+static int release_frame_reference(struct bpf_verifier_env *env, int id)
+{
+	struct bpf_verifier_state *state = env->cur_state;
+	int i;
+
+	for (i = 0; i < state->acquired_refs; i++) {
+		if (state->refs[i].type != REF_TYPE_FRAME || state->refs[i].id != id)
+			continue;
+		release_reference_state(state, i);
+		break;
+	}
+
+	return release_reference(env, id);
+}
+
 static void invalidate_non_owning_refs(struct bpf_verifier_env *env)
 {
 	struct bpf_func_state *unused;
@@ -10301,7 +10359,8 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 			    struct bpf_verifier_state *state)
 {
 	struct bpf_func_state *caller, *callee;
-	int err;
+	u16 scoped_args;
+	int err, regno;
 
 	if (state->curframe + 1 >= MAX_CALL_FRAMES) {
 		verbose(env, "the call stack of %d frames is too deep\n",
@@ -10333,6 +10392,30 @@ static int setup_func_entry(struct bpf_verifier_env *env, int subprog, int calls
 	if (err)
 		goto err_out;
 
+	scoped_args = callee->frame_scoped_args;
+	callee->frame_scoped_args = 0;
+	for (regno = 0; regno < MAX_BPF_REG; regno++) {
+		int id;
+
+		if (!(scoped_args & BIT(regno)))
+			continue;
+
+		id = acquire_frame_reference(env, state, callsite, callee->frameno);
+		if (id < 0) {
+			err = id;
+			goto err_out;
+		}
+		/*
+		 * The value is its own lifetime anchor: there is no associated
+		 * object to borrow from, only the frame. parent_id = id here
+		 * covers both possible derived references:
+		 *  - through the id (e.g. dynptr slice)
+		 *  - through parent_id (e.g. dynptr clone)
+		 */
+		callee->regs[regno].id = id;
+		callee->regs[regno].parent_id = id;
+	}
+
 	/* only increment it after check_reg_arg() finished */
 	state->curframe++;
 
@@ -10560,6 +10643,10 @@ static int push_callback_call(struct bpf_verifier_env *env, struct bpf_insn *ins
 		if (err)
 			return err;
 
+		if (verifier_bug_if(callee->frame_scoped_args, env,
+				    "frame-scoped argument declared for async callback"))
+			return -EFAULT;
+
 		return 0;
 	}
 
@@ -11033,7 +11120,7 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	struct bpf_func_state *caller, *callee;
 	struct bpf_reg_state *r0;
 	bool in_callback_fn;
-	u32 i, nregs;
+	u32 i, nregs, id;
 	int err;
 
 	callee = state->frame[state->curframe];
@@ -11106,6 +11193,17 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 		verbose(env, "to caller at %d:\n", *insn_idx);
 		print_verifier_state(env, state, caller->frameno, true);
 	}
+
+	/*
+	 * Values the caller only guaranteed for the duration of the call stop
+	 * being valid here.
+	 */
+	while ((id = frame_reference_id(state, callee->frameno))) {
+		err = release_frame_reference(env, id);
+		if (err)
+			return err;
+	}
+
 	account_processed_insns(env, callee, caller);
 	/* clear everything in the callee. In case of exceptional exits using
 	 * bpf_throw, this will be done by copy_verifier_state for extra frames. */
@@ -11283,6 +11381,11 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
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
2.55.0

