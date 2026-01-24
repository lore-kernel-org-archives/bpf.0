Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE4B283FE3
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 06:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235722; cv=none; b=K1VS+l58sWM58C2okyMZ4xEFszgwRcDhclInKXBi70Ig2tHhdK5CI5vjszTFyQsXUo/R3ytaymYpfWjYKcvX7PHClIP9JYgePyyVbA9Aqs4nUxUTfLqVEk7/Dvq+U86Pw4oZEcTJa4wOoi9ZX6ANA1j3UKY2aWuyACD22L+w9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235722; c=relaxed/simple;
	bh=h4fZJ5/eB6h3kRSc5/YL4hLV3+bf/vzJfsSepeg4Yyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLnDn1VMuyguCm1OnDvQo2GUO1cxczr/KZJJegC/NcGNtHmzUsJ1cSYsLTzM73yG1Vtd7bOcXWt5l1ht5/2tmiCnOzXSGp/yA6XcFCqx6ybB9C5CSzfPFbXirocwf4K4atsaUXJ/xyJBZvViPPGjIFzM7ZaAG8Ll08XSFdACFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBIKZSp0; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBIKZSp0"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so2449352a91.2
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 22:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235721; x=1769840521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm+ye49UjjJWSoY/pCeQ81QIgmdFuPgzbXJ82TRTTWs=;
        b=SBIKZSp0RT3bp6o20NjcU6iGvBRI9FgXOQ8LGfu99xfiVacpZlz/cKmv/5INO/uFqX
         py8EIusIUqpKGMFEV/QLmoFe0O5CSCkYO+4izMpBEpQw72rYqdJgfcKRjju9yTEk8q4n
         GYEAuZFO30NYk09QlDXKgzQCkv05nIs2ZGokBc/41jLOMqxG+1NdKSdcVkcHcl0lzD/R
         bG7XnOxLIQ1EKUIEKloULFa3rv409dWg53BtvZ6rFyDUrVEq1k0bC9Ke0heuSwDBq6YA
         GM1MVUgagbtA8HuwlyCpZfuJH1O52QJl7MHs5bh5LvZnTTOy0StC1TqMteK2PONxo1W7
         FkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235721; x=1769840521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wm+ye49UjjJWSoY/pCeQ81QIgmdFuPgzbXJ82TRTTWs=;
        b=hJLKfbXuDt0qtAAkt91Aq5cnzrHPGcWcuayQMTP2xunDxi9I/pRT3eA3D0sdq2koxz
         36M90EEngtkJP4F3Ev/huZXRLYRbG2nIW84j0cEGjry5W/gwPd9wMf56Do3grxXu1zkG
         w9qWomGjitgz6MdTsTfe//+tl554BQxeQwzXd7qacW9de9NyZCbSU4J0VmWqqFyksGEQ
         fGhrfwDAP7L64dVlm4O/DQJZWiRQ8KqwCYuj3tZcisi2GU3907MKNh1iLd3XnrCVSply
         jP+Lcf9+QhqJzMfHTpSjLDohv5N2IaOc0J/c+ef93fEFvfJfTuz+1W+BlBiHT4KCbIl4
         wcaw==
X-Forwarded-Encrypted: i=1; AJvYcCULtTrzGQGhEWeqlVrluT5hY6DltYQbYrdwo1yIbwN6SBFEw1NpXzrdDrhiVuQf/PPAt54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEm+MY921LztcGMEoRELrfR7yQbgUrRc07TlWjgwMpsrck/HY8
	v8HEV2C89yxXEuRNrGHTW0oHREsJGrvQJG1cvmsceGVGdSunCTVSEbDd
X-Gm-Gg: AZuq6aLe4xcSnsxeTxTtKxMgIGzN/+Cs57yCnoksp4Zm6sFfTHcx5esGVaGALmIJd+M
	3keUzY/YqwhyS/eIBNrpF4ScacI0DMFofwbhppIwML45g+xODgalLVs5uCwnkTv1xAp9M8OiM48
	03mc9bfqjkFeoAsbOzpCOA4vgv4QJ39/t7PzLCObO9VJmKq7czKNCnAV5RPajsKiIZqNJJ35NS0
	Tmn8Az0NiDvDi5+EbTX8sNP9Y1zwGLWYDGWKH+VuzpIZkcHwP2hHM4BTtFbu0lrPhwoqU2j2Gp4
	DH3MPcLGPP75eJ9O1zcejS1ueyTIZOUgwwxrWFgjBTOSFtFDJq3l6AxNK8m2dqCQnq4g3Csc90D
	GVfKICpXBRUBbDw7MDcnMYNV9Ure9angb4cXqGklNBUdO/sWuzkCuNNHeMmrRYAwGbgXQ0P1dZt
	W1g3GbC/D5
X-Received: by 2002:a17:90b:4c4b:b0:34e:5aa2:cf61 with SMTP id 98e67ed59e1d1-35368c436e7mr4203172a91.28.1769235720770;
        Fri, 23 Jan 2026 22:22:00 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:22:00 -0800 (PST)
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
Subject: [PATCH bpf-next v13 11/13] selftests/bpf: test bpf_get_func_* for fsession
Date: Sat, 24 Jan 2026 14:20:06 +0800
Message-ID: <20260124062008.8657-12-dongml2@chinatelecom.cn>
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

Test following bpf helper for fsession:
  bpf_get_func_arg()
  bpf_get_func_arg_cnt()
  bpf_get_func_ret()
  bpf_get_func_ip()

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v13:
- fix the selftests fail on !x86_64
---
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../bpf/prog_tests/get_func_ip_test.c         |  2 +
 .../selftests/bpf/progs/get_func_args_test.c  | 40 ++++++++++++++++++-
 .../selftests/bpf/progs/get_func_ip_test.c    | 23 +++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
index fadee95d3ae8..96b27de05524 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_args_test.c
@@ -41,6 +41,7 @@ void test_get_func_args_test(void)
 	ASSERT_EQ(skel->bss->test4_result, 1, "test4_result");
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test6_result, 1, "test6_result");
+	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 
 cleanup:
 	get_func_args_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..7772a0f288d3 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_entry_result, 1, "test9_entry_result");
+	ASSERT_EQ(skel->bss->test9_exit_result, 1, "test9_exit_result");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_args_test.c b/tools/testing/selftests/bpf/progs/get_func_args_test.c
index 5b7233afef05..0a3236a7a109 100644
--- a/tools/testing/selftests/bpf/progs/get_func_args_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_args_test.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/bpf.h>
+#include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
@@ -165,3 +165,41 @@ int BPF_PROG(tp_test2)
 
 	return 0;
 }
+
+__u64 test7_result = 0;
+#ifdef __TARGET_ARCH_x86
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test7)
+{
+	__u64 cnt = bpf_get_func_arg_cnt(ctx);
+	__u64 a = 0, z = 0, ret = 0;
+	__s64 err;
+
+	test7_result = cnt == 1;
+
+	/* valid arguments */
+	err = bpf_get_func_arg(ctx, 0, &a);
+	test7_result &= err == 0 && ((int) a == 1);
+
+	/* not valid argument */
+	err = bpf_get_func_arg(ctx, 1, &z);
+	test7_result &= err == -EINVAL;
+
+	if (bpf_session_is_return(ctx)) {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 2;
+	} else {
+		err = bpf_get_func_ret(ctx, &ret);
+		test7_result &= err == 0 && ret == 0;
+	}
+
+	return 0;
+}
+#else
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test7)
+{
+	test7_result = 1;
+	return 0;
+}
+#endif
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..65f7e1f182bf 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,26 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_entry_result = 0;
+__u64 test9_exit_result = 0;
+#ifdef __TARGET_ARCH_x86
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_session_is_return(ctx))
+		test9_exit_result = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_entry_result = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
+#else
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	test9_entry_result = test9_exit_result = 1;
+	return 0;
+}
+#endif
-- 
2.52.0

