Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BC11737
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 03:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695194; cv=none; b=V1I56WBSF22Kjh9YzlQFlT0Axrp66MQXqRETOQG6vKrQNc5bt79GufKtt8VhSa3KEwzR6Typ7eRtcMrRSVgqtvxSWWSdQ/88XhX3gII08HcZMAF52HSVa+wr9x4g9pgCa0kp47qRuCMG3X/9yaqcjhXhFIhADAhaysY3ED+wwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695194; c=relaxed/simple;
	bh=Zsn3UciRmz1y4y4OcE4XSj+bnHZZ1ViSPWAHbOk1uSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXK5+yKIWMOVukl3lE7WvhsTYasURkHx/BIenV8wwPGRINxf7GYeLxeofnKbZNKJSN8kZCMeP1zK0AU1bwDzAG6AM/stmAarW9PjgWkhWk59G5nPl+ELguDWnMCLhjfUe9PnJ7E0x0PTRT9mh8Cilv64SVLS5JC8h4UzY4ofGKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcFqN+RO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcFqN+RO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd10ae77d8so24064945ad.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 19:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709695192; x=1710299992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSQ/agq3nwxiLrfdgKH47D6257r+0l8kkJgdS53pJhI=;
        b=AcFqN+ROnbm9Cqre3NK2W7+IkyRNdVcrqiwSug7VvmiLLvvnA3H2dE/RlbaCYOhNXD
         wPn9+qIR1R75q54HiAVtPg/1CyYoevBPOb5DkUKEAEdtyfLjB59B79ZYy7hLu5LsHkBg
         lLyWUnHiIeP/jPj4oA6L5QeTlil1ObjJHcZLP0VEDHS3mWOaEDzY7Qlql865kD0KlPcM
         bL6GMRNOHuLj0x9Kh8V3+h+KDa9ZNRDlcLEZG/Btstrl0JVDf1cczlIX3aaynVmHkEDJ
         ZirFtCx1BavoPtWOAkI2Smdw7T9CvhONIe2U4qY7KgWmHOV/K1PFaQSz1T5IvBFONulH
         ptbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709695192; x=1710299992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSQ/agq3nwxiLrfdgKH47D6257r+0l8kkJgdS53pJhI=;
        b=VPVx9H+KGXEvQTJ8aB2GINLYzX9G75vJoy5xJoXooUomKuWI7AJ3IUZu3r587CmmOQ
         Ip5lsTLa+Lt5F57AYFk+XZdkUupuppsj0ieJm++7CEiBINqpeGDMuXbVqj//aw5LJ5ys
         5xb3rRllzB8vN2jtcVzvv9UF7+VcRYarwStTmJLTwzrZj3ce4OT7YqZtfXJkm3nwiJMp
         YJsuQB+UvA35XUBVoxWRkXKrQq5Bq3DOWOODLf/LtD0cCO7xp1+tBczXxqnZ4hbZ9bOB
         6mz9PfI2iuhUDaMBW8k3xGGl6DNt62bKmm95QYodVdkXvz7Y/ur9H67kPwkhBqIFx0SV
         CtRQ==
X-Gm-Message-State: AOJu0YxDXXjnxFCmae2/h+BFkp1XoKpprpdCYxSk8QtRkwl3pH0Q03NA
	fFjqTpfB92g1EWUFI6Dd3JQiuQblix6BBvjYMgDZ6/L9zGKING5ugnEAmvUQ
X-Google-Smtp-Source: AGHT+IHX78HrSj3V56t6HWiVp0mMHNo9PFsjiUpjFbfisSARgyrsYdPWQjcqX88WbIT/Ry8jd4vaAw==
X-Received: by 2002:a17:902:e544:b0:1dc:d588:bc6b with SMTP id n4-20020a170902e54400b001dcd588bc6bmr4446010plf.0.1709695191990;
        Tue, 05 Mar 2024 19:19:51 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:52ad])
        by smtp.gmail.com with ESMTPSA id j15-20020a170902da8f00b001d8aa88f59esm11328408plx.110.2024.03.05.19.19.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 05 Mar 2024 19:19:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v6 bpf-next 4/4] selftests/bpf: Test may_goto
Date: Tue,  5 Mar 2024 19:19:29 -0800
Message-Id: <20240306031929.42666-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
References: <20240306031929.42666-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for may_goto instruction via cond_break macro.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/progs/verifier_iterating_callbacks.c  | 103 +++++++++++++++++-
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 1a63996c0304..cb810a98e78f 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -3,3 +3,4 @@
 exceptions				 # JIT does not support calling kfunc bpf_throw				       (exceptions)
 get_stack_raw_tp                         # user_stack corrupted user stack                                             (no backchain userspace)
 stacktrace_build_id                      # compare_map_keys stackid_hmap vs. stackmap err -2 errno 2                   (?)
+verifier_iterating_callbacks
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..04cdbce4652f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_experimental.h"
 
 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
@@ -239,4 +237,103 @@ int bpf_loop_iter_limit_nested(void *unused)
 	return 1000 * a + b + c;
 }
 
+#define ARR_SZ 1000000
+int zero;
+char arr[ARR_SZ];
+
+SEC("socket")
+__success __retval(0xd495cdc0)
+int cond_break1(const void *ctx)
+{
+	unsigned long i;
+	unsigned int sum = 0;
+
+	for (i = zero; i < ARR_SZ; cond_break, i++)
+		sum += i;
+	for (i = zero; i < ARR_SZ; i++) {
+		barrier_var(i);
+		sum += i + arr[i];
+		cond_break;
+	}
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(999000000)
+int cond_break2(const void *ctx)
+{
+	int i, j;
+	int sum = 0;
+
+	for (i = zero; i < 1000; cond_break, i++)
+		for (j = zero; j < 1000; j++) {
+			sum += i + j;
+			cond_break;
+		}
+
+	return sum;
+}
+
+static __noinline int loop(void)
+{
+	int i, sum = 0;
+
+	for (i = zero; i <= 1000000; i++, cond_break)
+		sum += i;
+
+	return sum;
+}
+
+SEC("socket")
+__success __retval(0x6a5a2920)
+int cond_break3(const void *ctx)
+{
+	return loop();
+}
+
+SEC("socket")
+__success __retval(1)
+int cond_break4(const void *ctx)
+{
+	int cnt = zero;
+
+	for (;;) {
+		/* should eventually break out of the loop */
+		cond_break;
+		cnt++;
+	}
+	/* if we looped a bit, it's a success */
+	return cnt > 1 ? 1 : 0;
+}
+
+static __noinline int static_subprog(void)
+{
+	int cnt = zero;
+
+	for (;;) {
+		cond_break;
+		cnt++;
+	}
+
+	return cnt;
+}
+
+SEC("socket")
+__success __retval(1)
+int cond_break5(const void *ctx)
+{
+	int cnt1 = zero, cnt2;
+
+	for (;;) {
+		cond_break;
+		cnt1++;
+	}
+
+	cnt2 = static_subprog();
+
+	/* main and subprog have to loop a bit */
+	return cnt1 > 1 && cnt2 > 1 ? 1 : 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0

