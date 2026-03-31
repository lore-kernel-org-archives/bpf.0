Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C31EEA54
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950074; cv=none; b=c87/ifZkGFNbEbf4O8pC5KbeMsG0TKZpXPlGdFXGPG2btMi4WU3fg2oGAeVXPBUNEMS8jrfkHWMOSZvc4fpcTsEC5BVsuBAWqXylHMiY5SXpiuNkS/Z50trQOAtHq2jiKoVrPNCul6d6jCSNAe7KZ9hYxYr3dTLQK4MmHvlUryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950074; c=relaxed/simple;
	bh=rQBh02MaAajKMfKDC8YMNgw3hVbVvfm1kxuP49DEQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiIFYE4k8yIFT8bcZjLjvLIpc3e4yfGM1/givJ29vedPc9cXt8OPk9Vrl2zqsucO7p6864KYLBYWFLO/fnHUL8Vd3Gsy+btQZba5Zx51H7LVApyoh8cSaXWQ9NnEXsUjc2NX25Fq6E1r9+VoGMOGWEkNTh8DZ7ljspPQZZu8qh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LHVA964S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LHVA964S"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo60051445e9.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774950071; x=1775554871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsziD70VgpPgjTdfHcq7GvG3ra662CqVO4P1uVRU6Ec=;
        b=LHVA964SVm14THwbjTqDB3ocvdVbXmAt5uWQg0I/W5iB0YDKc0L4MQwkLIdMoJqloW
         su0Adq7oqcoA5Y00iRuIuQe086M6i1rIBe/kUAluJ3+XSQ781Hwzu1R5qBbipuTMDX1C
         FZcuyIdfzgdf2nCh+o6H0X8OFU8HWyB2R7KmD3gyOYjgKRk5dlsxlAXUww3jtgQDacBr
         lHXITDgQ8imXaqZPdRYOasXwN74r6n/opcpPuSpkYww8F0xUxNq4oXZ1iwSzjW9xQedW
         gDDch+txYqvdJUDuqi2n2t0u4NhunIJdMthjgOFHlQQZqKEiwY2AokYjcfESt4StNgSn
         C4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950071; x=1775554871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SsziD70VgpPgjTdfHcq7GvG3ra662CqVO4P1uVRU6Ec=;
        b=Rgty/ovHejKtjM1JaWXWoqOkhKfV9prQTwGBbW6rvPe+yA+OQs4MlDoUGykbNlNnnv
         9HhyXfjYKzS1LNreWyNVh92AA7XaV4ZgaY3juqI7X0VloZZD85ywfq7pNp2wiptQjAQb
         HYL1nKFTyanY0o8N4LA2tRCxDhsw7hgC+P7l4eHhLt/0DCi+OaCZjSF+PtxCxlTOjfnf
         Dk4GFA/lDBk5414pbNSdJilS+zU8m9aO5Qg9xmKoU6z3XirqlNPnifQdQcIcTqp+tmkV
         vcb55qETfjQCwiMYGizE5uMqXgql/ldbzA+YGeUx+JuhJZ+U5RL7oZUsRUbQqHgdFt/x
         AKTA==
X-Gm-Message-State: AOJu0Ywiiowe141QQnmgebxx98nJmUjHP8nKo0S3JHyQSgMrB+HALA4G
	njBu4iwKvmCJtZXVdp9JD4aX21p3nU25MbVmoRAgufDukdWw3uKcIn7srowupT+G5evzuhhHjGa
	T6sM7YuU=
X-Gm-Gg: ATEYQzyVFBboxb0CjFx+4O9n90tlHZlULbM5RXkDTezWWOnJfJhC8gjCWgq3GFJKUGz
	FbM3TgUEFZuSC1JPk7clELyabiRl1HSKT+DaLaGgWM0o0QdTzpJWAbJ4iW4lSNxW8wyVe49gPkC
	FQZOTMQJV0pj/qLqYAJYZTohZNLDvygu/nU7x4BKj0kLYj1quaG7mbn6ZcDCPhP97y9VD21gzZz
	y81DPZGPJHzzF4OfhIbTBha5+9SOG6GCW6V3HBTp6wm0cWsAz4WCv+g9P82rCCaxbWktEW/fDNR
	zAGI4ievE3pna3hdZ7xiFWjz8RrKrADZZLzC29xoeqpYq5xO2DmqzT/302Fp1O43xtpnRAG8Y6w
	vcORH5JNS1nxka2OSy+ouVfcdpWb9bxVfsUHFo5CNmup1TPN0wR2VueL7DNLGbO7JA0GoyFkUiw
	Ul+CFQZlP3qUPuo7dH5ImHSwfNv5ZHEAzG9kd1u8TypoeMpFvuKv8VlKdW7+AcOQ==
X-Received: by 2002:a05:600c:870f:b0:488:80b6:873a with SMTP id 5b1f17b1804b1-48880b6936emr1354875e9.21.1774950071278;
        Tue, 31 Mar 2026 02:41:11 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm130079565ad.72.2026.03.31.02.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 02:41:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add test for raw-address single kprobe attach
Date: Tue, 31 Mar 2026 18:37:47 +0900
Message-ID: <20260331094058.49229-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331094058.49229-1-hoyeon.lee@suse.com>
References: <20260331094058.49229-1-hoyeon.lee@suse.com>
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
index 9e77e5da7097..817c4794d54e 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -123,6 +123,82 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
 	test_attach_probe_manual__destroy(skel);
 }
 
+/* manual attach address-based kprobe/kretprobe testings */
+static void test_attach_kprobe_by_addr(enum probe_attach_mode attach_mode)
+{
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
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
+	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
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
+		ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe), -ENOTSUP,
+			  "attach_kprobe_legacy_by_addr_err");
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

