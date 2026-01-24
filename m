Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDC2D879C
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235732; cv=none; b=cxsTGffxb6tz1xmSPi28azNnGjWvDk8u1is9VJdL7gY0I6uVx6UOLBn6ZrGoeZELdjmj2VaqWwYyy1kWI2Vqe626FvLx77CAq+GnCXvXXv58keMepZfARSG3RScdf0GH+QP1UZYA3VeOi6gQkKM//AGaQFjViDprqmNoz1tr/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235732; c=relaxed/simple;
	bh=MY0TzEwIF2cncGc4J2MGjes5OtwOQCXp+QMlMZ001rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fz3oe/GrCcXB/ITlPGeg96lXdmYNgTM98RVCzkiIei/YTu/f40Y6L7V7t3o23YvzUKyGatUP+MTJy3EK5IbrYrglMC3Qk2yY9BP6lOHM7hjDoPf8jQzI6L8zhR0co8zeiNU9J7lrSYUf1kBqOEGyoOcCLnAOfvFASGu9od1IbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTFVcNiq; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTFVcNiq"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0c09bb78cso20563635ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235730; x=1769840530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=TTFVcNiqPiJrrrHYoxUCBVHB70RvgoGvGb8IKFBwd8poQo/qBDB/k4lU1CIu8ujhV9
         0L3BSht2kzXWJIHdddQ6QtxSnlsnlVoJxpP/HcNINHWT9BynqdMtrZ4JpSCkKuAhIMri
         DLCmpLx16q9VTiwJDnRWibzUg6kwr5RAJHEw+kguqRcIze8BPAuUYVBeXviUdpWGAoUE
         J1UbVaazzy2ufBV3KgG3rA9Xc6Ajq/rDkCqyaJsAybsMX3ne/GA0IcQRJdSZq79HgwGX
         7o+6uaiGDx3UuBrhGU5849XBj7EaTQCDSwm8di0T02pHF70V6PVwZsURVUMRKDiAMy3n
         34Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235730; x=1769840530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePFOCu4by0RV/ygPSJGiVD2r6LAEFSKblHnuNBvqT3M=;
        b=bgHJFt7yQqJn4EzOyk97RQVxXhR/E9PnwvUlMq5Whuq4C02/l2Do77b29u2vpd0B1o
         uAy+F/r6DjgJ75tyxZzxLBz+lse6BalfSM9DYpFdgHTpyT6cj5EyRi9cCEXbfw6IpnJt
         3rJdmqiUyRHvIhMmPUi8eBhIz2mJwS7Dq+26RzA7s/0mao7hfsryLUjWqxmm+ziENmBx
         Qe6B8WcgfLufKbzN9DltQncVWuDICy/XQWnSg56v6I8p9ntWvenboRwNOrJHvOtaR5ch
         46G6XQBOrQ5P6WS0KWb/D9K5hhazV15zbhAsa54z0idJEJn0nkPGgPn1L/3g1+3Lw0oP
         hW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5BjIXGnM/aAmDifv//EhqB1K5hDbbiJUH9MI1oPsNzLcfRoSDBKi8goO5GntUWXa46Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzjnwpH1zEyjBd4RF7LJjIeQOhDldrSRAs90Q4QbCSAAJIsi7
	lJy4gdcmvAhqRLPAcppw2Y8u/gxlVhIPlB4DRm9LHlNrQTaX525qrVjO
X-Gm-Gg: AZuq6aLQabbW6HYcSfyCzP19/UAkg6Uh0mRDuKyYKIqkILGIobNdjJG5U6OCVqCdoqW
	q8t4tpTAiE8NQuJekGLqz+N/q+9sYpKyJO49LE63NVfI72enk1ExAdA+bl7X7rrC5YINb1pVtAR
	O2a543zvJT0DV4j7EUmLKft8qSlJIPi78wL0HTNZXYWrz7JQZJbyOxPaInR01xTCiwvafXd0GaA
	AT3HUCpvTZcrnqtPmJV6QzvcwH1oMBQtAcZTSC1PD8BEdBdcejEI/e7jugksyxfrcGYC3yzGQNo
	a7G4Ytav7HRsFIVrxeLhjHbwtfRq9AksZXepEfaYccJ6sSKmmEtNtL/M+QxtiA9cqKxIcP3tr3A
	PgFtl6EC5Zz+N3N3j7cY8+gT7ro6jnIwdZ1o+OvLqhxVAsXDZivq2QenuweUO1wMXqeNcy5fDNg
	mQzsTlSbxM
X-Received: by 2002:a17:902:e744:b0:2a7:cb46:7069 with SMTP id d9443c01a7336-2a7d2fbaf36mr69604715ad.25.1769235730121;
        Fri, 23 Jan 2026 22:22:10 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:09 -0800 (PST)
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
Subject: [PATCH bpf-next v13 12/13] selftests/bpf: add testcases for fsession cookie
Date: Sat, 24 Jan 2026 14:20:07 +0800
Message-ID: <20260124062008.8657-13-dongml2@chinatelecom.cn>
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

Test session cookie for fsession. Multiple fsession BPF progs is attached
to bpf_fentry_test1() and session cookie is read and write in the
testcase.

bpf_get_func_ip() will influence the layout of the session cookies, so we
test the cookie in two case: with and without bpf_get_func_ip().

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v12:
- add the case to test session cookie without bpf_get_func_ip()

v11:
- add "volatile" to the variable "cookie"

v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/prog_tests/fsession_test.c  | 34 ++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 66 +++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fsession_test.c b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
index 75bb42942b67..0c4b428e1cee 100644
--- a/tools/testing/selftests/bpf/prog_tests/fsession_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/fsession_test.c
@@ -77,6 +77,38 @@ static void test_fsession_reattach(void)
 	fsession_test__destroy(skel);
 }
 
+static void test_fsession_cookie(void)
+{
+	struct fsession_test *skel = NULL;
+	int err;
+
+	skel = fsession_test__open();
+	if (!ASSERT_OK_PTR(skel, "fsession_test__open"))
+		goto cleanup;
+
+	/*
+	 * The test_fsession_basic() will test the session cookie with
+	 * bpf_get_func_ip() case, so we need only check
+	 * the cookie without bpf_get_func_ip() case here
+	 */
+	bpf_program__set_autoload(skel->progs.test6, false);
+
+	err = fsession_test__load(skel);
+	if (!ASSERT_OK(err, "fsession_test__load"))
+		goto cleanup;
+
+	err = fsession_test__attach(skel);
+	if (!ASSERT_OK(err, "fsession_attach"))
+		goto cleanup;
+
+	skel->bss->test6_entry_result = 1;
+	skel->bss->test6_exit_result = 1;
+
+	check_result(skel);
+cleanup:
+	fsession_test__destroy(skel);
+}
+
 void test_fsession_test(void)
 {
 #if !defined(__x86_64__)
@@ -87,4 +119,6 @@ void test_fsession_test(void)
 		test_fsession_basic();
 	if (test__start_subtest("fsession_reattach"))
 		test_fsession_reattach();
+	if (test__start_subtest("fsession_cookie"))
+		test_fsession_cookie();
 }
diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 0e1b66b2dddc..211332bdcccb 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -95,3 +95,69 @@ int BPF_PROG(test5, struct bpf_fentry_test_t *arg, int ret)
 	return 0;
 }
 
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
+
+__u64 test7_entry_ok = 0;
+__u64 test7_exit_ok = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7, int a)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0xAAAABBBBCCCCDDDDull;
+		test7_entry_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+		return 0;
+	}
+
+	test7_exit_ok = *cookie == 0xAAAABBBBCCCCDDDDull;
+	return 0;
+}
+
+__u64 test8_entry_ok = 0;
+__u64 test8_exit_ok = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test8, int a)
+{
+	volatile __u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		*cookie = 0x1111222233334444ull;
+		test8_entry_ok = *cookie == 0x1111222233334444ull;
+		return 0;
+	}
+
+	test8_exit_ok = *cookie == 0x1111222233334444ull;
+	return 0;
+}
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a, int ret)
+{
+	__u64 *cookie = bpf_session_cookie(ctx);
+
+	if (!bpf_session_is_return(ctx)) {
+		test9_entry_result = a == 1 && ret == 0;
+		*cookie = 0x123456ULL;
+		return 0;
+	}
+
+	test9_exit_result = a == 1 && ret == 2 && *cookie == 0x123456ULL;
+	return 0;
+}
-- 
2.52.0

