Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727B4CEE70
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576090; cv=none; b=CAX3mbdK1v3GJIuXW+e+7P+L+cHQupJMNa2xUx7cRX4MzDzyQMOnVKr8ry/DIwQm7WAo5aGi/7+a4O9X/rOhKtlUAKcOHYJxfDYskxz+MtLTEoDhBqRH7tnCTa0d9SCn67ZgdJ28wSI3E41b3qd9F4d05hCqny2+ThJdaKiM7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576090; c=relaxed/simple;
	bh=YlRTMhB8DqX9j8za+hEfuYCza5A2MOS4HS9Svup534w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cHXUNyiyGy8nfShPAcW99u0Zk/WZOuaATOqZF4HLdbC/Ut25r+ZRP/kxjfyQjOxdRQZeH6bScMuAbXNQBKWeq5slQ/JQ/QqM366pouzqBQYuAaefjARwD99xhpltbvxnQ66NYQTcf74r7cMZLyrbs9daMf+ywd5qaqM5iIxtCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkWGkMjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkWGkMjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F3E1F000FF;
	Wed, 16 Sep 2026 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576083;
	bh=2fm2f55xjG4/tAblsqB94vNdw1EmNWzxJzA3ED3M9X4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gkWGkMjYl/xHKfPCU6Oqg7FCKvT8ytLTWrM6nYijln4BXds3C48lRx80S7JB/AIlx
	 +9WfE0w2VIdSxjaw6OR5OpCEb0/BExUoDOgzHlIChrHGhl9cky/P2FGdl3O/kLrY8Q
	 p3qMNBU2+6Hp4FDMJijsULwWDKyDgqcw0ABViwx8Vh9Xffu3YHoAJRbDw8LfiXegWc
	 Nkgg9tA5FQRlw1Ge91VbU6Vn1E5wOAsaRq7EIk4xoITDrt/ogckn6RVzbVSoJHA4Sa
	 8FJ5ilXINf0jgDOgBo4A2NalGS/Kz1HSnHc4ERBUpuVAYWZLBvFK8z93XoUi80KADU
	 gOipq3eku1XsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Cover __uninit kfunc
 output argument slots
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916160821.3157543-6-memxor@gmail.com>
References: <20260916160821.3157543-1-memxor@gmail.com>
 <20260916160821.3157543-6-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:28:03 +0000
Message-Id: <20260916162803.99F3E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: ineffective test output_passed_on_stack for __uninit tracki=
ng
--

commit 70a455597d07423eca32cc332d11faa394e65772
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Cover __uninit kfunc output argument slots

This commit adds regression tests for the verifier's tracking of __uninit
kfunc output argument slots. It covers cases involving multiple outputs,
outputs following by-value parameters, and output pointers passed on the
stack.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_mult=
i.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c
> new file mode 100644
> index 0000000000000..b944346b35e34
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_uninit_multi.c

[ ... ]

> +#if defined(__BPF_FEATURE_STACK_ARGUMENT)
> +SEC("tc")
> +__arch_x86_64 __arch_arm64 __arch_riscv64
> +__success __retval(15)
> +__flag(BPF_F_TEST_STATE_FREQ)
> +__caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
> +__prepare_priv
> +__success_unpriv
> +__naked void output_passed_on_stack(void)
> +{
> +	asm volatile (
> +		"*(u64 *)(r10 - 8) =3D 0;"
> +		"goto +0;"

[Severity: Medium]
Does pre-initializing the output stack slot here prevent the test from
actually catching __uninit tracking regressions?

If the verifier fails to recognize the __uninit annotation, it treats the
argument as a normal pointer. Because the slot is initialized and kept alive
across the goto +0 checkpoint, the memory is tracked as STACK_ZERO. This
satisfies the BPF_READ requirement in unprivileged mode, allowing the
BPF_WRITE check to clobber the slot to STACK_MISC and verify successfully.

Should this test omit the initialization (similar to how it is done in
output_after_by_value_argument) so that a broken verifier evaluates a
BPF_READ on STACK_INVALID, forcing an expected verification failure in
unprivileged mode?

> +		"r1 =3D 1;"
> +		"r2 =3D 2;"
> +		"r3 =3D 3;"
> +		"r4 =3D 4;"
> +		"r5 =3D 5;"
> +		"r6 =3D r10;"
> +		"r6 +=3D -8;"
> +		"*(u64 *)(r11 - 8) =3D r6;"
> +		"call %[bpf_kfunc_test_uninit_stack];"
> +		"r0 =3D *(u32 *)(r10 - 8);"
> +		"exit;"
> +		: : __imm(bpf_kfunc_test_uninit_stack) : __clobber_all);
> +}
> +#endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916160821.3157=
543-1-memxor@gmail.com?part=3D5
