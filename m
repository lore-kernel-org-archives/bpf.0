Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD125C10F00
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E292075B
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfB1XTQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:19:16 -0500
Received: from www62.your-server.de ([213.133.104.62]:52350 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbfB1XTM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:19:12 -0500
Received: from [178.197.248.21] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzUxF-0000mr-5b; Fri, 01 Mar 2019 00:19:05 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     ast@fb.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch, yhs@fb.com,
        andriin@fb.com, jakub.kicinski@netronome.com, lmb@cloudflare.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v2 6/7] bpf, selftest: test global data/bss/rodata sections
Date:   Fri,  1 Mar 2019 00:18:28 +0100
Message-Id: <20190228231829.11993-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190228231829.11993-1-daniel@iogearbox.net>
References: <20190228231829.11993-1-daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Stringer <joe@wand.net.nz>

Add tests for libbpf relocation of static variable references
into the .data, .rodata and .bss sections of the ELF. Tests with
different offsets are all passing:

  # ./test_progs
  [...]
  test_static_data_access:PASS:load program 0 nsec
  test_static_data_access:PASS:pass packet 278 nsec
  test_static_data_access:PASS:relocate .bss reference 1 278 nsec
  test_static_data_access:PASS:relocate .data reference 1 278 nsec
  test_static_data_access:PASS:relocate .rodata reference 1 278 nsec
  test_static_data_access:PASS:relocate .bss reference 2 278 nsec
  test_static_data_access:PASS:relocate .data reference 2 278 nsec
  test_static_data_access:PASS:relocate .rodata reference 2 278 nsec
  test_static_data_access:PASS:relocate .bss reference 3 278 nsec
  test_static_data_access:PASS:relocate .bss reference 4 278 nsec
  Summary: 223 PASSED, 0 FAILED

Joint work with Daniel Borkmann.

Signed-off-by: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/testing/selftests/bpf/bpf_helpers.h     |  2 +-
 .../selftests/bpf/progs/test_global_data.c    | 61 +++++++++++++++++++
 tools/testing/selftests/bpf/test_progs.c      | 50 +++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index d9999f1ed1d2..0463662935f9 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -11,7 +11,7 @@
 /* helper functions called from eBPF programs written in C */
 static void *(*bpf_map_lookup_elem)(void *map, void *key) =
 	(void *) BPF_FUNC_map_lookup_elem;
-static int (*bpf_map_update_elem)(void *map, void *key, void *value,
+static int (*bpf_map_update_elem)(void *map, const void *key, const void *value,
 				  unsigned long long flags) =
 	(void *) BPF_FUNC_map_update_elem;
 static int (*bpf_map_delete_elem)(void *map, void *key) =
diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
new file mode 100644
index 000000000000..2a7cf40b8efb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_data.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Isovalent, Inc.
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <string.h>
+
+#include "bpf_helpers.h"
+
+struct bpf_map_def SEC("maps") result = {
+	.type		= BPF_MAP_TYPE_ARRAY,
+	.key_size	= sizeof(__u32),
+	.value_size	= sizeof(__u64),
+	.max_entries	= 9,
+};
+
+static       __u64 static_bss     = 0;		/* Reloc reference to .bss  section   */
+static       __u64 static_data    = 42;		/* Reloc reference to .data section   */
+static const __u64 static_rodata  = 24;		/* Reloc reference to .rodata section */
+static       __u64 static_bss2    = 0;		/* Reloc reference to .bss  section   */
+static       __u64 static_data2   = 0xffeeff;	/* Reloc reference to .data section   */
+static const __u64 static_rodata2 = 0xabab;	/* Reloc reference to .rodata section */
+static const __u64 static_rodata3 = 0xab;	/* Reloc reference to .rodata section */
+
+SEC("static_data_load")
+int load_static_data(struct __sk_buff *skb)
+{
+	__u32 key;
+
+	key = 0;
+	bpf_map_update_elem(&result, &key, &static_bss, 0);
+
+	key = 1;
+	bpf_map_update_elem(&result, &key, &static_data, 0);
+
+	key = 2;
+	bpf_map_update_elem(&result, &key, &static_rodata, 0);
+
+	key = 3;
+	bpf_map_update_elem(&result, &key, &static_bss2, 0);
+
+	key = 4;
+	bpf_map_update_elem(&result, &key, &static_data2, 0);
+
+	key = 5;
+	bpf_map_update_elem(&result, &key, &static_rodata2, 0);
+
+	key = 6;
+	static_bss2 = 1234;
+	bpf_map_update_elem(&result, &key, &static_bss2, 0);
+
+	key = 7;
+	bpf_map_update_elem(&result, &key, &static_bss, 0);
+
+	key = 8;
+	bpf_map_update_elem(&result, &key, &static_rodata3, 0);
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index c59d2e015d16..a3e64c054572 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -738,6 +738,55 @@ static void test_pkt_md_access(void)
 	bpf_object__close(obj);
 }
 
+static void test_static_data_access(void)
+{
+	const char *file = "./test_global_data.o";
+	struct bpf_object *obj;
+	__u32 duration = 0, retval;
+	int i, err, prog_fd, map_fd;
+	uint64_t value;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (CHECK(err, "load program", "error %d loading %s\n", err, file))
+		return;
+
+	map_fd = bpf_find_map(__func__, obj, "result");
+	if (map_fd < 0) {
+		error_cnt++;
+		goto close_prog;
+	}
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "pass packet",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	struct {
+		char *name;
+		uint32_t key;
+		uint64_t value;
+	} tests[] = {
+		{ "relocate .bss reference 1",    0, 0 },
+		{ "relocate .data reference 1",   1, 42 },
+		{ "relocate .rodata reference 1", 2, 24 },
+		{ "relocate .bss reference 2",    3, 0 },
+		{ "relocate .data reference 2",   4, 0xffeeff },
+		{ "relocate .rodata reference 2", 5, 0xabab },
+		{ "relocate .bss reference 3",    6, 1234 },
+		{ "relocate .bss reference 4",    7, 0 },
+	};
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		err = bpf_map_lookup_elem(map_fd, &tests[i].key, &value);
+		CHECK (err || value != tests[i].value, tests[i].name,
+		       "err %d result %lu expected %lu\n",
+		       err, value, tests[i].value);
+	}
+
+close_prog:
+	bpf_object__close(obj);
+}
+
 static void test_obj_name(void)
 {
 	struct {
@@ -2182,6 +2231,7 @@ int main(void)
 	test_map_lock();
 	test_signal_pending(BPF_PROG_TYPE_SOCKET_FILTER);
 	test_signal_pending(BPF_PROG_TYPE_FLOW_DISSECTOR);
+	test_static_data_access();
 
 	printf("Summary: %d PASSED, %d FAILED\n", pass_cnt, error_cnt);
 	return error_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.17.1

