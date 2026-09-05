Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859E258EE9;
	Sat,  5 Sep 2026 07:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594337; cv=none; b=H3MUhLMtZabQGTstXBMNwZ822EyO6cp6OXI1nNB9WdGnmdEKBclQaf/zteeaSxavvnkepvq6gDOqIAEPvzrbL6tdIRCXbZByAy/8LHdtDY6LR5HZZ37/QwSBHVjkgHaklxXfkKHnXdlN0RMF1OSy5cKL7Qke81tIFH0ISFB6Q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594337; c=relaxed/simple;
	bh=F8I23AU+j838hjXhl1ya9Hoh94IUJB6RgV6WyOcUdpY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IzxzQ3DAfQ5y9UhLtx7WELhw9OoMnMPQNrs/EZOTR/3Uc/eQh70Wab3bc19hB1ms1iMG1PJKhM9ee+YEMMagWwruAUtvCqhjETfvtRDSRMSDRbRPh9dwdMxCiwxDSQWcxczkI4h9yM58BFRzPO8bL6mJoDze3Ryss2Rz/t9HBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQ0j8Z/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQ0j8Z/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6531F00A3D;
	Sat,  5 Sep 2026 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788594335;
	bh=7yOxbGjvD5wE0Hp6BWVA5Rm3CoQLfyp/woX5BV7pxRk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dQ0j8Z/Xlikm1kfjAyCjsTDBJEGEqnfRe88eQVGnQeuofnhc8atPho0+xkyxlztfu
	 bNwZlfsv9iXQ649b14RT2AUFJfXQdUh/9sIruDdNyjdsLF0DjER7yEW4DJgANFzrDm
	 s26tzieG9TOc1wqFKN/FCZO0rXZYiQ80ma42Dl+BnD9bawuWVCidUETJUkjjYmrZpC
	 FIWHuYup0D89otgLZBlbfzpzGdYY9O2cBa/9QI99fw5WoKTJA0opFEb4j8+HaeTFAd
	 GBA4YUY1yz2vzwXobLfaR8K/+i9+uEXbuOtdnrgFzNBPESkYt2ykwdImL5h7up4EZV
	 JoA6i2hcg2nFQ==
Content-Type: multipart/mixed; boundary="===============0711090133430070351=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5e50a375b8cc6ff27c370db71783041b6ceebdf6a014a008bb2ecbfb2dca88ca@mail.kernel.org>
In-Reply-To: <20260905070409.4141522-4-pulehui@huaweicloud.com>
References: <20260905070409.4141522-4-pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v4 3/3] selftests/bpf: Enable stack argument tests for RV64
From: bot+bpf-ci@kernel.org
To: pulehui@huaweicloud.com,bpf@vger.kernel.org,linux-riscv@lists.infradead.org,linux-kernel@vger.kernel.org,jiangfeng@kylinos.cn
Cc: bjorn@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,puranjay@kernel.org,pjw@kernel.org,palmer@dabbelt.com,alex@ghiti.fr,pulehui@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 07:45:34 +0000 (UTC)

--===============0711090133430070351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Enable the stack argument selftests for RV64. The riscv guard is
> restricted to __riscv_xlen == 64 since stack arguments are only
> supported by the RV64 JIT.
>
> Keep the __BPF_FEATURE_STACK_ARGUMENT gate, defined by clang with
> BPF stack argument support [1].
>
> [1] https://github.com/llvm/llvm-project/pull/189060
>
> Signed-off-by: Feng Jiang <jiangfeng@kylinos.cn>

The changelog says "Enable the stack argument selftests for RV64", but
one arch-gated stack-argument test remains on x86_64/arm64 only.

Exhaustive list of every arch-gated stack-argument test in
tools/testing/selftests/bpf:

  progs/btf__stack_arg_precision.c        updated by this patch
  progs/btf__verifier_stack_arg_order.c   updated by this patch
  progs/stack_arg.c                       updated by this patch
  progs/stack_arg_kfunc.c                 updated by this patch
  progs/stack_arg_precision.c             updated by this patch
  progs/verifier_stack_arg.c              updated by this patch
  progs/verifier_stack_arg_order.c        updated by this patch
  progs/stack_arg_fail.c                  no arch gate - already runs
  progs/exceptions.c:383                  intentionally left alone
  progs/arena_kfunc.c:219-230             not updated, not explained

progs/exceptions.c is correctly left alone: DENYLIST.riscv64 lists
'exceptions' with the comment "JIT does not support exceptions", and
arch/riscv/net/ implements no bpf_jit_supports_exceptions().

progs/arena_kfunc.c is not explained. It gates its stack-argument test
with test_loader arch annotations rather than a preprocessor guard:

  #if defined(__BPF_FEATURE_ADDR_SPACE_CAST) && \
          defined(__BPF_FEATURE_STACK_ARGUMENT)
  SEC("syscall")
  __arch_x86_64
  __arch_arm64
  __failure __msg("arena pointer cannot be a stack argument")
  int arena_arg_stack(void *ctx)

test_loader.c skips any test whose arch mask does not contain the running
arch, so arena_arg_stack stays skipped on RV64 after this patch.

Does anything block it from running on RV64?  bpf_jit_supports_arena()
returns true on riscv64, DENYLIST.riscv64 contains only 'exceptions', and
arena_arg_stack is a __failure test so it only needs the verifier to reach
the "arena pointer cannot be a stack argument" check - which now happens
on RV64 because the preceding commit makes bpf_jit_supports_stack_args()
return true.

Should __arch_riscv64 be added to progs/arena_kfunc.c's arena_arg_stack
(and the #else dummy_test, which carries the same two annotations), or is
there a reason it should stay on x86_64/arm64 only?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33952202002
--===============0711090133430070351==--
