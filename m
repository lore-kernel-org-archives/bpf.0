Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.177.127.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794381614;
	b=gU+frfRVrSpCDg+l9Prm14CgsGGYQL4v1Gt90RnD7bNq+F8RmMdazC+m9ukyNz3+XGfl
	 0omchxE9fKNDKfu1dnqV52AUT8B0iCBba9aXoy9hnRzfgik2YThplGeMg40DypYUwA7XS
	 O4LLh7LImXvKFIejyfX5E41U3n2EiXaxjtG04RZzl6jIJhPGE3lBfKIdjL0rUGuEaMr23
	 j/vPlMjp9Oe2Mh8vhFYVx7pB8E6Ana5NR5J/vmFp+358iFpalj1TvOYVSRAqpcXlZY54E
	 rP2gTnhO5WGGKi/aA+ydTQy+G7cIJXR4BgECJgcA77Lu8rTCIRnAoF8giM7IbaMOo8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381614;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=vld2XnWSGvIu2UBZTKucsRLako0xFO5EnFDZKpfpIKA=;
	b=iZw54/hjLuLeQausrysukLX7gpDys0gOxxvh9KD3Ggo4TXRDWI62vMQsk/bc5lbTTwue
	 0REVB65i6v2TiXJmtye7/rq/21rgcb6+LcgZnzcxNZjKCyD2EDzvJvms4sUZ6GEsPVYi6
	 AzJUqP3Scc10aBBPoNpMzkE7n1Gu1KyLMIutlxiiD0ZCU2h4zmf8L6ho1MC3GAba0dece
	 xG/nzb36Kv0Llguq+rKyrs40x/8lig93XD4gD+C+YPTg8g9Du905uR0fQlkL2PPfzmZWW
	 +V/CJeCkNMYyphTmyLTuZnhBnRj0T6BPaPTGVB41/bZ6fCGGptZmOb8+cy8sRw5R+/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=eEeOWS4i;
	arc=none smtp.remote-ip=198.177.127.205
Received: from out-utut-a205.jellyfish.systems (out-utut-a205.jellyfish.systems [198.177.127.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475560A2613
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 07:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0475560A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=eEeOWS4i
Received: from fedora (unknown [151.145.76.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jPZfH2VvPz8sWR;
	Wed, 11 Nov 2026 07:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1794381596;
	bh=vld2XnWSGvIu2UBZTKucsRLako0xFO5EnFDZKpfpIKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEeOWS4ioY6iRWzxCKsVneklBsnYN9JDabaVViG/Qcbxjze5YUJOmwBMcjCfaEztc
	 zeWhWFIq4hqLabQ5UGJz+tbbjvWj8TFYKgIKJIWlh8qwI4ozcS6Hz6AF51Ixd04zQk
	 Ock3BZBf71eKoEs9vV5mXaFPqIfqe3MUKMv5XPQhc2TJHS6qWUCXlWQmwUt09Uqj/H
	 ODffy+csuwe/X0O1T6Oj9FZafpLbLQYIC4cc7NI4w/7dafnnvSf5PiPpFyUVgPO/oW
	 Tdl0e2W4IKmApXJtpMrbGAjo6dLfUaeZd8kbnsqad6G2eI7gb9nw+ct+1k7FW/q+vG
	 G1j6ltx1PIVwg==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	qmo@kernel.org,
	ihor.solodrai@linux.dev
Subject: [PATCH bpf-next v12 3/3] selftests/bpf: Cover recursive bpftool map dumps
Date: Wed, 11 Nov 2026 16:19:27 +0900
Message-ID: <be760a15c78cd2e7e27fc8b9bad6142488827573.1794380385.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794380385.git.hi@tychen.cc>
References: <cover.1794380385.git.hi@tychen.cc>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Compare recursive dumps of array_of_maps and hash_of_maps with individual
inner-map dumps in JSON and plain output. Cover shared and empty inner
maps, an empty array slot, BTF values, and multiple roots selected by
name. Check indentation of wrapped keys, values and per-CPU entries.

Use fmod_ret to make an inner map unavailable and check that only its
entry reports an error. Count lookup calls to check that outer entries
are read individually while inner maps still use batches. Also check
unchanged output without recursion and reject invalid arguments.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../prog_tests/bpftool_map_dump_recursive.c   | 480 ++++++++++++++++++
 .../bpf/progs/bpftool_map_dump_recursive.c    |  38 ++
 2 files changed, 518 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
new file mode 100644
index 000000000000..bc82d1cd5645
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
@@ -0,0 +1,480 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdarg.h>
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+#include "bpftool_map_dump_recursive.skel.h"
+
+#define OUTPUT_SIZE 16384
+
+static bool run(char *output, const char *fmt, ...)
+{
+	char command[MAX_BPFTOOL_CMD_LEN];
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(command, sizeof(command), fmt, ap);
+	va_end(ap);
+	output[0] = '\0';
+	return ASSERT_OK(get_bpftool_command_output(command, output, OUTPUT_SIZE),
+			 command) &&
+	       ASSERT_LT(strlen(output), OUTPUT_SIZE - 1, "output_fits");
+}
+
+static bool append(char *buf, size_t *len, const char *fmt, ...)
+{
+	va_list ap;
+	int n;
+
+	va_start(ap, fmt);
+	n = vsnprintf(buf + *len, OUTPUT_SIZE - *len, fmt, ap);
+	va_end(ap);
+	if (!ASSERT_GE(n, 0, "format") || !ASSERT_LT(n, OUTPUT_SIZE - *len, "expected_fits"))
+		return false;
+	*len += n;
+	return true;
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
+static bool map_info(__u32 id, struct bpf_map_info *info)
+{
+	__u32 len = sizeof(*info);
+	int fd, err;
+
+	memset(info, 0, sizeof(*info));
+	fd = bpf_map_get_fd_by_id(id);
+	if (!ASSERT_OK_FD(fd, "map_fd"))
+		return false;
+	err = bpf_map_get_info_by_fd(fd, info, &len);
+	close(fd);
+	return ASSERT_OK(err, "map_info");
+}
+
+/* Expect an "inner_map" member after each "inner_map_id" of a default dump. */
+static bool expect_json(const char *dump, __u32 hidden, char *expected)
+{
+	const char *tag = "\"inner_map_id\":", *p;
+	char inner[OUTPUT_SIZE];
+	struct bpf_map_info info;
+	size_t len = 0;
+	char *end;
+	__u32 id;
+
+	while ((p = strstr(dump, tag))) {
+		id = strtoul(p + strlen(tag), &end, 10);
+		if (!append(expected, &len, "%.*s,\"inner_map\":", (int)(end - dump), dump))
+			return false;
+		dump = end;
+		if (id == hidden) {
+			if (!append(expected, &len, "{\"error\":\"can't get map by id (%u): %s\"}",
+				    id, strerror(ENOENT)))
+				return false;
+			continue;
+		}
+		if (!map_info(id, &info) || !run(inner, "-j map dump id %u", id))
+			return false;
+		inner[strcspn(inner, "\n")] = '\0';
+		if (!append(expected, &len,
+			    "{\"id\":%u,\"type\":\"%s\",\"name\":\"%s\",\"flags\":%u,\"elements\":%s}",
+			    id, libbpf_bpf_map_type_str(info.type), info.name,
+			    info.map_flags, inner))
+			return false;
+	}
+	return append(expected, &len, "%s", dump);
+}
+
+/* Expect the inner map after each "inner_map_id" line of a default dump. */
+static bool expect_plain(const char *dump, __u32 hidden, char *expected)
+{
+	const char *tag = "inner_map_id: ", *p, *eol, *line;
+	char inner[OUTPUT_SIZE];
+	struct bpf_map_info info;
+	size_t len = 0;
+	__u32 id;
+
+	while ((p = strstr(dump, tag))) {
+		id = strtoul(p + strlen(tag), NULL, 10);
+		eol = strchr(p, '\n');
+		if (!ASSERT_OK_PTR(eol, "entry_line") ||
+		    !append(expected, &len, "%.*s", (int)(eol + 1 - dump), dump))
+			return false;
+		dump = eol + 1;
+		if (id == hidden)
+			continue;
+		if (!map_info(id, &info) || !run(inner, "map dump id %u", id) ||
+		    !append(expected, &len, "\n    %u: %s  name %s  flags 0x%x\n", id,
+			    libbpf_bpf_map_type_str(info.type), info.name,
+			    info.map_flags))
+			return false;
+		for (line = inner; *line; line = eol + 1) {
+			eol = strchr(line, '\n');
+			if (!ASSERT_OK_PTR(eol, "inner_line") ||
+			    !append(expected, &len, "    %.*s\n", (int)(eol - line), line))
+				return false;
+		}
+		if (!append(expected, &len, "\n"))
+			return false;
+	}
+	return append(expected, &len, "%s", dump);
+}
+
+static void check_dumps(const char *handle, __u32 hidden, bool plain)
+{
+	char dump[OUTPUT_SIZE], expected[OUTPUT_SIZE], output[OUTPUT_SIZE];
+
+	if (run(dump, "-j map dump %s", handle) &&
+	    expect_json(dump, hidden, expected) &&
+	    run(output, "-j map dump %s recursive", handle))
+		ASSERT_STREQ(output, expected, "json");
+	if (plain && run(dump, "map dump %s", handle) &&
+	    expect_plain(dump, hidden, expected) &&
+	    run(output, "map dump %s recursive 2>/dev/null", handle))
+		ASSERT_STREQ(output, expected, "plain");
+}
+
+static int create_inner(const char *name, struct btf **btf, bool populate)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	__u32 key = 0, value = 0x01010101;
+	int fd;
+
+	if (btf) {
+		*btf = btf__new_empty();
+		if (!ASSERT_OK_PTR(*btf, "btf_new") ||
+		    !ASSERT_EQ(btf__add_int(*btf, "unsigned int", 4, 0), 1, "btf_int") ||
+		    !ASSERT_OK(btf__load_into_kernel(*btf), "btf_load"))
+			return -1;
+		opts.btf_fd = btf__fd(*btf);
+		opts.btf_key_type_id = 1;
+		opts.btf_value_type_id = 1;
+	}
+	fd = bpf_map_create(BPF_MAP_TYPE_HASH, name, sizeof(key), sizeof(value), 1, &opts);
+	if (!ASSERT_OK_FD(fd, "create_inner"))
+		return -1;
+	if (populate && !ASSERT_OK(bpf_map_update_elem(fd, &key, &value, BPF_ANY),
+				   "update_inner")) {
+		close(fd);
+		return -1;
+	}
+	return fd;
+}
+
+/* Entries 0 and 2 share @a, entry 1 refers to @b; arrays leave slot 3 empty. */
+static int create_outer(enum bpf_map_type type, const char *name, int a, int b)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .inner_map_fd = a);
+	int inner[] = { a, b, a };
+	__u32 key;
+	int fd;
+
+	fd = bpf_map_create(type, name, sizeof(key), sizeof(__u32), 4, &opts);
+	if (!ASSERT_OK_FD(fd, "create_outer"))
+		return -1;
+	for (key = 0; key < ARRAY_SIZE(inner); key++) {
+		if (!ASSERT_OK(bpf_map_update_elem(fd, &key, &inner[key], BPF_ANY),
+			       "update_outer")) {
+			close(fd);
+			return -1;
+		}
+	}
+	return fd;
+}
+
+static void test_outer(enum bpf_map_type type, bool typed_inner)
+{
+	char handle[32], token[96], output[OUTPUT_SIZE];
+	int a = -1, b = -1, outer = -1;
+	struct btf *btf = NULL;
+	__u32 a_id, b_id;
+
+	a = create_inner("rec_a", typed_inner ? &btf : NULL, true);
+	b = create_inner("rec_b", NULL, false);
+	if (a < 0 || b < 0)
+		goto out;
+	outer = create_outer(type, "rec_outer", a, b);
+	if (outer < 0)
+		goto out;
+	snprintf(handle, sizeof(handle), "id %u", map_id(outer));
+	check_dumps(handle, 0, !typed_inner);
+	if (!typed_inner)
+		goto out;
+
+	/* Plain output uses BTF for the inner maps that have it. */
+	a_id = map_id(a);
+	b_id = map_id(b);
+	if (!run(output, "map dump %s recursive", handle))
+		goto out;
+	snprintf(token, sizeof(token), "\"id\": %u,", a_id);
+	ASSERT_EQ(count_token(output, token), 2, "btf_inner_dumps");
+	ASSERT_EQ(count_token(output, "\"value\": 16843009"), 2, "btf_inner_values");
+	snprintf(token, sizeof(token),
+		 "    %u: hash  name rec_b  flags 0x0\n    Found 0 elements\n",
+		 b_id);
+	ASSERT_EQ(count_token(output, token), 1, "plain_inner_dump");
+out:
+	if (outer >= 0)
+		close(outer);
+	if (a >= 0)
+		close(a);
+	if (b >= 0)
+		close(b);
+	btf__free(btf);
+}
+
+static void test_plain_layout(bool percpu)
+{
+	int inner = -1, outer = -1, cpus;
+	char command[64], *output = NULL;
+	__u32 key[5] = {};
+	size_t output_size;
+	void *values;
+
+	cpus = percpu ? libbpf_num_possible_cpus() : 1;
+	if (!ASSERT_GT(cpus, 0, "possible_cpus"))
+		return;
+	values = calloc(cpus, 24);
+	/* Three inner dumps, including per-CPU labels and indentation. */
+	output_size = 1024 + (size_t)cpus * 512;
+	output = malloc(output_size);
+	if (!ASSERT_OK_PTR(values, "values") || !ASSERT_OK_PTR(output, "output"))
+		goto out;
+
+	/* Long keys and values wrap; per-CPU values also have separate labels. */
+	inner = bpf_map_create(percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_HASH,
+			       "rec_layout", percpu ? 4 : sizeof(key), 20, 1, NULL);
+	if (!ASSERT_OK_FD(inner, "create_inner") ||
+	    !ASSERT_OK(bpf_map_update_elem(inner, key, values, BPF_ANY), "update_inner"))
+		goto out;
+	outer = create_outer(BPF_MAP_TYPE_HASH_OF_MAPS, "rec_outer", inner, inner);
+	if (outer < 0)
+		goto out;
+	snprintf(command, sizeof(command), "map dump id %u recursive", map_id(outer));
+	if (!ASSERT_OK(get_bpftool_command_output(command, output, output_size), "dump") ||
+	    !ASSERT_LT(strlen(output), output_size - 1, "output_fits"))
+		goto out;
+	ASSERT_EQ(count_token(output, "\n    key:\n"), 3, "key_labels");
+	ASSERT_EQ(count_token(output, percpu ? "\n    value (CPU " : "\n    value:\n"),
+		  3 * (percpu ? cpus : 1), "value_labels");
+	ASSERT_EQ(count_token(output,
+			      "\n    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00\n"),
+		  3 * (percpu ? cpus : 2), "first_hex_lines");
+	/* A per-CPU map also prints its four-byte key on a separate line. */
+	ASSERT_EQ(count_token(output, "\n    00 00 00 00\n"),
+		  3 * (percpu ? cpus + 1 : 2), "last_hex_lines");
+	ASSERT_EQ(count_token(output, "\n    Found 1 element\n\n"), 3, "inner_counts");
+out:
+	if (outer >= 0)
+		close(outer);
+	if (inner >= 0)
+		close(inner);
+	free(output);
+	free(values);
+}
+
+static void test_batch_lookups(enum bpf_map_type type)
+{
+	const char * const options[] = { "", "-j " };
+	struct bpftool_map_dump_recursive *skel;
+	char output[OUTPUT_SIZE];
+	int inner = -1, outer = -1;
+	__u32 id;
+	size_t i;
+
+	skel = bpftool_map_dump_recursive__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+	skel->bss->test_tgid = getpid();
+	if (!ASSERT_OK(bpftool_map_dump_recursive__attach(skel), "skel_attach"))
+		goto out;
+	inner = create_inner("rec_a", NULL, true);
+	if (inner < 0)
+		goto out;
+	outer = create_outer(type, "rec_outer", inner, inner);
+	if (outer < 0)
+		goto out;
+	id = map_id(outer);
+	for (i = 0; i < ARRAY_SIZE(options); i++) {
+		skel->bss->batch_calls = 0;
+		skel->bss->elem_calls = 0;
+		if (!run(output, "%smap dump id %u recursive", options[i], id))
+			break;
+		/* Only the three inner dumps use batches; array slot 3 is empty. */
+		ASSERT_EQ(skel->bss->batch_calls, 3, "inner_batches");
+		ASSERT_EQ(skel->bss->elem_calls,
+			  type == BPF_MAP_TYPE_ARRAY_OF_MAPS ? 4 : 3, "outer_lookups");
+	}
+out:
+	if (outer >= 0)
+		close(outer);
+	if (inner >= 0)
+		close(inner);
+	bpftool_map_dump_recursive__destroy(skel);
+}
+
+static void test_missing_inner(void)
+{
+	char handle[32], message[96], output[OUTPUT_SIZE];
+	struct bpftool_map_dump_recursive *skel;
+	int a = -1, b = -1, outer = -1;
+	__u32 hidden;
+
+	skel = bpftool_map_dump_recursive__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+	if (!ASSERT_OK(bpftool_map_dump_recursive__attach(skel), "skel_attach"))
+		goto out;
+	a = create_inner("rec_a", NULL, true);
+	b = create_inner("rec_b", NULL, true);
+	if (a < 0 || b < 0)
+		goto out;
+	outer = create_outer(BPF_MAP_TYPE_HASH_OF_MAPS, "rec_outer", a, b);
+	hidden = map_id(b);
+	if (outer < 0 || !hidden)
+		goto out;
+	snprintf(handle, sizeof(handle), "id %u", map_id(outer));
+	skel->bss->hidden_id = hidden;
+
+	/* Only the entry of the missing map has an error; the dump succeeds. */
+	check_dumps(handle, hidden, true);
+	snprintf(message, sizeof(message), "Error: can't get map by id (%u): %s\n",
+		 hidden, strerror(ENOENT));
+	if (run(output, "map dump %s recursive 2>&1 >/dev/null", handle))
+		ASSERT_STREQ(output, message, "plain_error");
+out:
+	if (outer >= 0)
+		close(outer);
+	if (a >= 0)
+		close(a);
+	if (b >= 0)
+		close(b);
+	bpftool_map_dump_recursive__destroy(skel);
+}
+
+static void test_multiple_roots(void)
+{
+	int a = -1, b = -1, outer[] = { -1, -1 };
+	char name[BPF_OBJ_NAME_LEN], handle[32];
+	size_t i;
+
+	snprintf(name, sizeof(name), "rec_root_%u", getpid() % 100000);
+	a = create_inner("rec_a", NULL, true);
+	b = create_inner("rec_b", NULL, false);
+	if (a < 0 || b < 0)
+		goto out;
+	for (i = 0; i < ARRAY_SIZE(outer); i++) {
+		outer[i] = create_outer(BPF_MAP_TYPE_ARRAY_OF_MAPS, name, a, b);
+		if (outer[i] < 0)
+			goto out;
+	}
+	snprintf(handle, sizeof(handle), "name %s", name);
+	check_dumps(handle, 0, true);
+out:
+	for (i = 0; i < ARRAY_SIZE(outer); i++)
+		if (outer[i] >= 0)
+			close(outer[i]);
+	if (a >= 0)
+		close(a);
+	if (b >= 0)
+		close(b);
+}
+
+/* The keyword has no effect on other maps or on maps of maps without entries. */
+static void test_unchanged(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts);
+	char dump[OUTPUT_SIZE], output[OUTPUT_SIZE];
+	const char * const options[] = { "", "-j " };
+	int fds[] = { -1, -1 };
+	size_t i, j;
+
+	fds[0] = create_inner("rec_a", NULL, true);
+	if (fds[0] < 0)
+		return;
+	opts.inner_map_fd = fds[0];
+	fds[1] = bpf_map_create(BPF_MAP_TYPE_HASH_OF_MAPS, "rec_empty", 4, 4, 1, &opts);
+	if (!ASSERT_OK_FD(fds[1], "create_outer"))
+		goto out;
+	for (i = 0; i < ARRAY_SIZE(fds); i++) {
+		for (j = 0; j < ARRAY_SIZE(options); j++) {
+			if (run(dump, "%smap dump id %u", options[j], map_id(fds[i])) &&
+			    run(output, "%smap dump id %u recursive", options[j],
+				map_id(fds[i])))
+				ASSERT_STREQ(output, dump, "unchanged");
+		}
+	}
+out:
+	for (i = 0; i < ARRAY_SIZE(fds); i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+}
+
+static void test_arguments(void)
+{
+	const char * const invalid[] = { "''", "unknown", "recursive unknown" };
+	char command[MAX_BPFTOOL_CMD_LEN], output[OUTPUT_SIZE] = {};
+	__u32 id;
+	size_t i;
+	int fd;
+
+	fd = create_inner("rec_args", NULL, false);
+	if (fd < 0)
+		return;
+	id = map_id(fd);
+	for (i = 0; i < ARRAY_SIZE(invalid); i++) {
+		snprintf(command, sizeof(command), "map dump id %u %s", id, invalid[i]);
+		ASSERT_NEQ(run_bpftool_command(command), 0, invalid[i]);
+	}
+	snprintf(command, sizeof(command), "map dump id %u rec", id);
+	ASSERT_OK(run_bpftool_command(command), "prefix");
+	snprintf(command, sizeof(command), "-j map dump recursive id %u", id);
+	ASSERT_NEQ(get_bpftool_command_output(command, output, sizeof(output)), 0,
+		   "misplaced_recursive");
+	ASSERT_HAS_SUBSTR(output, "got: 'recursive'", "misplaced_error");
+	close(fd);
+}
+
+void test_bpftool_map_dump_recursive(void)
+{
+	if (test__start_subtest("array_of_maps"))
+		test_outer(BPF_MAP_TYPE_ARRAY_OF_MAPS, false);
+	if (test__start_subtest("hash_of_maps"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, false);
+	if (test__start_subtest("btf_inner"))
+		test_outer(BPF_MAP_TYPE_HASH_OF_MAPS, true);
+	if (test__start_subtest("wide_inner"))
+		test_plain_layout(false);
+	if (test__start_subtest("percpu_inner"))
+		test_plain_layout(true);
+	if (test__start_subtest("batch_array_of_maps"))
+		test_batch_lookups(BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	if (test__start_subtest("batch_hash_of_maps"))
+		test_batch_lookups(BPF_MAP_TYPE_HASH_OF_MAPS);
+	if (test__start_subtest("missing_inner"))
+		test_missing_inner();
+	if (test__start_subtest("multiple_roots"))
+		test_multiple_roots();
+	if (test__start_subtest("unchanged"))
+		test_unchanged();
+	if (test__start_subtest("arguments"))
+		test_arguments();
+}
diff --git a/tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c b/tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c
new file mode 100644
index 000000000000..b130cd493d3a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_core_read.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define ENOENT 2
+
+char _license[] SEC("license") = "GPL";
+
+/* Opening this map fails as if it had been freed. */
+__u32 hidden_id;
+int test_tgid;
+int batch_calls;
+int elem_calls;
+
+SEC("fmod_ret/security_bpf_map")
+int BPF_PROG(hide_map, struct bpf_map *map, int fmode)
+{
+	return map->id == hidden_id ? -ENOENT : 0;
+}
+
+SEC("fmod_ret/security_bpf")
+int BPF_PROG(count_lookups, int cmd, union bpf_attr *attr,
+	     unsigned int size, bool kernel)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	if (kernel ||
+	    (BPF_CORE_READ(task, real_parent, tgid) != test_tgid &&
+	     BPF_CORE_READ(task, real_parent, real_parent, tgid) != test_tgid))
+		return 0;
+	if (cmd == BPF_MAP_LOOKUP_BATCH)
+		batch_calls++;
+	else if (cmd == BPF_MAP_LOOKUP_ELEM)
+		elem_calls++;
+	return 0;
+}
-- 
2.56.0

