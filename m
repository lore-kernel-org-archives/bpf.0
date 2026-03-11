Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83223DBA0
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773253721; cv=none; b=AE0fAVBS4jmmykGNKdYZKVO7kgePC9fHW+0NkqdPqHMnC8YRItb3UYausK0Mq9FEb8enRRu5HHHjxaarGZiJ0H412pg8BvWZXoA6uNDyxb752sb4qjofh9N7qBG1j8vS3RZgV+OAksytL3Sui/XeUI1FuAwXhTTTQ2MFcGVmxH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773253721; c=relaxed/simple;
	bh=EdcMX6LDMJHLkL0SOJCcFEe14W7SxI5cIgagXIRrknE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gipobDkXIgN5NEUPSxlSYZvkKgGBjbrVBAaExr41gjZ1HXjwnxjhhqdFtfCqK3kVYgjIA3TQKjnhAHSmFHFTiOHeFcRLPUU//fJ8rX0Q67uodsMBGoQjjNdThlpyjXvndt/9MaIzG5O8hVCG3YnENF/iQNZH9/h6M4mzRQV5v0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jPu20+C3; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jPu20+C3"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899e43ae2e1so1513046d6.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1773253719; x=1773858519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joLfX04LGzhe8j6MVJQ7jWVTogjCHM16XxkJCT2hiOg=;
        b=jPu20+C3eTNq0kkpOmOkkMCJvx++RGdp0tOBOjfOZXKWrZBN7Ya+2zNLVbqNalFivP
         2dClZBz8ja2Vk8wFOVSWhjrmcgrTcQd5NN/OT4rRewFO4wIo0d8b5HterO2VHeN2sT9P
         7LWgjmA/9vraZGhY4Y3cdQWQA4saHoyg1zDq/oyX0jLvvV7KMTsXGuTDuxNKKiTcCfmA
         3lsZrycG1BOPq2kT4kTwU7Zx8EHwP2t32OGTB/JrER0IDzWTqOU8FbtVdSz204wZoy03
         8nELjdKeMupM+XpedvEtHihF+FHuUTA1UBjAtf9m3WY76Epd6EJEbye9V/fRENCiw1Gg
         6tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773253719; x=1773858519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joLfX04LGzhe8j6MVJQ7jWVTogjCHM16XxkJCT2hiOg=;
        b=WSGC5dKjn5kBXCGffUb3J0+4K15uvMrRo1EiGKG345ZrS9oat21ydNPZt9ynb/luIZ
         /35F+XUn3NO+YpkdorRw5n0NUcqi7KsiQNmwlZ4V85iVWsxdGgkdH1sSvSPXgZj+zNXh
         +WL4rcIehQuwA5Sci0L65NuGYMPdHtHpuntUscOKyQA40BlEMpse5O2OdXDXxaPr1wJk
         7jVYZOCYwEM9kV8g9XpLx62SU7Jx8DXCtX74ciDJXPnldgwLlbJMXRwT30waIyVi9Xvc
         jGaGfZd/zwU5FH3SdJ242nIijql88l00uodnt5BmWeeuPYLIPISF8uyPSjMCf3u1C0Tr
         6XOw==
X-Gm-Message-State: AOJu0YxbRYzX0n6xAAQuA77llvBG2gLD60Dvpf1RBUF/RlNIQd0zlL+E
	Zm20egPeP0o+KY6JBfN8qp1wIJa/kA9QYEsqFbDNT5PO7rJRjh9OAY1vxzPdRepFuCmL0YRs26/
	4ith5
X-Gm-Gg: ATEYQzzi4bZ01IWLwlcvROM0DddjGZXP5qS/4kMothsg57TbNSkQeCF5gHHd3tQ0l1P
	7P/pz9mq9MmTP7qY3H8/K559sYsXVOeaz0IoQj69HxfeDyawTDNcFJXkFEldyTGxvCQEFiXbq4O
	Rsu/s1wn1BdxbCsojO4j7cMffzUCPUNhfx7aohLFmd5kDJVumxU2xQuc09lzvhBczuBckn76M6k
	Sdw/YvO2PjYJ4h0TmokaSQY6TybQHSORBDXVYgb80BQKwVYDPwOxm7NVlOd1bo+QSI6+8xJ9P2n
	YZmhoNr6bhAHUwTajaEYjl1v/sDcbs74/U8NQLROoVn6re1RF5L2JXjDaKxL6EBsYE+nVJuuqba
	fQrnhKUol6dAqu3Ysb1L7KB8o6PvCtZvlxJ/Q2anXhgi0Ss5xpCKwPfX2ciS4peqosm0LR8mnxt
	cYvl8SYvYGAgvXHwz689BO2g==
X-Received: by 2002:a05:6214:dc6:b0:89a:ec6:1028 with SMTP id 6a1803df08f44-89a66a1b3b0mr51146956d6.30.1773253718478;
        Wed, 11 Mar 2026 11:28:38 -0700 (PDT)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm21178946d6.19.2026.03.11.11.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:28:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add deep call stack selftests
Date: Wed, 11 Mar 2026 14:28:31 -0400
Message-ID: <20260311182831.91219-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260311182831.91219-1-emil@etsalapatis.com>
References: <20260311182831.91219-1-emil@etsalapatis.com>
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

