Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584779;
	b=1GgynXLRkSG8E5WZnI9FRolGKZYvCYBRkGszSgzq60/pQPAG3TFc6AzuiAnNNU2M4GHG
	 IFubWcd8CC+mSIjWzfQSXaClOYKOnwZaXF7QADe9M95egTxCqaMJHmDkKF8nd5h675qvO
	 bdcvaodqQAsIjHuO5r7WkuLOsPp8571iCGIi8qE2gFsOmWryz2T/Z8qls3p8h4d+rE9wa
	 7DfDWA5w3ub0+7FRrsB4Rtyd1lNAC9KFTKSDjZva9tGjMX/4K7E8CWPzrVltAfGrkcy3/
	 juneUCtbGPbBwnnkmJcm1ry9P0cvcufowReR7c7um8u6jLcVeXBVTI9qB9X9IEQzvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584779;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LOvq5qTsXOhuL0f+WJ6hk3zJTsKqEHMRgbWVdtpOXIM=;
	b=POMVyz8YHF1mVzREVR4hPv9ry42mO7T4+Y7Ehk2w2StbHMrkjORYqrB5rqff/MCYpCa7
	 DyKTjy8POi0oDbBDKHrw1UBlc3JT3nTgsmOg5Jx8bv/ucLPG4vHge0AGIoF1ffA3IG0xR
	 6q9mVOFjw7yXNohr03lTH4BYASO9DhQIQP9+lOcE5d0V1rZaoPx1SCuFZpMdZ09YuV5dX
	 81IDKo6AQsaoifnWc8FDnaId/sDXjNgTgr9R/x1rz4feYQ5QJ7XreSm4JKVJYQJbpwMeM
	 mbJNFjAIu4cIgoegXe2J48Xrvbiu0ou/omdMb3FIqEzytNhiV3u5h89EQyHs6JROqkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="F0f/6QD8";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E43606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43E43606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F0f/6QD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=LO
	vq5qTsXOhuL0f+WJ6hk3zJTsKqEHMRgbWVdtpOXIM=; b=F0f/6QD8e6nz5YuqSp
	z0jrWPkmW72ZsFLLn8S9kQmMbEr/fHKq3sow+FBPdEr3lS8vhYEwoHewYoZLDR3I
	ZRHHsBIpZ/mAlecOedbgy1pGVFOkg0e+UlU2PJ3jF/zbbEcE4te0411XA3sVACEN
	x+7rs3H6vBxz/bH8sFunQWJYQ=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S8;
	Wed, 25 Nov 2026 13:31:53 +0800 (CST)
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
Subject: [PATCH bpf-next v5 6/6] selftests/bpf: Test wq callback setup after deletion and user release
Date: Wed, 25 Nov 2026 13:31:32 +0800
Message-ID: <20261125053132.444234-7-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125053132.444234-1-luyun_611@163.com>
References: <20261125053132.444234-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S8
X-Coremail-Antispam: 1Uf129KBjvJXoW3GryxuF1xAry7CrWrtry8AFb_yoWfZFyUpF
	WrKry5tr4rXw13J39Iva1rWF1Fqws5X3yUJF95Was0vr1xCrnrZrs7KFyjvFnxGrZ5Jw4f
	Aw13ta1ruayUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnzVbUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7Akr+WsGcsmkiQAA3M

From: Yun Lu <luyun@kylinos.cn>

Use RUN_TESTS(wq) to check that the setter rejects a deleted value with
-ENOENT. For the separate usercnt case, load the preparation and reuse
programs once and swap a fresh inner hash map into an outer map-in-map
slot on each attempt, following the existing map-in-map selftests.

The outer slot holds only a normal reference on the inner map. Prepare
an idle WQ object while the inner map still has a user FD, then close
that FD so usercnt reaches zero while the map stays alive. An -EBUSY
result from bpf_wq_init() identifies a reused slot with an idle object.
Expect the setter to return -EPERM. When the setter checks membership
but omits the usercnt check, it returns 0 instead.

Retry only a cache miss. Fail the subtest on setup or cleanup errors
and on retry exhaustion so a passing result requires reaching the
setter assertion. Clear the outer slot each round so a retained
callback cannot pin the inner map, program and outer map in a cycle.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/wq.c | 115 +++++++++++++++++++-
 tools/testing/selftests/bpf/progs/wq.c      | 109 ++++++++++++++++++-
 2 files changed, 221 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
index a4f71bc..e8163bc 100644
--- a/tools/testing/selftests/bpf/prog_tests/wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/wq.c
@@ -1,11 +1,121 @@
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
+/* Check callback setup after reusing an idle object with no map uref. */
+static void test_wq_usercnt_reuse(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_program *prog;
+	struct wq *skel = NULL;
+	cpu_set_t old_mask;
+	int err, attempt, inner_fd, outer_fd;
+	int prepare_fd, reuse_fd;
+
+	if (!ASSERT_OK(pin_to_first_cpu(&old_mask), "pin"))
+		return;
+
+	skel = wq__open();
+	if (!ASSERT_OK_PTR(skel, "wq__open"))
+		goto restore;
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		if (prog != skel->progs.prepare_wq_usercnt_reuse &&
+		    prog != skel->progs.test_wq_usercnt_reuse)
+			bpf_program__set_autoload(prog, false);
+	}
+	err = wq__load(skel);
+	if (!ASSERT_OK(err, "wq__load"))
+		goto destroy;
+
+	outer_fd = bpf_map__fd(skel->maps.outer_wq);
+	prepare_fd = bpf_program__fd(skel->progs.prepare_wq_usercnt_reuse);
+	reuse_fd = bpf_program__fd(skel->progs.test_wq_usercnt_reuse);
+
+	opts.btf_fd = bpf_object__btf_fd(skel->obj);
+	opts.btf_key_type_id = bpf_map__btf_key_type_id(skel->maps.hmap_malloc);
+	opts.btf_value_type_id = bpf_map__btf_value_type_id(skel->maps.hmap_malloc);
+	opts.map_flags = BPF_F_NO_PREALLOC;
+
+	for (attempt = 0; attempt < WQ_USERCNT_MAX_ATTEMPTS; attempt++) {
+		LIBBPF_OPTS(bpf_test_run_opts, run_opts);
+		bool have_reuse_retval = false;
+		int key = 0;
+		__s32 retval;
+
+		/* Only key 0 is used; a single bucket suffices. */
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "wq_usercnt",
+					  sizeof(int),
+					  bpf_map__value_size(skel->maps.hmap_malloc),
+					  1, &opts);
+		if (!ASSERT_GE(inner_fd, 0, "inner_create"))
+			break;
+
+		err = bpf_map_update_elem(outer_fd, &key, &inner_fd, 0);
+		if (!ASSERT_OK(err, "inner_install")) {
+			close(inner_fd);
+			break;
+		}
+
+		err = bpf_prog_test_run_opts(prepare_fd, &run_opts);
+		/* The outer slot keeps the inner map alive after its last user FD closes. */
+		close(inner_fd);
+		if (ASSERT_OK(err, "usercnt_prepare_run") &&
+		    ASSERT_OK((__s32)run_opts.retval, "usercnt_prepare_ret")) {
+			err = bpf_prog_test_run_opts(reuse_fd, &run_opts);
+			have_reuse_retval = ASSERT_OK(err, "usercnt_reuse_run");
+		}
+
+		/* Drop the outer reference even if a callback retains the program. */
+		err = bpf_map_delete_elem(outer_fd, &key);
+		if (!ASSERT_OK(err, "outer_slot_clear") || !have_reuse_retval)
+			break;
+
+		retval = (__s32)run_opts.retval;
+		if (retval == WQ_USERCNT_RETRY)
+			continue;
+		ASSERT_EQ(retval, (__s32)-EPERM, "usercnt_setter_ret");
+		break;
+	}
+
+	ASSERT_LT(attempt, WQ_USERCNT_MAX_ATTEMPTS, "usercnt_reuse_hit");
+destroy:
+	wq__destroy(skel);
+restore:
+	err = sched_setaffinity(0, sizeof(old_mask), &old_mask);
+	ASSERT_OK(err, "restore_affinity");
+}
 
 void serial_test_wq(void)
 {
@@ -20,7 +130,7 @@ void serial_test_wq(void)
 
 	wq_skel = wq__open_and_load();
 	if (!ASSERT_OK_PTR(wq_skel, "wq__open_and_load"))
-		return;
+		goto clean_up;
 
 	err = wq__attach(wq_skel);
 	if (!ASSERT_OK(err, "wq_attach"))
@@ -37,6 +147,9 @@ void serial_test_wq(void)
 	ASSERT_EQ(wq_skel->bss->ok_sleepable, (1 << 1), "ok_sleepable");
 clean_up:
 	wq__destroy(wq_skel);
+
+	if (test__start_subtest("usercnt_reuse"))
+		test_wq_usercnt_reuse();
 }
 
 void serial_test_failures_wq(void)
diff --git a/tools/testing/selftests/bpf/progs/wq.c b/tools/testing/selftests/bpf/progs/wq.c
index 25be2cd..9d894bb 100644
--- a/tools/testing/selftests/bpf/progs/wq.c
+++ b/tools/testing/selftests/bpf/progs/wq.c
@@ -3,6 +3,7 @@
  */
 
 #include "bpf_experimental.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
@@ -23,13 +24,22 @@ struct {
 	__type(value, struct hmap_elem);
 } hmap SEC(".maps");
 
-struct {
+struct hmap_malloc_type {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(map_flags, BPF_F_NO_PREALLOC);
 	__uint(max_entries, 1000);
 	__type(key, int);
 	__type(value, struct hmap_elem);
-} hmap_malloc SEC(".maps");
+};
+
+struct hmap_malloc_type hmap_malloc SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__array(values, struct hmap_malloc_type);
+} outer_wq SEC(".maps");
 
 struct elem {
 	int ok_offset;
@@ -138,6 +148,101 @@ static int wq_cb_sleepable(void *map, int *key, void *value)
 	return 0;
 }
 
+static __always_inline int prepare_deleted_wq(void *map,
+					      struct hmap_elem **deleted)
+{
+	struct hmap_elem empty = {}, *value;
+	int key = 0;
+
+	if (bpf_map_update_elem(map, &key, &empty, BPF_NOEXIST))
+		return 1;
+	value = bpf_map_lookup_elem(map, &key);
+	if (!value) {
+		bpf_map_delete_elem(map, &key);
+		return 2;
+	}
+	if (bpf_map_delete_elem(map, &key))
+		return 3;
+	if (bpf_wq_init(&value->work, map, 0))
+		return 4;
+	*deleted = value;
+	return 0;
+}
+
+SEC("syscall")
+__retval(-ENOENT)
+long test_deleted_wq(void *ctx)
+{
+	struct hmap_elem *value;
+	int err;
+
+	err = prepare_deleted_wq(&hmap_malloc, &value);
+	if (err)
+		return err;
+	return bpf_wq_set_callback(&value->work, wq_callback, 0);
+}
+
+SEC("syscall")
+long prepare_wq_usercnt_reuse(void *ctx)
+{
+	struct hmap_elem *value;
+	struct bpf_map *inner;
+	int idx = 0;
+
+	inner = bpf_map_lookup_elem(&outer_wq, &idx);
+	if (!inner)
+		return 5;
+	return prepare_deleted_wq(inner, &value);
+}
+
+#define WQ_USERCNT_RETRY EAGAIN
+#define WQ_USERCNT_SETUP_FAIL 1
+#define WQ_USERCNT_CLEANUP_FAIL 2
+
+/*
+ * The host runs this after closing the inner map's last user FD; the
+ * outer slot keeps the map alive with a normal reference. Use positive
+ * EAGAIN for a reuse miss. Return the setter result only after deleting
+ * the inserted element.
+ */
+SEC("syscall")
+long test_wq_usercnt_reuse(void *ctx)
+{
+	struct hmap_elem empty = {}, *value;
+	struct bpf_map *inner;
+	long init_ret, result;
+	int idx = 0, key = 0;
+
+	inner = bpf_map_lookup_elem(&outer_wq, &idx);
+	if (!inner)
+		return WQ_USERCNT_SETUP_FAIL;
+
+	if (bpf_map_update_elem(inner, &key, &empty, BPF_NOEXIST))
+		return WQ_USERCNT_SETUP_FAIL;
+
+	value = bpf_map_lookup_elem(inner, &key);
+	if (!value) {
+		result = WQ_USERCNT_SETUP_FAIL;
+		goto delete;
+	}
+
+	init_ret = bpf_wq_init(&value->work, inner, 0);
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
+	if (bpf_map_delete_elem(inner, &key))
+		return WQ_USERCNT_CLEANUP_FAIL;
+	return result;
+}
+
 SEC("tc")
 /* test that workqueues can be used from an array */
 __retval(0)
-- 
2.43.0

