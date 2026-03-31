Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3440626B
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970729; cv=none; b=ksKtHHmOB0vjtpd72MorDb6x4TyyLCDqE1fiWpCMSQc44ovBfvkDMJx5mn2gJfNeUPM2rufE22fL9KBTQMT2qFJeYfbBBGG8OdkjxjV70ZR/PPFrctZx6To4kAgS6KCj47rk6RM9EHtbX13mVosPU9lZS7DU7o2PxjBDUjAJG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970729; c=relaxed/simple;
	bh=rQBh02MaAajKMfKDC8YMNgw3hVbVvfm1kxuP49DEQG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRe6itUCUoTrqDCSglgZjpn15o2xmcNuBV1QqPaf0HI/JoqfUIt9CWfeRlnXBi4G/3e71h0PNrXwqTNlEye4YdFxyFOj6fxDR0tpqWvsJMLSYlfn3CCUgx1TRtjUaKlXp2z3yXw30jShKLFt3/BbOcvLEvclpleF736nM5IQ+Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ckLFKafb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ckLFKafb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b982b0889d8so707436066b.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774970723; x=1775575523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsziD70VgpPgjTdfHcq7GvG3ra662CqVO4P1uVRU6Ec=;
        b=ckLFKafbvdz9cqr2ZRSkVDQVXu744rMOuN/MlVSTqcJf3JfvDMtLKm/hC6k00tkChi
         WE4IsezwxptukObTtAGC53RKlI6pDTJL8lbB7mMXGA8UdgmB1mQ8Eh/b4lQcgUmyO9ln
         SAGI1OxBpPmBqP2itNU18rq1EUBVxlFPDdBgJDf1uDiDeeGjjUmdhNTnHtWh+mJHKBYS
         REHEaX842O5YaUaUkNg6AqOVpFTWBPtaZdzAj9C/7skHmX1mfv3nLqlMcFtA8/L74HG1
         Sq4ZCTorh4igPwV2ZTTr2LJ4oMqDF6zOL9+d4K6Zsquz65Jhx+8jneeXo41WwvpJiQpR
         M1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970723; x=1775575523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SsziD70VgpPgjTdfHcq7GvG3ra662CqVO4P1uVRU6Ec=;
        b=J6EYf1L6V+5W47SH2tcekD1037E0yjTcHA1sBa6eY4gM1SxeLJuReE2CuP/TI0FhZt
         vuWfOK+Pso1BpmMHou8noKiMffxHFBkGdnSsgdoG3GuRmf+XLiYVwlNy6zCSpAQqyvAC
         X3mJaUf2lXWcraigivLTGeMYBkVdLyl/8i3WoiAN1z4Jrvt+vhDSHDlah2okFX3RMw2E
         ofOG5hOdMGVMbl9JohE14+moPSKIOQvjsV1h+CjZ5En/v/Ia7EsIrOWHbICgqNk5CT3F
         A46dBnDs69cv6m/qWW1J1JPWU69gzEgD83ecSI7sgg2B/3jxBNrZOt9du/xbGAmPdGbZ
         JriA==
X-Gm-Message-State: AOJu0YxDIccTNwGM5niVMe7H7FbmIuC1XPVeaAiLo2yCRP4Jdx157stI
	rHRC8ALvW4IiKscSMsUD/lne5sWzKGXK8XT0jfSZA6c8DbvRQp6CyJdldieoyY0sj1IyeofaYfS
	1rvrknHo=
X-Gm-Gg: ATEYQzwM3XgB1UyyR+KWmviBH4Oy0YYrvQ+0qGtsEqliOs0+mlQaul6qfUbY5XTDiFo
	FAHCYwG5Kro8HCs0Nz9I5TYbdtIl5DG41X8Eyh6Amr0C+sl2zdU6Bu6wjezVMEA1ZNhEV+XgYWC
	6j1r/fDSdUod1wSYEMLGD3+RbdO0zcvr5QPlaV7ac5KobPLM2VkZKm7JGbdEUTFapHaOhXu7kAk
	BZu1L+7QKIirmlE9+2FE2Idc1YDyIo9SAwbotIiDOn+636+roO/Y4ucILx3q5IfoF1y78HtTc1h
	bWYTI+fF15JrlszT30crX/2MwlvlYuPpSrlBXnhepPE5iqamqPaT8KtZElPgHu7NkKStbr0AJYL
	OgNf1HAJjIgEsQd+tHvu7g0zj3/GR3pb17ta+WXFi7L5O6SkyBiMi8xgLG8Jij5xEYidoMlHJhP
	d6YV3GYHMefD0BnEnxeIyg/Os2oC02TyWpdqdVwWmix7EkHHwc6lJPwLp9WfQBCw==
X-Received: by 2002:a17:907:e8a:b0:b97:eae9:d45e with SMTP id a640c23a62f3a-b9c13cc4dd3mr1812466b.50.1774970722671;
        Tue, 31 Mar 2026 08:25:22 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba558226sm1264003a91.2.2026.03.31.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 08:25:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: add test for raw-address single kprobe attach
Date: Wed,  1 Apr 2026 00:24:36 +0900
Message-ID: <20260331152509.70468-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260331152509.70468-1-hoyeon.lee@suse.com>
References: <20260331152509.70468-1-hoyeon.lee@suse.com>
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

