Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128038910F
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098436; cv=none; b=BukPREU6MLNFEwsgqkvn1V/qj9BoKy8CCwYemDJ6/gO37eDsJfipI0KgA7tWjTgn7SEkKC1Eth6qJBzMcRsoD7yXqKa8YQQQbPb2DnPd6Tw2VAU5Bsq8Ik4CoFyhbE5gJsjPWNGMmGEzHmS6b5hVt0uZSiYc1d6FUdg6E4XvgPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098436; c=relaxed/simple;
	bh=qCj5KxpbmLsxDHpp8TuDuSjn3hoLwqME9LrygCQAZec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEQ2KsLUlF4b+r4KKHGbLY43WdOP2kSPoyq3n5nEmbzpg60ag5vQsi6LYqqTR57skpbWZS5mngTOIINOwXxkzr238F3m5Xyfquv4ZN6TB0PyqhytJu7iRvmEsefj8M9OX31S3nUUSwwUSDSY1NAB9hXSij2TbkblSgk5MnOgi5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYemkd1c; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYemkd1c"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-398a384b5f7so235754a91.0
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 20:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789098434; x=1789703234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lMD4l39AzBLBX/0QKoGNGV2GkIHoHPkT1yUxuLkPpaU=;
        b=lYemkd1c3JfRBAnjkmN7hBaPRU4uqL8fOziTnWSDePq5Uiw9NK7suzO+pYs9pvLaBW
         y7OD/dg+oSQ50NwQJoXWz+brqXa9Qy4pV0OYZpRF4AjSrZlfr7BU+rt492+YFQpoNJHW
         wNNDCLe8lDu4ZvaSXHH9ut5GOOnliOxLGzyoFxuRMaW4yp3ZMun8amaCrYmss59O6eW0
         +QK3kpjsBOPjIIz8P6lnAYhYilaEIIILj2lgUE9cjfD7cv55AfesomRB2WenxEk+bkn+
         VHtLhANN1oBrmHoFohn1h8WS5JNK2if3NFNpqWUGdoHIew2PXp7g1DGEfYukyxV/hozW
         ODGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789098434; x=1789703234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lMD4l39AzBLBX/0QKoGNGV2GkIHoHPkT1yUxuLkPpaU=;
        b=R4W4cOZle5bqD+qo37qROwwmfc50wpWg8tu0mcoUYpUF/UGbSFZgKfrxUOxEO4stF+
         AiKGIpW2Qos17AGQEyS7jCU4P0v96hpDF8R5WQPz2wng0gVPIKq2SNvYpxIY+L5wcyem
         07T/zF1r2BQ0+N0S/BZcD1ziieEiq+tpCVv/JsaN4pUTjiYIgiWknlwL6RSzltgGI+Gq
         hFLm0Ld7oKX/P0rO0jzZM/l/gnEPFrjEf1bv2zM8mvZnASU45maVH9tKMqvxstlM06Zz
         OVOz4MS34WI7sCnXTtCqLH/O8mmsa71kECoyzqO1k4l1YmnoEQW8sav8O+laQMjZnx4c
         yHVw==
X-Forwarded-Encrypted: i=1; AKwUvBzHYwcn2xhHTKfCnBlOSd6acBSLk7CazntnYrmuHXpuV3pmeH7YMw46ZkmGqYLgRwQXWw0=@vger.kernel.org
X-Gm-Message-State: AFuF++kwMwvEcX8XL8Jz/eQFXMELTxLYjujLfSp5A4FP7v5P8JMFKHFr
	lnQBqN9oMp9TBsgkiS1Uxc7Tuz6l6uVy2HBA/rKnyzQvyHDtRpy9ncKYTBA0krXLu4czJQ==
X-Gm-Gg: AYBFou3MMYKtI5N60KaK44UAGEc7bOx6hta1u9V8PNVix3iU1UELpcKOXGx3bZLI3za
	JajIwmWmGCIif2L4Ap/nOnkSwyYBdx/YC/FICHFiT3wAxeMzBF0CSvbMSFpAesTj4KppnqFw4wG
	d8xjdl5ULhrxvBelwzYs4o+2ycvBaz+xgWAYlyq0JZybNFtYYjJANaxpqwZB3041rOHiJaj4xAa
	fW1K/2BQ+QV9itiQ05rYEDnERxNNoXk5jKt6WV9OlGzgVFSo2KyamKa/Tj/zJISp2nv6oEz+ayE
	p+QV7Da8CryNyuzr+FG8B4OMhj0DKD84nUaEaVYS+nlT+Y+daJQJO/lI9VkYPVNst3Fpe3CkXIQ
	qcWS9xFepI/U4B1KhiIyqHb4W5je+rSmizKB8oGg1tmGte6EHrFhi5Hjttx45igiF/ru34KJxNx
	xxs+RhkLjIiMx3WpYMoceoXqzBgPZAOyvL6y8ed3qQkSkWelZStVsP4Z76qeB10Nhy
X-Received: by 2002:a17:90b:560e:b0:398:a2ed:7b5c with SMTP id 98e67ed59e1d1-39d9c3a1fc2mr3848027a91.24.1789098434445;
        Thu, 10 Sep 2026 20:47:14 -0700 (PDT)
Received: from 192.168.5.7 ([69.5.53.41])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d9959ac65sm2119710a91.16.2026.09.10.20.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:47:14 -0700 (PDT)
From: Tianyi Chen <diannaaav@gmail.com>
To: qmo@kernel.org,
	bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Cover symbolic bpftool map creation flags
Date: Fri, 11 Sep 2026 11:46:58 +0800
Message-ID: <20260911034658.219396-3-diannaaav@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911034658.219396-1-diannaaav@gmail.com>
References: <20260911034658.219396-1-diannaaav@gmail.com>
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

