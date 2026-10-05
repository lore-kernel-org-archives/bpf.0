Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFF4A092D
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210164; cv=none; b=CyLMD7Ii8KC8B0Q8PPZsJkAh+ILwanTQ7zAbXy6NEhT0YNbnegHGTT+hNV6pClqZaA6nLNsBIoKQRSQRR9SihYkscLOinUG7egy4Mm7PwA5sURuaLM+19OqxXyu38azgJg+opXDZZEDq3BjlvKJv9YKhKIn7xP6dPhnf3q1LOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210164; c=relaxed/simple;
	bh=At363QlKvyLYE2nGLYQwG3CRGYFTuUUCSrxaswjwRCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EM/RSGL8Mqdy/IqQ8rUFMlEBkVGf1kZT+HL0ad3495qPDgi1XS4N5PVpXLA75aO7TUhxssfNuCRbkDEqEYyOm+wFhDgVLujrGVNDl0TO4d9bll/2IliPOGyhiDpAanSnMhI8OULf2WE08UmcGFBR7RobOTYjg8srqn0UWR+cQRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb+5IUhK; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb+5IUhK"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso955309f8f.2
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791210150; x=1791814950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuTHseKMpjlRmTdYLMIfTT9GWgnURCxzCnJaQz5UrpY=;
        b=Xb+5IUhKYOC4QKPxcvaXWRyU6UsyalpojDcZk/eMy80WGSS8kQACRtpxUX12Bc13D1
         6Rc/ELqBGbitNOY9jIEr30vXMa+AKgOhJA59yNWWi4v0tQoRpJU8xVzHAj9ZpwyxPVdJ
         IX1/cxIgsiIflCFeD5Kb7Ih37NvRD8Lk7ZQ3AERqIttDORvIeBFh7yHe/KxeXUlhQzYR
         IdPrES8K+cLCDQEEwWLZtVz+ncHzcbFPCXHCxpl3g807KP7QoNmB4falA0CKC8fxpy4S
         irYkpyOB+BWdaP4dMo6vWBtYLg/5kBKLnvb/0bXP2FR2+OYAj6N97pxRLUaGqm8bFZko
         iviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791210150; x=1791814950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zuTHseKMpjlRmTdYLMIfTT9GWgnURCxzCnJaQz5UrpY=;
        b=2zU/Q73I/IfD2c50WJ15mPgXISsg+bHgtgzmRS+y3ZCsRXFMR6m8fH3lJcc06vZwkb
         h0K8U9rH0s/xpM3k8xiFdGAELO/hetOsEH5knXPh/t58ka0o/49ggdKjGzLe9YmUn9dw
         xe2g+4G3BzH44mH1MsG+4Kz6YWCZeOMWOC9J2kBnnd1jWzluk159ZWfafo17PQto9VIC
         +hxqPbTGVQyunBv31Z+ps4KYawPXw6tOakdkJU627Orro1XiI+zLmIDCJmw9sNA8LMEh
         Up8cpiMbctgWP+7vSp6BAdh0VQ6f/jlijwBsWHvOD7i1U/Rmjax7kQgrt0Wik9PVpC1Z
         wWJg==
X-Gm-Message-State: AFq9FYKLpQBXCpVps09wb7wQs1cTbq1SiQ0JSbceoii9H3uyxkCMd0y2
	T2Fmp/4Qmh8D0+d7wTfwcDUS5g6hhPOtb867HOIbCJuUDm1jsxLWZYSshUlGLBFXsEDSf3ZA
X-Gm-Gg: AYBFou04oNsNIiMkPvL5Cwq6cW9nrEM5jouij4a8WkQgjOu8OLAqGXKOaUb4WYnO81b
	HPkqK0M82GvXNMrQ667JBozFNMlMhYCS++s2KcXjJ5CJKNgbunegeQYzh/vJ/2Vb9KRNavAeJjs
	0m4IpySFUG1n3NHpwcEj+cBFWE9fPuvLAalYezODks+NtfB7ZRnDJp6MaENV+PL4f1hIv4l3wlR
	c4+VpH+stXfd6n2IoAGOle6cPfOCi3HNOMdyJ3oGUTsgH0tIoOoPEXJemAgdPK8njVwxIH3/tBo
	QTzWfYY93uCDd7+tfpzMRFKggnZnwOMnFMFc3Yk3s0YAlroARrEfUNrWCnn0UfBJTX+pLHgUnfm
	LM/1Ab1is6jBgh7BEQPA5D/xRBkxyUce7LWuVMGZ6UdBxIXG2TL8QVKYyY1T1OONLykk2qHDbCn
	yALDJHzBnyaXcJqc8Wsfdlpeb8UQ9AIvIctddqExjRk+8VkBMsD0/IKee/1zQfqR9cUADjCNDJG
	JdvP54HGR/tuFL0gMHMST0/3tFScQ5MO6FcKwaESaRePBx37GXcaw0gxfjb9OTzL+KfHZ3ZtX7M
	jPPtIUnjmP9fel3y9+6p52O99srWEuLQulfmM3cPEi8feaDb
X-Received: by 2002:a05:6000:61b:b0:48a:fc9d:fbba with SMTP id ffacd0b85a97d-48b126f15e8mr20156055f8f.1.1791210149794;
        Mon, 05 Oct 2026 07:22:29 -0700 (PDT)
Received: from macbook (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622ab5a1sm3881623f8f.36.2026.10.05.07.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:22:29 -0700 (PDT)
From: Yusheng Zheng <yunwei356@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Hao Sun <sunhao.th@gmail.com>,
	Yusheng Zheng <yunwei356@gmail.com>
Subject: [RFC PATCH bpf-next 6/7] selftests/bpf: Test inline kfuncs
Date: Mon,  5 Oct 2026 07:22:18 -0700
Message-ID: <20261005142219.33451-7-yunwei356@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20261005142219.33451-1-yunwei356@gmail.com>
References: <20261005142219.33451-1-yunwei356@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

verifier_kfunc_inline checks:
  - the x86-64 native code of each kfunc with a body, emitted or
    copied, and the binding of operands;
  - the precision of results, the register effects at the entry and
    exit of the body, constant arguments and a prefetch through a
    scalar;
  - kfuncs with a body from a module: with native code from the module,
    copied, kept for a division, and rejected in a program type that
    may not call them;
  - that the kfuncs agree with plain BPF on random inputs.

bpf_test_kfunc_body.ko checks that registration rejects bad bodies. The
config enables CONFIG_BPF_INSN_KFUNCS.

Assisted-by: LLM
Signed-off-by: Yusheng Zheng <yunwei356@gmail.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +-
 tools/testing/selftests/bpf/config            |   1 +
 .../bpf/prog_tests/kfunc_body_registration.c  |  18 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_kfunc_inline.c         | 543 ++++++++++++++++++
 .../testing/selftests/bpf/test_kmods/Makefile |   2 +-
 .../bpf/test_kmods/bpf_test_kfunc_body.c      | 121 ++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  77 +++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |   4 +
 9 files changed, 768 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_body_registration.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_inline.c
 create mode 100644 tools/testing/selftests/bpf/test_kmods/bpf_test_kfunc_body.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a22be7efd1fa2..7a5dd7fcd3d14 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -48,7 +48,7 @@ TEST_PROGS_EXTENDED := \
 	ima_setup.sh verify_sig_setup.sh
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_test_kfunc_body.ko
 TEST_KMOD_TARGETS = $(addprefix $(OUTPUT)/,$(TEST_KMODS))
 
 # Compile but not part of 'make run_tests'
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 2b883b388f90c..abc4e79d42a01 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -3,6 +3,7 @@ CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
 CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=1
 CONFIG_BPF=y
 CONFIG_BPF_EVENTS=y
+CONFIG_BPF_INSN_KFUNCS=y
 CONFIG_BPF_JIT=y
 CONFIG_BPF_KPROBE_OVERRIDE=y
 CONFIG_BPF_LIRC_MODE2=y
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_body_registration.c b/tools/testing/selftests/bpf/prog_tests/kfunc_body_registration.c
new file mode 100644
index 0000000000000..3aa1f614b508e
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_body_registration.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <testing_helpers.h>
+
+/* bpf_test_kfunc_body.ko fails to load unless bad kfunc bodies are rejected */
+void test_kfunc_body_registration(void)
+{
+	int fd, err;
+
+	fd = open("bpf_test_kfunc_body.ko", O_RDONLY);
+	if (!ASSERT_GE(fd, 0, "open"))
+		return;
+	err = finit_module(fd, "", 0);
+	close(fd);
+	if (!ASSERT_OK(err, "finit_module"))
+		return;
+	ASSERT_OK(delete_module("bpf_test_kfunc_body", 0), "delete_module");
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 460ad10ddc020..ad7baf3afa248 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -60,6 +60,7 @@
 #include "verifier_iterating_callbacks.skel.h"
 #include "verifier_jeq_infer_not_null.skel.h"
 #include "verifier_jit_convergence.skel.h"
+#include "verifier_kfunc_inline.skel.h"
 #include "verifier_kfunc_packet_access.skel.h"
 #include "verifier_kfunc_uninit.skel.h"
 #include "verifier_kfunc_uninit_multi.skel.h"
@@ -245,6 +246,7 @@ void test_verifier_int_ptr(void)              { RUN(verifier_int_ptr); }
 void test_verifier_iterating_callbacks(void)  { RUN(verifier_iterating_callbacks); }
 void test_verifier_jeq_infer_not_null(void)   { RUN(verifier_jeq_infer_not_null); }
 void test_verifier_jit_convergence(void)      { RUN(verifier_jit_convergence); }
+void test_verifier_kfunc_inline(void)         { RUN_TESTS(verifier_kfunc_inline); }
 void test_verifier_kfunc_packet_access(void)  { RUN_TESTS(verifier_kfunc_packet_access); }
 void test_verifier_kfunc_uninit(void)         { RUN_TESTS(verifier_kfunc_uninit); }
 void test_verifier_kfunc_uninit_multi(void)   { RUN_TESTS(verifier_kfunc_uninit_multi); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_inline.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_inline.c
new file mode 100644
index 0000000000000..b525e7cf7a0f4
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_inline.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../test_kmods/bpf_testmod_kfunc.h"
+
+extern u64 bpf_rol64(u64 x, u32 n) __ksym;
+extern u64 bpf_select64(u64 cond, u64 a, u64 b) __ksym;
+extern u64 bpf_extract64(u64 x, u32 start, u32 len) __ksym;
+extern u64 bpf_load_be64(const void *p, s32 off) __ksym;
+extern void bpf_prefetch(const void *p) __ksym;
+extern void bpf_copy16(void *dst, const void *src) __ksym;
+extern u64 bpf_lea64(u64 base, u64 index, u32 scale, s32 disp) __ksym;
+
+/* r6 = rol(r6, 13) is one rol, the moves around the call go away */
+SEC("tc")
+__success __retval(8192)
+__xlated("0: r6 = 1")
+__xlated("1: call")
+__xlated("2: r0 = r6")
+__arch_x86_64
+__jited("{{.*}}movl\t$0x1, %ebx")
+__jited("{{.*}}rolq\t$0xd, %rbx")
+__jited("{{.*}}movq\t%rbx, %rax")
+__naked void inline_rol64_in_place(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"r1 = r6;"
+	"r2 = 13;"
+	"call %[bpf_rol64];"
+	"r6 = r0;"
+	"r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_rol64)
+	: __clobber_all);
+}
+
+/* r7 = rol(r6, 8) keeps r6 */
+SEC("tc")
+__success __retval(255)
+__arch_x86_64
+__jited("{{.*}}{{rorxq\t\\$0x38, %rdi, %r13|rolq\t\\$0x8, %r13}}")
+__naked void inline_rol64_copy(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"r1 = r6;"
+	"r2 = 8;"
+	"call %[bpf_rol64];"
+	"r7 = r0;"
+	"r0 = r7;"
+	"r0 -= r6;"
+	"exit;"
+	:
+	: __imm(bpf_rol64)
+	: __clobber_all);
+}
+
+/* a 32-bit move of the constant goes away as well */
+SEC("tc")
+__success __retval(16)
+__xlated("1: call")
+__arch_x86_64
+__jited("{{.*}}rolq\t$0x4, %rbx")
+__naked void inline_rol_w2(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"r1 = r6;"
+	"w2 = 4;"
+	"call %[bpf_rol64];"
+	"r6 = r0;"
+	"r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_rol64)
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __retval(42)
+__arch_x86_64
+__jited("{{.*}}testq\t%rbx, %rbx")
+__jited("{{.*}}movq\t%r14, %r15")
+__jited("{{.*}}cmovneq\t%r13, %r15")
+__naked void inline_select(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"r7 = 42;"
+	"r8 = 7;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"r3 = r8;"
+	"call %[bpf_select64];"
+	"r9 = r0;"
+	"r0 = r9;"
+	"exit;"
+	:
+	: __imm(bpf_select64)
+	: __clobber_all);
+}
+
+/* r9 = r6 ? r7 : r9 is a test and a cmov */
+SEC("tc")
+__success __retval(7)
+__arch_x86_64
+__jited("{{.*}}testq\t%rbx, %rbx")
+__jited("{{.*}}cmovneq\t%r13, %r15")
+__naked void inline_select_in_place(void)
+{
+	asm volatile (
+	"r6 = 0;"
+	"r7 = 42;"
+	"r9 = 7;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"r3 = r9;"
+	"call %[bpf_select64];"
+	"r9 = r0;"
+	"r0 = r9;"
+	"exit;"
+	:
+	: __imm(bpf_select64)
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0x56)
+__arch_x86_64
+__jited("{{.*}}{{bextrq\t%r13, %rbx, %r13|shlq\t%cl, %rbx}}")
+__naked void inline_extract(void)
+{
+	asm volatile (
+	"r6 = 0x12345678;"
+	"r1 = r6;"
+	"r2 = 8;"
+	"r3 = 8;"
+	"call %[bpf_extract64];"
+	"r7 = r0;"
+	"r0 = r7;"
+	"exit;"
+	:
+	: __imm(bpf_extract64)
+	: __clobber_all);
+}
+
+/* the bytes 01..08 on the stack, read as big endian */
+SEC("tc")
+__success __retval(0x05060708)
+__arch_x86_64
+__jited("{{.*}}{{movbeq\t\\(%rbx\\), %rax|bswapq\t%rax}}")
+__naked void inline_load_be64(void)
+{
+	asm volatile (
+	"*(u32 *)(r10 - 8) = 0x04030201;"
+	"*(u32 *)(r10 - 4) = 0x08070605;"
+	"r6 = r10;"
+	"r6 += -8;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_load_be64];"
+	"exit;"
+	:
+	: __imm(bpf_load_be64)
+	: __clobber_all);
+}
+
+SEC("tc")
+__success __retval(0)
+__arch_x86_64
+__jited("{{.*}}prefetcht0\t{{.*}}%r13)")
+__naked void inline_prefetch(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r7 = r10;"
+	"r7 += -8;"
+	"r1 = r7;"
+	"call %[bpf_prefetch];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_prefetch)
+	: __clobber_all);
+}
+
+/* the instructions of a prefetch load, so the address must be readable */
+SEC("tc")
+__failure __msg("R1 invalid mem access 'scalar'")
+__naked void inline_prefetch_scalar(void)
+{
+	asm volatile (
+	"r1 = 0;"
+	"call %[bpf_prefetch];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_prefetch)
+	: __clobber_all);
+}
+
+/* copy 16 bytes from fp-16 to fp-32: the JIT copies the compiled kfunc */
+SEC("tc")
+__success __retval(0x22)
+__arch_x86_64
+__xlated("6: call")
+__jited("{{.*}}movq\t(%r13), %{{.*}}")
+__naked void inline_copy16(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 16) = 0x11;"
+	"*(u64 *)(r10 - 8) = 0x22;"
+	"r6 = r10;"
+	"r6 += -32;"
+	"r7 = r10;"
+	"r7 += -16;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"call %[bpf_copy16];"
+	"r0 = *(u64 *)(r10 - 24);"
+	"exit;"
+	:
+	: __imm(bpf_copy16)
+	: __clobber_all);
+}
+
+/* the verifier checks the memory that the copy touches */
+SEC("tc")
+__failure __msg("off=0 size=8")
+__naked void inline_copy16_out_of_bounds(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_copy16];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm(bpf_copy16)
+	: __clobber_all);
+}
+
+/* 100 + 3 * 4 + 16 */
+SEC("tc")
+__success __retval(128)
+__arch_x86_64
+__jited("{{.*}}leaq\t0x10(%rbx,%r13,4), %r14")
+__naked void inline_lea(void)
+{
+	asm volatile (
+	"r6 = 100;"
+	"r7 = 3;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"r3 = 4;"
+	"r4 = 16;"
+	"call %[bpf_lea64];"
+	"r8 = r0;"
+	"r0 = r8;"
+	"exit;"
+	:
+	: __imm(bpf_lea64)
+	: __clobber_all);
+}
+
+/* the instructions bound the result, a call would not */
+SEC("tc")
+__success __retval(0)
+__naked void inline_precision(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = r0;"
+	"r2 = 0;"
+	"r3 = 3;"
+	"call %[bpf_extract64];"
+	"r6 = r10;"
+	"r6 += -8;"
+	"r6 += r0;"
+	"r0 = 0;"
+	"*(u8 *)(r6 + 0) = r0;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm(bpf_extract64)
+	: __clobber_all);
+}
+
+/* arguments cannot be read after the instructions, as after a call */
+SEC("tc")
+__failure __msg("R1 !read_ok")
+__naked void inline_clobber(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"r2 = 42;"
+	"r3 = 7;"
+	"call %[bpf_select64];"
+	"r0 = r1;"
+	"exit;"
+	:
+	: __imm(bpf_select64)
+	: __clobber_all);
+}
+
+/* a kfunc that returns nothing leaves R0 unreadable after its body */
+SEC("tc")
+__failure __msg("R0 !read_ok")
+__naked void inline_void_r0(void)
+{
+	asm volatile (
+	"r1 = r10;"
+	"r1 += -8;"
+	"call %[bpf_prefetch];"
+	"exit;"
+	:
+	: __imm(bpf_prefetch)
+	: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("R2 must be a known constant")
+__naked void inline_not_constant(void)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r1 = 1;"
+	"r2 = r0;"
+	"call %[bpf_rol64];"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32), __imm(bpf_rol64)
+	: __clobber_all);
+}
+
+/* r1 = r6 is skipped by a jump, so it must stay */
+SEC("tc")
+__success __retval(42)
+__naked void inline_bind_jump(void)
+{
+	asm volatile (
+	"r9 = *(u32 *)(r1 + %[len]);"
+	"r6 = 0;"
+	"r7 = 42;"
+	"r8 = 7;"
+	"r1 = 1;"
+	"if r9 != 0 goto l0_%=;"
+	"r1 = r6;"
+"l0_%=:"
+	"r2 = r7;"
+	"r3 = r8;"
+	"call %[bpf_select64];"
+	"exit;"
+	:
+	: __imm(bpf_select64),
+	  __imm_const(len, offsetof(struct __sk_buff, len))
+	: __clobber_all);
+}
+
+#if __clang_major__ >= 18 || defined(__BPF_FEATURE_MOVSX)
+/* a sign-extending move is not a plain copy of R6 */
+SEC("tc")
+__success __retval(7)
+__naked void inline_bind_movsx(void)
+{
+	asm volatile (
+	"r6 = 0x100;"
+	"r7 = 42;"
+	"r8 = 7;"
+	"r1 = (s8)r6;"
+	"r2 = r7;"
+	"r3 = r8;"
+	"call %[bpf_select64];"
+	"exit;"
+	:
+	: __imm(bpf_select64)
+	: __clobber_all);
+}
+#endif
+
+/* the result takes the register of the condition */
+SEC("tc")
+__success __retval(42)
+__naked void inline_bind_shared(void)
+{
+	asm volatile (
+	"r6 = 1;"
+	"r7 = 42;"
+	"r8 = 7;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"r3 = r8;"
+	"call %[bpf_select64];"
+	"r6 = r0;"
+	"r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_select64)
+	: __clobber_all);
+}
+
+/* native code from a module, with the result in the register of an argument */
+SEC("tc")
+__success __retval(6)
+__arch_x86_64
+__xlated("2: call")
+__jited("{{.*}}xorq\t%r13, %rbx")
+__naked void inline_module(void)
+{
+	asm volatile (
+	"r6 = 5;"
+	"r7 = 3;"
+	"r1 = r6;"
+	"r2 = r7;"
+	"call %[bpf_testmod_inline_xor];"
+	"r6 = r0;"
+	"r0 = r6;"
+	"exit;"
+	:
+	: __imm(bpf_testmod_inline_xor)
+	: __clobber_all);
+}
+
+/* without emit, the JIT copies the compiled kfunc, with the registers bound */
+SEC("tc")
+__success __retval(5)
+__arch_x86_64
+__xlated("1: call")
+__jited("{{.*}}movq\t%rbx, %r13")
+__naked void inline_copy(void)
+{
+	asm volatile (
+	"r6 = 5;"
+	"r1 = r6;"
+	"call %[bpf_testmod_inline_mov];"
+	"r7 = r0;"
+	"r0 = r7;"
+	"exit;"
+	:
+	: __imm(bpf_testmod_inline_mov)
+	: __clobber_all);
+}
+
+/* compiled code that branches or divides is not copied: the instructions stay */
+SEC("tc")
+__success __retval(0)
+__xlated("{{.*}}r0 /= r2")
+__naked void inline_copy_div(void)
+{
+	asm volatile (
+	"r1 = 9;"
+	"r2 = 0;"
+	"call %[bpf_testmod_inline_div];"
+	"exit;"
+	:
+	: __imm(bpf_testmod_inline_div)
+	: __clobber_all);
+}
+
+/* a kfunc that the program may not call keeps its call, which is rejected */
+SEC("xdp")
+__failure __msg("calling kernel function bpf_testmod_inline_mov is not allowed")
+__naked void inline_not_allowed(void)
+{
+	asm volatile (
+	"r1 = 1;"
+	"call %[bpf_testmod_inline_mov];"
+	"exit;"
+	:
+	: __imm(bpf_testmod_inline_mov)
+	: __clobber_all);
+}
+
+#define ROL(x, n) ((x) << ((n) & 63) | (x) >> (-(n) & 63))
+
+struct diff_state {
+	u64 bad;
+	u8 src[64], dst[64];
+};
+
+static u64 rand64(void)
+{
+	return (u64)bpf_get_prandom_u32() << 32 | bpf_get_prandom_u32();
+}
+
+/* a global function, so that the verifier checks it once and not per call */
+__noinline int diff_step(struct diff_state *s)
+{
+	u64 x = rand64(), y = rand64(), a = rand64(), b = rand64();
+	int i;
+
+	if (!s)
+		return 0;
+	s->bad |= (bpf_rol64(x, 1) ^ ROL(x, 1)) | (bpf_rol64(x, 13) ^ ROL(x, 13)) |
+		  (bpf_rol64(x, 63) ^ ROL(x, 63)) | (bpf_rol64(x, 64) ^ x);
+	s->bad |= bpf_select64(x & 1, a, b) ^ (x & 1 ? a : b);
+	s->bad |= bpf_extract64(x, 0, 64) ^ x;
+	s->bad |= bpf_extract64(x, 13, 7) ^ (x >> 13 & 0x7f);
+	s->bad |= bpf_extract64(x, 40, 24) ^ (x >> 40);
+	s->bad |= bpf_extract64(x, 63, 1) ^ (x >> 63);
+	s->bad |= bpf_lea64(x, y, 8, -12345) ^ (x + y * 8 - 12345);
+	for (i = 0; i < 8; i++) {
+		s->src[i] = x >> (8 * i);
+		s->src[8 + i] = y >> (8 * i);
+	}
+	s->bad |= bpf_load_be64(s->src, 0) ^ __builtin_bswap64(x);
+	s->bad |= bpf_load_be64(s->src + 16, -8) ^ __builtin_bswap64(y);
+	/* unaligned */
+	s->bad |= bpf_load_be64(s->src + 8, -7) ^ __builtin_bswap64(x >> 8 | y << 56);
+	bpf_copy16(s->dst + 8, s->src);
+	for (i = 0; i < 16; i++)
+		s->bad |= s->dst[8 + i] ^ s->src[i];
+	return 0;
+}
+
+/* native code and the instructions agree on random inputs */
+SEC("tc")
+__success __retval(0)
+int inline_differential(struct __sk_buff *skb)
+{
+	struct diff_state s = {};
+	int i;
+
+	for (i = 0; i < 256; i++)
+		diff_step(&s);
+	return s.bad != 0;
+}
+
+/* emits BTF for the kfuncs that only inline assembly calls */
+void __kfunc_btf_root(void)
+{
+	bpf_prefetch(0);
+	bpf_testmod_inline_mov(0);
+	bpf_testmod_inline_xor(0, 0);
+	bpf_testmod_inline_div(0, 0);
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
index 031c7454ce65f..1800a0cd7a771 100644
--- a/tools/testing/selftests/bpf/test_kmods/Makefile
+++ b/tools/testing/selftests/bpf/test_kmods/Makefile
@@ -19,7 +19,7 @@ Q = @
 endif
 
 MODULES = bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
-	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
+	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko bpf_test_kfunc_body.ko
 
 $(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
 
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_test_kfunc_body.c b/tools/testing/selftests/bpf/test_kmods/bpf_test_kfunc_body.c
new file mode 100644
index 0000000000000..2149bbd683381
--- /dev/null
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_test_kfunc_body.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+struct bpf_test_kfunc_body_pair {
+	u64 a, b;
+};
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc u64 bpf_test_kfunc_body(u64 x)
+{
+	return x;
+}
+
+__bpf_kfunc u64 bpf_test_kfunc_body_unset(u64 x)
+{
+	return x;
+}
+
+__bpf_kfunc u64 bpf_test_kfunc_body_pair(struct bpf_test_kfunc_body_pair p)
+{
+	return p.a;
+}
+
+__bpf_kfunc u64 bpf_test_kfunc_body_sleepable(u64 x)
+{
+	return x;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(test_body_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_test_kfunc_body)
+BTF_KFUNCS_END(test_body_kfunc_ids)
+
+/* never registered */
+BTF_KFUNCS_START(test_body_bad_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_test_kfunc_body_pair)
+BTF_ID_FLAGS(func, bpf_test_kfunc_body_sleepable, KF_SLEEPABLE)
+BTF_KFUNCS_END(test_body_bad_kfunc_ids)
+
+BTF_ID_LIST(test_body_ids)
+BTF_ID(func, bpf_test_kfunc_body)
+BTF_ID(func, bpf_test_kfunc_body_unset)
+BTF_ID(func, bpf_test_kfunc_body_pair)
+BTF_ID(func, bpf_test_kfunc_body_sleepable)
+
+static const struct bpf_insn test_body_insns[] = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+};
+
+/* writes R6 */
+static const struct bpf_insn test_body_bad_insns[] = {
+	BPF_MOV64_REG(BPF_REG_6, BPF_REG_1),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+};
+
+/* jumps past the last instruction */
+static const struct bpf_insn test_body_jump_insns[] = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
+	BPF_MOV64_IMM(BPF_REG_0, 0),
+};
+
+static struct bpf_kfunc_body test_body = { .id = &test_body_ids[0] };
+
+static struct btf_kfunc_id_set test_body_set = {
+	.owner = THIS_MODULE,
+	.set = &test_body_kfunc_ids,
+	.bodies = &test_body,
+	.body_cnt = 1,
+};
+
+static int test_body_rejected(struct btf_id_set8 *set, const u32 *id,
+			      const struct bpf_insn *insns, u32 len)
+{
+	test_body_set.set = set;
+	test_body.id = id;
+	test_body.insns = insns;
+	test_body.len = len;
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &test_body_set) == -EINVAL;
+}
+
+/*
+ * The module loads only if registration rejects a body without instructions,
+ * one with an instruction that writes R6, one with a jump past its last
+ * instruction, one for a kfunc outside the set, one with an argument of two
+ * registers and one for a kfunc with flags.
+ */
+static int bpf_test_kfunc_body_init(void)
+{
+	struct btf_id_set8 *good = &test_body_kfunc_ids, *bad = &test_body_bad_kfunc_ids;
+
+	if (!test_body_rejected(good, &test_body_ids[0], NULL, 0) ||
+	    !test_body_rejected(good, &test_body_ids[0], test_body_bad_insns,
+				ARRAY_SIZE(test_body_bad_insns)) ||
+	    !test_body_rejected(good, &test_body_ids[0], test_body_jump_insns,
+				ARRAY_SIZE(test_body_jump_insns)) ||
+	    !test_body_rejected(good, &test_body_ids[1], test_body_insns, 1) ||
+	    !test_body_rejected(bad, &test_body_ids[2], test_body_insns, 1) ||
+	    !test_body_rejected(bad, &test_body_ids[3], test_body_insns, 1))
+		return -EINVAL;
+	test_body_set.set = good;
+	test_body.id = &test_body_ids[0];
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &test_body_set);
+}
+
+static void bpf_test_kfunc_body_exit(void)
+{
+}
+
+module_init(bpf_test_kfunc_body_init);
+module_exit(bpf_test_kfunc_body_exit);
+
+MODULE_DESCRIPTION("BPF kfunc body registration test module");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 93847ca6293b4..13d5abe249d25 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -931,6 +931,78 @@ BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
 BTF_ID(func, bpf_testmod_ctx_release_dtor)
 
+/*
+ * Kfuncs with a body, in a set that XDP programs may not use: the JIT copies
+ * the first, the second has native code from this module, and the third,
+ * which divides, keeps its body.
+ */
+__bpf_kfunc u64 bpf_testmod_inline_mov(u64 x)
+{
+	return x;
+}
+
+__bpf_kfunc u64 bpf_testmod_inline_xor(u64 a, u64 b)
+{
+	return a ^ b;
+}
+
+__bpf_kfunc u64 bpf_testmod_inline_div(u64 a, u64 b)
+{
+	return b ? a / b : 0;
+}
+
+BTF_ID_LIST(bpf_testmod_body_ids)
+BTF_ID(func, bpf_testmod_inline_mov)
+BTF_ID(func, bpf_testmod_inline_xor)
+BTF_ID(func, bpf_testmod_inline_div)
+
+static const struct bpf_insn mov_body[] = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+};
+
+static const struct bpf_insn xor_body[] = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_REG(BPF_XOR, BPF_REG_0, BPF_REG_2),
+};
+
+static const struct bpf_insn div_body[] = {
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
+	BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_2),
+};
+
+#ifdef CONFIG_X86_64
+/* op %src, %dst on 64-bit registers */
+static u8 *x86_op(u8 *p, u8 op, u8 src, u8 dst)
+{
+	*p++ = 0x48 | (src & 8 ? 4 : 0) | (dst & 8 ? 1 : 0);
+	*p++ = op;
+	*p++ = 0xc0 | (src & 7) << 3 | (dst & 7);
+	return p;
+}
+
+/* the result can take the register of an argument, which a copy cannot */
+static int xor_emit(const u8 *reg, const s32 *imm, u8 *buf)
+{
+	u8 dst = reg[0], a = reg[1], b = reg[2], *p = buf;
+
+	if (dst == b)
+		swap(a, b);
+	if (dst != a)
+		p = x86_op(p, 0x89, a, dst);	/* mov %a, %dst */
+	return x86_op(p, 0x31, b, dst) - buf;	/* xor %b, %dst */
+}
+#else
+#define xor_emit	NULL
+#endif
+
+#define BODY(i, op, emit)	{ &bpf_testmod_body_ids[i], op##_body, ARRAY_SIZE(op##_body), emit }
+
+static const struct bpf_kfunc_body bpf_testmod_bodies[] = {
+	BODY(0, mov, NULL),
+	BODY(1, xor, xor_emit),
+	BODY(2, div, NULL),
+};
+
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_testmod_common_kfunc_ids,
@@ -1827,6 +1899,9 @@ BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
 BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
+BTF_ID_FLAGS(func, bpf_testmod_inline_mov)
+BTF_ID_FLAGS(func, bpf_testmod_inline_xor)
+BTF_ID_FLAGS(func, bpf_testmod_inline_div)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
 static int bpf_testmod_ops_init(struct btf *btf)
@@ -1861,6 +1936,8 @@ static int bpf_testmod_ops_init_member(const struct btf_type *t,
 static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_testmod_check_kfunc_ids,
+	.bodies = bpf_testmod_bodies,
+	.body_cnt = ARRAY_SIZE(bpf_testmod_bodies),
 };
 
 static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 67c02a421d133..2a55f1b145b42 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -357,4 +357,8 @@ void bpf_testmod_test_hardirq_fn(void);
 void bpf_testmod_test_softirq_fn(void);
 void bpf_kfunc_trigger_ctx_check(void) __ksym;
 
+u64 bpf_testmod_inline_mov(u64 x) __ksym;
+u64 bpf_testmod_inline_xor(u64 a, u64 b) __ksym;
+u64 bpf_testmod_inline_div(u64 a, u64 b) __ksym;
+
 #endif /* _BPF_TESTMOD_KFUNC_H */
-- 
2.51.1

