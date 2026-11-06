Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006749;
	b=tgScCyd+qgq39A9FtGsp+AUagMj1M+cywk34Re1XmQMJ7TYwg6KJiEweeHj+MXPY0QVH
	 IlDLEOdryQfdB4L83F3rf1lK2BDehyMxVt1eWeqdia5lPxmdGa1V5FrwQ0bnC3fSch30y
	 X8rp8aSjxImePbay6+tj3o7w9qfca9dMagrKZ6IzMPrGrIoMws1x2suhXsR/Fl/NvjzhY
	 fgDRZ98npItsqsigNHsgi8z7+CToqxKRFzJ72PybkczcILbEuCUWlthT9itdzJwZWwbT7
	 +KmxiK8yVm/O2QGUjQJ/W6Ew76MI1JRhPSQAKA32JyNvlKcOF/tdFOUY/0WMJws7pNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006749;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9uBI3J/n8hUUYc+E9E7dripe3ourxtY6wpV5hMK0nNY=;
	b=YytorejUPENbJenonPY7Zhv00CRlYfUYFYU0p8zTkGzkiM3Maqm6AR3Xjad32fgaXsMn
	 jjHqOzkYF1vvpuHEpwsDA7Y7sk8KpNsIWEA7MePQ4X4KETYkEvKHy1jzUZEyOlFrwl0Sa
	 Dj6OAHUxr9HkKyHvAx/k8BGL1ffr9neG43g/tf+qRIG+IaO3k2wZoiX22oBHn9Sq6xtFr
	 PI2ky2CSvZJPN56i8TyK6H9G48Ii/Fm1zqUhGfYTERBWmFtUqIblXwxwwGTLBWtymIaKN
	 5aqaCb/mASu1qyCTGv+MVDJUonWogZAG1/lpA3b49kxZpRpXkJjhYBes6H4UNNURykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OTOMvkCA;
	arc=none smtp.remote-ip=91.218.175.40
Received: from mta0.migadu.com (out-40.mta0.migadu.com [91.218.175.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC0606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DDC0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OTOMvkCA
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=I+3t72chMlrOR4VW2ZwGApanhoUwxLjtcZiuun3B0k0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006746; v=1; x=1794611546;
 b=OTOMvkCArg/UdkeTVuK3BFojdTnRYeHAvZ4xgsRvdlv6Y/xIk3tguDDDUERCBo7lyQh5yYo2
 pEip9l9QWmqhxkQtBG4ii6G/EDD8x1OflrOJmBlov06WOfa80ugjkS9AIQls7OPwzaclBz66tLt
 RyPDHEOc3DuOGLmeg7i+/udU=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 94a27417d50178b8;
	Fri, 06 Nov 2026 23:12:25 +0000
X-Mizu-Trace-ID: 94a27417d50178b8
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
Subject: [PATCH bpf v1 3/4] bpf: Scope the bpf_for_each_map_elem() array key to the callback frame
Date: Fri,  6 Nov 2026 16:11:56 -0700
Message-ID: <20261106231157.2840635-4-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
References: <20261106231157.2840635-1-ihor.solodrai@linux.dev>
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

Fixes: 06dcdcd4b9e8 ("bpf: Add arraymap support for bpf_for_each_map_elem() helper")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 include/linux/bpf.h   |  2 ++
 kernel/bpf/arraymap.c | 19 +++++++++++++++++--
 kernel/bpf/verifier.c |  4 ++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fdbf638300fc..0a41166c9fff 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3236,6 +3236,8 @@ int bpf_iter_map_check_value_write(const struct bpf_prog *prog,
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
index a801b8da2b63..07348b9b88c9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11805,8 +11805,8 @@ int map_set_for_each_callback_args(struct bpf_verifier_env *env,
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

