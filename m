Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6503F8231
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389012; cv=none; b=GWc5OQyMMNMVxLlvEcIq5SVIoQnDzOs93FqjpFLNbY1VpgpnceGiKnYbf36i/YYvsnKenqA+t5aUxKk7BZqDMHW3KMGZXRcSJiYrUbp2zw55BWZzydWH3RN4gwErpvjK+DyOQIlqo9mrm0t8XIqdw03xMmYAZIfRYGJ5U3L2z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389012; c=relaxed/simple;
	bh=JVU0f4WAK5YxgDsdR5EzQ5FIl6UqnAiAPwvTV0u+oGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqPXroVGjrVR8yY6o9n+RrYmDynCRKbpKAYVN8WYtHPLRc6CILhX4WMpJU4YU6p/szybXgVJk67HoOovPf1t8WQyzHCEZ/uVbpVmH8306QQE0v2Gh8bvgdmylIKBea5n5sgnFphlNo4GER4DKHEjr2dtc6BBp/EZ2sgO+mVvivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXA/RMXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXA/RMXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87531F000E9;
	Mon, 10 Aug 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389008;
	bh=52oMseUG6rfDZ/2IURN898pv8iPopqJkxZN5mhQNssE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iXA/RMXZTRwYCU2SOCplYeKeWPw1Ax+CYxYs6VcKNj31TZu1DSe6fvzm7SGOeKd79
	 uzdRFd7A5fIpoSH4U5Tb5mJpUqjV6YgKdwv94rS9MLIwl/m1zkGHJjC5q36iwM5mGB
	 juvG8JgVkP145rBDDGw5phLHmmhJB9l2Mg7J5uSZetDy1jRCw1wJjh7MjHVOFgkDuB
	 EyCJzb4T3wXWjoCSt4AYMQ2sQE8rFJ0gR8bu/luR/eAWa241XKE8f1c3ze1ePtNZb7
	 ZXbxRvuRPOIb2IeJyF5oCyhOSnmlgMOi0A/4tW7X4LR1X/6qywaZBgGk26QpVFW6FP
	 a0YrZn9p1iupQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Alexei Starovoitov" <ast@kernel.org>,
	"Daniel Borkmann" <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>,
	"Martin KaFai Lau" <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>,
	"Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
	"Song Liu" <song@kernel.org>,
	"Yonghong Song" <yonghong.song@linux.dev>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH bpf-next 5/7] selftests/bpf: Add arm64 JIT-sequence tests for __arena kfunc arguments
Date: Mon, 10 Aug 2026 12:09:18 -0700
Message-ID: <20260810190922.3408757-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810190922.3408757-1-puranjay@kernel.org>
References: <20260810190922.3408757-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pin the arm64 counterparts of the x86-64 rebase sequences: the single
extended-register add for an unconditional argument, the nullable
truncate-test-and-skip variant, and all five argument registers in one
call. The nullable cases use a local label so the branch is pinned to
the instruction right after the add, and the label line does not spell
out the call because arm64 emits either a direct bl or a materialize-
and-blr pair depending on the distance to the kfunc.

Note that on arm64 an unconditional argument is one instruction with
nothing to anchor it against, so arena_arg_jit_rebase alone cannot tell
the two forms apart; it only requires that nothing is emitted between
the rebase and the call. The args5 test is what pins the distinction,
since its four consecutive adds leave no room for a nullable
truncate-and-branch pair between them.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .../selftests/bpf/progs/arena_kfunc_jit.c     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
index c9b9186626162..b5a01cbc33a73 100644
--- a/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
+++ b/tools/testing/selftests/bpf/progs/arena_kfunc_jit.c
@@ -32,6 +32,10 @@ __jited("	movl	%edi, %edi")
 __jited("	addq	%r12, %rdi")
 __jited("...")
 __jited("	callq	{{.*}}")
+__arch_arm64
+__jited("...")
+__jited("	add	x0, x28, w0, uxtw")
+__jited("	{{(bl|mov)	.*}}")
 __success
 int arena_arg_jit_rebase(void *ctx)
 {
@@ -48,6 +52,12 @@ __jited("	testl	%edi, %edi")
 __jited("	je	L0")
 __jited("	addq	%r12, %rdi")
 __jited("L0:	callq	{{.*}}")
+__arch_arm64
+__jited("...")
+__jited("	mov	w0, w0")
+__jited("	cbz	w0, L0")
+__jited("	add	x0, x28, w0, uxtw")
+__jited("L0:	{{.*}}")
 __success
 int arena_arg_jit_nullable(void *ctx)
 {
@@ -72,6 +82,16 @@ __jited("	testl	%r8d, %r8d")
 __jited("	je	L0")
 __jited("	addq	%r12, %r8")
 __jited("L0:	callq	{{.*}}")
+__arch_arm64
+__jited("...")
+__jited("	add	x0, x28, w0, uxtw")
+__jited("	add	x1, x28, w1, uxtw")
+__jited("	add	x2, x28, w2, uxtw")
+__jited("	add	x3, x28, w3, uxtw")
+__jited("	mov	w4, w4")
+__jited("	cbz	w4, L0")
+__jited("	add	x4, x28, w4, uxtw")
+__jited("L0:	{{.*}}")
 __success
 int arena_arg_jit_args5(void *ctx)
 {
-- 
2.53.0-Meta

