Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732507;
	b=HlPbeGrZ+ZYGAd8fx8zLjnIG7fhFC+9WH1q+7A6yPxqK2cNw12PEBgsTAUPUtedYsmh7
	 s/F0QayExmXPT0jqGeyqEFk+ZD+YEvxxXTHZ2/uKA3mfl86m2ODsIGEDApQ0cIku/02wL
	 fRcNuf6z8Txp2iyrnnpJKrxKC4bK9KNzNZF5r9Ue6BeY99+CgbWLRKAm5VAL7IatTENaw
	 QqMvjJkTUKxH1NaPCoyNjbvZCdIikaUCGmpc5UHSFKbQRqoeK/3T3qCj9PLTUhR+E+wQC
	 jQZiedAE/B9l6+tOjBfDAWzKNlX1tdIY+lUycNlV3wp3wrMln+Y+nJ4T18OV5arkrsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732507;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:In-Reply-To:
	 References:From:Date:Subject:To:Cc:X-Envelope-From;
	bh=58yCDPlvA1IZ3zZRRZ2YdPC0GQr6jRpbVt4hkEUF7QU=;
	b=tBu/4rExJ3E0G9gGJIfnl7u3iYCI10L8+hLGRRHxizH3rHCQjOVWOJ/9jscs+1rbm4cz
	 pwcrbgVnJ8arMjE7yyawjePhRZasfNDLLWlpQ967tTtNY0nYEeqDClJq9VWtdMXbgBLVC
	 etA0x6986Xg/b6fserX1Qu8SJMe2NvmAFRDogy1WmOlJwhBvvW7FRHqsaXoQcqfxniYvT
	 whU6M4TYBCFyrNgFW0A3/LZjdmBpoF4kx1OJoZeSgFz2KPOMQoUFnlDvI9N+Rk3iY2nLI
	 3ljGa6YxJA+3e5uBBQiIik9QbPXzRh1tU+YbUko9hMtr8fZHhPizayOm9wTmd/wbnkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=Ck6R1Ko5;
	arc=none smtp.remote-ip=198.54.127.133
Received: from out-2z4y-a133.jellyfish.systems (out-2z4y-a133.jellyfish.systems [198.54.127.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0764606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 19:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0764606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=Ck6R1Ko5
Received: from [10.18.116.108] (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jJybf0lg6z8sWP;
	Tue, 03 Nov 2026 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793732498;
	bh=58yCDPlvA1IZ3zZRRZ2YdPC0GQr6jRpbVt4hkEUF7QU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=Ck6R1Ko5UoyxLZ91w6frZ+vlxTuh5AgxgHf+hghWPEl4MWj53kuHmLygRvQkFuRhc
	 W9B534STnhtkUm+dTu0DwN2GZjTymPgPDYPSThhj86d6MmdkndcjSjX4HlC9XiIpRC
	 7ura5tRs+tS8iczZhwy8xRQT8KYrzUAA+Kxbh2zKNonsaBKgZY7RSRi7LxROrcVL0m
	 6i14xYA6JeT/YeMW4hxAJGA6WQiK/MJZrGjT6tlLxk58JSAIne2MF+11xoNcv5MOJU
	 3ZxlqtubbI41PUngXCvm9W004QboVDIeqUv7/2KRfF+Rw0Q0f/Tfu76vzM+WG+EIHp
	 xnlM8ckY9zFEA==
Message-ID: <2c25cf3d118cce558cc58a207449b25c5f66b3a6.1793732336.git.hi@tychen.cc>
In-Reply-To: <cover.1793732336.git.hi@tychen.cc>
References: <cover.1793732336.git.hi@tychen.cc>
From: Tianyi Chen <hi@tychen.cc>
Date: Wed, 04 Nov 2026 04:01:33 +0900
Subject: [PATCH bpf-next v10 2/4] selftests/bpf: Check bpftool map info across
 mixed BTF maps
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
    andrii@kernel.org,
    eddyz87@gmail.com,
    ihor.solodrai@linux.dev,
    linux-kselftest@vger.kernel.org,
    skokovmaksimevg@gmail.com,
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

Create a typed map followed by a smaller untyped map with the same name.
Check that full and named listings do not report BTF for the untyped map,
JSON dumps match independently dumped contents, and plain dumps use raw
output when the selected maps do not all have BTF.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_info.c         | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c
new file mode 100644
index 0000000000000..5af19aa1e6669
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_info.c
@@ -0,0 +1,127 @@
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
+								  sizeof(elements[i])),
+				       "single_dump"))
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
2.56.0

