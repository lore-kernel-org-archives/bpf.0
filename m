Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793657300;
	b=iFk5hLLtS2/Echfhm1PtSXQKsrfvmYIAHRQUjVi9FxXl1PI9a35Et5UmOKPDNTVJLWa1
	 siT9OqA7FS8NOroRGGkhiXHoBhtYoMlEDlcIr206+iUz/dwijJw0O/Bk+XN5apyuOdggz
	 YY2rCZ0QB6W0EvJQmSf0VG+9qcM6iGvLB3e5FqwLnJtAsksaetWL1b4EzkH1g9BkYbFNF
	 kUmGlnunHhxbpIhBNOYTOpb+yyjfMBDSRLWReANsJp/b6d4kp8lZS4WUA0umXA8ajBVxQ
	 Kvo7xRkbr+KuH1Y8pBOlJFFIsYW7wT5ud4tQtSUegxMxPy/k9J/L5LembTBuFO0PgEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657300;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+pm9gGaZs/CLh7OoTmuolKvilNEtJFezKPiXE4mTJrk=;
	b=MSvqZBvbvWbAWI2D42iReT68SnnGGDYRFC31+dAON0j/bZotTYUlJZIqBhCvBsGlhbTk
	 xJnhuyBh9J8yiSISnhXNqyGnraO+YmCFst3Aolu8CfWjk4RyRri/vrKM5J2naUFzlpOpY
	 45qGGZY/hMsnFZyF8oQKSvfBwLtsWuDKrmu4YzPQhnVs2Obbid+JNj1vNXjEgmS1KSidi
	 aFp3B6eTQGMa9dpsvJMP9O4wEjdZNmCR9dVHiIc2x/aoFDaV10gPtCT6Nd73ShMtPyvF9
	 sz+4iSzsxhvxjBDRgx2+d1RGmT3sDN8kBNg4g8rpZfYrrn0JQaUEQ38s74Mv+O9pMOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="w/vFrUmg";
	arc=none smtp.remote-ip=91.218.175.203
Received: from mta0.migadu.com (out-203.mta0.migadu.com [91.218.175.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60509606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 22:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60509606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w/vFrUmg
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9fjztXg2DC76hhkmLgtkEbkjo8i8oo2Esga6BzQfns4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793657297; v=1; x=1794262097;
 b=w/vFrUmgnk7uuaFBQaIkpp+V5ZFaH8R5o13Oj+ZvJ4Yam3GhxJkcBzVi8h1EPIzLQHqwfmxh
 IHLqbqCTfTEv/PF47hB1CCbsnbauyCGr7A63W08gq1GRQVKlP+/+6GGZhUEpk61Zf45Bq6JfKGQ
 JGSttjwgA8ocSxrc8EzRs+kk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 20f9fe87d35c4850;
	Mon, 02 Nov 2026 22:08:17 +0000
X-Mizu-Trace-ID: 20f9fe87d35c4850
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	jose.marchesi@oracle.com,
	david.faust@oss.qualcomm.com,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf-next v3 8/8] selftests/bpf: skip the struct_ops arena tests without compiler support
Date: Mon,  2 Nov 2026 14:07:17 -0800
Message-ID: <20261102220717.4079739-9-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220717.4079739-1-vineet.gupta@linux.dev>
References: <20261102220717.4079739-1-vineet.gupta@linux.dev>
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

trigger() in struct_ops_arena.c and its three siblings puts the
__BPF_FEATURE_ADDR_SPACE_CAST guard inside the function, so without
arena support the body is gone and the program falls through to
"return 0".  The host side then does

  err = bpf_prog_test_run_opts(bpf_program__fd(trigger), &topts);
  ASSERT_OK(err, "test_run");
  ASSERT_EQ(topts.retval, 0, "trigger_retval");

and passes, having run a program that did nothing.  Two tests report OK
under a stock bpf-gcc on that basis: arena_arg and arena_autobind.  The
other two, arena_member and arena_member_render, need a testmod BTF
carrying the arena type tag and are not reached without one, but are
fixed the same way.

These are not driven by test_loader, so __skip_without_arena does not
reach them.  Use the flag-in-.data pattern linked_externs.c already
uses for the same situation: the program exports skip_tests, and the
host checks it before attaching and reports SKIP.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../bpf/prog_tests/test_struct_ops_arena.c    | 27 +++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_arena.c    | 10 +++++++
 .../bpf/progs/struct_ops_arena_autobind.c     | 10 +++++++
 .../bpf/progs/struct_ops_arena_member.c       | 10 +++++++
 .../progs/struct_ops_arena_member_render.c    | 10 +++++++
 5 files changed, 67 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
index e7580b9f0fc2..11b7dab77ff7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_arena.c
@@ -31,6 +31,12 @@ static void arena_arg(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_arena__open_and_load"))
 		return;
 
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP: no addr_space_cast support in the BPF compiler\n", __func__);
+		test__skip();
+		goto out;
+	}
+
 	link = bpf_map__attach_struct_ops(skel->maps.testmod_arena);
 	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
 		goto out;
@@ -142,6 +148,13 @@ static void arena_member(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_member__open_and_load"))
 		return;
 
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP: no addr_space_cast support in the BPF compiler\n", __func__);
+		test__skip();
+		struct_ops_arena_member__destroy(skel);
+		return;
+	}
+
 	attach_and_trigger(skel->maps.testmod_arena_member, skel->progs.trigger);
 	struct_ops_arena_member__destroy(skel);
 }
@@ -186,6 +199,13 @@ static void arena_autobind(void)
 	assert_prog_map(bpf_program__fd(skel->progs.test_arena_cb), info.id, "test_arena_cb");
 	assert_prog_map(bpf_program__fd(skel->progs.unrelated), info.id, "unrelated");
 
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP: no addr_space_cast support in the BPF compiler\n", __func__);
+		test__skip();
+		struct_ops_arena_autobind__destroy(skel);
+		return;
+	}
+
 	attach_and_trigger(skel->maps.testmod_arena_autobind, skel->progs.trigger);
 out:
 	struct_ops_arena_autobind__destroy(skel);
@@ -268,6 +288,13 @@ static void arena_member_render(void)
 	if (!ASSERT_OK_PTR(skel, "struct_ops_arena_member_render__open_and_load"))
 		return;
 
+	if (skel->data->skip_tests) {
+		printf("%s:SKIP: no addr_space_cast support in the BPF compiler\n", __func__);
+		test__skip();
+		struct_ops_arena_member_render__destroy(skel);
+		return;
+	}
+
 	attach_and_trigger(skel->maps.testmod_arena_member_render, skel->progs.trigger);
 	struct_ops_arena_member_render__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena.c b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
index 8aa8639df91f..612ca868c8fe 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena.c
@@ -83,6 +83,16 @@ struct bpf_testmod_ops3 testmod_arena = {
 	.test_arena_multislot = (void *)test_arena_multislot_cb,
 };
 
+/*
+ * These tests are not driven by test_loader, so __skip_without_arena
+ * cannot reach them; the host side reads this flag and skips instead.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
 SEC("syscall")
 int trigger(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
index 495faa0f4a8b..de026d901dcb 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_autobind.c
@@ -42,6 +42,16 @@ int unrelated(void *ctx)
 	return 0;
 }
 
+/*
+ * These tests are not driven by test_loader, so __skip_without_arena
+ * cannot reach them; the host side reads this flag and skips instead.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
 SEC("syscall")
 int trigger(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
index a2218cd81619..4ec0aead3e95 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
@@ -77,6 +77,16 @@ struct bpf_testmod_ops3 testmod_arena_member = {
 	.test_arena_member = (void *)test_arena_member_cb,
 };
 
+/*
+ * These tests are not driven by test_loader, so __skip_without_arena
+ * cannot reach them; the host side reads this flag and skips instead.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
 SEC("syscall")
 int trigger(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
index 09b4c740bdca..3ccbc6e71626 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member_render.c
@@ -60,6 +60,16 @@ struct bpf_testmod_ops3 testmod_arena_member_render = {
 	.test_arena_member = (void *)test_arena_member_render_cb,
 };
 
+/*
+ * These tests are not driven by test_loader, so __skip_without_arena
+ * cannot reach them; the host side reads this flag and skips instead.
+ */
+#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
+bool skip_tests __attribute((__section__(".data"))) = false;
+#else
+bool skip_tests = true;
+#endif
+
 SEC("syscall")
 int trigger(void *ctx)
 {
-- 
2.53.0-Meta

