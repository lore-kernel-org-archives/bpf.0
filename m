Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AA136EA89
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788290; cv=none; b=pzFkqc0kmurbwgnKf5BDTTaWCCsyaLeE6TMzUHGMqm+XWpbQWZ7+DDfnAUWFUGfUq3RfllvSmemLH0wF0WCpJVZayl0OEpj8THvOTxG2wneIzD4kz6A+pRbR5jA9dNiyDM4s4ArF0JEeGCFKvIPcMeGiSDeC1GbPW3JrwiKEfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788290; c=relaxed/simple;
	bh=yCgWS18J2giAmIBQJwNeZ4CV5RD/8KYMOj8QP1lNVww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfCILU6iAJa1PWNr1K9Cy5drBzC4MoCTleR65TX1nxFRZhjhNPzRZrSYm8y2awOzzIul7yC8lPTeQSQ+I/WtYXMVi/TTlTSMrA9jJ6I3fj4U/L1Hf351YwpCvcW9ebvgJGeCApZVx8+QSeV5ioRwunh4qCMNXxsGTQUBIXAFrOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZOROEA5u; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZOROEA5u"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48538c5956bso35085135e9.0
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 05:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774788285; x=1775393085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIyVVbIGIEKVOI7GAfRAoypwiecz72p9gSCxjoyNoLk=;
        b=ZOROEA5uTJXY4guSfQRL21SB2P+O2QpdlIneL13j8mCLzs1CZnMf+Ok3fSl8+fABrH
         oE+WF9zy98g2gJAX2AT1FWPyr5q3CFq29sk94YVGI1mDd/EpEdEdLRcyGwcK8SF1hHza
         vJVfFuvMetGrp2a6nZuhOBqP9zmtC1Lq/r0p781t3Ah9elKehGJi6DCGCeF8uoo1/Aal
         pn2NIHaVmH/BcJ+WlVDl0yfXcKCCdpTyq+7AW0d+tE6iVHAt3VNGXpNdqvpf3AeUcN0P
         rmkqyrh+Lpx+WoETNKKsRaR5wPpN+aXOZVbqRlLaLYfW+9CtLqMVJFIjrtuqs5LWRCVC
         hSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788285; x=1775393085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIyVVbIGIEKVOI7GAfRAoypwiecz72p9gSCxjoyNoLk=;
        b=cJ3/lDcjNexDhFb9MTa3Y8j1mQj4gz0OfukEmkhnpCMjB9gNFqbMhMGIJQzd7gkrYB
         ToO3V9tbYvSlK176BgdhGuEB8Wid3WQxzLs2wDoXU5reClPokG+qT0IyAIuYPQFA9TUI
         KM+gGX76NxGfUzrMGmvb8bhGTpdmD0CMoqwXLUElJ/tJA6M2rr7g8Au1S3ZH1haN5DTZ
         XE+AsFgPisdblfaVaa0aDc7uchEMZocx0rz7YBZpKFsGl3f8/Wl+Mjlix3Exj8OfQJO4
         D9cii/P+FFPveImiB1ut/EV/Ai+UNAe2i0A+WMBYatLpMbLDZPmp9Jzg7y/D6wa52pyi
         rSIg==
X-Gm-Message-State: AOJu0Yz0C/TVc6nFjGrpooiZTcLk7qBCUEJxZzjBABGBOW/1BtE8n+nR
	fOnajsovaoGp6Usb+0Q2jxNjlP0dhlP9EH12eHUqYrF9K+76gf0uMOAHCWipZHGJW43dteMmxn1
	lPq4huYM=
X-Gm-Gg: ATEYQzzajxm3FAMMix5elzu4+GOCzUK0frxMO2xebw7Cuo1lgB28qGqgFp8VX4gMR86
	vyE719L8HKUBLqn7UjzpaQ+PSBrUJnngGKwR7cH3i1OmqT+inMePizRY3AnLMH/sERdLCdWnol6
	u3oGnKHff6Vo0FpMnTBvJNPQDQXzMwssrsr9dSPPOXdWTWYjEH+QzlMm14MCJE8XTne8DIWMjcy
	dHW4Hbei9iVO12lgP2qXzcAZOqevkN8qrWwXe6jP+EvaD520Wd7V4x23R2HnY6tJYfwKov2xWrM
	1MpOZymYAq76hBmeBdWy3OLryrCiAFGkSp6iPTm+tu5vm3i4zuUTtmLvrvBogzo9z9n4ejq+MoD
	kIVjnEKjMG/qlj11a+Jqjh41Vn2yn1MwHpEuP+/u6eGTIoKLTcIyCr7vl4kUwJsiouJJMCGiUpB
	WcldbcniB2Ld1/95lRXp76dTyiI9YLxCu0zgGRW+BUsFEXSSDonzpSZXN38yQQAw==
X-Received: by 2002:a05:600c:2d82:b0:487:467:49e9 with SMTP id 5b1f17b1804b1-48722b92fcfmr118383365e9.7.1774788284911;
        Sun, 29 Mar 2026 05:44:44 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm3700321a12.14.2026.03.29.05.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:44:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: add test for address-based single kprobe attach
Date: Sun, 29 Mar 2026 21:43:39 +0900
Message-ID: <20260329124429.689912-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329124429.689912-1-hoyeon.lee@suse.com>
References: <20260329124429.689912-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, attach_probe covers manual single-kprobe attaches by
func_name, but not by raw address. This commit adds address-based
single-kprobe attach subtests for the two underlying attach paths,
legacy tracefs/debugfs and PMU-based non-legacy. The new subtests
resolve SYS_NANOSLEEP_KPROBE_NAME through kallsyms, pass the result
through bpf_kprobe_opts.addr, and verify that kprobe and kretprobe are
still triggered.

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

