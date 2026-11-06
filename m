Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006755;
	b=fUqX1JCftFB6dmnoosphHrmBbxqSNfdeBcHCvvqVyW9W3f7PM3JCO7zPpKYhQnywczsz
	 TVLyfXeya3/i+qiK3Ufx6+vRh1uVfk7D2uMgszwXMsgdorJOlehteMe8LR/XBw+m8YF/4
	 lqiK3IQyEM1ue6GiJH1yNnxoCE9z78/jRvshcF3+k5cxVS8LhvCvdP2hvzi9EAGfPPfKj
	 NigfrcpNCY49DAOxkUkR/lVsnHEu0QsZpLqLVbq9wu+tNvGSvNqPko/7gmLU9ZDc/UGx7
	 t+LzaPePcH3hbBaBJ2xSMlKffCVDjnx0LInNK9LZpqxnoQVq1xHa1Pld1LoUeswF2fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006755;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lGe12Rz/dF9fridaVZTA/bLUfTQ5JtCEMNf4pJ2mgv4=;
	b=f9krIyBrrnuFyWAffwhnqR5MApdn4V2BIuoPCwEioPIXn6tDpqjg269sFP2VUxm/0Wrn
	 Rc8OaqA6ILjKZyLyiege3f3X7aY3Uyrt49JOxy5icEXZBj9OwnB3jboHeuSPKcBkJtQyH
	 mf/JpoW/dxD859/wMIkSvz19eMSQ1brpYGoQglCe+yzZlBjtueB6rp5BDSlI0eQXHJEgX
	 dU8DZUQ06/I8cF9Zt8p14Aigrn6qe4mm/+45sKdTDNhbqQNwMltTWfA2VI5TfvM9kWBQM
	 /rbABVR74nFF736JfCLmfDK+T492CE835WzaAAZimXgRytYvfCUNsRnseW2Ou0Hq2jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="eOe+/7+J";
	arc=none smtp.remote-ip=95.215.58.132
Received: from mta1.migadu.com (out-132.mta1.migadu.com [95.215.58.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E24606A32D
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41E24606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eOe+/7+J
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=A5SmaMdhmWrhHg/dO6iE1ySj0GXEbBYh4k4qltZSYrE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006753; v=1; x=1794611553;
 b=eOe+/7+JWixssUzEV/b8UFV7ji5/cNMD7zhnVd33wOA2KlSmeXqrJ6LLR/BX1vFPbX6xBKd8
 W7wT6NZBwtBKlnxbtKOZkhHRn5Vm7OXR++EDEXLMkL4DR39xoSfcTt4ZKUb394sbH63BtxJXgWQ
 V5IZ5vBv1VmaMziZ4Wugg2Ec=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a1c50fc3341016db;
	Fri, 06 Nov 2026 23:12:33 +0000
X-Mizu-Trace-ID: a1c50fc3341016db
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
Subject: [PATCH bpf v1 4/4] selftests/bpf: Cover callback-frame map key lifetime
Date: Fri,  6 Nov 2026 16:11:57 -0700
Message-ID: <20261106231157.2840635-5-ihor.solodrai@linux.dev>
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

Array and per-CPU array callbacks to bpf_for_each_map_elem() receive
a key on the helper's stack.

Check that saving this key in the callback context and dereferencing
it after iteration is rejected.

Also require the same pattern to keep verifying for a hash key and
an array value, whose storage outlives the callback. These controls
guard the array-only and key-only scope of the lifetime restriction.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/progs/verifier_iterating_callbacks.c  | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 4dd98acc6436..da8068a1f004 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -9,6 +9,20 @@ struct {
 	__type(value, __u64);
 } map SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} percpu_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 8);
+	__type(key, __u32);
+	__type(value, __u64);
+} hash_map SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
 	__uint(max_entries, 8);
@@ -804,4 +818,81 @@ __naked void check_add_const_regsafe_off(void)
 	: __clobber_common);
 }
 
+struct key_ctx {
+	__u32 *key;
+};
+
+static long park_key_cb(struct bpf_map *map, __u32 *key, __u64 *value,
+			void *context)
+{
+	struct key_ctx *c = context;
+
+	c->key = key;
+	return 0;
+}
+
+/* bpf_for_each_array_elem() passes a key from its own stack frame. */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int array_park_map_key(void *ctx)
+{
+	struct key_ctx c = {};
+
+	bpf_for_each_map_elem(&map, park_key_cb, &c, 0);
+	if (c.key)
+		return *c.key;
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int percpu_array_park_map_key(void *ctx)
+{
+	struct key_ctx c = {};
+
+	bpf_for_each_map_elem(&percpu_map, park_key_cb, &c, 0);
+	if (c.key)
+		return *c.key;
+	return 0;
+}
+
+/* A hash key points into the element, which outlives the callback. */
+SEC("?raw_tp")
+__success
+int hash_park_map_key(void *ctx)
+{
+	struct key_ctx c = {};
+
+	bpf_for_each_map_elem(&hash_map, park_key_cb, &c, 0);
+	if (c.key)
+		return *c.key;
+	return 0;
+}
+
+struct value_ctx {
+	__u64 *value;
+};
+
+static long park_value_cb(struct bpf_map *map, __u32 *key, __u64 *value,
+			  void *context)
+{
+	struct value_ctx *c = context;
+
+	c->value = value;
+	return 0;
+}
+
+/* Only the key is frame-scoped; the element lives until map teardown. */
+SEC("?raw_tp")
+__success
+int array_park_map_value(void *ctx)
+{
+	struct value_ctx c = {};
+
+	bpf_for_each_map_elem(&map, park_value_cb, &c, 0);
+	if (c.value)
+		return *c.value;
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.56.0

