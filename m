Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE347207DF7
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598232; cv=none; b=CEgledCFuS/+BtFGC3Et6u+VJqjDxxzlAGZ33oKh4xRNvQfybialrz4tI2+VlbO4NAcWmhvXFdl5Gc65eVpyq9XXDs5NN8vPmnyIwQf2r2lkZCbJmlWIxI/l5Qoy9T+bJTF4NEUE3+1UzpRC7I5VcBirqkLtxp+jFUuYgtYSirA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598232; c=relaxed/simple;
	bh=XWFZK/e/7CsX4iMIsxwBsCGV+o44AZdAJ4gnsWag03o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YumJabb7iy+miOvzaDKZBLblvioiCUnOXNYG8vuKSsb61EoZ/Y82jdBog89xDN/EvTSiHuVbvVH8e9Z+3OC19uAPDDeJ7qbjsV88tL7A15bGW8AsncmUtdcGaQSMKwl8tO3iucqcMJpvixDAQ76slckJRYlKSHHA/buVMs0e4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gGqHBHIi; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gGqHBHIi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786598214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EYcOFy8k9Qk2cCl/jWteAJqGPNJg4JpMyMzEqhTo0Is=;
	b=gGqHBHIiKtMTOnIZQKKSlzGdfXL1nLGq1LypkigyAHxq6CRyoECql3nmpHnNLke/PIDUez
	cZCnt3Zv2makSGMZowpH2FUZzPO3vr6pSPPGmyjr4Xn2ktZ7ckhObLyc2rt7pm1UD8rac+
	E2mvjZy4vcGKUA+ub4h2kA7jz+RjtDE=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org,
	memxor@gmail.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Taegu Ha <hataegu0826@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v1] selftests/bpf: Fix insn count expectations in chained global subprogs test
Date: Thu, 13 Aug 2026 13:16:29 +0800
Message-ID: <20260813051635.121670-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The test asserts exact per-subprog insns_self/insns_total values and the
aggregate processed count, but these depend on compiler codegen. The
expected values match -mcpu=v3 output; under -mcpu=v4 clang emits a
sign-extending load in global_good() instead of a load plus two shifts,
so the subprog is verified in 3 insns instead of 5 and the test fails on
the cpuv4 flavor.

Rewrite the involved subprogs as naked functions with hand-written
instruction sequences using only v1 instructions, so the verified insn
counts no longer depend on cpu version or compiler codegen.

Fixes: c2e6c7de8830 ("bpf: Show more useful info in stack depth stats")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 .../bpf/progs/verifier_global_subprogs.c      | 56 +++++++++++++++----
 1 file changed, 45 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
index 7b65eea97ebc..3352dc177ec1 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
@@ -25,9 +25,22 @@ __noinline long global_bad(void)
 	return arr[unkn_idx]; /* BOOM */
 }
 
-__noinline long global_good(void)
+/* Insn counts asserted in chained_global_func_calls_success() depend on
+ * the exact instruction sequences of this function and its callers, so
+ * they are written in inline asm to be independent of compiler codegen.
+ */
+__naked __noinline long global_good(void)
 {
-	return arr[0];
+	/* return (long)arr[0]; 5 insns (ld_imm64 counts as one) */
+	asm volatile (
+		"r1 = %[arr] ll;"
+		"r0 = *(u32 *)(r1 + 0);"
+		"r0 <<= 32;"
+		"r0 s>>= 32;"
+		"exit;"
+		:
+		: __imm_addr(arr)
+		: __clobber_all);
 }
 
 __noinline long global_calls_bad(void)
@@ -35,9 +48,13 @@ __noinline long global_calls_bad(void)
 	return global_good() + global_bad() /* does BOOM indirectly */;
 }
 
-__noinline long global_calls_good_only(void)
+__naked __noinline long global_calls_good_only(void)
 {
-	return global_good();
+	/* return global_good(); 2 insns */
+	asm volatile (
+		"call global_good;"
+		"exit;"
+		::: __clobber_all);
 }
 
 __noinline long global_dead(void)
@@ -56,13 +73,30 @@ __msg("subprog 0 (chained_global_func_calls_success) main insns_self 7 insns_tot
 __msg("subprog {{[0-9]+}} (global_calls_good_only) global insns_self 2 insns_total 2 stack")
 __msg("subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total 5 stack")
 __msg("processed 14 insns")
-int chained_global_func_calls_success(void)
-{
-	int sum = 0;
-
-	if (call_dead_subprog)
-		sum += global_dead();
-	return global_calls_good_only() + sum;
+__naked int chained_global_func_calls_success(void)
+{
+	/* int sum = 0;
+	 * if (call_dead_subprog)
+	 *	sum += global_dead();
+	 * return global_calls_good_only() + sum;
+	 *
+	 * call_dead_subprog is known false, so 7 insns are processed:
+	 * the branch to l0 is always taken and global_dead() is dead code.
+	 */
+	asm volatile (
+		"r6 = 0;"
+		"r1 = %[call_dead_subprog] ll;"
+		"r1 = *(u8 *)(r1 + 0);"
+		"if r1 == 0 goto l0_%=;"
+		"call global_dead;"
+		"r6 = r0;"
+	"l0_%=:"
+		"call global_calls_good_only;"
+		"r0 += r6;"
+		"exit;"
+		:
+		: __imm_addr(call_dead_subprog)
+		: __clobber_all);
 }
 
 SEC("?raw_tp")
-- 
2.43.0

