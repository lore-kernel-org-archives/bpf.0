Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67786331A65
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677555; cv=none; b=TlTA3YLaIHfvp4VhkHlqajPOdYCcOJvo7EdcbFwXZp+j2IzS+fHHQ9cdXOW8upXP5D3H89XQ+OyMGKHlXc+OZePdZ4e572LxK1u+girvDZEViDmhsiJko3FIDrAOTY8Dzm7j/vBxuit5SHXW0XKz4XgrDwiqBaQas5fwd/5IbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677555; c=relaxed/simple;
	bh=EdcMX6LDMJHLkL0SOJCcFEe14W7SxI5cIgagXIRrknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz8lwxYYgqL71MHrj8nMRE7fy7UURAGE/saEDjFhiBhFgM6Nf4uuaHIbdPp6TrdqA0ATmxGEq9f4ZXd9BWCBGIjAvYaaiKg4jes0GkbZkxdZRUYiRcfjmMJNxge/zKf+EyQ/N211GZzyF3UCPmiZMG8XmvHDiszLUArnpLbCdvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=0/vOw3Eo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="0/vOw3Eo"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89a465bd7edso34130976d6.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773677553; x=1774282353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joLfX04LGzhe8j6MVJQ7jWVTogjCHM16XxkJCT2hiOg=;
        b=0/vOw3EowbfgIt71P1ZCjTf2qj7o3nPK9l6IJE9RO1Mp9Lk7To4vJKl8amPJJnM2Qb
         qA8xEmKRsRAEgUINnVx34jPpZEsi4Uv9y0zrfKnDPJiUB7ziZz3KMGl3+JugstS31Cov
         ZmGw8QzHXuNiXg7slhuXGJEbjhsWR5q2NK6zSBL5Vq5s1RHEFlTn8qTqox0QbPPehDu1
         sU7wGdxjJ43uSEHpzOssS+tiiD9NmGv9o+jhrlI10CeZ/wiqYyEQBkJnyYRLOcS7EKxV
         hLMaxvPS+AcBA2BSFlWpYt2n9s8RAeu/0ezTuIJdHByOPco8XQJTCCggY9l5IK7eVOFg
         WcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677553; x=1774282353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joLfX04LGzhe8j6MVJQ7jWVTogjCHM16XxkJCT2hiOg=;
        b=FSUpQ+bEbPy9dk0wNLzgppG+G/NjnxqjigUY+AISMOR/UAZl1bIdsSOarSEVORWcPi
         LHGnNzxae3Tr4sqiUH8EjZ+QjP+r8uR+3q5becBsrsV62r0zPIMCi8SK+aAO70m8HueC
         LclKhSiuv58rsrT7p3+pJvN8RN5MdT3FkkDNd/8rlElnr3dWts2ynWrdiPxbakM5E9V8
         hPLFivbVviZU76g13WQFW7uqcTyrwmODox8JOPGIq4fE7VxIAmQFm5+vbBJT3Pi+DK4c
         ivxRUQWVlocjwcDzWkqWrZRiQkpLEhhowNS7J++vN+9WQyhUKP9CDBPmWEY1O10OuJHe
         SkqA==
X-Gm-Message-State: AOJu0YzTuzLySoiJlw6XJWgFOe8zicGFmG2WkHJVPTyvd/TzKRbRhaHR
	kmh7Glf0LhAZH7x+rwJDzcfLpiedzaTBqw4aNqdU9wg9sKkze6PE4ppMm4iAmdS0MLdyIS0RMHD
	d03oIBgg=
X-Gm-Gg: ATEYQzzwGh0nilogdqSfkU7lCiXgd3Ezv73eH0HikImRMDfH9Me6GY2QNNX80NurnF3
	b5ittq6GW3vUFSDo3ERrBdprbI2+J2vGkWbdjpmV4MOA191hFbrf9XmrnIM9XlGKGFym6FURoow
	axsF3MkcfXGTdD210ii09Gd+JpsHUQXnyx0re6Zh2bLi1T4aInZGhFYYBM/vRbfWyfOet8MvCEc
	nY4PRxNJGOr6tcwheBtV4QTvTgzEZ4uTrSzoM8SAv5bC/ZTYJDbc5S9lR895UagTRLS5wkQZUMh
	rQsZUCPHsGH3ARwB+a/KsSEBhW0sa7SzvxlJ1fRHj+CucmH0OqhSL6dU9t0utQFnUoYdWI058Y8
	kaCvf+zgcbgl3EzBAfxtN2WIZii0zY8ZTt6i6dFRZy5BRVr9zERsOpYQVdwVKSf51pdTZSrsiWq
	vAIE8XOxYOWsvjRogxWp+LQQ==
X-Received: by 2002:a05:6214:27e5:b0:89a:ec6:1028 with SMTP id 6a1803df08f44-89a81dab8e5mr164642226d6.30.1773677553184;
        Mon, 16 Mar 2026 09:12:33 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c463b0806sm54022626d6.49.2026.03.16.09.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:12:32 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Add deep call stack selftests
Date: Mon, 16 Mar 2026 12:12:25 -0400
Message-ID: <20260316161225.128011-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260316161225.128011-1-emil@etsalapatis.com>
References: <20260316161225.128011-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that demonstrate the verifier support for deep call stacks
while still enforcing maximum stack size limits.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../bpf/progs/test_global_func_deep_stack.c   | 95 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index e905cbaf6b3d..500446808908 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -18,6 +18,7 @@
 #include "test_global_func15.skel.h"
 #include "test_global_func16.skel.h"
 #include "test_global_func17.skel.h"
+#include "test_global_func_deep_stack.skel.h"
 #include "test_global_func_ctx_args.skel.h"
 
 #include "bpf/libbpf_internal.h"
@@ -155,6 +156,7 @@ void test_test_global_funcs(void)
 	RUN_TESTS(test_global_func15);
 	RUN_TESTS(test_global_func16);
 	RUN_TESTS(test_global_func17);
+	RUN_TESTS(test_global_func_deep_stack);
 	RUN_TESTS(test_global_func_ctx_args);
 
 	if (test__start_subtest("ctx_arg_rewrite"))
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
new file mode 100644
index 000000000000..1b634b543b62
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Meta Platforms, Inc and affiliates. */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/*
+ * Macro tricks to tersely define for long non-recursive call chains. Add
+ * computation to the functions prevent tail recursion from reducing the
+ * stack size to 0.
+ */
+
+#define CAT(a, b) a ## b
+#define XCAT(a, b) CAT(a, b)
+
+#define F_0 \
+__attribute__((noinline))         \
+int f0(unsigned long a)           \
+{                                 \
+	volatile long b = a + 16; \
+	if (a == 0)               \
+		return 0;         \
+	return b;                 \
+}
+
+#define FN(n, prev) \
+__attribute__((noinline))                        \
+int XCAT(f, n)(unsigned long a)                  \
+{                                                \
+	volatile long b = XCAT(f, prev)(a - 1);  \
+	if (!b)                                  \
+		return 0;                        \
+	return b + 1;                            \
+}
+
+/* Call chain 33 levels deep. */
+#define F_1 F_0         FN(1, 0)
+#define F_2 F_1         FN(2, 1)
+#define F_3 F_2         FN(3, 2)
+#define F_4 F_3         FN(4, 3)
+#define F_5 F_4         FN(5, 4)
+#define F_6 F_5         FN(6, 5)
+#define F_7 F_6         FN(7, 6)
+#define F_8 F_7         FN(8, 7)
+#define F_9 F_8         FN(9, 8)
+#define F_10 F_9        FN(10, 9)
+#define F_11 F_10       FN(11, 10)
+#define F_12 F_11       FN(12, 11)
+#define F_13 F_12       FN(13, 12)
+#define F_14 F_13       FN(14, 13)
+#define F_15 F_14       FN(15, 14)
+#define F_16 F_15       FN(16, 15)
+#define F_17 F_16       FN(17, 16)
+#define F_18 F_17       FN(18, 17)
+#define F_19 F_18       FN(19, 18)
+#define F_20 F_19       FN(20, 19)
+#define F_21 F_20       FN(21, 20)
+#define F_22 F_21       FN(22, 21)
+#define F_23 F_22       FN(23, 22)
+#define F_24 F_23       FN(24, 23)
+#define F_25 F_24       FN(25, 24)
+#define F_26 F_25       FN(26, 25)
+#define F_27 F_26       FN(27, 26)
+#define F_28 F_27       FN(28, 27)
+#define F_29 F_28       FN(29, 28)
+#define F_30 F_29       FN(30, 29)
+#define F_31 F_30       FN(31, 30)
+#define F_32 F_31       FN(32, 31)
+
+#define CAT2(a, b) a ## b
+#define XCAT2(a, b) CAT2(a, b)
+
+#define F(n) XCAT2(F_, n)
+
+F(32)
+
+/* Ensure that even 32 levels deep, the function verifies. */
+SEC("syscall")
+__success
+int global_func_deep_stack_success(struct __sk_buff *skb)
+{
+	return f31(55);
+}
+
+/*
+ * Check we actually honor stack limits (33 * 16 = 528 > 512 = MAX_STACK_DEPTH).
+ * The stack depth is 16 because the verifier calls round_up_stack_depth() on
+ * the size.
+ */
+SEC("syscall")
+__failure __msg("combined stack size of 34 calls")
+int global_func_deep_stack_fail(struct __sk_buff *skb)
+{
+	return f32(123);
+}
-- 
2.49.0

