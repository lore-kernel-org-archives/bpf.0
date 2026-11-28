Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795857021;
	b=4k8h4ELM4+jJM6CTlUo2ti9HnI3y56DJ9Eu3dytJ6cNxx+QWIiv+4EMyhE2LGAfsdynA
	 Pv1xRmGwE2qM85k0Onxx2FwPRMrd2jH+PWznFG7CrslI62P2WSmXfDtl6T20ICZbO1V2M
	 VhCEZUkl0LCMA+TcH+KksgvvbTYWu+EAb1Lukr2irHeSnwPgVGjC8ujV8iASfEIWsEPHo
	 XNxnaWJEY23+cq6OZICGlNRJeqq2RJi3+R+sS5zKLV0T+s3NI45i6WQI7fH8fbo26eROo
	 ISbdEaFT5qgmv1U8FlKuYxbVgIv5U1PENpva7pobjpkr7mgQ5zWvgnKB6VYVSqLLK5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795857021;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Dn1o2p1B906bMdX25e4ikW0wW9m9BYWb6ODM95VCJTM=;
	b=GlPB5VlZ4w7jPeQT9ETa6KN+cgEcAc+aHYewDfIPtWmWkk04XbYuzg6Qfbbo5jzfITbv
	 cefiOlSrIX/p3OtlApxme0WPVqPNSaxKigU4dTG8Ap2ALDKFh9pm6vtWlZGdQiRkak/im
	 cA958+bTjy5aS5Yjj2KUvNd7J3ErwDHdRwiTRgY/7p7U+Yne6bUMbt7CsD6zMsatVi9cR
	 CjoAPAxEACy8yJEaQ/G6F1hQGektBAtCzxpMNFOeZcuMaHnJHqERogMZD4TijprBmDg7J
	 xtXHesP50TT4usgXx++AV+49ymNJPyWCiYg2Z4XXBE5cbWcH6TAan0JCbr7bt86vxYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A99606A321;
	Sat, 28 Nov 2026 09:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A99606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Dxl7VzmgprBsMjAA--.7855S3;
	Sat, 28 Nov 2026 17:10:11 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx1cxxmgprh_I3AA--.16824S3;
	Sat, 28 Nov 2026 17:10:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] selftests/bpf: Move FUNC_REG_ARG_CNT to bpf_arch_regs.h
Date: Sat, 28 Nov 2026 17:10:06 +0800
Message-ID: <20261128091007.25084-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261128091007.25084-1-yangtiezhu@loongson.cn>
References: <20261128091007.25084-1-yangtiezhu@loongson.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAx1cxxmgprh_I3AA--.16824S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ar4DZr4kKrW8Gr1UtFWUGFX_yoWxAFW8pa
	ykZFWYkr9aqF4ava4fGFWUWF4Sgr4vqr48AF92qrW7AF17J3yxJrn2gr45tr9IgrZYvrW5
	Aw17Kwn3XFWxZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j83kZUUUUU=

Commit bc72742bebec ("selftests/bpf: Validate arch-specific argument
registers limits") originally included the header "progs/bpf_misc.h"
in prog_tests/uprobe_autoattach.c so that FUNC_REG_ARG_CNT is defined
when checking argument assertions (arg4 through arg8).

Commit 8c2b5e90505e ("selftests/bpf: add bpf_for_each(), bpf_for(),
and bpf_repeat() macros") removed this include, causing the macro
FUNC_REG_ARG_CNT to evaluate to 0 in the preprocessor and silently
skipping all assertions beyond arg3 on every architecture.

Move the definitions of FUNC_REG_ARG_CNT into a new shared header
bpf_arch_regs.h, also add the new bpf_arch_regs.h as a dependency
of test_uprobe_autoattach.bpf.o in Makefile.skel to ensure it is
properly rebuilt when this header changes, and then include it in
prog_tests/uprobe_autoattach.c and progs/test_uprobe_autoattach.c
to fix silent assertion skips.

Here are the test results on LoongArch (default FUNC_REG_ARG_CNT
is 5).

Before:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  #659     uprobe_autoattach:OK

After:
  $ sudo ./test_progs -v -t uprobe_autoattach
  ...
  test_uprobe_autoattach:PASS:arg1 0 nsec
  test_uprobe_autoattach:PASS:arg2 0 nsec
  test_uprobe_autoattach:PASS:arg3 0 nsec
  test_uprobe_autoattach:PASS:arg4 0 nsec
  test_uprobe_autoattach:PASS:arg5 0 nsec
  #659     uprobe_autoattach:OK

Fixes: 8c2b5e90505e ("selftests/bpf: add bpf_for_each(), bpf_for(), and bpf_repeat() macros")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/Makefile.skel     |  2 ++
 tools/testing/selftests/bpf/bpf_arch_regs.h   | 29 +++++++++++++++++++
 .../bpf/prog_tests/uprobe_autoattach.c        |  1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  | 24 ---------------
 .../bpf/progs/test_uprobe_autoattach.c        |  2 +-
 5 files changed, 33 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_arch_regs.h

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 45e4ce5dca4d..ccd9565b90cf 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -149,4 +149,6 @@ $(CXX_OBJS): $(RDIR)/%.bpf.o: progs/%.cpp | $(RDIR)
 		$(BPF_CC_FLAGS) -c $< -o $@ $(call skip_on_fail,BPF)
 endif
 
+$(RDIR)/test_uprobe_autoattach.bpf.o: bpf_arch_regs.h
+
 endif # BPF_CC
diff --git a/tools/testing/selftests/bpf/bpf_arch_regs.h b/tools/testing/selftests/bpf/bpf_arch_regs.h
new file mode 100644
index 000000000000..4b5744f941bd
--- /dev/null
+++ b/tools/testing/selftests/bpf/bpf_arch_regs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_ARCH_REGS_H
+#define __BPF_ARCH_REGS_H
+
+/* How many arguments are passed to function in register */
+#if defined(__TARGET_ARCH_x86) || defined(__x86_64__)
+#define FUNC_REG_ARG_CNT 6
+#elif defined(__i386__)
+#define FUNC_REG_ARG_CNT 3
+#elif defined(__TARGET_ARCH_s390) || defined(__s390x__)
+#define FUNC_REG_ARG_CNT 5
+#elif defined(__TARGET_ARCH_arm) || defined(__arm__)
+#define FUNC_REG_ARG_CNT 4
+#elif defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_mips) || defined(__mips__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_powerpc) || defined(__powerpc__) || defined(__powerpc64__)
+#define FUNC_REG_ARG_CNT 8
+#elif defined(__TARGET_ARCH_sparc) || defined(__sparc__)
+#define FUNC_REG_ARG_CNT 6
+#elif defined(__TARGET_ARCH_riscv) || defined(__riscv__)
+#define FUNC_REG_ARG_CNT 8
+#else
+/* default to 5 for others */
+#define FUNC_REG_ARG_CNT 5
+#endif
+
+#endif /* __BPF_ARCH_REGS_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
index d5b3377aa33c..b5ea9b18ccc6 100644
--- a/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022, Oracle and/or its affiliates. */
 
 #include <test_progs.h>
+#include "bpf_arch_regs.h"
 #include "test_uprobe_autoattach.skel.h"
 
 /* uprobe attach point */
diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 6b930cb48f8d..28668ecf7e83 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -251,30 +251,6 @@
 #define SYS_PREFIX "__se_"
 #endif
 
-/* How many arguments are passed to function in register */
-#if defined(__TARGET_ARCH_x86) || defined(__x86_64__)
-#define FUNC_REG_ARG_CNT 6
-#elif defined(__i386__)
-#define FUNC_REG_ARG_CNT 3
-#elif defined(__TARGET_ARCH_s390) || defined(__s390x__)
-#define FUNC_REG_ARG_CNT 5
-#elif defined(__TARGET_ARCH_arm) || defined(__arm__)
-#define FUNC_REG_ARG_CNT 4
-#elif defined(__TARGET_ARCH_arm64) || defined(__aarch64__)
-#define FUNC_REG_ARG_CNT 8
-#elif defined(__TARGET_ARCH_mips) || defined(__mips__)
-#define FUNC_REG_ARG_CNT 8
-#elif defined(__TARGET_ARCH_powerpc) || defined(__powerpc__) || defined(__powerpc64__)
-#define FUNC_REG_ARG_CNT 8
-#elif defined(__TARGET_ARCH_sparc) || defined(__sparc__)
-#define FUNC_REG_ARG_CNT 6
-#elif defined(__TARGET_ARCH_riscv) || defined(__riscv__)
-#define FUNC_REG_ARG_CNT 8
-#else
-/* default to 5 for others */
-#define FUNC_REG_ARG_CNT 5
-#endif
-
 /* make it look to compiler like value is read and written */
 #define __sink(expr) asm volatile("" : "+g"(expr))
 
diff --git a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
index da4bf89d004c..b953f18b6b7d 100644
--- a/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
+++ b/tools/testing/selftests/bpf/progs/test_uprobe_autoattach.c
@@ -6,7 +6,7 @@
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
+#include "bpf_arch_regs.h"
 
 int uprobe_byname_parm1 = 0;
 int uprobe_byname_ran = 0;
-- 
2.42.0

