Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC253128BE
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153839; cv=none; b=YcRM3MWL9dPfCcsjZIpSvVro8VXm9E2nEZRtXEU/ZNlqL1BiyjPHWPodKJePHFjjLnd7Nil+eP6F3YsIEPVEAcwvhtaXxI+oli0iwac5ArOMU1141E1/wkjPDgcmrRBJeUjsTerY5vWE4TkgJMA8PRBvXD3uK8bQhUAdeZr37CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153839; c=relaxed/simple;
	bh=EI3S9m8lXbyfiPr0rXLXLlNg6jz6WDFgZ7OGN3ndRII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XlU0RGX10GGODqFf3Qs7t5TvIltHIOtkXWUQtS9D9FyYeeKv25HWfi/TRueQ6wSJaD7SSKDljprYF18xxLIFX9fdO8g/1YBshT3MnDY1+NOJBA7TNFNN1h5I33ydE7lu4TUNxWLodcRcyDfmbaCewuLVy5MdcS3QcZGm540MdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf6ZOjya; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf6ZOjya"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-823081bb15fso922712b3a.3
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 23:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153837; x=1769758637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFdyTmkIAkHsLaNZCmQPSpqba17vOR1m1y1zTk9qCAE=;
        b=Yf6ZOjya3MLh1Xnf8W/4FwtFVOx0M9nloYnBpbgUV9a/nn/8AIdt8kazT39oICvmqe
         t1ZvEjHycHixxkAgt5nG+5zGCyBfZhvOt2yNrIJwgwusk66fCVlr6y/PVfhWBOto5Lsf
         4cooazDHMB4eiR3z2T5MoDVvDrLpyp3m3W1q7we84QrMDEoamAfO2tDmF7zOEamdfPHA
         K79m6LGh8XpGXMtKmAaWWmUunYjCaOJCxENZOmLrf+0OHV+WE1zJXy6FcaB8U1hkpsVG
         ZnGkHAqPrNYfwGpjuf8JN9y6GI+wTA+hBAZjHVsOVgKW+6tGAG9KEEkVB2UJ+7Wrpw6T
         DCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153837; x=1769758637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aFdyTmkIAkHsLaNZCmQPSpqba17vOR1m1y1zTk9qCAE=;
        b=nD9yoxbnw3rsaUsjK95xHlF+F7ypkDTsnTOg7dWJMWuXDURDMf/Z92xH0kB7ah0UmV
         uRaDQK439qpyjWGATBJ70rj5UL7qxHdUGGyFWM+i0or8x4oOaK8mB9AHkVZ+a7Ok+FHE
         QhA6dvCXQrGkrHITAFoeMh5FCqW2UzJOz23VQfq2l9FmzKN+7Lo3Br2bEZueotxkYkru
         NGf8K5JkPxVGqOPX+302/rs9Pn6wpMKO+IrR32q3ZkdrOV36BUIz5iVRc16ZeG94mjM1
         1kSE3z7y8GMmGKzgNokcjeroF00lhHLbG40Z8zXHZi1lh/onp1r51xz3VBUHVpGp78C8
         p+Tw==
X-Forwarded-Encrypted: i=1; AJvYcCWW5nRzNcZNSJ8XS+jS+G5EHMSfx9Jm81VYs9/nzqEfEooJ+kljf1TnZgXw/9r/XxAkfQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+Zep1HZqfhDHt4FxNIhl4ZKwamYEF9vp9EYIaSz5x6EREQwC
	4c07gNyzV5R64rkz5DPBxMK8+/v3K2+gcA9ktyNwNGCC0AAM9Kb4u4iq
X-Gm-Gg: AZuq6aIwXhwKSnpxJ7m5Q3sGQUTltoPxjzRaXc5hfJyYzNUbnHVCjKoPMt3b+f/iodK
	f7F/NCrs3XflcgtP/NdJVeOD8i9JyTfrG+AIxf9tzsxaBGay16X9TETINCeyxyjs/cFItW8d6rT
	FRhry3rEZ2ubQ5UmjLFlybJftFF2FEE02Idq5Ak9NBnmT87zifl+wc0ib8T5vpdfBBkZGfQtAyH
	cPFss3sUp+klg9rTn/I4KG2vwzGkGYYUzS/ZJkXs0+pYDVQZ5D4cG4ZnoMmAQlHu9k1UHbBoAy9
	wxO/DTcErxKqn3PgmzsETJ0NYKsr3cf4cTGbRwmXv0c4ugth/ocO1AN85lHUew/JxahoAfgjckA
	krSsmdAw6BOYqFCpBhj4GzNAxjnvh6K1IhgrF4TNytMpFmZEGpg295qUTLUgNEJ9k/qFETrtB0T
	+ZBwu1NQ/Q
X-Received: by 2002:a05:6a00:1c88:b0:81f:82b2:ecf8 with SMTP id d2e1a72fcca58-82317ed8d49mr1870818b3a.63.1769153837561;
        Thu, 22 Jan 2026 23:37:17 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:37:17 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v11 11/12] selftests/bpf: add testcases for fsession cookie
Date: Fri, 23 Jan 2026 15:35:31 +0800
Message-ID: <20260123073532.238985-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
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

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v11:
- add "volatile" to the variable "cookie"

v3:
- restructure the testcase by combine the testcases for session cookie and
  get_func_ip into one patch
---
 .../selftests/bpf/progs/fsession_test.c       | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index f504984d42f2..211332bdcccb 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -108,3 +108,56 @@ int BPF_PROG(test6, int a)
 		test6_entry_result = (const void *) addr == &bpf_fentry_test1;
 	return 0;
 }
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

