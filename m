Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D614F3914
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577734; cv=none; b=KHjL1uFyGKMoyua0CegA8qKAdPdHCOv5+fMeK4vUZ1CNULdirNFm8J09e5hoDfZAHmc6OPYafQBBWre5vgC2JTI/MTtFNpQaqf72io7fPg0LWKwQFmiK+nQXR8obiUORjOso0S+86w7jt98MKLeRsqtl8pVrG31G5CqldtXZRqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577734; c=relaxed/simple;
	bh=7+KSnwa+Z1D21IwaKyQTNxQ+uJU7XgpTZahbq8RJejo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTPJ7VitnCkM4Jdhb/YWVP4IYGsrSTiOsF3/Rz07xHjv+Ddv1V34gqi3FACQ8kBqvqc/xq4sz32VDlXa1KM3IMIVh5PSoLbNTlgeuFlOTYvbGy7Ynufirm9zGDBuiiCLCGrC/RqV6vWnUkJ9QwHbL3Jhfh475Jy5eOEmM/JhNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrGKALJG; arc=none smtp.client-ip=91.218.175.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrGKALJG"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7+KSnwa+Z1D21IwaKyQTNxQ+uJU7XgpTZahbq8RJejo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791577731; v=1; x=1792182531;
 b=TrGKALJGO2cn9NNIsniF3zhOHG2do/O+i6U2b7/S6NMIa9zeEVTwl++pEmRgh4e1Jjufzj+l
 e2wGvbWPrBGKoyznfkTEiEgx2q3sTOZZijLdp+8h2gapBf9sGpfHxI4kQgXFDOiz9h/AYzweV2p
 jxmyjgFCWoq42jgXhe4bGCF8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1d9630834caf14b1;
	Fri, 09 Oct 2026 20:28:50 +0000
X-Mizu-Trace-ID: 1d9630834caf14b1
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
Subject: [PATCH bpf-next v2 09/11] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
Date: Fri,  9 Oct 2026 13:27:56 -0700
Message-ID: <20261009202759.50520-10-ihor.solodrai@linux.dev>
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

The dynptr passed to a bpf_user_ringbuf_drain() callback, and values
derived from it, must not be used after that callback returns.

Exercise escapes through the callback context, slices returned by
bpf_dynptr_data() and bpf_dynptr_slice(), and clones stored in the
caller's frame. Also cover an inner callback's dynptr escaping into an
outer callback.

Require the callback-return diagnostic for escaped pointers and slices.
Check the full bpf_throw() callback rejection so a frame-reference leak
cannot satisfy the test accidentally.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/exceptions_fail.c     |  20 +++
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 135 ++++++++++++++++++
 2 files changed, 155 insertions(+)

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
index c0d0422b8030..4e0f29c2d1f2 100644
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
 
@@ -243,3 +245,136 @@ int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
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
+/* An inner drain's dynptr must not escape into the outer callback either. */
+static long callback_park_outer(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx inner = {};
+	char buf[8] = {};
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_dynptr, &inner, 0);
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
2.56.0

