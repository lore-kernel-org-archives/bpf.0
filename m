Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3E3ACF00
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789103486; cv=none; b=cy9fjCFqS/qtk0Px131PsAEZVYBgO67XGrLmeeWn/YPOBMmQ5Awa2EjQiaqm7Mzx+P3EFx/ay6AZEM4J9sJSJhikQKFBgKIPZFXYcRMosmgtZAkLBTntVgDoT3HzQnbTUEVMNihT3kic04rHhe8Cd9a3nV4dbPC4o7xkDEe4ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789103486; c=relaxed/simple;
	bh=DoiP07DKezR18a2HO02fqc5HK1icjC68Wj8Ljl+Tong=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWpT2UY5Q8a/mkxef6j5IttqQad0hA4QxmhOlC1GntKzjW3XiotOAGWlOaSqbQtkLF4lFkhfjNZ+JZQlYD51aPGAtmk9RUuRhgJ0O9MbwzPSAwjx4+lk1PpTmZy9w7neVdxD/KV3krHjaL6nzLyzt/8PeFjO0hrDgl4/5+L+xqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSoJtG4s; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSoJtG4s"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so1689525ad.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 22:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789103484; x=1789708284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eQUWxWBt9gs4mQRfK8L9RSI8KhT9WTzeZfSp32VDsY0=;
        b=pSoJtG4sZ8d5W5ElKgb93UJB/og83R8qUZJA+FTwC+v53QJJ1/PcAWYyOOG2YHvhf5
         P4KotBWd2WYfFnJH2HT7SMGEB/ahfYz9PB4h7H/bH5mF53Yyct+xskmu36fnXcT9PIRW
         v4vPpCjf/CVeY8pHt1Td8HbJqOFdH+nlpyVczxs8LsZSUYWV4C45BkiF/XN0BuV9iIIl
         KcJAdzmVIHbcsJCMIkbS55NWRWn542Ih5pOk/qt8opgoWTA/XhBZeM9xtl3oPnZM6NMe
         eA8wc70WxNJUeuO98xN9abKH+5o6cVGZFBugzAQX/SBczOG/MpL78P47+MhIJNO3N0NT
         wEiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789103484; x=1789708284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eQUWxWBt9gs4mQRfK8L9RSI8KhT9WTzeZfSp32VDsY0=;
        b=UH4ZN25TwZtsp2OdjcxruPfs9rXxDVzm/riNw8cYToYt4yZSl8kH8c4nqShj1h8s7L
         ZDLLyE5f91abpq9xWaKsxffA5jGeZY9VdL8AJaM1U8TB1c9U7MdlhcPA1bo+Q2l0ls3w
         M7o11GC4lyv/sXgzPc7sr7PC5GwmUNXG3MIetwZJBIU8ZK3OUWfnIzN9B6OM8ioitXb/
         8F1amDITxMnVWcnLgk+Z1LHkVO205NUPPKFZaE3bxdSvWF1Ycxkoh6rTYIFI8X7JVLuP
         sN4WxS4uBi+JXISU2bmwvRv35ycoeyBkjY/B/eZllnySjApSaGNirVtUQAHlvfplYJfl
         hP7A==
X-Forwarded-Encrypted: i=1; AKwUvBwFZFPIP0oPasxGDmZG8fQCqWTnXPYM+uWBCIumQjzJ2R6lc15K5OEP0MrXhf/fJ1FTOgs=@vger.kernel.org
X-Gm-Message-State: AFuF++mgSenShRH+F1v7Y/V2mSGeZWiXmzzZhN/vlll7k9moRz1UurhT
	fCwTPexbFnQawZ4IiNVkgwh9uB+NUBXbXycqPX4te2O3dwOfE1Ll0gZdHUxfLnQOZeA=
X-Gm-Gg: AYBFou3mK3TxnBI3Nxxo/0W9IaeZ9rTdZmd7OH3bEvVYHbe1d+Q96sV0rpA6qYz3c8o
	S5x9RWwA06wrlDAZWefhXUaMPzyrNEGQWvfSRZL43h+ou1EOo0gpI+sSOC1bmX/ANEq6cOUvU3y
	mCxMv/CGoqVdkE4asHSHj/wR+W95fvkpmVBvIZ1ZUIFPOAf4kXEtwtrgqHp40qCdgduLYlb82B0
	/FdDhDhuKSozsyeTCkpOOnV5qJMeiLa1AjbPKKwjhWTnMOtqrw+UDpdgpPqO1tsV5u/qnbgHfa3
	38iCHxGEwlfCc2c7o3ok8O3mOqLbL0WVHZMAbE6vjBHOksW4zJqFJRj3bOKYRzxnERCWICuWNHj
	gb2QCsxu6G6L1b+ZGf680m0ZKpbZnRfKQz7oXrd2ciTwbylcDdmQOxwI567kznWAIUeET5bsp/d
	HYyK6TR4qvnrLix7rcPvzaZB79qswNE8a6T7hKQrLg
X-Received: by 2002:a05:6a20:a128:b0:3cc:3d08:da2b with SMTP id adf61e73a8af0-3daed41936dmr3917415637.15.1789103483395;
        Thu, 10 Sep 2026 22:11:23 -0700 (PDT)
Received: from fedora ([2602:f921:f20:17::a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e5182fsm3018993eec.9.2026.09.10.22.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 22:11:22 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Fri, 11 Sep 2026 13:10:53 +0800
Message-ID: <20260911051053.283421-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911051053.283421-1-diannaaav@gmail.com>
References: <20260911051053.283421-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

Exercise array-of-maps and hash-of-maps dumps with shared inner maps,
empty maps, BTF values and multiple selected roots. Check complete JSON
documents, plain output, root ordering, deduplication, both option forms
and unchanged nonrecursive output.

Cover ordinary and nested perf event arrays to preserve unsupported
lookup error markers. Dump 64 distinct inner maps under RLIMIT_NOFILE=32
to detect retaining a descriptor for every inner map. Check JSON and
plain output, and ensure child descriptor cleanup leaves the parent's
resources usable.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 480 ++++++++++++++++++
 1 file changed, 480 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 00000000000..a2354c2d647
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+#include <sys/resource.h>
+#include <dirent.h>
+
+#define OUTPUT_SIZE 8192
+#define MANY_MAPS_OUTPUT_SIZE 65536
+
+static bool dump_map(__u32 id, const char *options, char *output)
+{
+	char command[MAX_BPFTOOL_CMD_LEN];
+
+	snprintf(command, sizeof(command), "%s map dump id %u", options, id);
+	memset(output, 0, OUTPUT_SIZE);
+	if (!ASSERT_OK(get_bpftool_command_output(command, output, OUTPUT_SIZE - 1),
+		       "dump_map"))
+		return false;
+	/* The helper leaves the trailing newline in place. */
+	output[strcspn(output, "\n")] = '\0';
+	return true;
+}
+
+static __u32 map_id(int fd)
+{
+	struct bpf_map_info info = {};
+	__u32 len = sizeof(info);
+
+	if (!ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &len), "map_info"))
+		return 0;
+	return info.id;
+}
+
+static int count_token(const char *output, const char *token)
+{
+	int count = 0;
+
+	while ((output = strstr(output, token))) {
+		count++;
+		output += strlen(token);
+	}
+	return count;
+}
+
+static void check_plain(__u32 root_id, __u32 inner_id, const char *type,
+			int entries, bool typed)
+{
+	char command[MAX_BPFTOOL_CMD_LEN], header[128];
+	char output[OUTPUT_SIZE] = {};
+	const char *root, *inner;
+
+	snprintf(command, sizeof(command), "--recursive map dump id %u", root_id);
+	if (!ASSERT_OK(get_bpftool_command_output(command, output, sizeof(output) - 1),
+		       "plain_dump"))
+		return;
+	snprintf(header, sizeof(header), "%u: %s  name dump_outer  ", root_id, type);
+	root = strstr(output, header);
+	if (!ASSERT_OK_PTR(root, "plain_root_header"))
+		return;
+	ASSERT_EQ(root - output, 0, "plain_root_first");
+	ASSERT_EQ(count_token(output, "inner_map_id:"), entries, "plain_references");
+	if (entries) {
+		snprintf(header, sizeof(header), "%u: hash  name dump_inner  ", inner_id);
+		inner = strstr(output, header);
+		if (ASSERT_OK_PTR(inner, "plain_inner_header"))
+			ASSERT_GT(inner - root, 0, "plain_inner_after_root");
+		ASSERT_EQ(count_token(output, header), 1, "plain_inner_once");
+	}
+	ASSERT_EQ(count_token(output, "Found "), entries && !typed ? 2 : 1,
+		  "plain_map_count");
+	if (typed) {
+		ASSERT_HAS_SUBSTR(output, "\"key\": 0", "plain_btf_key");
+		ASSERT_HAS_SUBSTR(output, "\"value\": 16843009", "plain_btf_value");
+	}
+}
+
+static void test_outer(enum bpf_map_type type, int entries, bool empty_inner,
+		       bool typed)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	LIBBPF_OPTS(bpf_map_create_opts, inner_opts);
+	struct btf *btf = NULL;
+	char outer[OUTPUT_SIZE], inner[OUTPUT_SIZE], output[OUTPUT_SIZE];
+	char expected[OUTPUT_SIZE * 3], reference[64];
+	const char *type_name = libbpf_bpf_map_type_str(type);
+	int inner_fd = -1, outer_fd = -1;
+	__u32 root_id, inner_id, key, value = 0x01010101;
+
+	if (typed) {
+		btf = btf__new_empty();
+		if (!ASSERT_OK_PTR(btf, "create_btf") ||
+		    !ASSERT_EQ(btf__add_int(btf, "unsigned int", 4, 0), 1, "btf_int") ||
+		    !ASSERT_OK(btf__load_into_kernel(btf), "load_btf"))
+			goto out;
+		inner_opts.btf_fd = btf__fd(btf);
+		inner_opts.btf_key_type_id = 1;
+		inner_opts.btf_value_type_id = 1;
+	}
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_inner", sizeof(key),
+				  sizeof(value), 2, &inner_opts);
+	if (!ASSERT_OK_FD(inner_fd, "create_inner"))
+		goto out;
+	key = 0;
+	if (!empty_inner &&
+	    !ASSERT_OK(bpf_map_update_elem(inner_fd, &key, &value, BPF_ANY),
+		       "populate_inner"))
+		goto out;
+	opts.inner_map_fd = inner_fd;
+	outer_fd = bpf_map_create(type, "dump_outer", sizeof(key), sizeof(__u32),
+				  3, &opts);
+	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
+		goto out;
+	/* For arrays, unused slots also exercise failed lookups. */
+	for (key = 0; key < entries; key++)
+		if (!ASSERT_OK(bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_ANY),
+			       "populate_outer"))
+			goto out;
+	root_id = map_id(outer_fd);
+	inner_id = map_id(inner_fd);
+	if (!root_id || !inner_id || !dump_map(root_id, "-j", outer) ||
+	    !dump_map(inner_id, "-j", inner))
+		goto out;
+
+	ASSERT_EQ(outer[0], '[', "default_array");
+	ASSERT_EQ(count_token(outer, "\"elements\":"), 0, "default_no_wrapper");
+	ASSERT_EQ(count_token(outer, "\"id\":"), 0, "default_no_header");
+	snprintf(reference, sizeof(reference), "\"inner_map_id\":%u", inner_id);
+	ASSERT_EQ(count_token(outer, reference), entries, "default_references");
+	if (!entries)
+		ASSERT_STREQ(outer, "[]", "empty_outer_default");
+	if (empty_inner)
+		ASSERT_STREQ(inner, "[]", "empty_inner_default");
+	else if (typed)
+		ASSERT_HAS_SUBSTR(inner, "\"formatted\":{\"key\":0,\"value\":16843009}",
+				  "typed_inner");
+	else
+		ASSERT_STREQ(inner,
+			     "[{\"key\":[\"0x00\",\"0x00\",\"0x00\",\"0x00\"],"
+			     "\"value\":[\"0x01\",\"0x01\",\"0x01\",\"0x01\"]}]",
+			     "ordinary_default");
+
+	/*
+	 * Compare the complete JSON document: a flat array with the root first,
+	 * one copy of the shared inner map, and unchanged entry representations.
+	 */
+	if (entries)
+		snprintf(expected, sizeof(expected),
+			 "[{\"id\":%u,\"type\":\"%s\",\"name\":\"dump_outer\","
+			 "\"flags\":0,\"elements\":%s},{\"id\":%u,\"type\":\"hash\","
+			 "\"name\":\"dump_inner\",\"flags\":0,\"elements\":%s}]",
+			 root_id, type_name, outer, inner_id, inner);
+	else
+		snprintf(expected, sizeof(expected),
+			 "[{\"id\":%u,\"type\":\"%s\",\"name\":\"dump_outer\","
+			 "\"flags\":0,\"elements\":[]}]", root_id, type_name);
+	if (dump_map(root_id, "-j -r", output))
+		ASSERT_STREQ(output, expected, "recursive_json");
+	if (dump_map(root_id, "--json --recursive", output))
+		ASSERT_STREQ(output, expected, "recursive_long_options");
+	check_plain(root_id, inner_id, type_name, entries, typed);
+
+	/* Recursion on an ordinary map still emits a single map object. */
+	snprintf(expected, sizeof(expected),
+		 "[{\"id\":%u,\"type\":\"hash\",\"name\":\"dump_inner\","
+		 "\"flags\":0,\"elements\":%s}]", inner_id, inner);
+	if (dump_map(inner_id, "-j -r", output))
+		ASSERT_STREQ(output, expected, "ordinary_recursive");
+out:
+	if (outer_fd >= 0)
+		close(outer_fd);
+	if (inner_fd >= 0)
+		close(inner_fd);
+	btf__free(btf);
+}
+
+static void test_multiple_roots(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	char command[MAX_BPFTOOL_CMD_LEN], name[BPF_OBJ_NAME_LEN];
+	char output[OUTPUT_SIZE] = {}, expected[OUTPUT_SIZE * 4], elements[OUTPUT_SIZE];
+	static const char * const types[] = { "hash", "array_of_maps", "hash_of_maps", "hash" };
+	int fds[] = { -1, -1, -1, -1 };
+	__u32 ids[4], key;
+	size_t len = 0;
+	int i, n;
+
+	/*
+	 * Select the first inner map and both outers as roots. The other inner
+	 * map must be appended after all three roots, even though it is found
+	 * while dumping the first outer. A process-specific name avoids other
+	 * tests' maps joining the selection.
+	 */
+	snprintf(name, sizeof(name), "dump_%u", getpid());
+	fds[0] = bpf_map_create(BPF_MAP_TYPE_HASH, name, 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(fds[0], "create_selected_inner"))
+		goto out;
+	fds[3] = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_discovered", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(fds[3], "create_discovered_inner"))
+		goto out;
+	opts.inner_map_fd = fds[0];
+	fds[1] = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, name, 4, 4, 2, &opts);
+	if (!ASSERT_OK_FD(fds[1], "create_array_root"))
+		goto out;
+	fds[2] = bpf_map_create(BPF_MAP_TYPE_HASH_OF_MAPS, name, 4, 4, 2, &opts);
+	if (!ASSERT_OK_FD(fds[2], "create_hash_root"))
+		goto out;
+	for (i = 1; i <= 2; i++) {
+		key = 0;
+		if (!ASSERT_OK(bpf_map_update_elem(fds[i], &key, &fds[0], BPF_ANY),
+			       "reference_selected_inner"))
+			goto out;
+		key = 1;
+		if (!ASSERT_OK(bpf_map_update_elem(fds[i], &key, &fds[3], BPF_ANY),
+			       "reference_discovered_inner"))
+			goto out;
+	}
+	for (i = 0; i < ARRAY_SIZE(fds); i++) {
+		ids[i] = map_id(fds[i]);
+		if (!ids[i] || !dump_map(ids[i], "-j", elements))
+			goto out;
+		n = snprintf(expected + len, sizeof(expected) - len,
+			     "%s{\"id\":%u,\"type\":\"%s\",\"name\":\"%s\","
+			     "\"flags\":0,\"elements\":%s}%s",
+			     i ? "," : "[", ids[i], types[i],
+			     i == 3 ? "dump_discovered" : name, elements, i == 3 ? "]" : "");
+		if (!ASSERT_GE(n, 0, "format_expected") ||
+		    !ASSERT_LT(n, sizeof(expected) - len, "expected_length"))
+			goto out;
+		len += n;
+	}
+	snprintf(command, sizeof(command), "-j -r map dump name %s", name);
+	if (ASSERT_OK(get_bpftool_command_output(command, output, sizeof(output) - 1),
+		      "dump_multiple_roots")) {
+		output[strcspn(output, "\n")] = '\0';
+		ASSERT_STREQ(output, expected, "roots_first_and_seed_dedup");
+	}
+out:
+	for (i = 0; i < ARRAY_SIZE(fds); i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+}
+
+static void test_unreadable(bool outer)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	char elements[OUTPUT_SIZE], output[OUTPUT_SIZE], root[OUTPUT_SIZE];
+	char expected[OUTPUT_SIZE * 3], plain[OUTPUT_SIZE] = {};
+	char command[MAX_BPFTOOL_CMD_LEN];
+	int inner_fd = -1, outer_fd = -1, lookup_errno;
+	__u32 inner_id, root_id, key = 0, value;
+
+	/*
+	 * Every key is enumerable, but PERF_EVENT_ARRAY lookup returns
+	 * ENOTSUPP (the kernel-internal errno). Check both entries so an
+	 * early exit on the first lookup failure cannot pass.
+	 */
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_PERF_EVENT_ARRAY, "dump_unreadable",
+				  sizeof(key), sizeof(value), 2, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "create_unreadable"))
+		goto out;
+	if (!ASSERT_LT(bpf_map_lookup_elem(inner_fd, &key, &value), 0,
+		       "unreadable_lookup"))
+		goto out;
+	lookup_errno = errno;
+	if (!ASSERT_NEQ(lookup_errno, ENOENT, "unreadable_not_missing"))
+		goto out;
+	inner_id = map_id(inner_fd);
+	if (!inner_id || !dump_map(inner_id, "-j", elements))
+		goto out;
+	ASSERT_EQ(count_token(elements, "\"error\":"), 2, "default_json_errors");
+	snprintf(command, sizeof(command), "map dump id %u", inner_id);
+	if (!ASSERT_OK(get_bpftool_command_output(command, plain, sizeof(plain) - 1),
+		       "default_plain_unreadable"))
+		goto out;
+	ASSERT_EQ(count_token(plain, strerror(lookup_errno)), 2, "default_plain_errors");
+	ASSERT_HAS_SUBSTR(plain, "Found 0 elements", "default_plain_count");
+
+	root_id = inner_id;
+	if (outer) {
+		opts.inner_map_fd = inner_fd;
+		outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "dump_outer",
+					  sizeof(key), sizeof(value), 1, &opts);
+		if (!ASSERT_OK_FD(outer_fd, "create_outer") ||
+		    !ASSERT_OK(bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_ANY),
+			       "populate_outer"))
+			goto out;
+		root_id = map_id(outer_fd);
+		if (!root_id || !dump_map(root_id, "-j", root))
+			goto out;
+		snprintf(expected, sizeof(expected),
+			 "[{\"id\":%u,\"type\":\"array_of_maps\",\"name\":\"dump_outer\","
+			 "\"flags\":0,\"elements\":%s},{\"id\":%u,"
+			 "\"type\":\"perf_event_array\",\"name\":\"dump_unreadable\","
+			 "\"flags\":0,\"elements\":%s}]", root_id, root, inner_id, elements);
+	} else {
+		snprintf(expected, sizeof(expected),
+			 "[{\"id\":%u,\"type\":\"perf_event_array\","
+			 "\"name\":\"dump_unreadable\",\"flags\":0,\"elements\":%s}]",
+			 inner_id, elements);
+	}
+	if (dump_map(root_id, "-j -r", output))
+		ASSERT_STREQ(output, expected, "recursive_unreadable_json");
+	memset(output, 0, sizeof(output));
+	snprintf(command, sizeof(command), "-r map dump id %u", root_id);
+	if (ASSERT_OK(get_bpftool_command_output(command, output, sizeof(output) - 1),
+		      "recursive_unreadable_plain")) {
+		ASSERT_HAS_SUBSTR(output, plain, "recursive_plain_preserves_errors");
+		ASSERT_EQ(count_token(output, strerror(lookup_errno)), 2,
+			  "recursive_plain_errors");
+		ASSERT_EQ(count_token(output, "Found "), outer ? 2 : 1,
+			  "recursive_plain_maps");
+	}
+out:
+	if (outer_fd >= 0)
+		close(outer_fd);
+	if (inner_fd >= 0)
+		close(inner_fd);
+}
+
+static void test_many_inner_maps(bool json)
+{
+	enum {
+		DUMP_OK,
+		DUMP_ERR_RLIMIT,
+		DUMP_ERR_COMMAND,
+		DUMP_ERR_COUNTS,
+		DUMP_ERR_IDS,
+		DUMP_ERR_JSON,
+		DUMP_ERR_FDS,
+	};
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	const struct rlimit limit = { .rlim_cur = 32, .rlim_max = 32 };
+	char command[MAX_BPFTOOL_CMD_LEN], token[64];
+	__u32 ids[64], root_id, key;
+	int inner_fd = -1, outer_fd = -1, status;
+	int inherited_fds[32], nr_inherited = 0, i;
+	char *output = NULL;
+	pid_t pid;
+
+	inner_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_inner", 4, 4, 1, NULL);
+	if (!ASSERT_OK_FD(inner_fd, "create_template"))
+		goto out;
+	opts.inner_map_fd = inner_fd;
+	outer_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY_OF_MAPS, "dump_outer", 4, 4,
+				  ARRAY_SIZE(ids), &opts);
+	close(inner_fd);
+	inner_fd = -1;
+	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
+		goto out;
+	for (key = 0; key < ARRAY_SIZE(ids); key++) {
+		inner_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "dump_inner", 4, 4, 1, NULL);
+		if (!ASSERT_OK_FD(inner_fd, "create_inner") ||
+		    !ASSERT_OK(bpf_map_update_elem(outer_fd, &key, &inner_fd, BPF_ANY),
+			       "populate_outer"))
+			goto out;
+		ids[key] = map_id(inner_fd);
+		if (!ids[key])
+			goto out;
+		/* The outer map keeps each distinct inner map alive. */
+		close(inner_fd);
+		inner_fd = -1;
+	}
+	root_id = map_id(outer_fd);
+	output = calloc(1, MANY_MAPS_OUTPUT_SIZE);
+	if (!root_id || !ASSERT_OK_PTR(output, "allocate_output"))
+		goto out;
+
+	/* Fill the low FD slots to exercise inherited descriptor cleanup. */
+	for (i = 0; i < ARRAY_SIZE(inherited_fds); i++) {
+		int fd = open("/dev/null", O_RDONLY);
+
+		if (!ASSERT_OK_FD(fd, "open_inherited_fd"))
+			goto out;
+		inherited_fds[nr_inherited++] = fd;
+	}
+
+	/*
+	 * Create all fixtures before lowering the limit, and keep the test
+	 * runner's limit unchanged. Retaining every discovered FD would exceed
+	 * this limit before the recursive dump could visit all inner maps.
+	 */
+	pid = fork();
+	if (!ASSERT_GE(pid, 0, "fork"))
+		goto out;
+	if (!pid) {
+		struct dirent *entry;
+		DIR *dir;
+
+		/* Reserve a slot for the directory even if the parent is full. */
+		close(inherited_fds[nr_inherited - 1]);
+		dir = opendir("/proc/self/fd");
+		if (!dir)
+			_exit(DUMP_ERR_FDS);
+		/* The parent keeps the outer map and its inner maps alive. */
+		for (;;) {
+			char *end;
+			long fd;
+
+			errno = 0;
+			entry = readdir(dir);
+			if (!entry) {
+				if (errno)
+					_exit(DUMP_ERR_FDS);
+				break;
+			}
+			fd = strtol(entry->d_name, &end, 10);
+			if (*end || fd < 3 || fd == dirfd(dir))
+				continue;
+			close(fd);
+		}
+		if (closedir(dir))
+			_exit(DUMP_ERR_FDS);
+		if (setrlimit(RLIMIT_NOFILE, &limit))
+			_exit(DUMP_ERR_RLIMIT);
+		snprintf(command, sizeof(command), "%s -r map dump id %u",
+			 json ? "-j" : "", root_id);
+		if (get_bpftool_command_output(command, output, MANY_MAPS_OUTPUT_SIZE - 1))
+			_exit(DUMP_ERR_COMMAND);
+		if (count_token(output, json ? "\"id\":" : "Found ") != ARRAY_SIZE(ids) + 1 ||
+		    count_token(output, json ? "\"inner_map_id\":" : "inner_map_id:") !=
+		    ARRAY_SIZE(ids))
+			_exit(DUMP_ERR_COUNTS);
+		for (key = 0; key < ARRAY_SIZE(ids); key++) {
+			if (json)
+				snprintf(token, sizeof(token), "\"id\":%u,", ids[key]);
+			else
+				snprintf(token, sizeof(token), "\n%u: hash  name dump_inner  ",
+					 ids[key]);
+			if (count_token(output, token) != 1)
+				_exit(DUMP_ERR_IDS);
+		}
+		if (json && (output[0] != '[' ||
+			     strcmp(output + strlen(output) - 2, "]\n")))
+			_exit(DUMP_ERR_JSON);
+		_exit(DUMP_OK);
+	}
+	if (ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid") &&
+	    ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		ASSERT_EQ(WEXITSTATUS(status), DUMP_OK, "dump_with_low_fd_limit");
+	for (i = 0; i < nr_inherited; i++)
+		ASSERT_GE(fcntl(inherited_fds[i], F_GETFD), 0, "parent_fd_preserved");
+	ASSERT_EQ(map_id(outer_fd), root_id, "parent_outer_preserved");
+out:
+	while (nr_inherited)
+		close(inherited_fds[--nr_inherited]);
+	free(output);
+	if (outer_fd >= 0)
+		close(outer_fd);
+	if (inner_fd >= 0)
+		close(inner_fd);
+}
+
+void test_bpftool_map_dump(void)
+{
+	if (test__start_subtest("unreadable_ordinary"))
+		test_unreadable(false);
+	if (test__start_subtest("unreadable_inner"))
+		test_unreadable(true);
+	if (test__start_subtest("many_inner_maps_json"))
+		test_many_inner_maps(true);
+	if (test__start_subtest("many_inner_maps_plain"))
+		test_many_inner_maps(false);
+	if (test__start_subtest("multiple_roots"))
+		test_multiple_roots();
+	if (test__start_subtest("array_of_maps"))
+		test_outer(BPF_MAP_TYPE_ARRAY_OF_MAPS, 1, false, false);
+	if (test__start_subtest("hash_of_maps"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, 1, false, false);
+	if (test__start_subtest("shared_inner"))
+		test_outer(BPF_MAP_TYPE_ARRAY_OF_MAPS, 2, false, false);
+	if (test__start_subtest("empty_array_of_maps"))
+		test_outer(BPF_MAP_TYPE_ARRAY_OF_MAPS, 0, false, false);
+	if (test__start_subtest("empty_hash_of_maps"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, 0, false, false);
+	if (test__start_subtest("btf_inner"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, 1, false, true);
+	if (test__start_subtest("empty_inner"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, 1, true, false);
+}
-- 
2.55.0

