Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A233B6CC
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739598; cv=none; b=AJuZRbPtpwXL7zhTFuLaO7C7mL3irXmIj8RkkGl5sKoYq8jTtmSYiCQlxZvytW3lind1/Amm/IYUSpoZFswdN9SHLGgUe0q14n+e595TlOfwYaREA1I0CiyKhL7BFoHY4gZiqVRsyMbfYs3kkU4jGkKpEozbzmFtcgu7I/leEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739598; c=relaxed/simple;
	bh=38Al/pILaNFhJmrh80Z+1V1PnmEh2JH0LKNhY4ZkOBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9dIrBuyCvyIE7WeDrgq0U/3kB/wYJ2ewXoC+XVwrzA/67oUCHN4rk57YDmY4XWIKXk5xV9bXHFOWapTvJSyrLVM6GiIjlDA84fK9xGVuaPOn6WHGSJnR45j+kV/HS2pWC2nO3Irb+aO+cXCbjS3yweCC8KmHwND25HD0Nm90YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vesvK8tI; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vesvK8tI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=38Al/pILaNFhJmrh80Z+1V1PnmEh2JH0LKNhY4ZkOBQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786739594; v=1; x=1787344394;
 b=vesvK8tIsjJiQ5N6KcDwFMvJUpDWcsr5wpfi/6a0QcSLRBHfZxUjZ2CCzEZVW+twfe48oglc
 AfrLLeg9msibwk8Wk7cmj4p8fFBg6wVEmFqtZ3x7df/NwE4FYvVzOD93C1lakX6u83YXhR0NnRq
 8Q8Zu63HrFrtpeyTh6AdLR2A=
X-Envelope-To: bpf@vger.kernel.org
Received: from gvineet-fedora-PF5JGVFY.thefacebook.com (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 09c91c324fd420df;
	Fri, 14 Aug 2026 20:33:14 +0000
X-Migadu-Flow: FLOW_OUT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	x86@kernel.org,
	stable@vger.kernel.org,
	Vineet Gupta <vineet.gupta@linux.dev>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Check per-CPU address resolution per register
Date: Fri, 14 Aug 2026 13:32:48 -0700
Message-ID: <20260814203248.3714536-3-vineet.gupta@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814203248.3714536-1-vineet.gupta@linux.dev>
References: <20260814203248.3714536-1-vineet.gupta@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
reuses the same register, so which register the address lands in
decides how the JIT encodes the add. Getting the REX prefix wrong there
is invisible to a functional test on x86 unless the address happens to
land in an extended register, which is why this went unnoticed.

Add one __naked program per extended register, R5, R7, R8 and R9, each
loading a .percpu variable into that register, and match the JITed add
against the register it must resolve into. R1 is covered too, so that a
fix which sets REX.R unconditionally does not pass either.

Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_percpu_addr.c          | 114 ++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_percpu_addr.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8113fea7ba86..64ac49ad67e6 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -79,6 +79,7 @@
 #include "verifier_netfilter_retcode.skel.h"
 #include "verifier_bpf_fastcall.skel.h"
 #include "verifier_or_jmp32_k.skel.h"
+#include "verifier_percpu_addr.skel.h"
 #include "verifier_precision.skel.h"
 #include "verifier_prevent_map_lookup.skel.h"
 #include "verifier_private_stack.skel.h"
@@ -240,6 +241,7 @@ void test_verifier_netfilter_ctx(void)        { RUN(verifier_netfilter_ctx); }
 void test_verifier_netfilter_retcode(void)    { RUN(verifier_netfilter_retcode); }
 void test_verifier_bpf_fastcall(void)         { RUN(verifier_bpf_fastcall); }
 void test_verifier_or_jmp32_k(void)           { RUN(verifier_or_jmp32_k); }
+void test_verifier_percpu_addr(void)          { RUN(verifier_percpu_addr); }
 void test_verifier_precision(void)            { RUN(verifier_precision); }
 void test_verifier_prevent_map_lookup(void)   { RUN(verifier_prevent_map_lookup); }
 void test_verifier_private_stack(void)        { RUN(verifier_private_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
new file mode 100644
index 000000000000..962faea8ef90
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+int percpu_data SEC(".percpu");
+
+#if defined(__TARGET_ARCH_x86)
+
+/*
+ * An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
+ * reuses the same register, so the register the address lands in decides how
+ * the JIT encodes the add. On x86 R5, R7, R8 and R9 are the extended
+ * registers, whose high bit needs REX.R because the destination sits in
+ * ModRM.reg. Check one program per extended register, since getting the
+ * prefix wrong resolves the address into whichever register shares the low
+ * three bits instead.
+ */
+
+SEC("raw_tp")
+__description("per-CPU address into r5")
+__success
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %r8")
+__naked void percpu_addr_into_r5(void)
+{
+	asm volatile ("					\
+	r5 = %[percpu_data] ll;				\
+	r0 = *(u32 *)(r5 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("per-CPU address into r7")
+__success
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %r13")
+__naked void percpu_addr_into_r7(void)
+{
+	asm volatile ("					\
+	r7 = %[percpu_data] ll;				\
+	r0 = *(u32 *)(r7 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("per-CPU address into r8")
+__success
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %r14")
+__naked void percpu_addr_into_r8(void)
+{
+	asm volatile ("					\
+	r8 = %[percpu_data] ll;				\
+	r0 = *(u32 *)(r8 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+SEC("raw_tp")
+__description("per-CPU address into r9")
+__success
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %r15")
+__naked void percpu_addr_into_r9(void)
+{
+	asm volatile ("					\
+	r9 = %[percpu_data] ll;				\
+	r0 = *(u32 *)(r9 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+/* A register that needs no REX.R, to catch a fix that overcorrects. */
+SEC("raw_tp")
+__description("per-CPU address into r1")
+__success
+__arch_x86_64
+__jited("	addq	%gs:{{.*}}, %rdi")
+__naked void percpu_addr_into_r1(void)
+{
+	asm volatile ("					\
+	r1 = %[percpu_data] ll;				\
+	r0 = *(u32 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(percpu_data)
+	: __clobber_all);
+}
+
+#else
+
+SEC("raw_tp")
+__description("percpu addr dummy")
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
2.53.0-Meta

