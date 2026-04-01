Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F7436370
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053895; cv=none; b=anxiRRZWRbYrZusg+tUzgPokor40Po8WEoEpwrhGq60i2ZaLyhLageRaFiwwMEVEMdph7LZTUnpAHQFv7K6mXLztOWz9JYRvuyVEMsXjA0d3KSQIjuHx4IFLLSXVsK7v1u0pIA2CB5IZLq+ts0xWhES42TExf1n+CHxWKtXtF44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053895; c=relaxed/simple;
	bh=glWcsDDGalFiSacOuqeQ8XYEgwxT09FNo1V5BLl8j8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ6KO4VUgsZLDDEZSwg9P6dlejAGAvUOZ0E3Rf5mbxE8lORcmxx+DBF+lsRSJoO1Tf/bhtIk0SaqaornMEXuDShcWoXuvHVomsunakzNSa0AjQRLm/h+itfV5YknC8yXaRLKj73C2mNn3eDTROk5bCiFRL9uhedOdGLv6mFnjHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d0SE9Uwe; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d0SE9Uwe"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66dece07f3fso494214a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775053892; x=1775658692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDs2LjLXuI3q9xyIbH5MiBpzfTWmmXLZUhlHw8UKTVk=;
        b=d0SE9UweCOwD+w3U5+pxIrZvEe1urMSkIFkP92XuJpyrd6PR4NqfQjz0MKwuqwKu0W
         cqxlp/9NvadayBzUhgHp8+J21WELa4V/W49XVLHGLA1wcuVIQnEqWVvb9HckGxRWRxhF
         wrT5IYCjF6on7a0XoZqNCi786y9aPpaoLBn6TzHQ9RxMDkaH/H7M+SIAz0rI9AintopV
         y15SgKXzJBDhYBb1NtVWfqhIrhfPaNetzrciB6rHpKQbzrU1/xBVu1RZB0IBM0oK4i9J
         Tb3cAXbVtvqLWSEWhXprJ+/SJZNhR52jNM6YYQOX0wMfgNlDf1mnlcOcSfn9HVrFCKLW
         2f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053892; x=1775658692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDs2LjLXuI3q9xyIbH5MiBpzfTWmmXLZUhlHw8UKTVk=;
        b=coYkddvAWIgsmx/4c/l18EGJASPIx7uMnVwGnOnvvAeJxPxQT1U8vUCFgmdetFK7OS
         quYzGno+kMJCnY1F3dxExePLv/H0wNnLEssbnCH9sN7dR0CIdCe/lhSHBffPJmGt85ik
         Nk/+xJMJMEkljVmRKulW1wFKVSeixZH971faAkS2DshLXKv6FqASPNLVWUPThCAL7tqI
         YiEyNZzEk7O1nN+m53hwRwRxLTmRFXloyjzGYfA6XLBZxJ2Y9mqoB2dgOXyZGLlawktv
         vt/z0qunxwvF9+1hNbkJv35M1Fny1+muemIIBQbZEngDA5iTpj51bDrJL23dB3/xxf0O
         BJ/Q==
X-Gm-Message-State: AOJu0YzyNRZgyxZLao/HgwAd+5NNhujrYDkaTqgy2lLrhkCLfDH/F6QW
	9w0vFmX53LPNknJuYNyjT1czRJVcG1tgn1voaHf5mVcl2JBpDSsdua0Pb0I3v656M/d8BhiaA/e
	g63xzuI0=
X-Gm-Gg: ATEYQzzB+wht0tipfusPt9CZVEjZTrhbNLsM4ASa4Lo0fk4HGT7EmAeqtwl20bpvP7p
	GQsTA5bj/c5GD0fG76Lrz7cqGblnFojWiAzML4+9Goj4ksdI/1vO6eXxrugJwussdpcK0fYpCVq
	yHoqnNoA5nQKhuXq17rgZtNH2L88NO6x5BJ2X0BZjtCytfDB9XAWYy+pH+sK/86HiG2gOomHmNG
	0S7pxQbQsv4BPDRy+usdyCmpmvpR+E8moHUsSSVJtGZr565OhKT7bq4Zyq5mE3VeifbRj6bhBn5
	AFTUxMt2lH3PN5hlJQrhT4XQtEbtlCTGgrBIShDovP7h2OxRM0m0vrM111Zx3Tbm57cHtb79f7C
	v7MNtpLDzX4Z59NEcOwbuP7DwZ4xVYjQxNuk4wLTjv0czsB5OCuHF/qJqzFT62sQzjdZYVIeIcA
	UgXvPRwO3cRawqgywTAtj6z3Mxy6C2H6+d247yVWvVkh7liOPZYLH8gVyfqXwNgcyHvQzCphBR
X-Received: by 2002:a17:906:f1cc:b0:b9b:5164:9057 with SMTP id a640c23a62f3a-b9c137a9d07mr253197566b.3.1775053892398;
        Wed, 01 Apr 2026 07:31:32 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm199047295ad.48.2026.04.01.07.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:31:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/3] selftests/bpf: add test for raw-address single kprobe attach
Date: Wed,  1 Apr 2026 23:29:31 +0900
Message-ID: <20260401143116.185049-4-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401143116.185049-1-hoyeon.lee@suse.com>
References: <20260401143116.185049-1-hoyeon.lee@suse.com>
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

This commit adds PERF and LINK raw-address coverage. It resolves
SYS_NANOSLEEP_KPROBE_NAME through kallsyms, passes the absolute address
in bpf_kprobe_opts.offset with func_name = NULL, and verifies that
kprobe and kretprobe are still triggered. It also verifies that LEGACY
rejects the same form.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 9e77e5da7097..d7e276e5f4ba 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -123,6 +123,80 @@ static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
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
+	if (!ASSERT_OK_PTR(skel->links.handle_kretprobe, "attach_kretprobe_by_addr"))
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
+	ASSERT_ERR_PTR(skel->links.handle_kprobe, "attach_kprobe_legacy_by_addr");
+	ASSERT_EQ(libbpf_get_error(skel->links.handle_kprobe),
+		  -EOPNOTSUPP, "attach_kprobe_legacy_by_addr_err");
+
+	test_attach_probe_manual__destroy(skel);
+}
+
 /* attach uprobe/uretprobe long event name testings */
 static void test_attach_uprobe_long_event_name(void)
 {
@@ -416,6 +490,12 @@ void test_attach_probe(void)
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

