Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C9133F58A
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 19:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070706; cv=none; b=UjaFspNKBasuL2jNx8kBN0tfWIMZghwhNx8csJgR1GIwKyEgt3Sq0WzxE9aiGXiVbCy6+Caa2HMJ5N/9Dg5LGErdUeVPxbU7VC17fdnO0UOjU5IyMdI46Sio3TU0woM3VKLG1r5Lgot7Fdd0p2nw7YDLLD42ts0C6skxV3sNeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070706; c=relaxed/simple;
	bh=zreID7VlKz3sOwx4c4xLYDTLtsQVmx5niiZjOton9/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBng98IHnJCvW5q0zxq9ODx+gg7OD8b8y+Qp+XUFFdh63M4oOB1ZMwsCPCUUK9ZdzLNh+0erP14ycbNI8WFTa5TSW1M4ZeAP52vqFHsnfv/6R/KrqgORcXyDehB9hFVh/RYUGooS/wazkejWp7JXkfj91YfU1NmtviF3YR/30Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOLa6wA/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOLa6wA/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2adff872068so254825ad.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 12:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070704; x=1775675504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq94V4VxVCzdIEnjJH0P1icIANAAhuTjvKKe0p+pHxU=;
        b=kOLa6wA/yheVe+rFDI+qOwktORz76Tgv3Um/kyZ5lwsCdYuXIukYGnLO3vDqLemS86
         KZ4raew0UrTcR4/DSNZUCbCcPl4WRN7ymlVQA+dJnOoMxh1vMihgapgB7P5u3qbIKRQA
         VLIhUvEo9utpMPvCHcKfK16EvD55dRRcEr8Djc+rUh4GAxCizBF0a8s9iddLrwRQop2w
         YtsD3N2SPPFIUqxM459anghfEViaq2PRbXcfwtLr63Rz+kFwzK9hZoI2HFB3GFThCJNN
         dg+vH7GxUJDESZer5JmZPuHULPkOR7vXrMOFZebd1WY4nNZLTrG4+q7xUuQNkeIshVtT
         Uujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070704; x=1775675504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hq94V4VxVCzdIEnjJH0P1icIANAAhuTjvKKe0p+pHxU=;
        b=LctAgLWUJCMHo2WwT+7gY0tSdD7Y/YpM7Fx7HJEgUTu5hsLkmy2ZUT3xG07WTssdiD
         e2J2u44oO8oXcW4swNp3waqqldgUwylV9TorLNYldeRbKES9EoYfXXDiYAW9fF5sxZbf
         YTzeUho1/5JjhDNc1gLYx7K4dV3KaIcG0dafdz4qVc+s49yNp8UaKQy4MVrHN5AB9GHq
         Jsms7gkh/8hbm7OEBI4/rDWJRSsgZAUyTpPYq/UO6/+uyaj/wTJZU8GcWYf3wkaDwkBp
         XgVhZ3fI0UhSscbnG8xbi7g3erw/v8xw1gUN7df17F/cLzBZI8ug9YCX5lxZDefPKi3R
         /7mQ==
X-Gm-Message-State: AOJu0Yzrc722w3wkRIj8tsx9vIJQ0yNI+g9MsHMZ0MKWU6AzTEIhZV5M
	kgoARDdIcXiQIphl0tM30cVoL6wgvtCJdf/t+ct0I0RssDD4lp8p9Lr0GoNLx2wH
X-Gm-Gg: ATEYQzwPONvvfD2qtm8Dmzhr3CCkakRyyWSO6oRy8VpZwXVFOJYw58u25Lb00HEDANm
	6C6tfIv4wZf9O0CyjB/B12xX6ucMHRiCYmepAtaIOrrJ/ZI55csu507GwTh04k+Ujun4gyfae0E
	CGqv9X8rr/P+4ACmX4b5Ym8QlzWemefq0/LxWWG0N4GYaC75gMjT9otcIsfwVSfSseu46wxNQnt
	ZilxN+8rRUOMZ2AwctJuOkFRoJOtDTbyKn4trCPgtqB5SwXj0KSmYU6+1CASkcJiuPLRsHja7SO
	rALRgmBcwbKNoMKIU2ZyhHe6+IJRGhnOHEW4VwgDflnOfiykZxGvHuIu2PxGkdKnZbboR7jqXjQ
	USvo4tl9T5JAElVGrOpLfXD9YniuiS+pEs1TETc2qt/uIHNz85vTlH5TW/gtzS+ySdPFQ2IfHUU
	ntvpHUNtQ/EGB1d6uR3A9MrrUJB2JCFCujZaOAybP5fBPSzD07MCFP1sltZlTsQQyrSX6H
X-Received: by 2002:a17:903:2acb:b0:2b0:6ce3:8f7 with SMTP id d9443c01a7336-2b269cee743mr46533815ad.43.1775070704223;
        Wed, 01 Apr 2026 12:11:44 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm6805875ad.27.2026.04.01.12.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:11:43 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi is not sleepable
Date: Thu,  2 Apr 2026 00:41:26 +0530
Message-ID: <20260401191126.440683-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401191126.440683-1-varunrmallya@gmail.com>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to ensure that kprobe_multi programs cannot be attached
using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
 .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
 2 files changed, 54 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index 78c974d4ea33..f02fec2b6fda 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -10,6 +10,7 @@
 #include "kprobe_multi_session_cookie.skel.h"
 #include "kprobe_multi_verifier.skel.h"
 #include "kprobe_write_ctx.skel.h"
+#include "kprobe_multi_sleepable.skel.h"
 #include "bpf/libbpf_internal.h"
 #include "bpf/hashmap.h"
 
@@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
 }
 #endif
 
+static void test_attach_multi_sleepable(void)
+{
+	struct kprobe_multi_sleepable *skel;
+	int err;
+
+	skel = kprobe_multi_sleepable__open();
+	if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
+		return;
+
+	err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
+				     BPF_F_SLEEPABLE);
+	if (!ASSERT_OK(err, "bpf_program__set_flags"))
+		goto cleanup;
+
+	/* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
+	err = kprobe_multi_sleepable__load(skel);
+	if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
+		goto cleanup;
+
+	/* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
+	 * Also chosen a stable symbol to send into opts
+	 */
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	const char *sym = "vfs_read";
+
+	opts.syms = &sym;
+	opts.cnt = 1;
+
+	skel->links.handle_kprobe_multi_sleepable =
+		bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
+						      NULL, &opts);
+	ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
+		       "bpf_program__attach_kprobe_multi_opts");
+
+cleanup:
+	kprobe_multi_sleepable__destroy(skel);
+}
+
 void serial_test_kprobe_multi_bench_attach(void)
 {
 	if (test__start_subtest("kernel"))
@@ -676,5 +715,7 @@ void test_kprobe_multi_test(void)
 		test_unique_match();
 	if (test__start_subtest("attach_write_ctx"))
 		test_attach_write_ctx();
+	if (test__start_subtest("attach_multi_sleepable"))
+		test_attach_multi_sleepable();
 	RUN_TESTS(kprobe_multi_verifier);
 }
diff --git a/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
new file mode 100644
index 000000000000..56973ad8779d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+SEC("kprobe.multi")
+int handle_kprobe_multi_sleepable(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.53.0

