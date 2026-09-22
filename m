Received: from mta1.migadu.com (out-219.mta1.migadu.com [95.215.58.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E534EF15
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039058; cv=none; b=Zh6eDudmMpvXE/sWIb9o+kCz8wJDHRafgUA6wGDAFYVqsVlVMfzC3MGY3QumDxn2u2VFuG+2hgTwLtDeaua2E+q9TdeUZfW2c9/DLNKgRSq2sCCQd10VBzu+o7LFwSlbua3BkJeB8E4Wl9I6swsIo1yfvpPShKS0I54mYZmDi8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039058; c=relaxed/simple;
	bh=MOFDZylnJkHMTUTkD8mTkGLhpA5ihuPrk4xk8kIvGvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8985Q2Dm5BtBunXA7fSjfIvTNAf5c5evVmqxEb8v5JRmS7hzdPnsNqU9KGuwZXI3O8qYPcvi8JPznwWtzDtdI1cWvX5tSM+uZsBzYDZAaj3RfWGeFekaZfnkpcpFAdRPrFScQlSE9zjLylnPl0iCePxSUHJoLRgIFfNhE7BLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oCVYKxuD; arc=none smtp.client-ip=95.215.58.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oCVYKxuD"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MOFDZylnJkHMTUTkD8mTkGLhpA5ihuPrk4xk8kIvGvI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790039054; v=1; x=1790643854;
 b=oCVYKxuD7Ir6sw2ZzM62+TGd2+KJ072TgjLcCpnjRz3zQ1IMba/XV6VRGRowz/TlI/ySGW4t
 9O7L7Pia/VwYS3fLjXtPt866jbm7CBK8WxhclbGiSRysI9hT6EHoVPh7fl5Y6qPC4Vq7axA1Lzq
 DbIUP+y6LpFcNsqKGpjYa2NE=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d68bdd8ebbe95197;
	Tue, 22 Sep 2026 01:04:14 +0000
X-Mizu-Trace-ID: d68bdd8ebbe95197
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
Subject: [PATCH bpf-next v1 4/6] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
Date: Mon, 21 Sep 2026 18:03:31 -0700
Message-ID: <20260922010333.1226537-5-ihor.solodrai@linux.dev>
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

Add a rejection test for each route the bpf_user_ringbuf_drain() callback
dynptr can take out of its frame:

  - the CONST_PTR_TO_DYNPTR register parked in callback_ctx
  - a bpf_dynptr_data() slice
  - a bpf_dynptr_slice() slice
  - a bpf_dynptr_clone() written into the caller's frame
  - a slice taken from that clone after the drain returns
  - an inner drain's dynptr escaping into an outer callback

The first also checks that the diagnostic names the callback.

bpf_throw() from the callback reaches check_reference_leak() with the
frame reference still live, and is rejected afterwards by
check_max_stack_depth(). It matches that rejection in full, because
"bpf_throw" alone also matches the reference-leak wording the callback
must not produce.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/exceptions_fail.c     |  20 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 143 ++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/exceptions_fail.c b/tools/testing/selftests/bpf/progs/exceptions_fail.c
index 22503cf62e9f..86a0667ba348 100644
--- a/tools/testing/selftests/bpf/progs/exceptions_fail.c
+++ b/tools/testing/selftests/bpf/progs/exceptions_fail.c
@@ -31,6 +31,11 @@ struct {
 	__type(value, struct hmap_elem);
 } hmap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_USER_RINGBUF);
+	__uint(max_entries, 4096);
+} user_ringbuf SEC(".maps");
+
 private(A) struct bpf_spin_lock lock;
 private(A) struct bpf_rb_root rbtree __contains(foo, node);
 
@@ -110,6 +115,21 @@ static int timer_cb(void *map, int *key, struct bpf_timer *timer)
 	return 0;
 }
 
+static long drain_cb(struct bpf_dynptr *dynptr, void *context)
+{
+	bpf_throw(0);
+	return 0;
+}
+
+SEC("?tc")
+__failure
+__msg("bpf_throw kfunc (insn {{[0-9]+}}) cannot be called from callback subprog {{[0-9]+}}")
+int reject_user_ringbuf_callback_throw(struct __sk_buff *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, drain_cb, NULL, 0);
+	return 0;
+}
+
 SEC("?tc")
 __failure __msg("cannot be called from callback subprog")
 int reject_async_callback_throw(struct __sk_buff *ctx)
diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index c0d0422b8030..a8d3acfa2bd2 100644
--- a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
+++ b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
@@ -243,3 +245,144 @@ int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
 			       callback_adjust_bpf_dynptr_reg_off, NULL, 0);
 	return 0;
 }
+
+/* The sample goes back to the producer as soon as the callback returns. */
+struct dynptr_ctx {
+	struct bpf_dynptr *saved;
+};
+
+static long callback_park_dynptr(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx *c = context;
+
+	c->saved = dynptr;
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("the callback that owned this value returned")
+int user_ringbuf_callback_park_dynptr(void *ctx)
+{
+	struct dynptr_ctx c = {};
+	char buf[8] = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_dynptr, &c, 0);
+	if (c.saved)
+		bpf_dynptr_read(buf, sizeof(buf), c.saved, 0, 0);
+	return buf[0];
+}
+
+struct slice_ctx {
+	char *p;
+};
+
+static long callback_park_data_slice(struct bpf_dynptr *dynptr, void *context)
+{
+	struct slice_ctx *c = context;
+
+	c->p = bpf_dynptr_data(dynptr, 0, 8);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("the callback that owned this value returned")
+int user_ringbuf_callback_park_data_slice(void *ctx)
+{
+	struct slice_ctx c = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_data_slice, &c, 0);
+	if (c.p)
+		return c.p[0];
+	return 0;
+}
+
+static long callback_park_kfunc_slice(struct bpf_dynptr *dynptr, void *context)
+{
+	struct slice_ctx *c = context;
+
+	c->p = bpf_dynptr_slice(dynptr, 0, NULL, 8);
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("the callback that owned this value returned")
+int user_ringbuf_callback_park_kfunc_slice(void *ctx)
+{
+	struct slice_ctx c = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_kfunc_slice, &c, 0);
+	if (c.p)
+		return c.p[0];
+	return 0;
+}
+
+struct clone_ctx {
+	struct bpf_dynptr clone;
+	__u64 armed;
+};
+
+static long callback_park_clone(struct bpf_dynptr *dynptr, void *context)
+{
+	struct clone_ctx *c = context;
+
+	bpf_dynptr_clone(dynptr, &c->clone);
+	c->armed = 1;
+	return 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as R3")
+int user_ringbuf_callback_park_clone(void *ctx)
+{
+	struct clone_ctx c = {};
+	char buf[8] = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_clone, &c, 0);
+	if (c.armed)
+		bpf_dynptr_read(buf, sizeof(buf), &c.clone, 0, 0);
+	return buf[0];
+}
+
+SEC("?raw_tp")
+__failure __msg("Expected an initialized dynptr as R1")
+int user_ringbuf_callback_park_clone_then_slice(void *ctx)
+{
+	struct clone_ctx c = {};
+	char *p;
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_clone, &c, 0);
+	if (c.armed) {
+		p = bpf_dynptr_data(&c.clone, 0, 8);
+		if (p)
+			return p[0];
+	}
+	return 0;
+}
+
+static long callback_park_inner(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx *c = context;
+
+	c->saved = dynptr;
+	return 0;
+}
+
+/* An inner drain's dynptr must not escape into the outer callback either. */
+static long callback_park_outer(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx inner = {};
+	char buf[8] = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_inner, &inner, 0);
+	if (inner.saved)
+		bpf_dynptr_read(buf, sizeof(buf), inner.saved, 0, 0);
+	return buf[0] ? 1 : 0;
+}
+
+SEC("?raw_tp")
+__failure __msg("the callback that owned this value returned")
+int user_ringbuf_callback_nested_park_inner(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_outer, NULL, 0);
+	return 0;
+}
-- 
2.55.0

