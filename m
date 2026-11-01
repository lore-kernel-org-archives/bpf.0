Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560784;
	b=hwg+x8NA0kWAsPkY1Hu14V27Yxb9lCmvBI9anlTCINL8QrxSnm75bpoHoKtgOCRMv3OI
	 T47qfIAe2XVrxrHK20ZiOaBbLbQ0YX1XvgE6mewBwB7OdKUnamp/aiXS9JeR+Ue/gsV6h
	 qMhaUFMM9TwEGH2yaHm3CjYtoZx9f6miYCntC28e/HZ7lSCht3dsWptVlkxpHdgvQGrjw
	 xtBC+xtZCLXTuFIdJqev4UTqzeq49KcDg7/OmuvAoekR2e+LYwIVhSQDnjsvObH8/gbpn
	 Wk88bSbiy1PnKfvIlR3ky05750qyzPt4FN2IHUtE332QLvgEDLc7SqvEJ95zTBR/DDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560784;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jj+Ig1S/FGx8AiMwFhaDjZMRs+GqISHjm15x3K2/wpI=;
	b=zmz6g9tsOUu8HUXlgfsUbSSvBvfGLaN2g0uH3V1qTmN5JCwI1ej+55VDVQ+1Sy5//Qxl
	 lqh0lTZ/BUxcLPlOsLX3hrbZH9k9Ntxzvm/4V57QwNGkU+znrVs2qEcapieXSX6rkDm0h
	 dVqAeAeBgdv8lzEcemPKUPqmA08hFIG5eWNWlVVlpgu7UBn538Yua7S79p5eWoZ8DRGFp
	 vEboXBb7pH2xU84QMCi2XN/8NAAdqwFGBXTMXGPxI94JYzcZwODqWDP1MeO7QFWsjP5I+
	 0w0gZAcr6ub9+q2LX1eCfoLEfpaeNoK59o6Ug5lkwgvLd6TFwNjlPoQBW/Kh2DQaJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQpdacoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58244606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQpdacoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2AA1F000C1;
	Sun,  1 Nov 2026 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793560784;
	bh=jj+Ig1S/FGx8AiMwFhaDjZMRs+GqISHjm15x3K2/wpI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=BQpdacoMHqp2e9T798ax/LTNTzv/rSw/+e4H6vps8M6k5tSWz69iQ5XF4dTj1SvLj
	 E6NqxPUVM8hC2qo36U/9SI2HcN6/r7EOHi8NJQcBB2CFMsxeYuCCL+ys1mwhr3EnW9
	 /D/+loQIZ4W+LLTXgu30I2xTVa7d9L2CTy7u+cZFGib6yzyUiIFbIk+0smpDgkx5XV
	 03fXAnglfwI1Nr5FFJ4HM8Co8es4wCdA9KmgHo2aOgtVHsbGhF/fpzrimQJTPbu8i9
	 XR89QQMpu1Tgrfue9ljL2IrYs/5SrF48VcnQgMHDBkEJ6cLAlR0sLTNxDE+ydM1qUQ
	 XcYEjA/UiwqhQ==
Message-ID: <sashiko-outbox-192586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 03/27] bpf: Refuse to map an arena at address 0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261101190535.1454146-4-alexei.starovoitov@gmail.com>
References: <20261101190535.1454146-1-alexei.starovoitov@gmail.com>
 <20261101190535.1454146-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:19:43 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: round_up() overflow in arena_get_unmapped_area() maps arena=
 at 0
--

commit 3145de230091dc6bb32f02294ed0d9f801a1c145
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Refuse to map an arena at address 0

This commit rejects mapping a BPF arena at address 0 in
arena_get_unmapped_area() by returning -EINVAL when mm_get_unmapped_area()
returns 0, preventing arena->user_vm_start from remaining 0 after the
first mmap().

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 3c61c181a6fa9..ad8aab5510939 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -650,6 +650,9 @@ static unsigned long arena_get_unmapped_area(struct f=
ile *filp, unsigned long ad
>  	ret =3D mm_get_unmapped_area(filp, addr, len * 2, 0, flags);
>  	if (IS_ERR_VALUE(ret))
>  		return ret;
> +	if (!ret)
> +		/* user_vm_start =3D=3D 0 means that the user range is not set yet */
> +		return -EINVAL;
>  	if ((ret >> 32) =3D=3D ((ret + len - 1) >> 32))
>  		return ret;
>  	if (WARN_ON_ONCE(arena->user_vm_start))

[Severity: Medium]
Can arena_get_unmapped_area() still return 0 via integer overflow in the
subsequent round_up(ret, SZ_4G) when mmap() is called with MAP_FIXED?

In mm/mmap.c, __get_unmapped_area() invokes get_area() before checking
whether addr exceeds TASK_SIZE - len:

mm/mmap.c:__get_unmapped_area() {
	...
	if (get_area) {
		addr =3D get_area(file, addr, len, pgoff, flags);
	...
	if (IS_ERR_VALUE(addr))
		return addr;

	if (addr > TASK_SIZE - len)
		return -ENOMEM;
}

When arena->user_vm_start is 0 and userspace passes MAP_FIXED (or
MAP_FIXED_NOREPLACE) with a page-aligned addr in the range
[0xffffffff00001000UL, 0xfffffffffffff000UL], mm_get_unmapped_area()
returns addr directly without checking TASK_SIZE.

In kernel/bpf/arena.c:arena_get_unmapped_area():

	ret =3D mm_get_unmapped_area(filp, addr, len * 2, 0, flags);
	if (IS_ERR_VALUE(ret))
		return ret;
	if (!ret)
		/* user_vm_start =3D=3D 0 means that the user range is not set yet */
		return -EINVAL;
	if ((ret >> 32) =3D=3D ((ret + len - 1) >> 32))
		return ret;
	if (WARN_ON_ONCE(arena->user_vm_start))
		/* checks at map creation time should prevent this */
		return -EFAULT;
	return round_up(ret, SZ_4G);

Here IS_ERR_VALUE(ret) is false because ret is below -MAX_ERRNO, and !ret
is false. Because ret is a signed long, (ret >> 32) sign-extends to
0xffffffffffffffffUL while ((ret + len - 1) >> 32) is unsigned and
evaluates to 0xffffffffUL (or wraps to 0), so the 4 GiB check is also
false.

Execution then reaches round_up(ret, SZ_4G), which overflows 64-bit
arithmetic to 0. __get_unmapped_area() receives 0, passes the
addr > TASK_SIZE - len check, and maps the arena at address 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101190535.1454=
146-1-alexei.starovoitov@gmail.com?part=3D3
