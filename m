Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54A933507E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772512279; cv=none; b=kWylmPe4iabDUnJLQkeyGbyBFtvtBYiBCdpfbOJ8Sv54bASx63nzcHD1euewqXaahJpO9gJzbOCqCSwWunciM72FekPWocNX7WCfn0q7LwW9bZwmnwAooL8sxMSJkZhpw0utfbM3KiZeVcg7k77wMy4ydcTZ6JJfHWbsCFKpp08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772512279; c=relaxed/simple;
	bh=mzpIXLlKpinDCl+5V7aNDu4CeSoomtxWYl1dQPRoujs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuOMyATFeVBRlu+2ep995kbd7QqPtMswj2D1CEZqK5WUYOSAx3aiLMskPoYfZrwxnx0FXbWTZEdj4H/ntibThGTVmR4jM49faGYFfL5/oA8TXcAb1hZte/aUAaAEGrZGrhBRvsw5FNNC+zX/uM132esPz2KaEcQzaUwf50uJKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=viAPBUn4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="viAPBUn4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-506bcb23a78so48538891cf.3
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 20:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772512277; x=1773117077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lkp/M1GmaomVnQzJz6ApytBwTmM03+1HQanQRJH4P2k=;
        b=viAPBUn4cuEeVPNqGJuG3yb87A3A0pGQpPG6uxCuXnv5thaSvbCGDDCZra7IWDY+xa
         Z0wVz4zURoQIEX5Dtuhpd6jrHuX1ku10k7ZbRR8/GW2jedcQovTDkY4G3YoAoKewU2BY
         +Hf7fiR2jMWt7GFnKiOlbw418WHqtpisHRgKg1uhKbQE8+CrIzRX5wb+fwCtfQzKSJdd
         5nJNepErhJrGaPAvHXk4G9GTVwjca2j0vOo0bboG1a3BoMXOD5sKwKK8V96dbxr/MFPG
         0PLUvhYqebfvJ7yHkftVMXUkne7Kd6sDqwZiVE5Vfdvvws8tXO/s674CxJ5IB2cRLA9m
         Oibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772512277; x=1773117077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lkp/M1GmaomVnQzJz6ApytBwTmM03+1HQanQRJH4P2k=;
        b=cMX0e6fOOBfpS7nOTV6h4e1bz/Pkp5vqGHDdIkaXPuUcR3/uXoRdqKApjzeFiy419m
         HbuP2qIsEvpWN2NTRK7KtdJMqxWFzHdIgbRGG/tUxZmcEcD2xh3rlK1AGZH7cTMriqeH
         s0/BfBzVO2F+Z4YrNABZvKnn5rYiTFtkLIJHwMVWvs7wA//OSpvGnAV3wwvZQ31GK/E+
         AHCfFvP3rS75bK1GCLQpa+oVnwC3k7Fvd6e2/JLa+8sW0eQccUtdWFLbXAK5ESJOqUVz
         6pDbxVlFOSjCPud4jhO0QpQ/WR8qhcvxztDVlWtwyWFX8sQcdt25UlEyhVx2Zz+j+63v
         EDlw==
X-Gm-Message-State: AOJu0YzGCetffnG30CnOOlo1ChBPk0fSUkZINgJOaysUE830Fllv/ovF
	LxmTWvb/VyvNERy8erdnw5VUWt3OhURAjzqALzacZYuoSepRPCtWmBtsAxUmfYH9EhVgFfrqbUP
	1uXbLWkc=
X-Gm-Gg: ATEYQzwDz4KFOoHxZQzGJDoqg39KSQ62b2hjqkI85BzU5GfAG5mYTqM2uvjBNSeRfAZ
	Ne1lw+fmZmdq0YaSiNBTmFALFZIpE3+C2WQPyM3C7Huqld51WcnE0Y1VTRgBxNOfK6ecvcZzW/W
	NY1OVy1nTuIFyWIL0A8CDH8HA20GRvLVfVHmEOrLKKoXJDtqpTBBt0IilUn+hN/yavtkEubKIvC
	LZkiVdgCBiuMH+KC6uZKc5s9cg/BO+cOp09w1OTMpiTVMmNX4PGBC037IUYPnA09M3wGApoHB+Y
	iIhk0NyXsZAgd08XnyKRfV3ZaNi6Opnh4jmaSus3jAtVmV+ZH0ZujXHNzAz+AVoCAYiik555FZN
	C2u/wofWRP8n4FLEG3rNJmpLWI+Lo95Wdpl99pTUn7rcKpyLfDqxDA6TtK5QMTBkTLtcVuIkMKc
	3bhupOhU5Wahpv2TqmFKg59Q==
X-Received: by 2002:a05:622a:51:b0:4f1:ddda:9a26 with SMTP id d75a77b69052e-507527cd1b3mr195524571cf.35.1772512276590;
        Mon, 02 Mar 2026 20:31:16 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm20876966d6.6.2026.03.02.20.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:31:16 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/2] bpf: Add deep call stack selftests
Date: Mon,  2 Mar 2026 23:31:06 -0500
Message-ID: <20260303043106.406099-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260303043106.406099-1-emil@etsalapatis.com>
References: <20260303043106.406099-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that demonstrate the verifier support for deep call stacks
while still enforcing maximum stack size limits.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 .../bpf/prog_tests/test_global_funcs.c        |  2 +
 .../bpf/progs/test_global_func_deep_stack.c   | 79 +++++++++++++++++++
 2 files changed, 81 insertions(+)
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
index 000000000000..02b1a0f9d6ac
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_global_func_deep_stack.c
@@ -0,0 +1,79 @@
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
+__attribute__((noinline)) \
+int f0(unsigned long a) { volatile long b = a + 16; if (a == 0) return 0; return b; }
+
+#define FN(n, prev) \
+__attribute__((noinline)) \
+int XCAT(f, n)(unsigned long a) { volatile long b = XCAT(f, prev)(a - 1); if (!b) return 0; return b + 1; }
+
+/* Call chain 33 levels deep. */
+#define F_1 F_0		FN(1, 0)
+#define F_2 F_1   	FN(2, 1)
+#define F_3 F_2   	FN(3, 2)
+#define F_4 F_3   	FN(4, 3)
+#define F_5 F_4   	FN(5, 4)
+#define F_6 F_5   	FN(6, 5)
+#define F_7 F_6   	FN(7, 6)
+#define F_8 F_7   	FN(8, 7)
+#define F_9 F_8   	FN(9, 8)
+#define F_10 F_9	FN(10, 9)
+#define F_11 F_10	FN(11, 10)
+#define F_12 F_11   	FN(12, 11)
+#define F_13 F_12   	FN(13, 12)
+#define F_14 F_13   	FN(14, 13)
+#define F_15 F_14   	FN(15, 14)
+#define F_16 F_15   	FN(16, 15)
+#define F_17 F_16   	FN(17, 16)
+#define F_18 F_17   	FN(18, 17)
+#define F_19 F_18   	FN(19, 18)
+#define F_20 F_19	FN(20, 19)
+#define F_21 F_20	FN(21, 20)
+#define F_22 F_21   	FN(22, 21)
+#define F_23 F_22   	FN(23, 22)
+#define F_24 F_23   	FN(24, 23)
+#define F_25 F_24   	FN(25, 24)
+#define F_26 F_25   	FN(26, 25)
+#define F_27 F_26   	FN(27, 26)
+#define F_28 F_27   	FN(28, 27)
+#define F_29 F_28   	FN(29, 28)
+#define F_30 F_29	FN(30, 29)
+#define F_31 F_30	FN(31, 30)
+#define F_32 F_31   	FN(32, 31)
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
+/* Check we actually honor stack limits (33 * 16 = 528 > 512 = MAX_STACK_DEPTH). */
+SEC("syscall")
+__failure __msg("combined stack size of 34 calls")
+int global_func_deep_stack_fail(struct __sk_buff *skb)
+{
+	return f32(123);
+}
-- 
2.49.0

