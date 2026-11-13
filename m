Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605985;
	b=EffFRWNEclC/SlJQQP/7CSLZHayVROMPwTX1NFrN6diEU1ILSP+pDaUkY2vTMVrbatgB
	 62Z3+En/vumgoH6HixefvNDq3DxuJMkVCjd89bx83CoW6P+if1MDe4OzgB2p+1OYJyuRv
	 K62trWF4SzKP58nV4xan1zniIgWE5f9MrFAd+6ANN9jouOvuewMQc6FxCBmNoyqc1+o+U
	 s/qkR3QH4C9SZQgE5vVchbDBpfDFpM8nTDWHkS2wn4MEPwNUCwU89jvUcQF0a3iZ0Ig14
	 0di33mk8HLA8aiYzYXNqvPIK0oekE3uomJBt7NUoqFCyiSEoTIImEvRWZKAmm1zHWvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605985;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u94aFki2JHrzXWUzYkXMIM3zWcIdJ4IFbBL6XQTANbg=;
	b=0VGV786KjXePvLoRJ5yVV8JUEvNj5g4dvOlLrV7DBF8egTOvE0UPLKYSt0lUh7zcP0J5
	 239oDLyTtc/u2cafDGFj/BSf97qRcBnDfbZnfQPQglcLgyZv29m/t7egX13fUmZu9gASI
	 S+Ado9T/qAFqqDVbfyG1q7apKErBAiskWRbYSLF5meAxbYQIDgbQPJOHQd5PTOMM5Ej6b
	 qzADM+MPPRT1J6UjN5drUh/XRhkFB7M/kYroNrnggOQvm0x7QTwjWACt3Uo4TplUK+QHw
	 /rCRAj0WxnYRgJzD5IQNUrs3/XnYjDHLpnsIJ8bniWswiTtCk5HAt2LxF9ECpQg1aUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ng05LQ+V;
	arc=none smtp.remote-ip=91.218.175.60
Received: from mta0.migadu.com (out-60.mta0.migadu.com [91.218.175.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01314606A8AC
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01314606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ng05LQ+V
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cDCADkqrNAxGiWvFobBoxQptsU/wnt/yOvihiiZ3358=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794605981; v=1; x=1795210781;
 b=Ng05LQ+VI8sUKzyl2TOoV8jZS3ESD0qHtotBJBoZMB8+R0iqSU76H7oXNO3D4oS07c1UXRRc
 bN+M9ELnM9VYZUUYUNuEqkmfTYvWS8rvPdmT2SE2QItAhbasLfC1xH9zn9o9wYms9OyfIlvyI55
 c/4yo5CXKamNyNNzlv9u36Sw=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 0d6927979516cc84;
	Fri, 13 Nov 2026 21:39:41 +0000
X-Mizu-Trace-ID: 0d6927979516cc84
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
Subject: [PATCH bpf-next v4 1/6] bpf: Share map-backed callback register setup
Date: Fri, 13 Nov 2026 14:39:16 -0700
Message-ID: <20261113213921.1646681-2-ihor.solodrai@linux.dev>
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
index bb1659ce7a5c..a3d4a2d6de6a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12215,6 +12215,16 @@ static int check_func_callx(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return check_func_callx_one(env, reg->subprogno, insn_idx);
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
@@ -12226,15 +12236,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
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
@@ -12325,26 +12328,12 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
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
@@ -12446,26 +12435,12 @@ static int set_task_work_schedule_callback_state(struct bpf_verifier_env *env,
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
@@ -12481,26 +12456,12 @@ static int set_rcu_callback_state(struct bpf_verifier_env *env,
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

