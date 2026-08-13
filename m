Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AB441D4F4
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647874; cv=none; b=baSr7PanSoh8gTCdvSVfP1uHUSJ52wjuVdlwdQWwsSwu4yFxhXO0AwiIoFdqRpNWyo5Dt0+Myts5HNZfk1L8u0uGOrvrdIHdDqPBlYxgagZ5jZdb/TL0n28bsMm/mNW1bRuwxM/UL/sd8gVso9227EGjQ9YwZJfkqa7w56bX08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647874; c=relaxed/simple;
	bh=JFeTjoHu/J5aIdzXipxjYrvrqq8GSmnQDocc7tdaFbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+M4rjghz/CAnNJdhcEtOwkAqXVIfjkemHE4jkZ4zpOvRXjtm2Bb22Zcrwpzc/317wTgJKwXfWfIfi/9xxfKNDYxhb1oUNP5WIbI4GTXtGC/ccPBVLxjYGo0jPDcHBw94zZElpjGj5adrcz244k3GkuWX1aFo0lyXQEquGZ5o+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yu/Fvas3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yu/Fvas3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DADD1F000E9;
	Thu, 13 Aug 2026 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647872;
	bh=3JHn0+9Qqg4VhS4+rN1rVVtRiWVVkCnSB43CEoOrEx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yu/Fvas3cXFnhACLSqjYEubO5Bg9T6aRUw+/cVIIVPJDaJqc0d8v80gTApffzakJK
	 rlQMr9efBaUVaW32xfxpux/o0c9urz4IBS1uQS41ayNn9hm4RdfwiB5V7m4yYc8OCt
	 1gknw1qTZSAcbuX1W3RrQNy/IR++VysJ6MdrwylKBlcKTJqbIjrNXvq9XnTZ8F/r0k
	 SUHAF0c4KCSoazxYv1SK6uPseumr11qlLMyPttEnWL+cAdaBiaW6h+ouNofhsNPgdT
	 iBk4BFghI+H2+9kA/K0SJZOzfeW7RNkiP9aOl1OaPPkePX6FnXCopiYY1vE8gOTnLJ
	 nVM48Re1Tct3A==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH bpf-next v2 5/7] selftests/bpf: Add arm64 JIT-sequence tests for __arena kfunc arguments
Date: Thu, 13 Aug 2026 12:03:52 -0700
Message-ID: <20260813190356.335181-6-puranjay@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813190356.335181-1-puranjay@kernel.org>
References: <20260813190356.335181-1-puranjay@kernel.org>
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
Acked-by: Xu Kuohai <xukuohai@huawei.com>
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

