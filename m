Received: from out-93wp-a21.jellyfish.systems (out-93wp-a21.jellyfish.systems [104.207.68.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3253E1CFB
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788747343; cv=none; b=qB2o4Bnbd7dY8HZ/rcym3RAOuOigxA0+ygglFGD0Ft60iUEB62OJfTp4W5sohvfKediILhxDPFiPbLhd/ACFXoJ8XyaXLCObe498FAIpBmFYc3Ioggo5r6eplLPiB0O6+uiuo7cRQ7f+nZL5KjYv2XXwqPg2ks6ccweHkG1O7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788747343; c=relaxed/simple;
	bh=V24EdTx0Jc3b4YquY5iKBvYsiJvrFgyxPWaiu4uUAN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDMGS3AQBHRy8IUEHR+3rgctDszQE6EVqnURJ4mk+OjNA0M2krwGyY/akz1fNza+8I7z8ZYx02GkjkXAPZahBvv9qRUDtmfBXIyo1XY5DxSsu5XkuV8nINZ1xMMd3y7pARM4ZD1jX29men41/il+xX8IibHP9I8gTf97VLGTwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=mmhjXOtN; arc=none smtp.client-ip=104.207.68.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="mmhjXOtN"
Received: from 192.168.5.3 (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdVyz1wxGz2x9N;
	Mon, 07 Sep 2026 02:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788747325;
	bh=xM7csDhXm8uOsmjo6YRZ+NmRhstWabkie9x2z0r7Ab8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmhjXOtN4XHHUa90nvjvKUifxB21fnuCA3vtB+y8r2zftVzCkI1eAIMgSCnmcxzKn
	 IUcyisgnfekr0TU4aNOgnnRy1ShzVvqHYKlnQJvpc+RDztuvXntlOMWfDe2lmVHYdS
	 HN0D8TMsqHaRFDBhM+Vl3DeTh6SCUyop4ORVTkIiIaRWE4PCslRDX8JW9+uHJk8GYB
	 Lt9D8yzcTzodV06qFnyscAHR+w8Kg1ChyubAVP3vibnnlLIOKJTGrenRXK2UidTswW
	 E8vKIS0WnLsHzhoqhDo0KDYPXJ0+YWAlxbMemVcqcOqJk3fPp2Bw01aDsoti8/IQ5S
	 QUMiCPXOrqlzw==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	linux-kselftest@vger.kernel.org,
	hi@tychen.cc
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Cover symbolic bpftool map creation flags
Date: Mon,  7 Sep 2026 10:15:16 +0800
Message-ID: <178874713816.1519295.11686841174785622807.flags-v3-2@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc>
References: <178874362959.1415955.5742268739057412911.flags-v2-0@tychen.cc> <178874713816.1519295.5079603775338308680.flags-v3-0@tychen.cc>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

Check numeric and symbolic map creation flags, including combined and
repeated names, against map information read independently with libbpf.
Exercise malformed names and lists, update-only flags, empty input and
numeric range errors. Verify rejected input leaves no pinned map.

Assisted-by: Codex:GPT-6
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_flags.c        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
new file mode 100644
index 00000000000..d617b43273a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <errno.h>
+#include <unistd.h>
+#include <bpf/bpf.h>
+#include <bpftool_helpers.h>
+#include <test_progs.h>
+
+static const struct map_flags_test {
+	const char *name;
+	const char *flags;
+	__u32 expected_flags;
+	const char *error;
+} tests[] = {
+	{ "zero", "0", 0 },
+	{ "decimal", "129", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
+	{ "hexadecimal", "0x81", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
+	{ "octal", "0201", BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
+	{ "positive_sign", "+1", BPF_F_NO_PREALLOC },
+	{ "single_name", "BPF_F_NO_PREALLOC", BPF_F_NO_PREALLOC },
+	{ "combined_names", "BPF_F_NO_PREALLOC,BPF_F_RDONLY_PROG",
+	  BPF_F_NO_PREALLOC | BPF_F_RDONLY_PROG },
+	{ "repeated_name", "BPF_F_NO_PREALLOC,BPF_F_NO_PREALLOC", BPF_F_NO_PREALLOC },
+	{ "unknown_name", "BPF_F_NOT_A_MAP_FLAG", 0, "can't parse" },
+	{ "other_command_flag", "BPF_F_PATH_FD", 0, "can't parse" },
+	{ "update_flag", "BPF_F_LOCK", 0, "can't parse" },
+	{ "abbreviated_name", "BPF_F_NO_PRE", 0, "can't parse" },
+	{ "lowercase_name", "bpf_f_no_prealloc", 0, "can't parse" },
+	{ "empty", "", 0, "can't parse" },
+	{ "whitespace", " ", 0, "can't parse" },
+	{ "empty_list", ",", 0, "can't parse" },
+	{ "leading_comma", ",BPF_F_NO_PREALLOC", 0, "can't parse" },
+	{ "trailing_comma", "BPF_F_NO_PREALLOC,", 0, "can't parse" },
+	{ "empty_element", "BPF_F_NO_PREALLOC,,BPF_F_RDONLY_PROG", 0, "can't parse" },
+	{ "number_then_name", "1,BPF_F_RDONLY_PROG", 0, "can't parse" },
+	{ "name_then_number", "BPF_F_NO_PREALLOC,128", 0, "can't parse" },
+	{ "numeric_list", "1,128", 0, "can't parse" },
+	{ "whitespace_in_list", "BPF_F_NO_PREALLOC, BPF_F_RDONLY_PROG", 0, "can't parse" },
+	{ "overflow_u32", "4294967296", 0, "can't parse" },
+	{ "overflow_hex", "0x100000000", 0, "can't parse" },
+	{ "overflow_u64", "18446744073709551616", 0, "can't parse" },
+	{ "negative", "-1", 0, "can't parse" },
+	/* Numeric bits unknown to bpftool must still reach the kernel. */
+	{ "all_bits", "0xffffffff", 0, "map create failed" },
+	/* The kernel validates combinations of known map creation flags. */
+	{ "invalid_combination", "BPF_F_RDONLY,BPF_F_WRONLY", 0, "map create failed" },
+};
+
+static void test_map_flags(const struct map_flags_test *test, const char *path)
+{
+	char cmd[MAX_BPFTOOL_CMD_LEN], output[1024] = {};
+	struct bpf_map_info info = {};
+	__u32 info_len = sizeof(info);
+	int fd, err;
+
+	/* Let the flags parser handle negative numbers instead of getopt(). */
+	err = snprintf(cmd, sizeof(cmd),
+		       "-- map create %s type hash key 4 value 4 entries 1 name flags_test flags '%s' 2>&1",
+		       path, test->flags);
+	if (!ASSERT_GT(err, 0, "format_command") ||
+	    !ASSERT_LT(err, sizeof(cmd), "command_length"))
+		return;
+
+	err = get_bpftool_command_output(cmd, output, sizeof(output));
+	if (test->error) {
+		ASSERT_NEQ(err, 0, "reject_flags");
+		ASSERT_HAS_SUBSTR(output, test->error, "error_message");
+		err = access(path, F_OK);
+		ASSERT_EQ(err, -1, "no_pin");
+		ASSERT_EQ(errno, ENOENT, "pin_absent");
+		goto cleanup;
+	}
+	if (!ASSERT_OK(err, "create_map"))
+		goto cleanup;
+
+	fd = bpf_obj_get(path);
+	if (!ASSERT_OK_FD(fd, "open_map"))
+		goto cleanup;
+	if (ASSERT_OK(bpf_map_get_info_by_fd(fd, &info, &info_len), "map_info"))
+		ASSERT_EQ(info.map_flags, test->expected_flags, "map_flags");
+	close(fd);
+cleanup:
+	unlink(path);
+}
+
+void test_bpftool_map_flags(void)
+{
+	char dir[] = "/sys/fs/bpf/bpftool_flags_XXXXXX";
+	char path[sizeof(dir) + sizeof("/map")];
+	int i;
+
+	if (!ASSERT_OK_PTR(mkdtemp(dir), "create_pin_dir"))
+		return;
+	snprintf(path, sizeof(path), "%s/map", dir);
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_map_flags(&tests[i], path);
+	}
+	ASSERT_OK(rmdir(dir), "remove_pin_dir");
+}
-- 
2.55.0

