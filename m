Received: from out-2uec-a122.jellyfish.systems (out-2uec-a122.jellyfish.systems [63.250.43.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5B37187F
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616347; cv=none; b=fzJSar5IsCScyyZDvxmIL43SUrgD0ePxnby/l6UPSfirXrfNjYXkRJjcIEEGVlGV5mTMYdEkAvkpPNdDSN6rM7L00NsOLiM3IH1pN1tU8ykOfUqabYE5KH3teXFkxwEFE0c5sTaiYCHTjD1daDBwZ/5K6HhjoTX3EsK+7RxAZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616347; c=relaxed/simple;
	bh=01y/iGt8E8+7GTBoZl9BI+q8HMQ4idh0ucD/ynriE8o=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Ybm11qVTy664OAaoX+LYQDno/Y9tKk9QGoV9B3g0RDptT+Uu93bJfizKo6Mq+HiB6JqcHzzjBAZu7Sks46c1TxUNVux9fuVjCBZo//a9WRtJthOKCXxJ+D+cOegt1Lu4HndJg1w7eLrF/QUJXL/7EUcSTW80REUPy/soY7QGQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=GphOTRUC; arc=none smtp.client-ip=63.250.43.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="GphOTRUC"
Received: from [172.20.10.14] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4htp3X310bz6tkV;
	Mon, 28 Sep 2026 17:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1790616028;
	bh=xyWF0nGHzWfJpsbRecUZtBY956VjJxb1mVyLqW64Ufo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=GphOTRUCH7voytIDddTrvV3y81WmjjCILKIrL3txUbhOWd3RL8zwedXiy6aSggOgD
	 QXsSO4VfNFMVDcoQXtUnMke4mJ9eOTFIefKDGfpqowAXbiTdJISTDXR6zJ3tNiuc8n
	 HLxw5eGru5cRj9bqSKdJNriG0MmonIMNRJt35gSz7plWcYyUfFn1jk86FyrVkHpEib
	 iptj9kZGviDArVOCP5Ac8wufHTm+sbi1BcDb0uMQDXRg3G71LEWQdKc43Dr4VLOJXJ
	 ZkOw+qB8oK4xsLe9Url7XBBiwRii9mVWCJayd3OqHXU4/stTKc4n87jibRFs2ZlPS9
	 UylvKE4G0FHIw==
Message-ID:
 <cea9cb26c3267c22da2101a0e3d075e2633a2e61.1790615923.git.hi@tychen.cc>
In-Reply-To: <cover.1790615923.git.hi@tychen.cc>
References: <cover.1790615923.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Tue, 29 Sep 2026 02:13:21 +0900
Subject: [PATCH bpf-next 2/2] selftests/bpf: Check bpftool map info across
 mixed BTF maps
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com
X-Envelope-From: hi@tychen.cc
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Create a typed map followed by a smaller untyped map with the same name.
Check that full and named listings do not report BTF for the untyped map,
JSON dumps match independently dumped contents, and plain dumps use raw
output when the selected maps do not all have BTF.

These cover the separate info-query loops in map show and map dump
without requiring recursive dumping.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_info.c         | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c
new file mode 100644
index 000000000000..5bcfef952619
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+
+#define OUTPUT_SIZE (1024 * 1024)
+
+static void check_show(char *output, struct bpf_map_info *info)
+{
+	char id[32];
+	char *map, *end, *btf;
+
+	snprintf(id, sizeof(id), "{\"id\":%u,", info->id);
+	map = strstr(output, id);
+	if (!ASSERT_OK_PTR(map, "map_in_output"))
+		return;
+	end = strchr(map, '}');
+	if (!ASSERT_OK_PTR(end, "map_object_end"))
+		return;
+	btf = strstr(map, "\"btf_id\":");
+	if (info->btf_id) {
+		ASSERT_TRUE(btf && btf < end, "typed_map_btf");
+		if (btf && btf < end)
+			ASSERT_EQ(strtoul(btf + strlen("\"btf_id\":"), NULL, 10),
+				  info->btf_id, "btf_id");
+	} else {
+		ASSERT_TRUE(!btf || btf > end, "raw_map_no_btf");
+	}
+}
+
+static void test_map_info(const char *operation)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	struct bpf_map_info info[2] = {};
+	char command[MAX_BPFTOOL_CMD_LEN], name[BPF_OBJ_NAME_LEN];
+	char elements[2][1024] = {}, expected[4096];
+	struct btf *btf = NULL;
+	int fds[] = { -1, -1 };
+	__u64 wide_key = 0, wide_value = 1;
+	__u32 key = 0, value = 2;
+	char *output;
+	int i;
+
+	output = malloc(OUTPUT_SIZE);
+	if (!ASSERT_OK_PTR(output, "output"))
+		return;
+	snprintf(name, sizeof(name), "info_%u", getpid());
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "create_btf") ||
+	    !ASSERT_EQ(btf__add_int(btf, "unsigned long long", 8, 0), 1, "btf_int") ||
+	    !ASSERT_OK(btf__load_into_kernel(btf), "load_btf"))
+		goto out;
+	opts.btf_fd = btf__fd(btf);
+	opts.btf_key_type_id = 1;
+	opts.btf_value_type_id = 1;
+	/* Query the typed map before a smaller map without BTF. */
+	fds[0] = bpf_map_create(BPF_MAP_TYPE_HASH, name, 8, 8, 1, &opts);
+	fds[1] = bpf_map_create(BPF_MAP_TYPE_HASH, name, 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(fds[0], "create_typed") ||
+	    !ASSERT_OK_FD(fds[1], "create_raw") ||
+	    !ASSERT_OK(bpf_map_update_elem(fds[0], &wide_key, &wide_value, BPF_ANY),
+		       "populate_typed") ||
+	    !ASSERT_OK(bpf_map_update_elem(fds[1], &key, &value, BPF_ANY), "populate_raw"))
+		goto out;
+	for (i = 0; i < ARRAY_SIZE(fds); i++) {
+		__u32 len = sizeof(info[i]);
+
+		if (!ASSERT_OK(bpf_map_get_info_by_fd(fds[i], &info[i], &len), "map_info"))
+			goto out;
+	}
+	if (!ASSERT_LT(info[0].id, info[1].id, "map_order"))
+		goto out;
+
+	if (!strcmp(operation, "show_all"))
+		snprintf(command, sizeof(command), "-j map show");
+	else if (!strcmp(operation, "show_name"))
+		snprintf(command, sizeof(command), "-j map show name %s", name);
+	else
+		snprintf(command, sizeof(command), "%s map dump name %s",
+			 !strcmp(operation, "dump_json") ? "-j" : "", name);
+	output[0] = '\0';
+	if (!ASSERT_OK(get_bpftool_command_output(command, output, OUTPUT_SIZE), operation))
+		goto out;
+	if (!strncmp(operation, "show_", 5)) {
+		check_show(output, &info[0]);
+		check_show(output, &info[1]);
+	} else if (!strcmp(operation, "dump_json")) {
+		for (i = 0; i < ARRAY_SIZE(fds); i++) {
+			snprintf(command, sizeof(command), "-j map dump id %u", info[i].id);
+			if (!ASSERT_OK(get_bpftool_command_output(command, elements[i],
+							 sizeof(elements[i])), "single_dump"))
+				goto out;
+			elements[i][strcspn(elements[i], "\n")] = '\0';
+		}
+		snprintf(expected, sizeof(expected),
+			 "[{\"id\":%u,\"type\":\"hash\",\"name\":\"%s\",\"flags\":0,"
+			 "\"elements\":%s},{\"id\":%u,\"type\":\"hash\",\"name\":\"%s\","
+			 "\"flags\":0,\"elements\":%s}]\n",
+			 info[0].id, name, elements[0], info[1].id, name, elements[1]);
+		ASSERT_STREQ(output, expected, "independent_map_formatting");
+	} else {
+		char *count = strstr(output, "Found 1 element\n");
+
+		ASSERT_NULL(strstr(output, "\"value\":"), "mixed_maps_use_raw_output");
+		if (ASSERT_OK_PTR(count, "first_map_count"))
+			ASSERT_HAS_SUBSTR(count + 1, "Found 1 element\n", "second_map_count");
+	}
+out:
+	for (i = 0; i < ARRAY_SIZE(fds); i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+	btf__free(btf);
+	free(output);
+}
+
+void serial_test_bpftool_map_info(void)
+{
+	if (test__start_subtest("show_all"))
+		test_map_info("show_all");
+	if (test__start_subtest("show_name"))
+		test_map_info("show_name");
+	if (test__start_subtest("dump_json"))
+		test_map_info("dump_json");
+	if (test__start_subtest("dump_plain"))
+		test_map_info("dump_plain");
+}
-- 
2.55.0

