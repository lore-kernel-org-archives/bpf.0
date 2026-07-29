Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF5477E33;
	Wed, 29 Jul 2026 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338331; cv=none; b=YmxdfwWWNi65Rfq6iIu56V5KuEjAyYz3KGMcaBn2dXr5rVFmZ2/K63sMizV0eqCvw/Ab9tfwK0bUw2ABn6D3hYzKHMY0G2rrwuSFIrzjEg+fCYR0rR1bVY73Pr5grop8+CzRhFeLC/T4imwUOtvo1BT8OsWCmnn7kb5hoxFIS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338331; c=relaxed/simple;
	bh=Nx6OIizraZlOmxAWOwRcuceZeeyLkRPjbVHH7Gn4TAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tk6nBjDuUZb/5vX+L0IGLnzOkAnF/4Iqak0RUsMCzR3tuOttwAVwoEE2Fvi8SalPxh14JzwQV8uuWyubwsGkQVDG5sDZXM+IEHPkYFnQELhc3N/qBO6ixjzrKL5y8GKzQmL6ckJzPMQHyW0z2mYJCTnB8q5ypKZwWa67qpXnFBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD56ejda; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD56ejda"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82702C2BCFD;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785338330;
	bh=Nx6OIizraZlOmxAWOwRcuceZeeyLkRPjbVHH7Gn4TAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nD56ejdauvUMoPfxiAdq/8w/Q9QIqzEdAlKSuLn/zFgDBGpsE5zmwSM5IjW3wc/nN
	 keNoEOSC1H1qtTh4qgqkjl9zTgZRaB3btgGGA32DKOy7oo+ueAutAxP7cYfUzl7EjQ
	 7O5bOar6g3Px/BBSWIl/kPCDYO16NDiJJMLHEbVMZrm6H8Vbg4MOvS3IItgY1mmPcw
	 299t09Uy+MiKqM8axnTmUhTonTlLU6txfhhyL/YbASr7UiGx9NsMte1vjMhU/63HNF
	 yNx/tYieNOsxuOXJ8d5aOgs3zkBaRdfw8jmqW8gy8RwR78gbjCqjyKHH8s7wKawf8v
	 3NWQtb0Yip9ZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746BC54FD2;
	Wed, 29 Jul 2026 15:18:50 +0000 (UTC)
From: Yiyang Chen via B4 Relay <devnull+chenyy23.mails.tsinghua.edu.cn@kernel.org>
Date: Wed, 29 Jul 2026 15:18:30 +0000
Subject: [PATCH bpf v4 4/4] selftests/bpf: Cover commuted pointer state
 propagation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-c3-035-public-bpf-v4-v4-4-8ee297e2346b@mails.tsinghua.edu.cn>
References: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
In-Reply-To: <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Wade <danjwade95@gmail.com>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785338329; l=3991;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=tfUvyuKi1Ys9RlS8/axJkWdbpqzVGWdZXEMU4sF7MBw=;
 b=VTR+t/a6HrwDiKqltgDeJuxnQX+kCxRgAoiwBJyMHCtTjRUxbAugUapXIo9+A2Mrooo6B8gzJ
 DnC/MDc7JAtCUwINc1Kuz8bD/qX6NEa5MD56igOR4NtRZJCO1uWJ+Sm
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-Endpoint-Received: by B4 Relay for chenyy23@mails.tsinghua.edu.cn/kernel
 with auth_id=900
X-Original-From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Reply-To: chenyy23@mails.tsinghua.edu.cn

From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

Add verifier coverage for the three cases affected by preserving the full
pointer state across scalar += pointer: stack frame number inheritance,
readonly-untrusted memory access, and dynptr data-slice invalidation.

Tested-by: Daniel Wade <danjwade95@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 30 ++++++++++++++++
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     | 17 +++++++++
 .../selftests/bpf/progs/verifier_basic_stack.c     | 41 ++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 344fb2aa0813d..29c6361d8820a 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1635,6 +1635,36 @@ static int callback(__u32 index, void *data)
         return 0;
 }
 
+/* A commuted add should preserve the parent id of a dynptr data slice. */
+SEC("?raw_tp")
+__failure __msg("invalid mem access 'scalar'")
+int dynptr_slice_commuted_invalidate(void *ctx)
+{
+	struct bpf_dynptr ptr;
+	__u32 *slice, *derived;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(__u32), 0, &ptr);
+
+	slice = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!slice)
+		goto done;
+
+	asm volatile ("%[dst] = 0;"
+		"%[dst] += %[src];"
+		"%[src] = 0;"
+		: [dst]"=&r"(derived), [src]"+r"(slice)
+		:
+		: "memory");
+
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	val = *derived;
+	return 0;
+
+done:
+	bpf_ringbuf_discard_dynptr(&ptr, 0);
+	return 0;
+}
+
 /* If the dynptr is written into in a callback function, its data
  * slices should be invalidated as well.
  */
diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 5b4453747c230..f166fff8f2176 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -226,4 +226,21 @@ int null_check(void *ctx)
 	return 0;
 }
 
+SEC("socket")
+__success
+__retval(1)
+int ldx_is_ok_commuted_addr(void *ctx)
+{
+	int v, *p, *derived;
+
+	v = 1;
+	p = bpf_rdonly_cast(&v, 0);
+	asm volatile ("%[dst] = 0;"
+		"%[dst] += %[src];"
+		: [dst]"=&r"(derived)
+		: [src]"r"(p)
+		: "memory");
+	return *derived;
+}
+
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
index fb62e09f21146..d3df7a9f1d8c8 100644
--- a/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_basic_stack.c
@@ -97,4 +97,45 @@ __naked void misaligned_read_from_stack(void)
 "	::: __clobber_all);
 }
 
+SEC("socket")
+__description("stack pointer arithmetic preserves frame number")
+__failure __msg("R7 invalid mem access 'scalar'")
+__naked void stack_ptr_arith_preserves_frameno(void)
+{
+	asm volatile ("\
+		r3 = 0;						\
+		*(u64 *)(r10 - 8) = r3;			\
+		r1 = %[map_hash_8b] ll;			\
+		r2 = r10;					\
+		r2 += -8;					\
+		call %[bpf_map_lookup_elem];		\
+		if r0 != 0 goto +2;			\
+		r0 = 0;						\
+		exit;						\
+		r1 = r0;					\
+		r2 = 0;						\
+		r3 = 0;						\
+		call stack_ptr_arith_preserves_frameno_subprog;\
+		r0 = 0;						\
+		exit;						\
+	":
+	: __imm(bpf_map_lookup_elem),
+	  __imm_addr(map_hash_8b)
+	: __clobber_all);
+}
+
+static __used __naked void stack_ptr_arith_preserves_frameno_subprog(void)
+{
+	asm volatile ("\
+		*(u64 *)(r10 - 8) = r1;			\
+		r6 = -8;					\
+		r6 += r10;					\
+		*(u64 *)(r6 + 0) = r2;			\
+		r7 = *(u64 *)(r10 - 8);			\
+		*(u64 *)(r7 + 0) = r3;			\
+		r0 = 0;						\
+		exit;						\
+	"::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


