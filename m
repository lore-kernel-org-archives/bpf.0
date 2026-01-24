Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F99E286A9
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 03:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225582; cv=none; b=q3GinWdJyEEDrjHsDdywxadCS06squrfvN1JeJRGb9HqaA50jnzNHefiZK77BpOmaZO+b7BqUc3hMFdI60C1ZLHSALTnBr38Z9TcrH654w2Twhg0sKxpF/9j9rTTBMV4/rZ22ABP1047DE831voyffItma2XZ1oFS2sjl5V8o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225582; c=relaxed/simple;
	bh=NMhfMKw+E8jT0WPxwfHo2GO3dNgWbESa3HXh/xZZFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLY8mvBNrgC+BB7JXp2MgLqNnzEstpLvyexzZwYwlijHEKXQJ+XZ0nLZJVBxK+nvDdkvupJvxlUCjt8q2hl2FyVgHRKBNFLklCcGwA4BnEIVdsioIECets/3qFiUJdXImY3ehIMrTlO0Qu6rZTprKbsEY7f3MFf6MrKeJq28+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fookqzox; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fookqzox"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a1022dda33so16989245ad.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 19:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225581; x=1769830381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=fookqzoxgTbUNufIl6XFE4cmUNIZlZUOOxyueKtVetpquqZlygcs8dMTxVKQmR7EvH
         AG+n2c4nYbuWXf2DYi39E4qaCGTp1xlym0G95pwkkeXU6qW5gb8jy5fre0wEYTCUEd+u
         4UUwBn/OX2mSkqEZcaxupA0L6wGx3Qtb83B7ONkMy2Pe1Bng9bVbYkrUbFpOQoW//zn5
         9SJeIwtWZ/1n8Wc4JafEi9hCrwO/cjPPXf54+yp2MrBDLWdo4H4mYOoDFFD9MHRbA5oV
         ifr9P8FhE24mta6YS4Rldrv2VwMTm0MJFQtOJLxbPDXQ+SK8U1Q+0VeCY2/nw4/H22n4
         rHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225581; x=1769830381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=aWDPHQ5CgAhKoAwIAQyC9WrmpvArctNXQqeP2U1HTb4CLkNhFxwiU1XxB5Bk5szW6k
         bu0ZngKVyfCapYnorl7vQp8daiLUeviQs0/nt8vme+KOStUz/vKpCsYvTCi0agnDhaJK
         NnZf8giQ2qmhn7hLaF3+/1hmold6xnr/zBi27KY5b5y3YcK/CO2NEliqPMWeQRFYloFr
         hsc/woloS3/V7l8/osyAdOq2S5ZCo4EsSB4dipjC91ox32sHVTOprBG9zMY3FdQBcWSB
         4XfOwASybQQ193GfHEjK/3stSqiniTZI1uqOkkcHqsJPDo96nMsgh7Waip4tz4uoy16C
         z1aw==
X-Forwarded-Encrypted: i=1; AJvYcCWUnBlTEkg8E58Pi9xcHxdqNSiiVWiN9hkuqMImfJVsxlpagjWyKjol0RNZgtsXcGOD+3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOG+NFh7YoIppaa0GqvmpJ+eLvK7G1UmsDX/k6WfwloFb2zavo
	iw/RyEqkYmR6ftVZLl7WvaKX+mCTwODwPAF/Z7P/tZyaC1rYClWCXPOH
X-Gm-Gg: AZuq6aKhG4OnOK8hc5c2UcV+jPtKB/4KXtbeYDXs4L9x0aja9nWHN805CS4JkbiHQdk
	HvzwTUOlKjDW+UeHpJjsQku4kyKQLHDL28uV55TEDLg3yaUnC1Kf+OLq5BnttB7qVbckAiZv0zo
	iq6dVK9l/EIB7phWW/k8CYe9kAeaw/sGQ28PzZUYQJddANXJg3NII3mmzg/G0h0o8YdC2gc3X8Z
	uywsHOCef0Z6qVAZ24EqBWxQcuoXI+PKBURLvsH2Uox0CuUY71rKR5H+zyzZcRdubp7TkysWKeP
	DgNEfV3ooDuDhyVHGQWvWN5A8e3wBC0OydM4iD5/tHdUZlidgHIAjpkANJjYmc8rJF4Ui5sdiPk
	9T4zfSmOw9zViSWLb9FT3pzPAJenCfMApoiNrjsSeOpAKJrR1rXErkrmdNHrMRuyGc4fbsa5dYx
	a8Kn+6kW9v
X-Received: by 2002:a17:902:e88b:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2a7fe443107mr53079405ad.5.1769225580791;
        Fri, 23 Jan 2026 19:33:00 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:33:00 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v12 10/13] selftests/bpf: add testcases for fsession
Date: Sat, 24 Jan 2026 11:31:16 +0800
Message-ID: <20260124033119.28682-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 90 +++++++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 97 +++++++++++++++++++
 2 files changed, 187 insertions(+)
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
index 000000000000..0e1b66b2dddc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -0,0 +1,97 @@
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
-- 
2.52.0

