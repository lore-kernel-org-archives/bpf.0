Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE9837DE9F
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021160; cv=none; b=upYOkVd5l8W7ATbaxyTUPMZo4D1ZAGPdCpx4YS4vtKLojTKvfO1NuSHrIxf5OADU7kulZHP7EoPmAzIw+3cqAQKzsUz8FZhmA6+vqj35OgptSIH8C3BAP+VRqSV0aQEl72RGLjlLej8QTpB8+xM2EBkA6uWu4XnOkmUgGV/Gak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021160; c=relaxed/simple;
	bh=Bx7ZKiCR+YTeCEb1pdcIvvplXe6zg+4+eQLydO/doHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poEX0WInr/ZQMV94F9Ffjj2d94kIUf7o1YG3+uI4A/s1hp+Yp4UtTcD4Mte1PeydgYhDfrqXcYoj8MdeND89i5N0PChgXO6AICT9wZIHASUl7F98f5MA9YrIEcvJSljnh2JbsMqepK5Jwk3CwM+bMmlhpH1Wj87ENlAIskaWHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KI7+qQko; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KI7+qQko"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486ff201041so63039545e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775021157; x=1775625957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqiSmwJgQ4+uNqG6p5uMKmapSGc5Bt2MrHRQWhazOtk=;
        b=KI7+qQkoOiS7ZG4ZywCKk4keIhNQYAsdsEzC6ou6emWJgkYF41M9q8WoSNmGxWWgkN
         VSD6Ih4GXXlS2/SII4MT9cY1tRXNhq4q0VKn15/F2dop4nY9h2k3q0oVhlip//yM6GR5
         NrGZR8/bR8v1TQKkOYPdGh0S4Kc0sZgZVdHng1xVjLPGBv8dqJQbMbqKKqZauoPmvh9I
         0uuyn2U6IeWIuwPVh2RSFgaXXheo/5uTbe6XsOstwRV8t2IH7yfo999TjNst8tdLIfnd
         QWW1boXsyXJcukwaRzpfBGuvdV9mLvtnDOEcFjywRjJGmTEWZn8UeWJp0jQTPiWTJSPs
         Zwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021157; x=1775625957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HqiSmwJgQ4+uNqG6p5uMKmapSGc5Bt2MrHRQWhazOtk=;
        b=KYK1k2llsoTI/yStdJ9FcNR7xRaSW75wpvDqQS+gVThJFWfV/IgnnopxPd4A1PFE/p
         owCVKLNWYeNkFifRljuONMH3N0FpXEezCW9VEPsXSiECpdLWk/IvuP9W9murAfR4rGRA
         kTa1aM8Zt6cTu7AruC9GDuRw3W8+5fqyLjnvdsklBjQZNqB3iALgAVoAyrb1YOEABfVI
         tZk98sjDdDO9SWTtYqruUISF2fSW1rvxJq0gsa4AXQsGdpNn6sn91tvZ+feC2q/FS4Gi
         zp3VD+XGYbZS2oSaA0k8JNiNBiLEssEpbqnHbNV0ow9HgDBUWVXyd56GZ7IhDX9apb4F
         W9Ng==
X-Gm-Message-State: AOJu0Ywzl55WGluFCyjtdWSrJoZRDdT5w8i/f4v6UzSVkUn4ex6mB81m
	CbT+PNUVIwTYG/6Eri+OzJYyuYUIKmtm/CZqPheUG9kPzXWk4LTja7WfOd67lNoFvfLyyTSGYAR
	xsY2Shmc=
X-Gm-Gg: ATEYQzzIFOPpJvUa+IoFrG12vUlajtoWeOWQYBzVm7u9IKpNkjYKh04z6jUthOnlTDf
	9M0GxvVkoDo24KAB3hZ2nHX4+AJFgRSpS0QpyKVgwVjr4vZmCahjwgIy6913XQSgLEcdZWs2dlO
	6zBJNOmQma/6z6G2l0F91/UAP/WibvgZF7U4lEWnOe0g3RwbYTXO7iALhNPOW3n2DwLlF1NcAQh
	6hITB0fIAse8pXYO9tT1xy/CUoDVYHfLVxlIoHVvTWW/vKTueEmwhx9SslkOvq24jC5PUuUnZuu
	SKXsXGrk9/T4mPGStJscs6sSAs1O5qhotdJ8Pb/ePang7NRXsgkn/4GvzgJTzFcPMbNpMuaqiW3
	rPsAKhARBdrpK7ED8zbmxUR2o6iKHIP1aqWU4Uoq0Y6bIjAzHWIz3oPZcS9HPpcukUNsKM3X+CC
	boMD3rOy6a5hvBxsFY1flmPRU7JckKiHbeCjXErRQTz7jsHXc4PZKBzXga9YIvVw==
X-Received: by 2002:a05:600c:4f95:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4888356754dmr32735925e9.13.1775021157359;
        Tue, 31 Mar 2026 22:25:57 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b818sm15308214b3a.6.2026.03.31.22.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:25:56 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: add test for raw-address single kprobe attach
Date: Wed,  1 Apr 2026 14:25:11 +0900
Message-ID: <20260401052544.100968-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401052544.100968-1-hoyeon.lee@suse.com>
References: <20260401052544.100968-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, attach_probe covers manual single-kprobe attaches by
func_name, but not the raw-address form that the PMU-based
single-kprobe path can accept.

This commit adds PERF and LINK raw-address subtests by resolving
SYS_NANOSLEEP_KPROBE_NAME through kallsyms, passing the absolute address
in bpf_kprobe_opts.offset with func_name = NULL, and verifying that
kprobe and kretprobe are still triggered. It also verifies that LEGACY
rejects the same form.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..a41542f4b35d 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -123,6 +123,82 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* manual attach address-based kprobe/kretprobe testings */
+static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mode)
+{
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct test_attach_probe_manual *skel;
+	unsigned long func_addr;
+
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return;
+
+	func_addr = ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
+	if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
+		return;
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
+		return;
+
+	kprobe_opts.attach_mode = attach_mode;
+	kprobe_opts.retprobe = false;
+	kprobe_opts.offset = func_addr;
+	skel->links.handle_kprobe =
+		bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.handle_kprobe, "attach_kprobe_by_addr"))
+		goto cleanup;
+
+	kprobe_opts.retprobe = true;
+	skel->links.handle_kretprobe =
+		bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+						NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(skel->links.handle_kretprobe,
+			   "attach_kretprobe_by_addr"))
+		goto cleanup;
+
+	/* trigger & validate kprobe && kretprobe */
+	usleep(1);
+
+	ASSERT_EQ(skel->bss->kprobe_res, 1, "check_kprobe_res");
+	ASSERT_EQ(skel->bss->kretprobe_res, 2, "check_kretprobe_res");
+
+cleanup:
+	test_attach_probe_manual__destroy(skel);
+}
+
+/* reject legacy address-based kprobe attach */
+static void test_attach_kprobe_legacy_by_addr_reject(void)
+{
+	LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct test_attach_probe_manual *skel;
+	unsigned long func_addr;
+
+	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
+		return;
+
+	func_addr = ksym_get_addr(SYS_NANOSLEEP_KPROBE_NAME);
+	if (!ASSERT_NEQ(func_addr, 0UL, "func_addr"))
+		return;
+
+	skel = test_attach_probe_manual__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open_and_load"))
+		return;
+
+	kprobe_opts.attach_mode = PROBE_ATTACH_MODE_LEGACY;
+	kprobe_opts.offset = func_addr;
+	skel->links.handle_kprobe =
+		bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						NULL, &kprobe_opts);
+	if (ASSERT_ERR_PTR(skel->links.handle_kprobe,
+			   "attach_kprobe_legacy_by_addr"))
+		ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe),
+			  -EOPNOTSUPP, "attach_kprobe_legacy_by_addr_err");
+
+	test_attach_probe_manual__destroy(skel);
+}
+
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -416,6 +492,12 @@ void test_attach_probe(void)
 		test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
 	if (test__start_subtest("manual-link"))
 		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
+	if (test__start_subtest("kprobe-perf-by-addr"))
+		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
+	if (test__start_subtest("kprobe-link-by-addr"))
+		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LINK);
+	if (test__start_subtest("kprobe-legacy-by-addr-reject"))
+		test_attach_kprobe_legacy_by_addr_reject();
 
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
-- 
2.52.0
