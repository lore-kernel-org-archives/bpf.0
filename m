Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCFDC00319
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0F2083E
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDl63utD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfCBDmk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:40 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:39583 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfCBDmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:39 -0500
Received: by mail-yw1-f73.google.com with SMTP id f82so16827076ywb.6
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=30sJoz76QL/OhJxOPH7zRJrnxPOMnYLdN9UeMk4c+7Q=;
        b=tDl63utDesoRRsZqMxK9TyyuB5bJclQM8qdrCRAllRJQm3uR3XaoHfOse98FNhnZn9
         VnPxD/d0Fi0MViGnI8wqEulHk40ru68DceYBUA/bYsZWvcm3BOrSg3jb+rQOHVcO4bxL
         ubPqybO+ArU4rHtdOUeRQWVSfWbRJ3lY2vSPOVzhBP00GvmDS1qJRq3jKdwIcj3dEzXA
         gM0Vr1KKV4jjMW8A5JHjqIAHmdXKIDkqM8tob9uK/3MjAhg1FE2Qtm6z+i8/jFW3W6i6
         KEQKDrQ2GmeGpl90unf5vGQq5Wuqb1U8kuPlPo8GyUYRMz1tyDSAYJyL40jF+R2oltV5
         aEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=30sJoz76QL/OhJxOPH7zRJrnxPOMnYLdN9UeMk4c+7Q=;
        b=dnfOjUxS/xCtApV8vJobHXlvCxUTN3rVPDgKMF95Au69YENaBVUlC1qVJzNE5KGl3R
         4VK/FlbKb/XPynb808uKjng+J13AjO+gYL3pn3iZPZIXis40oEWm8aIRBcdmxq0g1LIN
         /NdUCGG0gykudcclx3xXi4zBXXaM1jYZ2A4A3Qa//cVeBTr3y4Sx5bGuh1VN0EvDlV8e
         iRjVbCwlaCzgooi5lyBQiDhdGRhtFJjjT9ip2FaLSgMquX+meKVpdbH2mk+yPphA6Dzn
         sSnj3pBpadxMxZ5ZWculyNJbfiwzPOlhuJ0IzC/dDKKhC67xDeyqdZ5BvvJSL6MBroW8
         W5Ug==
X-Gm-Message-State: APjAAAW87zkwIp7cFGf83IMWYA/KISyjgqEvNiSKXXLjyFojxfb4Hhm+
        vNeVTB9wq14IccaNBM+6nN8hYTM=
X-Google-Smtp-Source: APXvYqxW12DOsT+a6PeYGkwSSosdFCHXPbbWbqk2vmNBePoNHZ9Ev8c3IMKf+mH5Ub8no8muaYuONXw=
X-Received: by 2002:a25:9b82:: with SMTP id v2mr3977541ybo.58.1551498158253;
 Fri, 01 Mar 2019 19:42:38 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:18 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-7-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 6/7] selftests: bpf: break up test_progs - spinlock
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
index 6e41dfab1e75..e97b5b0eaf27 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -829,7 +829,7 @@ static void test_flow_dissector(void)
 	bpf_object__close(obj);
 }
 
-static void *test_spin_lock(void *arg)
+void *spin_lock_thread(void *arg)
 {
 	__u32 duration, retval;
 	int err, prog_fd = *(u32 *) arg;
@@ -842,106 +842,6 @@ static void *test_spin_lock(void *arg)
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
@@ -1004,8 +904,6 @@ int main(void)
 	test_queue_stack_map(QUEUE);
 	test_queue_stack_map(STACK);
 	test_flow_dissector();
-	test_spinlock();
-	test_map_lock();
 	test_signal_pending(BPF_PROG_TYPE_SOCKET_FILTER);
 	test_signal_pending(BPF_PROG_TYPE_FLOW_DISSECTOR);
 
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 148b5494ed08..66309327b4f8 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -85,3 +85,4 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
 int extract_build_id(char *build_id, size_t size);
+void *spin_lock_thread(void *arg);
-- 
2.21.0.352.gf09ad66450-goog

