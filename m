Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794007282;
	b=h3lYf2ypSEq6LnJQZzRDmces5gI0yx8Vt/Xw9td31tkkyZN9IGBWTPIDaTUepoQZcgQj
	 OwYPz0hVsqJd0NtVwK5jBNcJDrMg6oQiJI0Zaik1RtCQDLC+MUq/9GlgJGdzIzoai0oZ2
	 0fpmXc7mIV8zBJ/TR1srzn8PqzpREZo76HvaMD+RDzfFav9xl5xdBO2sLHUYd9LikC/RM
	 bC9BDHVuCfkVEuaTPI88wVLYNg7dTN/a6TDrt3gkyTClfyapWCUJ0pyCYHpv3fzGvKyDe
	 VDvHgYRbwLl86puxQn1yPtQEQJAHYKkFTvrHiykxuGBrv8qPxsjS+RxFeem6VIWRFzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007282;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DKjzSB3hNwK17fYFqxMQb++9oXpcwDQtGYzQS+quS9E=;
	b=ALoja3NEggUJXoeb61QJuw8QDvYnor7vB1Q1S4zMkl0AG6y05kIpLdyJgl4BVEm26ozS
	 62oncfILufP2RjUCbu8QsQH+zWoxc5bz8Oc+UxKjXYp/HnVxSJJaT6iJmonu7Y9Hd3btw
	 g1adpqCQesWxF+ruh0eBk+DwvMsm7+qBWK+4/KsQSfRp7ihPqVS5KSPGFLIJeG3kCRdfQ
	 2rRF7mbKanJ99sUHQaT/ln/wY6zLmaI4docrLA9vZ9lQO8faufPC1qAe8LfBsDmNjD9We
	 k9a+E87A7zIZuXBcYY2lyiTUvQMFo3+EMrPP+CcTZ/YU8XRWezqjn6cDqj9yY2XJv0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SePRUO0i;
	arc=none smtp.remote-ip=95.215.58.176
Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DEE606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DEE606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SePRUO0i
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=weidGywD0nZEBv6zr+OwX2zvTonparTAWfuBs6nrVLQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794007278; v=1; x=1794612078;
 b=SePRUO0imyoutl37ki93oj2RnJDq4TvMpsIxKuDU7u20ixRhvKQv8meX8rM7usY6lRslvjJv
 paLKO29VoGJYMdemmEy0ChSst3li3ddwuAWlz+NHfd+2ZP38eVvAP9SOqexM1IU06a2ANLwcQTe
 zak8kxHnVUkOl4jleJpNZM1U=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id fc4cc6e662f1191e;
	Fri, 06 Nov 2026 23:21:18 +0000
X-Mizu-Trace-ID: fc4cc6e662f1191e
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
Subject: [PATCH bpf-next v1 1/2] bpf: Share map-backed callback register setup
Date: Fri,  6 Nov 2026 16:21:09 -0700
Message-ID: <20261106232110.2867412-1-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
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

Map iteration, timer, task-work and RCU callbacks repeat the same register
type, offset and map-metadata setup for their map, key and value arguments.

Use one initializer for map-backed callback registers. Leave argument
selection, value ids and callback-specific policy in each setter.

No functional change.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 kernel/bpf/verifier.c | 81 +++++++++++--------------------------------
 1 file changed, 21 insertions(+), 60 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b58a1796a2e..389488e4e7a7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11958,6 +11958,16 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return check_static_func_call(env, subprog, insn_idx);
 }
 
+static void mark_map_callback_reg(struct bpf_reg_state *reg,
+				  const struct bpf_reg_state *map_reg,
+				  enum bpf_reg_type type)
+{
+	reg->type = type;
+	__mark_reg_known_zero(reg);
+	reg->map_ptr = map_reg->map_ptr;
+	reg->map_uid = map_reg->map_uid;
+}
+
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee)
@@ -11969,15 +11979,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 	 */
 	callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
 
-	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
-	callee->regs[BPF_REG_2].map_ptr = caller->regs[BPF_REG_1].map_ptr;
-	callee->regs[BPF_REG_2].map_uid = caller->regs[BPF_REG_1].map_uid;
-
-	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
-	callee->regs[BPF_REG_3].map_ptr = caller->regs[BPF_REG_1].map_ptr;
-	callee->regs[BPF_REG_3].map_uid = caller->regs[BPF_REG_1].map_uid;
+	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1], PTR_TO_MAP_KEY);
+	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* pointer to stack or null */
@@ -12068,26 +12071,12 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 				    struct bpf_func_state *callee,
 				    int insn_idx)
 {
-	struct bpf_map *map_ptr = caller->regs[BPF_REG_1].map_ptr;
-	u32 map_uid = caller->regs[BPF_REG_1].map_uid;
-
 	/* bpf_timer_set_callback(struct bpf_timer *timer, void *callback_fn);
 	 * callback_fn(struct bpf_map *map, void *key, void *value);
 	 */
-	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
-	callee->regs[BPF_REG_1].map_ptr = map_ptr;
-	callee->regs[BPF_REG_1].map_uid = map_uid;
-
-	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
-	callee->regs[BPF_REG_2].map_ptr = map_ptr;
-	callee->regs[BPF_REG_2].map_uid = map_uid;
-
-	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
-	callee->regs[BPF_REG_3].map_ptr = map_ptr;
-	callee->regs[BPF_REG_3].map_uid = map_uid;
+	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_1], CONST_PTR_TO_MAP);
+	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_1], PTR_TO_MAP_KEY);
+	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_1], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
@@ -12189,26 +12178,12 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
 						 struct bpf_func_state *callee,
 						 int insn_idx)
 {
-	struct bpf_map *map_ptr = caller->regs[BPF_REG_3].map_ptr;
-	u32 map_uid = caller->regs[BPF_REG_3].map_uid;
-
 	/*
 	 * callback_fn(struct bpf_map *map, void *key, void *value);
 	 */
-	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
-	callee->regs[BPF_REG_1].map_ptr = map_ptr;
-	callee->regs[BPF_REG_1].map_uid = map_uid;
-
-	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
-	callee->regs[BPF_REG_2].map_ptr = map_ptr;
-	callee->regs[BPF_REG_2].map_uid = map_uid;
-
-	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
-	callee->regs[BPF_REG_3].map_ptr = map_ptr;
-	callee->regs[BPF_REG_3].map_uid = map_uid;
+	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_3], CONST_PTR_TO_MAP);
+	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_3], PTR_TO_MAP_KEY);
+	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_3], PTR_TO_MAP_VALUE);
 	callee->regs[BPF_REG_3].id = ++env->id_gen;
 
 	/* unused */
@@ -12224,26 +12199,12 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
 				  struct bpf_func_state *callee,
 				  int insn_idx)
 {
-	struct bpf_map *map_ptr = caller->regs[BPF_REG_2].map_ptr;
-	u32 map_uid = caller->regs[BPF_REG_2].map_uid;
-
 	/*
 	 * callback_fn(struct bpf_map *map, void *key, void *value);
 	 */
-	callee->regs[BPF_REG_1].type = CONST_PTR_TO_MAP;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_1]);
-	callee->regs[BPF_REG_1].map_ptr = map_ptr;
-	callee->regs[BPF_REG_1].map_uid = map_uid;
-
-	callee->regs[BPF_REG_2].type = PTR_TO_MAP_KEY;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_2]);
-	callee->regs[BPF_REG_2].map_ptr = map_ptr;
-	callee->regs[BPF_REG_2].map_uid = map_uid;
-
-	callee->regs[BPF_REG_3].type = PTR_TO_MAP_VALUE;
-	__mark_reg_known_zero(&callee->regs[BPF_REG_3]);
-	callee->regs[BPF_REG_3].map_ptr = map_ptr;
-	callee->regs[BPF_REG_3].map_uid = map_uid;
+	mark_map_callback_reg(&callee->regs[BPF_REG_1], &caller->regs[BPF_REG_2], CONST_PTR_TO_MAP);
+	mark_map_callback_reg(&callee->regs[BPF_REG_2], &caller->regs[BPF_REG_2], PTR_TO_MAP_KEY);
+	mark_map_callback_reg(&callee->regs[BPF_REG_3], &caller->regs[BPF_REG_2], PTR_TO_MAP_VALUE);
 
 	/* unused */
 	bpf_mark_reg_not_init(env, &callee->regs[BPF_REG_4]);

base-commit: 3e18218484126afb9da722080659c038cb2256ab
-- 
2.56.0

