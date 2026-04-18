Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE603346BE
	for <bpf@vger.kernel.org>; Sat, 18 Apr 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776518211; cv=none; b=u71YbreaZCt+Tl3L59MeNR8UwKaI50hkqtphc16TY2/Sh9DgKEkTsNItrkHkO2fUp/FjJjvdi11i3BLWC/Fc2+nKzQ9mHUsLcU3J7i/3QNO3CF+Vmj/Tn5cE4Kkf6QM40WHQGCPL4tsAVr+oEii9s6Nv5jWuuGwR9bf9RbRePRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776518211; c=relaxed/simple;
	bh=vtUu+jHe7HnSzhZlRslaEdtDC+J15c9BV92Q0gNry5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfBrqEyfTfxv4LmdGjxh+dS2d8vKZ+Rdh0fd69JvdTzuIHZWn8R+/dHLWGYu/I9W+9DR6Qv4266GyTne/4GWFVkdzi05OlMU4Aci6s0jJSAP192QWMdnCXDUDWMyHDQQBGs9F3GiaJoT0lTV1MN96SD9OUuslrpvaGATMiNasdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAnh73D0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAnh73D0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A63C19424;
	Sat, 18 Apr 2026 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776518210;
	bh=vtUu+jHe7HnSzhZlRslaEdtDC+J15c9BV92Q0gNry5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lAnh73D066Z9cKjlSpw3Mx9qafbKYJLB822+WbBK/dlFnyNJfOl1giOcnYxg8vwVn
	 TF0wvp2KGYyBdOMbsDILcCJEXGmgdmnpiSyz3w+Ze0+lLDS8M+5+gDXaUSjcc8NRdg
	 noOO0pBwdRaZBY7qpO/Ie6zHuQF1Mf8RSFDlsaahwFy5H9brjBwIxGS2WBsP45D4Pb
	 N8/Nb8IdPkRVxhI7yDCa4Gn+7PouusLsMATQrRreyRyRhA6FjCpbGKLDbQMx5rKUJ1
	 AVtEUTLYrDM32if2wBnoiNTXR2xyXiN7kVBWAw/Ix0B1ok7s56y4801IaMm7K4gfsE
	 iKy7mAfCnOoyQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	kernel-team@meta.com,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH bpf-next v13 4/6] selftests/bpf: add selftest to check bpf_get_cpu_time_counter jit
Date: Sat, 18 Apr 2026 06:16:02 -0700
Message-ID: <20260418131614.1501848-5-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418131614.1501848-1-puranjay@kernel.org>
References: <20260418131614.1501848-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vadim Fedorenko <vadfed@meta.com>

bpf_get_cpu_time_counter() is replaced with rdtsc instruction on x86_64.
Add tests to check that JIT works as expected. When JIT is not
supported, bpf_cpu_time_counter_to_ns() can be inlined by verifier.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_cpu_cycles.c | 120 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index a96b25ebff23..775fe69b0948 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -116,6 +116,7 @@
 #include "verifier_bits_iter.skel.h"
 #include "verifier_lsm.skel.h"
 #include "verifier_jit_inline.skel.h"
+#include "verifier_cpu_cycles.skel.h"
 #include "irq.skel.h"
 #include "verifier_ctx_ptr_param.skel.h"
 
@@ -265,6 +266,7 @@ void test_irq(void)			      { RUN(irq); }
 void test_verifier_mtu(void)		      { RUN(verifier_mtu); }
 void test_verifier_jit_inline(void)               { RUN(verifier_jit_inline); }
 void test_verifier_ctx_ptr_param(void)       { RUN(verifier_ctx_ptr_param); }
+void test_verifier_cpu_cycles(void)	      { RUN(verifier_cpu_cycles); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
new file mode 100644
index 000000000000..26c02010ccf1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_cpu_cycles.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Inc. */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+extern u64 bpf_cpu_time_counter_to_ns(u64 cycles) __weak __ksym;
+extern u64 bpf_get_cpu_time_counter(void) __weak __ksym;
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: call kernel-function")
+__naked int bpf_rdtsc(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+/* save RDX in R11 as it will be overwritten */
+__jited("	movq	%rdx, %r11")
+/* lfence may not be executed depending on cpu features */
+__jited("	{{(lfence|)}}")
+__jited("	rdtsc")
+/* combine EDX:EAX into RAX */
+__jited("	shlq	${{(32|0x20)}}, %rdx")
+__jited("	orq	%rdx, %rax")
+/* restore RDX from R11 */
+__jited("	movq	%r11, %rdx")
+__jited("	leave")
+__naked int bpf_rdtsc_jit_x86_64(void)
+{
+	asm volatile(
+	"call %[bpf_get_cpu_time_counter];"
+	"exit"
+	:
+	: __imm(bpf_get_cpu_time_counter)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_arm64
+__xlated("0: r1 = 42")
+__xlated("1: r0 = r1")
+__naked int bpf_cyc2ns_arm(void)
+{
+	asm volatile(
+	"r1=0x2a;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+__xlated("0: r1 = 42")
+__xlated("1: call kernel-function")
+__naked int bpf_cyc2ns(void)
+{
+	asm volatile(
+	"r1=0x2a;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+SEC("syscall")
+__arch_x86_64
+/* program entry for bpf_rdtsc_jit_x86_64(), regular function prologue */
+__jited("	endbr64")
+__jited("	nopl	(%rax,%rax)")
+__jited("	nopl	(%rax)")
+__jited("	pushq	%rbp")
+__jited("	movq	%rsp, %rbp")
+__jited("	endbr64")
+/* save RDX in R11 as it will be overwritten */
+__jited("	movabsq	$0x2a2a2a2a2a, %rdi")
+__jited("	imulq	${{.*}}, %rdi, %rax")
+__jited("	shrq	${{.*}}, %rax")
+__jited("	leave")
+__naked int bpf_cyc2ns_jit_x86(void)
+{
+	asm volatile(
+	"r1=0x2a2a2a2a2a ll;"
+	"call %[bpf_cpu_time_counter_to_ns];"
+	"exit"
+	:
+	: __imm(bpf_cpu_time_counter_to_ns)
+	: __clobber_all
+	);
+}
+
+void rdtsc(void)
+{
+	bpf_get_cpu_time_counter();
+	bpf_cpu_time_counter_to_ns(42);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.52.0

