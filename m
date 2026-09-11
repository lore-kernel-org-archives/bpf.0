Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196D83E92AC
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095110; cv=none; b=e6rCDPWfhvuUFkrBxeOdok/PymuXITKZg7PC3dcxEco0/Fty48+/Qsxb2FxaPpZlCo5/UqZgx5y59v1t+clwjKssVrmWJiW7HYIp11aJ1a+1x1L+RjpIC/B9Nc4ovwHkVmjaWW+ec//X3MNIOOU86o/szZRTc2lsWE2I0nrC34k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095110; c=relaxed/simple;
	bh=+ELgKcvlpicmxpbGiIYs3NAolniWrdUucrVp1yAdbIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G294EGiVzwFTdTuJy/6ehxg/ct0RUmgdwlsg7laVZkUbuWuKzUVqqIhTnp+qhYVgvr3+fQKRTVR07T2DKO2aXA5OUVGu9WT2x9zK7Bor709dEh86nUlGtnf3YpzmxhAcwZAg7n7MYFXS/538H/4vrT7a/iUBEPS73QlgeDzh/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1MCrVIT; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1MCrVIT"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so127649a91.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095107; x=1789699907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+zBKyXqRJiN29CBFt2gBrCjVJ/nOrn2TlfO7tHxw/8=;
        b=D1MCrVITAWV3aksOwOWnBh9g0Jz5RSyVF0uYuFYPF58cj0t3+2FiKd1fTrc8QhYFqY
         Hg6vZ2s7vwYVR7Z4e95J3E1z8+IWwNf1lRm8TpZ+3w3OALjXgSqZwI2pMbaXp2/W0o6v
         2H8UaA8gQZUiA0KqLjVNyhML3xhLGJ72oydse1FpC7zQPGkJQ+e+udvcG3B/lydCly57
         fx/vyqzA7BCiSNFup16g5r0jkogbvQ5Aao1iJeD8tgYcjDZvgR4ErNXk8kIcRkZAlx4y
         6JFvF7rZ0+82FqF/z9NNHkzI+5MsvNbt/UnYGCvaykxJOg0kEt+e6AouP5cmrwQ+XB5m
         pNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095107; x=1789699907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+zBKyXqRJiN29CBFt2gBrCjVJ/nOrn2TlfO7tHxw/8=;
        b=ZMDpjxxog/pi7voCHJlZkw94ECoq/8rKM2TV45kPxr/ZPaHKqXTf1Z4frh7UwuX8/U
         AK3czMFrfctcoGvmHhQuiXWrM00PjARH3OjG/g5yYRALQuQlt7fUZTo49hnPg+aw0af3
         RhJUOyXwx94KDL7zDXd3XruKXZ+o355m36ZElQAQFPmMi8tjWb/Zeya5z3X+91pooe/E
         cJ1eznUyUJso/BhpjuTuQBYiyPAJG7rPZIkac3coTBq7cbVh8JXLE389345O7zbqCOye
         R5PriBZivts+7PXZU8rwk+XeYrweEKOJt4ZMloIdueklv+N+RYZ3KOmC1cincMmw+Y6g
         j03Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDqtpLJjLxUaG62aeSF6bKoLQdbinqkVqlje7XFzwOEV0Zllka5p8MmDySBEEMeRRYpS4=@vger.kernel.org
X-Gm-Message-State: AFuF++mSsAmw7Nl6jPpxrXEYshKeq0YacLmNKQVVPZR/FGY1DiwzjB0Q
	ZRf7EG/glVKXf4vBkcSuJ7XAz4Lh8PQozKgG8PI9VgXypQY5akKThRoo
X-Gm-Gg: AYBFou3h49ZFlS56KFkSB0jmGmdEc2VjwVFGOQRZdI0UXp2fbhDicR1gFgM41VH4UDC
	NJKe5+nqBX8bfHe9A4JCgsjC1M6TRdZfuH3uRqHXWUK2QGRT5L+n5MvZkDoV4x6vQiUlvFzhDzn
	rvxQyaZDykxlOx/FQv6iVUDUgoE4dmxlY+LSanilWUgAa1L2wEKRUD50K2prCcSdgVXPSAuS1cp
	xrr0ZlWpzVPHzP6ItDjMoEC8xl/thnukGtX5HkwRO27p2auLG8QdHDBBJKLwitCUmqvTcmDdlnv
	C7UjwVM0goUTbkjWuVOlUGs+AYkHs3E36Tp30mtElqajeqRMJoVkWg5SYBHNj/INHYidCaL6mo0
	wdNFYptzeq+5LUyUpCqkl58kFeW1O5qY62AKV5n8FNG+r26GnFcnfYK1naAb4VVWt8ei2WD7JY5
	H++gNMiambhbLPjvxqAIwzOGv12mDlpwwAL6dNAEkaPq3UkbTboVR5B8TbAPbD+hjt
X-Received: by 2002:a17:90b:518f:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-39d9c1bef27mr3342610a91.13.1789095107270;
        Thu, 10 Sep 2026 19:51:47 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994cc978sm1888632a91.9.2026.09.10.19.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:51:46 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Check bpftool batch map dump contents
Date: Fri, 11 Sep 2026 10:51:30 +0800
Message-ID: <20260911025130.191011-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911025130.191011-1-diannaaav@gmail.com>
References: <20260911025130.191011-1-diannaaav@gmail.com>
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

