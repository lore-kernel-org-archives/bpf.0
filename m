Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8682933BBCD;
	Wed, 12 Aug 2026 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786515348; cv=none; b=oc+mFYgUKHi1PRjhe2NtT/psxdCdorGZcjPFeIpW281CGme25N1yJHMPuxt0Fm9aTPYBpmSZokSdUxcvg86G8UdllCM90c0Vag73uMgiW8nUxVatC7AGFTiLkNHFjLXvDjiDwly9w+uKp7FPRGekP6Cbi1fGABHiwOEKvTeTHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786515348; c=relaxed/simple;
	bh=nDP6paJ4yvOeTTQPjHq36gISLz9LC0poCyeiCB53Nmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vf4OxvH7qnQWiPPohYX71NC3yPOVfkarATlCtfP7G6Jpk6yFkRnSeYgimZA8mLU6fQfjXUY5jAaIH6RmjhBFW0TuA967xEBt4qO1pejr/wlLpP6CA30C73j4xTw2cpPZWgy6GX6632/DoTZS+mdxDybNCTwTvJ7LK1Z4KCe4SFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3c831c9e961511f1aa26b74ffac11d73-20260812
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2bbef95c-6341-4781-af19-6359c394f5c3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:e5acc5ddddb0ed177903b3cf65272e0a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3c831c9e961511f1aa26b74ffac11d73-20260812
X-User: jiangfeng@kylinos.cn
Received: from [127.0.0.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <jiangfeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 763689697; Wed, 12 Aug 2026 14:15:37 +0800
From: Feng Jiang <jiangfeng@kylinos.cn>
Date: Wed, 12 Aug 2026 06:15:33 +0000
Subject: [bpf-next PATCH 2/2] selftests/bpf: Enable stack argument tests
 for riscv
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-bpf-riscv-stack-args-v1-2-67b246806e59@kylinos.cn>
References: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
In-Reply-To: <20260812-bpf-riscv-stack-args-v1-0-67b246806e59@kylinos.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, Feng Jiang <jiangfeng@kylinos.cn>
X-Mailer: b4 0.14.3

Add __TARGET_ARCH_riscv to the architecture guard in all stack
argument selftests so the real test cases are compiled for RISC-V.

Keep the __BPF_FEATURE_STACK_ARGUMENT gate, defined by clang with
BPF stack argument support [1].

[1] https://github.com/llvm/llvm-project/pull/189060

Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>
---
 tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c      | 2 +-
 tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c | 2 +-
 tools/testing/selftests/bpf/progs/exceptions.c                    | 2 +-
 tools/testing/selftests/bpf/progs/stack_arg.c                     | 2 +-
 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c               | 2 +-
 tools/testing/selftests/bpf/progs/stack_arg_precision.c           | 2 +-
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c            | 2 +-
 tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
index 8d38aafe66a2..c8540d30e293 100644
--- a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
@@ -4,7 +4,7 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long size)
diff --git a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
index 99bc115f8380..d1c382693fed 100644
--- a/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/btf__verifier_stack_arg_order.c
@@ -3,7 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 int subprog_bad_order_6args(int a, int b, int c, int d, int e, int f)
diff --git a/tools/testing/selftests/bpf/progs/exceptions.c b/tools/testing/selftests/bpf/progs/exceptions.c
index c8d716fbd419..dc5d422a82a5 100644
--- a/tools/testing/selftests/bpf/progs/exceptions.c
+++ b/tools/testing/selftests/bpf/progs/exceptions.c
@@ -379,7 +379,7 @@ int exception_bad_assert_range_with(struct __sk_buff *ctx)
 	return 1;
 }
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) \
 	&& defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
index 944e3bb603e7..8ba4991bbabd 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -21,7 +21,7 @@ struct {
 
 int timer_result;
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
index 345f2da2e361..6a22255fcaa7 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -6,7 +6,7 @@
 #include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index bee2eeec021d..cffa0dfb6f52 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -6,7 +6,7 @@
 #include "../test_kmods/bpf_testmod_kfunc.h"
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 /* Force kfunc extern BTF generation for inline asm call below.
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 7e0ce5db28a0..b2a724a2790e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -12,7 +12,7 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 __noinline __used
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
index c9fe4857da3f..ed260041d827 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg_order.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
-#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_riscv)) && \
 	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 __noinline __used __naked

-- 
2.53.0

