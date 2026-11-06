Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006741;
	b=oAgp/apC3C6kHe3SW7zOIeRKaMJeFimzN6wiEOdrQ5JXV+Na7b+p5uhRqoFUyZ9mqWEz
	 MGgett9J412XE3sdcrlBgQS64fujsVzvaoU0P7zB+eiuMkjUc/hrDvTXKgWRzyxU095MS
	 jWVSnubBiwU8tIYDc4aiRgL9yVHeZSbC2lrtqFTPdm38Ez+qhzJS5R+ePjjO0dXDESq2m
	 oct8yPwlLM/+CMg/uQ0JaLOT6fFJStRJjeRrZep6q38KYlGUmrrBvgpX4SvTLTZh0dDOQ
	 E6Ohr1zg9tKGbRN2WXs1kxZqowSNAkiI9Fdqy4zKEduR9N5igdVuBynZpTbFWBzZRMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006741;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=41uUIng/s6RlXusBXkFwIGXC2fxaVQ0JewCTTW4PXlE=;
	b=osLeCZk+ez4Opp7biyHEjDP8M7MGuo0aJRz/9QQdlHnaMUiKn4bsuemmQnJrXT9njDt2
	 ce4u/b0ReqCd+ve5aY/kKOtfgb/GxoeRFB8Dzn2+uWJHPWQxx4o9kPd2z8wTLInWxg2Ip
	 xSvO49fDBNj5uDPMW0BsZmN3ik1Xf7Y0x4Rdrgy1bubfj2u9R/rQ9NxbQnjOrQ6XKwXjj
	 Mon2Cj8DQgGFbQJl3ZoNADmZOL26OruqYhJ9xFQYM8vuZaw7bymjsbqD/6Xf3s6uxQShG
	 f4TIBc8WaJDyWwr7kf8sFaG09k5IFkWZIPCz0mHdx4Jis5uIg32FFQGyfuHr0BiamBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AZWIKCyG;
	arc=none smtp.remote-ip=95.215.58.126
Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64769606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 23:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64769606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AZWIKCyG
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kutOv9rBAQwEefut6vlM924/p+vuxAhMEkB0yBpkhTo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794006738; v=1; x=1794611538;
 b=AZWIKCyGk8ooP4ajjuvD9iuz/joJndfML6iwC0rmv3nFOtTk3i6EZM/JvwNE4C4x5TF8Zblw
 c8p1/IUyKe1hecRAODrnt9sAdM6ZW+wTBPaM2G7fdiQ0JBkyO87COn6UPSLVgpFM100c/llwgNv
 WvKWg3xyR5kwh1b+P7yqI+XA=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 23e5037a5e79bdf0;
	Fri, 06 Nov 2026 23:12:18 +0000
X-Mizu-Trace-ID: 23e5037a5e79bdf0
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
Subject: [PATCH bpf v1 2/4] selftests/bpf: Cover the user ringbuf callback dynptr lifetime
Date: Fri,  6 Nov 2026 16:11:55 -0700
Message-ID: <20261106231157.2840635-3-ihor.solodrai@linux.dev>
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

The dynptr passed to a bpf_user_ringbuf_drain() callback, and values
derived from it, must not be used after that callback returns.

Exercise escapes through the callback context, slices returned by
bpf_dynptr_data() and bpf_dynptr_slice(), and clones stored in the
caller's frame. Also cover an inner callback's dynptr escaping into an
outer callback.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../selftests/bpf/progs/user_ringbuf_fail.c   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c b/tools/testing/selftests/bpf/progs/user_ringbuf_fail.c
index c0d0422b8030..80eb1e7802ad 100644
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
-- 
2.56.0

