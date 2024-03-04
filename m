Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A110A1A
	for <bpf@vger.kernel.org>; Mon,  4 Mar 2024 22:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592738; cv=none; b=RcKgLaVyMlRQQ52FAQeYkqs+jRP2cS2KTpZZYze1vh1kAE2Wkkk0jKJwONXHHrM/E8ptPhTsulGUTCK/LM1CFVtJ8cZvLXANXTJKS1e6dLW7iXp/0sUZtNt/+STRVvpoyOS79vvq8Xb/AwDYnbpH30LIVPtCqK49bJHWJ/XnyS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592738; c=relaxed/simple;
	bh=T9Tg69UkPoHBYpyj0IQGWeVNmt0BhhIt5JaJNfhMswQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxbQle2obNwHnLcpetI3XlqggoBhWwRMq0ZpDkAtMKISRE+F19hvvFRexWZ4GIKboaRWo66hVpXcIXJjJETn3G5UynLclCDC2ZutbMRlsqSR4LUf9XITEclBkWMQmkO7m9Wfc2fXGmz7Mh4giKy9sv7l587QWd1cP1YN+li7PHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+XGRry+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+XGRry+"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51341a5aafbso1931195e87.0
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 14:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709592735; x=1710197535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HloUQLeyf3X91OgKXgvzmZERUb4RBb98Jjf4ea1gRCQ=;
        b=R+XGRry+rBp+aGbJaIpuLmhhI6oMpuQvnRh9pAG6YQkzdjQ61PZWi9aMDN6d3HPY+6
         dO+iRMJcVGKWzCpCVUlBykhThktLLgy8GOyroZJd8LL4K2N5InY0HrlI38Z8NlpqUN0W
         q1b/zA6pxT2vMgqTozVoqYPLXjWJP98Vy9gL6HxwSlTHiz4mUj/QHqeopDiySY1P9nJs
         4EF2axN/89nDni/flHBOKHkA6LCUzt+qBvNPfad+/+hqgMgcV4NMKe0Axc8jnyCLcRXv
         EQzf3belMb9sydVz27g06y/CzImP3j4XfaxbIoilWnQfxtgEwcJJRmFXswr5g9M+f0PJ
         F4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709592735; x=1710197535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HloUQLeyf3X91OgKXgvzmZERUb4RBb98Jjf4ea1gRCQ=;
        b=DvZs78j52BhyHnEdg8MBZUWW0PriAjMriCLzEjRwRb3Siy4cGq3R5w1SMTsngo4WmZ
         WqGwqLjRaoEMTteCXe1o+HxyxD1bdRWfa7uUI1pf7bKef/Sj8U4526VShRNbraWalWwe
         /6IYBHKgHRl4KwsMXNViaRPQWGoDJZRhe0hvRUkGxEqjffGL3DJ+segf07UixqH1y+cT
         g/OL8oVcygaNdqtqlKsAa4LJZQTE3mhqtZti2JH1vpCJwpg9BOiN48d+Rl6q5tSw9Ctd
         zRUOv6TGYxvm9fc1Ph7ScX+6m7crFePVCyCH+9hMVRcro7HvDe3pZEyZ6mIm98W71wW9
         sSPw==
X-Gm-Message-State: AOJu0YzVA35PtWbRXVFDJVXgbkNF3vjOFJbghB87qfBzJDphWG9dpsJY
	5EO5VaGEo2whMudEKGcY9znjZTAb3s4+fsjCHaZBqzOBWePT4KWYlPsyElnY
X-Google-Smtp-Source: AGHT+IEp0r3rFFPVCj0FcU8IN4rhqHyBnIK4nsNn5D8WCLS5RExw7Enc8YF7YpZD2or3aBGAnHDJ8g==
X-Received: by 2002:ac2:43b7:0:b0:513:4847:2c0d with SMTP id t23-20020ac243b7000000b0051348472c0dmr99913lfl.29.1709592734591;
        Mon, 04 Mar 2024 14:52:14 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qx22-20020a170906fcd600b00a4302eb448dsm5315499ejb.134.2024.03.04.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 14:52:14 -0800 (PST)
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
Subject: [PATCH bpf-next v3 06/15] selftests/bpf: bad_struct_ops test
Date: Tue,  5 Mar 2024 00:51:47 +0200
Message-ID: <20240304225156.24765-7-eddyz87@gmail.com>
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

When loading struct_ops programs kernel requires BTF id of the
struct_ops type and member index for attachment point inside that
type. This makes it not possible to have same BPF program used in
struct_ops maps that have different struct_ops type.
Check if libbpf rejects such BPF objects files.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 +++
 .../selftests/bpf/prog_tests/bad_struct_ops.c | 35 +++++++++++++++++++
 .../selftests/bpf/progs/bad_struct_ops.c      | 25 +++++++++++++
 4 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index b9ff88e3d463..2de7e80dbb4b 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -610,6 +610,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops = {
 	.owner = THIS_MODULE,
 };
 
+static int bpf_dummy_reg2(void *kdata)
+{
+	struct bpf_testmod_ops2 *ops = kdata;
+
+	ops->test_1();
+	return 0;
+}
+
+static struct bpf_testmod_ops2 __bpf_testmod_ops2 = {
+	.test_1 = bpf_testmod_test_1,
+};
+
+struct bpf_struct_ops bpf_testmod_ops2 = {
+	.verifier_ops = &bpf_testmod_verifier_ops,
+	.init = bpf_testmod_ops_init,
+	.init_member = bpf_testmod_ops_init_member,
+	.reg = bpf_dummy_reg2,
+	.unreg = bpf_dummy_unreg,
+	.cfi_stubs = &__bpf_testmod_ops2,
+	.name = "bpf_testmod_ops2",
+	.owner = THIS_MODULE,
+};
+
 extern int bpf_fentry_test1(int a);
 
 static int bpf_testmod_init(void)
@@ -621,6 +644,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
+	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	if (ret < 0)
 		return ret;
 	if (bpf_fentry_test1(0) < 0)
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
index 971458acfac3..c51c4eae9ed5 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
@@ -45,4 +45,8 @@ struct bpf_testmod_ops {
 	int data;
 };
 
+struct bpf_testmod_ops2 {
+	int (*test_1)(void);
+};
+
 #endif /* _BPF_TESTMOD_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
new file mode 100644
index 000000000000..9f5dbefa0dd9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "bad_struct_ops.skel.h"
+
+static void invalid_prog_reuse(void)
+{
+	struct bad_struct_ops *skel;
+	char *log = NULL;
+	int err;
+
+	skel = bad_struct_ops__open();
+	if (!ASSERT_OK_PTR(skel, "bad_struct_ops__open"))
+		return;
+
+	if (start_libbpf_log_capture())
+		goto cleanup;
+
+	err = bad_struct_ops__load(skel);
+	log = stop_libbpf_log_capture();
+	ASSERT_ERR(err, "bad_struct_ops__load should fail");
+	ASSERT_HAS_SUBSTR(log,
+		"struct_ops init_kern testmod_2 func ptr test_1: invalid reuse of prog test_1",
+		"expected init_kern message");
+
+cleanup:
+	free(log);
+	bad_struct_ops__destroy(skel);
+}
+
+void test_bad_struct_ops(void)
+{
+	if (test__start_subtest("invalid_prog_reuse"))
+		invalid_prog_reuse();
+}
diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
new file mode 100644
index 000000000000..b7e175cd0af0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "../bpf_testmod/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1) { return 0; }
+
+SEC("struct_ops/test_2")
+int BPF_PROG(test_2) { return 0; }
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops testmod_1 = {
+	.test_1 = (void *)test_1,
+	.test_2 = (void *)test_2
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops2 testmod_2 = {
+	.test_1 = (void *)test_1
+};
-- 
2.43.0

