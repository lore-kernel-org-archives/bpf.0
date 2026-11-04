Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818526;
	b=b0n/1e8/vBvuUCd4GZcK+cO7/3x+BhaDJU8VL7myobvNuoBXbCOLh+UDMt1cmFGAEvJ+
	 rWmhJbbhZddkyZ4qbgDgmPZoERNQuZvSX/IRmuGkRBel/06lJkZLnh48da/YKsdu/fI6H
	 hlTDECNDvUAlVa2+KYUiK0WxsJxjxh4n31Ye3hye9BLPG058nlLDjPEyLIJvMGY2uPLgE
	 h442DGI/0mnTANi7Ku1KRJg+2gWzQCoGOnGfAIBQL5Rtlblv4n3S2HEc2VIiZnv5uGLKH
	 F3QJRmbA7TkkVSSdTlcnWGs0WoSJeco85yG4HUZk/hWOYHjiXoSsgF53l1l3KhqiAbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818526;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Envelope-From;
	bh=eWC9X2U46fz8DB76WKnjUuDWQkP/04F7Y1N8G3j7Q84=;
	b=nhENefV0aQx1E/Bag9PykNewELk/8IiNj/O7TGGSw807pzbZmxz0tG9bG0JU1WbPNgKg
	 +vKRHYSPwYPy40sZn/+CBfyJ5LVDhoPHTizL6iZKfPpG2xN0UZLX2K9CTL9CMN/rPKvsv
	 Y8vdzcxR3hFu1TnYCejEZJ2c6UuKR+tRkg32FNel95ciuRwqWDGnMPKe3Wis2Ha9snutR
	 lRfqhQgEyLJ6ufjXGRi4ijf3dk/yfOHe8N+06Takanx4E0+S9R46Qk+2dUyv4behRwOyH
	 YEvQo15G5rPqVExwX49O/ch5CPsHjJqMskuqeGeRVjnL+EEvw0Z0myJ8/mQ/uYTATTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tychen.cc;
	spf=pass smtp.mailfrom=tychen.cc;
	dkim=pass header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=aGDxZHX7;
	arc=none smtp.remote-ip=198.54.127.75
Received: from out-zbxj-a75.jellyfish.systems (out-zbxj-a75.jellyfish.systems [198.54.127.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F10606D806
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 18:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F10606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tychen.cc header.i=@tychen.cc header.a=rsa-sha256 header.s=spacemail header.b=aGDxZHX7
Received: from fedora (ec2-52-197-241-54.ap-northeast-1.compute.amazonaws.com [52.197.241.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4jKZPc02pYz8sWQ;
	Wed, 04 Nov 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1793818503;
	bh=eWC9X2U46fz8DB76WKnjUuDWQkP/04F7Y1N8G3j7Q84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGDxZHX7j5Kr3Ubf/FTTlXK+IHitduv71ZcKJN6Bg08BPcMaCAH9P1gnz0bPr+Vhk
	 ZcG7jySOUvp6FM11DFsU8h4B+0ucDlSb+h2Ra54BD329ED/nLAXdLkxMVSX7CJSuh6
	 RGLRCkyM59b5ARDUm71RJUeECfQ7AlkF4MHrZsy0oy7xCV0mSvPR0+Rm3BwfKdYyyS
	 zwkyJwZy4noSW9V+IiwaudMTVQrMKxhpX06UnNadkzS7RBdeK7Nv6bMzw83X+HCbZG
	 /i63EHtNMzlC6Mk5GwzVatop1oNNhyZAl6Q0AwFxKe1R5E2+KYdBOddnoDog3BJFPN
	 Vz2zvULn2LZiQ==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	qmo@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	alexei.starovoitov@gmail.com,
	skokovmaksimevg@gmail.com
Subject: [PATCH bpf-next v11 3/3] selftests/bpf: Cover recursive bpftool map dumps
Date: Thu,  5 Nov 2026 03:54:39 +0900
Message-ID: <9a0298fe0bc97f58bc5482f5642bc58835b2d3a1.1793818386.git.hi@tychen.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793818386.git.hi@tychen.cc>
References: <cover.1793818386.git.hi@tychen.cc>
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

Check that a recursive dump of an array_of_maps or a hash_of_maps
equals the default dump with the dump of each inner map added to the
entry that refers to it, in JSON and plain output. The maps include an
inner map shared by two entries, an empty inner map, an empty array
slot, inner maps with and without BTF, and two outer maps selected by
name.

Make one inner map impossible to open with an fmod_ret program on
security_bpf_map(), as if it had been replaced, and check that only its
entry reports an error while the dump succeeds. Also check that the
keyword does not change the dumps of other maps or of empty maps of
maps, and that invalid or misplaced arguments are rejected.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../prog_tests/bpftool_map_dump_recursive.c   | 375 ++++++++++++++++++
 .../bpf/progs/bpftool_map_dump_recursive.c    |  17 +
 2 files changed, 392 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
new file mode 100644
index 0000000000000..4d0083a18ce16
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_dump_recursive.c
@@ -0,0 +1,375 @@
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
+	const char *tag = "inner_map_id: ", *p, *eol;
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
+		    !append(expected, &len, "%u: %s  name %s  flags 0x%x\n%s", id,
+			    libbpf_bpf_map_type_str(info.type), info.name,
+			    info.map_flags, inner))
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
+	char handle[32], token[64], output[OUTPUT_SIZE];
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
+	snprintf(token, sizeof(token), "%u: hash  name rec_b  flags 0x0\nFound 0 elements\n",
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
+	char dump[OUTPUT_SIZE], output[OUTPUT_SIZE];
+	const char * const options[] = { "", "-j " };
+	int fds[] = { -1, -1 };
+	size_t i, j;
+
+	fds[0] = create_inner("rec_a", NULL, true);
+	if (fds[0] < 0)
+		return;
+	fds[1] = bpf_map_create(BPF_MAP_TYPE_HASH_OF_MAPS, "rec_empty", 4, 4, 1,
+				&(struct bpf_map_create_opts){
+					.sz = sizeof(struct bpf_map_create_opts),
+					.inner_map_fd = fds[0],
+				});
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
index 0000000000000..baa44070bcda2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bpftool_map_dump_recursive.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define ENOENT 2
+
+char _license[] SEC("license") = "GPL";
+
+/* Opening this map fails as if it had been freed. */
+__u32 hidden_id;
+
+SEC("fmod_ret/security_bpf_map")
+int BPF_PROG(hide_map, struct bpf_map *map, int fmode)
+{
+	return map->id == hidden_id ? -ENOENT : 0;
+}
-- 
2.56.0

