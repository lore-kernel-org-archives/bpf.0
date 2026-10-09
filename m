Received: from mta0.migadu.com (out-31.mta0.migadu.com [91.218.175.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC895012B5
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577714; cv=none; b=HVcoqmrW/kauojeyemtVb0DqVzunsVO0/Ua62sKxdTEUfOqCg5CCNKu9H0rho5BMjsZe4fyncqn925CPmqj5QK63HYIAJGbb6a8tTE5thpfE3B1ercbwRbdo+MbFbhTFcUT+LF3ENL8yoda59D7jFdDJiu3ZKW3zRO5/+dRqLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577714; c=relaxed/simple;
	bh=i1b57pRh/t8JW15i8kWsi10Trxaun8ksv67rkEKKzeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjB6+vURhN66MnVOZZQfDsn1JyDjYa7MzCBAKSM5hXJKtmvGYs2fgBvgiKZ+ySL43C2qry4x301ouIIv5UqMv+OEfZZeXM/JBhH2flqDmwYZKCotshdE2vKGwvQqIJra9eVKn6gmpZh4PvsX6sKvUWh3TkVKBYhfdRSXaCNOCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJMWTqVn; arc=none smtp.client-ip=91.218.175.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJMWTqVn"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i1b57pRh/t8JW15i8kWsi10Trxaun8ksv67rkEKKzeQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577707; v=1; x=1792182507;
 b=lJMWTqVnFESnlDMNccpnOIuqrBKmdug85Uzvqjc4784Y8u+CPF/HMFM/lLI+9OUMwuvpoS5j
 7qMs6kg4ZYF5l4qO1nMWD4n/AHFLVt+cigzwIiZzxI9DdwMq4ssE2fzTJSgMK+6rq3v96/dbMmv
 mH4ZQxBvBMidwKZwpFXaB+e0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 403d3f4752775e56;
	Fri, 09 Oct 2026 20:28:27 +0000
X-Mizu-Trace-ID: 403d3f4752775e56
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
Subject: [PATCH bpf-next v2 03/11] bpf: Append complete reference states
Date: Fri,  9 Oct 2026 13:27:50 -0700
Message-ID: <20261009202759.50520-4-ihor.solodrai@linux.dev>
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

Reference acquisition exposes an uninitialized entry for each caller to
fill after insertion.

Accept a complete reference entry and return its id after insertion. Keep
lock and IRQ accounting and acquisition diagnostics in their callers.
Take the target state directly so acquisition can also serve queued
callback states.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 73 +++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8d6812fee0c9..62b991f3c39a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1497,51 +1497,53 @@ static int grow_stack_arg_slots(struct bpf_verifier_env *env,
 	return 0;
 }
 
-/* Acquire a pointer id from the env and update the state->refs to include
- * this new pointer reference.
- * On success, returns a valid pointer id to associate with the register
- * On failure, returns a negative errno.
+/*
+ * Append @ref to @state->refs. Return its id, or a negative errno.
  */
-static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_env *env, int insn_idx)
+static int acquire_reference_state(struct bpf_verifier_state *state,
+				   const struct bpf_reference_state *ref)
 {
-	struct bpf_verifier_state *state = env->cur_state;
 	int new_ofs = state->acquired_refs;
 	int err;
 
 	err = resize_reference_state(state, state->acquired_refs + 1);
 	if (err)
-		return NULL;
-	state->refs[new_ofs].insn_idx = insn_idx;
-
-	return &state->refs[new_ofs];
+		return err;
+	state->refs[new_ofs] = *ref;
+	return ref->id;
 }
 
 static int acquire_reference(struct bpf_verifier_env *env, int insn_idx, int parent_id)
 {
-	struct bpf_reference_state *s;
+	struct bpf_reference_state ref = {
+		.type = REF_TYPE_PTR,
+		.id = ++env->id_gen,
+		.insn_idx = insn_idx,
+		.parent_id = parent_id,
+	};
+	int id;
 
-	s = acquire_reference_state(env, insn_idx);
-	if (!s)
-		return -ENOMEM;
-	s->type = REF_TYPE_PTR;
-	s->id = ++env->id_gen;
-	s->parent_id = parent_id;
-	bpf_diag_record_ref_acquire(env, insn_idx, s->id);
-	return s->id;
+	id = acquire_reference_state(env->cur_state, &ref);
+	if (id >= 0)
+		bpf_diag_record_ref_acquire(env, insn_idx, id);
+	return id;
 }
 
 static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum ref_state_type type,
 			      int id, void *ptr)
 {
 	struct bpf_verifier_state *state = env->cur_state;
-	struct bpf_reference_state *s;
+	struct bpf_reference_state ref = {
+		.type = type,
+		.id = id,
+		.insn_idx = insn_idx,
+		.ptr = ptr,
+	};
+	int err;
 
-	s = acquire_reference_state(env, insn_idx);
-	if (!s)
-		return -ENOMEM;
-	s->type = type;
-	s->id = id;
-	s->ptr = ptr;
+	err = acquire_reference_state(state, &ref);
+	if (err < 0)
+		return err;
 
 	state->active_locks++;
 	state->active_lock_id = id;
@@ -1554,18 +1556,21 @@ static int acquire_lock_state(struct bpf_verifier_env *env, int insn_idx, enum r
 static int acquire_irq_state(struct bpf_verifier_env *env, int insn_idx)
 {
 	struct bpf_verifier_state *state = env->cur_state;
-	struct bpf_reference_state *s;
+	struct bpf_reference_state ref = {
+		.type = REF_TYPE_IRQ,
+		.id = ++env->id_gen,
+		.insn_idx = insn_idx,
+	};
+	int id;
 
-	s = acquire_reference_state(env, insn_idx);
-	if (!s)
-		return -ENOMEM;
-	s->type = REF_TYPE_IRQ;
-	s->id = ++env->id_gen;
+	id = acquire_reference_state(state, &ref);
+	if (id < 0)
+		return id;
 
-	state->active_irq_id = s->id;
+	state->active_irq_id = id;
 	bpf_diag_record_context(env, insn_idx, BPF_DIAG_CONTEXT_IRQ, true,
 				bpf_diag_irq_depth(state));
-	return s->id;
+	return id;
 }
 
 static void release_reference_state(struct bpf_verifier_state *state, int idx)
-- 
2.56.0

