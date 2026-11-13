Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605996;
	b=n46PVskXoCs17SBDLElsjmGZ8MUjEiGTXNuSdWv18CqJbhWAwzKttarmaIGzQ8PBTjf3
	 j70WbX+KO3AnuPuMY2gy0VFNW4D4/F9AkE6InFZa7wHYzZjIxj4MsDDIHX4OMTd2SmYTP
	 GcKta3xnQy88HT/3NI4LXLzI/XlbmdkrA3E1gpKXyUr+uAqMGG7EfNHakFUmXW/y3HR2Z
	 u+cQsDnnYXLOZm7+Nz+Jb7AU4eudJED7FlWYElv++Ewtvu0eRjd+HaO7TWA928V4TKuzr
	 5LUNU9I4Cwac+2nDcTNt2BBvvJk43gQiNzBAAydbp6wvbRSCM0BfX3VplQ3brSN3MAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605996;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zoQTU4nf45DptmyEqzy2o25bIB3hQB6v8aMS4cIKpbA=;
	b=YOyLa2RjTaN9nYzM2Lip7SDBoV4K5K6XW7ykMXSMxQvtm/j3a8ROOHeF8ChFyHS8p3FS
	 ylXej2Fyr1bTagsmYvkLiOeQc8ZAynQjYv/moi3N1o4pxGTI7clcHtaOzm2wlN2D+Ie5p
	 /Dx1X+A08+pJcfORU3ahXqwgzmB7+XmK3Iqhb7l/rQZ7jeMH4gg6sjn66ngPRsq9Tc8xy
	 o79HVv5JO7DBV9inESbei5BBcDcjgdkoikMR+RBY7ixmZTJXoWKH4SKmBAZAp+rT8HJAa
	 8EQTKj0hQaGaD0O4gnN4/o64P6xZaxHponqzwOLxUc5MNiqWQGBRF4D8vf72GZqAPJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X0z+Fj9y;
	arc=none smtp.remote-ip=91.218.175.66
Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B5606A885
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17B5606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X0z+Fj9y
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=JVF8XJpM5b/KIvQmyyZvfVvwDnvFNbc7OlSQOAfW4lc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794605992; v=1; x=1795210792;
 b=X0z+Fj9yeR6cddx4BRnF3VinP/DegjWru+JuCmTmbBOIvpsWeG8qf28mMGNr+uKZqm+AbPqO
 j2VUFkFItCnsc+OHDUVgAa787w3JbhjscFb/dzSPVLlW9CVWhQDVxakKdsVYeC1ZZiUewH6qwgo
 9fbjLseszfvmFRZgAU+0gNZA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id c4ad31d0c87e22c0;
	Fri, 13 Nov 2026 21:39:52 +0000
X-Mizu-Trace-ID: c4ad31d0c87e22c0
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
Subject: [PATCH bpf-next v4 3/6] bpf: Scope the bpf_user_ringbuf_drain() dynptr to its callback frame
Date: Fri, 13 Nov 2026 14:39:18 -0700
Message-ID: <20261113213921.1646681-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
References: <20261113213921.1646681-1-ihor.solodrai@linux.dev>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dynptr argument to a bpf_user_ringbuf_drain() callback points to a
descriptor on the helper's stack. The descriptor and the sample it
describes are valid only during that callback invocation.

The callback can save the dynptr pointer, a slice, or a clone in the
caller's frame and use it after the drain returns. An escaped descriptor
pointer can allow arbitrary kernel read/write once the helper's stack
is reused.

The verifier assigns the dynptr a type and an id, but does not tie it
or its descendants to the callback's lifetime.

Give the callback frame an id and make it both the id and the parent_id
of R1, then invalidate that id and everything derived from it when the
frame is popped. R1 has to be its own parent: slices take the dynptr's
id as their parent_id, and bpf_dynptr_data() clobbers R1, so with a
separate dynptr id nothing would connect a slice to the frame.

Pair the frame id in join_func() like any other id, so joining states
from different callback frames cannot link a value to the wrong frame.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/join.c            |  3 +++
 kernel/bpf/states.c          |  3 +++
 kernel/bpf/verifier.c        | 16 ++++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 0d039742c97a..716330b3a975 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -477,6 +477,8 @@ struct bpf_func_state {
 	 * reused after returns, while this ID is preserved across state clones.
 	 */
 	u32 diag_frame_id;
+	/* parent_id of the args that are gone when this frame returns */
+	u32 frame_id;
 	/* subprog number == index within subprog_info
 	 * zero == main subprog
 	 */
diff --git a/kernel/bpf/join.c b/kernel/bpf/join.c
index 295dfd769320..67211f329907 100644
--- a/kernel/bpf/join.c
+++ b/kernel/bpf/join.c
@@ -424,6 +424,9 @@ static bool join_func(struct bpf_join_state *js, struct bpf_func_state *fd,
 			return false;
 		if (!join_loop_stack(fa, fb))
 			return false;
+		jid_note(js, fa->frame_id, fb->frame_id);
+	} else if (!jid_strict_ok(js, fa->frame_id, fb->frame_id)) {
+		return false;
 	}
 
 	for (i = 0; i < MAX_BPF_REG; i++) {
diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index b2daad5e78c7..a37b04347392 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -628,6 +628,9 @@ static bool func_states_equal(struct bpf_verifier_env *env, struct bpf_func_stat
 	    old->entry_preempt_locks != cur->entry_preempt_locks)
 		return false;
 
+	if (!check_ids(old->frame_id, cur->frame_id, &env->idmap_scratch))
+		return false;
+
 	for (i = 0; i < MAX_BPF_REG; i++)
 		if (((1 << i) & live_regs) &&
 		    !regsafe(env, &old->regs[i], &cur->regs[i], &env->idmap_scratch))
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3462e9b50d66..995a5edf66a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12245,6 +12245,16 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	return 0;
 }
 
+/* The arg points into the stack frame of the helper that calls the callback */
+static void mark_frame_scoped_arg(struct bpf_verifier_env *env,
+				  struct bpf_func_state *callee, u32 regno)
+{
+	if (!callee->frame_id)
+		callee->frame_id = ++env->id_gen;
+	callee->regs[regno].id = callee->frame_id;
+	callee->regs[regno].parent_id = callee->frame_id;
+}
+
 static int set_callee_state(struct bpf_verifier_env *env,
 			    struct bpf_func_state *caller,
 			    struct bpf_func_state *callee, int insn_idx)
@@ -12368,6 +12378,7 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
 	 * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
 	 */
 	mark_dynptr_cb_reg(env, &callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
+	mark_frame_scoped_arg(env, callee, BPF_REG_1);
 	callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
 
 	callee->in_callback_fn = true;
@@ -12606,6 +12617,11 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
 	if (err)
 		return err;
 	invalidate_stack_slices(env, callee->frameno, INT_MIN, 0);
+	if (callee->frame_id) {
+		err = invalidate_reference(env, callee->frame_id);
+		if (err)
+			return err;
+	}
 
 	/* for callbacks like bpf_loop or bpf_for_each_map_elem go back to callsite,
 	 * there function call logic would reschedule callback visit.
-- 
2.56.0

