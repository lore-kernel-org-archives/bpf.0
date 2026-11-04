Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822091;
	b=S8t8+R/GO3IL9kl7VtI8MSWXoC1hYC4dv9h6B9dxH59BfeQn5eC1H4lLyosjSVynPfBd
	 ajXiwHM7kScKfWQFxZYd+UvjdXMJv0rbn3abWZBLLOPg9kncnyoyI/BhQdIcT6tNdVA2G
	 znmpV94kiqLjG6/9U13hdZNk3968r8LuMfvfhCMM/0phTGmf5pwF9yaPKQYKaFnESZgKG
	 7epxcHIc7T7+pozZ3Iaii33DsUFR9JS3pejk9QkzZbp3mZNoKb2Yy5/0DdycBCedM1y9C
	 B3yM4VygO+cx7hLswoMd5RFV8YF4kiEcm90sdbKaf3q3Yp3g2VjsuQ9GBglhfWhsyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822091;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=RuJing33sTSyr8nNw0srFM/fQ8v9tfQcK7zb7jIdo2o=;
	b=2NFdDtcbnMoLhgc124V60dEMdRn1wJ/rjpQbvxyoz+GtMr1LuykEVJU+kn2cHHGK6a7v
	 CZwKzNJiNRRSx2OH+/Pdu4rv0AjD3ihZJ2g7oasPTiW1h37CTyBAGXjpyeJvYn2wkqQxh
	 M4wh6mzsgyBViIs6YscJsdS4dFnett61JvpPGLIu1rUSa2SZQ1nL5PrWo3lJh8YmX6yQD
	 Iz+vGWYiOW8oi/Ef+JYHjAEb8q4UQgWCX4CVZNveiewiFT8PxEAkFt8XOdY5LvV/SyvTh
	 TK62tePipiBPhasSL82z5WHaaKPQx3c3UL/gWbDZQLj8O7UNPlFvaS9DWIIWqs/8M9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=er5WBXSy;
	arc=none smtp.remote-ip=198.54.127.128
Received: from out-2z4y-a128.jellyfish.systems (out-2z4y-a128.jellyfish.systems [198.54.127.128])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C26099A38
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 19:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87C26099A38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=er5WBXSy
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKbkG5Bhnz2x98;
	Wed, 04 Nov 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793822074;
	bh=RuJing33sTSyr8nNw0srFM/fQ8v9tfQcK7zb7jIdo2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=er5WBXSyGmiKEQR/BTtSMOXH+NQs+g+DYl1HoZqC0FqPcVu34FaUFXnr6p+IMbJLM
	 MUQCYqCboZieI6+uCzM3VBHlsP5rMZcgp5MsImxMrAKhNERDzQV3v5hmvvXNI6OjYw
	 /gtkNSyRkyR8yCirOaEBUQtbeZvQqk3PAlkBBgPbJrLO7UseVwF4UQr1DVmyt1Q8UK
	 AXhKa0xwB9E1Srch4MDhgXsKa1g8j+c5SEjki5LPhnVzyJ3FTIyCf607lN7v1/KOKO
	 Wk9dWwK8Koaj1vRBCX6qojFsYeZXTfwzqVxIVBOn1tVSrCpCe2Z7PCfxH+pdmabwrY
	 RXeHgXRmvqV+g==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	alexei.starovoitov@gmail.com
Subject: [PATCH bpf-next v9 2/2] selftests/bpf: Check bpftool batch map dumps
Date: Thu,  5 Nov 2026 04:54:13 +0900
Message-ID: <e4cd18723b893385d66232276f44049bb86c8e51.1793821981.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793821981.git.hi@tychen.cc>
References: <cover.1793821981.git.hi@tychen.cc>
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
X-Envelope-From: hi@tychen.cc

Batched dumps must print the same output as individual lookups. Use an
fmod_ret program on security_bpf() to count the map lookups made by
bpftool children of the test, and to fail batch lookups with -EBUSY.

For each map type with batched lookups, compare plain and JSON dumps
with a dump whose batch lookups all fail, and check that no individual
lookups were needed. Cover BTF and per-CPU output, an empty map, 1-byte
keys and unaligned values. With 4 KiB values, check dumps that need
several batches, and that failing the first or second batch lookup
continues with individual lookups without restarting the dump.

Pre-size RHASH maps so asynchronous growth does not race with the
order-sensitive dump comparisons.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_batch.c        | 231 ++++++++++++++++++
 .../selftests/bpf/progs/bpftool_map_batch.c   |  42 ++++
 2 files changed, 273 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_batch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
new file mode 100644
index 0000000000000..4cca77f410a06
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <arpa/inet.h>
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include "bpftool_helpers.h"
+#include "bpftool_map_batch.skel.h"
+
+/* Fits the plain and JSON dumps of the multi-batch cases below. */
+#define OUTPUT_SIZE (8U << 20)
+
+struct dump_case {
+	const char *name;
+	enum bpf_map_type type;
+	__u32 key_size;
+	__u32 value_size;
+	__u32 entries;
+	bool btf;
+	/* Values large enough that the 1 MiB budget needs several batches. */
+	bool multi_batch;
+};
+
+static bool is_percpu(enum bpf_map_type type)
+{
+	return type == BPF_MAP_TYPE_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_LRU_PERCPU_HASH ||
+	       type == BPF_MAP_TYPE_PERCPU_ARRAY;
+}
+
+static int run_dump(struct bpftool_map_batch *skel, __u32 id, bool json,
+		    int fail_batch, char *output)
+{
+	char command[64];
+	int err;
+
+	snprintf(command, sizeof(command), "%smap dump id %u",
+		 json ? "-j " : "", id);
+	skel->bss->fail_batch = fail_batch;
+	skel->bss->batch_calls = 0;
+	skel->bss->elem_calls = 0;
+	output[0] = '\0';
+	err = get_bpftool_command_output(command, output, OUTPUT_SIZE);
+	if (!ASSERT_LT(strlen(output), OUTPUT_SIZE - 1, "output_fits"))
+		return -1;
+	return err;
+}
+
+static void check_same(const char *output, const char *expected, const char *name)
+{
+	size_t i;
+
+	for (i = 0; output[i] && output[i] == expected[i]; i++)
+		;
+	if (!ASSERT_EQ(output[i], expected[i], name))
+		printf("%s: first difference at offset %zu\n", name, i);
+}
+
+/* Failing every batch lookup gives the dump of individual lookups. */
+static void check_dump(struct bpftool_map_batch *skel, const struct dump_case *test,
+		       __u32 id, bool json, char *expected, char *output)
+{
+	int fail;
+
+	if (!ASSERT_OK(run_dump(skel, id, json, -1, expected), "individual_dump") ||
+	    !ASSERT_EQ(skel->bss->elem_calls, test->entries, "individual_lookups"))
+		return;
+
+	if (!ASSERT_OK(run_dump(skel, id, json, 0, output), "batch_dump"))
+		return;
+	ASSERT_GE(skel->bss->batch_calls, test->multi_batch ? 2 : 1, "batch_calls");
+	ASSERT_EQ(skel->bss->elem_calls, 0, "batch_only");
+	check_same(output, expected, "batch_output");
+
+	if (!test->multi_batch)
+		return;
+	/* Fail before and after a batch has been printed. */
+	for (fail = 1; fail <= 2; fail++) {
+		if (!ASSERT_OK(run_dump(skel, id, json, fail, output), "fallback_dump"))
+			return;
+		ASSERT_EQ(skel->bss->batch_calls, fail, "fallback_batch_calls");
+		if (fail == 1) {
+			ASSERT_EQ(skel->bss->elem_calls, test->entries, "fallback_lookups");
+		} else {
+			ASSERT_GT(skel->bss->elem_calls, 0, "resumed_lookups");
+			ASSERT_LT(skel->bss->elem_calls, test->entries, "not_restarted");
+		}
+		check_same(output, expected, "fallback_output");
+	}
+}
+
+static void fill_bytes(void *buf, __u32 size, __u32 seed)
+{
+	__u8 *bytes = buf;
+	__u32 i;
+
+	for (i = 0; i < size; i++)
+		bytes[i] = seed * 37 + i;
+}
+
+static void run_case(struct bpftool_map_batch *skel, const struct dump_case *test,
+		     char *expected, char *output)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	int fd = -1, inner_fd = -1, cpus = 1, cpu;
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+	__u32 i, max_entries, stride;
+	struct btf *btf = NULL;
+	__u8 key[8] = {};
+	void *values = NULL;
+
+	if (is_percpu(test->type)) {
+		cpus = libbpf_num_possible_cpus();
+		if (!ASSERT_GT(cpus, 0, "possible_cpus"))
+			return;
+	}
+	stride = is_percpu(test->type) ? (test->value_size + 7) & ~7U : test->value_size;
+	values = calloc(cpus, stride);
+	if (!ASSERT_OK_PTR(values, "values"))
+		return;
+
+	if (test->btf) {
+		btf = btf__new_empty();
+		if (!ASSERT_OK_PTR(btf, "btf_new") ||
+		    !ASSERT_EQ(btf__add_int(btf, "unsigned int", 4, 0), 1, "btf_int") ||
+		    !ASSERT_OK(btf__load_into_kernel(btf), "btf_load"))
+			goto out;
+		opts.btf_fd = btf__fd(btf);
+		opts.btf_key_type_id = 1;
+		opts.btf_value_type_id = 1;
+	}
+	if (test->type == BPF_MAP_TYPE_ARRAY_OF_MAPS ||
+	    test->type == BPF_MAP_TYPE_HASH_OF_MAPS) {
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "batch_inner", 4, 4, 1, NULL);
+		if (!ASSERT_OK_FD(inner_fd, "inner_map"))
+			goto out;
+		opts.inner_map_fd = inner_fd;
+	}
+	if (test->type == BPF_MAP_TYPE_LPM_TRIE || test->type == BPF_MAP_TYPE_RHASH)
+		opts.map_flags = BPF_F_NO_PREALLOC;
+	max_entries = test->entries ?: 1;
+	/* Leave room for per-CPU LRU free lists instead of testing eviction. */
+	if (test->type == BPF_MAP_TYPE_LRU_HASH ||
+	    test->type == BPF_MAP_TYPE_LRU_PERCPU_HASH)
+		max_entries *= 4;
+	/* Avoid asynchronous growth during dump comparisons. */
+	if (test->type == BPF_MAP_TYPE_RHASH)
+		opts.map_extra = max_entries;
+
+	fd = bpf_map_create(test->type, "batch_dump", test->key_size,
+			    test->value_size, max_entries, &opts);
+	if (!ASSERT_OK_FD(fd, "map_create"))
+		goto out;
+	for (i = 0; i < test->entries; i++) {
+		if (test->type == BPF_MAP_TYPE_LPM_TRIE) {
+			__u32 prefix[] = { 32, htonl(i) };
+
+			memcpy(key, prefix, sizeof(prefix));
+		} else if (test->key_size == 1) {
+			key[0] = (__u8)i;
+		} else {
+			/* Array map indices use native byte order. */
+			memcpy(key, &i, sizeof(i));
+		}
+		if (inner_fd >= 0)
+			memcpy(values, &inner_fd, sizeof(inner_fd));
+		else
+			for (cpu = 0; cpu < cpus; cpu++)
+				fill_bytes(values + cpu * stride, test->value_size,
+					   i + cpu * 101);
+		if (!ASSERT_OK(bpf_map_update_elem(fd, key, values, BPF_ANY), "map_update"))
+			goto out;
+	}
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &len), "map_info"))
+		goto out;
+
+	check_dump(skel, test, info.id, false, expected, output);
+	check_dump(skel, test, info.id, true, expected, output);
+out:
+	if (fd >= 0)
+		close(fd);
+	if (inner_fd >= 0)
+		close(inner_fd);
+	btf__free(btf);
+	free(values);
+}
+
+void test_bpftool_map_batch(void)
+{
+	static const struct dump_case cases[] = {
+		{ "hash", BPF_MAP_TYPE_HASH, 4, 4, 100 },
+		{ "empty", BPF_MAP_TYPE_HASH, 4, 4, 0 },
+		/* The hash cursor is wider than the key; values are unaligned. */
+		{ "odd_sizes", BPF_MAP_TYPE_HASH, 1, 3, 100 },
+		{ "btf", BPF_MAP_TYPE_HASH, 4, 4, 100, true },
+		{ "lru_hash", BPF_MAP_TYPE_LRU_HASH, 4, 4, 100 },
+		{ "percpu_hash", BPF_MAP_TYPE_PERCPU_HASH, 4, 3, 100 },
+		{ "lru_percpu_hash", BPF_MAP_TYPE_LRU_PERCPU_HASH, 4, 4, 100 },
+		{ "btf_percpu_hash", BPF_MAP_TYPE_PERCPU_HASH, 4, 4, 100, true },
+		{ "rhash", BPF_MAP_TYPE_RHASH, 4, 4, 100 },
+		{ "array", BPF_MAP_TYPE_ARRAY, 4, 4, 100 },
+		{ "percpu_array", BPF_MAP_TYPE_PERCPU_ARRAY, 4, 3, 100 },
+		{ "lpm_trie", BPF_MAP_TYPE_LPM_TRIE, 8, 4, 100 },
+		{ "array_of_maps", BPF_MAP_TYPE_ARRAY_OF_MAPS, 4, 4, 100 },
+		{ "hash_of_maps", BPF_MAP_TYPE_HASH_OF_MAPS, 4, 4, 100 },
+		/* Bucket and key cursors, up to 255 entries per batch. */
+		{ "multi_batch_hash", BPF_MAP_TYPE_HASH, 4, 4096, 256, false, true },
+		{ "multi_batch_array", BPF_MAP_TYPE_ARRAY, 4, 4096, 256, false, true },
+	};
+	struct bpftool_map_batch *skel;
+	char *expected = NULL, *output = NULL;
+	unsigned int i;
+
+	skel = bpftool_map_batch__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+	skel->bss->test_tgid = getpid();
+	if (!ASSERT_OK(bpftool_map_batch__attach(skel), "skel_attach"))
+		goto out;
+	expected = malloc(OUTPUT_SIZE);
+	output = malloc(OUTPUT_SIZE);
+	if (!ASSERT_OK_PTR(expected, "expected") || !ASSERT_OK_PTR(output, "output"))
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++)
+		if (test__start_subtest(cases[i].name))
+			run_case(skel, &cases[i], expected, output);
+out:
+	free(expected);
+	free(output);
+	bpftool_map_batch__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/bpftool_map_batch.c b/tools/testing/selftests/bpf/progs/bpftool_map_batch.c
new file mode 100644
index 0000000000000..0ca6f7973e880
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpftool_map_batch.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define EBUSY 16
+
+char _license[] SEC("license") = "GPL";
+
+/* The test process; bpftool runs as its child or grandchild via popen(). */
+int test_tgid;
+/* 1-based batch lookup to fail, -1 to fail all of them, 0 for none. */
+int fail_batch;
+int batch_calls;
+int elem_calls;
+
+static bool is_test_bpftool(void)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return BPF_CORE_READ(task, real_parent, tgid) == test_tgid ||
+	       BPF_CORE_READ(task, real_parent, real_parent, tgid) == test_tgid;
+}
+
+SEC("fmod_ret/security_bpf")
+int BPF_PROG(count_bpftool_lookups, int cmd, union bpf_attr *attr,
+	     unsigned int size, bool kernel)
+{
+	if (kernel || !is_test_bpftool())
+		return 0;
+
+	if (cmd == BPF_MAP_LOOKUP_ELEM) {
+		elem_calls++;
+	} else if (cmd == BPF_MAP_LOOKUP_BATCH) {
+		batch_calls++;
+		/* Trigger fallback rather than end-of-iteration (-ENOENT). */
+		if (fail_batch < 0 || fail_batch == batch_calls)
+			return -EBUSY;
+	}
+	return 0;
+}
-- 
2.56.0

