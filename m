Received: from out-utut-a220.jellyfish.systems (out-utut-a220.jellyfish.systems [198.177.127.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A752C0261
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 01:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.177.127.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744103; cv=none; b=SLlj1d+XoJIUNhb2iYg/7LgGVBoYcXh2e9nwC13DkfM2k2PbkhdEQiWia2ptFcBOKHiS7UrBeQK1d7fVaICJvwWzFxkDPSQ+FCHyBkTDTa3FXBfLTsMFNf81jq5ZLy89ajoU0/23Mnk/i7juwNKjQBlJeeATr5frqZz03JQFOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744103; c=relaxed/simple;
	bh=xyW6NXUVCY7QvDdpzAk9YGLQfhKCI8Eg3TBCGXOR9uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5bDfGn2L45+7Fv6jNMRg5lWbNJeqSITGPCxENXfpP+qf21jS1UVnR4to54erZaqIjdoGuDhIRpEcPgcjkj7J7VUXYJYWtuiAY6R0gVnhmlGSphiHO9avwfKylYipLF11xDtD/N5D54CAVrpznO0ooRb3Ya06KbhZtQzyPFFHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=F+QAlc0M; arc=none smtp.client-ip=198.177.127.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="F+QAlc0M"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdTmv3T37z2x9C;
	Mon, 07 Sep 2026 01:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788744098;
	bh=Cggm1U35O7+wM6fnvzbwxQkZSp4QFPXKW7P1zMc4Aw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+QAlc0MuQwhpyiM4o7CefFWK5JTAjrwd49a9SSPMIjny+HmCIglIo7Ky2FIQF79m
	 n2G77tjbjep614wOMMifz+bBmaytJcit3lIR8wtfWvmQZnNlto2Ds0RL8V0Ify22/6
	 wBVP8c2ssCAP/8tr1Ai1NHKhA6laBOljdnYRBZg6KFrQ9GHOl9e92jQ0Tm3h8g6NG3
	 tNF7yF/F1RUidAedaNcLuiI5eftXOoELVXQEaoaXMFM763OstAZ/+YGCyvnpymyON4
	 mHTpBoixbHkrzeNCGiuZHZ/4Wtj3Rr01jcUwwc2ld4NnpAMZXPSkARIQddnSN1ED35
	 dHd3Mj3CzlnWg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Mon,  7 Sep 2026 09:21:27 +0800
Message-ID: <178874362960.1415955.11629203769007485967.recursive-v3-2@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874362960.1415955.7640440818340667463.recursive-v3-0@tychen.cc>
References: <178870998583.979169.16526173782819097354@tychen.cc> <178874362960.1415955.7640440818340667463.recursive-v3-0@tychen.cc>
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

Cover ordinary and nested perf event arrays to ensure unsupported
element lookups retain their error markers without failing the dump.
Dump 64 distinct inner maps under RLIMIT_NOFILE=32 in both JSON and
plain modes to catch holding every discovered inner-map FD open.

Open 32 extra descriptors before forking, close inherited descriptors
in the child before imposing the limit, and verify the parent's file
descriptors and outer map remain usable.

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 465 ++++++++++++++++++
 1 file changed, 465 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 00000000000..9c88743a8f8
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
@@ -0,0 +1,465 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+#include <sys/resource.h>
+#include <dirent.h>
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
+				  3, &opts);
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
+	int i, len = 0;
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
+	output = calloc(1, 65536);
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
+			_exit(6);
+		/* The parent keeps the outer map and its inner maps alive. */
+		for (;;) {
+			char *end;
+			long fd;
+
+			errno = 0;
+			entry = readdir(dir);
+			if (!entry) {
+				if (errno)
+					_exit(6);
+				break;
+			}
+			fd = strtol(entry->d_name, &end, 10);
+			if (*end || fd < 3 || fd == dirfd(dir))
+				continue;
+			close(fd);
+		}
+		if (closedir(dir))
+			_exit(6);
+		if (setrlimit(RLIMIT_NOFILE, &limit))
+			_exit(1);
+		snprintf(command, sizeof(command), "%s -r map dump id %u",
+			 json ? "-j" : "", root_id);
+		if (get_bpftool_command_output(command, output, 65535))
+			_exit(2);
+		if (count_token(output, json ? "\"id\":" : "Found ") != ARRAY_SIZE(ids) + 1 ||
+		    count_token(output, json ? "\"inner_map_id\":" : "inner_map_id:") !=
+		    ARRAY_SIZE(ids))
+			_exit(3);
+		for (key = 0; key < ARRAY_SIZE(ids); key++) {
+			if (json)
+				snprintf(token, sizeof(token), "\"id\":%u,", ids[key]);
+			else
+				snprintf(token, sizeof(token), "\n%u: hash  name dump_inner  ",
+					 ids[key]);
+			if (count_token(output, token) != 1)
+				_exit(4);
+		}
+		if (json && (output[0] != '[' ||
+			     strcmp(output + strlen(output) - 2, "]\n")))
+			_exit(5);
+		_exit(0);
+	}
+	if (ASSERT_EQ(waitpid(pid, &status, 0), pid, "waitpid") &&
+	    ASSERT_TRUE(WIFEXITED(status), "child_exited"))
+		ASSERT_EQ(WEXITSTATUS(status), 0, "dump_with_low_fd_limit");
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

