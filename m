Received: from mail-pz2-f11.google.com (mail-pz2-f11.google.com [74.125.228.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648373E5EF2
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789095061; cv=none; b=BGcun2g5w25Ibqi33pljqekKi/boTlHhdIks25suSmDmdshfl85XIiipx/mUpejELo7to7uv0kpXmbCu+J+dsmc73PqlXsUH7P4UIhHd+8QR7sEaWKjDR9tEu3lxFFGANHVlMH7r56VhEbVQnkMsgEUtowXuOst11UI3fKPi2Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789095061; c=relaxed/simple;
	bh=kpSLrnfA/vUl/c5jXmXhseDA+FfRKhJiHbrBlYcKj9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apBAknDv2vJIt1iJFLzxKwXr/A1sMYtU7D8rr1LHlyrfFx3gIxViqx5eAMmIVBwSSgJOsY5Qc2J04qDSVOj28WOS5bYsMvJM3+D3Zg0yIZAbn7Qqy/nSPJ9RthQh95YAUwsLVty9t+dn3csKGQmwl27zT+OyJkCfpsP4FlHfu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6uL8611; arc=none smtp.client-ip=74.125.228.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6uL8611"
Received: by mail-pz2-f11.google.com with SMTP id 41be03b00d2f7-cc1c2963c92so107381a12.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 19:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789095060; x=1789699860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0knv+5p0Y2agkMleFRrU/WI3Z2Rc8uFoKLD1T3IoWWA=;
        b=n6uL8611J5SkSrtn1xtLmh+Hm9Qobi/n92JY0UXyAlxkb3r3JA8zeQBAmkhlGUw2/m
         yU8GkirX83k+oqIruVTHU0eDvqKeJQAkPDt5YwUPk47dex2C0YaCFuDPkr5gGwuJ8HD/
         0jYEoGjt9URJFUtgVA9sQ0uswn0v0eiHMa+wEfjZNTltissmsHSDJnRCHdfABUHcuq9k
         psRETH2jbsDC6oj0yIdbuTLwx2oFVYMuG8ja/YT1vvq7imX0Z4bAlVSo+d01a5bFzhCQ
         fwL0S+FJH9BB093WdVC41tUhdYrQca57YR1DbMTMy1q8czFecJ1AsJfMZ5gVdPeX1mnN
         2C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789095060; x=1789699860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0knv+5p0Y2agkMleFRrU/WI3Z2Rc8uFoKLD1T3IoWWA=;
        b=Lg+7YjTUQK2XUgB6uHNVMq3u32MtkS7KELuhNFmefyuA2E1FZCynt6i8/4DGxtx3H9
         LzYrutFl+/aArWTbhjeHtRTNJYuCAQmBWEqb3xq7nrIrd7LcSIOrutPO6imdxx+ZRXUZ
         /cZdKDggIgtuwk0uSp4Y+P0gK4gCZOzMdwokMGKKHb0SLJ++eH8KCaSLnMJmUBnicK3C
         1atrd2MvNccrgVCPhsoWiUsC42vr1lJUCpFwRpQV78JWrK7Is+dhYVupuiZW12L20zYn
         6U3qaD0eJHpFa1HzWKUbrQdVUM5+VVvjWvgr+F3mq97wfwfKjiBH+c45UFIvBzkjkBwE
         8+7g==
X-Forwarded-Encrypted: i=1; AKwUvBybf3mRCWwD8Fmk8B7XLu1x9WMVegquKKvNIDPwoikreMiN25RqIhIbINFcZOX/Tqq9rTs=@vger.kernel.org
X-Gm-Message-State: AFuF++niPyHa7GIS3Ca2ZJ1Y9vlCqNNM7MqV+XFztM2Em+WdTZb7gB/k
	Bym1PpZaFTY3iIZOhsM7errmpVXDk+he9chM/aYv9gHNrJySfZPuV+1w
X-Gm-Gg: AYBFou0DVOzoTLTXBNGIBvY9xqlo7Vcc1cGWxIZ10xz3pzepN+z+caMtgaLqqctmSTZ
	wE7qjQ3+1GvCZlh+GgkQ1czTiRgNiO7yjC2KqVglVPd49zd/9lvoxv34nD5AIrUxAAImQuyOKcK
	qRk6Y3x3GjXTiukeNr5qFwD0nnOAeMYiaWdNTdu7G7iJem/4JJYu2odSoCC9Bh+rucCwPubO/o8
	o66SdcGpth79nr7NNUZ+dH05hdaaVFNbGVClUJi05qVDZtH3A3LwHbdZ5KEXdtGz7LWG4cVNMk8
	rK5ATc6t36EW1aW7Jok8VSDyNOcLyjutrJrHb4DDtxz4a1mtnUWjAf/WRxMM363LS80F5RSYF+Y
	dNA5rvlfe4f1P+bvnoKBppXmFMXVHEgHiVL+XGBY+7EoBctzU4u92NoTSS16A/VosKOmaFNs5J+
	kk2j5uOqkaeEspS+5bwrzl+CfN89RLZPr128TcJioLeO885AtXWvEhbBlsRY95Al6+
X-Received: by 2002:a05:6a00:a02:b0:847:770f:da4c with SMTP id d2e1a72fcca58-86b32df12d7mr3002967b3a.16.1789095059576;
        Thu, 10 Sep 2026 19:50:59 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bb8f28sm385299b3a.40.2026.09.10.19.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:50:59 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Cover symbolic bpftool map creation flags
Date: Fri, 11 Sep 2026 10:50:44 +0800
Message-ID: <20260911025044.190540-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911025044.190540-1-diannaaav@gmail.com>
References: <20260911025044.190540-1-diannaaav@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Chen <hi@tychen.cc>

Check numeric and symbolic map creation flags, including combined and
repeated names, against map information read independently with libbpf.
Exercise malformed names and lists, update-only flags, empty input and
numeric range errors. Verify rejected input leaves no pinned map.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 .../bpf/prog_tests/bpftool_map_flags.c        | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c b/tools/testing/selftests/bpf/prog_tests/bpftool_map_flags.c
new file mode 100644
index 000000000000..d617b43273a8
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

