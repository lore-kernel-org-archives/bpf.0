Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427830;
	b=evBc4a1peaFaBwKLyyzMXfvBhMT1tdb05KvJQntLyYSFKCbIMQUGvMsNJYyEGqSHteI2
	 bvMSTDZFK2Hf65KpQoTB7dgAonlyoJ4gbRRgxYYvAK2cSk1cb8h1j/Iutr0APe1pcmLhc
	 SLkSNOhF1/o4bRxCgF0izCz8vSvNFm3H10EaILj/vfXH/ydyW0HKDQkuXiNa1S3N1Giej
	 t43dZolFWcl0xMRTv3MclR5tm721CKKyIcvFSw+aXPda5VTSVS23L3P40tYwE4X9Tiwhd
	 9LwqT1N9tAdfmcR7x7IVnqLRMmqwxhNLNFQL/Oe/UcKFnED86koD5W6OLypvRWWwsAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427830;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3cJo8ZcESNxsZAep8SluVMXLsttaabMAn4YH9ghtoYM=;
	b=EsYBxeF08dtHJPN1IDuLA/otEPK3xq1Z4d0YOPLlBj3qqr9rRTlJmE8y6wmN2V+C3/WS
	 KqLPt+vq6eyHZVxQhHRxRr9Irpobmku+t7UllAEM0GIeXgNcQCrChl9ifctz4JjdnIy5w
	 pzkkLURgUqoX9fBM2A/KgpwLu1b06N3v4HUiI85vFtdU5BPuJseApoOhvIcGUUrB/TvB+
	 YuMztg5cTvzoDqRICF9MopkPLuaJmgSHC6CR3Tab02rs5dA4kO+j8UWibgsOI+MfcBH0V
	 eoD4CWqKdzRK21Z4/0D+xTCyQLajtTSCkBW6MV3N8q10ywwX5PPEHSNtyf6joIT8zpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efy5LHLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B16606A31C;
	Wed, 11 Nov 2026 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=efy5LHLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8BC1F00A05;
	Wed, 11 Nov 2026 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427830;
	bh=3cJo8ZcESNxsZAep8SluVMXLsttaabMAn4YH9ghtoYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efy5LHLDTh7qPk1pWF59I5VtBweAgvHVfkckHKFfoUt045aQexIROcIBlu01MLGrJ
	 pU+XmlOAAJhAuBbF7vBgdnUi7xKwH/eGM5lXMG6BUnlhe+3d4nabhoZ0lNISL991lF
	 leOetLjnH7dkKxPrYWWFObjnmOouuOiv2mlnVFxtnhV5PxZSY9np5FWqHdwkv4B/rg
	 XMiXXCybeOLjni9eBtCjvngZ6IIMcZHm6sfAVlqzaDtKwtaoj+NElbv0mYfGVgXS9F
	 uK4dvppr/dYyLw2CVEydHx9RHdgZbLxymsPrjt/hU404RddV1KkZjPgIv+W1QACfOI
	 HdLmdb8NkvZ4g==
Message-ID: <sashiko-outbox-209613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Avoid per-CPU private stack in
 preemptible tracing progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Bazov" <mikeba@sentinelone.com>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-1-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
 <20261111-bpf-preempt-v2-r2-v2-1-9d8f6b952ad2@sentinelone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:10:29 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: raw_tp tests in verifier_private_stack no longer
  test priv stack
--

commit 173ae153d8d266fe351d0833f08f2920b88ec9ce
Author: Mike Bazov <mikeba@sentinelone.com>

bpf: Avoid per-CPU private stack in preemptible tracing progs

This commit disables per-CPU private stacks for tracing, raw_tp, and
tracepoint programs because they run preemptibly and can be entered by a
second task on the same CPU, and updates check_recursion() and the BPF
selftests accordingly.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b=
/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> index e7f410a74a21b..bebdb0aff23fd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> @@ -127,6 +127,23 @@ __naked void no_private_stack_kprobe(void)
>  "	::: __clobber_all);
>  }
> =20
> +SEC("fentry/bpf_fentry_test9")
> +__description("No private stack, fentry")
> +__success
> +__arch_x86_64
> +__jited("	subq	$0x100, %rsp")
> +__arch_arm64
> +__jited("	sub	sp, sp, #0x100")
> +__naked void no_private_stack_fentry(void)
> +{
> +	asm volatile ("			\
> +	r1 =3D 42;			\
> +	*(u64 *)(r10 - 256) =3D r1;	\
> +	r0 =3D 0;				\
> +	exit;				\
> +"	::: __clobber_all);
> +}
> +
>  SEC("uprobe")
>  __description("No private stack, uprobe")
>  __success

[Severity: Low]
Should no_private_stack_nested() and no_private_stack_stack_args() above
this hunk also be switched from SEC("raw_tp") to a program type that is
still eligible for a private stack, such as SEC("kprobe.multi") or
SEC("perf_event")?

With raw_tp returning NO_PRIV_STACK from bpf_enable_priv_stack(),
check_max_stack_depth() now skips both tests on priv_stack_mode !=3D
PRIV_STACK_ADAPTIVE before reaching the 64-byte BPF_PRIV_STACK_MIN_SIZE
threshold or the x86-64 si[s].stack_arg_cnt check they were written to
cover:

tools/testing/selftests/bpf/progs/verifier_private_stack.c:
    SEC("raw_tp")
    __description("No private stack")
    ...
    __naked void no_private_stack_nested(void)
    ...
    /* x86-64 has one register for the private stack and for the sixth argu=
ment */
    SEC("raw_tp")
    __description("No private stack, stack arguments")
    ...
    __naked void no_private_stack_stack_args(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-bpf-preemp=
t-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com?part=3D1
