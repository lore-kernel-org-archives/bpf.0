Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FAF311C38
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053735; cv=none; b=C2AtG77D5uyl/MDKbqp/rUMadhhBg+jHZkHg9uxJMny4ZtVK7EJJLHt7sEWNbaEgBDygI0XNUl71JI10pkQ9oNmlXLDPxkc+iqNDcwVD0hbZPImjCoFTblMyb2qasHPc/KYQWkPMpXDssgZjW43s4YGipsC/3jL4xlT8UUoEIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053735; c=relaxed/simple;
	bh=FYzWglH3Sum+8390Wy0gRg8Q06ZKbw+gn0wI9rmzZg4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d1VBA4xEiCOqKSvGfr7b0Opk4UEc9IpBl1wbRz/2/2VSuocaD4tp8PlAYt2TNbO7hB6l5V+PLk3DunCJPtKNLgYG6DvxyjMqk2OuVwaV707unWAqkT71hOx24x45uwRMhLQRY/Qh8lALkEtXm4WR1AH/f/nUAqxMzZ/diGKdLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LVpA5EQv; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVpA5EQv"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso128803eec.0
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 13:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053731; x=1772658531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dMHmqKHxrwFZmYF6YxbRzL2nzys8T1WazGuJ7IEz3lg=;
        b=LVpA5EQvynFGG+17oobkMnplj0zSgT8jdHVeK5UAkGmYUu09Ni0a3/F6W5svIFl8Xh
         I5e4tkgZimHErh7SIH8Y6dhGXrUo2VJWuR4Q6GMitDO/hF8l/0gKnabuDPj27JtxeYI1
         r5r46DvKbKGG17sO2fZX1HwYmxVqnvtAIMRcLzDS7VbALHhOCxUm2aDbt2SnBJanNCJN
         pJKaD08Pn4ihm6o/eNktluwKtLyQpshmZYl7gkRbAQaqWv1eoLbbpZ1ZoeGdhgGojhh+
         p/eoUzozVuWrGblPRlPzu3yX277dEz5FibEm0Ee5pZtKSxVsGVRu5161L64Qtf48T1sR
         4mrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053731; x=1772658531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dMHmqKHxrwFZmYF6YxbRzL2nzys8T1WazGuJ7IEz3lg=;
        b=K0FJfQ+GpARUvN+L2qL2xHUOAYUlcQGm0BE0jeGvH9EPJ9Ub3FH0QUmP27n+Id1mJH
         cQNMIvNzs4U7tRxGdvjWSBbrHaGApbz64hpsfenzyKKgP+PzOVUVzgdODrecgwVrSIFu
         eFjVzOu5Xh9pWtDUtuk+tOYfUjMw/xetaF5KIRueLW+wxli4bE/a9n04U+/ggvc9xk/V
         yyxalTwYih8MzI/mLIZbU5eGfB9qlKEadatxHF0JFhiA/8992zeLZFqS2E80v63hj3ov
         vyEPFVsB2s286Wt3wiso9g4CVWQJWBpWYfotopiE1fe4oUVZVt+5xBDYWVdry8Ced2Eg
         jKww==
X-Forwarded-Encrypted: i=1; AJvYcCVNqDWWWKucBnknaLRRsIBVmYyr5NPgS+DSrSWCFGooRWbtNhK97X7JbeK1VABiVE0Yn9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqu20QZiis+H+SEiqkx6TTgAHgXB2BPNZPFMW/3pYp7l5Bee89
	uDs/+TjRmHGxxGcB3tZ1D4crflhaW8YNbCWxGMPi3zpiFfPLJBEnhBbWq7jkSwfKeAUwj7iiF33
	qbnNGilA0ocsEsw==
X-Received: from dyaa9.prod.google.com ([2002:a05:693c:40c9:b0:2ba:9c5e:b1a2])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:4586:b0:2b0:5306:1770 with SMTP id 5a478bee46e88-2bd7bd24250mr8264899eec.22.1772053731102;
 Wed, 25 Feb 2026 13:08:51 -0800 (PST)
Date: Wed, 25 Feb 2026 13:08:18 -0800
In-Reply-To: <20260225210820.177674-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210820.177674-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260225210820.177674-3-wusamuel@google.com>
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sets up the framework to test wakeup_sources iterators using BPF, and
adds a few basic tests.

Adds several helper functions that for grabbing and releasing a
wakelock, abstracting out key functions to setup a framework for testing
wakeup_sources.

Additionally, adds 3 tests:
1. check_active_count: Checks that stats related to active_count are
   properly set after several lock/unlock cycles
2. check_sleep_times: Checks that time accounting related to sleep are
   properly calculated
3. check_no_infinite_reads: Checks that the iterator traversal returns
   NULL at the end

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/wakeup_source_iter.c       | 300 ++++++++++++++++++
 .../selftests/bpf/progs/wakeup_source_iter.c  |  80 +++++
 3 files changed, 381 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/wakeup_source_iter.c

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 24855381290d..75e8542ef111 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -111,6 +111,7 @@ CONFIG_IP6_NF_IPTABLES=y
 CONFIG_IP6_NF_FILTER=y
 CONFIG_NF_NAT=y
 CONFIG_PACKET=y
+CONFIG_PM_WAKELOCKS=y
 CONFIG_RC_CORE=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_LIVEPATCH=m
diff --git a/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
new file mode 100644
index 000000000000..40e47157a6a0
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/wakeup_source_iter.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include "wakeup_source_iter.skel.h"
+
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+
+/* Sleep for 10ms to ensure active time is > 0 after converting ns to ms*/
+#define TEST_SLEEP_US 10000
+#define TEST_SLEEP_MS (TEST_SLEEP_US / 1000)
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+static const char test_ws_name[] = "bpf_selftest_ws";
+static bool test_ws_created;
+
+/*
+ * Creates a new wakeup source by writing to /sys/power/wake_lock.
+ * This lock persists until explicitly unlocked.
+ */
+static int lock_ws(const char *name)
+{
+	int fd;
+	ssize_t bytes;
+
+	fd = open("/sys/power/wake_lock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_lock"))
+		return -1;
+
+	bytes = write(fd, name, strlen(name));
+	close(fd);
+	if (!ASSERT_EQ(bytes, strlen(name), "write to wake_lock"))
+		return -1;
+
+	return 0;
+}
+
+/*
+ * Destroys the ws by writing the same name to /sys/power/wake_unlock.
+ */
+static void unlock_ws(const char *name)
+{
+	int fd;
+
+	fd = open("/sys/power/wake_unlock", O_WRONLY);
+	if (!ASSERT_OK_FD(fd, "open /sys/power/wake_unlock"))
+		goto cleanup;
+
+	write(fd, name, strlen(name));
+
+cleanup:
+	if (fd)
+		close(fd);
+}
+
+/*
+ * Setups for testing ws iterators. Will run once prior to suite of tests.
+ */
+static int setup_test_ws(void)
+{
+	if (lock_ws(test_ws_name))
+		return -1;
+	test_ws_created = true;
+
+	return 0;
+}
+
+/*
+ * Tears down and cleanups testing ws iterators. WIll run once after the suite
+ * of tests.
+ */
+static void teardown_test_ws(void)
+{
+	if (!test_ws_created)
+		return;
+	unlock_ws(test_ws_name);
+	test_ws_created = false;
+}
+
+struct WakeupSourceInfo {
+	char name[WAKEUP_SOURCE_NAME_LEN];
+	unsigned long active_count;
+	long active_time_ms;
+	unsigned long event_count;
+	unsigned long expire_count;
+	long last_change_ms;
+	long max_time_ms;
+	long prevent_sleep_time_ms;
+	long total_time_ms;
+	unsigned long wakeup_count;
+};
+
+/*
+ * Reads and parses one wakeup_source record from the iterator file.
+ * A record is a single space-delimited line.
+ * Returns true on success, false on EOF. Asserts internally on errors.
+ */
+static bool read_ws_info(FILE *iter_file, struct WakeupSourceInfo *ws_info,
+			 char **line)
+{
+	size_t linesize;
+	int items;
+
+	if (getline(line, &linesize, iter_file) == -1)
+		return false;
+
+	(*line)[strcspn(*line, "\n")] = 0;
+
+	items = sscanf(*line, "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu",
+		       ws_info->name, &ws_info->active_count,
+		       &ws_info->active_time_ms, &ws_info->event_count,
+		       &ws_info->expire_count, &ws_info->last_change_ms,
+		       &ws_info->max_time_ms, &ws_info->prevent_sleep_time_ms,
+		       &ws_info->total_time_ms, &ws_info->wakeup_count);
+
+	if (!ASSERT_EQ(items, 10, "read wakeup source info"))
+		return false;
+
+	if (!ASSERT_LT(strlen(ws_info->name), WAKEUP_SOURCE_NAME_LEN,
+		       "name length"))
+		return false;
+
+	return true;
+}
+
+static int get_ws_iter_stream(struct wakeup_source_iter *skel, int *iter_fd,
+			      FILE **iter_file)
+{
+	*iter_fd = bpf_iter_create(
+			bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(*iter_fd, "iter_create"))
+		return -1;
+
+	*iter_file = fdopen(*iter_fd, "r");
+	if (!ASSERT_OK_PTR(*iter_file, "fdopen"))
+		return -1;
+
+	return 0;
+}
+
+static void subtest_ws_iter_check_active_count(struct wakeup_source_iter *skel)
+{
+	static const char subtest_ws_name[] = "bpf_selftest_ws_active_count";
+	const int lock_unlock_cycles = 5;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	bool found_ws = false;
+	FILE *iter_file = NULL;
+	int iter_fd = -1;
+	int i;
+
+	for (i = 0; i < lock_unlock_cycles; i++) {
+		if (!ASSERT_OK(lock_ws(subtest_ws_name), "lock_ws"))
+			goto cleanup;
+		unlock_ws(subtest_ws_name);
+	}
+
+	if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, subtest_ws_name) == 0) {
+			found_ws = true;
+			ASSERT_EQ(ws_info.active_count, lock_unlock_cycles,
+				  "active_count check");
+			ASSERT_EQ(ws_info.event_count, lock_unlock_cycles,
+				  "event_count check");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_ws, "found active_count test ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_sleep_times(struct wakeup_source_iter *skel)
+{
+	bool found_test_ws = false;
+	struct WakeupSourceInfo ws_info;
+	char *line = NULL;
+	FILE *iter_file = NULL;
+	int iter_fd = -1;
+
+	if (get_ws_iter_stream(skel, &iter_fd, &iter_file))
+		goto cleanup;
+
+	while (read_ws_info(iter_file, &ws_info, &line)) {
+		if (strcmp(ws_info.name, test_ws_name) == 0) {
+			found_test_ws = true;
+			ASSERT_GT(ws_info.last_change_ms, 0,
+				  "Expected non-zero last change");
+			ASSERT_GE(ws_info.active_time_ms, TEST_SLEEP_MS,
+				  "Expected active time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.max_time_ms, TEST_SLEEP_MS,
+				  "Expected max time >= TEST_SLEEP_MS");
+			ASSERT_GE(ws_info.total_time_ms, TEST_SLEEP_MS,
+				  "Expected total time >= TEST_SLEEP_MS");
+			break;
+		}
+	}
+
+	ASSERT_TRUE(found_test_ws, "found_test_ws");
+
+	free(line);
+cleanup:
+	if (iter_file)
+		fclose(iter_file);
+	else if (iter_fd >= 0)
+		close(iter_fd);
+}
+
+static void subtest_ws_iter_check_no_infinite_reads(
+		struct wakeup_source_iter *skel)
+{
+	int iter_fd;
+	char buf[256];
+
+	iter_fd = bpf_iter_create(bpf_link__fd(skel->links.wakeup_source_collector));
+	if (!ASSERT_OK_FD(iter_fd, "iter_create"))
+		return;
+
+	while (read(iter_fd, buf, sizeof(buf)) > 0)
+		;
+
+	/* Final read should return 0 */
+	ASSERT_EQ(read(iter_fd, buf, sizeof(buf)), 0, "read");
+
+	close(iter_fd);
+}
+
+void test_wakeup_source_iter(void)
+{
+	struct wakeup_source_iter *skel = NULL;
+	struct btf *vmlinux_btf;
+	int btf_id;
+
+	if (geteuid() != 0) {
+		fprintf(stderr,
+			"Skipping wakeup_source_iter test, requires root\n");
+		test__skip();
+		return;
+	}
+
+	skel = wakeup_source_iter__open();
+	if (!ASSERT_OK_PTR(skel, "wakeup_source_iter__open"))
+		return;
+
+	vmlinux_btf = btf__load_vmlinux_btf();
+	if (!vmlinux_btf)
+		return;
+
+	btf_id = btf__find_by_name_kind(vmlinux_btf, "bpf_iter__wakeup_source", BTF_KIND_STRUCT);
+	btf__free(vmlinux_btf);
+
+	if (btf_id <= 0) {
+		test__skip();
+		goto destroy;
+	}
+
+	if (!ASSERT_OK(wakeup_source_iter__load(skel), "iter__load"))
+		goto destroy;
+
+	if (!ASSERT_OK(setup_test_ws(), "setup_test_ws"))
+		goto teardown;
+
+	if (!ASSERT_OK(wakeup_source_iter__attach(skel), "skel_attach"))
+		goto teardown;
+
+	/*
+	 * Sleep on O(ms) to ensure that time stats' resolution isn't lost when
+	 * converting from ns to ms
+	 */
+	usleep(TEST_SLEEP_US);
+
+	if (test__start_subtest("active_count"))
+		subtest_ws_iter_check_active_count(skel);
+	if (test__start_subtest("sleep_times"))
+		subtest_ws_iter_check_sleep_times(skel);
+	if (test__start_subtest("no_infinite_reads"))
+		subtest_ws_iter_check_no_infinite_reads(skel);
+
+teardown:
+	teardown_test_ws();
+destroy:
+	wakeup_source_iter__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/wakeup_source_iter.c b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
new file mode 100644
index 000000000000..d770efc3bd0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/wakeup_source_iter.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+
+#define NSEC_PER_MS 1000000UL
+#define WAKEUP_SOURCE_NAME_LEN 32
+
+char _license[] SEC("license") = "GPL";
+
+struct wakeup_source___local {
+	const char *name;
+	unsigned long active_count;
+	unsigned long event_count;
+	unsigned long wakeup_count;
+	unsigned long expire_count;
+	ktime_t last_time;
+	ktime_t max_time;
+	ktime_t total_time;
+	ktime_t start_prevent_time;
+	ktime_t prevent_sleep_time;
+	bool active:1;
+	bool autosleep_enabled:1;
+} __attribute__((preserve_access_index));
+
+struct bpf_iter__wakeup_source___local {
+	struct bpf_iter_meta *meta;
+	struct wakeup_source___local *wakeup_source;
+} __attribute__((preserve_access_index));
+
+SEC("iter/wakeup_source")
+int wakeup_source_collector(struct bpf_iter__wakeup_source___local *ctx)
+{
+	const struct wakeup_source___local *ws = ctx->wakeup_source;
+	struct seq_file *seq = ctx->meta->seq;
+	char name[WAKEUP_SOURCE_NAME_LEN] = {'\0'};
+	const char *pname;
+	bool active, autosleep_enable;
+	s64 active_time, curr_time, max_time, prevent_sleep_time, total_time;
+
+	if (!ws)
+		return 0;
+
+	active = BPF_CORE_READ_BITFIELD_PROBED(ws, active);
+	autosleep_enable = BPF_CORE_READ_BITFIELD_PROBED(ws, autosleep_enabled);
+	if (bpf_core_read(&pname, sizeof(pname), &ws->name) ||
+	    bpf_probe_read_kernel_str(name, sizeof(name), pname) < 0)
+		return 0;
+
+	active_time = 0;
+	curr_time = bpf_ktime_get_ns();
+	max_time = ws->max_time;
+	prevent_sleep_time = ws->prevent_sleep_time;
+	total_time = ws->total_time;
+
+	if (active) {
+		active_time = curr_time - ws->last_time;
+		total_time += active_time;
+		if (active_time > max_time)
+			max_time = active_time;
+		if (autosleep_enable)
+			prevent_sleep_time +=
+				curr_time - ws->start_prevent_time;
+	}
+
+	BPF_SEQ_PRINTF(seq,
+		       "%s %lu %ld %lu %lu %ld %ld %ld %ld %lu\n",
+		       name,
+		       ws->active_count,
+		       active_time / NSEC_PER_MS,
+		       ws->event_count,
+		       ws->expire_count,
+		       ws->last_time / NSEC_PER_MS,
+		       max_time / NSEC_PER_MS,
+		       prevent_sleep_time / NSEC_PER_MS,
+		       total_time / NSEC_PER_MS,
+		       ws->wakeup_count);
+	return 0;
+}
-- 
2.53.0.473.g4a7958ca14-goog

