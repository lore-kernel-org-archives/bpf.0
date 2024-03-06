Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E06086C
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721951; cv=none; b=kl98U00hPevamfNSjnCo2xnS5LoPOQhh2cT2qz4ly/zDqR0VKAaIrGjJuSn83AXuloCzTHerK/2bpV3LzUhsh4vs1l3ccrwZpKBeXZnfgFzI6KpnHfQvjk1PfHRkvYsWe76/hlltW3djkcMQrMEXNn9wYJbvhFMB5qF/BPvgWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721951; c=relaxed/simple;
	bh=d3p2s7QmzxToDK96TFHJQ1qZN4aIgJhdEigNkUD5eww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVxDTqNlIUYIpfeYtws/Lx6GGAuLoCGVwmeG7igaNXAuxn8kZZjH03d7QshisI/rhKh5iAlnyzKQqIu/dffG9a7IjXp/BceqLUM8TYnOZaaEl25b4tCZMNc8dmFNb46SlmfhYtR7pr8A69Sit4blpwaVa066GKuTmqTg/irHYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwvK8NB6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwvK8NB6"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a458850dbddso314686866b.0
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709721948; x=1710326748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcjgCbM6tI4PtrjhlfgHXYswgkyt3LDoGkG3c2uEf/I=;
        b=MwvK8NB6guaKaWduK3e9mg+ZAc4zKquBOTTACn7ztPZqdR3wqFAfyI8kOxF8Lw0Qgt
         ATeVx4L7UwsgHTGEXfKScgGbFaRKJKB9jAuFrqd8XbJtE0AnqNFmFA4lvh0HnTCtKrTT
         XSkcnLuyNDWX7CHws+yqPa/CVd0Ws3h3AVWm34piym+9PAVGY8SJVlJTbrJGPH/0bJLh
         u+icRK0lQ8FVOJJFZqH8pYREcGa+H4Px8ViDoPbGTK6MPf6vLi0wbMVSNalc2xhCrjCp
         8JB33xWQ86OmIAdjQbcW5c1U3IiTXXKWFHVu4g3YhrT0lbSlj8q8Jy6Ux43WHgJbID3q
         3IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709721948; x=1710326748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcjgCbM6tI4PtrjhlfgHXYswgkyt3LDoGkG3c2uEf/I=;
        b=BE9j5ypOF1D3hQCb5uQE48X291mOzEJqS6TJwXH5GuWRc575EhPY7qcnD79tWUHms+
         GVug+hFpZHlolWUzSm+l6rBpj7yv0oRsbFQZ5PHQ4luFuXbbevAXovsVdt1F5cQi//dj
         ADjlCC0XmsQWp8ci6kjI2D2MiQ0p65SD5V7iQQJ4d+Z0mywzMoPR990sQ5cH2VcEXCYQ
         r02cPsmVR4odwXQnvO9yT995P35cOHChfbWYXoffpWvKle1U4eCcVB2BihTSAF2dv5rS
         29vVE70VWeKg8EN8asMWX/BDsQB9Fd+ubDlDl+UVqVmvFcDDFuAmgKKB/GN3vrYxBli+
         4k8Q==
X-Gm-Message-State: AOJu0YwJl4aamRdCyZza02LxwUhVyDr6hRmTk9DC/7TJdd/WlHlIAY19
	gqLnbc2KxaYdZgy0+thmgWkG8HrD+xY8irrneud1H7EKUDdEQBCitxZXT3I9
X-Google-Smtp-Source: AGHT+IFLDt1IvMYPrqAZ/kfmqoVdbLskdVSLF8dz2gAp4FdkAC37wkw7Mdwdgf8mAXIe7LDYq2zwtw==
X-Received: by 2002:a17:906:f9c9:b0:a44:3db:6649 with SMTP id lj9-20020a170906f9c900b00a4403db6649mr9628372ejb.58.1709721948113;
        Wed, 06 Mar 2024 02:45:48 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906591400b00a3d5efc65e0sm7002450ejq.91.2024.03.06.02.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:45:47 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v4 07/15] selftests/bpf: test autocreate behavior for struct_ops maps
Date: Wed,  6 Mar 2024 12:45:21 +0200
Message-ID: <20240306104529.6453-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306104529.6453-1-eddyz87@gmail.com>
References: <20240306104529.6453-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that bpf_map__set_autocreate() can be used to disable automatic
creation for struct_ops maps.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/prog_tests/struct_ops_autocreate.c    | 76 +++++++++++++++++++
 .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocreate.c

diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
new file mode 100644
index 000000000000..a5c8bb9fcb2c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "struct_ops_autocreate.skel.h"
+
+static void cant_load_full_object(void)
+{
+	struct struct_ops_autocreate *skel;
+	char *log = NULL;
+	int err;
+
+	skel = struct_ops_autocreate__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
+	 * match the BTF of the actual struct bpf_testmod_ops defined in the
+	 * kernel, so we should fail to load it if we don't disable autocreate
+	 * for that map.
+	 */
+	err = struct_ops_autocreate__load(skel);
+	log = stop_libbpf_log_capture();
+	if (!ASSERT_ERR(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	ASSERT_HAS_SUBSTR(log, "libbpf: struct_ops init_kern", "init_kern message");
+	ASSERT_EQ(err, -ENOTSUP, "errno should be ENOTSUP");
+
+cleanup:
+	free(log);
+	struct_ops_autocreate__destroy(skel);
+}
+
+static void can_load_partial_object(void)
+{
+	struct struct_ops_autocreate *skel;
+	struct bpf_link *link = NULL;
+	int err;
+
+	skel = struct_ops_autocreate__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
+		return;
+
+	err = bpf_program__set_autoload(skel->progs.test_2, false);
+	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
+		goto cleanup;
+
+	err = bpf_map__set_autocreate(skel->maps.testmod_2, false);
+	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
+		goto cleanup;
+
+	err = struct_ops_autocreate__load(skel);
+	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
+		goto cleanup;
+
+	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
+		goto cleanup;
+
+	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
+	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
+
+cleanup:
+	bpf_link__destroy(link);
+	struct_ops_autocreate__destroy(skel);
+}
+
+void test_struct_ops_autocreate(void)
+{
+	if (test__start_subtest("cant_load_full_object"))
+		cant_load_full_object();
+	if (test__start_subtest("can_load_partial_object"))
+		can_load_partial_object();
+}
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
new file mode 100644
index 000000000000..9a951ee6f55c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	test_1_result = 42;
+	return 0;
+}
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_2)
+{
+	return 0;
+}
+
+struct bpf_testmod_ops___v1 {
+	int (*test_1)(void);
+};
+
+struct bpf_testmod_ops___v2 {
+	int (*test_1)(void);
+	int (*does_not_exist)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v1 testmod_1 = {
+	.test_1 = (void *)test_1
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops___v2 testmod_2 = {
+	.test_1 = (void *)test_1,
+	.does_not_exist = (void *)test_2
+};
-- 
2.43.0

