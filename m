Received: from out-2uec-a118.jellyfish.systems (out-2uec-a118.jellyfish.systems [63.250.43.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD70414412
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267981; cv=none; b=UGDfGMvaBuMYOz8MsU2oNYLbeZk2WXTg20FKmi17PTPCricRX2W1IHqVlO85bnDg0Wd5B8/2Qip1hAWXLI64VAr/yIiNr970f0bHsrPzEk7jNgGsiwVxaSivb9+00+nM4LrOcdF+cWLnN6ksfwJjGrQZTQR//9wFcESuydv51t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267981; c=relaxed/simple;
	bh=1tAeZEFj6pgkFN3kCC39tuCsKMm/PJi/DXNpHecduQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDBsN77FFqv10k9s1rKA5TJMRPxbfEV6EZvDd2FBxABGH97eHlAREjWARMk2CLsi55g6L2jClIGM2SsbMvzZg6KrOPcKDw2d5RobeT1UfEf9iSm9oyZES7mBJBwpzFV/ocicDASyB63B/30c1p792pOQ46CFupBrHXkKbzh9qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=mXiNeLdg; arc=none smtp.client-ip=63.250.43.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="mXiNeLdg"
Received: from fedora (unknown [124.160.34.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hrKDC5wg6z2x9D;
	Thu, 24 Sep 2026 16:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790267662;
	bh=1XHk4TxSYBMH+w7gkOT5drcj3TjyTSpVE0GOOKHnUlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mXiNeLdgr/+QqUOzruRO2FczmBEHM7or8OHlSGP6E59cpXYobfAJW2lrj/Ud3Ib9x
	 afiOtwRKX8wyh4beOyv4PuG2GZCJaitj4bi7L5WFlSvxirsWRFa1G9WDK/BXJkcWSB
	 lujc5kRnSj9XB++TsH8VtAuomva9kyLXDaPBNuKF7FsMqkmqStqpFRnVgJZrYLtxFJ
	 C5IxuGTYGH2P6Wmu9bpXHcQOV1SMeU1F7uPQ60EGdwN/pgBUE6EksmShJtUsvYQ9dR
	 wH/dHMMdABYG1g+Sw3cl49jAWaggVWXiOJnNc2M9yjctwkyMHcMLvU+U+YzjbdpCrX
	 TwDijFhz+JImQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Check bpftool batch map dump contents
Date: Fri, 25 Sep 2026 01:34:03 +0900
Message-ID: <20260924163403.203491-3-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924163403.203491-1-hi@tychen.cc>
References: <20260924163403.203491-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Exercise hash map dumps around the initial batch size and across
multiple batches, including empty and single-entry maps. Compare each
complete unordered key/value set with the input data in plain, JSON
and pretty JSON output.

Cover one-byte keys, three-byte values and BTF-formatted maps to catch
cursor sizing, buffer alignment and formatting regressions.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_batch.c        | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
new file mode 100644
index 000000000000..b4216ed778ef
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_batch.c
@@ -0,0 +1,187 @@
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
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_batch", test->key_size,
+			    test->value_size, test->count ?: 1, &opts);
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
2.55.0

