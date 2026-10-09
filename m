Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977834EA37A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577745; cv=none; b=UucT0WMbbaxNirU4ac42vwinD+pg+jLQlqa7zPyeef0XDuDJYHMkkCk2Wz6HyKOfayJoh2sn2yxuHOidlE5B4/Fc3B1DY/zliweVBI9XyZCSe+31K7xnC281A2ojDkJRhrj+8JniVxzuBl/ruBEeS/JwdI3ghcU93pZEUerOOws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577745; c=relaxed/simple;
	bh=XB0Lc26fKCWw5hSHh/qAWzBPbxx7L+ehGElIudcNCyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8MsVcRovqYwnrRHWRoSbfDtJxuNKvWP/NelDfR7BlvdVz47WTn50ABNzxW1a25gGbDO9fS7vgz0FgGQjXO7VYca0g899kuZuHKYIYAAR4v0vkwNwl8+T7rB6rv/XmIXgih+bNXXYMgSA2sOha8VLOPq+mjOGiZcPIE+jxz3mM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VwPxTHFs; arc=none smtp.client-ip=91.218.175.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VwPxTHFs"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XB0Lc26fKCWw5hSHh/qAWzBPbxx7L+ehGElIudcNCyA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577741; v=1; x=1792182541;
 b=VwPxTHFsBCJkoqW5PL5SUlrGwPqzxjD6itPkAQ/x3N0j6CdbXxCLqRE9G0ohAshajvPyKM+J
 2OHmfhilpwUH/p6WBicuY5J6+xc28XdYNz4rlJVFNYN3j+4HIqoZ4v0YMTRG0nYLoR6HBRH9VBX
 SvwxcZfawgywlhwSNKBxEgsc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6e81207e6bf561dc;
	Fri, 09 Oct 2026 20:29:01 +0000
X-Mizu-Trace-ID: 6e81207e6bf561dc
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
Subject: [PATCH bpf-next v2 11/11] selftests/bpf: Cover callback-frame map key lifetime
Date: Fri,  9 Oct 2026 13:27:58 -0700
Message-ID: <20261009202759.50520-12-ihor.solodrai@linux.dev>
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
index 1fbcc5228306..2e0c56888953 100644
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
@@ -800,4 +814,81 @@ __naked void check_add_const_regsafe_off(void)
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

