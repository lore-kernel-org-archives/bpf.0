Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270498;
	b=OCa46V+Q26aIea8S2S/dQB91PUM0qZw/ojXwpzcMtHdLcEPeEcspfy36KZos3CIa1nvX
	 54jNlgkGVj1uBNnDrw2gANIccOnLQd500iKHiZjl0XS114fDaakNk8BjGEPEDVDfb7Xxv
	 qnCzCaSbmNaZ/y7acHUdyIC3+CWqhTTlaTfetCBQIZWJ3x3tFyWlGO9KkWj2Q8ALnyN9w
	 iuC8Fa5unIke4G7+b9vYMgUd6IJ/h1eS8B4qMYDp9JRv4PJv+jJb/A6wLoo5N3pA7SOVH
	 yNmLXV8bPgfOW6n9F3xsY0TskkXqt1TcKjI0AfX7fsykGrCvvoOhJfVSFsyah6TyMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=vPVzVyvuMfsW+lOT+kwODk5TwN9x9ob84puXWhX+n04=;
	b=ntA24pC7Xx+2RI+gajIG04/rr2HffOmZ5Qm5BtMfojjg52IsW86mKs4tR6q2zQVbLk2X
	 bmKbG9zZU+LhaFzMGqNAe3z73vrCyt9fXl/VJQR+EsLLy9Tbyq+N+MSF/++6wkRJmR1qA
	 eYL1zf1jbYAFMG2VJpPT9ugOXwGgc3IkuFFQ2SETANkeznZw3Oq6GHvu7Ve6VKkIF6jRj
	 9B+il30q1OpcEjZXvo6vgkeKBZUBekuX6j8JcUB3BhohwRQAwCAIfS/4sxa4y8V1/TR25
	 CrGv8Eu1rgaZ8ArzxBZVBgP9zFJQW0waJtbVpmjURfXLgNiEs56ycvJrjn3vL/NDSMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A3/MXwC1";
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A80606A31C
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3/MXwC1
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b80834ce1aso3779495e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270496; x=1794875296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vPVzVyvuMfsW+lOT+kwODk5TwN9x9ob84puXWhX+n04=;
        b=A3/MXwC1nzKAkovFElW7pWTOHjGcM1KQC9Cb1vOyEwHihODdF4qnPQxr7jtBYWrBOo
         51iTfbEwEYhNFCWCiDQZ/uQLd5cHZnxvljA7GQ4m4GROrCHa7AuDNdUio9EZP/YNK6GJ
         i7QKZ4CQMGrNifZHJ0aIUCGdcmTfAp7V+0nVSY0ioVs2GPzZ4ZUrDKEsvVJqE6JNOufu
         3NCW+OPLk+G/p/FYdNfib3sFj4EyAkNjpNz0ryareg8p8Srv6xxhFljAQ7gDFnGvBJY0
         +Xl2GZkJ6wCFcpRGuwl0pwCHWzSZQ/6pYmGJ40VK8rg8ZQ0+sBHxw892TghWXA31LN3L
         MOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270496; x=1794875296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vPVzVyvuMfsW+lOT+kwODk5TwN9x9ob84puXWhX+n04=;
        b=RwBoSzdGeZlP0TXsydoicDDhDH/VPmAjqPm4MYenlc5v4AdCuZYg0J03525pubKRwI
         BENhhmhlizc86Ixyt5/oOPYHtLniGtacReVg65zTMhQTrdlPDx/3RUXmOM0y67P+VGE4
         r9xwqFW/ltlRJDjK20na4a2qspZkxG75SezndCMy9aV6a2W8WeLmuXR7axi4Ra5UGLzy
         vn3uWg4t1mRkvr/ziJML1x8P2uM7vVp3936DuAJsWlZCi3KfpP9oaoJZHc8HBv/Ac7te
         1WlgNsf5fHZv43QGFscfz9WxDJWStmiQDHtWZK91r+kaTCkrRSz3D9/ZOyTdKSEAnraj
         RSnQ==
X-Gm-Message-State: APuU4Z+/0gQNurfgDqnYygtqichixUdFRYZa9lARN3ljV7eM1JNmeo81
	mb6gnOK2UUnJN24S56w4kttY9cUUHFC3TlKw71AnAuhUB5oK3HSYzNOd9DHwiNaS
X-Gm-Gg: AYBFou3hydoxd5iIC9XtDFfq4GStHfKHsK2h26Jcylr0mmtGIoo12HgB8pVqxLSgqfE
	HiJs0VB3j5yqfotYEbATCUbzkqa4OEXQRZTV0VaEBpBRhb0Vo+tj50btMJkGedpmFjNxseKoHmv
	fHt1Wk3m3xyy90f4OTFbu74FQbrHd51rWvL0J0dy2cRZOatS+5Ym9xkIhx8g1DFHJYM69djVOfW
	jdB5qVlZxtY7qwz3HRdKHOrFKbl7oDEnsrRC8flvk2hsULcLyEVTedF6DX9Nlt0WtPOG2fSxxeU
	iWR2lXtNg+SDBHOpvz2Jtze5lTButxu+TIZwQa0FL4dVGFOob5uztXs+Yk4hU1RCDjwoHbrGWM9
	3ELyiv9iXg0jDl6NiNTcfFGFi9Zl7ZsZPX1zO/S2UGkS5sze+yvSicbcxC3vJL15qdCod6KPXRf
	dxaMKQX08IyOIYbGU1EDF9x4dINmoMHKC8Er5gVMEgWdTZCr6nmcCTcDdy06mZldFahzbDYzSLT
	qruwJsU0RkQX+GPnvS5hp0ZeZtNJ+Z+GaqJymWzxWmgpY58PfAIE/isE+N9Qxs6rRUfbB0BKYKO
	WSwRcXQHqQyCl7K9sAhboOAKZuYt+b3jMDAMTKeolSnBD43XFQ0gCUvtDXO2s5C3fV1Nv7Es4Dz
	qSbd8wkESyT3VpI4PQkXTeD6vUdd52xHMrshXOGWX1Fc9CVfie+VfjNmttfPYoz6D7gC8
X-Received: by 2002:a05:600c:350c:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ba0233eafamr12773075e9.15.1794270496151;
        Mon, 09 Nov 2026 16:28:16 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835f175c9sm1699332f8f.32.2026.11.09.16.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:14 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 16/20] selftests/bpf: Test bpf_task_park() across functions and callbacks
Date: Tue, 10 Nov 2026 01:27:38 +0100
Message-ID: <d76c4b9a400a95fe0990be39692686309e84b63e.1794269507.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12884; i=memxor@gmail.com; h=from:subject:message-id; bh=79egtNyWxRjPmhNT7XKR332gx4yyVUVtuzQRmdS3A3Q=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTosde8fIXeRZbt1ybc3C10vNfdVyRzkltT6VM/mxvb dTat+dFRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYyLYyRYeFVR9umxTHbIndp 8uvp6MYfMOzexnS8x+JJn4Exi+OLckaGX69WeUr+nL89kv/MQ4O/nvYizjucVxidT/HzjOVxFVj MDAA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Pin where a park may sit in the call graph and what the frames above it
lose.

A park in a static function and a park in a global function called
directly from the main program are both accepted and both return the
timeout. In either case the caller's hash map value does not survive
the call: for the static function because a function that parks is
verified in the state of its caller, where the park sees every frame,
for the global function because the call site applies the might_park
mark the CFG pass propagated. The mark travels: a static function that
calls the global one invalidates its caller's value the same way, and
so does a global function that calls the static one and sleeps in a
helper of its own, where merging the callee's marks changes nothing but
might_park. A dynptr or a bits iterator the caller holds across a
global call that parks is refused with the same message as across the
park itself.

With callx the function that parks may be called by a function that did
not load its address. Such a caller has no mark and is verified on its
own, without the frames above it, until its exit reports the park. A
program that passes the address of the parking function to it loses its
hash map value across the call all the same, and a bpf_loop() callback
that does so is refused with the callback message.

No callback other than the body of a BPF kthread, which has its own
tests, may park. A bpf_loop() callback and a
bpf_for_each_map_elem() callback that call the kfunc directly, one that
calls a static function which parks, a bpf_wq callback and a
bpf_task_work callback, which the verifier checks as states of their
own with the callback as frame 0, and the exception callback are all
refused with the callback message. A bpf_loop() callback that calls a
global function which parks, directly or through a second global
function, is refused at the call site with the message naming the
function it called, since the callee is verified without knowledge of
its callers.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/prog_tests/task_park.c      |   2 +
 .../bpf/progs/verifier_task_park_frames.c     | 393 ++++++++++++++++++
 2 files changed, 395 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_task_park_frames.c

diff --git a/tools/testing/selftests/bpf/prog_tests/task_park.c b/tools/testing/selftests/bpf/prog_tests/task_park.c
index 2ba4c24ae598..43514132e6e9 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_park.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_park.c
@@ -7,6 +7,7 @@
 #include <sys/syscall.h>
 #include "task_park.skel.h"
 #include "verifier_task_park.skel.h"
+#include "verifier_task_park_frames.skel.h"
 
 static int run_syscall_prog(struct bpf_program *prog, __u32 *retval)
 {
@@ -221,6 +222,7 @@ void test_task_park(void)
 	struct task_park *skel;
 
 	RUN_TESTS(verifier_task_park);
+	RUN_TESTS(verifier_task_park_frames);
 
 	skel = task_park__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
diff --git a/tools/testing/selftests/bpf/progs/verifier_task_park_frames.c b/tools/testing/selftests/bpf/progs/verifier_task_park_frames.c
new file mode 100644
index 000000000000..f374e9051fe5
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_task_park_frames.c
@@ -0,0 +1,393 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
+
+#include "bpf_experimental.h"
+#include <errno.h>
+#include "bpf_misc.h"
+
+/* Where a bpf_task_park() may sit in the call graph, and what its callers lose. */
+char _license[] SEC("license") = "GPL";
+
+struct park_elem {
+	__u32 state;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct park_elem);
+} park_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct park_elem);
+} hash_map SEC(".maps");
+
+struct wq_elem {
+	struct bpf_wq wq;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+struct tw_elem {
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct tw_elem);
+} tw_map SEC(".maps");
+
+static __always_inline struct park_elem *lookup_hash_elem(void)
+{
+	__u32 key = 0;
+
+	return bpf_map_lookup_elem(&hash_map, &key);
+}
+
+/* A static function that parks is verified in its caller's state: the park sees every frame. */
+static __noinline int park_static(void)
+{
+	return bpf_task_park(0, 0);
+}
+
+/* A global function is verified alone: its callers rely on the might_park mark. */
+__noinline int park_global(void)
+{
+	return bpf_task_park(0, 0);
+}
+
+/* The mark reaches callers through further static and global functions. */
+static __noinline int park_via_static(void)
+{
+	return park_global();
+}
+
+__noinline int park_via_global(void)
+{
+	return park_global();
+}
+
+/* The mark reaches a caller that sleeps on its own account as well. */
+__noinline int park_and_sleep_global(void)
+{
+	char buf[8];
+
+	park_static();
+	return bpf_copy_from_user(buf, sizeof(buf), NULL);
+}
+
+/* A park in a function called directly from the main program is allowed. */
+SEC("syscall")
+__success __retval(0)
+int park_in_static_subprog(void *ctx)
+{
+	return park_static() != -ETIMEDOUT;
+}
+
+SEC("syscall")
+__success __retval(0)
+int park_in_global_subprog(void *ctx)
+{
+	return park_global() != -ETIMEDOUT;
+}
+
+/* The caller's hash map value does not survive a park in its callee, static or global. */
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int hash_value_after_static_subprog_park(void *ctx)
+{
+	struct park_elem *elem = lookup_hash_elem();
+
+	if (!elem)
+		return 0;
+	park_static();
+	return elem->state;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int hash_value_after_global_subprog_park(void *ctx)
+{
+	struct park_elem *elem = lookup_hash_elem();
+
+	if (!elem)
+		return 0;
+	park_global();
+	return elem->state;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int hash_value_after_nested_subprog_park(void *ctx)
+{
+	struct park_elem *elem = lookup_hash_elem();
+
+	if (!elem)
+		return 0;
+	park_via_static();
+	return elem->state;
+}
+
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+int hash_value_after_sleeping_subprog_park(void *ctx)
+{
+	struct park_elem *elem = lookup_hash_elem();
+
+	if (!elem)
+		return 0;
+	park_and_sleep_global();
+	return elem->state;
+}
+
+/* A dynptr held by the caller is as live across a global call that parks as across the park. */
+char dynptr_buf[8];
+
+SEC("syscall")
+__failure __msg("bpf_task_park() with a live dynptr at frame 0")
+int dynptr_across_global_subprog_park(void *ctx)
+{
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_mem(dynptr_buf, sizeof(dynptr_buf), 0, &ptr);
+	park_global();
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() with a live bits iterator at frame 0")
+int bits_iterator_across_global_subprog_park(void *ctx)
+{
+	struct bpf_iter_bits it;
+	__u64 word = 1;
+
+	bpf_iter_bits_new(&it, &word, 1);
+	park_global();
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
+
+/*
+ * No callback other than the body of a BPF kthread may park: not directly, not
+ * through a static or a global function.
+ */
+static int park_cb(__u32 index, void *data)
+{
+	bpf_task_park(0, 0);
+	return 1;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int park_in_loop_callback(void *ctx)
+{
+	bpf_loop(1, park_cb, NULL, 0);
+	return 0;
+}
+
+static int park_static_cb(__u32 index, void *data)
+{
+	park_static();
+	return 1;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int static_subprog_park_in_callback(void *ctx)
+{
+	bpf_loop(1, park_static_cb, NULL, 0);
+	return 0;
+}
+
+static int park_global_cb(__u32 index, void *data)
+{
+	park_global();
+	return 1;
+}
+
+SEC("syscall")
+__failure __msg("global function park_global() may call bpf_task_park(), "
+		"which is not allowed in a callback")
+int global_subprog_park_in_callback(void *ctx)
+{
+	bpf_loop(1, park_global_cb, NULL, 0);
+	return 0;
+}
+
+static int park_via_global_cb(__u32 index, void *data)
+{
+	park_via_global();
+	return 1;
+}
+
+SEC("syscall")
+__failure __msg("global function park_via_global() may call bpf_task_park(), "
+		"which is not allowed in a callback")
+int nested_global_subprog_park_in_callback(void *ctx)
+{
+	bpf_loop(1, park_via_global_cb, NULL, 0);
+	return 0;
+}
+
+static int park_for_each_cb(struct bpf_map *map, __u32 *key, struct park_elem *val, void *data)
+{
+	bpf_task_park(0, 0);
+	return 1;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int park_in_for_each_callback(void *ctx)
+{
+	bpf_for_each_map_elem(&park_map, park_for_each_cb, NULL, 0);
+	return 0;
+}
+
+#ifdef CAN_USE_CALLX
+
+/* calls_arg(fn) { return fn(); } */
+__naked __noinline __used
+static unsigned long calls_arg(void)
+{
+	asm volatile ("					\
+	callx r1;					\
+	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The program loads the address of the function that parks, calls_arg() calls
+ * it. Nothing marks calls_arg(), so it is verified on its own, without its
+ * callers, until its exit says that it parked. The hash map value of the
+ * program is gone after the call all the same.
+ */
+SEC("syscall")
+__failure __msg("invalid mem access 'scalar'")
+__naked int hash_value_after_callx_park(void)
+{
+	asm volatile ("					\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[hash_map] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	if r0 == 0 goto l0_%=;				\
+	r6 = r0;					\
+	r1 = %[park_static] ll;				\
+	call calls_arg;					\
+	r0 = *(u32 *)(r6 + %[state_off]);		\
+l0_%=:	exit;						\
+"	:
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(hash_map),
+	  __imm_addr(park_static),
+	  __imm_const(state_off, offsetof(struct park_elem, state))
+	: __clobber_all);
+}
+
+/* Nor does the callback get to park behind calls_arg(). */
+__naked __noinline __used
+static unsigned long park_callx_cb(void)
+{
+	asm volatile ("					\
+	r1 = %[park_static] ll;				\
+	call calls_arg;					\
+	r0 = 1;						\
+	exit;						\
+"	:
+	: __imm_addr(park_static)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+__naked int callx_park_in_callback(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	r2 = %[park_callx_cb] ll;			\
+	r3 = 0;						\
+	r4 = 0;						\
+	call %[bpf_loop];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_loop),
+	  __imm_addr(park_callx_cb)
+	: __clobber_all);
+}
+
+#endif /* CAN_USE_CALLX */
+
+/* An asynchronous callback is verified as its own state, with the callback as frame 0. */
+static int park_wq_cb(void *map, int *key, void *value)
+{
+	bpf_task_park(0, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int park_in_wq_callback(void *ctx)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+	if (bpf_wq_init(&elem->wq, &wq_map, 0))
+		return 0;
+	if (bpf_wq_set_callback(&elem->wq, park_wq_cb, 0))
+		return 0;
+	return bpf_wq_start(&elem->wq, 0);
+}
+
+static int park_task_work_cb(struct bpf_map *map, void *key, void *value)
+{
+	bpf_task_park(0, 0);
+	return 0;
+}
+
+SEC("syscall")
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int park_in_task_work_callback(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct tw_elem *elem;
+	__u32 key = 0;
+
+	elem = bpf_map_lookup_elem(&tw_map, &key);
+	if (!elem)
+		return 0;
+	return bpf_task_work_schedule_signal(task, &elem->tw, &tw_map, park_task_work_cb);
+}
+
+/* The exception callback unwinds the program after bpf_throw(): no park there either. */
+__noinline int park_exception_cb(u64 cookie)
+{
+	bpf_task_park(0, 0);
+	return 0;
+}
+
+SEC("syscall")
+__exception_cb(park_exception_cb)
+__arch_x86_64 __arch_arm64 __arch_s390x
+__failure __msg("bpf_task_park() is not allowed in a callback")
+int park_in_exception_callback(void *ctx)
+{
+	bpf_throw(0);
+	return 0;
+}
-- 
2.53.0

