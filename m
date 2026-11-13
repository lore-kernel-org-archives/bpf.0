Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606000;
	b=py41uOdYgyypQbuc4b668P24FczFvZ0MBxPRpeoOzgtA5SjEXDFJwcQrc1xKqcZ68azZ
	 K2eknTteNuU1L+mmDZI7Q8a5NWCpr8W2ZbPfVnWnAnrvq1J9PSzjpocQDpYj1DARUNzU+
	 YSEQ7X/tIdg3p6Jj2PIAMKcbeuKINpYFsU+hkDvrx7TUh7iLW/D5BjDPbXwMPBJEHRgps
	 9Zaoq8D7B09+4DN0Ml2HtwVncGay2m0FhqnEu5P3RTYrOLQDg06mHy5D6QfwSQjsP7BjI
	 /REAz8QVVKLdkhgnic4ZPqBt9OziMschgsFdGHYovi0NLJDvAxnEeIhCsAew9/HVa5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606000;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PqbAXpWiWQTk6LCN7E2FIOUxu9bMggSdDwC34zhM2Yw=;
	b=MC5vRYAxqGZlkdZNEKR6k+2wHCEvXFpAE67kQE2d/KpmixKLllMLcC1h6UEdkvhSjTnV
	 flTxzr7m93rusxsOVoK4KQCT1VXWlBDa0Md/yaY3D1EaRUL1vCJ2mP0MmgfWO/Mg0wHoZ
	 xkWUfMgysj1cSnzNVO5RbpcINX9JhEwqpppj0XVuYKEZ6TCqV6EQOzxjzOhAPLhcETsEv
	 W3mijpTuaFQx7uuy7v7MO9WhJPVjelr10haAUXFNn1Pd+NoI174U8BiJHD5BFtS2zN1o5
	 7malELnowCJBnTFt6cnFNZbghR1r96XhGdBU2acFyRrICzC02pEzTCMC++K8beUwhng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=juYKBTYc;
	arc=none smtp.remote-ip=95.215.58.111
Received: from mta1.migadu.com (out-111.mta1.migadu.com [95.215.58.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4A606A8B4
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3C4A606A8B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=juYKBTYc
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uFwShxfNpXz78z+BTKoNtYZGXioC5LsRUIM6BJF585I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794605997; v=1; x=1795210797;
 b=juYKBTYcrnkhQKEwz8EQR+pgBaWzAarXODGUv2eDYhIWx62RTq9zlkzARGDUOWuAjsFp5mFu
 slbMlcYn68Ga+n2IhfH6bID+bHOG3duSnDsvOruignnDB5nxqaZqd5e/tDT3E+s1S14tlE4pAeE
 MPnHkC/QbqZQoVG655td3XZA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 15592b26ac649082;
	Fri, 13 Nov 2026 21:39:57 +0000
X-Mizu-Trace-ID: 15592b26ac649082
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
Subject: [PATCH bpf-next v4 4/6] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
Date: Fri, 13 Nov 2026 14:39:19 -0700
Message-ID: <20261113213921.1646681-5-ihor.solodrai@linux.dev>
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

The dynptr passed to a bpf_user_ringbuf_drain() callback, and values
derived from it, must not be used after that callback returns.

Exercise escapes through the callback context, slices returned by
bpf_dynptr_data() and bpf_dynptr_slice(), and clones stored in the
caller's frame. Also cover an inner callback's dynptr escaping into an
outer callback.

A program that leaves either the outer or the inner dynptr in the same
slot and only tests it for NULL must still load. This covers the frame
id pairing in join_func().

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index c0d0422b8030..6606e6c56329 100644
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
 
@@ -243,3 +245,162 @@ int user_ringbuf_callback_const_ptr_to_dynptr_reg_off(void *ctx)
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
+__failure __msg("R3 type=scalar expected=fp, dynptr_ptr")
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
+__failure __msg("invalid mem access 'scalar'")
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
+__failure __msg("invalid mem access 'scalar'")
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
+__failure __msg("R3 type=scalar expected=fp, dynptr_ptr")
+int user_ringbuf_callback_nested_park_inner(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_park_outer, NULL, 0);
+	return 0;
+}
+
+static long callback_maybe_park(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx *c = context;
+
+	if (bpf_get_prandom_u32() & 1)
+		c->saved = dynptr;
+	return 0;
+}
+
+/* inner.saved ends up holding either the outer or the inner dynptr. */
+static long callback_maybe_park_outer(struct bpf_dynptr *dynptr, void *context)
+{
+	struct dynptr_ctx inner = { .saved = dynptr };
+
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_maybe_park, &inner, 0);
+	return inner.saved ? 1 : 0;
+}
+
+SEC("?raw_tp")
+__success
+int user_ringbuf_callback_nested_maybe_park(void *ctx)
+{
+	bpf_user_ringbuf_drain(&user_ringbuf, callback_maybe_park_outer, NULL, 0);
+	return 0;
+}
-- 
2.56.0

