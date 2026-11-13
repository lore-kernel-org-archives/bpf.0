Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.117
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606004;
	b=WHjWB+BTZ7C5SM6SVw0e2M/HseOBYqdaXt0IC+mOQTFsIsp3NJ1Jsthj+q8NAPZA/NMl
	 607j2SCNMO9mf0C8FFIx410stDbGskS8/f9Qr7tpWHxddTRgX6CpcvN0l54n8msTsY7gI
	 gXdQUdE/+gexpM+zjgS44GGNGFpGJYfVm126jkC4Kk/ItHeHBjXcbTmrhavlZgUDPhE8A
	 NyIxphuJbej/LZIALd1Eb+PmdS8dKVyfjQ+bfeAU2eqS2WuxJ8blaesv8OxXMwCbJjFYm
	 GIxz65rpMBIVd+6myX26DF7iOIIuNu899NlSIQBBr+osZRNqwc9Tfwfq+3y0ykKTXRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606004;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o6BLMWGyYA/eRwNUSGfhLzF/PmgCxowd+1uKcbGHQA0=;
	b=N0badI5qHDo8o4wwyEOOJdPaiy78A0y71FgJ04dRZkOQigs8asoA+tu8Nmbn4dJ1gD3G
	 nCniV5LweCIrBB2hqdhS9p1KAc9jEXcRp6E5+Yf8r72EjfQm47RZNnAfXmcy3pYTiekpG
	 aFNFb/ol/rhoUaE20ONIyR0e+fzxbDFR8+za8TRJU/JGhBTcDgfLAp+mvuLPPETgN8E6E
	 /OI7scvzw8BMqwrqTBIZFDvpXIrFXBcjqA4vm5qKvXUxzVwYZznH16R//EQ9HpQDWrRDg
	 NWpeQB1P+bAWcJzNOxmJTbbJRRSUVZc5snonTVI0jz/u0R1qV8QD99T7YUCQibd/x8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="F7dL/CLa";
	arc=none smtp.remote-ip=95.215.58.117
Received: from mta1.migadu.com (out-117.mta1.migadu.com [95.215.58.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C87C606A8B8
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C87C606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F7dL/CLa
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uOMBHIAh2voUel2PSBXq9GwHi/7oyUlmSAxCygMdB5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794606001; v=1; x=1795210801;
 b=F7dL/CLa+iE34809PXQNt31PlApX/uuvCDRmDLnS7cqt4tgJ3EGjuOVsPp3qZYiN507KrgLD
 91MUl8bCrlyR0ZPKNhkfzKiuTF1ON64tLM8skEWICEuK0fwKBOKUDquLr+uxAiqQFTqbgpWjtNL
 8dGzucpMDEM5HARJ6tjgw90E=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 74e642830b745cab;
	Fri, 13 Nov 2026 21:40:01 +0000
X-Mizu-Trace-ID: 74e642830b745cab
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
Subject: [PATCH bpf-next v4 5/6] bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
Date: Fri, 13 Nov 2026 14:39:20 -0700
Message-ID: <20261113213921.1646681-6-ihor.solodrai@linux.dev>
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

bpf_for_each_map_elem() passes array and per-CPU array callbacks the
address of a key on the helper's stack.

A callback can save that pointer in its context and dereference it
after the helper returns. Loads through PTR_TO_MAP_KEY are not
fault-protected, allowing a four-byte read-only leak of reused kernel
stack.

The verifier tracks the pointer's type and key size, but does not tie
its lifetime to the callback invocation.

Scope R2 to the callback frame in the array map callback setup so the
key and its copies are invalidated on callback return. Leave hash keys
and map values unchanged, since their storage is not callback-local.

Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/arraymap.c | 19 +++++++++++++++++--
 kernel/bpf/verifier.c |  4 ++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..36587b63ce13 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3291,6 +3291,8 @@ int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
 int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 				   struct bpf_func_state *caller,
 				   struct bpf_func_state *callee);
+void mark_frame_scoped_arg(struct bpf_verifier_env *env,
+			   struct bpf_func_state *callee, u32 regno);
 
 int bpf_percpu_hash_copy(struct bpf_map *map, void *key, void *value, u64 flags);
 int bpf_percpu_array_copy(struct bpf_map *map, void *key, void *value, u64 flags);
diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 133f189bf6d2..508706d0c360 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -855,6 +855,21 @@ static u64 array_map_mem_usage(const struct bpf_map *map)
 	return usage;
 }
 
+static int array_map_set_for_each_callback_args(struct bpf_verifier_env *env,
+						struct bpf_func_state *caller,
+						struct bpf_func_state *callee)
+{
+	int err;
+
+	err = map_set_for_each_callback_args(env, caller, callee);
+	if (err)
+		return err;
+
+	/* the key is on the stack of bpf_for_each_array_elem() */
+	mark_frame_scoped_arg(env, callee, BPF_REG_2);
+	return 0;
+}
+
 BTF_ID_LIST_SINGLE(array_map_btf_ids, struct, bpf_array)
 const struct bpf_map_ops array_map_ops = {
 	.map_meta_equal = array_map_meta_equal,
@@ -875,7 +890,7 @@ const struct bpf_map_ops array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
@@ -900,7 +915,7 @@ const struct bpf_map_ops percpu_array_map_ops = {
 	.map_check_btf = array_map_check_btf,
 	.map_lookup_batch = generic_map_lookup_batch,
 	.map_update_batch = generic_map_update_batch,
-	.map_set_for_each_callback_args = map_set_for_each_callback_args,
+	.map_set_for_each_callback_args = array_map_set_for_each_callback_args,
 	.map_for_each_callback = bpf_for_each_array_elem,
 	.map_mem_usage = array_map_mem_usage,
 	.map_btf_id = &array_map_btf_ids[0],
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 995a5edf66a8..ce11e78c7c98 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12246,8 +12246,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
 }
 
 /* The arg points into the stack frame of the helper that calls the callback */
-static void mark_frame_scoped_arg(struct bpf_verifier_env *env,
-				  struct bpf_func_state *callee, u32 regno)
+void mark_frame_scoped_arg(struct bpf_verifier_env *env,
+			   struct bpf_func_state *callee, u32 regno)
 {
 	if (!callee->frame_id)
 		callee->frame_id = ++env->id_gen;
-- 
2.56.0

