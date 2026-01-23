Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E35334C1B
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153831; cv=none; b=uWjWo+oQ8xK3d+LO50N/eLVEJBQS8uZqrn/fW52+iRTBAZeKBc6mtsGgOFAR44yc2spHIZti7/6Rgje9fkTMRvPOwR799RX2o4mycfiyi8BzhI1Zqp4KcnwYLcuVIEeRQg7tAebCyfayKYWlnc8HZB4Jj0gn2aRGjYnTOxckEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153831; c=relaxed/simple;
	bh=tNyw0RMF3OxHkN5cM2BejvwuZpXkAcKTmu7JJGqwwVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HiExmq3RdEH7B9XOF83J3gtZI+LNRxLGd2s/O8AZvtAd6FGParQCsp9HZ/g57mzaaZ1o3M/fVD+a2t050ih3n/63dqw0+OX82z/Js03ObJgHyKHWvH3QCFbru4gLwlpS7pIG5XPW+OV3et7vy+PoxpOLszATl04upaOzFujvMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg4qzk67; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg4qzk67"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1025596b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153829; x=1769758629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlyqjJg45w/WwCBTFkaauQNGPumY1lkyqYrB1pbejjE=;
        b=Rg4qzk67bP0dkMYudgynLaCGlPyH8hZKRnUPqpFj138wcNsEPrjuXMOowe654JLRJA
         gi51PiSPgyg/6ognu3CLq+KwBUyFz8iZb9YmiGs6DVLT825UAgz9a481nmjmFe1AWj8H
         QBK2z5GxpZeTi85fmPR49pLT+6gpWr3YD3fJweFGfkd6N7wjHY3qIZiZjCZze8UJPija
         UFIcllh/0zTCOfsB8IrPBZkox7YKNEcywoB/eoEJ67q7obJYMUNCxwcpQuCsVOst84tu
         YST+onGjWxabUcCsmhdf9UPh2fo8W0H9Jx49rL+6oTztkH0wwyQ0qbq9xDrEpXC9arcR
         UUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153829; x=1769758629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlyqjJg45w/WwCBTFkaauQNGPumY1lkyqYrB1pbejjE=;
        b=HblU4CQ8Zgh2juaYIKd7cFoQzzExWKdo7PzmlP8TA5TzFXHhD8N6EjkiFO7gM0Ruq0
         FdUs6s/h8dcnBvu7AlOcazBS5T/3OOQPlqFNyPLqiqSibRcMjWR+PtBElomLrxnj3elc
         phyn24OwdiNuQgCbgU4zRcpMjpQ+9V6eqMZGG3sAKenC1yxU2CL64h0XqGB5KUu1RFnm
         PYJdUNaAcUP5IusvE1fXbhVfM4LLDwtr+HCqHu8BXEbAUjG+EM1uz+GKyqCKz4Kgo98/
         ILPc3TgQYbCoTLZL5OnSxV8b/3HWgzUmhcItPj6ayiUw6bD8NPkPnBMoMK1t6/oosUuS
         f30w==
X-Forwarded-Encrypted: i=1; AJvYcCUyEjni7qB4enxAMZeLz7AxL/pOCifItZ2AOvrQcxqtPLopPnNiczXeUw1/OiSTiVg56AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ1cW88my6m+P3wnswwfRIPzp2CRmT/ReTQ1YY26yxlwXNhPx
	2Gv7Octi5HiHe2Lmphns5mPgiVniUkaItyQiLXkM+HIwuNXDZkNnfIc9
X-Gm-Gg: AZuq6aIZPW6qGVbsABHuWFYG7kUdQu+PMm23/ATXCt97qUT5B23Dbgtp/nPKYpN6DQ0
	gUR5ZG8r5r9t2GufpRNaj7p3SbQX1YoTQrnWVcXVDAK/Db6IO2IgCh71P3ZyVrwlX571xlPRI68
	JawOjWHlG3gQtHA2SC5kc6pJghYNn5gC//JfPjrqHCw6kRTTGJOwu6OG/BwXUw95fu8PgcFVS+R
	/hJ9bY/n0P1skyvOT5Nk5GT6z0bEu3yQXiSTnX0Hdush/gDph19TUYpq+s0zLJ6qsGzHIsKH9Zx
	shscUZsLylHiE0G9pQtEbhTKBR3MwSyy3Ur0uznR6u6P79ju+BhWg7y5/vjQ0bKlYJddeCvICq5
	ABlui1AQQ30ld+gUsxFT0dCCLMKKwcmVcDmbiJLvHb+bp0BWTMEsCEp6xabK/J8fE2LBcFGbPQr
	KNO7u6v9Kp
X-Received: by 2002:a05:6a00:37cf:b0:821:82a7:4ec2 with SMTP id d2e1a72fcca58-82317ef21dfmr1685523b3a.63.1769153828843;
        Thu, 22 Jan 2026 23:37:08 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:37:08 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 10/12] selftests/bpf: add testcases for fsession
Date: Fri, 23 Jan 2026 15:35:30 +0800
Message-ID: <20260123073532.238985-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcases for BPF_TRACE_FSESSION. The function arguments and return
value are tested both in the entry and exit. And the kfunc
bpf_session_is_ret() is also tested.

As the layout of the stack changed for fsession, so we also test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  |  90 ++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 110 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
new file mode 100644
index 000000000000..75bb42942b67
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <test_progs.h>
+#include "fsession_test.skel.h"
+
+static int check_result(struct fsession_test *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	/* Trigger test function calls */
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, "test_run_opts err"))
+		return err;
+	if (!ASSERT_OK(topts.retval, "test_run_opts retval"))
+		return topts.retval;
+
+	for (int i = 0; i < sizeof(*skel->bss) / sizeof(__u64); i++) {
+		if (!ASSERT_EQ(((__u64 *)skel->bss)[i], 1, "test_result"))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void test_fsession_basic(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+static void test_fsession_reattach(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open_and_load"))
+		goto cleanup;
+
+	/* first attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_first_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+	/* detach */
+	fsession_test__detach(skel);
+
+	/* reset counters */
+	memset(skel->bss, 0, sizeof(*skel->bss));
+
+	/* second attach */
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_second_attach"))
+		goto cleanup;
+
+	if (check_result(skel))
+		goto cleanup;
+
+cleanup:
+	fsession_test__destroy(skel);
+}
+
+void test_fsession_test(void)
+{
+#if !defined(__x86_64__)
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("fsession_test"))
+		test_fsession_basic();
+	if (test__start_subtest("fsession_reattach"))
+		test_fsession_reattach();
+}
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
new file mode 100644
index 000000000000..f504984d42f2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 ChinaTelecom */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 test1_entry_result = 0;
+__u64 test1_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test1, int a, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test1_entry_result = a == 1 && ret == 0;
+		return 0;
+	}
+
+	test1_exit_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test2_entry_result = 0;
+__u64 test2_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG(test2, char a, int b, __u64 c, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test2_entry_result = a == 4 && b == 5 && c == 6 && ret == 0;
+		return 0;
+	}
+
+	test2_exit_result = a == 4 && b == 5 && c == 6 && ret == 15;
+	return 0;
+}
+
+__u64 test3_entry_result = 0;
+__u64 test3_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test4")
+int BPF_PROG(test3, void *a, char b, int c, __u64 d, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test3_entry_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 0;
+		return 0;
+	}
+
+	test3_exit_result = a == (void *)7 && b == 8 && c == 9 && d == 10 && ret == 34;
+	return 0;
+}
+
+__u64 test4_entry_result = 0;
+__u64 test4_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test5")
+int BPF_PROG(test4, __u64 a, void *b, short c, int d, __u64 e, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		test4_entry_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+			e == 15 && ret == 0;
+		return 0;
+	}
+
+	test4_exit_result = a == 11 && b == (void *)12 && c == 13 && d == 14 &&
+		e == 15 && ret == 65;
+	return 0;
+}
+
+__u64 test5_entry_result = 0;
+__u64 test5_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test7")
+int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
+{
+	bool is_exit = bpf_session_is_return(ctx);
+
+	if (!is_exit) {
+		if (!arg)
+			test5_entry_result = ret == 0;
+		return 0;
+	}
+
+	if (!arg)
+		test5_exit_result = 1;
+	return 0;
+}
+
+__u64 test6_entry_result = 0;
+__u64 test6_exit_result = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test6, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test6_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.52.0

