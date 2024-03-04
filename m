Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32FC7C08C
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592739; cv=none; b=KORjbIa0t4I9psKgvt8TskscpJx1HGZXhdQPxcSO+pe3RNlbvjwZwnr/fqSt2xcvnEMGxs4PbP6T57ayFjv4w8E6yOw+UGFeS8UNPYyXtZxwjMljOhecUYlVINLdq/b3aslBJ7/sI6MnRnPBT4nm4L0rcGdDsYKpeM2TxYaWUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592739; c=relaxed/simple;
	bh=QXvEP/c5CZ+qMkyjvMCGVrtnH7EiT8yRzTlaKOqT5e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT8Ki04HXNL3W+KgmNmayDYQOyoaLaWA6NEkyfJ9r8/krXGcXfbE2/zOk4QA1iHrPZBukycok7OgBVZ4ih3cOMNEYtPq6lwrzZ4AY6hrcodn85AKiPTb7p424u4+Q9S4HXf5Szw+MHNDqrHN7+1fsLwxNMpiEDroh43Xxh+Vask=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEAs11aY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEAs11aY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a293f2280c7so877306266b.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592736; x=1710197536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8J+ytjUf9SzelgOKTwnMQGif16G6a4gx4Sx+0P9UUqs=;
        b=IEAs11aYRu0fd9WqtYaYkc0t7Z0Xqh6Q/aZlnV7igqvx0VbWdH5bI8FuhOYiQcI/ib
         W78eb+jK7fvdXmKVY1YX1cdbvp9qdQ+fCQ9IWPcQXtrTh5HBHEOZZO/z/NScJkjItg8j
         qv2YtMRpgdQ2qA5MDXRofTWm5EmcF/yy0PchpB8xK1NxopaxE4svUS8hb6rJ4xlKD7Ya
         x0Qa8sxvbVNbWXHeK0B/rf9046kXv/X1cxpkzvAlTwDbNvHI8TWKZue8PlwGffV3zVrf
         WOukMAZJTK6I2XUegEJVrK9DRM7ntjEKdFjOa5CfI3/X0u43AAA6Quz+muXOw6Ax8BSu
         P6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592736; x=1710197536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8J+ytjUf9SzelgOKTwnMQGif16G6a4gx4Sx+0P9UUqs=;
        b=q448Y1ydZFnbRBLXEsWrimsXWU5TmtPKeJGe+my76PIPcAznAEwRkBgHFBQMY312ir
         P5kR7ZAlcVoeUovoxpYdOV0DtXWrOHwItdK1MsY8LVMLkn1gE7VThD0nMegtbNWZPvJi
         dAyBXeXZuK6pSoKHYje+him0fYW7ovRoB/Rg4jzFvImTV6QEtaPQVScXe8rtNktgEWRu
         PjPlZgVR+HjnCFBKM/AeZw+MgqBbWa/sjWQL6BpDFYS11Lu6R9kPsvpg+CBgJYPgdh1L
         73L0owsSHBDVhJanSxAX/eRwq1Goese5sNtUQW0yzAL1pV9jPqJm2JvrS/rSGYFaVrFW
         2WvA==
X-Gm-Message-State: AOJu0YzNOyEF7zESax4xn1fw3ou8qiNB+kALb5ZyqXne2hT+nWgGJ5Fk
	Y9m/2F5+4kSTKYN2GHcWv2vzBnSWOZOCf5lnRQAofea5/Wc7sEOKU0cHco4S
X-Google-Smtp-Source: AGHT+IGgohPam7TXIaIr+S33KaDBcz4qKamA0IS4LVT8US+z5qkC1vzTeOnIQxJhcADCBctwSvI5Kw==
X-Received: by 2002:a17:906:7809:b0:a3f:6513:1489 with SMTP id u9-20020a170906780900b00a3f65131489mr6551981ejm.55.1709592735964;
        Mon, 04 Mar 2024 14:52:15 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:15 -0800 (PST)
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
Subject: [PATCH bpf-next v3 07/15] selftests/bpf: test autocreate behavior for struct_ops maps
Date: Tue,  5 Mar 2024 00:51:48 +0200
Message-ID: <20240304225156.24765-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304225156.24765-1-eddyz87@gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
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
index 000000000000..883f938d518c
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
+	char *log;
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

