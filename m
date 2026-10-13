Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672C3B19AB
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881542; cv=none; b=W8zotDJeLcaewSXo/pJQOHt4AJmX8UyKKmhayB3oCiOXjjn+yjsdftghVVqa9s13QspKDKW4bPXhkxQnx5JPBCLSVOX1/4dYhI5tQvriT2OXwXRZo6VO4wfFCJX7EYsS79I4qDpsDIma6pt+VE7xz1ML1DqrEwm07hL9VVMqwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881542; c=relaxed/simple;
	bh=AQXPh9AHQNkaFzxsl6b13Gp94hbCJcoOVWxWw97JMt4=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=GQ1HDqySjrjBgWMNfUBS518RICBykaWZdqyapybkxbgTgwjIDFlwKZmwbBbNrVovP5fSWfqqU/XSYj3pMK5fQUQIfHu7hn0WoRLac/MmEhXw2dbJOmA8AhK5/55qDBJOSF1hqyR3E970WyntdfNGMYaw3bmkzK2yjUvv8DO18qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwWRuoem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwWRuoem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D362B1F000FF;
	Tue, 13 Oct 2026 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791881541;
	bh=E1uZ5qqLC9YxeraFJaqiFe30n3c31f2Xo4bmy+UzpoI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IwWRuoem1MmcpqQBd/8DF/kK8jjpaNBn9WqBaCNeV4HwONJE//ehnC0XgMo1IEEAs
	 bsINNZ1eRmXntql1MAUKYuiFXfkAkTznf7Q8zoDg5HfVx8eGIpLEieqEBeyRM9QZXv
	 yf6QhFpy4ViXHCrT9v4Xe9uXSVwysv5Oo2KxQu00H26PjbwBEjx2HvalMXeNlsiSjU
	 +TFsY9qv9xrfVYX37ZDcQ6zhSStNjfMKJhGKdF0hxSF3RsLaGPUD3ixFc76fb/bJBE
	 AKbdc9PsaxW+z+bMzeAey6L/itsYN4NwbhOmJ0S5z1csoCmLi88qGQp+uqZgWQtHpU
	 qe76XLfR2uFig==
Message-ID: <sashiko-outbox-169283@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 04/13] bpf: Recognize __nullable on pointer
 members of kernel structs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261013082012.1107446-5-memxor@gmail.com>
References: <20261013082012.1107446-1-memxor@gmail.com>
 <20261013082012.1107446-5-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 08:52:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: MEM_PERCPU pointers are stripped of PTR_MAYBE_NULL flag causi=
ng Oops
--

commit 2e4273929b840decae1764fc52e2d82686a2b6c3
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Recognize __nullable on pointer members of kernel structs

This patch updates btf_struct_walk() to report the __nullable BTF type tag
on pointer members as PTR_MAYBE_NULL. The verifier is also modified to keep
the PTR_MAYBE_NULL flag on trusted and RCU pointers only, under the
assumption that untrusted results are probed anyway.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2f190abe34489..a9c47441fba91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -6721,6 +6721,13 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>  		clear_trusted_flags(&flag);
>  	}
> =20
> +	/*
> +	 * A __nullable member only matters where NULL would otherwise be
> +	 * assumed away, on trusted and RCU pointers; the rest are probed.
> +	 */
> +	if (!(flag & (PTR_TRUSTED | MEM_RCU)))
> +		flag &=3D ~PTR_MAYBE_NULL;
> +

[Severity: High]
Does this unintentionally strip the NULL-checking requirement from
MEM_PERCPU pointers?

Struct members annotated with __percpu __nullable will receive the
MEM_PERCPU | PTR_MAYBE_NULL flags from btf_struct_walk(), but lack
PTR_TRUSTED or MEM_RCU.

Because the pointer loses PTR_MAYBE_NULL here, does the BPF verifier no
longer force the BPF program to verify it against NULL before passing it to
helpers like bpf_per_cpu_ptr() or bpf_this_cpu_ptr()?

Since these helpers do not check for NULL internally, calling them with NULL
simply returns the base address of the CPU's per-CPU memory area. A
subsequent NULL check by the BPF program would then pass, which might allow
it to dereference the base of the per-CPU area and corrupt memory.

>  	if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
>  		ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id,=
 flag);
>  		if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013082012.1107=
446-1-memxor@gmail.com?part=3D4
