Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC058313535
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264780; cv=none; b=XxWFgmDixtCh+t/en9Stl+ZGLRK55svn8i5GLkvwOBR2Vvl4CVk3mya0F+o/2hYkJ4wrzLUgvFmmduVgSrTEJ0WqCA9YYG/OqZPkTVqFwUt5lTUeC2c03ObOnsAZzihipKXRCsWqaNZRalcrUgHAh6JXXRUMgQnqPDH1+JjkvUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264780; c=relaxed/simple;
	bh=/5BZEDEPjXJZEbemnrSGEP/CsHhL3NpXMyBNCx84GNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=so2IHvRDV/T9scptfL+eGomPgV9I6AInPTM0qd9FEeceYJLdcsdtsiGk1lUzGvxArzhB+4iTiImllCdhH0zxMV0aiD5EkqBpO0aTYO891SZzVZB1a+4SuYuAhmfvomUDlkkOhrZ8FOppTmwAF2ZkyCBU0GnqRJqbB76829Ow7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYC7pFaA; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYC7pFaA"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b4520f6b32so3447351eec.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772264778; x=1772869578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvm98zlzsM3HSjB/EuHx7YQoewB1rqACesQFCVmyaYs=;
        b=WYC7pFaAaUCbJSkbSBK4/PDZSwxJHlq0ZnZZuviEniVtJ6xrR3n82shzGkOPhgZUYc
         l8cKiDYSuMltpFSvUZigmmBmqFIttq7E1oiEs+FTwgRG9bMp/yE4AYIY3Nmz5QgBI0+k
         B17X+TqoJiRrkAo0PDDLt4tOzCsKrOpxFH/VnadC/0tvaiLLxE7mKtkRk4aaYFYIMcdJ
         zERH3r2F81/9vSCzGLOumzCr023hMmNj0beaTYjFQWzDlwQgd6HPptpuW1R6wBzqNOkB
         aBk5iQ/QWsUNYQLORI2zNo0Txzg47rlSDBkLTVTdxpNa8A5UM0GAv9TtkWALttZbnkRV
         55dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772264778; x=1772869578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rvm98zlzsM3HSjB/EuHx7YQoewB1rqACesQFCVmyaYs=;
        b=ZIuUivPKwA/Rsl7fkd8YXxtYNicqzC4z9OHLeYB5XF8ZBc01hw/bF5B/zjze8TVtja
         hv4HZWMmmh6docAAqNIlypw4DpuUAmeP+Wusirh6BSLuINhm59DzRaWi3q6flzOxcWKy
         P4ZeBd6dv7JfDmIr3X15yR5e89hAvHtd56ZvSIkRP65ZH1oXTIUKWYX0aH7TrK3Yx7OO
         7ZEofL9KHquaoOCjJ3W/IYpSnlN94JLjk9XrqgqCD/XtkBwzWmr55575BCfLbCO24tJa
         1Vjvx8VEvM7kpGjGjYjahU3lKIKOFGdnz74H/i73+O9RaNXYWtxUoZp4LuUDs8qCmwV/
         F6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj4o5yHplRqdT3xtZJx7UnG0wBuPKhjtYb1F/SVkEbZOnR0aRMjAGSMVBEwUsoyK6/c9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YywivMuD3pY1NjeVlG/JdUjK3bOzMukKJSG0T9sr2aQsgiRELmB
	jXWv0uLZIUSpsc19qwN/7D3yoJVIjlg+Sxsr6lHc0OouesuJXLY5OdSK
X-Gm-Gg: ATEYQzwmUW6mU+scwqH9ODiGJPNxA7Kfp4zjJNvncbO+gxZO55eZrU/AtQM29DYpdUw
	l9FVb6kpSMQw9A22E3l0NIWDsX/PveuI1khA18RSQUcG7mHMHnVEyXQLg4DzcQkaUvEcTf2zE9k
	h3jeYhgzdcIO7ZSt4Lh1MRc2n2m0HA0STmWXfElwjfniqIkaGl5JE6v4cGbl8r4lQtbBGStEHwS
	CLysWOevMfO8/sgHQW3JQI8xHAb0B6MWUW4x6lRybkuUxYA/bnL4m/kbwYP6bNve7JuG/U3O1FL
	tPw4LqPQWjBQ1RDJv5DcU3vnZFOJw2UcSJhmSuv6l9Yj2YRqOP3Y1zvnxCNcQD+CIIgpisjvO6g
	VQinvSCnxbIhV9CY0pUsMmLciFNNt2ui2S1m1wJi1n8E4uMOMEUP8WQT3E9lslRi8CAcFftTaIA
	v7HMsAUAtPxeM6n4HkL4SfcAqfCdICXFC/A2NgYSjsZB7R1rCA946GWhIvmjfWM9hSUBJNXv3fV
	2APCGgchNgCygRnzLAck65qtso=
X-Received: by 2002:a05:7300:538e:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2bde1d31d40mr2418500eec.21.1772264777939;
        Fri, 27 Feb 2026 23:46:17 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bded67bd05sm1874926eec.1.2026.02.27.23.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:46:17 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2 1/2] selftests/bpf: bpf_cookie: skip kprobe_multi tests without bpf_testmod
Date: Sat, 28 Feb 2026 15:45:54 +0800
Message-ID: <20260228074555.122950-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
References: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kprobe_multi subtests rely on bpf_testmod fentry ksyms.

When bpf_testmod isn't available, libbpf fails to resolve
bpf_testmod_fentry_test* and skeleton load fails with -ESRCH, causing
false failures.

Skip these subtests when env.has_testmod is false.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

---
Changes in v2:

No functional change.

Drop the unrelated perf_event_open() argument change from this patch
(moved to patch 2/2).

v1: <https://lore.kernel.org/lkml/20260227164037.84110-1-sun.jian.kdev@gmail.com/>
---
 tools/testing/selftests/bpf/prog_tests/bpf_cookie.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 75f4dff7d042..b7643a5bf7ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -105,6 +105,11 @@ static void kprobe_multi_link_api_subtest(void)
 	unsigned long long addrs[8];
 	__u64 cookies[8];
 
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
 	if (!ASSERT_OK(load_kallsyms(), "load_kallsyms"))
 		goto cleanup;
 
@@ -192,6 +197,11 @@ static void kprobe_multi_attach_api_subtest(void)
 	};
 	__u64 cookies[8];
 
+	if (!env.has_testmod) {
+		test__skip();
+		return;
+	}
+
 	skel = kprobe_multi__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "fentry_raw_skel_load"))
 		goto cleanup;
-- 
2.43.0

