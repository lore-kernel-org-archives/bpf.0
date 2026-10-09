Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489914086A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791521141; cv=none; b=gnylYpK1GdoU+C/Fn1FfUnmgJZ92216vBceDfms516aEYJroV56cDzFE5h93CvqFJFxw45xeCoG4x4b1VvS4MC6jq7L7Tj9K9qxIo/Tz1+Gv1LELaLZE/5zH6uKDgvOYqk2u5GGx5Bp/YTKeIthxOTxXxSHcyEw0sk3OEcia9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791521141; c=relaxed/simple;
	bh=C+KMbGDV4F/E2ipZKrEyV4ShNCkmIBu1mAhapen8SkU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hgETcyCdUP0nGUA6eCF4r3cytucFgOGLbdr34eH6DQm5989+PC1kAS/ZRaPl8d+/7BG6jZMqzG8lbL7o8eVbQbnfvO0RiaQXb3PGnhqnaIuF9zPOnph3VuluEvO/EtTo11BsBIhSAEzD/0TAtNsEhnMst4HFu53GHXWv0biEFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogwu7NsF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogwu7NsF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA881F00893;
	Fri,  9 Oct 2026 04:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791521139;
	bh=kKegSbqZ/y2JrObtv++O5ExEg8672j83C1FEngTMWs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ogwu7NsFOqxWNWZrOPv/A2glhHOB34VmPxAp6T2VXLBQmUSjVYYglnbzQ8wHgl6Wy
	 OhhUFnt5rcRulCH2gPEINsEhwxd5NvQ710a0MsVhcawTOahU3r+7cbcwpNpLfwus62
	 1iDY+ZAVzKgrvr8b9vxFmWbAHvhdeezyw796GltkFET7s0oZcroJnUmAQv2Q5y6xkj
	 fsdkHpM5AvEnNwKM+PCbc9XUCnvwKWrJEPOFHxvMppZu+ZzO4YF2Nt+F3HsoUBVIu0
	 vUnyE+WrQvayVpH2iYjSn3dAqBwMxFCJ588ChqUFxMoYtLl3PpXXtHv4cYB3MI5s0F
	 gDcgRGBsJtV3g==
Message-ID: <sashiko-outbox-164850@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 10/24] bpf: Do not use a private stack for
 a program that can unwind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041539.28288-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041539.28288-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:45:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: bpf_prog_may_unwind misses might_throw, causing private stack=
 corruption
--

commit 38438f251d7fce91364c50842e5e55c25b6033f4
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Do not use a private stack for a program that can unwind

This patch aims to prevent BPF programs that can unwind from using a private
stack. A private stack keeps its frame pointer in %r9 on x86-64, and an
unwind skips the restore, leading to stack addressing issues. The fix forces
NO_PRIV_STACK for programs that might unwind.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 2b9640099269e..f45dd3157f7fb 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> @@ -183,6 +183,16 @@ static void mark_call_sites(struct bpf_verifier_env =
*env)
>  	}
>  }
> =20
> +bool bpf_prog_may_unwind(const struct bpf_verifier_env *env)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < env->subprog_cnt; i++)
> +		if (env->subprog_info[i].might_unwind)

[Severity: High]
Does bpf_prog_may_unwind() miss the might_throw condition?

Since might_unwind and might_throw are tracked separately in
bpf_subprog_info, it appears a BPF program using bpf_throw() would bypass
this check and still be compiled with a private stack.

> +			return true;
> +	return false;
> +}
> +
>  int bpf_exc_check_prog(struct bpf_verifier_env *env)
>  {

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 59b275bfc949d..35013a5d84019 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -5801,6 +5801,17 @@ static int check_max_stack_depth(struct bpf_verifi=
er_env *env)
>  		}
>  	}
> =20
> +	/*
> +	 * A private stack keeps its frame pointer in %r9 on x86-64, restored
> +	 * by a pop after the call that an unwind skips. A frame resumed at a
> +	 * pad then addresses its stack through a stale pointer, and a frame
> +	 * sent to its epilogue instead pops its callee-saved registers one
> +	 * slot off. Do not use a private stack for any program that can
> +	 * unwind, on every arch for now.
> +	 */
> +	if (env->cleanup_info_cnt || bpf_prog_may_unwind(env))
> +		priv_stack_mode =3D NO_PRIV_STACK;

[Severity: High]
Will this leave programs that throw exceptions vulnerable to stack shifting
in check_max_stack_depth()?

If a program uses bpf_throw() and is compiled with a private stack
(PRIV_STACK_ADAPTIVE), the x86 JIT pushes the private frame pointer (%r9)
before every call.

When bpf_throw() is called, the ORC unwinder calculates the boundary frame's
stack pointer as the value of %rsp before the call, which includes the
un-popped %r9 (shifting it by -8 bytes). Then bpf_exception_cb() uses this
value to restore the boundary frame's callee-saved registers.

Because of the unaccounted %r9 push, the stack pointer is off by 8 bytes.
Could this cause pop_callee_regs to pop the stale %r9 into a callee-saved
register, shift all other registers by one slot, and ultimately corrupt the
callee-saved registers?

> +
>  	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
>  		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D10
