Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC4C00319
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6024D218AE
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 01:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2aFCbun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfB1BCS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:02:18 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:36784 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbfB1BCR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 20:02:17 -0500
Received: by mail-oi1-f202.google.com with SMTP id x133so8332966oia.3
        for <bpf@vger.kernel.org>; Wed, 27 Feb 2019 17:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SQm8kcZDSBCvLnOml+eW9IdAgWWUYVBRZzvZcw5mBrk=;
        b=K2aFCbunZKJNv4yHEHeEQuqQo9dg1t+eQG8a76MVKhhvkYs996PbFlufvEbwFCV8su
         KhxskCkYx4kIjUxUpT8m09yUL1XcPzcYja7QrrDmn9Az8xfxpeC5375JlafZwEuahwFw
         YWs3F1ODW/U87rS7iYyBpqTI6Q37IdzQgszZNImZmhRs0aRK/2tHaZo6fSpTaWOxaUwl
         +H20Jl4JlE919LRz3OinoSGyIVqhU8Q9hNvXRM4pzNxCpldQ9rRvcu1GTgU229ulp7M7
         Hj0J9qvC654W5+R8cKbDVbQJRGtdZXDnrCBFhfQW8vc5CmHV7XKWkoFPe6MqBoca4PfU
         ImTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SQm8kcZDSBCvLnOml+eW9IdAgWWUYVBRZzvZcw5mBrk=;
        b=hqYL4eI1hqEt5JaDFYX0Zvl4wUoRULd3km22nhuAFm7qXiQ3WMcym/n+z8wYN2YPZA
         fNP/Fwrxj00s3N4+BsK4eFamstCMD6f+H0GDYxSKjBpZZyR+pKaSHv/2CMg+mY2roihE
         EQbV1x23eq48zl8GclES0L9t73qJySoQ41AtFVWZL39AfKb0ZjMIvw26zZU1cMYcFTlP
         BbUi/JW1fv/95WuGi1DGjHWChlFdSU0hlNkCN9F9hLOOKDSjq9Mr795kkLuivOj2FAy+
         S98s7gVqfEkoVN0lPdCZI5KLAqNq80388HFozyPl/adKiMVI91BjayVZ9o7P3eqSGaQY
         Xqtw==
X-Gm-Message-State: AHQUAuYOHOYNfZxgySQXYVSBtqCd5vrKPAgLJRRdCopG6NTz3uqk3poJ
        BNJItVHTdcvQxCTShHAvyv7GQxg=
X-Google-Smtp-Source: AHgI3Ib1wAkcjKvOS8LN8JZ8mixJBQnPukfkj9aSetoTugPKrpyCbGxTvHNvKI05zAHhS2Q9F5aavSk=
X-Received: by 2002:aca:ebcc:: with SMTP id j195mr2525571oih.6.1551315735631;
 Wed, 27 Feb 2019 17:02:15 -0800 (PST)
Date:   Wed, 27 Feb 2019 17:01:56 -0800
In-Reply-To: <20190228010156.82981-1-sdf@google.com>
Message-Id: <20190228010156.82981-7-sdf@google.com>
Mime-Version: 1.0
References: <20190228010156.82981-1-sdf@google.com>
X-Mailer: git-send-email 2.21.0.rc2.261.ga7da99ff1b-goog
Subject: [PATCH bpf-next 7/7] selftests: bpf: break up test_progs - misc
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the rest of prog tests into separate files.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/bpf_obj_id.c     | 249 ++++++
 .../selftests/bpf/prog_tests/flow_dissector.c |  72 ++
 .../selftests/bpf/prog_tests/l4lb_all.c       |  90 +++
 .../selftests/bpf/prog_tests/obj_name.c       |  71 ++
 .../selftests/bpf/prog_tests/prog_run_xattr.c |  49 ++
 .../bpf/prog_tests/queue_stack_map.c          | 103 +++
 .../bpf/prog_tests/reference_tracking.c       |  48 ++
 .../selftests/bpf/prog_tests/signal_pending.c |  48 ++
 .../selftests/bpf/prog_tests/tcp_estats.c     |  19 +
 tools/testing/selftests/bpf/test_progs.c      | 735 ------------------
 tools/testing/selftests/bpf/test_progs.h      |   5 +
 11 files changed, 754 insertions(+), 735 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/flow_dissector.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/l4lb_all.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/obj_name.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/reference_tracking.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/signal_pending.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tcp_estats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
new file mode 100644
index 000000000000..a64f7a02139c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_bpf_obj_id(void)
+{
+	const __u64 array_magic_value = 0xfaceb00c;
+	const __u32 array_key = 0;
+	const int nr_iters = 2;
+	const char *file = "./test_obj_id.o";
+	const char *expected_prog_name = "test_obj_id";
+	const char *expected_map_name = "test_map_id";
+	const __u64 nsec_per_sec = 1000000000;
+
+	struct bpf_object *objs[nr_iters];
+	int prog_fds[nr_iters], map_fds[nr_iters];
+	/* +1 to test for the info_len returned by kernel */
+	struct bpf_prog_info prog_infos[nr_iters + 1];
+	struct bpf_map_info map_infos[nr_iters + 1];
+	/* Each prog only uses one map. +1 to test nr_map_ids
+	 * returned by kernel.
+	 */
+	__u32 map_ids[nr_iters + 1];
+	char jited_insns[128], xlated_insns[128], zeros[128];
+	__u32 i, next_id, info_len, nr_id_found, duration = 0;
+	struct timespec real_time_ts, boot_time_ts;
+	int err = 0;
+	__u64 array_value;
+	uid_t my_uid = getuid();
+	time_t now, load_time;
+
+	err = bpf_prog_get_fd_by_id(0);
+	CHECK(err >= 0 || errno != ENOENT,
+	      "get-fd-by-notexist-prog-id", "err %d errno %d\n", err, errno);
+
+	err = bpf_map_get_fd_by_id(0);
+	CHECK(err >= 0 || errno != ENOENT,
+	      "get-fd-by-notexist-map-id", "err %d errno %d\n", err, errno);
+
+	for (i = 0; i < nr_iters; i++)
+		objs[i] = NULL;
+
+	/* Check bpf_obj_get_info_by_fd() */
+	bzero(zeros, sizeof(zeros));
+	for (i = 0; i < nr_iters; i++) {
+		now = time(NULL);
+		err = bpf_prog_load(file, BPF_PROG_TYPE_SOCKET_FILTER,
+				    &objs[i], &prog_fds[i]);
+		/* test_obj_id.o is a dumb prog. It should never fail
+		 * to load.
+		 */
+		if (err)
+			error_cnt++;
+		assert(!err);
+
+		/* Insert a magic value to the map */
+		map_fds[i] = bpf_find_map(__func__, objs[i], "test_map_id");
+		assert(map_fds[i] >= 0);
+		err = bpf_map_update_elem(map_fds[i], &array_key,
+					  &array_magic_value, 0);
+		assert(!err);
+
+		/* Check getting map info */
+		info_len = sizeof(struct bpf_map_info) * 2;
+		bzero(&map_infos[i], info_len);
+		err = bpf_obj_get_info_by_fd(map_fds[i], &map_infos[i],
+					     &info_len);
+		if (CHECK(err ||
+			  map_infos[i].type != BPF_MAP_TYPE_ARRAY ||
+			  map_infos[i].key_size != sizeof(__u32) ||
+			  map_infos[i].value_size != sizeof(__u64) ||
+			  map_infos[i].max_entries != 1 ||
+			  map_infos[i].map_flags != 0 ||
+			  info_len != sizeof(struct bpf_map_info) ||
+			  strcmp((char *)map_infos[i].name, expected_map_name),
+			  "get-map-info(fd)",
+			  "err %d errno %d type %d(%d) info_len %u(%Zu) key_size %u value_size %u max_entries %u map_flags %X name %s(%s)\n",
+			  err, errno,
+			  map_infos[i].type, BPF_MAP_TYPE_ARRAY,
+			  info_len, sizeof(struct bpf_map_info),
+			  map_infos[i].key_size,
+			  map_infos[i].value_size,
+			  map_infos[i].max_entries,
+			  map_infos[i].map_flags,
+			  map_infos[i].name, expected_map_name))
+			goto done;
+
+		/* Check getting prog info */
+		info_len = sizeof(struct bpf_prog_info) * 2;
+		bzero(&prog_infos[i], info_len);
+		bzero(jited_insns, sizeof(jited_insns));
+		bzero(xlated_insns, sizeof(xlated_insns));
+		prog_infos[i].jited_prog_insns = ptr_to_u64(jited_insns);
+		prog_infos[i].jited_prog_len = sizeof(jited_insns);
+		prog_infos[i].xlated_prog_insns = ptr_to_u64(xlated_insns);
+		prog_infos[i].xlated_prog_len = sizeof(xlated_insns);
+		prog_infos[i].map_ids = ptr_to_u64(map_ids + i);
+		prog_infos[i].nr_map_ids = 2;
+		err = clock_gettime(CLOCK_REALTIME, &real_time_ts);
+		assert(!err);
+		err = clock_gettime(CLOCK_BOOTTIME, &boot_time_ts);
+		assert(!err);
+		err = bpf_obj_get_info_by_fd(prog_fds[i], &prog_infos[i],
+					     &info_len);
+		load_time = (real_time_ts.tv_sec - boot_time_ts.tv_sec)
+			+ (prog_infos[i].load_time / nsec_per_sec);
+		if (CHECK(err ||
+			  prog_infos[i].type != BPF_PROG_TYPE_SOCKET_FILTER ||
+			  info_len != sizeof(struct bpf_prog_info) ||
+			  (jit_enabled && !prog_infos[i].jited_prog_len) ||
+			  (jit_enabled &&
+			   !memcmp(jited_insns, zeros, sizeof(zeros))) ||
+			  !prog_infos[i].xlated_prog_len ||
+			  !memcmp(xlated_insns, zeros, sizeof(zeros)) ||
+			  load_time < now - 60 || load_time > now + 60 ||
+			  prog_infos[i].created_by_uid != my_uid ||
+			  prog_infos[i].nr_map_ids != 1 ||
+			  *(int *)(long)prog_infos[i].map_ids != map_infos[i].id ||
+			  strcmp((char *)prog_infos[i].name, expected_prog_name),
+			  "get-prog-info(fd)",
+			  "err %d errno %d i %d type %d(%d) info_len %u(%Zu) jit_enabled %d jited_prog_len %u xlated_prog_len %u jited_prog %d xlated_prog %d load_time %lu(%lu) uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) name %s(%s)\n",
+			  err, errno, i,
+			  prog_infos[i].type, BPF_PROG_TYPE_SOCKET_FILTER,
+			  info_len, sizeof(struct bpf_prog_info),
+			  jit_enabled,
+			  prog_infos[i].jited_prog_len,
+			  prog_infos[i].xlated_prog_len,
+			  !!memcmp(jited_insns, zeros, sizeof(zeros)),
+			  !!memcmp(xlated_insns, zeros, sizeof(zeros)),
+			  load_time, now,
+			  prog_infos[i].created_by_uid, my_uid,
+			  prog_infos[i].nr_map_ids, 1,
+			  *(int *)(long)prog_infos[i].map_ids, map_infos[i].id,
+			  prog_infos[i].name, expected_prog_name))
+			goto done;
+	}
+
+	/* Check bpf_prog_get_next_id() */
+	nr_id_found = 0;
+	next_id = 0;
+	while (!bpf_prog_get_next_id(next_id, &next_id)) {
+		struct bpf_prog_info prog_info = {};
+		__u32 saved_map_id;
+		int prog_fd;
+
+		info_len = sizeof(prog_info);
+
+		prog_fd = bpf_prog_get_fd_by_id(next_id);
+		if (prog_fd < 0 && errno == ENOENT)
+			/* The bpf_prog is in the dead row */
+			continue;
+		if (CHECK(prog_fd < 0, "get-prog-fd(next_id)",
+			  "prog_fd %d next_id %d errno %d\n",
+			  prog_fd, next_id, errno))
+			break;
+
+		for (i = 0; i < nr_iters; i++)
+			if (prog_infos[i].id == next_id)
+				break;
+
+		if (i == nr_iters)
+			continue;
+
+		nr_id_found++;
+
+		/* Negative test:
+		 * prog_info.nr_map_ids = 1
+		 * prog_info.map_ids = NULL
+		 */
+		prog_info.nr_map_ids = 1;
+		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+		if (CHECK(!err || errno != EFAULT,
+			  "get-prog-fd-bad-nr-map-ids", "err %d errno %d(%d)",
+			  err, errno, EFAULT))
+			break;
+		bzero(&prog_info, sizeof(prog_info));
+		info_len = sizeof(prog_info);
+
+		saved_map_id = *(int *)((long)prog_infos[i].map_ids);
+		prog_info.map_ids = prog_infos[i].map_ids;
+		prog_info.nr_map_ids = 2;
+		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+		prog_infos[i].jited_prog_insns = 0;
+		prog_infos[i].xlated_prog_insns = 0;
+		CHECK(err || info_len != sizeof(struct bpf_prog_info) ||
+		      memcmp(&prog_info, &prog_infos[i], info_len) ||
+		      *(int *)(long)prog_info.map_ids != saved_map_id,
+		      "get-prog-info(next_id->fd)",
+		      "err %d errno %d info_len %u(%Zu) memcmp %d map_id %u(%u)\n",
+		      err, errno, info_len, sizeof(struct bpf_prog_info),
+		      memcmp(&prog_info, &prog_infos[i], info_len),
+		      *(int *)(long)prog_info.map_ids, saved_map_id);
+		close(prog_fd);
+	}
+	CHECK(nr_id_found != nr_iters,
+	      "check total prog id found by get_next_id",
+	      "nr_id_found %u(%u)\n",
+	      nr_id_found, nr_iters);
+
+	/* Check bpf_map_get_next_id() */
+	nr_id_found = 0;
+	next_id = 0;
+	while (!bpf_map_get_next_id(next_id, &next_id)) {
+		struct bpf_map_info map_info = {};
+		int map_fd;
+
+		info_len = sizeof(map_info);
+
+		map_fd = bpf_map_get_fd_by_id(next_id);
+		if (map_fd < 0 && errno == ENOENT)
+			/* The bpf_map is in the dead row */
+			continue;
+		if (CHECK(map_fd < 0, "get-map-fd(next_id)",
+			  "map_fd %d next_id %u errno %d\n",
+			  map_fd, next_id, errno))
+			break;
+
+		for (i = 0; i < nr_iters; i++)
+			if (map_infos[i].id == next_id)
+				break;
+
+		if (i == nr_iters)
+			continue;
+
+		nr_id_found++;
+
+		err = bpf_map_lookup_elem(map_fd, &array_key, &array_value);
+		assert(!err);
+
+		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
+		CHECK(err || info_len != sizeof(struct bpf_map_info) ||
+		      memcmp(&map_info, &map_infos[i], info_len) ||
+		      array_value != array_magic_value,
+		      "check get-map-info(next_id->fd)",
+		      "err %d errno %d info_len %u(%Zu) memcmp %d array_value %llu(%llu)\n",
+		      err, errno, info_len, sizeof(struct bpf_map_info),
+		      memcmp(&map_info, &map_infos[i], info_len),
+		      array_value, array_magic_value);
+
+		close(map_fd);
+	}
+	CHECK(nr_id_found != nr_iters,
+	      "check total map id found by get_next_id",
+	      "nr_id_found %u(%u)\n",
+	      nr_id_found, nr_iters);
+
+done:
+	for (i = 0; i < nr_iters; i++)
+		bpf_object__close(objs[i]);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
new file mode 100644
index 000000000000..bcbd928c96ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+#define CHECK_FLOW_KEYS(desc, got, expected)				\
+	CHECK(memcmp(&got, &expected, sizeof(got)) != 0,		\
+	      desc,							\
+	      "nhoff=%u/%u "						\
+	      "thoff=%u/%u "						\
+	      "addr_proto=0x%x/0x%x "					\
+	      "is_frag=%u/%u "						\
+	      "is_first_frag=%u/%u "					\
+	      "is_encap=%u/%u "						\
+	      "n_proto=0x%x/0x%x "					\
+	      "sport=%u/%u "						\
+	      "dport=%u/%u\n",						\
+	      got.nhoff, expected.nhoff,				\
+	      got.thoff, expected.thoff,				\
+	      got.addr_proto, expected.addr_proto,			\
+	      got.is_frag, expected.is_frag,				\
+	      got.is_first_frag, expected.is_first_frag,		\
+	      got.is_encap, expected.is_encap,				\
+	      got.n_proto, expected.n_proto,				\
+	      got.sport, expected.sport,				\
+	      got.dport, expected.dport)
+
+static struct bpf_flow_keys pkt_v4_flow_keys = {
+	.nhoff = 0,
+	.thoff = sizeof(struct iphdr),
+	.addr_proto = ETH_P_IP,
+	.ip_proto = IPPROTO_TCP,
+	.n_proto = __bpf_constant_htons(ETH_P_IP),
+};
+
+static struct bpf_flow_keys pkt_v6_flow_keys = {
+	.nhoff = 0,
+	.thoff = sizeof(struct ipv6hdr),
+	.addr_proto = ETH_P_IPV6,
+	.ip_proto = IPPROTO_TCP,
+	.n_proto = __bpf_constant_htons(ETH_P_IPV6),
+};
+
+void test_flow_dissector(void)
+{
+	struct bpf_flow_keys flow_keys;
+	struct bpf_object *obj;
+	__u32 duration, retval;
+	int err, prog_fd;
+	__u32 size;
+
+	err = bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
+			    "jmp_table", &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
+				&flow_keys, &size, &retval, &duration);
+	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv4",
+	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+	CHECK_FLOW_KEYS("ipv4_flow_keys", flow_keys, pkt_v4_flow_keys);
+
+	err = bpf_prog_test_run(prog_fd, 10, &pkt_v6, sizeof(pkt_v6),
+				&flow_keys, &size, &retval, &duration);
+	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv6",
+	      "err %d errno %d retval %d duration %d size %u/%lu\n",
+	      err, errno, retval, duration, size, sizeof(flow_keys));
+	CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/l4lb_all.c b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
new file mode 100644
index 000000000000..20ddca830e68
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/l4lb_all.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static void test_l4lb(const char *file)
+{
+	unsigned int nr_cpus = bpf_num_possible_cpus();
+	struct vip key = {.protocol = 6};
+	struct vip_meta {
+		__u32 flags;
+		__u32 vip_num;
+	} value = {.vip_num = VIP_NUM};
+	__u32 stats_key = VIP_NUM;
+	struct vip_stats {
+		__u64 bytes;
+		__u64 pkts;
+	} stats[nr_cpus];
+	struct real_definition {
+		union {
+			__be32 dst;
+			__be32 dstv6[4];
+		};
+		__u8 flags;
+	} real_def = {.dst = MAGIC_VAL};
+	__u32 ch_key = 11, real_num = 3;
+	__u32 duration, retval, size;
+	int err, i, prog_fd, map_fd;
+	__u64 bytes = 0, pkts = 0;
+	struct bpf_object *obj;
+	char buf[128];
+	u32 *magic = (u32 *)buf;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	map_fd = bpf_find_map(__func__, obj, "vip_map");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &key, &value, 0);
+
+	map_fd = bpf_find_map(__func__, obj, "ch_rings");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &ch_key, &real_num, 0);
+
+	map_fd = bpf_find_map(__func__, obj, "reals");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_update_elem(map_fd, &real_num, &real_def, 0);
+
+	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 54 ||
+	      *magic != MAGIC_VAL, "ipv4",
+	      "err %d errno %d retval %d size %d magic %x\n",
+	      err, errno, retval, size, *magic);
+
+	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 74 ||
+	      *magic != MAGIC_VAL, "ipv6",
+	      "err %d errno %d retval %d size %d magic %x\n",
+	      err, errno, retval, size, *magic);
+
+	map_fd = bpf_find_map(__func__, obj, "stats");
+	if (map_fd < 0)
+		goto out;
+	bpf_map_lookup_elem(map_fd, &stats_key, stats);
+	for (i = 0; i < nr_cpus; i++) {
+		bytes += stats[i].bytes;
+		pkts += stats[i].pkts;
+	}
+	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
+		error_cnt++;
+		printf("test_l4lb:FAIL:stats %lld %lld\n", bytes, pkts);
+	}
+out:
+	bpf_object__close(obj);
+}
+
+void test_l4lb_all(void)
+{
+	const char *file1 = "./test_l4lb.o";
+	const char *file2 = "./test_l4lb_noinline.o";
+
+	test_l4lb(file1);
+	test_l4lb(file2);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/obj_name.c b/tools/testing/selftests/bpf/prog_tests/obj_name.c
new file mode 100644
index 000000000000..e178416bddad
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/obj_name.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_obj_name(void)
+{
+	struct {
+		const char *name;
+		int success;
+		int expected_errno;
+	} tests[] = {
+		{ "", 1, 0 },
+		{ "_123456789ABCDE", 1, 0 },
+		{ "_123456789ABCDEF", 0, EINVAL },
+		{ "_123456789ABCD\n", 0, EINVAL },
+	};
+	struct bpf_insn prog[] = {
+		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	__u32 duration = 0;
+	int i;
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		size_t name_len = strlen(tests[i].name) + 1;
+		union bpf_attr attr;
+		size_t ncopy;
+		int fd;
+
+		/* test different attr.prog_name during BPF_PROG_LOAD */
+		ncopy = name_len < sizeof(attr.prog_name) ?
+			name_len : sizeof(attr.prog_name);
+		bzero(&attr, sizeof(attr));
+		attr.prog_type = BPF_PROG_TYPE_SCHED_CLS;
+		attr.insn_cnt = 2;
+		attr.insns = ptr_to_u64(prog);
+		attr.license = ptr_to_u64("");
+		memcpy(attr.prog_name, tests[i].name, ncopy);
+
+		fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
+		CHECK((tests[i].success && fd < 0) ||
+		      (!tests[i].success && fd != -1) ||
+		      (!tests[i].success && errno != tests[i].expected_errno),
+		      "check-bpf-prog-name",
+		      "fd %d(%d) errno %d(%d)\n",
+		       fd, tests[i].success, errno, tests[i].expected_errno);
+
+		if (fd != -1)
+			close(fd);
+
+		/* test different attr.map_name during BPF_MAP_CREATE */
+		ncopy = name_len < sizeof(attr.map_name) ?
+			name_len : sizeof(attr.map_name);
+		bzero(&attr, sizeof(attr));
+		attr.map_type = BPF_MAP_TYPE_ARRAY;
+		attr.key_size = 4;
+		attr.value_size = 4;
+		attr.max_entries = 1;
+		attr.map_flags = 0;
+		memcpy(attr.map_name, tests[i].name, ncopy);
+		fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
+		CHECK((tests[i].success && fd < 0) ||
+		      (!tests[i].success && fd != -1) ||
+		      (!tests[i].success && errno != tests[i].expected_errno),
+		      "check-bpf-map-name",
+		      "fd %d(%d) errno %d(%d)\n",
+		      fd, tests[i].success, errno, tests[i].expected_errno);
+
+		if (fd != -1)
+			close(fd);
+	}
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
new file mode 100644
index 000000000000..5dd89b941f53
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_run_xattr.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_prog_run_xattr(void)
+{
+	const char *file = "./test_pkt_access.o";
+	struct bpf_object *obj;
+	char buf[10];
+	int err;
+	struct bpf_prog_test_run_attr tattr = {
+		.repeat = 1,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.data_out = buf,
+		.data_size_out = 5,
+	};
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj,
+			    &tattr.prog_fd);
+	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
+		return;
+
+	memset(buf, 0, sizeof(buf));
+
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err != -1 || errno != ENOSPC || tattr.retval, "run",
+	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
+
+	CHECK_ATTR(tattr.data_size_out != sizeof(pkt_v4), "data_size_out",
+	      "incorrect output size, want %lu have %u\n",
+	      sizeof(pkt_v4), tattr.data_size_out);
+
+	CHECK_ATTR(buf[5] != 0, "overflow",
+	      "BPF_PROG_TEST_RUN ignored size hint\n");
+
+	tattr.data_out = NULL;
+	tattr.data_size_out = 0;
+	errno = 0;
+
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err || errno || tattr.retval, "run_no_output",
+	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
+
+	tattr.data_size_out = 1;
+	err = bpf_prog_test_run_xattr(&tattr);
+	CHECK_ATTR(err != -EINVAL, "run_wrong_size_out", "err %d\n", err);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
new file mode 100644
index 000000000000..e60cd5ff1f55
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+enum {
+	QUEUE,
+	STACK,
+};
+
+static void test_queue_stack_map_by_type(int type)
+{
+	const int MAP_SIZE = 32;
+	__u32 vals[MAP_SIZE], duration, retval, size, val;
+	int i, err, prog_fd, map_in_fd, map_out_fd;
+	char file[32], buf[128];
+	struct bpf_object *obj;
+	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
+
+	/* Fill test values to be used */
+	for (i = 0; i < MAP_SIZE; i++)
+		vals[i] = rand();
+
+	if (type == QUEUE)
+		strncpy(file, "./test_queue_map.o", sizeof(file));
+	else if (type == STACK)
+		strncpy(file, "./test_stack_map.o", sizeof(file));
+	else
+		return;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	map_in_fd = bpf_find_map(__func__, obj, "map_in");
+	if (map_in_fd < 0)
+		goto out;
+
+	map_out_fd = bpf_find_map(__func__, obj, "map_out");
+	if (map_out_fd < 0)
+		goto out;
+
+	/* Push 32 elements to the input map */
+	for (i = 0; i < MAP_SIZE; i++) {
+		err = bpf_map_update_elem(map_in_fd, NULL, &vals[i], 0);
+		if (err) {
+			error_cnt++;
+			goto out;
+		}
+	}
+
+	/* The eBPF program pushes iph.saddr in the output map,
+	 * pops the input map and saves this value in iph.daddr
+	 */
+	for (i = 0; i < MAP_SIZE; i++) {
+		if (type == QUEUE) {
+			val = vals[i];
+			pkt_v4.iph.saddr = vals[i] * 5;
+		} else if (type == STACK) {
+			val = vals[MAP_SIZE - 1 - i];
+			pkt_v4.iph.saddr = vals[MAP_SIZE - 1 - i] * 5;
+		}
+
+		err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+					buf, &size, &retval, &duration);
+		if (err || retval || size != sizeof(pkt_v4) ||
+		    iph->daddr != val)
+			break;
+	}
+
+	CHECK(err || retval || size != sizeof(pkt_v4) || iph->daddr != val,
+	      "bpf_map_pop_elem",
+	      "err %d errno %d retval %d size %d iph->daddr %u\n",
+	      err, errno, retval, size, iph->daddr);
+
+	/* Queue is empty, program should return TC_ACT_SHOT */
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				buf, &size, &retval, &duration);
+	CHECK(err || retval != 2 /* TC_ACT_SHOT */|| size != sizeof(pkt_v4),
+	      "check-queue-stack-map-empty",
+	      "err %d errno %d retval %d size %d\n",
+	      err, errno, retval, size);
+
+	/* Check that the program pushed elements correctly */
+	for (i = 0; i < MAP_SIZE; i++) {
+		err = bpf_map_lookup_and_delete_elem(map_out_fd, NULL, &val);
+		if (err || val != vals[i] * 5)
+			break;
+	}
+
+	CHECK(i != MAP_SIZE && (err || val != vals[i] * 5),
+	      "bpf_map_push_elem", "err %d value %u\n", err, val);
+
+out:
+	pkt_v4.iph.saddr = 0;
+	bpf_object__close(obj);
+}
+
+void test_queue_stack_map(void)
+{
+	test_queue_stack_map_by_type(QUEUE);
+	test_queue_stack_map_by_type(STACK);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
new file mode 100644
index 000000000000..5633be43828f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static int libbpf_debug_print(enum libbpf_print_level level,
+			      const char *format, va_list args)
+{
+	if (level == LIBBPF_DEBUG)
+		return 0;
+
+	return vfprintf(stderr, format, args);
+}
+
+void test_reference_tracking(void)
+{
+	const char *file = "./test_sk_lookup_kern.o";
+	struct bpf_object *obj;
+	struct bpf_program *prog;
+	__u32 duration = 0;
+	int err = 0;
+
+	obj = bpf_object__open(file);
+	if (IS_ERR(obj)) {
+		error_cnt++;
+		return;
+	}
+
+	bpf_object__for_each_program(prog, obj) {
+		const char *title;
+
+		/* Ignore .text sections */
+		title = bpf_program__title(prog, false);
+		if (strstr(title, ".text") != NULL)
+			continue;
+
+		bpf_program__set_type(prog, BPF_PROG_TYPE_SCHED_CLS);
+
+		/* Expect verifier failure if test name has 'fail' */
+		if (strstr(title, "fail") != NULL) {
+			libbpf_set_print(NULL);
+			err = !bpf_program__load(prog, "GPL", 0);
+			libbpf_set_print(libbpf_debug_print);
+		} else {
+			err = bpf_program__load(prog, "GPL", 0);
+		}
+		CHECK(err, title, "\n");
+	}
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/signal_pending.c b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
new file mode 100644
index 000000000000..f2a37bbf91ab
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/signal_pending.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static void sigalrm_handler(int s) {}
+static struct sigaction sigalrm_action = {
+	.sa_handler = sigalrm_handler,
+};
+
+static void test_signal_pending_by_type(enum bpf_prog_type prog_type)
+{
+	struct bpf_insn prog[4096];
+	struct itimerval timeo = {
+		.it_value.tv_usec = 100000, /* 100ms */
+	};
+	__u32 duration, retval;
+	int prog_fd;
+	int err;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(prog); i++)
+		prog[i] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
+	prog[ARRAY_SIZE(prog) - 1] = BPF_EXIT_INSN();
+
+	prog_fd = bpf_load_program(prog_type, prog, ARRAY_SIZE(prog),
+				   "GPL", 0, NULL, 0);
+	CHECK(prog_fd < 0, "test-run", "errno %d\n", errno);
+
+	err = sigaction(SIGALRM, &sigalrm_action, NULL);
+	CHECK(err, "test-run-signal-sigaction", "errno %d\n", errno);
+
+	err = setitimer(ITIMER_REAL, &timeo, NULL);
+	CHECK(err, "test-run-signal-timer", "errno %d\n", errno);
+
+	err = bpf_prog_test_run(prog_fd, 0xffffffff, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(duration > 500000000, /* 500ms */
+	      "test-run-signal-duration",
+	      "duration %dns > 500ms\n",
+	      duration);
+
+	signal(SIGALRM, SIG_DFL);
+}
+
+void test_signal_pending(enum bpf_prog_type prog_type)
+{
+	test_signal_pending_by_type(BPF_PROG_TYPE_SOCKET_FILTER);
+	test_signal_pending_by_type(BPF_PROG_TYPE_FLOW_DISSECTOR);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_estats.c b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
new file mode 100644
index 000000000000..bb8759d69099
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tcp_estats.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+void test_tcp_estats(void)
+{
+	const char *file = "./test_tcp_estats.o";
+	int err, prog_fd;
+	struct bpf_object *obj;
+	__u32 duration = 0;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
+	CHECK(err, "", "err %d errno %d\n", err, errno);
+	if (err) {
+		error_cnt++;
+		return;
+	}
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 02f460ea0e60..9d33a0684643 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -39,163 +39,6 @@ int bpf_find_map(const char *test, struct bpf_object *obj, const char *name)
 	return bpf_map__fd(map);
 }
 
-static void test_prog_run_xattr(void)
-{
-	const char *file = "./test_pkt_access.o";
-	struct bpf_object *obj;
-	char buf[10];
-	int err;
-	struct bpf_prog_test_run_attr tattr = {
-		.repeat = 1,
-		.data_in = &pkt_v4,
-		.data_size_in = sizeof(pkt_v4),
-		.data_out = buf,
-		.data_size_out = 5,
-	};
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj,
-			    &tattr.prog_fd);
-	if (CHECK_ATTR(err, "load", "err %d errno %d\n", err, errno))
-		return;
-
-	memset(buf, 0, sizeof(buf));
-
-	err = bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err != -1 || errno != ENOSPC || tattr.retval, "run",
-	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
-
-	CHECK_ATTR(tattr.data_size_out != sizeof(pkt_v4), "data_size_out",
-	      "incorrect output size, want %lu have %u\n",
-	      sizeof(pkt_v4), tattr.data_size_out);
-
-	CHECK_ATTR(buf[5] != 0, "overflow",
-	      "BPF_PROG_TEST_RUN ignored size hint\n");
-
-	tattr.data_out = NULL;
-	tattr.data_size_out = 0;
-	errno = 0;
-
-	err = bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err || errno || tattr.retval, "run_no_output",
-	      "err %d errno %d retval %d\n", err, errno, tattr.retval);
-
-	tattr.data_size_out = 1;
-	err = bpf_prog_test_run_xattr(&tattr);
-	CHECK_ATTR(err != -EINVAL, "run_wrong_size_out", "err %d\n", err);
-
-	bpf_object__close(obj);
-}
-
-static void test_l4lb(const char *file)
-{
-	unsigned int nr_cpus = bpf_num_possible_cpus();
-	struct vip key = {.protocol = 6};
-	struct vip_meta {
-		__u32 flags;
-		__u32 vip_num;
-	} value = {.vip_num = VIP_NUM};
-	__u32 stats_key = VIP_NUM;
-	struct vip_stats {
-		__u64 bytes;
-		__u64 pkts;
-	} stats[nr_cpus];
-	struct real_definition {
-		union {
-			__be32 dst;
-			__be32 dstv6[4];
-		};
-		__u8 flags;
-	} real_def = {.dst = MAGIC_VAL};
-	__u32 ch_key = 11, real_num = 3;
-	__u32 duration, retval, size;
-	int err, i, prog_fd, map_fd;
-	__u64 bytes = 0, pkts = 0;
-	struct bpf_object *obj;
-	char buf[128];
-	u32 *magic = (u32 *)buf;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	map_fd = bpf_find_map(__func__, obj, "vip_map");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &key, &value, 0);
-
-	map_fd = bpf_find_map(__func__, obj, "ch_rings");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &ch_key, &real_num, 0);
-
-	map_fd = bpf_find_map(__func__, obj, "reals");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_update_elem(map_fd, &real_num, &real_def, 0);
-
-	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 54 ||
-	      *magic != MAGIC_VAL, "ipv4",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
-
-	err = bpf_prog_test_run(prog_fd, NUM_ITER, &pkt_v6, sizeof(pkt_v6),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != 7/*TC_ACT_REDIRECT*/ || size != 74 ||
-	      *magic != MAGIC_VAL, "ipv6",
-	      "err %d errno %d retval %d size %d magic %x\n",
-	      err, errno, retval, size, *magic);
-
-	map_fd = bpf_find_map(__func__, obj, "stats");
-	if (map_fd < 0)
-		goto out;
-	bpf_map_lookup_elem(map_fd, &stats_key, stats);
-	for (i = 0; i < nr_cpus; i++) {
-		bytes += stats[i].bytes;
-		pkts += stats[i].pkts;
-	}
-	if (bytes != MAGIC_BYTES * NUM_ITER * 2 || pkts != NUM_ITER * 2) {
-		error_cnt++;
-		printf("test_l4lb:FAIL:stats %lld %lld\n", bytes, pkts);
-	}
-out:
-	bpf_object__close(obj);
-}
-
-static void test_l4lb_all(void)
-{
-	const char *file1 = "./test_l4lb.o";
-	const char *file2 = "./test_l4lb_noinline.o";
-
-	test_l4lb(file1);
-	test_l4lb(file2);
-}
-
-static void test_tcp_estats(void)
-{
-	const char *file = "./test_tcp_estats.o";
-	int err, prog_fd;
-	struct bpf_object *obj;
-	__u32 duration = 0;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	CHECK(err, "", "err %d errno %d\n", err, errno);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	bpf_object__close(obj);
-}
-
-static inline __u64 ptr_to_u64(const void *ptr)
-{
-	return (__u64) (unsigned long) ptr;
-}
-
 static bool is_jit_enabled(void)
 {
 	const char *jit_sysctl = "/proc/sys/net/core/bpf_jit_enable";
@@ -214,322 +57,6 @@ static bool is_jit_enabled(void)
 	return enabled;
 }
 
-static void test_bpf_obj_id(void)
-{
-	const __u64 array_magic_value = 0xfaceb00c;
-	const __u32 array_key = 0;
-	const int nr_iters = 2;
-	const char *file = "./test_obj_id.o";
-	const char *expected_prog_name = "test_obj_id";
-	const char *expected_map_name = "test_map_id";
-	const __u64 nsec_per_sec = 1000000000;
-
-	struct bpf_object *objs[nr_iters];
-	int prog_fds[nr_iters], map_fds[nr_iters];
-	/* +1 to test for the info_len returned by kernel */
-	struct bpf_prog_info prog_infos[nr_iters + 1];
-	struct bpf_map_info map_infos[nr_iters + 1];
-	/* Each prog only uses one map. +1 to test nr_map_ids
-	 * returned by kernel.
-	 */
-	__u32 map_ids[nr_iters + 1];
-	char jited_insns[128], xlated_insns[128], zeros[128];
-	__u32 i, next_id, info_len, nr_id_found, duration = 0;
-	struct timespec real_time_ts, boot_time_ts;
-	int err = 0;
-	__u64 array_value;
-	uid_t my_uid = getuid();
-	time_t now, load_time;
-
-	err = bpf_prog_get_fd_by_id(0);
-	CHECK(err >= 0 || errno != ENOENT,
-	      "get-fd-by-notexist-prog-id", "err %d errno %d\n", err, errno);
-
-	err = bpf_map_get_fd_by_id(0);
-	CHECK(err >= 0 || errno != ENOENT,
-	      "get-fd-by-notexist-map-id", "err %d errno %d\n", err, errno);
-
-	for (i = 0; i < nr_iters; i++)
-		objs[i] = NULL;
-
-	/* Check bpf_obj_get_info_by_fd() */
-	bzero(zeros, sizeof(zeros));
-	for (i = 0; i < nr_iters; i++) {
-		now = time(NULL);
-		err = bpf_prog_load(file, BPF_PROG_TYPE_SOCKET_FILTER,
-				    &objs[i], &prog_fds[i]);
-		/* test_obj_id.o is a dumb prog. It should never fail
-		 * to load.
-		 */
-		if (err)
-			error_cnt++;
-		assert(!err);
-
-		/* Insert a magic value to the map */
-		map_fds[i] = bpf_find_map(__func__, objs[i], "test_map_id");
-		assert(map_fds[i] >= 0);
-		err = bpf_map_update_elem(map_fds[i], &array_key,
-					  &array_magic_value, 0);
-		assert(!err);
-
-		/* Check getting map info */
-		info_len = sizeof(struct bpf_map_info) * 2;
-		bzero(&map_infos[i], info_len);
-		err = bpf_obj_get_info_by_fd(map_fds[i], &map_infos[i],
-					     &info_len);
-		if (CHECK(err ||
-			  map_infos[i].type != BPF_MAP_TYPE_ARRAY ||
-			  map_infos[i].key_size != sizeof(__u32) ||
-			  map_infos[i].value_size != sizeof(__u64) ||
-			  map_infos[i].max_entries != 1 ||
-			  map_infos[i].map_flags != 0 ||
-			  info_len != sizeof(struct bpf_map_info) ||
-			  strcmp((char *)map_infos[i].name, expected_map_name),
-			  "get-map-info(fd)",
-			  "err %d errno %d type %d(%d) info_len %u(%Zu) key_size %u value_size %u max_entries %u map_flags %X name %s(%s)\n",
-			  err, errno,
-			  map_infos[i].type, BPF_MAP_TYPE_ARRAY,
-			  info_len, sizeof(struct bpf_map_info),
-			  map_infos[i].key_size,
-			  map_infos[i].value_size,
-			  map_infos[i].max_entries,
-			  map_infos[i].map_flags,
-			  map_infos[i].name, expected_map_name))
-			goto done;
-
-		/* Check getting prog info */
-		info_len = sizeof(struct bpf_prog_info) * 2;
-		bzero(&prog_infos[i], info_len);
-		bzero(jited_insns, sizeof(jited_insns));
-		bzero(xlated_insns, sizeof(xlated_insns));
-		prog_infos[i].jited_prog_insns = ptr_to_u64(jited_insns);
-		prog_infos[i].jited_prog_len = sizeof(jited_insns);
-		prog_infos[i].xlated_prog_insns = ptr_to_u64(xlated_insns);
-		prog_infos[i].xlated_prog_len = sizeof(xlated_insns);
-		prog_infos[i].map_ids = ptr_to_u64(map_ids + i);
-		prog_infos[i].nr_map_ids = 2;
-		err = clock_gettime(CLOCK_REALTIME, &real_time_ts);
-		assert(!err);
-		err = clock_gettime(CLOCK_BOOTTIME, &boot_time_ts);
-		assert(!err);
-		err = bpf_obj_get_info_by_fd(prog_fds[i], &prog_infos[i],
-					     &info_len);
-		load_time = (real_time_ts.tv_sec - boot_time_ts.tv_sec)
-			+ (prog_infos[i].load_time / nsec_per_sec);
-		if (CHECK(err ||
-			  prog_infos[i].type != BPF_PROG_TYPE_SOCKET_FILTER ||
-			  info_len != sizeof(struct bpf_prog_info) ||
-			  (jit_enabled && !prog_infos[i].jited_prog_len) ||
-			  (jit_enabled &&
-			   !memcmp(jited_insns, zeros, sizeof(zeros))) ||
-			  !prog_infos[i].xlated_prog_len ||
-			  !memcmp(xlated_insns, zeros, sizeof(zeros)) ||
-			  load_time < now - 60 || load_time > now + 60 ||
-			  prog_infos[i].created_by_uid != my_uid ||
-			  prog_infos[i].nr_map_ids != 1 ||
-			  *(int *)(long)prog_infos[i].map_ids != map_infos[i].id ||
-			  strcmp((char *)prog_infos[i].name, expected_prog_name),
-			  "get-prog-info(fd)",
-			  "err %d errno %d i %d type %d(%d) info_len %u(%Zu) jit_enabled %d jited_prog_len %u xlated_prog_len %u jited_prog %d xlated_prog %d load_time %lu(%lu) uid %u(%u) nr_map_ids %u(%u) map_id %u(%u) name %s(%s)\n",
-			  err, errno, i,
-			  prog_infos[i].type, BPF_PROG_TYPE_SOCKET_FILTER,
-			  info_len, sizeof(struct bpf_prog_info),
-			  jit_enabled,
-			  prog_infos[i].jited_prog_len,
-			  prog_infos[i].xlated_prog_len,
-			  !!memcmp(jited_insns, zeros, sizeof(zeros)),
-			  !!memcmp(xlated_insns, zeros, sizeof(zeros)),
-			  load_time, now,
-			  prog_infos[i].created_by_uid, my_uid,
-			  prog_infos[i].nr_map_ids, 1,
-			  *(int *)(long)prog_infos[i].map_ids, map_infos[i].id,
-			  prog_infos[i].name, expected_prog_name))
-			goto done;
-	}
-
-	/* Check bpf_prog_get_next_id() */
-	nr_id_found = 0;
-	next_id = 0;
-	while (!bpf_prog_get_next_id(next_id, &next_id)) {
-		struct bpf_prog_info prog_info = {};
-		__u32 saved_map_id;
-		int prog_fd;
-
-		info_len = sizeof(prog_info);
-
-		prog_fd = bpf_prog_get_fd_by_id(next_id);
-		if (prog_fd < 0 && errno == ENOENT)
-			/* The bpf_prog is in the dead row */
-			continue;
-		if (CHECK(prog_fd < 0, "get-prog-fd(next_id)",
-			  "prog_fd %d next_id %d errno %d\n",
-			  prog_fd, next_id, errno))
-			break;
-
-		for (i = 0; i < nr_iters; i++)
-			if (prog_infos[i].id == next_id)
-				break;
-
-		if (i == nr_iters)
-			continue;
-
-		nr_id_found++;
-
-		/* Negative test:
-		 * prog_info.nr_map_ids = 1
-		 * prog_info.map_ids = NULL
-		 */
-		prog_info.nr_map_ids = 1;
-		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
-		if (CHECK(!err || errno != EFAULT,
-			  "get-prog-fd-bad-nr-map-ids", "err %d errno %d(%d)",
-			  err, errno, EFAULT))
-			break;
-		bzero(&prog_info, sizeof(prog_info));
-		info_len = sizeof(prog_info);
-
-		saved_map_id = *(int *)((long)prog_infos[i].map_ids);
-		prog_info.map_ids = prog_infos[i].map_ids;
-		prog_info.nr_map_ids = 2;
-		err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
-		prog_infos[i].jited_prog_insns = 0;
-		prog_infos[i].xlated_prog_insns = 0;
-		CHECK(err || info_len != sizeof(struct bpf_prog_info) ||
-		      memcmp(&prog_info, &prog_infos[i], info_len) ||
-		      *(int *)(long)prog_info.map_ids != saved_map_id,
-		      "get-prog-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%Zu) memcmp %d map_id %u(%u)\n",
-		      err, errno, info_len, sizeof(struct bpf_prog_info),
-		      memcmp(&prog_info, &prog_infos[i], info_len),
-		      *(int *)(long)prog_info.map_ids, saved_map_id);
-		close(prog_fd);
-	}
-	CHECK(nr_id_found != nr_iters,
-	      "check total prog id found by get_next_id",
-	      "nr_id_found %u(%u)\n",
-	      nr_id_found, nr_iters);
-
-	/* Check bpf_map_get_next_id() */
-	nr_id_found = 0;
-	next_id = 0;
-	while (!bpf_map_get_next_id(next_id, &next_id)) {
-		struct bpf_map_info map_info = {};
-		int map_fd;
-
-		info_len = sizeof(map_info);
-
-		map_fd = bpf_map_get_fd_by_id(next_id);
-		if (map_fd < 0 && errno == ENOENT)
-			/* The bpf_map is in the dead row */
-			continue;
-		if (CHECK(map_fd < 0, "get-map-fd(next_id)",
-			  "map_fd %d next_id %u errno %d\n",
-			  map_fd, next_id, errno))
-			break;
-
-		for (i = 0; i < nr_iters; i++)
-			if (map_infos[i].id == next_id)
-				break;
-
-		if (i == nr_iters)
-			continue;
-
-		nr_id_found++;
-
-		err = bpf_map_lookup_elem(map_fd, &array_key, &array_value);
-		assert(!err);
-
-		err = bpf_obj_get_info_by_fd(map_fd, &map_info, &info_len);
-		CHECK(err || info_len != sizeof(struct bpf_map_info) ||
-		      memcmp(&map_info, &map_infos[i], info_len) ||
-		      array_value != array_magic_value,
-		      "check get-map-info(next_id->fd)",
-		      "err %d errno %d info_len %u(%Zu) memcmp %d array_value %llu(%llu)\n",
-		      err, errno, info_len, sizeof(struct bpf_map_info),
-		      memcmp(&map_info, &map_infos[i], info_len),
-		      array_value, array_magic_value);
-
-		close(map_fd);
-	}
-	CHECK(nr_id_found != nr_iters,
-	      "check total map id found by get_next_id",
-	      "nr_id_found %u(%u)\n",
-	      nr_id_found, nr_iters);
-
-done:
-	for (i = 0; i < nr_iters; i++)
-		bpf_object__close(objs[i]);
-}
-
-static void test_obj_name(void)
-{
-	struct {
-		const char *name;
-		int success;
-		int expected_errno;
-	} tests[] = {
-		{ "", 1, 0 },
-		{ "_123456789ABCDE", 1, 0 },
-		{ "_123456789ABCDEF", 0, EINVAL },
-		{ "_123456789ABCD\n", 0, EINVAL },
-	};
-	struct bpf_insn prog[] = {
-		BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
-		BPF_EXIT_INSN(),
-	};
-	__u32 duration = 0;
-	int i;
-
-	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
-		size_t name_len = strlen(tests[i].name) + 1;
-		union bpf_attr attr;
-		size_t ncopy;
-		int fd;
-
-		/* test different attr.prog_name during BPF_PROG_LOAD */
-		ncopy = name_len < sizeof(attr.prog_name) ?
-			name_len : sizeof(attr.prog_name);
-		bzero(&attr, sizeof(attr));
-		attr.prog_type = BPF_PROG_TYPE_SCHED_CLS;
-		attr.insn_cnt = 2;
-		attr.insns = ptr_to_u64(prog);
-		attr.license = ptr_to_u64("");
-		memcpy(attr.prog_name, tests[i].name, ncopy);
-
-		fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
-		CHECK((tests[i].success && fd < 0) ||
-		      (!tests[i].success && fd != -1) ||
-		      (!tests[i].success && errno != tests[i].expected_errno),
-		      "check-bpf-prog-name",
-		      "fd %d(%d) errno %d(%d)\n",
-		       fd, tests[i].success, errno, tests[i].expected_errno);
-
-		if (fd != -1)
-			close(fd);
-
-		/* test different attr.map_name during BPF_MAP_CREATE */
-		ncopy = name_len < sizeof(attr.map_name) ?
-			name_len : sizeof(attr.map_name);
-		bzero(&attr, sizeof(attr));
-		attr.map_type = BPF_MAP_TYPE_ARRAY;
-		attr.key_size = 4;
-		attr.value_size = 4;
-		attr.max_entries = 1;
-		attr.map_flags = 0;
-		memcpy(attr.map_name, tests[i].name, ncopy);
-		fd = syscall(__NR_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
-		CHECK((tests[i].success && fd < 0) ||
-		      (!tests[i].success && fd != -1) ||
-		      (!tests[i].success && errno != tests[i].expected_errno),
-		      "check-bpf-map-name",
-		      "fd %d(%d) errno %d(%d)\n",
-		      fd, tests[i].success, errno, tests[i].expected_errno);
-
-		if (fd != -1)
-			close(fd);
-	}
-}
-
 int compare_map_keys(int map1_fd, int map2_fd)
 {
 	__u32 key, next_key;
@@ -617,217 +144,6 @@ int extract_build_id(char *build_id, size_t size)
 	return -1;
 }
 
-static int libbpf_debug_print(enum libbpf_print_level level,
-			      const char *format, va_list args)
-{
-	if (level == LIBBPF_DEBUG)
-		return 0;
-
-	return vfprintf(stderr, format, args);
-}
-
-static void test_reference_tracking()
-{
-	const char *file = "./test_sk_lookup_kern.o";
-	struct bpf_object *obj;
-	struct bpf_program *prog;
-	__u32 duration = 0;
-	int err = 0;
-
-	obj = bpf_object__open(file);
-	if (IS_ERR(obj)) {
-		error_cnt++;
-		return;
-	}
-
-	bpf_object__for_each_program(prog, obj) {
-		const char *title;
-
-		/* Ignore .text sections */
-		title = bpf_program__title(prog, false);
-		if (strstr(title, ".text") != NULL)
-			continue;
-
-		bpf_program__set_type(prog, BPF_PROG_TYPE_SCHED_CLS);
-
-		/* Expect verifier failure if test name has 'fail' */
-		if (strstr(title, "fail") != NULL) {
-			libbpf_set_print(NULL);
-			err = !bpf_program__load(prog, "GPL", 0);
-			libbpf_set_print(libbpf_debug_print);
-		} else {
-			err = bpf_program__load(prog, "GPL", 0);
-		}
-		CHECK(err, title, "\n");
-	}
-	bpf_object__close(obj);
-}
-
-enum {
-	QUEUE,
-	STACK,
-};
-
-static void test_queue_stack_map(int type)
-{
-	const int MAP_SIZE = 32;
-	__u32 vals[MAP_SIZE], duration, retval, size, val;
-	int i, err, prog_fd, map_in_fd, map_out_fd;
-	char file[32], buf[128];
-	struct bpf_object *obj;
-	struct iphdr *iph = (void *)buf + sizeof(struct ethhdr);
-
-	/* Fill test values to be used */
-	for (i = 0; i < MAP_SIZE; i++)
-		vals[i] = rand();
-
-	if (type == QUEUE)
-		strncpy(file, "./test_queue_map.o", sizeof(file));
-	else if (type == STACK)
-		strncpy(file, "./test_stack_map.o", sizeof(file));
-	else
-		return;
-
-	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	map_in_fd = bpf_find_map(__func__, obj, "map_in");
-	if (map_in_fd < 0)
-		goto out;
-
-	map_out_fd = bpf_find_map(__func__, obj, "map_out");
-	if (map_out_fd < 0)
-		goto out;
-
-	/* Push 32 elements to the input map */
-	for (i = 0; i < MAP_SIZE; i++) {
-		err = bpf_map_update_elem(map_in_fd, NULL, &vals[i], 0);
-		if (err) {
-			error_cnt++;
-			goto out;
-		}
-	}
-
-	/* The eBPF program pushes iph.saddr in the output map,
-	 * pops the input map and saves this value in iph.daddr
-	 */
-	for (i = 0; i < MAP_SIZE; i++) {
-		if (type == QUEUE) {
-			val = vals[i];
-			pkt_v4.iph.saddr = vals[i] * 5;
-		} else if (type == STACK) {
-			val = vals[MAP_SIZE - 1 - i];
-			pkt_v4.iph.saddr = vals[MAP_SIZE - 1 - i] * 5;
-		}
-
-		err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-					buf, &size, &retval, &duration);
-		if (err || retval || size != sizeof(pkt_v4) ||
-		    iph->daddr != val)
-			break;
-	}
-
-	CHECK(err || retval || size != sizeof(pkt_v4) || iph->daddr != val,
-	      "bpf_map_pop_elem",
-	      "err %d errno %d retval %d size %d iph->daddr %u\n",
-	      err, errno, retval, size, iph->daddr);
-
-	/* Queue is empty, program should return TC_ACT_SHOT */
-	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
-				buf, &size, &retval, &duration);
-	CHECK(err || retval != 2 /* TC_ACT_SHOT */|| size != sizeof(pkt_v4),
-	      "check-queue-stack-map-empty",
-	      "err %d errno %d retval %d size %d\n",
-	      err, errno, retval, size);
-
-	/* Check that the program pushed elements correctly */
-	for (i = 0; i < MAP_SIZE; i++) {
-		err = bpf_map_lookup_and_delete_elem(map_out_fd, NULL, &val);
-		if (err || val != vals[i] * 5)
-			break;
-	}
-
-	CHECK(i != MAP_SIZE && (err || val != vals[i] * 5),
-	      "bpf_map_push_elem", "err %d value %u\n", err, val);
-
-out:
-	pkt_v4.iph.saddr = 0;
-	bpf_object__close(obj);
-}
-
-#define CHECK_FLOW_KEYS(desc, got, expected)				\
-	CHECK(memcmp(&got, &expected, sizeof(got)) != 0,		\
-	      desc,							\
-	      "nhoff=%u/%u "						\
-	      "thoff=%u/%u "						\
-	      "addr_proto=0x%x/0x%x "					\
-	      "is_frag=%u/%u "						\
-	      "is_first_frag=%u/%u "					\
-	      "is_encap=%u/%u "						\
-	      "n_proto=0x%x/0x%x "					\
-	      "sport=%u/%u "						\
-	      "dport=%u/%u\n",						\
-	      got.nhoff, expected.nhoff,				\
-	      got.thoff, expected.thoff,				\
-	      got.addr_proto, expected.addr_proto,			\
-	      got.is_frag, expected.is_frag,				\
-	      got.is_first_frag, expected.is_first_frag,		\
-	      got.is_encap, expected.is_encap,				\
-	      got.n_proto, expected.n_proto,				\
-	      got.sport, expected.sport,				\
-	      got.dport, expected.dport)
-
-static struct bpf_flow_keys pkt_v4_flow_keys = {
-	.nhoff = 0,
-	.thoff = sizeof(struct iphdr),
-	.addr_proto = ETH_P_IP,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = bpf_htons(ETH_P_IP),
-};
-
-static struct bpf_flow_keys pkt_v6_flow_keys = {
-	.nhoff = 0,
-	.thoff = sizeof(struct ipv6hdr),
-	.addr_proto = ETH_P_IPV6,
-	.ip_proto = IPPROTO_TCP,
-	.n_proto = bpf_htons(ETH_P_IPV6),
-};
-
-static void test_flow_dissector(void)
-{
-	struct bpf_flow_keys flow_keys;
-	struct bpf_object *obj;
-	__u32 duration, retval;
-	int err, prog_fd;
-	__u32 size;
-
-	err = bpf_flow_load(&obj, "./bpf_flow.o", "flow_dissector",
-			    "jmp_table", &prog_fd);
-	if (err) {
-		error_cnt++;
-		return;
-	}
-
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_v4, sizeof(pkt_v4),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv4",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("ipv4_flow_keys", flow_keys, pkt_v4_flow_keys);
-
-	err = bpf_prog_test_run(prog_fd, 10, &pkt_v6, sizeof(pkt_v6),
-				&flow_keys, &size, &retval, &duration);
-	CHECK(size != sizeof(flow_keys) || err || retval != 1, "ipv6",
-	      "err %d errno %d retval %d duration %d size %u/%lu\n",
-	      err, errno, retval, duration, size, sizeof(flow_keys));
-	CHECK_FLOW_KEYS("ipv6_flow_keys", flow_keys, pkt_v6_flow_keys);
-
-	bpf_object__close(obj);
-}
-
 void *spin_lock_thread(void *arg)
 {
 	__u32 duration, retval;
@@ -841,46 +157,6 @@ void *spin_lock_thread(void *arg)
 	pthread_exit(arg);
 }
 
-static void sigalrm_handler(int s) {}
-static struct sigaction sigalrm_action = {
-	.sa_handler = sigalrm_handler,
-};
-
-static void test_signal_pending(enum bpf_prog_type prog_type)
-{
-	struct bpf_insn prog[4096];
-	struct itimerval timeo = {
-		.it_value.tv_usec = 100000, /* 100ms */
-	};
-	__u32 duration, retval;
-	int prog_fd;
-	int err;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(prog); i++)
-		prog[i] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0);
-	prog[ARRAY_SIZE(prog) - 1] = BPF_EXIT_INSN();
-
-	prog_fd = bpf_load_program(prog_type, prog, ARRAY_SIZE(prog),
-				   "GPL", 0, NULL, 0);
-	CHECK(prog_fd < 0, "test-run", "errno %d\n", errno);
-
-	err = sigaction(SIGALRM, &sigalrm_action, NULL);
-	CHECK(err, "test-run-signal-sigaction", "errno %d\n", errno);
-
-	err = setitimer(ITIMER_REAL, &timeo, NULL);
-	CHECK(err, "test-run-signal-timer", "errno %d\n", errno);
-
-	err = bpf_prog_test_run(prog_fd, 0xffffffff, &pkt_v4, sizeof(pkt_v4),
-				NULL, NULL, &retval, &duration);
-	CHECK(duration > 500000000, /* 500ms */
-	      "test-run-signal-duration",
-	      "duration %dns > 500ms\n",
-	      duration);
-
-	signal(SIGALRM, SIG_DFL);
-}
-
 #define DECLARE
 #include <prog_tests/tests.h>
 #undef DECLARE
@@ -894,17 +170,6 @@ int main(void)
 #define CALL
 #include <prog_tests/tests.h>
 #undef CALL
-	test_prog_run_xattr();
-	test_l4lb_all();
-	test_tcp_estats();
-	test_bpf_obj_id();
-	test_obj_name();
-	test_reference_tracking();
-	test_queue_stack_map(QUEUE);
-	test_queue_stack_map(STACK);
-	test_flow_dissector();
-	test_signal_pending(BPF_PROG_TYPE_SOCKET_FILTER);
-	test_signal_pending(BPF_PROG_TYPE_FLOW_DISSECTOR);
 
 	printf("Summary: %d PASSED, %d FAILED\n", pass_cnt, error_cnt);
 	return error_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 4cc473d9a69b..f2aeb410bdf5 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -82,6 +82,11 @@ extern struct ipv6_packet pkt_v6;
 #define NUM_ITER 100000
 #define VIP_NUM 5
 
+static inline __u64 ptr_to_u64(const void *ptr)
+{
+	return (__u64) (unsigned long) ptr;
+}
+
 int bpf_find_map(const char *test, struct bpf_object *obj, const char *name);
 int compare_map_keys(int map1_fd, int map2_fd);
 int compare_stack_ips(int smap_fd, int amap_fd, int stack_trace_len);
-- 
2.21.0.rc2.261.ga7da99ff1b-goog

