Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9353C34845C
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210457; cv=none; b=LvZc2IZsqCawGhEGRY+ChnZaGfTV/eg7QU1HNGj7DQmdk5QUI5pEZZHNqIecD39eRp3Cz87baOf9l+v+OwtbnpMhvlhsquze0MhSBK6o2U8RerradFKXQkXL//r8BJJcxk/3BqRV1QiUJ3TJelPO2GkYvvEiULQbKtn291EFrwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210457; c=relaxed/simple;
	bh=C9rvgcLgCnl2H3Sg4HwQ69JNuoVVfZdko+mTO0riISE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ju33yiiCQmhUoNVZRpZWwXkAQOsiazHotZqlzWs02ooyxCqcom9tTykPE+AiNMP+ZWNv0C9+y3pv/GSRn0hmoGljjhxk6VYQvJ7+/TmYAklho/LaUZAsdE61+WrhIUcQbMHHk8fYlgNqthQyLPmkd9sWIWT7Lq8tpY/yh6WA0ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSiZX+Kg; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSiZX+Kg"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2800546eec.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772210456; x=1772815256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdhIwXbtzriV4OW5ztdIybKDlCas+wm2/e72G4CdWfk=;
        b=LSiZX+KgqPM8gkkTRYnQF4QKo15oV/QXh/m7oyDGR/x8wN6SnXBpLAmnYll49dVxlj
         DRj1bLoxgrYoIa4yr4OEaRWkDNGMlvqysGwi5RFoB3AwHtP8pHgK+nhGHDV54zBeW0kM
         BiVkQpBFmTTY+w0NHfT0CycYlTAjNr2jrCl2Y1cZFjbDkHH2UxL15/1crmX7Fuv11zAa
         fU36fxIwBEAwoDDovUDirPw7I+Ls50qNfknKYMevaYiHWEiJ3G+wW3iCx6piL/4BnNuG
         CTg27Ri7Oc1UpQHvQguFO70RsXV+dvmDqa329MDSLWvCaCwSjyrikupRfykFHEEJn6Uu
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772210456; x=1772815256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdhIwXbtzriV4OW5ztdIybKDlCas+wm2/e72G4CdWfk=;
        b=S3T/bdcZ2Xxeu/apKZdct4s9T/AJEPSlEqzK89J8x5EQBelb6XyY/GpWYG7AdqkUu7
         TkQSMU1y/cgo2mJaZL10HdUVdGD7mbzC236TzTfwLq+e2JsM8TW76cxGkMaGHlG4t27S
         dmKk7ulchX6RR/nHcWAxvePuOkcbS/d6SqzRkFcmaPydQwqWOZtjyaWpk31vbf3Lj+px
         3crD0yexWHri8ahh9mhEZUKRAyHM47pRQKLOuH8P7rKPGP2BoIccQ3nOWDojmXfujtDF
         Gvp1iFz/KhFShOym3UK0+38f6OXI727js70/50er+orTHCpfkDaA614jgZv9VOP3TiQn
         YzgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpbKp920LAWD1OqJu6CjIrwK0v+Q95tovjAhePQdPxolyTWJtxKtBHzE6n7fTg8v/evao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTaGC3JATidqLK5HPx5UlDyEDA4vlmeYPzk4wXRRbhR51z5UL
	8ClEBJzia+3BaW95cyOZ3YYW7/bjjd7vcJqFQ01wl+dlfQN/Z8EZWtKL
X-Gm-Gg: ATEYQzxlIwbYfPf1ufppcjfdKsBZAHuEx+XSxCQJGjFQ2erlaC2AacQ3m3wlMrtC97c
	Frfs1RuUccToyZJu1Oe+POzeYm9QJl28QJd/zp1QJ5ctoI6a6sfuRSxwU65IkCH5Rk6ilE9qLE4
	kIknqboBtiAEjJNXg0TDqQ35QkNnj9qkgqLMPInMRfpYcbFgIaoeZ9mNzj7GPJOIX+123knnL52
	VFNfY5LhTitQHBxjC99d9vfa1Z1nPEGwqSTH7/Pp1DtPPExkT5RTv9ah9SQPG+sB5id3umhZiK6
	HRu8EJoIL73I+JQTZ3HNZjtEftMSGCPPY2FdIo7+prT4zEME9dWKGJ3/hQ85oNOTtp68mo11l5Z
	tvLd9sgVEYVztRUHm3osc0poRAn4j09LxA5pUkGJcPtdjAyNISmHIZaNZpIv22xAQlAWcJ5B+8i
	9wUEc4KKHQUGzTF99XSMKEDd7YLuCVerd4wzgO0aZFtIXDXDgKxhofowed8TA+p2jX8xtzbDL/H
	M599jRQgQaU1lhESaZZrXPR+yo=
X-Received: by 2002:a05:693c:2c97:b0:2ba:8961:e1a1 with SMTP id 5a478bee46e88-2bde1d31e56mr1547097eec.22.1772210455641;
        Fri, 27 Feb 2026 08:40:55 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdef9700ffsm220707eec.28.2026.02.27.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 08:40:55 -0800 (PST)
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
Subject: [PATCH 2/2] selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably
Date: Sat, 28 Feb 2026 00:40:37 +0800
Message-ID: <20260227164037.84110-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
References: <20260227164037.84110-1-sun.jian.kdev@gmail.com>
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

Tested:
  ./test_progs -t bpf_cookie/perf_event -vv (30 runs): 0 failures

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_cookie.c       | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 50f5e11e6e65..35adc3f6d443 100644
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

