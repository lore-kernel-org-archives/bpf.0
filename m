Received: from mta1.migadu.com (out-115.mta1.migadu.com [95.215.58.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AA48595E
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577718; cv=none; b=Xf8yPddQOihugFYoo4sRnLk+BpehoQY5HXABTPUuzsJfUk4foS2FokzIlK4VmzumOK0oRMkTRevrQJFUpo6mDELLHloeL5pL5q8vCMJemvkeWhZoATCsoIcFmjgQZYGQmJCJwlXkZJeXMDsCgqnAV1F0WCbEw9RXCNd+9j4AsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577718; c=relaxed/simple;
	bh=Fk6IbwxLCRHyqNLGA9vr1AJAvk3XKFCLsDSugFuHLNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNhrZJjKlCLZ75mBOgRztj2UwqDBamtipMX+JMYHYcWaQI3avkvWkROfrdf2GTBSkJg9OmNctCGzsLYjIs/TBA3xlqUjmSttmoIb/i1D+bIy0BkyO/5aqEgLjPAdhkx6YS8knARoziDa2+At+IR9j9UaIkGepUY8qSGVD39bZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SQK60uN0; arc=none smtp.client-ip=95.215.58.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SQK60uN0"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Fk6IbwxLCRHyqNLGA9vr1AJAvk3XKFCLsDSugFuHLNk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577714; v=1; x=1792182514;
 b=SQK60uN09Q7+o41eKlR0kkuV8TmrUGnfuKTJ4BPz33M4zCoXv90jslBYXqyuFprhvWmX6wwM
 U4owtclq9Wkdcct9m4N6AfZQ2I0rJXWV4UiVW+mIt4Gz4F0cKABiOxrd3fPHRsyEP/eNbsZcTPq
 kDeDfZ9Fx7nnFaABNUj875/c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a40a8b37256890ac;
	Fri, 09 Oct 2026 20:28:34 +0000
X-Mizu-Trace-ID: a40a8b37256890ac
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
Subject: [PATCH bpf-next v2 05/11] bpf: Share map-backed callback register setup
Date: Fri,  9 Oct 2026 13:27:52 -0700
Message-ID: <20261009202759.50520-6-ihor.solodrai@linux.dev>
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
index 88b86f658e4a..8f2125c6e348 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11267,6 +11267,16 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
 				   struct bpf_verifier_state *state,
 				   struct bpf_func_state *caller,
@@ -11279,15 +11289,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
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
@@ -11354,26 +11357,12 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
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
@@ -11477,26 +11466,12 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
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
@@ -11513,26 +11488,12 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
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
-- 
2.56.0

