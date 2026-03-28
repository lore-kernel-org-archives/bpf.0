Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6633DEE5
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712647; cv=none; b=dgeRXbdfZeWxKKbWEJZBulGnF0ZIs+E+nRdpajKXDzBlzGoK2xEqtFtiN0uUcmUzpVkaxKNpjN9lZbwhZ5RGRMGTXsjJXu4OE9eqayF0Ibmn1J+/Xr5O/4ZsEnUQaEWppu+Shn7/ccIQkO4KK6a2w6JGAl3CzXitrREpjqzHNQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712647; c=relaxed/simple;
	bh=+JvJUtFV1FwOAyBEZih9NfIXAfatfUjyA2bfmrJIeeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZm9EWoJsMnJvKA1A35TwRz81vSfnWz+krFVY1XdQEXxBh+NnmdaiSyedbhT6oy9o/fzV5aml+XRq1j4dnhbXbZnP7ULj3OQ0tm+nEQGv0bBwNZf99xkpol7EcTjYOpqhqP3zsGjDxKf+5st2XDtcy2zBXsKfyapMDA3XWq+Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WRQ0j3C0; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WRQ0j3C0"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2a8abac7dso1812533e87.3
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774712644; x=1775317444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnDYuCPPOC0a7dKZYCydLNtXkl+EJ9KEblo4sLyQOoE=;
        b=WRQ0j3C0vG85UWu25ZUNhiEcoJ6LOSEVZtsBOnwbj9ZHoDHc5J2aS8H8kKIFgUgszU
         kukXdcoigVaM6nGbvcNV6wth6nsF7qYtKc72v7Z06u9PUgoHJJp18TpCb+AlBuCliUMp
         M2k8TZgfuGB6hJiAJkiMzny+QZIchIifU9RWM5i3OY4Vb24VtqDiE1HTnZFq7z66QmlH
         IWdTZdi+fQZecoL5Um/WJtx32+0TdEzTS+RWOiAVjw6Z6TfuQXP+mzRj6Ia6Csc3JuiG
         l0H64aWDeAZZreG+mCXmD566o4A25UZ+Knnjxl1P+d1XM6bOKq5Al+e1X3slGAHKywon
         sRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712644; x=1775317444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CnDYuCPPOC0a7dKZYCydLNtXkl+EJ9KEblo4sLyQOoE=;
        b=UGRAo9jJdVN+akbO/wvC3GTIZTwU3jF5eKOmkhldpcg0cfjMR//EQLsCw7p2TzyNGe
         btl38Y4TTCgDSL9CVTOXSgMwHr0n7lXrPYiHAKvRRiAQpalxK4Ar2YlQUSF5ZSTZ1KiX
         0erGjUg3Px4xhOc4/nnnCyy5QEgRDD0B+OslJ+yxG1SpK4gievaBag6FrlQZOubLQd4M
         Rc09gRnBXtR4fN/VHe+4iKyVS49hh1tZwEEorv3SWwm9LlAIted18jCf0MDXhNol9JKD
         B9e3+KLEt8hVYh5gEiuG8bJ7Kv/QubFjmoftj4Ww/skDtGjokF+7nj6uHVv2hgw8OljX
         vnug==
X-Gm-Message-State: AOJu0YzZVd7gGqcpKZ4RaEFsWYZ0HkwpYmn9wX6zJGjELuQXllaMe9YX
	Oh1nX6ktHgXyn+rqaLOe5P0GKn0d0Zz1rRxP07KjEFzny2q0akKQ/8yvDb0dE3GjIh1mr8d1wr7
	Ac7XDwjs=
X-Gm-Gg: ATEYQzwVw9kjGzCR0+LVpABWNx+HRoVrBuk6AcSL1q9b+eryz7iN9DR1bmS9CeLQIht
	FTax7FTcOW7TTFb/3XB6ncZth7Kc6l7Bv/iu7chQEi7eso5ObF4FeyCCG/sM4ltCT4ddLJnJdlr
	Kt8Mmu7L6KFKnkf8PCk4LuGA/mStsHX/om9L0uzxQw7hNgv8uqZsdnVmj6gddgza3mcqjyXEcDP
	0pg+TNl+CQk21oQgNmg8MyZ/PKYpWcYjj8AbYBzycs7z7P/h3XgH0YWGuK5F+h2iIegnRZRy2K7
	hvb3LjqzzXCpCYdORtKaV5UwRXnsSqJhun6exQp6Q8o86P8Kz1awryzqP0h/BwxaYGi0/j1TmS/
	8xmlPF+6GqWYewI0pw6VoNJKYHx/WKUgd1zOnTTlXVGUGoXFcO75KjBPhOlAOI9NUbb601Lo9X4
	cMzMLfL4L2VtbvSnRUYaXPJcAcxY3WYcFPhGy+bpdYdIVorCee2ccRIdudfNuOEA==
X-Received: by 2002:a05:600d:1c:b0:485:3f17:425 with SMTP id 5b1f17b1804b1-48727ec7681mr82529125e9.21.1774708015839;
        Sat, 28 Mar 2026 07:26:55 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm1874017a12.14.2026.03.28.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:26:54 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: add test for address-based single kprobe attach
Date: Sat, 28 Mar 2026 23:26:09 +0900
Message-ID: <20260328142643.627560-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328142643.627560-1-hoyeon.lee@suse.com>
References: <20260328142643.627560-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

attach_probe already verifies manual single-kprobe attaches with
func_name and optional offset.

This commit adds address-based single-kprobe attach subtests for the
two underlying attach paths, legacy tracefs/debugfs and PMU-based
non-legacy. The new subtests resolve SYS_NANOSLEEP_KPROBE_NAME through
kallsyms, pass the result through bpf_kprobe_opts.addr, and verify that
kprobe and kretprobe are still triggered.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..64f2ed75779d 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -123,6 +123,51 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* manual attach address-based kprobe/kretprobe testings */
+static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mode)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
+	struct bpf_link *kprobe_link, *kretprobe_link;
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
+	kprobe_opts.addr = func_addr;
+	kprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kprobe,
+						      NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe_by_addr"))
+		goto cleanup;
+	skel->links.handle_kprobe = kprobe_link;
+
+	kprobe_opts.retprobe = true;
+	kretprobe_link = bpf_program__attach_kprobe_opts(skel->progs.handle_kretprobe,
+							 NULL, &kprobe_opts);
+	if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe_by_addr"))
+		goto cleanup;
+	skel->links.handle_kretprobe = kretprobe_link;
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
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -416,6 +461,10 @@ void test_attach_probe(void)
 		test_attach_probe_manual(PROBE_ATTACH_MODE_PERF);
 	if (test__start_subtest("manual-link"))
 		test_attach_probe_manual(PROBE_ATTACH_MODE_LINK);
+	if (test__start_subtest("kprobe-legacy-by-addr"))
+		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_LEGACY);
+	if (test__start_subtest("kprobe-perf-by-addr"))
+		test_attach_kprobe_by_addr(PROBE_ATTACH_MODE_PERF);
 
 	if (test__start_subtest("auto"))
 		test_attach_probe_auto(skel);
-- 
2.52.0

