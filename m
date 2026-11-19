Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795051766;
	b=bob7Oy8dBqLXk8V1X/InzyC7r+eLWlUtQsepu8ReyzLRLDCta7Q55dmz9ucfhS+fUiue
	 WTK1bbnCVDJb0JZTWLf7MT99hFhi5g/SpfrUM0+mRm+5B2uqDCACC7MxbmPUQixqN+Jxn
	 ou82P05CAhdAH8bE7my2LqOHDevgC3BbhoqOpNcxZYQzIdtDAyg/lZ+OeT23Zb+opSx0D
	 3rbkTW6RAgFC15WOABFtj1NO4HPKeMKb3aVUvX3789ZETO1rppHeSJ8wzbt1R4msv9Cg+
	 bVAKCtZhq7S3U4rJW7RqbRb2WmkJnoQY03IR/TcRix5EVYMwqh6rAbspAh4gUQmApNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795051766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YK/3UqG448iTYZMUabnUq8CDRuHGn2unPHOZ2lAdrHg=;
	b=f5QlIgyiH6eS6HQ/6Op/ZnOHc4eNjWDld5gnpFuCHcp5FNNz/VCjkAgxLD4i0waPcSt8
	 h5eJvjfjYaqBZhkabzKNxv6FukPmI+ZsGpmVVqKd2tjjkp/2v8CerrOdhWh83D4wpA5bP
	 uqMO/ah15zjp2W47sdtm87sKljQV1iBO4Mkx5afIB2ZiYWz/UevKDpIECkUyAZHs/aLaV
	 9v7bCYATANO0uwifqlz/AvcWT83YDjmlMtYIfWaWw1sW8aEpJiffawM3R0w7URt8pr39N
	 toO/eBRlOqu6EG5Sl64bjXTtP47viqVrbmmTGsxSv2YTcJyLJeH9jgZF6mePPxU+9sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S06wUJss;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB9606A31C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ADB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S06wUJss
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so1312784b3a.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795051765; x=1795656565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK/3UqG448iTYZMUabnUq8CDRuHGn2unPHOZ2lAdrHg=;
        b=S06wUJssSJsraZ5soR+dRtUp4Kqyb4rKOBDYPWD9xj4aqzARO5kiR0AOGglwkQCxcm
         9kj31oQi1cPvRxqNi/xTce0+ipCB9eQUDPkSN2X6njldSCbdaK0wNL6wg6HCCAfcMukq
         F89b4AVyD2BKYRZG0JIROcabnAPRHNqqnSv0PZG3VmAqMHh1e+/55YlcCVLOvGgtSnU+
         lbv7gP3VcNqJdZwoburUiKGueHut9gYu6GJ+GxCYsbcQkKpxEKwkqaGGK7wDU7S44/t2
         6d2cZqUqRboTtypmR7j8/G/a4S4Z31fviQZCG7bRHWWD9rfaycf+GWfjwAkDS/ZVGk34
         flOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051765; x=1795656565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YK/3UqG448iTYZMUabnUq8CDRuHGn2unPHOZ2lAdrHg=;
        b=YMXbRk5jBRwTH9/3d2HoGlz6rYoL/3dUYvz4cvKYDD6aCekeiAGPtJzvFbje6UkSr5
         f1B8kHOpKgep3C2JAHg87tCTU8G2aetkvPleNC+8bAD51d/SaUDVUSUxnmeHEMtHQvVB
         R9Gc7o9I77NNELWnhGm8Q1BLtH05EBrH0Yqffao5xg1AN/JUeVrv/ac1Z+0G+/XpgMC9
         Bt/hG4UrGuoOa7QqXatXAbux8d8C7wCT0M3xc46NxUawkGyyu4wa3x+ywE5oTbFGMNJK
         feIJlnkxUZOXktRfnRg1bGvWOn9MQBYcvnpkmn762OfCScRQnCvTOA0gm45dh9MKuzZs
         gdVA==
X-Gm-Message-State: APuU4Z/h4HrZtsCA8oP3fAZ3OSx5IQFW95Y1lE5Fv7DcQcRqUnFHwoBv
	xS5tMEQ/54ItWR89OMUHm1PjtlZ0O05BcUBLJb1TOzQ7qXhLKxMLBzQNe9o02A==
X-Gm-Gg: AYBFou2lmwytcH+18QBE4XHb4WEe8q8r/fmr1KPmSoHAwmiySbZsRqmgsxPY38h/jjV
	tzHNqYF5P9mGjLUXup6TkS0IsV+Vw0h92O0gL2yMkl2ocBA7D7mNXnkHZtAGxgnXUXb+Z5PZpG0
	Qqx+Xy21bGPEpE1ZqVEsfnJKpUuqd5caP0UlULuePxlr9BRlsQ0SqCK4bG/jM36Qu7T5m+g01SZ
	REsys9KKX1cEDxEd/H08MQY9P8D+orB0p+aSxIlJ2DKHDS6uFZxMyKowSBgPCd1J6a0fulvKrZF
	X7Zz9q/WUMDSXoSidhU+BrpSKwrfQm5A5p/GFK3slsBL+D38KLG50DQCs8+uvm7t0GUdI/EfAQw
	6oxC95UkPLy9fjagAkOabf0iGnDbdR+Rvq2NvUsLPV7oPvBxP5EPQnnj6Hm1iYmQ/4FO9wrcWMD
	1r6QN0lrAaxuPQDmzgvqxFlrnG7+DfXMMQhRkV26Z0Mh4gDOKaj+n8SgP2eLsQiXLoffpXRS47T
	aUt6H9PigowtHvPOfCZzvolPVcV9lrkBIz8+blVfXdipKFMalp6U9JL8iDCZmZ7WWwhN1PUpdru
	SFQ/QdcauYkBmpn9RirYOxaoOLUCtSBEt+8/WsvvxeoTOma6TIuyZgb0pvZtuK5bPeuLexOthAz
	03MQsPlOKJ9/GkOvmLYDK29nQWoAj/eFxYF9XhAockPfjwtgSLG1qSVXcOpXg4kRvsPNZaNHZuA
	==
X-Received: by 2002:a05:6a00:ab87:b0:89e:fe2d:abe2 with SMTP id d2e1a72fcca58-8c5d4bc1f3emr3594019b3a.44.1795051764649;
        Wed, 18 Nov 2026 17:29:24 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c6660c2f1asm1534033b3a.29.2026.11.18.17.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:29:24 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 2/5] selftests/bpf: Don't use BPF_MAX_TRAMP_LINKS
Date: Thu, 19 Nov 2026 01:29:06 +0000
Message-ID: <20261119012909.3657417-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

BPF_MAX_TRAMP_LINKS does not tell how many programs a trampoline takes.
Its image fills up earlier or later: that depends on the programs, on
the traced function and on the kernel. Three tests read the number from
the BTF of the kernel.

fexit_stress and the rollback test of tracing_multi need a trampoline
that is full. Let them attach programs until the attach fails with
-E2BIG. That is right with the limit and without it, and fexit_stress now
covers the attach that does not fit.

trampoline_count attaches BPF_MAX_TRAMP_LINKS programs and expects -E2BIG
for the next one. Drop it with its programs and its function in
bpf_testmod.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/fexit_stress.c   | 29 +++---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 35 ++++----
 .../bpf/prog_tests/trampoline_count.c         | 89 -------------------
 .../bpf/progs/test_trampoline_count.c         | 24 -----
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 18 ----
 tools/testing/selftests/bpf/test_progs.c      | 37 --------
 tools/testing/selftests/bpf/test_progs.h      |  2 -
 7 files changed, 32 insertions(+), 202 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/trampoline_count.c
 delete mode 100644 tools/testing/selftests/bpf/progs/test_trampoline_count.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
index 14c91b6f1e83..929b25d92bb1 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_stress.c
@@ -3,19 +3,13 @@
 #include <test_progs.h>
 #include "bpf_util.h"
 
+/* More programs than fit into the image of a trampoline */
+#define CNT 128
+
 void serial_test_fexit_stress(void)
 {
-	int bpf_max_tramp_links, err, i;
-	int *fd, *fexit_fd, *link_fd;
-
-	bpf_max_tramp_links = get_bpf_max_tramp_links();
-	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
-		return;
-	fd = calloc(bpf_max_tramp_links * 2, sizeof(*fd));
-	if (!ASSERT_OK_PTR(fd, "fd"))
-		return;
-	fexit_fd = fd;
-	link_fd = fd + bpf_max_tramp_links;
+	int fexit_fd[CNT] = {}, link_fd[CNT] = {};
+	int err, i;
 
 	const struct bpf_insn trace_program[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 0),
@@ -34,7 +28,7 @@ void serial_test_fexit_stress(void)
 		goto out;
 	trace_opts.attach_btf_id = err;
 
-	for (i = 0; i < bpf_max_tramp_links; i++) {
+	for (i = 0; i < CNT; i++) {
 		fexit_fd[i] = bpf_prog_load(BPF_PROG_TYPE_TRACING, NULL, "GPL",
 					    trace_program,
 					    ARRAY_SIZE(trace_program),
@@ -42,19 +36,22 @@ void serial_test_fexit_stress(void)
 		if (!ASSERT_GE(fexit_fd[i], 0, "fexit load"))
 			goto out;
 		link_fd[i] = bpf_link_create(fexit_fd[i], 0, BPF_TRACE_FEXIT, NULL);
-		if (!ASSERT_GE(link_fd[i], 0, "fexit attach"))
-			goto out;
+		if (link_fd[i] < 0)
+			break;
 	}
+	/* The image is full */
+	if (!ASSERT_GT(i, 1, "attached") || !ASSERT_LT(i, CNT, "attached") ||
+	    !ASSERT_EQ(link_fd[i], -E2BIG, "fexit attach"))
+		goto out;
 
 	err = bpf_prog_test_run_opts(fexit_fd[0], &topts);
 	ASSERT_OK(err, "bpf_prog_test_run_opts");
 
 out:
-	for (i = 0; i < bpf_max_tramp_links; i++) {
+	for (i = 0; i < CNT; i++) {
 		if (link_fd[i] > 0)
 			close(link_fd[i]);
 		if (fexit_fd[i] > 0)
 			close(fexit_fd[i]);
 	}
-	free(fd);
 }
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index cc727011f3a2..51ca65dae6f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -984,16 +984,20 @@ static struct tracing_multi_rollback *extra_load_and_link(void)
 	return NULL;
 }
 
-static struct tracing_multi_rollback **fillers_load_and_link(int max)
+/* More programs than fit into the image of a trampoline */
+#define FILLERS_MAX 128
+
+/* Attach programs to bpf_fentry_test10 until the image of its trampoline is full */
+static struct tracing_multi_rollback **fillers_load_and_link(void)
 {
 	struct tracing_multi_rollback **skels, *skel;
 	int i, err;
 
-	skels = calloc(max + 1, sizeof(*skels));
+	skels = calloc(FILLERS_MAX, sizeof(*skels));
 	if (!ASSERT_OK_PTR(skels, "calloc"))
 		return NULL;
 
-	for (i = 0; i < max; i++) {
+	for (i = 0; i < FILLERS_MAX; i++) {
 		skel = skels[i] = tracing_multi_rollback__open();
 		if (!ASSERT_OK_PTR(skels[i], "tracing_multi_rollback__open"))
 			goto cleanup;
@@ -1005,14 +1009,18 @@ static struct tracing_multi_rollback **fillers_load_and_link(int max)
 			goto cleanup;
 
 		skel->links.filler = bpf_program__attach_trace(skel->progs.filler);
-		if (!ASSERT_OK_PTR(skels[i]->links.filler, "bpf_program__attach_trace"))
-			goto cleanup;
+		err = libbpf_get_error(skel->links.filler);
+		if (err)
+			break;
 	}
 
+	if (!ASSERT_EQ(err, -E2BIG, "bpf_program__attach_trace"))
+		goto cleanup;
+
 	return skels;
 
 cleanup:
-	fillers_cleanup(skels, i + 1);
+	fillers_cleanup(skels, FILLERS_MAX);
 	return NULL;
 }
 
@@ -1023,14 +1031,9 @@ static void test_rollback_unlink(void)
 	struct tracing_multi_rollback **fillers;
 	size_t cnt = FUNCS_CNT;
 	__u32 *ids = NULL;
-	int err, max;
-
-	max = get_bpf_max_tramp_links();
-	if (!ASSERT_GE(max, 1, "bpf_max_tramp_links"))
-		return;
+	int err;
 
-	/* Attach maximum allowed programs to bpf_fentry_test10 */
-	fillers = fillers_load_and_link(max);
+	fillers = fillers_load_and_link();
 	if (!ASSERT_OK_PTR(fillers, "fillers_load_and_link"))
 		return;
 
@@ -1047,8 +1050,8 @@ static void test_rollback_unlink(void)
 
 	/*
 	 * Attach tracing_multi link on bpf_fentry_test1-10, which will
-	 * fail on bpf_fentry_test10 function, because it already has
-	 * maximum allowed programs attached.
+	 * fail on bpf_fentry_test10 function, because the image of its
+	 * trampoline is full.
 	 *
 	 * The rollback needs to unlink already link-ed trampolines and
 	 * put all of them.
@@ -1079,7 +1082,7 @@ static void test_rollback_unlink(void)
 	tracing_multi_rollback_run(skel);
 
 cleanup:
-	fillers_cleanup(fillers, max);
+	fillers_cleanup(fillers, FILLERS_MAX);
 	tracing_multi_rollback__destroy(extra);
 	tracing_multi_rollback__destroy(skel);
 	free(ids);
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
deleted file mode 100644
index 7321850db75f..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ /dev/null
@@ -1,89 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#define _GNU_SOURCE
-#include <test_progs.h>
-
-struct inst {
-	struct bpf_object *obj;
-	struct bpf_link   *link;
-};
-
-static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
-{
-	struct bpf_object *obj;
-	struct bpf_program *prog;
-	int err;
-
-	obj = bpf_object__open_file(file, NULL);
-	if (!ASSERT_OK_PTR(obj, "obj_open_file"))
-		return NULL;
-
-	inst->obj = obj;
-
-	err = bpf_object__load(obj);
-	if (!ASSERT_OK(err, "obj_load"))
-		return NULL;
-
-	prog = bpf_object__find_program_by_name(obj, name);
-	if (!ASSERT_OK_PTR(prog, "obj_find_prog"))
-		return NULL;
-
-	return prog;
-}
-
-void test_trampoline_count(void)
-{
-	char *file = "test_trampoline_count.bpf.o";
-	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
-	int bpf_max_tramp_links, i;
-	struct bpf_program *prog;
-	struct bpf_link *link;
-	struct inst *inst;
-
-	bpf_max_tramp_links = get_bpf_max_tramp_links();
-	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
-		return;
-	inst = calloc(bpf_max_tramp_links + 1, sizeof(*inst));
-	if (!ASSERT_OK_PTR(inst, "inst"))
-		return;
-
-	/* attach 'allowed' trampoline programs */
-	for (i = 0; i < bpf_max_tramp_links; i++) {
-		prog = load_prog(file, progs[i % ARRAY_SIZE(progs)], &inst[i]);
-		if (!prog)
-			goto cleanup;
-
-		link = bpf_program__attach(prog);
-		if (!ASSERT_OK_PTR(link, "attach_prog"))
-			goto cleanup;
-
-		inst[i].link = link;
-	}
-
-	/* and try 1 extra.. */
-	prog = load_prog(file, "fmod_ret_test", &inst[i]);
-	if (!prog)
-		goto cleanup;
-
-	/* ..that needs to fail */
-	link = bpf_program__attach(prog);
-	if (!ASSERT_ERR_PTR(link, "attach_prog")) {
-		inst[i].link = link;
-		goto cleanup;
-	}
-
-	/* with E2BIG error */
-	if (!ASSERT_EQ(libbpf_get_error(link), -E2BIG, "E2BIG"))
-		goto cleanup;
-	if (!ASSERT_EQ(link, NULL, "ptr_is_null"))
-		goto cleanup;
-
-	/* and finally execute the probe */
-	ASSERT_OK(trigger_module_test_read(256), "trigger_module_test_read");
-
-cleanup:
-	for (; i >= 0; i--) {
-		bpf_link__destroy(inst[i].link);
-		bpf_object__close(inst[i].obj);
-	}
-	free(inst);
-}
diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
deleted file mode 100644
index 02f52806b1b2..000000000000
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-
-SEC("fentry/bpf_testmod_trampoline_count_test")
-int BPF_PROG(fentry_test)
-{
-	return 0;
-}
-
-SEC("fmod_ret/bpf_testmod_trampoline_count_test")
-int BPF_PROG(fmod_ret_test, int ret)
-{
-	return 0;
-}
-
-SEC("fexit/bpf_testmod_trampoline_count_test")
-int BPF_PROG(fexit_test, int ret)
-{
-	return 0;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1f8bc0c99a71..58846056f667 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -767,11 +767,6 @@ noinline void bpf_testmod_stacktrace_test_1(void)
 
 int bpf_testmod_fentry_ok;
 
-noinline int bpf_testmod_trampoline_count_test(void)
-{
-	return 0;
-}
-
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -861,8 +856,6 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 			21, 22, 23, 24, 25, 26) != 231)
 		goto out;
 
-	bpf_testmod_trampoline_count_test();
-
 	bpf_testmod_stacktrace_test_1();
 
 	bpf_testmod_fentry_ok = 1;
@@ -2609,16 +2602,6 @@ struct bpf_struct_ops testmod_multi_st_ops = {
 
 extern int bpf_fentry_test1(int a);
 
-BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
-BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
-BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
-
-static const struct
-btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
-	.owner = THIS_MODULE,
-	.set = &bpf_testmod_trampoline_count_ids,
-};
-
 static int bpf_testmod_init(void)
 {
 	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
@@ -2635,7 +2618,6 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
-	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 168d84cf4eb7..d19924e87e86 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1269,43 +1269,6 @@ int write_sysctl(const char *sysctl, const char *value)
 	return 0;
 }
 
-int get_bpf_max_tramp_links_from(struct btf *btf)
-{
-	const struct btf_enum *e;
-	const struct btf_type *t;
-	__u32 i, type_cnt;
-	const char *name;
-	__u32 j, vlen;
-
-	for (i = 1, type_cnt = btf__type_cnt(btf); i < type_cnt; i++) {
-		t = btf__type_by_id(btf, i);
-		if (!t || !btf_is_enum(t) || t->name_off)
-			continue;
-		e = btf_enum(t);
-		for (j = 0, vlen = btf_vlen(t); j < vlen; j++, e++) {
-			name = btf__str_by_offset(btf, e->name_off);
-			if (name && !strcmp(name, "BPF_MAX_TRAMP_LINKS"))
-				return e->val;
-		}
-	}
-
-	return -1;
-}
-
-int get_bpf_max_tramp_links(void)
-{
-	struct btf *vmlinux_btf;
-	int ret;
-
-	vmlinux_btf = btf__load_vmlinux_btf();
-	if (!ASSERT_OK_PTR(vmlinux_btf, "vmlinux btf"))
-		return -1;
-	ret = get_bpf_max_tramp_links_from(vmlinux_btf);
-	btf__free(vmlinux_btf);
-
-	return ret;
-}
-
 static void dump_crash_log(void)
 {
 	fflush(stdout);
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index adc18f5eceb6..6fd105eed34e 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -501,8 +501,6 @@ int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int trigger_module_test_read(int read_sz);
 int trigger_module_test_write(int write_sz);
 int write_sysctl(const char *sysctl, const char *value);
-int get_bpf_max_tramp_links_from(struct btf *btf);
-int get_bpf_max_tramp_links(void);
 
 struct netns_obj;
 struct netns_obj *netns_new(const char *name, bool open);
-- 
2.55.0

