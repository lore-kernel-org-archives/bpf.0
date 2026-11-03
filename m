Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732545;
	b=vXUpDUqhfMWO9vPXAUAhOORELr3mNZ3+mlvSDzImAco3guDf9OUkZnXCvnDNpCJFsbMc
	 VY3IT9BWbsOq93B1xZ2DNg9Zx5mRJgmVC1DQnddNyJdsPnSYnwZAtw9iueZamsB9QHMG7
	 JKVH5KTIgLswMT9pbn3d46oy5SuPAntTKeqUR436n5kne0DpNFp1Se4/Vi6MqhNrPNjbm
	 wHDa1dOAM7YC2wwvLMRzZ1pZgMCWJyxfS24tN65uxb/CD1soidjVzK2xd99jXqpIIteUn
	 QmTZ2T5tEr7lHilhjaI3uv6gMXBLk2enPT9v8BT3zwPlirGWKYZl0dtuJlYaN+di9ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732545;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:In-Reply-To:
	 References:From:Date:Subject:To:Cc:X-Envelope-From;
	bh=iRcFKVq4yzOPPq5tlMD3IhnrPnQrcTTJkLYWnS8Ojxg=;
	b=xrwGWUGNUu0A7uHrlOnH35EhXzEtKerbOu2x8Go4hs4nOgdhH0Cpm0BH9YhKlBatB7uK
	 UXZ/HbhVCpWd86vRTmDyY+8EALpSeQd8z0MxdUfhN9qJW0Sb+J9fJsAilH4oir8mDNsrN
	 mjGrfgdznKMiBGhFXe0lqeKrrQ2AaOudfQ2Ddx4nL19bQZeuxSqA/7B3kYEGflNHXqmU8
	 jADj9EljU7JlespUcT4vT9Mlscv/T46Up6XFH2MnXkP2VNiQtfW3l/wZoOzHjmCTTKtzi
	 vhQ00IoJB63qhiOeCHtlS0VvVuMx8p/JapLAJTvzTseAnIlVJZObUdAopMjdxrbUGxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b="BE73ii/7";
	arc=none smtp.remote-ip=198.54.127.65
Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC94606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEC94606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=BE73ii/7
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJyc73fspz8sWS;
	Tue, 03 Nov 2026 19:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732524;
	bh=iRcFKVq4yzOPPq5tlMD3IhnrPnQrcTTJkLYWnS8Ojxg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=BE73ii/704qk/HXdjhkCYdpTN/L5SBEpfmk83JNnCYY6KHeUZaifDCg9KJjsvFmJU
	 2nF7VFj3s0DEz/ePQvniaYqX2YeNic8aLgBfUeq8HLLkH4J3R3cDF7jXbcnHfh3h3b
	 XYjKnJ1Kgo+3EYVWcKIgwWLsXKCzoSY49ZiPx54ERFn7OC9LFcrVq0sHIk0Wuy0VtZ
	 i8uefOFHi7ic4CACUDCK4UnDnLXiSYnzicwuM/yMoqBOCcfb8gHcUzghaostDXoNCy
	 6KHl76Rpjf0gTNBRkUqpBBXtB91OXJnXI1ytCFZR4mDQT3uk0aGvqr7CV9h6OKz3l6
	 wSNc6ev7VBy7g==
Message-ID: <a970aee62ffdc611105549c4263dfa41d00ace6d.1793732386.git.hi@tychen.cc>
In-Reply-To: <cover.1793732386.git.hi@tychen.cc>
References: <cover.1793732386.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:59 +0900
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: Check bpftool batch map dump
 contents
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    daniel@iogearbox.net,
    ast@kernel.org,
    hi@tychen.cc
X-Envelope-From: hi@tychen.cc
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Exercise hash map dumps around the initial batch size and across
multiple batches, including empty and single-entry maps. Compare each
complete unordered key/value set with the input data in plain, JSON
and pretty JSON output.

Cover one-byte keys, three-byte values and BTF-formatted maps to catch
cursor sizing, buffer alignment and formatting regressions.

Also cover a sparse hash map whose maximum capacity exceeds the batch
buffer budget.

Acked-by: Quentin Monnet <qmo@kernel.org>
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_batch.c        | 191 ++++++++++++++++++
 1 file changed, 191 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
new file mode 100644
index 0000000000000..5387de2ba79fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+#include <ctype.h>
+
+#define MAX_ENTRIES 1025
+#define RECORD_SIZE 256
+#define OUTPUT_SIZE (MAX_ENTRIES * RECORD_SIZE + 1024)
+
+struct dump_case {
+	const char *name;
+	unsigned int count;
+	unsigned int key_size;
+	unsigned int value_size;
+	bool btf;
+	unsigned int max_entries;
+};
+
+static void hex_bytes(char *out, const void *data, unsigned int size, bool json)
+{
+	const unsigned char *bytes = data;
+	unsigned int i;
+
+	if (json)
+		*out++ = '[';
+	for (i = 0; i < size; i++) {
+		if (json && i)
+			*out++ = ',';
+		out += sprintf(out, json ? "\"0x%02x\"" : "%02x", bytes[i]);
+	}
+	if (json)
+		*out++ = ']';
+	*out = '\0';
+}
+
+static void expected_record(char *record, const struct dump_case *test,
+			    unsigned int index, bool json)
+{
+	__u32 key = index, value = index * 37 + 11;
+	unsigned char short_key = index;
+	char key_hex[64], value_hex[64], formatted[96];
+
+	hex_bytes(key_hex, test->key_size == 1 ? (void *)&short_key : &key,
+		  test->key_size, json);
+	hex_bytes(value_hex, &value, test->value_size, json);
+	snprintf(formatted, sizeof(formatted), "{\"key\":%u,\"value\":%u}",
+		 key, value);
+	if (json && test->btf)
+		snprintf(record, RECORD_SIZE,
+			 "{\"key\":%s,\"value\":%s,\"formatted\":%s}",
+			 key_hex, value_hex, formatted);
+	else if (json)
+		snprintf(record, RECORD_SIZE, "{\"key\":%s,\"value\":%s}",
+			 key_hex, value_hex);
+	else if (test->btf)
+		snprintf(record, RECORD_SIZE, "%s", formatted);
+	else
+		snprintf(record, RECORD_SIZE, "key:%svalue:%s", key_hex, value_hex);
+}
+
+static void check_dump(const struct dump_case *test, __u32 id, bool json, bool pretty)
+{
+	bool array = json || test->btf;
+	char command[MAX_BPFTOOL_CMD_LEN], expected[RECORD_SIZE], footer[64];
+	bool seen[MAX_ENTRIES] = {};
+	char *output, *src, *dst, *cursor;
+	unsigned int i, n;
+	int err;
+
+	output = calloc(1, OUTPUT_SIZE);
+	if (!ASSERT_OK_PTR(output, "alloc_output"))
+		return;
+	snprintf(command, sizeof(command), "%smap dump id %u",
+		 pretty ? "-p " : json ? "-j " : "", id);
+	err = get_bpftool_command_output(command, output, OUTPUT_SIZE);
+	if (!ASSERT_OK(err, "map_dump"))
+		goto out;
+	/*
+	 * Ignore presentation whitespace, but compare complete records and all
+	 * punctuation. Expected contents come only from the input data, never
+	 * from another map walk or bpftool invocation.
+	 */
+	for (src = output, dst = output; *src; src++)
+		if (!isspace((unsigned char)*src))
+			*dst++ = *src;
+	*dst = '\0';
+	cursor = output;
+	if (array) {
+		if (!ASSERT_EQ(*cursor, '[', "array_start"))
+			goto out;
+		cursor++;
+	}
+	for (n = 0; n < test->count; n++) {
+		if (array && n) {
+			if (!ASSERT_EQ(*cursor, ',', "record_separator"))
+				goto out;
+			cursor++;
+		}
+		for (i = 0; i < test->count; i++) {
+			if (seen[i])
+				continue;
+			expected_record(expected, test, i, json);
+			if (!strncmp(cursor, expected, strlen(expected)))
+				break;
+		}
+		if (!ASSERT_LT(i, test->count, "unique_expected_record"))
+			goto out;
+		seen[i] = true;
+		cursor += strlen(expected);
+	}
+	if (array) {
+		ASSERT_STREQ(cursor, "]", "array_end_and_count");
+	} else {
+		snprintf(footer, sizeof(footer), "Found%uelement%s", test->count,
+			 test->count == 1 ? "" : "s");
+		ASSERT_STREQ(cursor, footer, "plain_count");
+	}
+out:
+	free(output);
+}
+
+static void run_dump_case(const struct dump_case *test)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	struct btf *btf = NULL;
+	unsigned int i;
+	int fd = -1;
+
+	if (test->btf) {
+		btf = btf__new_empty();
+		if (!ASSERT_OK_PTR(btf, "btf_new"))
+			return;
+		if (!ASSERT_EQ(btf__add_int(btf, "unsigned int", 4, 0), 1,
+			       "btf_int") ||
+		    !ASSERT_OK(btf__load_into_kernel(btf), "btf_load"))
+			goto out;
+		opts.btf_fd = btf__fd(btf);
+		opts.btf_key_type_id = 1;
+		opts.btf_value_type_id = 1;
+	}
+	if (test->max_entries)
+		opts.map_flags = BPF_F_NO_PREALLOC;
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_batch", test->key_size,
+			    test->value_size, test->max_entries ?: (test->count ?: 1), &opts);
+	if (!ASSERT_OK_FD(fd, "map_create"))
+		goto out;
+	for (i = 0; i < test->count; i++) {
+		__u32 key = i, value = i * 37 + 11;
+		unsigned char short_key = i;
+		void *key_ptr = test->key_size == 1 ? (void *)&short_key : &key;
+
+		if (!ASSERT_OK(bpf_map_update_elem(fd, key_ptr, &value, BPF_ANY),
+			       "map_update"))
+			goto out;
+	}
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &info_len), "map_info"))
+		goto out;
+	check_dump(test, info.id, false, false);
+	check_dump(test, info.id, true, false);
+	check_dump(test, info.id, true, true);
+out:
+	if (fd >= 0)
+		close(fd);
+	btf__free(btf);
+}
+
+void test_bpftool_map_batch(void)
+{
+	static const struct dump_case cases[] = {
+		{ "empty", 0, 4, 4 },
+		{ "single", 1, 4, 4 },
+		{ "below_batch", 255, 4, 4 },
+		{ "exact_batch", 256, 4, 4 },
+		{ "above_batch", 257, 4, 4 },
+		{ "multiple_batches", 1025, 4, 4 },
+		{ "large_sparse", 1025, 4, 4, false, 1U << 20 },
+		{ "one_byte_key", 256, 1, 4 },
+		{ "odd_value_size", 257, 4, 3 },
+		{ "btf_empty", 0, 4, 4, true },
+		{ "btf_single", 1, 4, 4, true },
+		{ "btf_multiple_batches", 1025, 4, 4, true },
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++)
+		if (test__start_subtest(cases[i].name))
+			run_dump_case(&cases[i]);
+}
-- 
2.56.0

