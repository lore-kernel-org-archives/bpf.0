Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E93E7BCF
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095078; cv=none; b=oDOFVvxpKcfMKMKywu8g2krHjKU8an4MhVJstAE2luXGgN4sI32uA6eIZm+2CXyGe2hAgj7K1y0ODfmBmeLQZ6xzle2k2FCbfI9TnuUvwV2ATotFzTop4FRvKe1zlS2YfDKjED2riGQhwvlIYFqgMjW6Z/ANOZ8J8rKoBdpjCiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095078; c=relaxed/simple;
	bh=zvURFWGFPdfNk5U/W+Z+WZv9hpEt62uFkaWB8o08ac8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=giGyzyAseoG4ZPUxtWp0TxRWnFGhaKqwYnrJ93BdpUu3g+cOIBNOmnz3M+J+NE5YL/RE0egNUcdlLJDpOrceLfx1Mx8WsS4vXQrDPYxNThvo9bMbAkwLuVxhtg451mLBXQGVPEYWamPpXImMpv90pLuAkdDQPKMmwNXOIPspOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMbvvsxp; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMbvvsxp"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-38de693676dso249626a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095075; x=1789699875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o0Qq6S3MIWfNq1nMPGT25RdxPQqRqtg3e2EiLx0rO7U=;
        b=VMbvvsxposzUWefCgz7Wuwdl98jbvwhwzgalQHvbTgn2+/E69oo4wdmhFn8me3VBr6
         aCxoZwWzu2K7M1rnSGWpgSAAv5RH07WAkpiU23NOPeJhYVY/f2zRiZXKwWqRi5W46yIf
         lXli9yejWGcDhtaIqUas91bCAE3oa+Rj6T8IVFE2redEWp7MSPAoYsbl4nG+jV9PejO+
         +Ecv1fquVpNoaK+gkazu8QEQj3eLihYkFh/NWZvZafRZFtZjkrQ8ThAA6n1vDiE7GZQM
         /n/Z7qeNiTMmI4gpGfOykg9AJz2vnDobwGqIpdhUDvIZJqKZdCOrCoFkAi0OIJafRgfg
         fA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095075; x=1789699875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o0Qq6S3MIWfNq1nMPGT25RdxPQqRqtg3e2EiLx0rO7U=;
        b=oSmlPBazrFDF68j3yU3ZQ6nAIrVqLeoIUsFkP3PFrDSmyJgSasonUPBVezDG3ovNDA
         QuCcOB8ciltu6B7Mh0rfwZsH1oBWrefZum202HC2VHKkHrkU53rjM7a1sglTYT3Omyyf
         LM+X+ZKgyY7v0V941EMcfIAYsrpTj86HnXIjuFUp/8hGc06KM5YpkWasGyBArAXNDRku
         8lOd4v9wB7bktHbPHkhZrTdUzqM0MY3z4dfMimgYtKEFsYBTcXoiy33/lxOBCWKVr8BF
         kG/7LOU4uTy4PRUXTj0bdyj6iuZSvJFMJbN2vjduztvLawdJNWmWUfrXfaXJnjv5aHXV
         Ephw==
X-Forwarded-Encrypted: i=1; AKwUvBwEfwF5BY6MmXCRUY0YpxwdaC2FLFyD8+n2HtyAxVA7MvDq7LO8va/g0v7XjsGEDtaQgFI=@vger.kernel.org
X-Gm-Message-State: AFuF++mqeVpBLVmBaCfIIvGOqDvYD/yHFrtEkMJCmR2kDmQtpg1oj/mT
	q8nqiG/HSOyN5XpnSN+Ic8i6l5KC2ug66gHgdmM9Q1BWLoXdCvYTreVw
X-Gm-Gg: AYBFou20SkKjNdNaaBMK0WkylomCu24IVYdoBnZyA2ZF1Xk8eNi+I+TgIKNAi9nop8O
	AL/EevTYzDcgAVLRT1RdQjg+ecViaHhJ9ugV3zlkF4FPiFCuN7s+kPhdrZsTWVtLRYngbdy6mf1
	c3K89YgyZ4m6trKAsQQV6KSB02U/VQNmRe6bPbsTj2DNxP11kNWdW9u5HsseF+kMjpXe55uT7m4
	bzvxy1l7rlBpTkuUpY1/s/+xerl5Wb0bTqcZAfDsOv+LbEtBpq1W0WZSOofq8MhJ2YfIXooX3Gi
	n8wnFwI5eNq36kPz1RgDf4Cws0ofTmbisqge0ryLSkZgXcurRRV7Gx5YpfMo1uFbOKIBebznaW5
	sw3BM3AhHL+9U5PMf14cR2ciLG3Z+KxucduRWcsq0s/WamdAB0qCIG/n5MU4AC7KaKE0qtYUmK/
	ijNVAowE2cLLG7I41qahHMU+DFgEMLl0FWeVeE35oVG6RTNJmXVmRm3ZB/vE8vl2Ts7BVm9hJGC
	bc=
X-Received: by 2002:a17:90a:ec8c:b0:396:635a:9b10 with SMTP id 98e67ed59e1d1-39d9bf0af3fmr3460734a91.11.1789095074485;
        Thu, 10 Sep 2026 19:51:14 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95095946sm2363350a91.5.2026.09.10.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:51:14 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Cover recursive bpftool map dumps
Date: Fri, 11 Sep 2026 10:51:00 +0800
Message-ID: <20260911025100.190706-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911025100.190706-1-diannaaav@gmail.com>
References: <20260911025100.190706-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

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

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_dump.c         | 465 ++++++++++++++++++
 1 file changed, 465 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump.c
new file mode 100644
index 000000000000..db547a68d0a2
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

