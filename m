Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31353E2E
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366110; cv=none; b=klVU5lNrodUAMuqTF3Lsm6gqB92mL0B/mmnccDIOhohbFlBF+6wGhfEoUqL7HsunsxH7GxuPSzfb+sPimQ3gCSxutHop3azQStbRszA5JmtZLcN0Hsnx5+8XCTzca0Y4VrFz+DpVJLDiQiM/IAfFtFbYFl2rqBct3YvzW2FeiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366110; c=relaxed/simple;
	bh=u1+sbSM+7+UEe04xGAhqrujZrrYmcrCFuvWQmciz25Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lauBkz0WWfHa3WmQdx/Lo/QLBN/g60mnxaJPbToQTGsYmXp9nlYoWq7fxOaulu3Qwy5lS+HDWhXT5q2kgiDvDcn82Lelu314eUsu66SvCEag8xHD39jsE6dgdoAG1x30+OnNQrKZ5m7hcItcYhNI6IxGtsAfL0QC/vZPA0yeLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBqHvYeX; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBqHvYeX"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609fc742044so3639067b3.1
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710366107; x=1710970907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hMREXqXE361hvOJ3Zdr6NNwVC2A8l7mk09b9lG9NMU=;
        b=gBqHvYeXsVITnE4wiTdPW3jO3xlcN6t3+pNI8cK7sjLUJHnXKqvGz1BFXLawEYxnVU
         nQjayGxPhCyYqDLnErvk9YhB5UsShg/7HBP4QY7YA3HEnY3/dMIb7jyOx8aoTLyy8DII
         pClVySFzHoAEHNsEtK1WAv/XgZidSS6XZY8xnn1MNW/rohX4WU/CLTG/jGVupB93o2yd
         XT0e2axUpUgAoEj+zpnIH5UPQkuk3R2U90IFE+zi1yC1RWwHn6kAbMp3hPVaouyELqBu
         38SHdv66wrW6UWOCiVVp0+s1XMhYTMjqG5mR9vDQMK2Tu3L3DeCuRe5OJN1BZarUzKDO
         9/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366107; x=1710970907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hMREXqXE361hvOJ3Zdr6NNwVC2A8l7mk09b9lG9NMU=;
        b=p5deXTEycdMTm38cPpMxAjyc0tvBTTZesasOhsmAHdeh2pI8oF+mBXcTNJyanm9s+D
         WZqkyich7/DQqxsGByPBO9LXr8n3gTNxrwJjeN0FIMgGGY+6YdqFNvb8L0pU3JJPc1WH
         JPB4RzAOe07lbO+btQvTo5tMpE1UZLzkZu9XpX7uAmWwzJcwUfk7aAxLYyBLhClOvMQx
         ESXLrnVf0eswnxoR8fGxlXzYxXmeSpKGTsceuYbJxecBcc1b2h/6q0Nvp0mPvpcWV9ft
         eOQiSRknHDlfZZF7XuLp1Z/q6HYbM61ccdePtsUNgTyfwo3V6M8aUbo7vZnr8ioy+pBO
         MguA==
X-Gm-Message-State: AOJu0YwfhaogEHlqI3XSpELXcJzNVNnezke1BB4/vDko8zdILdK06m+t
	4viWuJRdGg3FKwoK/CydmtWMNLTEOonreGvJujQWCvnMLu/6lSTQwRUi+KME
X-Google-Smtp-Source: AGHT+IFgR3d6HgqWlyHbiQ2UiAgP/2mZEtx2IQmFTaorMP+UbeD/ttRWEU03WJbfYJuv2lgPDANk5Q==
X-Received: by 2002:a0d:c945:0:b0:60a:3ad:6872 with SMTP id l66-20020a0dc945000000b0060a03ad6872mr3763204ywd.34.1710366106836;
        Wed, 13 Mar 2024 14:41:46 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:30fd:440:22c1:8047])
        by smtp.gmail.com with ESMTPSA id y74-20020a0dd64d000000b00607b3038a7dsm2678950ywd.9.2024.03.13.14.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:41:46 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Accept extra arguments if they are not used.
Date: Wed, 13 Mar 2024 14:41:39 -0700
Message-Id: <20240313214139.685112-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313214139.685112-1-thinker.li@gmail.com>
References: <20240313214139.685112-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A struct_ops program can have more arguments than what the corresponding
function pointer in the kernel has if the program doesn't access the
arguments. For example, a struct_ops operator may have 2 arguments, but
your program may defined with 3 or more arguments. It is acceptable as long
as the program doesn't use these arguments.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../bpf/prog_tests/test_struct_ops_module.c   | 56 +++++++++++++++++++
 .../bpf/progs/struct_ops_extra_arg.c          | 49 ++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
index 098776d00ab4..a146bf079a60 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
@@ -4,6 +4,7 @@
 #include <time.h>
 
 #include "struct_ops_module.skel.h"
+#include "struct_ops_extra_arg.skel.h"
 
 static void check_map_info(struct bpf_map_info *info)
 {
@@ -138,11 +139,66 @@ static void test_struct_ops_not_zeroed(void)
 	struct_ops_module__destroy(skel);
 }
 
+/* Handle BPF programs with additional arguments that don't appear in the
+ * function pointer prototype in the kernel.
+ */
+static void test_struct_ops_extra_arg(void)
+{
+	struct struct_ops_extra_arg *skel;
+	int err;
+
+	/* test_extra_arg() has an extra argument, so testmod_1 should fail
+	 * to load.
+	 *
+	 * Since extra_arg is used in test_extra_arg(), it should be
+	 * rejected by the verifier.
+	 */
+	skel = struct_ops_extra_arg__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_extra_arg_open_extra_arg"))
+		return;
+
+	err = struct_ops_extra_arg__load(skel);
+	ASSERT_ERR(err, "struct_ops_extra_arg_load_extra_arg");
+
+	struct_ops_extra_arg__destroy(skel);
+
+	/* Switch to test_2() */
+	skel = struct_ops_extra_arg__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_extra_arg_open"))
+		return;
+
+	skel->struct_ops.testmod_1->test_2 = skel->progs.test_2;
+
+	err = struct_ops_extra_arg__load(skel);
+	ASSERT_OK(err, "struct_ops_extra_arg_load");
+
+	struct_ops_extra_arg__destroy(skel);
+
+	/* Switch to test_extra_arg_unused()
+	 *
+	 * Since extra_arg is never used, it should be accepted by the
+	 * verifier. The verifier would accept a program with extra
+	 * arguments as long as they are not used.
+	 */
+	skel = struct_ops_extra_arg__open();
+	if (!ASSERT_OK_PTR(skel, "struct_ops_extra_arg_open_unused"))
+		return;
+
+	skel->struct_ops.testmod_1->test_2 = skel->progs.test_extra_arg_unused;
+
+	err = struct_ops_extra_arg__load(skel);
+	ASSERT_OK(err, "struct_ops_extra_arg_load_unused");
+
+	struct_ops_extra_arg__destroy(skel);
+}
+
 void serial_test_struct_ops_module(void)
 {
 	if (test__start_subtest("test_struct_ops_load"))
 		test_struct_ops_load();
 	if (test__start_subtest("test_struct_ops_not_zeroed"))
 		test_struct_ops_not_zeroed();
+	if (test__start_subtest("test_struct_ops_extra_arg"))
+		test_struct_ops_extra_arg();
 }
 
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c b/tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c
new file mode 100644
index 000000000000..4b73b279ad22
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/struct_ops_extra_arg.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+int test_1_result = 0;
+int test_2_result = 0;
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	test_1_result = 0xdeadbeef;
+	return 0;
+}
+
+SEC("?struct_ops/test_2")
+void BPF_PROG(test_2, int a, int b)
+{
+	test_2_result = a + b;
+}
+
+SEC("?struct_ops/test_extra_arg")
+void BPF_PROG(test_extra_arg, int a, int b, int extra_arg)
+{
+	/* Accessing extra_arg will cause a verifier error since it
+	 * accesses the context data beyond the size of the context.
+	 */
+	test_2_result = a + b + extra_arg + 3;
+}
+
+SEC("?struct_ops/test_extra_arg_unused")
+void BPF_PROG(test_extra_arg_unused, int a, int b, int extra_arg)
+{
+	/* The extra_arg is not used, so it should not cause a verifier
+	 * error.
+	 */
+	test_2_result = a + b + 3;
+}
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_extra_arg,
+	.data = 0x1,
+};
-- 
2.34.1

