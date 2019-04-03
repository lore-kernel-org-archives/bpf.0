Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74389C10F0D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E842133D
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 18:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfDCSXf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:23:35 -0400
Received: from www62.your-server.de ([213.133.104.62]:55468 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfDCSXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 14:23:34 -0400
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBkXo-0006Eb-Al; Wed, 03 Apr 2019 20:23:28 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, joe@wand.net.nz, yhs@fb.com,
        andrii.nakryiko@gmail.com, kafai@fb.com,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 14/15] bpf, selftest: test global data/bss/rodata sections
Date:   Wed,  3 Apr 2019 20:23:05 +0200
Message-Id: <8c340799694aef7861089798b3ff31691d80dee7.1554314902.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
In-Reply-To: <cover.1554314902.git.daniel@iogearbox.net>
References: <cover.1554314902.git.daniel@iogearbox.net>
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25408/Wed Apr  3 09:53:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Joe Stringer <joe@wand.net.nz>

Add tests for libbpf relocation of static variable references
into the .data, .rodata and .bss sections of the ELF, also add
read-only test for .rodata. All passing:

  # ./test_progs
  [...]
  test_global_data:PASS:load program 0 nsec
  test_global_data:PASS:pass global data run 925 nsec
  test_global_data_number:PASS:relocate .bss reference 925 nsec
  test_global_data_number:PASS:relocate .data reference 925 nsec
  test_global_data_number:PASS:relocate .rodata reference 925 nsec
  test_global_data_number:PASS:relocate .bss reference 925 nsec
  test_global_data_number:PASS:relocate .data reference 925 nsec
  test_global_data_number:PASS:relocate .rodata reference 925 nsec
  test_global_data_number:PASS:relocate .bss reference 925 nsec
  test_global_data_number:PASS:relocate .bss reference 925 nsec
  test_global_data_number:PASS:relocate .rodata reference 925 nsec
  test_global_data_number:PASS:relocate .rodata reference 925 nsec
  test_global_data_number:PASS:relocate .rodata reference 925 nsec
  test_global_data_string:PASS:relocate .rodata reference 925 nsec
  test_global_data_string:PASS:relocate .data reference 925 nsec
  test_global_data_string:PASS:relocate .bss reference 925 nsec
  test_global_data_string:PASS:relocate .data reference 925 nsec
  test_global_data_string:PASS:relocate .bss reference 925 nsec
  test_global_data_struct:PASS:relocate .rodata reference 925 nsec
  test_global_data_struct:PASS:relocate .bss reference 925 nsec
  test_global_data_struct:PASS:relocate .rodata reference 925 nsec
  test_global_data_struct:PASS:relocate .data reference 925 nsec
  test_global_data_rdonly:PASS:test .rodata read-only map 925 nsec
  [...]
  Summary: 229 PASSED, 0 FAILED

Note map helper signatures have been changed to avoid warnings
when passing in const data.

Joint work with Daniel Borkmann.

Signed-off-by: Joe Stringer <joe@wand.net.nz>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/testing/selftests/bpf/bpf_helpers.h          |   8 +-
 .../testing/selftests/bpf/prog_tests/global_data.c | 157 +++++++++++++++++++++
 .../testing/selftests/bpf/progs/test_global_data.c | 106 ++++++++++++++
 3 files changed, 267 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/global_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c

diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
index 97d1409..e85d62c 100644
--- a/tools/testing/selftests/bpf/bpf_helpers.h
+++ b/tools/testing/selftests/bpf/bpf_helpers.h
@@ -9,14 +9,14 @@
 #define SEC(NAME) __attribute__((section(NAME), used))
 
 /* helper functions called from eBPF programs written in C */
-static void *(*bpf_map_lookup_elem)(void *map, void *key) =
+static void *(*bpf_map_lookup_elem)(void *map, const void *key) =
 	(void *) BPF_FUNC_map_lookup_elem;
-static int (*bpf_map_update_elem)(void *map, void *key, void *value,
+static int (*bpf_map_update_elem)(void *map, const void *key, const void *value,
 				  unsigned long long flags) =
 	(void *) BPF_FUNC_map_update_elem;
-static int (*bpf_map_delete_elem)(void *map, void *key) =
+static int (*bpf_map_delete_elem)(void *map, const void *key) =
 	(void *) BPF_FUNC_map_delete_elem;
-static int (*bpf_map_push_elem)(void *map, void *value,
+static int (*bpf_map_push_elem)(void *map, const void *value,
 				unsigned long long flags) =
 	(void *) BPF_FUNC_map_push_elem;
 static int (*bpf_map_pop_elem)(void *map, void *value) =
diff --git a/tools/testing/selftests/bpf/prog_tests/global_data.c b/tools/testing/selftests/bpf/prog_tests/global_data.c
new file mode 100644
index 0000000..d011079
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/global_data.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+
+static void test_global_data_number(struct bpf_object *obj, __u32 duration)
+{
+	int i, err, map_fd;
+	uint64_t num;
+
+	map_fd = bpf_find_map(__func__, obj, "result_number");
+	if (map_fd < 0) {
+		error_cnt++;
+		return;
+	}
+
+	struct {
+		char *name;
+		uint32_t key;
+		uint64_t num;
+	} tests[] = {
+		{ "relocate .bss reference",     0, 0 },
+		{ "relocate .data reference",    1, 42 },
+		{ "relocate .rodata reference",  2, 24 },
+		{ "relocate .bss reference",     3, 0 },
+		{ "relocate .data reference",    4, 0xffeeff },
+		{ "relocate .rodata reference",  5, 0xabab },
+		{ "relocate .bss reference",     6, 1234 },
+		{ "relocate .bss reference",     7, 0 },
+		{ "relocate .rodata reference",  8, 0xab },
+		{ "relocate .rodata reference",  9, 0x1111111111111111 },
+		{ "relocate .rodata reference", 10, ~0 },
+	};
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		err = bpf_map_lookup_elem(map_fd, &tests[i].key, &num);
+		CHECK(err || num != tests[i].num, tests[i].name,
+		      "err %d result %lx expected %lx\n",
+		      err, num, tests[i].num);
+	}
+}
+
+static void test_global_data_string(struct bpf_object *obj, __u32 duration)
+{
+	int i, err, map_fd;
+	char str[32];
+
+	map_fd = bpf_find_map(__func__, obj, "result_string");
+	if (map_fd < 0) {
+		error_cnt++;
+		return;
+	}
+
+	struct {
+		char *name;
+		uint32_t key;
+		char str[32];
+	} tests[] = {
+		{ "relocate .rodata reference", 0, "abcdefghijklmnopqrstuvwxyz" },
+		{ "relocate .data reference",   1, "abcdefghijklmnopqrstuvwxyz" },
+		{ "relocate .bss reference",    2, "" },
+		{ "relocate .data reference",   3, "abcdexghijklmnopqrstuvwxyz" },
+		{ "relocate .bss reference",    4, "\0\0hello" },
+	};
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		err = bpf_map_lookup_elem(map_fd, &tests[i].key, str);
+		CHECK(err || memcmp(str, tests[i].str, sizeof(str)),
+		      tests[i].name, "err %d result \'%s\' expected \'%s\'\n",
+		      err, str, tests[i].str);
+	}
+}
+
+struct foo {
+	__u8  a;
+	__u32 b;
+	__u64 c;
+};
+
+static void test_global_data_struct(struct bpf_object *obj, __u32 duration)
+{
+	int i, err, map_fd;
+	struct foo val;
+
+	map_fd = bpf_find_map(__func__, obj, "result_struct");
+	if (map_fd < 0) {
+		error_cnt++;
+		return;
+	}
+
+	struct {
+		char *name;
+		uint32_t key;
+		struct foo val;
+	} tests[] = {
+		{ "relocate .rodata reference", 0, { 42, 0xfefeefef, 0x1111111111111111ULL, } },
+		{ "relocate .bss reference",    1, { } },
+		{ "relocate .rodata reference", 2, { } },
+		{ "relocate .data reference",   3, { 41, 0xeeeeefef, 0x2111111111111111ULL, } },
+	};
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		err = bpf_map_lookup_elem(map_fd, &tests[i].key, &val);
+		CHECK(err || memcmp(&val, &tests[i].val, sizeof(val)),
+		      tests[i].name, "err %d result { %u, %u, %llu } expected { %u, %u, %llu }\n",
+		      err, val.a, val.b, val.c, tests[i].val.a, tests[i].val.b, tests[i].val.c);
+	}
+}
+
+static void test_global_data_rdonly(struct bpf_object *obj, __u32 duration)
+{
+	int err = -ENOMEM, map_fd, zero = 0;
+	struct bpf_map *map;
+	__u8 *buff;
+
+	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
+	if (!map || !bpf_map__is_internal(map)) {
+		error_cnt++;
+		return;
+	}
+
+	map_fd = bpf_map__fd(map);
+	if (map_fd < 0) {
+		error_cnt++;
+		return;
+	}
+
+	buff = malloc(bpf_map__def(map)->value_size);
+	if (buff)
+		err = bpf_map_update_elem(map_fd, &zero, buff, 0);
+	free(buff);
+	CHECK(!err || errno != EPERM, "test .rodata read-only map",
+	      "err %d errno %d\n", err, errno);
+}
+
+void test_global_data(void)
+{
+	const char *file = "./test_global_data.o";
+	__u32 duration = 0, retval;
+	struct bpf_object *obj;
+	int err, prog_fd;
+
+	err = bpf_prog_load(file, BPF_PROG_TYPE_SCHED_CLS, &obj, &prog_fd);
+	if (CHECK(err, "load program", "error %d loading %s\n", err, file))
+		return;
+
+	err = bpf_prog_test_run(prog_fd, 1, &pkt_v4, sizeof(pkt_v4),
+				NULL, NULL, &retval, &duration);
+	CHECK(err || retval, "pass global data run",
+	      "err %d errno %d retval %d duration %d\n",
+	      err, errno, retval, duration);
+
+	test_global_data_number(obj, duration);
+	test_global_data_string(obj, duration);
+	test_global_data_struct(obj, duration);
+	test_global_data_rdonly(obj, duration);
+
+	bpf_object__close(obj);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
new file mode 100644
index 0000000..5ab14e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_data.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Isovalent, Inc.
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <string.h>
+
+#include "bpf_helpers.h"
+
+struct bpf_map_def SEC("maps") result_number = {
+	.type		= BPF_MAP_TYPE_ARRAY,
+	.key_size	= sizeof(__u32),
+	.value_size	= sizeof(__u64),
+	.max_entries	= 11,
+};
+
+struct bpf_map_def SEC("maps") result_string = {
+	.type		= BPF_MAP_TYPE_ARRAY,
+	.key_size	= sizeof(__u32),
+	.value_size	= 32,
+	.max_entries	= 5,
+};
+
+struct foo {
+	__u8  a;
+	__u32 b;
+	__u64 c;
+};
+
+struct bpf_map_def SEC("maps") result_struct = {
+	.type		= BPF_MAP_TYPE_ARRAY,
+	.key_size	= sizeof(__u32),
+	.value_size	= sizeof(struct foo),
+	.max_entries	= 5,
+};
+
+/* Relocation tests for __u64s. */
+static       __u64 num0;
+static       __u64 num1 = 42;
+static const __u64 num2 = 24;
+static       __u64 num3 = 0;
+static       __u64 num4 = 0xffeeff;
+static const __u64 num5 = 0xabab;
+static const __u64 num6 = 0xab;
+
+/* Relocation tests for strings. */
+static const char str0[32] = "abcdefghijklmnopqrstuvwxyz";
+static       char str1[32] = "abcdefghijklmnopqrstuvwxyz";
+static       char str2[32];
+
+/* Relocation tests for structs. */
+static const struct foo struct0 = {
+	.a = 42,
+	.b = 0xfefeefef,
+	.c = 0x1111111111111111ULL,
+};
+static struct foo struct1;
+static const struct foo struct2;
+static struct foo struct3 = {
+	.a = 41,
+	.b = 0xeeeeefef,
+	.c = 0x2111111111111111ULL,
+};
+
+#define test_reloc(map, num, var)					\
+	do {								\
+		__u32 key = num;					\
+		bpf_map_update_elem(&result_##map, &key, var, 0);	\
+	} while (0)
+
+SEC("static_data_load")
+int load_static_data(struct __sk_buff *skb)
+{
+	static const __u64 bar = ~0;
+
+	test_reloc(number, 0, &num0);
+	test_reloc(number, 1, &num1);
+	test_reloc(number, 2, &num2);
+	test_reloc(number, 3, &num3);
+	test_reloc(number, 4, &num4);
+	test_reloc(number, 5, &num5);
+	num4 = 1234;
+	test_reloc(number, 6, &num4);
+	test_reloc(number, 7, &num0);
+	test_reloc(number, 8, &num6);
+
+	test_reloc(string, 0, str0);
+	test_reloc(string, 1, str1);
+	test_reloc(string, 2, str2);
+	str1[5] = 'x';
+	test_reloc(string, 3, str1);
+	__builtin_memcpy(&str2[2], "hello", sizeof("hello"));
+	test_reloc(string, 4, str2);
+
+	test_reloc(struct, 0, &struct0);
+	test_reloc(struct, 1, &struct1);
+	test_reloc(struct, 2, &struct2);
+	test_reloc(struct, 3, &struct3);
+
+	test_reloc(number,  9, &struct0.c);
+	test_reloc(number, 10, &bar);
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.9.5

