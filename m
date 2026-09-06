Received: from out-zbxj-a65.jellyfish.systems (out-zbxj-a65.jellyfish.systems [198.54.127.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21F6346E59
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705945; cv=none; b=fbhP/G6c4pG0b3DWlBO/P1bby2gEqHHCyW+n8GDIirxuD25808lZT7+JSrO+DnQqvb9Cl3fvyZlBfJJABcFvIASmr2HyzFCcxsjT4p1DEe/3uJ3H8MiCPNFa6SKrw77/iAWraQUmClqicZwd5S4ZXrc7UVaszE+Pqw9AGKnZVRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705945; c=relaxed/simple;
	bh=AwCXbmbpt17i7YNmPyhPR8fCoHZw3YWqSpsb+wb8YD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feeQaW0Mki9BwbDfRruL31NDyNcO1ZdvjB7TF8CiqV+bXb1hQ9cR3ZzA2NPdWQZEH7Z0u7IzkuxBqUGLkX/rMdPuJOoyzoGa3UvLDphMLUbumH34itQt0j2q6WeWqFRr9mwBmi00Zg/CYelP14xwQy2nIPrL2LqQ9OovnHbAC4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=nyXIjllM; arc=none smtp.client-ip=198.54.127.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="nyXIjllM"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdCXj6R54z8sX3;
	Sun, 06 Sep 2026 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788705610;
	bh=wHXpina7BeJ4lMtrwoh48Wls4cUx9IdFAqvnnPqY3NU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyXIjllMpUgI+Vh8KO5e6meeVYwhD5hZ7S6hwHgV86t1mqzzMoesVyfzwS+ehYtn9
	 NrMTN7NPMrW1QolW/rAl+H2veK0qAZooAQg4Tbrzjb2d+Xyj66xigm+dZgfk6GGTQr
	 kNK8+/v6+cmutHlM9MYAwEHmM5+pWe+zGz2mYVzQeibhCWwzggJd1xXRAx6FEeWr/V
	 8yPsqKMs4hRfq8P5vfNbqVRN3gv1tggixUAUke+QC8XLQkaCeUxc+rdcR9715Nm6YG
	 jf55hd4SYz8d02bzU648sBzC/+DCciyR94+G1IJBxts6kRBXFZRYvsnd9Y24KKsr3A
	 w7sQ27F/VP+uQ==
From: Tianyi Chen <hi@tychen.cc>
To: qmo@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Tianyi Chen <hi@tychen.cc>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Sun,  6 Sep 2026 22:39:50 +0800
Message-ID: <20260906143950.848769-2-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906143950.848769-1-hi@tychen.cc>
References: <20260906143950.848769-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Exercise recursive map dumping for array-of-maps and hash-of-maps,
including shared inner maps, empty outer and inner maps, BTF-formatted
values and multiple selected roots.

Check complete JSON documents against the existing nonrecursive entry
representations, and check plain headers and typed values. Verify both
short and long options, root ordering, deduplication and unchanged
default output.

All eight subtests pass in a matching-kernel VM.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 252 ++++++++++++++++++
 1 file changed, 252 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 00000000000..3c425dbe2d9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+
+#define OUTPUT_SIZE 8192
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
+	/* The helper doesn't terminate or strip the output. */
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
+				 3, &opts);
+	if (!ASSERT_OK_FD(outer_fd, "create_outer"))
+		goto out;
+	/* The unused third array slot also exercises failed lookups. */
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
+	/* Compare the complete JSON document: a flat array with the root first,
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
+	int i, len = 0;
+
+	/* Select the first inner map and both outers as roots. The other inner
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
+		len += snprintf(expected + len, sizeof(expected) - len,
+				"%s{\"id\":%u,\"type\":\"%s\",\"name\":\"%s\","
+				"\"flags\":0,\"elements\":%s}%s",
+				i ? "," : "[", ids[i], types[i],
+				i == 3 ? "dump_discovered" : name, elements, i == 3 ? "]" : "");
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
+void test_bpftool_map_dump(void)
+{
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

