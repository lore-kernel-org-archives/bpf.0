Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB0370AE5
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098469; cv=none; b=FqtTiAmO4aILXb7iRIkZIBwaNYLngmVXy5ARrAZ3+D2NIzqZB1WALUFcaBk9LG50AzTeeOpdi3EeIL2iPi8SaRjWyMGmcmve3jEIuEr3E++m1AnwCBc4Ie0gu+kLzSt3SPfQVlnznd7+lO4Y2cyOYaSpEj7wzeSfcS9PFjbrzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098469; c=relaxed/simple;
	bh=XQw2nJvNdDqF0i/qvi72cAwb8fZCOX0tU/74XvQXXxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1D/iu+vP1zbhqd4wPTkvNOEqD/0tVGaa3EQasE4hMsnkkwaZQVmkh4FSs9ONqEKkYvm+4S8yuM+/6/Kr6Dn3aYe92/9iZkI2k9bbvv9FC/KuYF0t5YZCeDL9kMh4uXrfpB8mbn0uvv339DiXZzDQfKZOW0RIcWJ4NdCtGOquQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfIBjlRA; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfIBjlRA"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3965683e9e9so246915a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098467; x=1789703267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCQPQxwkJKy3DEd1LSZHV7jWJXwUky4OTtKypkUgOZ4=;
        b=TfIBjlRARsP3bjw0vc2vXdflCPGg6fYLWpevrR70Xsxv97oCYZFPHhUv2Z+8Cfjsvs
         7kVJqUi+Zir1wcCE1dpEJTxU/ATHEc1G1VFFPtrqG0EYNDsmYpwc9GLL4GiBfqkRhm2T
         IGcScyz92Dj+Yg3BzukhMXPY+5ZOw+Is2NdX7azyBEzmSwtBbcNl2NWdpxlvXMZmwt2a
         LathIHETIYCr3KVUlbmYdMY5jd43K9wTjInuumOWY3hwWQDsa8NxibZP8COm75i69/Tr
         9kuzcep1he3dE6Oynv2hup28FkblpcqOu15ZOWk88on0Br4+OGaaqcnrz4Y32uELpZyj
         e2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098467; x=1789703267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MCQPQxwkJKy3DEd1LSZHV7jWJXwUky4OTtKypkUgOZ4=;
        b=nDdG4Dk+d3rv71xTCRpihytzk3/jRx/qEU+zraTuVGty7h+jkplRcfD0g1EqcmtXcS
         bD4nyoHpjKc+nEYLVMp+cfzFrxFy+qU/EemGTpg7u4FjgOWRb5iVTi8fs/miF74U7WsJ
         yUS2WZtK//09+Aw0rHQzhrP1XfkdP4JBjFLG9RjmRPF1eIwXF8qjZtn9AI5noNJG5G4R
         tPYYCsuFXr3VrxxUCaKgFTSDxABw96IGh97eEtj0VCM5Kvg9K/PsqloIO2sQseGH3rwm
         TdmlQroanD67SYk0FE3wJaJo0ALT3uToPJF/VNmTydShJPF+oxtRZmdAaNRlzixuvf5c
         QL+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzSS0gVzZrFmvtyB/bTo4MVhRFUdUD0JQf42PLa0WPzkMmOwTdhZ8FxDGocpSwp4By497M=@vger.kernel.org
X-Gm-Message-State: AFuF++kLafN+qVflZyvE3v9nof6vCVjWcsgOK69qzKi0c4P9DcSabOxW
	7R/TubZjvFHtM5a7HAsKrOOnBh4K7uIn6bAiAUz/JiFJSH7Nh4/lhJQZ
X-Gm-Gg: AYBFou2bZoBViwmi7VhDnrEamfFCMzqSqZeyx+w1fTMk65T9zqLnNBu4uw+kgmNhe+U
	mXYBR3Vlf0GpFdtmq+0xT+F1u1Z+ZXLKCoaBRsvG8a/LjTlcjtkXULgOtLkhme+lZRPx5XjZCY3
	nIOUoPafse61lb9va24NeUPK+28DIzGyt0e8OmOGvKTo8zUwPVt7eb5QiJJZ0EW/tHy7TNs3jSE
	tY8vidXltudcggLKOg3QzjQXBt92IGhg7ImXQenqdYMdsUTRYafDsqG4RfRz2mUmOVOg/7WJGmf
	fDJRw/3yDboOWSueOGg/X3td1QsOK0I9S7uoqmpMzVIyCrvL1/qlNefSDUC7kirghbQiyeK+L6u
	0Th58rjW5q7ItRG6C1n6w/iMND/VJ1Yu8EtPg7mYUsUbkZOG2GE251rMM4DHE0URFm5TeoTuBqI
	zAqqV5bSClgb6YNoixm3nPXWFUwFyZzHH6pHquYAIZqUoXDj+DywRMMaoI2Fk5lz2u3nz5HNxlD
	9I=
X-Received: by 2002:a17:90b:540d:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39d9bee4822mr3831687a91.8.1789098467216;
        Thu, 10 Sep 2026 20:47:47 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9540fd76sm2770852a91.9.2026.09.10.20.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:46 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Check bpftool batch map dump contents
Date: Fri, 11 Sep 2026 11:47:32 +0800
Message-ID: <20260911034732.219752-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911034732.219752-1-diannaaav@gmail.com>
References: <20260911034732.219752-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

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
index 00000000000..b4216ed778e
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

