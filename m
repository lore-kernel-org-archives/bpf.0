Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808D530AD1C
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776402227; cv=none; b=WgCu5SjtvUmi98UltHR/U0zGXf8HZKgyZuUOB6I7igON7wVPZneSnixUOEMn0i8PVFUyETHaHiDYgFXy9Itwx8+d6bsMghvW5tdbgrZuNBb5nAnvoYzZsoYkihWaCc7JBwi9YqiwvEifkA2KH4BZHyvRZ+z3/ldvwh42cCq0tRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776402227; c=relaxed/simple;
	bh=E23cRdShad6ikSJIg5ouBgANd/AjWxKixm4NGabX35I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rX3nSW0HQICzpd7tqzJGfr0pAPiLDCFutYy9OGUwiuYAZEkBadnx+K0gWavY80pnjGTvJCR3K1XkwIudFbAkQCWvCWTPc7wOm69r63+AbX6AAiHc8dgQPuHKhG0zS05hWLGYyc1sTfy5Nyv2QG6C1eGQBHBO/Nzv9Ohq8muUpYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVfnFGiv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVfnFGiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E3FC19425;
	Fri, 17 Apr 2026 05:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776402227;
	bh=E23cRdShad6ikSJIg5ouBgANd/AjWxKixm4NGabX35I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NVfnFGivu83S8IErJnOsWK4t0uVyVJ5jdz36ycDZeCqGDUSdDsEmbp5A2AeAkUWwr
	 aOl1D/vXZpKS9KGj1BedmpPEsmhxsn/kd4kDsSjfiCnO6AjcgCRXwtqxmjmI5WYIff
	 zpz/tosiWi9uG54n//xdGDGMCVVhzY3k0zLArWOXHK7hh4t6H8kwT3bxzNcGPz3Ybx
	 D0lCFhyg9H3pDbIqqhSwcdJPh7iZLf7UTpOZy0kHaYfDnRsMcpfPPJOZKgSCmVz2wJ
	 EnHSUeC65nAGbvY+rtY1ocll4rVupK53CMAraD3/xXwU+eLYBLBVmOsGM7Jq/dFcZF
	 5pt9c5GKsBeew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 12/16] bpf: Enable stack argument support
 for x86_64
Reply-To: sashiko@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417034800.2631277-1-yonghong.song@linux.dev>
References: <20260417034800.2631277-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 05:03:46 +0000
Message-Id: <20260417050346.F2E3FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Enabling `bpf_jit_supports_stack_args()` for x86_64 without the co=
rresponding JIT implementation introduces a bisection-breaking regression t=
hat can lead to arbitrary kernel memory writes and ABI violations.
--

commit b40feee41e4472d0e27be38b4c99c940abe3c1ba
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Enable stack argument support for x86_64

This commit enables stack argument support for the x86_64 JIT and verifier
to allow BPF programs and kfuncs to use more than 5 arguments.

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index e9b78040d703e..32864dbc2c4e8 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3937,6 +3937,11 @@ bool bpf_jit_supports_kfunc_call(void)
>  	return true;
>  }
> =20
> +bool bpf_jit_supports_stack_args(void)
> +{
> +	return true;
> +}
> +

Does enabling this without the actual JIT implementation break bisection?

If bpf_jit_supports_stack_args() returns true, the verifier will allow
instructions using BPF_REG_PARAMS (register 11) to handle stack arguments.
However, since the JIT support isn't implemented in this commit,
BPF_REG_PARAMS is not yet defined in the JIT's reg2hex array.

Could this cause reg2hex[11] to implicitly default to 0, which maps to
RAX (BPF_REG_0)? If the verifier emits instructions using BPF_REG_PARAMS,
the x86 JIT might miscompile them using RAX as the base register, potential=
ly
allowing an arbitrary kernel memory write since R0 is controllable by the
BPF program.

Additionally, it appears kfunc calls with >5 arguments won't have their
arguments correctly marshaled to the System V ABI (like moving the 6th
argument to R9), which could lead to reading uninitialized garbage from
registers and the stack.

I see the JIT implementation is added later in the series in commit
41dcf99330b6b ("bpf,x86: Implement JIT support for stack arguments").
Should the JIT implementation be merged before or in the same patch as
this feature enablement to maintain bisection?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417034658.2625=
353-1-yonghong.song@linux.dev?part=3D12
