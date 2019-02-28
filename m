Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C7C4360F
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500EB20842
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4kRF8eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfB1BCO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:02:14 -0500
Received: from mail-ot1-f74.google.com ([209.85.210.74]:33187 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbfB1BCO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 20:02:14 -0500
Received: by mail-ot1-f74.google.com with SMTP id e25so8916454otp.0
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 17:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/J8O+wyhgFcJAWbety9WmHCsfmX69m7poGdYkm5IflE=;
        b=q4kRF8eUccW4K+zUoslDHYwNmMQ5PcieAx+hUEXca0sGTqOc/l/9jlC+jw4gOt/Hyw
         qLHFq2GwY/leP8ekoTCHpVy43/J1AYm5FjetdxPtKBsSJetGrEqS8Xox9LoPAOd5XkP2
         mnAbbomYH0Ip2O+sW6L1k8ujPRZXeDDkmlRxc97P0swrrgNZy/dSIx4oASGiR7h7D62r
         hPMA/dMHFwWC3HsKok2S+VpUmpLCgMslkQhSNNt7ResZDRMwC0VvozsKX1YKFqBceK45
         UvbdVUDBpT/OneWqtEnMON6cQypJdg+nK/wowarDNskH3TYKC11cxISgS5Mz5Z2A4eTI
         eR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/J8O+wyhgFcJAWbety9WmHCsfmX69m7poGdYkm5IflE=;
        b=K3oFogsTR3fTi6UzJU/d8DwRCSCVruKvFpdpYTYaU3iR8TXbITZqvfk/itUQr39vQp
         5lz5ksnnvmYZ/alcDJMnHjdQc9aMffDJdmL79HrOXz/XB+oRgxZ11xnR6yFk9bpOAUTV
         EjP2bZPoxwIUWvpxwcjzScJCWFP/WUPEyv8EI2Fe5eTq3Bi9+RacR4FcX/bW/qH4PJg1
         4PpXJxjwX55DQfDiE+i7vfQt0q2vxkfd9G4YrEji1OVLp+ua4MlDsXxQ6vwZirg0le9m
         pwNC+6Kapr90td3XrDQ9Mx2dXBDKNASM7ZD9CSrZrk03i8eyW82jOoIctoy3Qn1BP4H1
         HtZw==
X-Gm-Message-State: AHQUAubitlce3GrDBrJ+3VbqbxSpU+zIrC7som2bvXNnzqTASx5jvS0K
        ja8bq3Wj+rXXCQwkNIjR/3CrHDk=
X-Google-Smtp-Source: AHgI3IZfXDw7aVcO5pJSGkra+aiglAm/9WAfiFXpBTH/HnG0XjWJOzcaothr/zgKsVs/MM/gKzdlHcc=
X-Received: by 2002:a05:6830:1205:: with SMTP id r5mr3709046otp.62.1551315732646;
 Wed, 27 Feb 2019 17:02:12 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:01:55 -0800
In-Reply-To: <20190228010156.82981-1-sdf@google.com>
Message-Id: <20190228010156.82981-6-sdf@google.com>
Mime-Version: 1.0
References: <20190228010156.82981-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next 6/7] selftests: bpf: break up test_progs - spinlock
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move spinlock prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/map_lock.c       |  75 +++++++++++++
 .../selftests/bpf/prog_tests/spinlock.c       |  29 +++++
 tools/testing/selftests/bpf/test_progs.c      | 104 +-----------------
 tools/testing/selftests/bpf/test_progs.h      |   1 +
 4 files changed, 106 insertions(+), 103 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/map_lock.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/spinlock.c

diff --git a/tools/testing/selftests/bpf/prog_tests/map_lock.c b/tools/testing/selftests/bpf/prog_tests/map_lock.c
new file mode 100644
index 000000000000..90f8a206340a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/map_lock.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static void *parallel_map_access(void *arg)
+{
+	int err, map_fd = *(u32 *) arg;
+	int vars[17], i, j, rnd, key = 0;
+
+	for (i = 0; i < 10000; i++) {
+		err = bpf_map_lookup_elem_flags(map_fd, &key, vars, BPF_F_LOCK);
+		if (err) {
+			printf("lookup failed\n");
+			error_cnt++;
+			goto out;
+		}
+		if (vars[0] != 0) {
+			printf("lookup #%d var[0]=%d\n", i, vars[0]);
+			error_cnt++;
+			goto out;
+		}
+		rnd = vars[1];
+		for (j = 2; j < 17; j++) {
+			if (vars[j] == rnd)
+				continue;
+			printf("lookup #%d var[1]=%d var[%d]=%d\n",
+			       i, rnd, j, vars[j]);
+			error_cnt++;
+			goto out;
+		}
+	}
+out:
+	pthread_exit(arg);
+}
+
+void test_map_lock(void)
+{
+	const char *file = "./test_map_lock.o";
+	int prog_fd, map_fd[2], vars[17] = {};
+	pthread_t thread_id[6];
+	struct bpf_object *obj;
+	int err = 0, key = 0, i;
+	void *ret;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+	if (err) {
+		printf("test_map_lock:bpf_prog_load errno %d\n", errno);
+		goto close_prog;
+	}
+	map_fd[0] = bpf_find_map(__func__, obj, "hash_map");
+	if (map_fd[0] < 0)
+		goto close_prog;
+	map_fd[1] = bpf_find_map(__func__, obj, "array_map");
+	if (map_fd[1] < 0)
+		goto close_prog;
+
+	bpf_map_update_elem(map_fd[0], &key, vars, BPF_F_LOCK);
+
+	for (i = 0; i < 4; i++)
+		assert(pthread_create(&thread_id[i], NULL,
+				      &spin_lock_thread, &prog_fd) == 0);
+	for (i = 4; i < 6; i++)
+		assert(pthread_create(&thread_id[i], NULL,
+				      &parallel_map_access, &map_fd[i - 4]) == 0);
+	for (i = 0; i < 4; i++)
+		assert(pthread_join(thread_id[i], &ret) == 0 &&
+		       ret == (void *)&prog_fd);
+	for (i = 4; i < 6; i++)
+		assert(pthread_join(thread_id[i], &ret) == 0 &&
+		       ret == (void *)&map_fd[i - 4]);
+	goto close_prog_noerr;
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/spinlock.c b/tools/testing/selftests/bpf/prog_tests/spinlock.c
new file mode 100644
index 000000000000..9a573a9675d7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/spinlock.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_spinlock(void)
+{
+	const char *file = "./test_spin_lock.o";
+	pthread_t thread_id[4];
+	struct bpf_object *obj;
+	int prog_fd;
+	int err = 0, i;
+	void *ret;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
+	if (err) {
+		printf("test_spin_lock:bpf_prog_load errno %d\n", errno);
+		goto close_prog;
+	}
+	for (i = 0; i < 4; i++)
+		assert(pthread_create(&thread_id[i], NULL,
+				      &spin_lock_thread, &prog_fd) == 0);
+	for (i = 0; i < 4; i++)
+		assert(pthread_join(thread_id[i], &ret) == 0 &&
+		       ret == (void *)&prog_fd);
+	goto close_prog_noerr;
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 446b6d9bb1cd..02f460ea0e60 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -828,7 +828,7 @@ static void test_flow_dissector(void)
 	bpf_object__close(obj);
 }
 
-static void *test_spin_lock(void *arg)
+void *spin_lock_thread(void *arg)
 {
 	__u32 duration, retval;
 	int err, prog_fd = *(u32 *) arg;
@@ -841,106 +841,6 @@ static void *test_spin_lock(void *arg)
 	pthread_exit(arg);
 }
 
-static void test_spinlock(void)
-{
-	const char *file = "./test_spin_lock.o";
-	pthread_t thread_id[4];
-	struct bpf_object *obj;
-	int prog_fd;
-	int err = 0, i;
-	void *ret;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
-	if (err) {
-		printf("test_spin_lock:bpf_prog_load errno %d\n", errno);
-		goto close_prog;
-	}
-	for (i = 0; i < 4; i++)
-		assert(pthread_create(&thread_id[i], NULL,
-				      &test_spin_lock, &prog_fd) == 0);
-	for (i = 0; i < 4; i++)
-		assert(pthread_join(thread_id[i], &ret) == 0 &&
-		       ret == (void *)&prog_fd);
-	goto close_prog_noerr;
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
-static void *parallel_map_access(void *arg)
-{
-	int err, map_fd = *(u32 *) arg;
-	int vars[17], i, j, rnd, key = 0;
-
-	for (i = 0; i < 10000; i++) {
-		err = bpf_map_lookup_elem_flags(map_fd, &key, vars, BPF_F_LOCK);
-		if (err) {
-			printf("lookup failed\n");
-			error_cnt++;
-			goto out;
-		}
-		if (vars[0] != 0) {
-			printf("lookup #%d var[0]=%d\n", i, vars[0]);
-			error_cnt++;
-			goto out;
-		}
-		rnd = vars[1];
-		for (j = 2; j < 17; j++) {
-			if (vars[j] == rnd)
-				continue;
-			printf("lookup #%d var[1]=%d var[%d]=%d\n",
-			       i, rnd, j, vars[j]);
-			error_cnt++;
-			goto out;
-		}
-	}
-out:
-	pthread_exit(arg);
-}
-
-static void test_map_lock(void)
-{
-	const char *file = "./test_map_lock.o";
-	int prog_fd, map_fd[2], vars[17] = {};
-	pthread_t thread_id[6];
-	struct bpf_object *obj;
-	int err = 0, key = 0, i;
-	void *ret;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_CGROUP_SKB, &obj, &prog_fd);
-	if (err) {
-		printf("test_map_lock:bpf_prog_load errno %d\n", errno);
-		goto close_prog;
-	}
-	map_fd[0] = bpf_find_map(__func__, obj, "hash_map");
-	if (map_fd[0] < 0)
-		goto close_prog;
-	map_fd[1] = bpf_find_map(__func__, obj, "array_map");
-	if (map_fd[1] < 0)
-		goto close_prog;
-
-	bpf_map_update_elem(map_fd[0], &key, vars, BPF_F_LOCK);
-
-	for (i = 0; i < 4; i++)
-		assert(pthread_create(&thread_id[i], NULL,
-				      &test_spin_lock, &prog_fd) == 0);
-	for (i = 4; i < 6; i++)
-		assert(pthread_create(&thread_id[i], NULL,
-				      &parallel_map_access, &map_fd[i - 4]) == 0);
-	for (i = 0; i < 4; i++)
-		assert(pthread_join(thread_id[i], &ret) == 0 &&
-		       ret == (void *)&prog_fd);
-	for (i = 4; i < 6; i++)
-		assert(pthread_join(thread_id[i], &ret) == 0 &&
-		       ret == (void *)&map_fd[i - 4]);
-	goto close_prog_noerr;
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
 static void sigalrm_handler(int s) {}
 static struct sigaction sigalrm_action = {
 	.sa_handler = sigalrm_handler,
@@ -1003,8 +903,6 @@ int main(void)
 	test_queue_stack_map(QUEUE);
 	test_queue_stack_map(STACK);
 	test_flow_dissector();
-	test_spinlock();
-	test_map_lock();
 	test_signal_pending(BPF_PROG_TYPE_SOCKET_FILTER);
 	test_signal_pending(BPF_PROG_TYPE_FLOW_DISSECTOR);
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 21e74d1c53c0..4cc473d9a69b 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -86,3 +86,4 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
+void *spin_lock_thread(void *arg);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

