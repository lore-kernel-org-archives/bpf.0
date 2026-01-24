Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3CC28C2A1
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235712; cv=none; b=swNeJpisDjHtk5RzWrixdV4CxTNiFF1vCX9669c60B4iCa4cbtlM3MIWPscAGG1kbDfMZ5jUjY5nx/PahtFCF+c033JkuWZAIcD/+F8KHYeo8ZgTj9oBKfHNDtkaFpXzrc1Wrw/S+HuFw4klnZsRUPoF5KCdbXe1CTYzgeKwDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235712; c=relaxed/simple;
	bh=NMhfMKw+E8jT0WPxwfHo2GO3dNgWbESa3HXh/xZZFQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgZQqNnWZT6WkQ47GGFUkVHv/i6AEdSwSSms/xgrLXtB7Ob3jbQbo5JZhnZYEL/CWUUo23xlP5e33fy+MWYK1mf/G78+vVdDLDGpC8vxC9i6MBuLnvGFoXU9z9HGBqxU6XDvAdltELvSfGAc+qNwuGR/lY6Kt5CsaUgL3w+hFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnyPgBgk; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnyPgBgk"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a1388cdac3so22820965ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235711; x=1769840511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=nnyPgBgk0Qt6bK5+nC3N48gjjAI/cW3QWwZ3OAQoJgf2HUYBf6HofP8sSkco4f5WKU
         cRO704xHhrCzXG4coK6LtaZIa9mpNBJduPfaxOq5khBCsPNK6Ri9ZyR/mA9Ya9WE/HME
         Clmg4WIfqLjHU+lKYRrZQmJgYhiGaU3iKwi+y014xwG8iogBkNqim71dqZvMAtQJB7xl
         c126dt3UoWbtkeAlkB16OVBHUQxyypBVpi0uIjYGNygZYNEZtnD0RVtA8lmiCt818VYV
         3/2UlPwIIksq3MbriZEVS9+PlOwvXiZC4Y3xV9AjuX7aYCYNUwkm4B7F+Xpte9eoj47I
         ASfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235711; x=1769840511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9tfRq7kpRfTqZi2VUjEMy6rc+Konf695G7WjTH97jCE=;
        b=qGuBspNzNDMmEspkRdsGuvNOFG0z++I81PySc1vK+GNwUQ04Fk9dIg4Ke6R1BNTTmt
         EwWWsundc+e15lBE12Kj+9oA6SFuCFp7H6hR5HemeWvkRWk2eSzJL8izbisHOTcV8c0o
         53mgRldgTZLZ6jRHCTplZyFpd1P5xseA0xUUc/Gn2M3Z/Le57rK/px0QBnDCxyNwe4pj
         ZH+uv2fozBuW37FlCiHN9uDYK9EE3pvSmc58AwzFmiRUDYL/VTcBdaOQTaCFrwxHa4OE
         vatyZU9cyMvJPUi9M4cJWpl2C+DVKLhSZ1v6kMfUwrf+7N7gI73IMaNPH1sdCEE01njl
         U50A==
X-Forwarded-Encrypted: i=1; AJvYcCXU/tnzGBVE8eUF/Rcf/r3hp0jMyaXD/0qpES7ueqCKjiAPoSvPbdLpCTQYGJuKV/HuOow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5mavuG0Geu2HacHk81vLKAg11tFBry3ztuO4OyAOtkVALIXec
	Ess/D8muIT8cF6qA9CHSaekHfx6GIxA+H7dwS3FsFduS9QBF5SVnIlzx
X-Gm-Gg: AZuq6aJ0ybiS0CIPNo3ku4V6j1D2fkXfS7j6KxSoBCxpcPShIFAb6/oLPhmjTIliuIc
	ATqkkiQLAbY/yCzthWQTD/6KMpowVKfBD8tzP3yyE+V6efkDGsz8YUeSlbk8mzE4xQ9trG9EK/4
	YEqgaD9JPhj2zBGAIQdfNlUwLDMtV0bUHYaYP/M1y2SDEYn+0ZfbsyOkcb3vrFdmo2Q64FukD4e
	nJjfFx5bDxPCtyWlP76cm5ZdOjc9TWf6n6E+c613sUksoakSb5+R05056m/kInkbVLxT+L0YYer
	PK3PyZ2gWQ67r9N59DhqxXZoHKgz2UQFp4nMO7CfCVdnx1bw54PWhbg7NFDPZp0a5RTL1pP3bbB
	enwSRdmaTG0GwuKshOrSo8gC4SsFJWu4PyW6+yTR4FQkNWW+G3afiUNE3k7pAt3uSWGmbzMxQ3Y
	RQBx6Y5FGt
X-Received: by 2002:a17:903:1aa3:b0:2a7:b646:54d0 with SMTP id d9443c01a7336-2a7fe733e05mr55712075ad.41.1769235710737;
        Fri, 23 Jan 2026 22:21:50 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:50 -0800 (PST)
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
Subject: [PATCH bpf-next v13 10/13] selftests/bpf: add testcases for fsession
Date: Sat, 24 Jan 2026 14:20:05 +0800
Message-ID: <20260124062008.8657-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
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

