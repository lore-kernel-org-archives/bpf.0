Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2923C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8562083E
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j14gnfaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfCBDmi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:38 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:47051 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfCBDmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:37 -0500
Received: by mail-qk1-f202.google.com with SMTP id u13so19537011qkj.13
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ixOdPlBjvOaVplJWhIVkjTNv1rASbGHInc+Aax1BJvs=;
        b=j14gnfaX0/ghguTpOpDcxDqFAKMm9MU/Zw6XCIU6qgG2kqURHUcsUPtIcIxvU2G8N3
         EHEOkgOsC6Nxesyy4hhD21IqDAkHWCJk6u41hT19wQxOawxQf6jptqtSu2REyO/d2xiu
         ZgHh3P7TWzJ2ajTCr+Qq72mYst7lHlxOanUzL+iQI9JaTQohj+DdLSUDRCF/a3pL9NXI
         INSKP4d3YioKY/IUD4ZomXqX4i+/qqDC3pgotdw9VHUrCi69+abHom9nMZwFgy7NBopF
         A3QeIXUHv9E9D9KZ6JGb/Rar0nMVz8ypaZuzgLcQm9vK/CrMGwBlByumy1ZbXNxdq8kd
         S9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ixOdPlBjvOaVplJWhIVkjTNv1rASbGHInc+Aax1BJvs=;
        b=MnHa2INwgMIVsVeax6vn4KKOaUjk8N5+r65Le5KXivsN4bfRIXcUklEFqLciLt7NZD
         vwW1KMc0gEBSWvBMKLugOl9jAsYb6/0tNzwiCYYCN7aKsunh71nHr/oCuZajUObzSKrW
         yH2lAi5cG0ETtVCmjcd2dMEtwg0mmZnmWiyLYDyZpAMOThp/fqyOMVRf0dKWUP97Rmpr
         PJq0GEbTAigb4STvE6VQn8uqv5UhJkAmBG1dl3qCNADRAJeV8UfwE4NOKfGKON1biNlP
         Hs1tP4q6wj6dHJ+ZdmjF7DGUIpMJjX0HH95FRoS6e+2tTzs5SIBinfcByQzBwTEH8JFy
         WFJg==
X-Gm-Message-State: APjAAAUNXJFNIC0UBgvtyITMmk1TLCqZ9YfjpzMi69mEfDPNKzqWZq3t
        78w8Nsk6j2yefzscu56paK2tH78=
X-Google-Smtp-Source: APXvYqxmbNA4uKWZxzY53HF2m8n++Rp1vDqS6E+QHVQm46B6oBAyW6DxloRwqeG082v4Z/9hQUrxF6U=
X-Received: by 2002:a37:9a4c:: with SMTP id c73mr4771217qke.50.1551498155615;
 Fri, 01 Mar 2019 19:42:35 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:17 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-6-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 5/7] selftests: bpf: break up test_progs - tracepoint
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move tracepoint prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/get_stack_raw_tp.c         | 139 ++++++
 .../bpf/prog_tests/task_fd_query_rawtp.c      |  78 ++++
 .../bpf/prog_tests/task_fd_query_tp.c         |  82 ++++
 .../bpf/prog_tests/tp_attach_query.c          | 132 ++++++
 tools/testing/selftests/bpf/test_progs.c      | 427 ------------------
 5 files changed, 431 insertions(+), 427 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tp_attach_query.c

diff --git a/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
new file mode 100644
index 000000000000..d7bb5beb1c57
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/get_stack_raw_tp.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#define MAX_CNT_RAWTP	10ull
+#define MAX_STACK_RAWTP	100
+struct get_stack_trace_t {
+	int pid;
+	int kern_stack_size;
+	int user_stack_size;
+	int user_stack_buildid_size;
+	__u64 kern_stack[MAX_STACK_RAWTP];
+	__u64 user_stack[MAX_STACK_RAWTP];
+	struct bpf_stack_build_id user_stack_buildid[MAX_STACK_RAWTP];
+};
+
+static int get_stack_print_output(void *data, int size)
+{
+	bool good_kern_stack = false, good_user_stack = false;
+	const char *nonjit_func = "___bpf_prog_run";
+	struct get_stack_trace_t *e = data;
+	int i, num_stack;
+	static __u64 cnt;
+	struct ksym *ks;
+
+	cnt++;
+
+	if (size < sizeof(struct get_stack_trace_t)) {
+		__u64 *raw_data = data;
+		bool found = false;
+
+		num_stack = size / sizeof(__u64);
+		/* If jit is enabled, we do not have a good way to
+		 * verify the sanity of the kernel stack. So we
+		 * just assume it is good if the stack is not empty.
+		 * This could be improved in the future.
+		 */
+		if (jit_enabled) {
+			found = num_stack > 0;
+		} else {
+			for (i = 0; i < num_stack; i++) {
+				ks = ksym_search(raw_data[i]);
+				if (strcmp(ks->name, nonjit_func) == 0) {
+					found = true;
+					break;
+				}
+			}
+		}
+		if (found) {
+			good_kern_stack = true;
+			good_user_stack = true;
+		}
+	} else {
+		num_stack = e->kern_stack_size / sizeof(__u64);
+		if (jit_enabled) {
+			good_kern_stack = num_stack > 0;
+		} else {
+			for (i = 0; i < num_stack; i++) {
+				ks = ksym_search(e->kern_stack[i]);
+				if (strcmp(ks->name, nonjit_func) == 0) {
+					good_kern_stack = true;
+					break;
+				}
+			}
+		}
+		if (e->user_stack_size > 0 && e->user_stack_buildid_size > 0)
+			good_user_stack = true;
+	}
+	if (!good_kern_stack || !good_user_stack)
+		return LIBBPF_PERF_EVENT_ERROR;
+
+	if (cnt == MAX_CNT_RAWTP)
+		return LIBBPF_PERF_EVENT_DONE;
+
+	return LIBBPF_PERF_EVENT_CONT;
+}
+
+void test_get_stack_raw_tp(void)
+{
+	const char *file = "./test_get_stack_rawtp.o";
+	int i, efd, err, prog_fd, pmu_fd, perfmap_fd;
+	struct perf_event_attr attr = {};
+	struct timespec tv = {0, 10};
+	__u32 key = 0, duration = 0;
+	struct bpf_object *obj;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
+		return;
+
+	efd = bpf_raw_tracepoint_open("sys_enter", prog_fd);
+	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+
+	perfmap_fd = bpf_find_map(__func__, obj, "perfmap");
+	if (CHECK(perfmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
+		  perfmap_fd, errno))
+		goto close_prog;
+
+	err = load_kallsyms();
+	if (CHECK(err < 0, "load_kallsyms", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	attr.sample_type = PERF_SAMPLE_RAW;
+	attr.type = PERF_TYPE_SOFTWARE;
+	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
+	pmu_fd = syscall(__NR_perf_event_open, &attr, getpid()/*pid*/, -1/*cpu*/,
+			 -1/*group_fd*/, 0);
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n", pmu_fd,
+		  errno))
+		goto close_prog;
+
+	err = bpf_map_update_elem(perfmap_fd, &key, &pmu_fd, BPF_ANY);
+	if (CHECK(err < 0, "bpf_map_update_elem", "err %d errno %d\n", err,
+		  errno))
+		goto close_prog;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (CHECK(err < 0, "ioctl PERF_EVENT_IOC_ENABLE", "err %d errno %d\n",
+		  err, errno))
+		goto close_prog;
+
+	err = perf_event_mmap(pmu_fd);
+	if (CHECK(err < 0, "perf_event_mmap", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	/* trigger some syscall action */
+	for (i = 0; i < MAX_CNT_RAWTP; i++)
+		nanosleep(&tv, NULL);
+
+	err = perf_event_poller(pmu_fd, get_stack_print_output);
+	if (CHECK(err < 0, "perf_event_poller", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	goto close_prog_noerr;
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
new file mode 100644
index 000000000000..958a3d88de99
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_rawtp.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_task_fd_query_rawtp(void)
+{
+	const char *file = "./test_get_stack_rawtp.o";
+	__u64 probe_offset, probe_addr;
+	__u32 len, prog_id, fd_type;
+	struct bpf_object *obj;
+	int efd, err, prog_fd;
+	__u32 duration = 0;
+	char buf[256];
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
+		return;
+
+	efd = bpf_raw_tracepoint_open("sys_enter", prog_fd);
+	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+
+	/* query (getpid(), efd) */
+	len = sizeof(buf);
+	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
+				&fd_type, &probe_offset, &probe_addr);
+	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
+		  errno))
+		goto close_prog;
+
+	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
+	      strcmp(buf, "sys_enter") == 0;
+	if (CHECK(!err, "check_results", "fd_type %d tp_name %s\n",
+		  fd_type, buf))
+		goto close_prog;
+
+	/* test zero len */
+	len = 0;
+	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
+				&fd_type, &probe_offset, &probe_addr);
+	if (CHECK(err < 0, "bpf_task_fd_query (len = 0)", "err %d errno %d\n",
+		  err, errno))
+		goto close_prog;
+	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
+	      len == strlen("sys_enter");
+	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
+		goto close_prog;
+
+	/* test empty buffer */
+	len = sizeof(buf);
+	err = bpf_task_fd_query(getpid(), efd, 0, 0, &len, &prog_id,
+				&fd_type, &probe_offset, &probe_addr);
+	if (CHECK(err < 0, "bpf_task_fd_query (buf = 0)", "err %d errno %d\n",
+		  err, errno))
+		goto close_prog;
+	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
+	      len == strlen("sys_enter");
+	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
+		goto close_prog;
+
+	/* test smaller buffer */
+	len = 3;
+	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
+				&fd_type, &probe_offset, &probe_addr);
+	if (CHECK(err >= 0 || errno != ENOSPC, "bpf_task_fd_query (len = 3)",
+		  "err %d errno %d\n", err, errno))
+		goto close_prog;
+	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
+	      len == strlen("sys_enter") &&
+	      strcmp(buf, "sy") == 0;
+	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
+		goto close_prog;
+
+	goto close_prog_noerr;
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
new file mode 100644
index 000000000000..d636a4f39476
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/task_fd_query_tp.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static void test_task_fd_query_tp_core(const char *probe_name,
+				       const char *tp_name)
+{
+	const char *file = "./test_tracepoint.o";
+	int err, bytes, efd, prog_fd, pmu_fd;
+	struct perf_event_attr attr = {};
+	__u64 probe_offset, probe_addr;
+	__u32 len, prog_id, fd_type;
+	struct bpf_object *obj;
+	__u32 duration = 0;
+	char buf[256];
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "bpf_prog_load", "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	snprintf(buf, sizeof(buf),
+		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
+	efd = open(buf, O_RDONLY, 0);
+	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+	bytes = read(efd, buf, sizeof(buf));
+	close(efd);
+	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "read",
+		  "bytes %d errno %d\n", bytes, errno))
+		goto close_prog;
+
+	attr.config = strtol(buf, NULL, 0);
+	attr.type = PERF_TYPE_TRACEPOINT;
+	attr.sample_type = PERF_SAMPLE_RAW;
+	attr.sample_period = 1;
+	attr.wakeup_events = 1;
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (CHECK(err, "perf_event_open", "err %d errno %d\n", err, errno))
+		goto close_pmu;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n", err,
+		  errno))
+		goto close_pmu;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
+	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n", err,
+		  errno))
+		goto close_pmu;
+
+	/* query (getpid(), pmu_fd) */
+	len = sizeof(buf);
+	err = bpf_task_fd_query(getpid(), pmu_fd, 0, buf, &len, &prog_id,
+				&fd_type, &probe_offset, &probe_addr);
+	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
+		  errno))
+		goto close_pmu;
+
+	err = (fd_type == BPF_FD_TYPE_TRACEPOINT) && !strcmp(buf, tp_name);
+	if (CHECK(!err, "check_results", "fd_type %d tp_name %s\n",
+		  fd_type, buf))
+		goto close_pmu;
+
+	close(pmu_fd);
+	goto close_prog_noerr;
+
+close_pmu:
+	close(pmu_fd);
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
+
+void test_task_fd_query_tp(void)
+{
+	test_task_fd_query_tp_core("sched/sched_switch",
+				   "sched_switch");
+	test_task_fd_query_tp_core("syscalls/sys_enter_read",
+				   "sys_enter_read");
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
new file mode 100644
index 000000000000..a2f476f91637
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tp_attach_query.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_tp_attach_query(void)
+{
+	const int num_progs = 3;
+	int i, j, bytes, efd, err, prog_fd[num_progs], pmu_fd[num_progs];
+	__u32 duration = 0, info_len, saved_prog_ids[num_progs];
+	const char *file = "./test_tracepoint.o";
+	struct perf_event_query_bpf *query;
+	struct perf_event_attr attr = {};
+	struct bpf_object *obj[num_progs];
+	struct bpf_prog_info prog_info;
+	char buf[256];
+
+	snprintf(buf, sizeof(buf),
+		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
+	efd = open(buf, O_RDONLY, 0);
+	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+		return;
+	bytes = read(efd, buf, sizeof(buf));
+	close(efd);
+	if (CHECK(bytes <= 0 || bytes >= sizeof(buf),
+		  "read", "bytes %d errno %d\n", bytes, errno))
+		return;
+
+	attr.config = strtol(buf, NULL, 0);
+	attr.type = PERF_TYPE_TRACEPOINT;
+	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
+	attr.sample_period = 1;
+	attr.wakeup_events = 1;
+
+	query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
+	for (i = 0; i < num_progs; i++) {
+		err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
+				    &prog_fd[i]);
+		if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
+			goto cleanup1;
+
+		bzero(&prog_info, sizeof(prog_info));
+		prog_info.jited_prog_len = 0;
+		prog_info.xlated_prog_len = 0;
+		prog_info.nr_map_ids = 0;
+		info_len = sizeof(prog_info);
+		err = bpf_obj_get_info_by_fd(prog_fd[i], &prog_info, &info_len);
+		if (CHECK(err, "bpf_obj_get_info_by_fd", "err %d errno %d\n",
+			  err, errno))
+			goto cleanup1;
+		saved_prog_ids[i] = prog_info.id;
+
+		pmu_fd[i] = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+				    0 /* cpu 0 */, -1 /* group id */,
+				    0 /* flags */);
+		if (CHECK(pmu_fd[i] < 0, "perf_event_open", "err %d errno %d\n",
+			  pmu_fd[i], errno))
+			goto cleanup2;
+		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_ENABLE, 0);
+		if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
+			  err, errno))
+			goto cleanup3;
+
+		if (i == 0) {
+			/* check NULL prog array query */
+			query->ids_len = num_progs;
+			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
+			if (CHECK(err || query->prog_cnt != 0,
+				  "perf_event_ioc_query_bpf",
+				  "err %d errno %d query->prog_cnt %u\n",
+				  err, errno, query->prog_cnt))
+				goto cleanup3;
+		}
+
+		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_SET_BPF, prog_fd[i]);
+		if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
+			  err, errno))
+			goto cleanup3;
+
+		if (i == 1) {
+			/* try to get # of programs only */
+			query->ids_len = 0;
+			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
+			if (CHECK(err || query->prog_cnt != 2,
+				  "perf_event_ioc_query_bpf",
+				  "err %d errno %d query->prog_cnt %u\n",
+				  err, errno, query->prog_cnt))
+				goto cleanup3;
+
+			/* try a few negative tests */
+			/* invalid query pointer */
+			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF,
+				    (struct perf_event_query_bpf *)0x1);
+			if (CHECK(!err || errno != EFAULT,
+				  "perf_event_ioc_query_bpf",
+				  "err %d errno %d\n", err, errno))
+				goto cleanup3;
+
+			/* no enough space */
+			query->ids_len = 1;
+			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
+			if (CHECK(!err || errno != ENOSPC || query->prog_cnt != 2,
+				  "perf_event_ioc_query_bpf",
+				  "err %d errno %d query->prog_cnt %u\n",
+				  err, errno, query->prog_cnt))
+				goto cleanup3;
+		}
+
+		query->ids_len = num_progs;
+		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
+		if (CHECK(err || query->prog_cnt != (i + 1),
+			  "perf_event_ioc_query_bpf",
+			  "err %d errno %d query->prog_cnt %u\n",
+			  err, errno, query->prog_cnt))
+			goto cleanup3;
+		for (j = 0; j < i + 1; j++)
+			if (CHECK(saved_prog_ids[j] != query->ids[j],
+				  "perf_event_ioc_query_bpf",
+				  "#%d saved_prog_id %x query prog_id %x\n",
+				  j, saved_prog_ids[j], query->ids[j]))
+				goto cleanup3;
+	}
+
+	i = num_progs - 1;
+	for (; i >= 0; i--) {
+ cleanup3:
+		ioctl(pmu_fd[i], PERF_EVENT_IOC_DISABLE);
+ cleanup2:
+		close(pmu_fd[i]);
+ cleanup1:
+		bpf_object__close(obj[i]);
+	}
+	free(query);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index a342fbe19f86..6e41dfab1e75 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -531,136 +531,6 @@ static void test_obj_name(void)
 	}
 }
 
-static void test_tp_attach_query(void)
-{
-	const int num_progs = 3;
-	int i, j, bytes, efd, err, prog_fd[num_progs], pmu_fd[num_progs];
-	__u32 duration = 0, info_len, saved_prog_ids[num_progs];
-	const char *file = "./test_tracepoint.o";
-	struct perf_event_query_bpf *query;
-	struct perf_event_attr attr = {};
-	struct bpf_object *obj[num_progs];
-	struct bpf_prog_info prog_info;
-	char buf[256];
-
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
-		return;
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf),
-		  "read", "bytes %d errno %d\n", bytes, errno))
-		return;
-
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-
-	query = malloc(sizeof(*query) + sizeof(__u32) * num_progs);
-	for (i = 0; i < num_progs; i++) {
-		err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj[i],
-				    &prog_fd[i]);
-		if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-			goto cleanup1;
-
-		bzero(&prog_info, sizeof(prog_info));
-		prog_info.jited_prog_len = 0;
-		prog_info.xlated_prog_len = 0;
-		prog_info.nr_map_ids = 0;
-		info_len = sizeof(prog_info);
-		err = bpf_obj_get_info_by_fd(prog_fd[i], &prog_info, &info_len);
-		if (CHECK(err, "bpf_obj_get_info_by_fd", "err %d errno %d\n",
-			  err, errno))
-			goto cleanup1;
-		saved_prog_ids[i] = prog_info.id;
-
-		pmu_fd[i] = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-				    0 /* cpu 0 */, -1 /* group id */,
-				    0 /* flags */);
-		if (CHECK(pmu_fd[i] < 0, "perf_event_open", "err %d errno %d\n",
-			  pmu_fd[i], errno))
-			goto cleanup2;
-		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_ENABLE, 0);
-		if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
-			  err, errno))
-			goto cleanup3;
-
-		if (i == 0) {
-			/* check NULL prog array query */
-			query->ids_len = num_progs;
-			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
-			if (CHECK(err || query->prog_cnt != 0,
-				  "perf_event_ioc_query_bpf",
-				  "err %d errno %d query->prog_cnt %u\n",
-				  err, errno, query->prog_cnt))
-				goto cleanup3;
-		}
-
-		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_SET_BPF, prog_fd[i]);
-		if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
-			  err, errno))
-			goto cleanup3;
-
-		if (i == 1) {
-			/* try to get # of programs only */
-			query->ids_len = 0;
-			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
-			if (CHECK(err || query->prog_cnt != 2,
-				  "perf_event_ioc_query_bpf",
-				  "err %d errno %d query->prog_cnt %u\n",
-				  err, errno, query->prog_cnt))
-				goto cleanup3;
-
-			/* try a few negative tests */
-			/* invalid query pointer */
-			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF,
-				    (struct perf_event_query_bpf *)0x1);
-			if (CHECK(!err || errno != EFAULT,
-				  "perf_event_ioc_query_bpf",
-				  "err %d errno %d\n", err, errno))
-				goto cleanup3;
-
-			/* no enough space */
-			query->ids_len = 1;
-			err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
-			if (CHECK(!err || errno != ENOSPC || query->prog_cnt != 2,
-				  "perf_event_ioc_query_bpf",
-				  "err %d errno %d query->prog_cnt %u\n",
-				  err, errno, query->prog_cnt))
-				goto cleanup3;
-		}
-
-		query->ids_len = num_progs;
-		err = ioctl(pmu_fd[i], PERF_EVENT_IOC_QUERY_BPF, query);
-		if (CHECK(err || query->prog_cnt != (i + 1),
-			  "perf_event_ioc_query_bpf",
-			  "err %d errno %d query->prog_cnt %u\n",
-			  err, errno, query->prog_cnt))
-			goto cleanup3;
-		for (j = 0; j < i + 1; j++)
-			if (CHECK(saved_prog_ids[j] != query->ids[j],
-				  "perf_event_ioc_query_bpf",
-				  "#%d saved_prog_id %x query prog_id %x\n",
-				  j, saved_prog_ids[j], query->ids[j]))
-				goto cleanup3;
-	}
-
-	i = num_progs - 1;
-	for (; i >= 0; i--) {
- cleanup3:
-		ioctl(pmu_fd[i], PERF_EVENT_IOC_DISABLE);
- cleanup2:
-		close(pmu_fd[i]);
- cleanup1:
-		bpf_object__close(obj[i]);
-	}
-	free(query);
-}
-
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
@@ -748,299 +618,6 @@ int extract_build_id(char *build_id, size_t size)
 	return -1;
 }
 
-#define MAX_CNT_RAWTP	10ull
-#define MAX_STACK_RAWTP	100
-struct get_stack_trace_t {
-	int pid;
-	int kern_stack_size;
-	int user_stack_size;
-	int user_stack_buildid_size;
-	__u64 kern_stack[MAX_STACK_RAWTP];
-	__u64 user_stack[MAX_STACK_RAWTP];
-	struct bpf_stack_build_id user_stack_buildid[MAX_STACK_RAWTP];
-};
-
-static int get_stack_print_output(void *data, int size)
-{
-	bool good_kern_stack = false, good_user_stack = false;
-	const char *nonjit_func = "___bpf_prog_run";
-	struct get_stack_trace_t *e = data;
-	int i, num_stack;
-	static __u64 cnt;
-	struct ksym *ks;
-
-	cnt++;
-
-	if (size < sizeof(struct get_stack_trace_t)) {
-		__u64 *raw_data = data;
-		bool found = false;
-
-		num_stack = size / sizeof(__u64);
-		/* If jit is enabled, we do not have a good way to
-		 * verify the sanity of the kernel stack. So we
-		 * just assume it is good if the stack is not empty.
-		 * This could be improved in the future.
-		 */
-		if (jit_enabled) {
-			found = num_stack > 0;
-		} else {
-			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(raw_data[i]);
-				if (strcmp(ks->name, nonjit_func) == 0) {
-					found = true;
-					break;
-				}
-			}
-		}
-		if (found) {
-			good_kern_stack = true;
-			good_user_stack = true;
-		}
-	} else {
-		num_stack = e->kern_stack_size / sizeof(__u64);
-		if (jit_enabled) {
-			good_kern_stack = num_stack > 0;
-		} else {
-			for (i = 0; i < num_stack; i++) {
-				ks = ksym_search(e->kern_stack[i]);
-				if (strcmp(ks->name, nonjit_func) == 0) {
-					good_kern_stack = true;
-					break;
-				}
-			}
-		}
-		if (e->user_stack_size > 0 && e->user_stack_buildid_size > 0)
-			good_user_stack = true;
-	}
-	if (!good_kern_stack || !good_user_stack)
-		return LIBBPF_PERF_EVENT_ERROR;
-
-	if (cnt == MAX_CNT_RAWTP)
-		return LIBBPF_PERF_EVENT_DONE;
-
-	return LIBBPF_PERF_EVENT_CONT;
-}
-
-static void test_get_stack_raw_tp(void)
-{
-	const char *file = "./test_get_stack_rawtp.o";
-	int i, efd, err, prog_fd, pmu_fd, perfmap_fd;
-	struct perf_event_attr attr = {};
-	struct timespec tv = {0, 10};
-	__u32 key = 0, duration = 0;
-	struct bpf_object *obj;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
-		return;
-
-	efd = bpf_raw_tracepoint_open("sys_enter", prog_fd);
-	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-
-	perfmap_fd = bpf_find_map(__func__, obj, "perfmap");
-	if (CHECK(perfmap_fd < 0, "bpf_find_map", "err %d errno %d\n",
-		  perfmap_fd, errno))
-		goto close_prog;
-
-	err = load_kallsyms();
-	if (CHECK(err < 0, "load_kallsyms", "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.type = PERF_TYPE_SOFTWARE;
-	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, getpid()/*pid*/, -1/*cpu*/,
-			 -1/*group_fd*/, 0);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n", pmu_fd,
-		  errno))
-		goto close_prog;
-
-	err = bpf_map_update_elem(perfmap_fd, &key, &pmu_fd, BPF_ANY);
-	if (CHECK(err < 0, "bpf_map_update_elem", "err %d errno %d\n", err,
-		  errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err < 0, "ioctl PERF_EVENT_IOC_ENABLE", "err %d errno %d\n",
-		  err, errno))
-		goto close_prog;
-
-	err = perf_event_mmap(pmu_fd);
-	if (CHECK(err < 0, "perf_event_mmap", "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	/* trigger some syscall action */
-	for (i = 0; i < MAX_CNT_RAWTP; i++)
-		nanosleep(&tv, NULL);
-
-	err = perf_event_poller(pmu_fd, get_stack_print_output);
-	if (CHECK(err < 0, "perf_event_poller", "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	goto close_prog_noerr;
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
-static void test_task_fd_query_rawtp(void)
-{
-	const char *file = "./test_get_stack_rawtp.o";
-	__u64 probe_offset, probe_addr;
-	__u32 len, prog_id, fd_type;
-	struct bpf_object *obj;
-	int efd, err, prog_fd;
-	__u32 duration = 0;
-	char buf[256];
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
-		return;
-
-	efd = bpf_raw_tracepoint_open("sys_enter", prog_fd);
-	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-
-	/* query (getpid(), efd) */
-	len = sizeof(buf);
-	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
-	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
-		  errno))
-		goto close_prog;
-
-	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
-	      strcmp(buf, "sys_enter") == 0;
-	if (CHECK(!err, "check_results", "fd_type %d tp_name %s\n",
-		  fd_type, buf))
-		goto close_prog;
-
-	/* test zero len */
-	len = 0;
-	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
-	if (CHECK(err < 0, "bpf_task_fd_query (len = 0)", "err %d errno %d\n",
-		  err, errno))
-		goto close_prog;
-	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
-	      len == strlen("sys_enter");
-	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
-		goto close_prog;
-
-	/* test empty buffer */
-	len = sizeof(buf);
-	err = bpf_task_fd_query(getpid(), efd, 0, 0, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
-	if (CHECK(err < 0, "bpf_task_fd_query (buf = 0)", "err %d errno %d\n",
-		  err, errno))
-		goto close_prog;
-	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
-	      len == strlen("sys_enter");
-	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
-		goto close_prog;
-
-	/* test smaller buffer */
-	len = 3;
-	err = bpf_task_fd_query(getpid(), efd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
-	if (CHECK(err >= 0 || errno != ENOSPC, "bpf_task_fd_query (len = 3)",
-		  "err %d errno %d\n", err, errno))
-		goto close_prog;
-	err = fd_type == BPF_FD_TYPE_RAW_TRACEPOINT &&
-	      len == strlen("sys_enter") &&
-	      strcmp(buf, "sy") == 0;
-	if (CHECK(!err, "check_results", "fd_type %d len %u\n", fd_type, len))
-		goto close_prog;
-
-	goto close_prog_noerr;
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
-static void test_task_fd_query_tp_core(const char *probe_name,
-				       const char *tp_name)
-{
-	const char *file = "./test_tracepoint.o";
-	int err, bytes, efd, prog_fd, pmu_fd;
-	struct perf_event_attr attr = {};
-	__u64 probe_offset, probe_addr;
-	__u32 len, prog_id, fd_type;
-	struct bpf_object *obj;
-	__u32 duration = 0;
-	char buf[256];
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "bpf_prog_load", "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/%s/id", probe_name);
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf), "read",
-		  "bytes %d errno %d\n", bytes, errno))
-		goto close_prog;
-
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(err, "perf_event_open", "err %d errno %d\n", err, errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n", err,
-		  errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n", err,
-		  errno))
-		goto close_pmu;
-
-	/* query (getpid(), pmu_fd) */
-	len = sizeof(buf);
-	err = bpf_task_fd_query(getpid(), pmu_fd, 0, buf, &len, &prog_id,
-				&fd_type, &probe_offset, &probe_addr);
-	if (CHECK(err < 0, "bpf_task_fd_query", "err %d errno %d\n", err,
-		  errno))
-		goto close_pmu;
-
-	err = (fd_type == BPF_FD_TYPE_TRACEPOINT) && !strcmp(buf, tp_name);
-	if (CHECK(!err, "check_results", "fd_type %d tp_name %s\n",
-		  fd_type, buf))
-		goto close_pmu;
-
-	close(pmu_fd);
-	goto close_prog_noerr;
-
-close_pmu:
-	close(pmu_fd);
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
-static void test_task_fd_query_tp(void)
-{
-	test_task_fd_query_tp_core("sched/sched_switch",
-				   "sched_switch");
-	test_task_fd_query_tp_core("syscalls/sys_enter_read",
-				   "sys_enter_read");
-}
-
 static int libbpf_debug_print(enum libbpf_print_level level,
 			      const char *format, va_list args)
 {
@@ -1423,10 +1000,6 @@ int main(void)
 	test_tcp_estats();
 	test_bpf_obj_id();
 	test_obj_name();
-	test_tp_attach_query();
-	test_get_stack_raw_tp();
-	test_task_fd_query_rawtp();
-	test_task_fd_query_tp();
 	test_reference_tracking();
 	test_queue_stack_map(QUEUE);
 	test_queue_stack_map(STACK);
-- 
2.21.0.352.gf09ad66450-goog

