Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606010;
	b=adNiliEZhLS8vtd1oIqzD68WoxNg+BFHL5rTn04ECprmAVS+e32Qupc7tBBCW8HqHOnD
	 keBUQO8nfxX5E78O1SIvx+1iB6zlZOfQfjTX5rUax5nA4QbObLJFZgoiOv9i0KfVPu7O8
	 Q8w6hvaOUkyWjjlXc97FKV02MVerMgu7bxBDe020QBntdDs/RiP8uOV0x7WdEnznxbGfQ
	 sb0kW6ATwLysSYCgi0v8hj3BmEKzBiNpxvzZxssQfs0z060AQ8OABeKItzDU1JlgWkVn0
	 GGii++XRMv32jzRxqCuDRkNXXrsDdEsOL1OJyexIH09dJnUetEYi9ho1GS4cTdzVGtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606010;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LCQc9kOni4SWH9/sppw3ilCo5DL7FdPQXQxmUFpEAF8=;
	b=mtWGcY30DJgpq9G0xXJc65OcFd8xh1PEcTi6FO+v4N04a/QqO8yNvmw9UqozY3iTLFsU
	 /qgZcvElISUcpLXfGXk2d/R6j9r6NZtE3wBvGllvy429sVUrqC30rj3qKb+0ubzfBQ8ub
	 FmS15j+ynfPWMt3xkgMxePJvDaryWidXittv9mtYLEf0jlzpI4KbNGluScpAF2z5IIDg9
	 zh+5HIrHcQGsLUOlasl237n7FCs0gEPpk0yHs14zULlHoJId67s0JVB3rDtZKd00QB/OJ
	 JDqOa07q7cofdUmoStriP06i4uol8UpqPzukQiBrS7BfYXOFLu0tPCb0Q3hV0AChdyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DyXYNQG0;
	arc=none smtp.remote-ip=95.215.58.125
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0360A381C
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACC0360A381C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DyXYNQG0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zEMZrhKbiE7PjxVtAluBP/MvIVAz42s7MtM09a7r768=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794606006; v=1; x=1795210806;
 b=DyXYNQG07hf4/J4/BEB+YNsCJ9CPr0IqY2GTIV6ueuzRw0hJjSnHGNMYuExRs0DLkdHPxBPH
 wJKM4VqhRPC1UvNiDfxZl4q3dnQ1ff+8iYfiyru0esyk0FxtPUkpo/m9lt+HYw17YhXV4yfyPyL
 Pu4vetjHiY9V6QM8e92UMvOI=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 1cbded36f2dc424a;
	Fri, 13 Nov 2026 21:40:04 +0000
X-Mizu-Trace-ID: 1cbded36f2dc424a
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
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Cover callback-frame map key lifetime
Date: Fri, 13 Nov 2026 14:39:21 -0700
Message-ID: <20261113213921.1646681-7-ihor.solodrai@linux.dev>
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
index e30f7676081f..1dfeb13b4382 100644
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
@@ -860,4 +874,81 @@ __naked void check_add_const_regsafe_off(void)
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

