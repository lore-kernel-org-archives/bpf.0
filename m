Received: from out-zbxj-a78.jellyfish.systems (out-zbxj-a78.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D7A3BB101
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714801; cv=none; b=anMTy3WuX4UeDQtxVaC2lVbjqrBiDG9g7ps4vEl3HFUdUIgr34tFjvofbIHKti/XP4zOBl3FwBWAPfaZh+rsN5vcnEjDxU2o56eQVKvvuBza3i26yijRRDEtJPzYA6nmYCWciP12XdOLCCOEbspynNHv9w/Hwfu3SXdBwvxk3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714801; c=relaxed/simple;
	bh=IRE56WVX3dwqVWzGZI4zmf8UloIQ3ZU31Z9VISf2cs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiU+q39B49cBao9KIDeL3mH9YEh0sROuarYgkG3ncXjEuvx7tbkFO7PFj88eIhzKWKpoQJbSu8INpOPvAQHucyd1LXlkfBemAEKG7stLQEo4bULPmkZbMzUjBR9uWCoWWngPkaQ+7ksLuTZLgYl9h5iESdHABFJFoVILwQmvEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=mpFT3SgM; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="mpFT3SgM"
Received: from fedora (unknown [69.5.53.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hdGpz2kMnz2xBD;
	Sun, 06 Sep 2026 17:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1788714466;
	bh=XfxKpBvhfXs8G4qxM4Uz03DjYwo8QijjCQSAF1xi5yU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mpFT3SgMBjqNjl8uctFw81Cd/LaEeCBT3X67joiTM0ohLumpadntue8j9SCDPcrmE
	 Fa9PlaiNzOI10BHNxVJa73FcBTVbFhdCAoRbu0CPxqX91HCcT7ume0LQQGu9f+LhVS
	 Nxz4Vif7BypqWjtHnvH0FSbSTwoveY2U+GC4HxHQv+rdMpwsr+b3Qm3hGIFGdIg0Fb
	 8IZ6H5rrQ2b8V5L2+w2YYbUeeGtxkAEQZ9NIFcY22DzWSfioaMDkY5iul2/AUpP86T
	 R87CLPY4/CRFloWBn+Jt02WYYLXKNX3ypzd2suFXbkClioOWbSEAamcIVjjigoKvCp
	 81d+yrBWwbO9g==
From: Tianyi Chen <hi@tychen.cc>
To: bpf@vger.kernel.org
Cc: Tianyi Chen <hi@tychen.cc>,
	Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover symbolic bpftool map creation flags
Date: Mon,  7 Sep 2026 01:07:15 +0800
Message-ID: <20260906170715.1212085-3-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906170715.1212085-1-hi@tychen.cc>
References: <20260906170715.1212085-1-hi@tychen.cc>
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
 .../bpf/prog_tests/bpftool_map_flags.c        | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
new file mode 100644
index 00000000000..140401dd254
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
@@ -0,0 +1,99 @@
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

