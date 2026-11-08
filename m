Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.133.104.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166127;
	b=Cv9CoLL5pfZRjLuV3968BMcjX8Fdqi2giBnhJ69Zl7wDOzgW+QmglO/9GEScyAud1YLJ
	 ckeX1nt3BF72YufSsWH2ooLVd0ETu93dAkqtSfvAizF5v7vMZpwFvK3b8XUpGi5tFecKc
	 vHQWs6M2ExYdyTjGdGjRqOXTvsxkiB2YzVE2UkVvyMuo9MhJ+r0I/hvi9wAfUpmqk+7QC
	 uk2aIE4FcYUFdKqcB4KD0z+587sp+Is2w0hvaWhgQg/PlVCLe+DMGamhxRECPFK+yHQc9
	 H+jBFLpME2p3Pe9loNG58FrAx68/z7RfisCkkVDqjOtTps+9ftx8M5L3fz8+zZ4cFwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166127;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Virus-Scanned;
	bh=Z1NoO9DPHj1vRM5H1QU+J5V/JovmwvsET8QtS8CNb+w=;
	b=epymAeU6aWPEANRX0ZeLSLRdPuCiyXDvaQUnhiclq33UsYVWXbHFxS5Z4/llm+wkh6Uq
	 KXkmvdYs5/G9jxadDES6Kjp4KjqK8LlsgWAOpiXkQTnP3FPg0lUTy5Car3H2fSCK24XZ5
	 6XwvmnU8pm78DeBFX8sZ7ZlyITlirfENs1AgI7tTLhRc6eCQ+nu5gU3YjZ4CSnIaLVaIV
	 rvltnN7zbv/ilui9bWdHS4KstKYy1my4BI7NjpQUNxSwN4/uQ+ynyv40MvxdCQpOoQcV4
	 G5Vn4gZkWlf+agqqNZYr0RO35hVZzGik52UpbVMrf9+EXXOSO3hpULmsTbbcFb/qezQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=iogearbox.net;
	spf=pass smtp.mailfrom=iogearbox.net;
	dkim=pass header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=pbaQzx1x;
	arc=none smtp.remote-ip=213.133.104.62
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200CF606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 19:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 200CF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.a=rsa-sha256 header.s=default2302 header.b=pbaQzx1x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Z1NoO9DPHj1vRM5H1QU+J5V/JovmwvsET8QtS8CNb+w=; b=pbaQzx1xWIWldZmwD0UnlBNMkx
	dshZgQ8Z6rA7M/gN82RPYWlZ9P/fmAwZFhsWQW0q0H3SAAQMo/FTdvXx3h2kkRl6j+gOntD5dGTre
	F2QeZn5jMaOfXeYq3/q9dkeYhumm18w/eft2mKIa7K47fEeL3r5nuci9UXFoFaMK0uGSgpH8tvFMw
	ZcDeLoIYazMG7aRxBezEBwGQSWty4+kEOraEGVNa0IuE0I07CAMw1k237PRmTcG0I/DFquCAYcd4u
	6py+U1a4po0XTivEx+86OCrKF9tw4MPuONTW+OqZPqtHt0L43EDB1CBv2oS4S9NrMH+E2yTZS4fof
	az8O8o5Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xQ8ZI-000PuT-2v;
	Sun, 08 Nov 2026 20:28:45 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: puranjay@kernel.org,
	memxor@gmail.com,
	xukuohai@huaweicloud.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 23/24] selftests/bpf: Test the verifier's division by constants
Date: Sun,  8 Nov 2026 20:26:49 +0100
Message-ID: <0317dbcd31c9a13584bafe9583885abadfab5579.1794165614.git.daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794165614.git.daniel@iogearbox.net>
References: <cover.1794165614.git.daniel@iogearbox.net>
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
X-Virus-Scanned: Clear (ClamAV 1.4.6/28177/Sun Nov  8 07:23:52 2026)

On the JITs that support UHMUL and SHMUL, check the uhmul and shmul
sequences that the verifier rewrites 64-bit divisions by a constant
into, one test per sequence shape, and the modulos that keep the
division. The results of the rewritten sequences are checked by
jit_insns' div_const.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_div_const.c  | 225 ++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_div_const.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 0db43480cd99..4d77b8fd4eab 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -55,6 +55,7 @@
 #include "verifier_direct_packet_access.skel.h"
 #include "verifier_direct_stack_access_wraparound.skel.h"
 #include "verifier_div0.skel.h"
+#include "verifier_div_const.skel.h"
 #include "verifier_div_mod_bounds.skel.h"
 #include "verifier_div_overflow.skel.h"
 #include "verifier_flow_keys.skel.h"
@@ -263,6 +264,7 @@ void test_verifier_default_trusted_ptr(void)  { RUN_TESTS(verifier_default_trust
 void test_verifier_direct_packet_access(void) { RUN(verifier_direct_packet_access); }
 void test_verifier_direct_stack_access_wraparound(void) { RUN(verifier_direct_stack_access_wraparound); }
 void test_verifier_div0(void)                 { RUN(verifier_div0); }
+void test_verifier_div_const(void)            { RUN(verifier_div_const); }
 void test_verifier_div_mod_bounds(void)       { RUN(verifier_div_mod_bounds); }
 void test_verifier_div_overflow(void)         { RUN(verifier_div_overflow); }
 void test_verifier_flow_keys(void)            { RUN(verifier_flow_keys); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_div_const.c b/tools/testing/selftests/bpf/progs/verifier_div_const.c
new file mode 100644
index 000000000000..9601776ca2f7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_div_const.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+/* BPF_REG_AX as the verifier dumps it */
+#define REG_AX "r13"
+
+/* JITs with UHMUL and SHMUL get the multiplication by the magic number */
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || \
+	(defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64)) && \
+	(__clang_major__ >= 18 || defined(__BPF_FEATURE_SDIV_SMOD))
+
+SEC("socket")
+__description("udiv by 1000000000 shifts the dividend first")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: r0 >>= 9")
+__xlated("2: " REG_AX " = 0x44b82fa09b5a53")
+__xlated("4: r0 uh*= " REG_AX)
+__xlated("5: r0 >>= 11")
+__xlated("6: exit")
+__naked void udiv_shifted(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 /= 1000000000;				\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("udiv by 1000000")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x431bde82d7b634db")
+__xlated("3: r0 uh*= " REG_AX)
+__xlated("4: r0 >>= 18")
+__xlated("5: exit")
+__naked void udiv(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 /= 1000000;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("udiv by 7 takes the add sequence")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x2492492492492493")
+__xlated("3: " REG_AX " uh*= r0")
+__xlated("4: r0 -= " REG_AX)
+__xlated("5: r0 >>= 1")
+__xlated("6: r0 += " REG_AX)
+__xlated("7: r0 >>= 2")
+__xlated("8: exit")
+__naked void udiv_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 /= 7;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("umod by 1000000")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x431bde82d7b634db")
+__xlated("3: " REG_AX " uh*= r0")
+__xlated("4: " REG_AX " >>= 18")
+__xlated("5: " REG_AX " *= 1000000")
+__xlated("6: r0 -= " REG_AX)
+__xlated("7: exit")
+__naked void umod(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 %%= 1000000;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("umod by 1000 keeps the division")
+__success
+__xlated("...")
+__xlated("1: r0 %= 1000")
+__xlated("2: exit")
+__naked void umod_kept(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 %%= 1000;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sdiv by 10")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x6666666666666667")
+__xlated("3: " REG_AX " sh*= r0")
+__xlated("4: " REG_AX " s>>= 2")
+__xlated("5: r0 = " REG_AX)
+__xlated("6: r0 >>= 63")
+__xlated("7: r0 += " REG_AX)
+__xlated("8: exit")
+__naked void sdiv(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 s/= 10;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sdiv by 2 adds the dividend")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x8000000000000001")
+__xlated("3: " REG_AX " sh*= r0")
+__xlated("4: " REG_AX " += r0")
+__xlated("5: r0 = " REG_AX)
+__xlated("6: r0 >>= 63")
+__xlated("7: r0 += " REG_AX)
+__xlated("8: exit")
+__naked void sdiv_add(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 s/= 2;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("sdiv by -3 subtracts the dividend")
+__success
+__arch_x86_64 __arch_arm64 __arch_riscv64
+__load_if_JITed()
+__xlated("...")
+__xlated("1: " REG_AX " = 0x5555555555555555")
+__xlated("3: " REG_AX " sh*= r0")
+__xlated("4: " REG_AX " -= r0")
+__xlated("5: " REG_AX " s>>= 1")
+__xlated("6: r0 = " REG_AX)
+__xlated("7: r0 >>= 63")
+__xlated("8: r0 += " REG_AX)
+__xlated("9: exit")
+__naked void sdiv_sub(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 s/= -3;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("smod by 10 keeps the division")
+__success
+__xlated("...")
+__xlated("1: r0 s%= 10")
+__xlated("2: exit")
+__naked void smod_kept(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 s%%= 10;					\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+#else
+
+SEC("socket")
+__description("UHMUL/SHMUL or cpuv4 not supported, use a dummy test")
+__skip("UHMUL/SHMUL or cpuv4 not supported")
+__success
+int dummy_test(void)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0

