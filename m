Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4004A32
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772700200; cv=none; b=r6YNS6oXd8Yg3FvnCXj++9PeTAtsXPy4JiGpg5mQz7bPvM6DipHqFBp//O8Lsty7ySmxIsLc/wHy3pdYfiKMq8ODLz2syjTUTuVcfnm1shB1BQRQb2naUcP+kHTHBoukCS0R+pXWPsyA9TnzctF3BocYYFCPft/Teanj9tKRN04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772700200; c=relaxed/simple;
	bh=u0MGYNAw3R2Om4vWGOjTSr99GmxyJZFiyTRBLrX6YfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jvSvh3CpZXXw8m5ytQtZ0/26W7SAjHhTirzpnDyNpKzarBrhStQj30uq7K2xSprW88PUZnY5XaTLoyg5X3E3BIUIPuFJISvYU6E+zm6BtRHZ8eTQ1yjeHS4O1nU7eE5moUEbQXf57auJC6umqHYoThIscFHrSw9xcXoKxsWmaJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glOJNtNF; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glOJNtNF"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986d231b3cso103151857b3.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772700197; x=1773304997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CrbCrCECbu++kikZq0nQDYehopFHuwXsfSUPduIJHA=;
        b=glOJNtNFq/DN10ClthHrmayv/shT5b1DNeUEs7ckGrSE4wVvooePRPuKez8dsPyYVJ
         435T19Ciy8qXqSC5tZ9P0/aX6Nd9rf+9q0FJqbIK6LNOXFj9j6kBXoNmuHoxmODwTlol
         kxzTwI1A8YH3CBwltwEh7xMvlTnVm+wCHmBkOK5CQ4r4ccESvpWtvOj9JTcopye9fm58
         sHD7VL+1FB+CxWvq3v8hJQFFhJOYGYIE6pQF6KL+JtsGHsbTWMcJ31TerH48bVssj3+k
         1R+ndGtBzXM3QC7X9yhe3lWxn4eFMTAprYUgUpiMBjsNLrIJZik+x5Rc5Mzm7g+y2V8A
         Es6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772700197; x=1773304997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CrbCrCECbu++kikZq0nQDYehopFHuwXsfSUPduIJHA=;
        b=Uwo/TjXAv96hOaLakeQC0exn9uMmVVznahOZlEKGdBZrsPS9exIFfyI8iSzTSQk6+V
         GMtHPOcabEngVtZq4CM2ORb5Ih6SMVVrEr64M7XWXfgxYnP5eO8VXMTFo4tP5uZeuvlU
         MgaIS/2BLT5/avRql++pukaIsYrDRhmrac8IYoRoxIfUk7ZtsfJd9a8hxqdiurw2aJw4
         qMaP6IifbqliKHyF2Omm8BVv2fBzZWRfKq9iDJ0HGXyNmuO2VyuFRyyoqsb+RENqQkiw
         5S37Ik+aDJKviYcc3m/slERrcZLnWSfj5w96Yal7TVS8DS1/moekWeO6ErDiZ1RSwS+n
         bKvQ==
X-Gm-Message-State: AOJu0YydR6dnBmacWi3e3ZMo5d6vZjxasNYOg3HCFUcY8fPbdgg4N94L
	Z+ZTUoSSRvBAlmG3Ow3OgS37EROzcZyZAyZZafUmazqmiHfldohW4QB405logYmidHeZnjrF
X-Gm-Gg: ATEYQzwY/dH2gGPmqy9sDMRkNZJgscEJ0MTsMrsAmLNwr/COdZPOxbn0GkGceaIE5QE
	9hr3C2eh1ADoWIGoyZbHfQ3Mn6iNyB4SGEhqyHS1F0YH4QDDq5OAjlA3QYo+7lqBakTRBad4LhW
	Z+p/wj42oZP4I2nXZ30U6QSO/wnld10ngdKhiaBaFjTDl07Tcsm0IkkZ9kUY0Mb7nHEClPHzl6X
	tGDDI2JmAdi0OM4vCrWgNGfr3QExOyNt5KAWxMrxPMbEFw580hOv4guCwzzRUPNR0nLPEB1NDOF
	iPY2GBKhNizLlE073hFSlSxoWLFYE+vYJBwuIIulvE3DVijCfeud4M2kFhl5FLPJ8ZIeT34/hlr
	ac1scHgQKxnHQxbAiPvIVn/8YtXnj9HKWYGK0Esh2zXbkWmNGoHIz+y/n/b8XE6Y8sscXqorMML
	8g4EWBMJYAMegq+vgFq/ASa//lafw25ZUzG5GBXJ1HgzJeNeXo+8HvMPq4bUJIb12V2cAdg5a6s
	CCpBTN4D9t4aDnCUF+IlcoqyvX1oltOfA==
X-Received: by 2002:a05:690e:1914:b0:644:59ed:dba3 with SMTP id 956f58d0204a3-64d0715a05bmr1217220d50.30.1772700197654;
        Thu, 05 Mar 2026 00:43:17 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7626e56sm8943553d50.15.2026.03.05.00.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 00:43:17 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Shuah Khan <shuah@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: perf_link: avoid failures in concurrent mode
Date: Thu,  5 Mar 2026 16:43:05 +0800
Message-ID: <20260305084306.283983-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_link creates a system-wide perf event pinned to CPU 0 (pid=-1, cpu=0)
and also pins the test thread to CPU 0. Under concurrent selftests this
can lead to cross-test interference and CPU 0 contention, making the test
flaky.

Create a per-task perf event instead (pid=0, cpu=-1) and drop CPU pinning
from burn_cpu(). Use barrier() to prevent the burn loop from being
optimized away. Drop the serial_ prefix so the test can run in parallel.
Also remove the stale TODO comment.

Tested:
  ./test_progs -t perf_link -vv
  ./test_progs -j$(nproc) -t perf_link -vv
  for i in $(seq 1 50); do ./test_progs -j$(nproc) -t perf_link; done

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/perf_link.c      | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_link.c b/tools/testing/selftests/bpf/prog_tests/perf_link.c
index d940ff87fa08..9e3a0d217af8 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_link.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_link.c
@@ -1,8 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Facebook */
 #define _GNU_SOURCE
-#include <pthread.h>
-#include <sched.h>
+#include <linux/compiler.h>
 #include <test_progs.h>
 #include "testing_helpers.h"
 #include "test_perf_link.skel.h"
@@ -12,23 +11,14 @@
 
 static void burn_cpu(void)
 {
-	volatile int j = 0;
-	cpu_set_t cpu_set;
-	int i, err;
-
-	/* generate some branches on cpu 0 */
-	CPU_ZERO(&cpu_set);
-	CPU_SET(0, &cpu_set);
-	err = pthread_setaffinity_np(pthread_self(), sizeof(cpu_set), &cpu_set);
-	ASSERT_OK(err, "set_thread_affinity");
+	int i;
 
 	/* spin the loop for a while (random high number) */
 	for (i = 0; i < 1000000; ++i)
-		++j;
+		barrier();
 }
 
-/* TODO: often fails in concurrent mode */
-void serial_test_perf_link(void)
+void test_perf_link(void)
 {
 	struct test_perf_link *skel = NULL;
 	struct perf_event_attr attr;
@@ -45,7 +35,7 @@ void serial_test_perf_link(void)
 	attr.config = PERF_COUNT_SW_CPU_CLOCK;
 	attr.freq = 1;
 	attr.sample_freq = 1000;
-	pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
+	pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
 

base-commit: 0b3bb205808195159be633a8cefb602670e856fb
-- 
2.43.0

