Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059112;
	b=QC/FWqeVmry8umzf+8uPGNbLJ7FIEIfD+4KzopSsBh4Gkr4Z4do04LRJu4uTyXkaig6c
	 ZSHAoIRjpW90vlHSCX30M5rCshFnlt03+c5LGl4a4fsrIdWatgLUzUC9ZD3a/ohkw4ZpD
	 bip4vzY7XLLz5HcM07YUVlt8MV+4ElYrqDSqlA4Hi/B/bIxXW6qJMhx+CulXAuWJnoZmh
	 I9i8eY5Y5WbIPn4srNfhcRYF7FOX1Jo1cb8O4rahImiFP1NCLAJSELor0J/13kpUn3Ryd
	 /3GuFVHpJzxOMXeQY57sGqQexhBHryMVlOXToSmY/eZsFOkqc1h6v2SFQPUMgprg6mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059112;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=YxTjdsoLDTFjbludj0TwXUH1hmfcO65i9BFo17EwK9I=;
	b=wluTjcdT/7IsrE6VieLV/AKc2nMYVana4jSb1+tqckqtQna4DetqBe0eSvhxHAx/itj9
	 NTdwoLMOIVwx2wyFOp4AcOtoXrknt0eFCOzNJXnvPHrPOWzxyKsrYOuUO8fb8N2thaTik
	 4Mvvc+9cyFxCftfuGh+TyuIxtWVIgLxq3Wrn7mhxF3qKVn/MFcbwsm9z03y0QOCCrCzwr
	 8/jOX70Ey+M4l+ox/7iFD6hsndASRHz+XzNdeKqFqhA3qx17ZZ/a9y+QLmKvtPXmgVNJ1
	 CQTZFGM8H035n85UgCR7cJg7K6ilOvZmWrZfFUDUR50Fe+HhWibTmIB4sAdUwOfMteg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lI0tzo8a;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57749606A334
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57749606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=lI0tzo8a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yx
	TjdsoLDTFjbludj0TwXUH1hmfcO65i9BFo17EwK9I=; b=lI0tzo8asJhY5wZiqt
	6huUw74ZCT3rLFpSoolt5lEetrgcXtX42OEBwtDjCZEhg7puTK2pVKU/NfftTxbz
	G1M2LwOE5WfRsKAebVZhl4DSKT17QQywmZNAXuy38PIkWomXbckSVUjsYUnDY+EL
	ex9+5mRpSe4fTPWWBZE3cTNlQ=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S8;
	Thu, 19 Nov 2026 11:31:08 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: Test wq callback setup after deletion and user release
Date: Thu, 19 Nov 2026 11:30:51 +0800
Message-ID: <20261119033051.196177-7-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3JFy5XFWUZrW8Jw45CF47XFb_yoWxArWxpa
	ykGryYkr4ftw13Ja1Sva1FgF4Fvrs7XrW7JF9Ygr9IvrnxJrn3Grs7KFyavFn8AFZ5Jr1f
	A3y3Ka15ua1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYwZcUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6xzUo2r+bXwZtgAA3q

From: Yun Lu <luyun@kylinos.cn>

Use the existing NO_PREALLOC HASH map and callback to test that
bpf_wq_set_callback() rejects a deleted value with -ENOENT.

Keep the map alive through a program fd after dropping its last user
reference. When bpf_wq_init() returns -EBUSY on a reinserted element,
the idle callback survived reuse. Check that the setter returns -EPERM.
On v3 the same test gets 0. Retry only a cache miss and report cleanup
failures separately after attempting to delete each inserted element.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 103 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/wq.c      |  62 ++++++++++++
 2 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index a4f71bc34fa6..f783a91417e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -1,11 +1,109 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2024 Benjamin Tissoires */
+#include <errno.h>
+#include <sched.h>
+#include <unistd.h>
 #include <test_progs.h>
 #include "wq.skel.h"
 #include "wq_failures.skel.h"
 
 #define CALLBACK_WAIT_RETRIES 10000
 #define CALLBACK_WAIT_US 1000
+#define WQ_USERCNT_MAX_ATTEMPTS 256
+#define WQ_USERCNT_RETRY EAGAIN
+
+static int pin_to_first_cpu(cpu_set_t *old_mask)
+{
+	cpu_set_t new_mask;
+	int cpu;
+
+	if (sched_getaffinity(0, sizeof(*old_mask), old_mask))
+		return -errno;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++)
+		if (CPU_ISSET(cpu, old_mask))
+			break;
+	if (cpu == CPU_SETSIZE)
+		return -EINVAL;
+
+	CPU_ZERO(&new_mask);
+	CPU_SET(cpu, &new_mask);
+	if (sched_setaffinity(0, sizeof(new_mask), &new_mask))
+		return -errno;
+	return 0;
+}
+
+static int run_wq_prog(int prog_fd, __s32 *retval)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int err;
+
+	err = bpf_prog_test_run_opts(prog_fd, &opts);
+	if (err)
+		return err;
+	*retval = (__s32)opts.retval;
+	return 0;
+}
+
+/* Check callback setup after reusing an idle object with no map uref. */
+static void test_wq_usercnt_reuse(void)
+{
+	struct wq *skel = NULL;
+	cpu_set_t old_mask;
+	__s32 retval = 0;
+	int stage_b_fd = -1;
+	int err, attempt;
+
+	if (!ASSERT_OK(pin_to_first_cpu(&old_mask), "pin"))
+		return;
+
+	for (attempt = 0; attempt < WQ_USERCNT_MAX_ATTEMPTS; attempt++) {
+		skel = wq__open_and_load();
+		if (!ASSERT_OK_PTR(skel, "wq__open_and_load"))
+			break;
+
+		err = run_wq_prog(bpf_program__fd(skel->progs.test_deleted_wq),
+				  &retval);
+		if (!ASSERT_OK(err, "test_deleted_wq_run") ||
+		    !ASSERT_EQ(retval, (__s32)-ENOENT, "test_deleted_wq_ret"))
+			break;
+
+		stage_b_fd = dup(bpf_program__fd(skel->progs.test_wq_usercnt_reuse));
+		if (!ASSERT_GE(stage_b_fd, 0, "dup_stage_b"))
+			break;
+
+		/* Drop all target-map user FDs; the retained program FD keeps
+		 * the map alive through used_maps, but usercnt becomes zero.
+		 */
+		wq__destroy(skel);
+		skel = NULL;
+
+		err = run_wq_prog(stage_b_fd, &retval);
+		close(stage_b_fd);
+		if (!ASSERT_OK(err, "stage_b_run"))
+			break;
+
+		if (retval == WQ_USERCNT_RETRY) {
+			/* The cached element was not reused; try again. */
+			continue;
+		}
+		if (retval > 0) {
+			ASSERT_FAIL("usercnt stage error %d", retval);
+			break;
+		}
+
+		ASSERT_EQ(retval, (__s32)-EPERM, "usercnt_setter_ret");
+		break;
+	}
+
+	if (attempt == WQ_USERCNT_MAX_ATTEMPTS)
+		ASSERT_FAIL("usercnt reuse not hit after %d attempts",
+			    WQ_USERCNT_MAX_ATTEMPTS);
+
+	if (skel)
+		wq__destroy(skel);
+	sched_setaffinity(0, sizeof(old_mask), &old_mask);
+}
 
 void serial_test_wq(void)
 {
@@ -20,7 +118,7 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq__open_and_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
@@ -37,6 +135,9 @@ void serial_test_wq(void)
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:
 	wq__destroy(wq_skel);
+
+	if (test__start_subtest("usercnt_reuse"))
+		test_wq_usercnt_reuse();
 }
 
 void serial_test_failures_wq(void)
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 25be2cd9d42c..1543eeb7165f 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -3,6 +3,7 @@
  */
 
 #include "bpf_experimental.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
@@ -138,6 +139,67 @@ static int wq_cb_sleepable(void *map, int *key, void *value)
 	return 0;
 }
 
+SEC("syscall")
+__retval(-ENOENT)
+long test_deleted_wq(void *ctx)
+{
+	struct hmap_elem empty = {}, *value;
+	int key = 0;
+
+	if (bpf_map_update_elem(&hmap_malloc, &key, &empty, BPF_NOEXIST))
+		return 1;
+	value = bpf_map_lookup_elem(&hmap_malloc, &key);
+	if (!value)
+		return 2;
+	if (bpf_map_delete_elem(&hmap_malloc, &key))
+		return 3;
+	if (bpf_wq_init(&value->work, &hmap_malloc, 0))
+		return 4;
+	return bpf_wq_set_callback(&value->work, wq_callback, 0);
+}
+
+#define WQ_USERCNT_RETRY EAGAIN
+#define WQ_USERCNT_SETUP_FAIL 1
+#define WQ_USERCNT_CLEANUP_FAIL 2
+
+/*
+ * The host runs this after dropping all user references to hmap_malloc.
+ * Use positive EAGAIN for a reuse miss. Return the setter result only
+ * after deleting the inserted element.
+ */
+SEC("syscall")
+long test_wq_usercnt_reuse(void *ctx)
+{
+	struct hmap_elem empty = {}, *value;
+	long init_ret, result;
+	int key = 0;
+
+	if (bpf_map_update_elem(&hmap_malloc, &key, &empty, BPF_NOEXIST))
+		return WQ_USERCNT_SETUP_FAIL;
+
+	value = bpf_map_lookup_elem(&hmap_malloc, &key);
+	if (!value) {
+		result = WQ_USERCNT_SETUP_FAIL;
+		goto delete;
+	}
+
+	init_ret = bpf_wq_init(&value->work, &hmap_malloc, 0);
+	if (init_ret == -EBUSY) {
+		result = bpf_wq_set_callback(&value->work, wq_callback, 0);
+	} else if (init_ret == -EPERM) {
+		/* The retained idle callback was not reused. */
+		result = WQ_USERCNT_RETRY;
+	} else {
+		/* init 0 or another error is a setup failure, not a miss. */
+		result = WQ_USERCNT_SETUP_FAIL;
+	}
+
+delete:
+	if (bpf_map_delete_elem(&hmap_malloc, &key))
+		return WQ_USERCNT_CLEANUP_FAIL;
+	return result;
+}
+
 SEC("tc")
 /* test that workqueues can be used from an array */
 __retval(0)
-- 
2.43.0

