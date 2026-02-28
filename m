Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4881C3BFC
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772264786; cv=none; b=ak1iLK+TYskcfbI4J1ailgDsDiFxEt+CK9Oasx7w1rQW25DjDPb6G1lG6BTxbdRt4MldbDLi7rfovUTotkQjji5qzRadnoYGjWvzS+PVj7OjRIHS8JaoOhRWhDzDatdP8I7j4qzqKJkndcTyBCQ2pXyCIcB2+aDxJZ0UNjvj8xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772264786; c=relaxed/simple;
	bh=heJM+PRvqvvK4uhbidwwxuK028a5HlfOSxuMoE/I4JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FO3+wDHCXq0tUGrHjMFpEcIeBqqVC8/yQPzqMosVieIVOGxeMT30LPFf4VMIq/e/64bJ+SVSsOdoPu45qOcqBlus1iDgnwqOeDijvVDIDDYreJEFFMbg2/WNGHQvJD+Im+kERKTM94Ry4N9uhPf0XmLUJ6u4T1AU8UBInv/zzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7rQ3K9I; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7rQ3K9I"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bddf5091c0so3214732eec.1
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 23:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772264784; x=1772869584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T94amDN1jD/1WCsiOX6E39ApqIsgBUSoK8r+edFETp0=;
        b=E7rQ3K9IOkDDdYtuqL0Au51CjpbXIo+rnOzEsVZ0htzyvZy6RQLTK63E4/UABgFAEf
         XWJaubqPqb7T3icOd/qmLe32z79dDzAxzlkrtsrKtYzQFeZyt9YaehKbzA37LV6M4lUD
         rj0wFlviCroVCgYsA6jbAEyq8em++ynbChQa5sn9Rzpgg1LP1OmN368qhie36f9q5Psd
         52D4Yw3ABnqJZs8S7aSDLX+RxbmB42S++Z+anLnrivLK+Iy4Bp34S4ROrf+O0GiyFU8c
         gFRP8xYOtWB1jc6dSzIGP7cXNvQqCBPieyAyUwGp0OPxUXun5+pD5nqTuVKN71oXFK++
         65YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772264784; x=1772869584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T94amDN1jD/1WCsiOX6E39ApqIsgBUSoK8r+edFETp0=;
        b=LpHh9BtYwLLb/wB1sgAs+0kBB9SDcqSQCWmlJ+SfWmxF6YwFmCyEHA9jAi9zwsmwxk
         SD4xGKJ6LWq0ZMNLZbFl5DBI+jdafLOsSljBEuRrfZkYWMBPVequ67Ffl6Yo3Y+igKzK
         4ux09SgU4fql+plJeONn735TykKxc/qDqvb239UjMwjtHsBzUGRyHU7PPMKfxbQoVo9i
         7EbbeIny7czW6Nb+unlbUDuOVekxA8VN2nfURkLVqeKv3Hwt7IXZ3er+D2fDye/G7ZfP
         0Pj+MZ0LhJwH+my5tAiN6ME9YPnX66aiyKivkwtIwTWep1HBWqfo3mqCRId7mzf1OMmW
         lLng==
X-Forwarded-Encrypted: i=1; AJvYcCVbE1MrxGMl/BxcfB6iQ6llskhEZNuEG5QRkDnD01WFIpOk5XlkcsvrYKMh0d/CIJtYEF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXAkITnTeBjMs/TAJULJC864YceB0UwG0q7/d1v8Ofgf6I/TAr
	mFeGhI7pgsSCx61vPANbyr9FrfA38l50gbOlpFTm7wWi/AAgqFYx4v+S
X-Gm-Gg: ATEYQzwQ1UvOWokA5F2krnMMD6wFGZt0W5sFbpAFvZvu3IfMHqSgsLdAa+CQEQTfL+u
	0eAU7Y36u8iXRpv1z9Tq2LxYgm+ze3AfpOSVrHSqxPD0QdJ0tkjF1jZU6Hum/msqcaYdBUVjV9N
	Aw5hVY0J/G5yy+ht5Yn1zCZunqEDASk4O0Lsr4sB58Fg/p50LGvxBMZcMpIXExv+sOCJmWMZ9WN
	c9fVfeR1kF6X9aYpLBW+/wctpNg5REw+vNM+EVFVIMWjCvSVI+EeQnaFxhW1o3bj9h4/5J78sTU
	kLSV+S3l/9aWfW+p7IC4RZ4pCobsx20urfX60943weWEJFRW/JSYTp1jvAss1WNC261NrdwmXHK
	2JlKTWNGvdJ77wYNBGRSOfTwxQIoBDEJ8qpDriIh4bZ9ZQgzYnJrBj85Fu1UCr3ESW4RpgjWmOo
	AEuecsSRlofr9/3Jf5WLyaEh8bt2Pu4TbttfGjNy4oCF2Nug3r+jn9qlVySxD50drwvelnEswED
	6iGe6XfrdDKrh+L8giWPd1x6oM=
X-Received: by 2002:a05:693c:2c97:b0:2bd:d3f3:b0be with SMTP id 5a478bee46e88-2bde1d49fa5mr2551896eec.20.1772264783909;
        Fri, 27 Feb 2026 23:46:23 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bded67bd05sm1874926eec.1.2026.02.27.23.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 23:46:23 -0800 (PST)
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
Subject: [PATCH v2 2/2] selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably
Date: Sat, 28 Feb 2026 15:45:55 +0800
Message-ID: <20260228074555.122950-3-sun.jian.kdev@gmail.com>
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

The perf_event subtest relies on SW_CPU_CLOCK sampling to trigger the BPF
program, but the current CPU burn loop can be too short on slower systems
and may fail to generate any overflow sample. This leaves pe_res unchanged
and makes the test flaky.

Make burn_cpu() take a loop count and use a longer burn only for the
perf_event subtest. Also scope perf_event_open() to the current task to
avoid wasting samples on unrelated activity.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>

---
Changes in v2:

Move the perf_event_open() argument change here from patch 1/2.

v1: <https://lore.kernel.org/lkml/20260227164037.84110-1-sun.jian.kdev@gmail.com/>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c     | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index b7643a5bf7ad..35adc3f6d443 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -6,6 +6,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <unistd.h>
+#include <linux/compiler.h>
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <bpf/btf.h>
@@ -431,11 +432,12 @@ static void tp_subtest(struct test_bpf_cookie *skel)
 	bpf_link__destroy(link3);
 }
 
-static void burn_cpu(void)
+static void burn_cpu(long loops)
 {
-	volatile int j = 0;
+	long j = 0;
 	cpu_set_t cpu_set;
-	int i, err;
+	long i;
+	int err;
 
 	/* generate some branches on cpu 0 */
 	CPU_ZERO(&cpu_set);
@@ -443,9 +445,10 @@ static void burn_cpu(void)
 	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
 	ASSERT_OK(err, "set_thread_affinity");
 
-	/* spin the loop for a while (random high number) */
-	for (i = 0; i < 1000000; ++i)
+	for (i = 0; i < loops; ++i) {
 		++j;
+		barrier();
+	}
 }
 
 static void pe_subtest(struct test_bpf_cookie *skel)
@@ -461,7 +464,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	attr.type = PERF_TYPE_SOFTWARE;
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
 	attr.sample_period = 100000;
-	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
 
@@ -470,7 +473,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	if (!ASSERT_OK_PTR(link, "link1"))
 		goto cleanup;
 
-	burn_cpu(); /* trigger BPF prog */
+	burn_cpu(100000000L); /* trigger BPF prog */
 
 	ASSERT_EQ(skel->bss->pe_res, 0x100000, "pe_res1");
 
@@ -489,7 +492,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	if (!ASSERT_OK_PTR(link, "link2"))
 		goto cleanup;
 
-	burn_cpu(); /* trigger BPF prog */
+	burn_cpu(100000000L); /* trigger BPF prog */
 
 	ASSERT_EQ(skel->bss->pe_res, 0x200000, "pe_res2");
 
-- 
2.43.0

