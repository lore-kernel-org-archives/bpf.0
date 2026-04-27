Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0E3AD515
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 23:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777333709; cv=none; b=q9JkcGHqZPn29vsyPwNDQEKax/jYHYtXr2basNrEywJJEqTqGYDUsb2A60CPZ8gzNqnvGSGtDziEmIGOCLjeQnmnI0OZUBeuVgdT9W+dytA6XpIGMTRWL0DftScxyJ9i65qXgbBnNTMNftJeemTQJ9bYkBTCoQCDZDczd+Xjgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777333709; c=relaxed/simple;
	bh=4qgD8NXIgP60g2ZgfZ0Qni9zzpAN5k22pYvDGRANGqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR1jLlA933y6EPW2mnDh+Av6sDEc+nJsHAOINtv+4wp4z+Bb0RmW6uA/FWLl8TRvQJ1CTW4T+5Y37dWKfkBIxK9UhQKKb3qcqE7kit1FbjuaOR0/pIQs8nOd7ZkraAFwUMt3sBIJjMTxImbzAx2UNVS57z5AiekAdUGclky3i6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRIBfYrh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRIBfYrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784F4C2BCB6;
	Mon, 27 Apr 2026 23:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777333709;
	bh=4qgD8NXIgP60g2ZgfZ0Qni9zzpAN5k22pYvDGRANGqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRIBfYrhSGTarGaNCzsZQTCCrKM1S7CB/q0pOPP8XvVIX51lg1R+7LSeoI33hCPJY
	 cfydGXEPNXiFNl2gzjeYatIjhhKI4muArXYxrLzGB2ighjZa1D+2ALiHw9Q495B2Z0
	 nfFxaHiUbFOChi+bKvaEDCj8t4dvCXXsBc2NOQz6rzAKMKlxGvPJga6ZT8ZFWkaLM5
	 KOtrFWCPXcVBogNSMiYugRiIR242WZRz7o1rZp1BbM6zkLTw6tHmzDWn1ThN/+9yrg
	 MLbS1yiwE6rLjtGV70OyZa0vrou+mfRM5yLiEjuEw6scnnjOgrYOS5hVsHGKLxrnpv
	 ISQkGkbOUO8Ew==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org,
	"Yonghong Song" <yonghong.song@linux.dev>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Xu Kuohai" <xukuohai@huaweicloud.com>,
	"Catalin Marinas" <catalin.marinas@arm.com>,
	"Will Deacon" <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: Enable stack argument tests for arm64
Date: Mon, 27 Apr 2026 16:48:00 -0700
Message-ID: <20260427234801.2104511-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427234801.2104511-1-puranjay@kernel.org>
References: <20260427234801.2104511-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that arm64 supports stack arguments, enable the existing stack_arg,
stack_arg_kfunc and verifier_stack_arg tests for __TARGET_ARCH_arm64.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg.c                | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg_kfunc.c          | 3 ++-
 tools/testing/selftests/bpf/progs/stack_arg_precision.c      | 3 ++-
 tools/testing/selftests/bpf/progs/verifier_stack_arg.c       | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
index 296fddfe6804..8d38aafe66a2 100644
--- a/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/btf__stack_arg_precision.c
@@ -4,7 +4,8 @@
 #include <bpf/bpf_helpers.h>
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 long subprog_call_mem_kfunc(long a, long b, long c, long d, long e, long size)
 {
diff --git a/tools/testing/selftests/bpf/progs/stack_arg.c b/tools/testing/selftests/bpf/progs/stack_arg.c
index ab6240b997c5..b5e9929a4d63 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg.c
@@ -21,7 +21,8 @@ struct {
 
 int timer_result;
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
 
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
index fa9def876ea5..da0d4f91d273 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_kfunc.c
@@ -6,7 +6,8 @@
 #include "bpf_kfuncs.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 const volatile bool has_stack_arg = true;
 
diff --git a/tools/testing/selftests/bpf/progs/stack_arg_precision.c b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
index 29b2f2aea931..460d1872a84c 100644
--- a/tools/testing/selftests/bpf/progs/stack_arg_precision.c
+++ b/tools/testing/selftests/bpf/progs/stack_arg_precision.c
@@ -6,7 +6,8 @@
 #include "../test_kmods/bpf_testmod_kfunc.h"
 #include "bpf_misc.h"
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 /* Force kfunc extern BTF generation for inline asm call below.
  * Uses its own SEC so it's not included as a .text subprog.
diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index 6b596ad63774..b412c311b757 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -12,7 +12,8 @@ struct {
 	__type(value, long long);
 } map_hash_8b SEC(".maps");
 
-#if defined(__TARGET_ARCH_x86) && defined(__BPF_FEATURE_STACK_ARGUMENT)
+#if (defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)) && \
+	defined(__BPF_FEATURE_STACK_ARGUMENT)
 
 __noinline __used
 static int subprog_6args(int a, int b, int c, int d, int e, int f)
-- 
2.52.0

