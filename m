Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA32AC43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F11E2083E
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 03:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VarszuKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfCBDmf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:42:35 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43017 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbfCBDme (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 22:42:34 -0500
Received: by mail-yw1-f73.google.com with SMTP id r8so24851207ywh.10
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 19:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kCtLmQYYxh6FyeEeIolgFgvsXd9srM0EzQvTNKuV0Z8=;
        b=VarszuKoVzpWsN+p9y4nWJlrDY4IHIwGcjyXV/8PbZO89ftB+y5de/0L+VdoBDiT7P
         ttBpYbpe6HT2TA3w+o/eOqk7O59sK4G2U77d5IvkaHJq8oet8/6cli26XFqluSZ0oWCA
         /4q5n8ezbebkzi+SbFPvFFrrow6GDiSCzrlevMe9hxwZpOjffPPHO8R0YVw2mRbLGrxr
         Qjlv74mqKM5vg6OD5Q91iify5FeM83pH8eHQ7KozCm3mRMSBT+Bj4t1SdKIIctC6Ey/W
         3OxPTIpBxGR1TAYUPSRy4YmclIlmPpoaNEMTtG79N4igEmyn3s8kC55IlOzL0wOiXdFJ
         wSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kCtLmQYYxh6FyeEeIolgFgvsXd9srM0EzQvTNKuV0Z8=;
        b=ts8dCQwq3MEtVly1WzdrDzEvmLcyYUv/tlPYdUBSVQzyZbbPkj3CtRLCeLiGYw3OUt
         JR7zBLSB89GYRHHyU218puAYjDEZOV2fGd8w+VVd7OAJfUiVZBzJVPjygLRCnzDCGHBO
         z+vo3lfN+xPOHsx2QV8UcTpMt2IBC7CRXxa3myKFW9h7SjBrZXfoN5ACl0DpNzGgWsNC
         xDZMUHOQazRxI7yoe7Q4hd8280+Fm2qqjlDU5zvUQ3fOsqbE7YYNpGOhfkA2RuFVhTmY
         vr90jlvG34iKX2oXUW/ZyYahhZE1F34iVpSZRfnWLejeWybpANsqldoAzVPDAGQ5BwdY
         MlFw==
X-Gm-Message-State: APjAAAXPf6kApeDQaQGO+5mxvmI/oqsOcA6rFWMRrJf0qRUv057OpnRK
        PxIf5FSC3tZiIU6fXPzUYgpgXA0=
X-Google-Smtp-Source: APXvYqwwhvgDsdomdo9wIoYwqW/fHCswsdm0iPH4OgTeNzrkcoTjWn2jmAsAlyrBc2kByNqaoaAIvqM=
X-Received: by 2002:a25:d7d1:: with SMTP id o200mr4355504ybg.21.1551498153000;
 Fri, 01 Mar 2019 19:42:33 -0800 (PST)
Date:   Fri,  1 Mar 2019 19:42:16 -0800
In-Reply-To: <20190302034219.99480-1-sdf@google.com>
Message-Id: <20190302034219.99480-5-sdf@google.com>
Mime-Version: 1.0
References: <20190302034219.99480-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.352.gf09ad66450-goog
Subject: [PATCH bpf-next v3 4/7] selftests: bpf: break up test_progs - stackmap
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move stackmap prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../bpf/prog_tests/stacktrace_build_id.c      | 165 ++++++
 .../bpf/prog_tests/stacktrace_build_id_nmi.c  | 150 ++++++
 .../selftests/bpf/prog_tests/stacktrace_map.c | 103 ++++
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  59 +++
 tools/testing/selftests/bpf/test_progs.c      | 479 +-----------------
 tools/testing/selftests/bpf/test_progs.h      |   3 +
 6 files changed, 483 insertions(+), 476 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
new file mode 100644
index 000000000000..3aab2b083c71
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_stacktrace_build_id(void)
+{
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	const char *file = "./test_stacktrace_build_id.o";
+	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
+	struct perf_event_attr attr = {};
+	__u32 key, previous_key, val, duration = 0;
+	struct bpf_object *obj;
+	char buf[256];
+	int i, j;
+	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
+	int build_id_matches = 0;
+	int retry = 1;
+
+retry:
+	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
+		goto out;
+
+	/* Get the ID for the sched/sched_switch tracepoint */
+	snprintf(buf, sizeof(buf),
+		 "/sys/kernel/debug/tracing/events/random/urandom_read/id");
+	efd = open(buf, O_RDONLY, 0);
+	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+
+	bytes = read(efd, buf, sizeof(buf));
+	close(efd);
+	if (CHECK(bytes <= 0 || bytes >= sizeof(buf),
+		  "read", "bytes %d errno %d\n", bytes, errno))
+		goto close_prog;
+
+	/* Open the perf event and attach bpf progrram */
+	attr.config = strtol(buf, NULL, 0);
+	attr.type = PERF_TYPE_TRACEPOINT;
+	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
+	attr.sample_period = 1;
+	attr.wakeup_events = 1;
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
+		  pmu_fd, errno))
+		goto close_prog;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
+		  err, errno))
+		goto close_pmu;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
+	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
+		  err, errno))
+		goto disable_pmu;
+
+	/* find map fds */
+	control_map_fd = bpf_find_map(__func__, obj, "control_map");
+	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
+	if (CHECK(stackid_hmap_fd < 0, "bpf_find_map stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
+	if (CHECK(stackmap_fd < 0, "bpf_find_map stackmap", "err %d errno %d\n",
+		  err, errno))
+		goto disable_pmu;
+
+	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
+	if (CHECK(stack_amap_fd < 0, "bpf_find_map stack_amap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	assert(system("dd if=/dev/urandom of=/dev/zero count=4 2> /dev/null")
+	       == 0);
+	assert(system("./urandom_read") == 0);
+	/* disable stack trace collection */
+	key = 0;
+	val = 1;
+	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+
+	/* for every element in stackid_hmap, we can find a corresponding one
+	 * in stackmap, and vise versa.
+	 */
+	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
+	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
+	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = extract_build_id(buf, 256);
+
+	if (CHECK(err, "get build_id with readelf",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
+	if (CHECK(err, "get_next_key from stackmap",
+		  "err %d, errno %d\n", err, errno))
+		goto disable_pmu;
+
+	do {
+		char build_id[64];
+
+		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
+		if (CHECK(err, "lookup_elem from stackmap",
+			  "err %d, errno %d\n", err, errno))
+			goto disable_pmu;
+		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
+			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
+			    id_offs[i].offset != 0) {
+				for (j = 0; j < 20; ++j)
+					sprintf(build_id + 2 * j, "%02x",
+						id_offs[i].build_id[j] & 0xff);
+				if (strstr(buf, build_id) != NULL)
+					build_id_matches = 1;
+			}
+		previous_key = key;
+	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
+
+	/* stack_map_get_build_id_offset() is racy and sometimes can return
+	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
+	 * try it one more time.
+	 */
+	if (build_id_matches < 1 && retry--) {
+		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+		close(pmu_fd);
+		bpf_object__close(obj);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
+		goto retry;
+	}
+
+	if (CHECK(build_id_matches < 1, "build id match",
+		  "Didn't find expected build ID from the map\n"))
+		goto disable_pmu;
+
+	stack_trace_len = PERF_MAX_STACK_DEPTH
+		* sizeof(struct bpf_stack_build_id);
+	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
+	CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
+	      "err %d errno %d\n", err, errno);
+
+disable_pmu:
+	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+
+close_pmu:
+	close(pmu_fd);
+
+close_prog:
+	bpf_object__close(obj);
+
+out:
+	return;
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
new file mode 100644
index 000000000000..8a114bb1c379
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_stacktrace_build_id_nmi(void)
+{
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	const char *file = "./test_stacktrace_build_id.o";
+	int err, pmu_fd, prog_fd;
+	struct perf_event_attr attr = {
+		.sample_freq = 5000,
+		.freq = 1,
+		.type = PERF_TYPE_HARDWARE,
+		.config = PERF_COUNT_HW_CPU_CYCLES,
+	};
+	__u32 key, previous_key, val, duration = 0;
+	struct bpf_object *obj;
+	char buf[256];
+	int i, j;
+	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
+	int build_id_matches = 0;
+	int retry = 1;
+
+retry:
+	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
+		return;
+
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (CHECK(pmu_fd < 0, "perf_event_open",
+		  "err %d errno %d. Does the test host support PERF_COUNT_HW_CPU_CYCLES?\n",
+		  pmu_fd, errno))
+		goto close_prog;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
+		  err, errno))
+		goto close_pmu;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
+	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
+		  err, errno))
+		goto disable_pmu;
+
+	/* find map fds */
+	control_map_fd = bpf_find_map(__func__, obj, "control_map");
+	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
+	if (CHECK(stackid_hmap_fd < 0, "bpf_find_map stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
+	if (CHECK(stackmap_fd < 0, "bpf_find_map stackmap", "err %d errno %d\n",
+		  err, errno))
+		goto disable_pmu;
+
+	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
+	if (CHECK(stack_amap_fd < 0, "bpf_find_map stack_amap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	assert(system("dd if=/dev/urandom of=/dev/zero count=4 2> /dev/null")
+	       == 0);
+	assert(system("taskset 0x1 ./urandom_read 100000") == 0);
+	/* disable stack trace collection */
+	key = 0;
+	val = 1;
+	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+
+	/* for every element in stackid_hmap, we can find a corresponding one
+	 * in stackmap, and vise versa.
+	 */
+	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
+	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
+	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = extract_build_id(buf, 256);
+
+	if (CHECK(err, "get build_id with readelf",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
+	if (CHECK(err, "get_next_key from stackmap",
+		  "err %d, errno %d\n", err, errno))
+		goto disable_pmu;
+
+	do {
+		char build_id[64];
+
+		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
+		if (CHECK(err, "lookup_elem from stackmap",
+			  "err %d, errno %d\n", err, errno))
+			goto disable_pmu;
+		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
+			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
+			    id_offs[i].offset != 0) {
+				for (j = 0; j < 20; ++j)
+					sprintf(build_id + 2 * j, "%02x",
+						id_offs[i].build_id[j] & 0xff);
+				if (strstr(buf, build_id) != NULL)
+					build_id_matches = 1;
+			}
+		previous_key = key;
+	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
+
+	/* stack_map_get_build_id_offset() is racy and sometimes can return
+	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
+	 * try it one more time.
+	 */
+	if (build_id_matches < 1 && retry--) {
+		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+		close(pmu_fd);
+		bpf_object__close(obj);
+		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
+		       __func__);
+		goto retry;
+	}
+
+	if (CHECK(build_id_matches < 1, "build id match",
+		  "Didn't find expected build ID from the map\n"))
+		goto disable_pmu;
+
+	/*
+	 * We intentionally skip compare_stack_ips(). This is because we
+	 * only support one in_nmi() ips-to-build_id translation per cpu
+	 * at any time, thus stack_amap here will always fallback to
+	 * BPF_STACK_BUILD_ID_IP;
+	 */
+
+disable_pmu:
+	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+
+close_pmu:
+	close(pmu_fd);
+
+close_prog:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
new file mode 100644
index 000000000000..2bfd50a0d6d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_stacktrace_map(void)
+{
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	const char *file = "./test_stacktrace_map.o";
+	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
+	struct perf_event_attr attr = {};
+	__u32 key, val, duration = 0;
+	struct bpf_object *obj;
+	char buf[256];
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
+		return;
+
+	/* Get the ID for the sched/sched_switch tracepoint */
+	snprintf(buf, sizeof(buf),
+		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
+	efd = open(buf, O_RDONLY, 0);
+	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+
+	bytes = read(efd, buf, sizeof(buf));
+	close(efd);
+	if (bytes <= 0 || bytes >= sizeof(buf))
+		goto close_prog;
+
+	/* Open the perf event and attach bpf progrram */
+	attr.config = strtol(buf, NULL, 0);
+	attr.type = PERF_TYPE_TRACEPOINT;
+	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
+	attr.sample_period = 1;
+	attr.wakeup_events = 1;
+	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
+			 0 /* cpu 0 */, -1 /* group id */,
+			 0 /* flags */);
+	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
+		  pmu_fd, errno))
+		goto close_prog;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
+	if (err)
+		goto disable_pmu;
+
+	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
+	if (err)
+		goto disable_pmu;
+
+	/* find map fds */
+	control_map_fd = bpf_find_map(__func__, obj, "control_map");
+	if (control_map_fd < 0)
+		goto disable_pmu;
+
+	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
+	if (stackid_hmap_fd < 0)
+		goto disable_pmu;
+
+	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
+	if (stackmap_fd < 0)
+		goto disable_pmu;
+
+	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
+	if (stack_amap_fd < 0)
+		goto disable_pmu;
+
+	/* give some time for bpf program run */
+	sleep(1);
+
+	/* disable stack trace collection */
+	key = 0;
+	val = 1;
+	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+
+	/* for every element in stackid_hmap, we can find a corresponding one
+	 * in stackmap, and vise versa.
+	 */
+	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
+	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu_noerr;
+
+	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
+	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu_noerr;
+
+	stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
+	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
+	if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu_noerr;
+
+	goto disable_pmu_noerr;
+disable_pmu:
+	error_cnt++;
+disable_pmu_noerr:
+	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
+	close(pmu_fd);
+close_prog:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
new file mode 100644
index 000000000000..1f8387d80fd7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_stacktrace_map_raw_tp(void)
+{
+	int control_map_fd, stackid_hmap_fd, stackmap_fd;
+	const char *file = "./test_stacktrace_map.o";
+	int efd, err, prog_fd;
+	__u32 key, val, duration = 0;
+	struct bpf_object *obj;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
+	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
+		return;
+
+	efd = bpf_raw_tracepoint_open("sched_switch", prog_fd);
+	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
+		goto close_prog;
+
+	/* find map fds */
+	control_map_fd = bpf_find_map(__func__, obj, "control_map");
+	if (control_map_fd < 0)
+		goto close_prog;
+
+	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
+	if (stackid_hmap_fd < 0)
+		goto close_prog;
+
+	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
+	if (stackmap_fd < 0)
+		goto close_prog;
+
+	/* give some time for bpf program run */
+	sleep(1);
+
+	/* disable stack trace collection */
+	key = 0;
+	val = 1;
+	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+
+	/* for every element in stackid_hmap, we can find a corresponding one
+	 * in stackmap, and vise versa.
+	 */
+	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
+	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
+		  "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
+	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
+		  "err %d errno %d\n", err, errno))
+		goto close_prog;
+
+	goto close_prog_noerr;
+close_prog:
+	error_cnt++;
+close_prog_noerr:
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 1f48bf400c66..a342fbe19f86 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -661,7 +661,7 @@ static void test_tp_attach_query(void)
 	free(query);
 }
 
-static int compare_map_keys(int map1_fd, int map2_fd)
+int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
 	char val_buf[PERF_MAX_STACK_DEPTH *
@@ -688,7 +688,7 @@ static int compare_map_keys(int map1_fd, int map2_fd)
 	return 0;
 }
 
-static int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
+int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 {
 	__u32 key, next_key, *cur_key_p, *next_key_p;
 	char *val_buf1, *val_buf2;
@@ -724,165 +724,7 @@ static int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len)
 	return err;
 }
 
-static void test_stacktrace_map()
-{
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *file = "./test_stacktrace_map.o";
-	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
-	struct perf_event_attr attr = {};
-	__u32 key, val, duration = 0;
-	struct bpf_object *obj;
-	char buf[256];
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-		return;
-
-	/* Get the ID for the sched/sched_switch tracepoint */
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/sched/sched_switch/id");
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (bytes <= 0 || bytes >= sizeof(buf))
-		goto close_prog;
-
-	/* Open the perf event and attach bpf progrram */
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
-		  pmu_fd, errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (err)
-		goto disable_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (err)
-		goto disable_pmu;
-
-	/* find map fds */
-	control_map_fd = bpf_find_map(__func__, obj, "control_map");
-	if (control_map_fd < 0)
-		goto disable_pmu;
-
-	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
-	if (stackid_hmap_fd < 0)
-		goto disable_pmu;
-
-	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
-	if (stackmap_fd < 0)
-		goto disable_pmu;
-
-	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
-	if (stack_amap_fd < 0)
-		goto disable_pmu;
-
-	/* give some time for bpf program run */
-	sleep(1);
-
-	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
-
-	/* for every element in stackid_hmap, we can find a corresponding one
-	 * in stackmap, and vise versa.
-	 */
-	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
-	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu_noerr;
-
-	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
-	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu_noerr;
-
-	stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
-	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
-	if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu_noerr;
-
-	goto disable_pmu_noerr;
-disable_pmu:
-	error_cnt++;
-disable_pmu_noerr:
-	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-	close(pmu_fd);
-close_prog:
-	bpf_object__close(obj);
-}
-
-static void test_stacktrace_map_raw_tp()
-{
-	int control_map_fd, stackid_hmap_fd, stackmap_fd;
-	const char *file = "./test_stacktrace_map.o";
-	int efd, err, prog_fd;
-	__u32 key, val, duration = 0;
-	struct bpf_object *obj;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_RAW_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load raw tp", "err %d errno %d\n", err, errno))
-		return;
-
-	efd = bpf_raw_tracepoint_open("sched_switch", prog_fd);
-	if (CHECK(efd < 0, "raw_tp_open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-
-	/* find map fds */
-	control_map_fd = bpf_find_map(__func__, obj, "control_map");
-	if (control_map_fd < 0)
-		goto close_prog;
-
-	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
-	if (stackid_hmap_fd < 0)
-		goto close_prog;
-
-	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
-	if (stackmap_fd < 0)
-		goto close_prog;
-
-	/* give some time for bpf program run */
-	sleep(1);
-
-	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
-
-	/* for every element in stackid_hmap, we can find a corresponding one
-	 * in stackmap, and vise versa.
-	 */
-	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
-	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
-		  "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
-	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto close_prog;
-
-	goto close_prog_noerr;
-close_prog:
-	error_cnt++;
-close_prog_noerr:
-	bpf_object__close(obj);
-}
-
-static int extract_build_id(char *build_id, size_t size)
+int extract_build_id(char *build_id, size_t size)
 {
 	FILE *fp;
 	char *line = NULL;
@@ -906,317 +748,6 @@ static int extract_build_id(char *build_id, size_t size)
 	return -1;
 }
 
-static void test_stacktrace_build_id(void)
-{
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *file = "./test_stacktrace_build_id.o";
-	int bytes, efd, err, pmu_fd, prog_fd, stack_trace_len;
-	struct perf_event_attr attr = {};
-	__u32 key, previous_key, val, duration = 0;
-	struct bpf_object *obj;
-	char buf[256];
-	int i, j;
-	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
-	int build_id_matches = 0;
-	int retry = 1;
-
-retry:
-	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-		goto out;
-
-	/* Get the ID for the sched/sched_switch tracepoint */
-	snprintf(buf, sizeof(buf),
-		 "/sys/kernel/debug/tracing/events/random/urandom_read/id");
-	efd = open(buf, O_RDONLY, 0);
-	if (CHECK(efd < 0, "open", "err %d errno %d\n", efd, errno))
-		goto close_prog;
-
-	bytes = read(efd, buf, sizeof(buf));
-	close(efd);
-	if (CHECK(bytes <= 0 || bytes >= sizeof(buf),
-		  "read", "bytes %d errno %d\n", bytes, errno))
-		goto close_prog;
-
-	/* Open the perf event and attach bpf progrram */
-	attr.config = strtol(buf, NULL, 0);
-	attr.type = PERF_TYPE_TRACEPOINT;
-	attr.sample_type = PERF_SAMPLE_RAW | PERF_SAMPLE_CALLCHAIN;
-	attr.sample_period = 1;
-	attr.wakeup_events = 1;
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open", "err %d errno %d\n",
-		  pmu_fd, errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
-		  err, errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
-		  err, errno))
-		goto disable_pmu;
-
-	/* find map fds */
-	control_map_fd = bpf_find_map(__func__, obj, "control_map");
-	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
-	if (CHECK(stackid_hmap_fd < 0, "bpf_find_map stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
-	if (CHECK(stackmap_fd < 0, "bpf_find_map stackmap", "err %d errno %d\n",
-		  err, errno))
-		goto disable_pmu;
-
-	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
-	if (CHECK(stack_amap_fd < 0, "bpf_find_map stack_amap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	assert(system("dd if=/dev/urandom of=/dev/zero count=4 2> /dev/null")
-	       == 0);
-	assert(system("./urandom_read") == 0);
-	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
-
-	/* for every element in stackid_hmap, we can find a corresponding one
-	 * in stackmap, and vise versa.
-	 */
-	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
-	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
-	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = extract_build_id(buf, 256);
-
-	if (CHECK(err, "get build_id with readelf",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
-	if (CHECK(err, "get_next_key from stackmap",
-		  "err %d, errno %d\n", err, errno))
-		goto disable_pmu;
-
-	do {
-		char build_id[64];
-
-		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
-		if (CHECK(err, "lookup_elem from stackmap",
-			  "err %d, errno %d\n", err, errno))
-			goto disable_pmu;
-		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
-			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
-			    id_offs[i].offset != 0) {
-				for (j = 0; j < 20; ++j)
-					sprintf(build_id + 2 * j, "%02x",
-						id_offs[i].build_id[j] & 0xff);
-				if (strstr(buf, build_id) != NULL)
-					build_id_matches = 1;
-			}
-		previous_key = key;
-	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
-
-	/* stack_map_get_build_id_offset() is racy and sometimes can return
-	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
-	 * try it one more time.
-	 */
-	if (build_id_matches < 1 && retry--) {
-		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-		close(pmu_fd);
-		bpf_object__close(obj);
-		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
-		       __func__);
-		goto retry;
-	}
-
-	if (CHECK(build_id_matches < 1, "build id match",
-		  "Didn't find expected build ID from the map\n"))
-		goto disable_pmu;
-
-	stack_trace_len = PERF_MAX_STACK_DEPTH
-		* sizeof(struct bpf_stack_build_id);
-	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
-	CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
-	      "err %d errno %d\n", err, errno);
-
-disable_pmu:
-	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-
-close_pmu:
-	close(pmu_fd);
-
-close_prog:
-	bpf_object__close(obj);
-
-out:
-	return;
-}
-
-static void test_stacktrace_build_id_nmi(void)
-{
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *file = "./test_stacktrace_build_id.o";
-	int err, pmu_fd, prog_fd;
-	struct perf_event_attr attr = {
-		.sample_freq = 5000,
-		.freq = 1,
-		.type = PERF_TYPE_HARDWARE,
-		.config = PERF_COUNT_HW_CPU_CYCLES,
-	};
-	__u32 key, previous_key, val, duration = 0;
-	struct bpf_object *obj;
-	char buf[256];
-	int i, j;
-	struct bpf_stack_build_id id_offs[PERF_MAX_STACK_DEPTH];
-	int build_id_matches = 0;
-	int retry = 1;
-
-retry:
-	err = bpf_prog_load(file, BPF_PROG_TYPE_PERF_EVENT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
-		return;
-
-	pmu_fd = syscall(__NR_perf_event_open, &attr, -1 /* pid */,
-			 0 /* cpu 0 */, -1 /* group id */,
-			 0 /* flags */);
-	if (CHECK(pmu_fd < 0, "perf_event_open",
-		  "err %d errno %d. Does the test host support PERF_COUNT_HW_CPU_CYCLES?\n",
-		  pmu_fd, errno))
-		goto close_prog;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_ENABLE, 0);
-	if (CHECK(err, "perf_event_ioc_enable", "err %d errno %d\n",
-		  err, errno))
-		goto close_pmu;
-
-	err = ioctl(pmu_fd, PERF_EVENT_IOC_SET_BPF, prog_fd);
-	if (CHECK(err, "perf_event_ioc_set_bpf", "err %d errno %d\n",
-		  err, errno))
-		goto disable_pmu;
-
-	/* find map fds */
-	control_map_fd = bpf_find_map(__func__, obj, "control_map");
-	if (CHECK(control_map_fd < 0, "bpf_find_map control_map",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
-	if (CHECK(stackid_hmap_fd < 0, "bpf_find_map stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
-	if (CHECK(stackmap_fd < 0, "bpf_find_map stackmap", "err %d errno %d\n",
-		  err, errno))
-		goto disable_pmu;
-
-	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
-	if (CHECK(stack_amap_fd < 0, "bpf_find_map stack_amap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	assert(system("dd if=/dev/urandom of=/dev/zero count=4 2> /dev/null")
-	       == 0);
-	assert(system("taskset 0x1 ./urandom_read 100000") == 0);
-	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
-
-	/* for every element in stackid_hmap, we can find a corresponding one
-	 * in stackmap, and vise versa.
-	 */
-	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
-	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
-	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = extract_build_id(buf, 256);
-
-	if (CHECK(err, "get build_id with readelf",
-		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
-
-	err = bpf_map_get_next_key(stackmap_fd, NULL, &key);
-	if (CHECK(err, "get_next_key from stackmap",
-		  "err %d, errno %d\n", err, errno))
-		goto disable_pmu;
-
-	do {
-		char build_id[64];
-
-		err = bpf_map_lookup_elem(stackmap_fd, &key, id_offs);
-		if (CHECK(err, "lookup_elem from stackmap",
-			  "err %d, errno %d\n", err, errno))
-			goto disable_pmu;
-		for (i = 0; i < PERF_MAX_STACK_DEPTH; ++i)
-			if (id_offs[i].status == BPF_STACK_BUILD_ID_VALID &&
-			    id_offs[i].offset != 0) {
-				for (j = 0; j < 20; ++j)
-					sprintf(build_id + 2 * j, "%02x",
-						id_offs[i].build_id[j] & 0xff);
-				if (strstr(buf, build_id) != NULL)
-					build_id_matches = 1;
-			}
-		previous_key = key;
-	} while (bpf_map_get_next_key(stackmap_fd, &previous_key, &key) == 0);
-
-	/* stack_map_get_build_id_offset() is racy and sometimes can return
-	 * BPF_STACK_BUILD_ID_IP instead of BPF_STACK_BUILD_ID_VALID;
-	 * try it one more time.
-	 */
-	if (build_id_matches < 1 && retry--) {
-		ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-		close(pmu_fd);
-		bpf_object__close(obj);
-		printf("%s:WARN:Didn't find expected build ID from the map, retrying\n",
-		       __func__);
-		goto retry;
-	}
-
-	if (CHECK(build_id_matches < 1, "build id match",
-		  "Didn't find expected build ID from the map\n"))
-		goto disable_pmu;
-
-	/*
-	 * We intentionally skip compare_stack_ips(). This is because we
-	 * only support one in_nmi() ips-to-build_id translation per cpu
-	 * at any time, thus stack_amap here will always fallback to
-	 * BPF_STACK_BUILD_ID_IP;
-	 */
-
-disable_pmu:
-	ioctl(pmu_fd, PERF_EVENT_IOC_DISABLE);
-
-close_pmu:
-	close(pmu_fd);
-
-close_prog:
-	bpf_object__close(obj);
-}
-
 #define MAX_CNT_RAWTP	10ull
 #define MAX_STACK_RAWTP	100
 struct get_stack_trace_t {
@@ -1893,10 +1424,6 @@ int main(void)
 	test_bpf_obj_id();
 	test_obj_name();
 	test_tp_attach_query();
-	test_stacktrace_map();
-	test_stacktrace_build_id();
-	test_stacktrace_build_id_nmi();
-	test_stacktrace_map_raw_tp();
 	test_get_stack_raw_tp();
 	test_task_fd_query_rawtp();
 	test_task_fd_query_tp();
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 040132877680..148b5494ed08 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -82,3 +82,6 @@ extern struct ipv6_packet pkt_v6;
 #define VIP_NUM 5
 
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
+int compare_map_keys(int map1_fd, int map2_fd);
+int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
+int extract_build_id(char *build_id, size_t size);
-- 
2.21.0.352.gf09ad66450-goog

