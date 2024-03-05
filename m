Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC34C637
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709614358; cv=none; b=eC2uy/3XDTqHropgcrACmn+pyNJ6zpIJmOAoDqhK5WG1+UjXbJPhN8cOtDujQwfH3QGf0412ujre6pDOfil5cGZJIWxNL7iLg+Afj7drch2rJBsAe9bxTOST2Q9fwM6DzvYiudK4jk/ljABWYbbrpAw+zaaasyJlN4rgWeZo62M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709614358; c=relaxed/simple;
	bh=Zsn3UciRmz1y4y4OcE4XSj+bnHZZ1ViSPWAHbOk1uSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qNIAicjydZ7FkFw4uv1yOB1QFeQwJWZnUFfcvHJ/lnHMENy4d8RnN9nQz60JcWD387Ai22HdZzm1b8D2BvziFQWnrkB1mLaCTjbGRzTe0hsNcXM71IO400KpqVBNBUuR1pFSNsaYfWEAxofXv5QKApVnMw1tOO1gfs13pdfRr6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd6IwlJA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd6IwlJA"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so4185144b3a.1
        for <bpf@vger.kernel.org>; Mon, 04 Mar 2024 20:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709614356; x=1710219156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSQ/agq3nwxiLrfdgKH47D6257r+0l8kkJgdS53pJhI=;
        b=Xd6IwlJA1cpCGdebeBWhqlHE96BJ4XHBT38O0urKjApDEEIAgQLblORZu6/kSuHDCT
         PvxH9xP5EeUREN6IyR6eJbasc15nqGWu1aoUc6jKAy4ucWJYtILaPKxO6B/Bf5sPYqEn
         uK5KVqKB9PaLAmtOCZkS5Qw3fUSP7BxOV1/gJ+W8ibSPH3tWkifw7rF5Hrg5PyCVPCxH
         MVBIhWMOQIexWWHqSp6rAc3PxJK9fSdiRwnwrhyT13FErO8OsnBYh9In+acm4dUfRWzy
         stFsuum5GOOgQbhURsrpIgZVqxfVx8Fftq7jRwp/4d9yPahR6HK3aC43JHJu+544xbo7
         5Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709614356; x=1710219156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSQ/agq3nwxiLrfdgKH47D6257r+0l8kkJgdS53pJhI=;
        b=vo279U7B7sn7PBSES72m2Lqkz/taKTe9OgoH0hqCbmd4M5dEL5DlAeBKN2DOJ9sNpb
         61OoX1e3BcMUZ3gBiYYqBn1kAalLHhINP3LBAXV3FqBLlYwBDl0BFDv8x20Ic6idCnZH
         WIsApnIZqW9uXxRFnorhv1gjhbBLIcI9wKI/xyBW+96iYLCWC51bpxqltgLzEOdjBSLh
         4Yfn5UnpBo/0psIPix1xQEViZMgS51HOAPjr4AZ7nXb4aAcbOhwV+mwwc0JgRCSJupMY
         NzJRpBRiOndWT2uMjBWPgLv2Lr4Cu541rcdnQC/L5dqL2A+kX/MtVgSa8ojulEd3rA+3
         ZpWw==
X-Gm-Message-State: AOJu0YySkhDlDCtUhpmrLIznOmi83q6Y9E4jSqiS/VfhayQoSSvQf3CT
	L6ygreBZgQi29mGKGR9pnuvqF6NGs4lEU1Tfngh8+Ec8LRfXvdVB8oOn32eR
X-Google-Smtp-Source: AGHT+IEn22Wlnq2fYGJMxP6zW6kxVI+CfKoKfLmaInCkciuUnyOgxph/MANId2gAnStQ67YEgHvwHg==
X-Received: by 2002:a05:6a20:54a4:b0:1a0:ea67:ecb2 with SMTP id i36-20020a056a2054a400b001a0ea67ecb2mr998113pzk.12.1709614355985;
        Mon, 04 Mar 2024 20:52:35 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:9426])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001dcc138d4afsm9434175plh.34.2024.03.04.20.52.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Mar 2024 20:52:35 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v5 bpf-next 4/4] selftests/bpf: Test may_goto
Date: Mon,  4 Mar 2024 20:52:19 -0800
Message-Id: <20240305045219.66142-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
References: <20240305045219.66142-1-alexei.starovoitov@gmail.com>
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

