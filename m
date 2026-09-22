Received: from mta0.migadu.com (out-216.mta0.migadu.com [91.218.175.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F534EF15
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039065; cv=none; b=u4xBQ3uDYJKOfW+mfnQCbLC/jJOic8FTLLbi6BZROTRg2V7j+67mK3waDxvXMji+Z+fTQPRVn51w26SmFepEO7Eoj3TaLa2wucPoFdGzLn2zDvTI6L47vsAhxNHriErSorrqyfuYTkYIwYhUxDHaecFOurZ4MvQGsO/cBvb3Fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039065; c=relaxed/simple;
	bh=Vw7xOFj7NDfG3x/79uhiyl8/V5mf++Vc9MTJPJzRdcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/gc36a/Q3XmSqSSvnk0arm7EvYc4iGyoNmNtZvxv9YrE2/FRyLqKSgFNIXxkzjaBIn7i/YlwohNZmU/9j7lPPDq317Ge15luFsfAfcGlxOm6E1MH5SAy71OSOHBFGtnUtFLJ5mjDlXVNEEFd0qmhkxM35b3pAHFOxjzmCY6qkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnIKsi0K; arc=none smtp.client-ip=91.218.175.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnIKsi0K"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Vw7xOFj7NDfG3x/79uhiyl8/V5mf++Vc9MTJPJzRdcI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039061; v=1; x=1790643861;
 b=nnIKsi0KRGUx/kluNqMGRa4xKPlxP8nsEY7UdjALJJOObHAtl0CKafzsmOk+31wv876QLWkb
 HmJC+S0pUwUtC9qsl4LMvwws7txSwdQPsn8zq2A+Eid3puUQg7IdAXuLfQUk2Of3SvZ51dE0Ss9
 EcOKJeFjpiExbMLIhHHKDHfY=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id fe3c14a229ddcf9d;
	Tue, 22 Sep 2026 01:04:21 +0000
X-Mizu-Trace-ID: fe3c14a229ddcf9d
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
Subject: [PATCH bpf-next v1 6/6] selftests/bpf: Cover callback-frame map key lifetime
Date: Mon, 21 Sep 2026 18:03:33 -0700
Message-ID: <20260922010333.1226537-7-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
References: <20260922010333.1226537-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parking the key in callback_ctx and dereferencing it after the iteration
is rejected for array and percpu-array maps, whose key lives in
bpf_for_each_array_elem()'s frame.

Two cases must keep verifying, and are the reason the declaration is not
in the shared map_set_for_each_callback_args(): the same shape over a
hash map, whose key points into the element, and parking the element
value, which lives until map teardown.

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
2.55.0

