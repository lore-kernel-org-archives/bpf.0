Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB000396B68
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787343563; cv=none; b=gch0FlmaAThW2PxVmhz9hltmZLiZQPC5FlLatzXD+6ZgcK+02aS6CW5Dg+uOyF+iEe4t3ZMGWVrITW6R/S/wLn6mHnmn3AjLwoASk88lM27BIgbqCY5zAudJBG+70BwJkfbDlh2vPFnuk5vdpt0Nh5JYvIpz2fMFyj6b3DrHRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787343563; c=relaxed/simple;
	bh=kRhZMaQZxlRiy11N3dXAgntUh+g+ibn0zsZL72jRRNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T1pgxxLzoJqr5m8LeaPau8Nv5F7nfrxgv9RIEg/bSqtcUMtlgOQ9Aohxdp++5JuE37zpVd6IrxmoVK5wBkm323+wY5HJNP237nFqtYKUL8yxdGDyU2tv1q13V/gYbGxvm99LA+QwJpgALpvN6u5AbW6wsds4QAkpc0nMqNiofgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsf5AHkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsf5AHkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F641F000E9;
	Fri, 21 Aug 2026 20:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787343562;
	bh=2pb3hjmHIMsjPbteIeKPazesgr+T5oYr4VtK5QuvgXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lsf5AHkU5PfRpCX/Tl7PxOsoItWwv/IhQYsSyDENwwTXM+1eP1K4RhqMI8pRbhVn8
	 +3WNvu1As17cf+Vy1I6v9k7NJNkgipLOS1e9PntaBgNjfL2d8RRZ2FGlJonac/gFi8
	 zDyvcJTVQtiOjEeVW+SWseEDgN0+fagyWX2j1bZL2xRmSAfxeRHvCcTvhr4bojGswA
	 4htFUtnNz8kp1//Sx7+8ijz6mIqTkwTYLsRdOf9XKUkH/WxAR1tMJPW3RMwjLWd3iE
	 ucvcAjw8KxvYDMf6Uvh9a5w9qA0/JVBw6SMGNzHoTyU8n7VQPVWI+z8JZms5Ldoqry
	 fLCkXgBSWE2+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the blocked
 cpuv4 instruction tests for bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260821201316.1059129-4-vineet.gupta@linux.dev>
References: <20260821201316.1059129-1-vineet.gupta@linux.dev>
 <20260821201316.1059129-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 20:19:21 +0000
Message-Id: <20260821201922.53F641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly added multi-line comment for the gas bug workaround does =
not follow the required BPF subsystem comment style.
--

--- Patch [3]: [PATCH bpf-next 3/3] selftests/bpf: Enable some of the block=
ed cpuv4 instruction tests for bpf-gcc ---
commit 55694625f0a27b85eb77860cd1b4f07749dec04c
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-g=
cc

This commit enables several blocked BPF CPUv4 instruction tests for bpf-gcc
by checking specific feature macros instead of relying solely on clang chec=
ks.
It also skips address space cast tests for bpf-gcc as the feature is not
currently supported, while retaining the existing tests for clang.

> diff --git a/tools/testing/selftests/bpf/progs/compute_live_registers.c b=
/tools/testing/selftests/bpf/progs/compute_live_registers.c
> index 338e67cd8856a..c7d5a0abff2c3 100644
> --- a/tools/testing/selftests/bpf/progs/compute_live_registers.c
> +++ b/tools/testing/selftests/bpf/progs/compute_live_registers.c
> @@ -299,7 +299,14 @@ __naked void gotol(void)
>  		"r3 =3D 24;"
>  		"if r1 > 0x7 goto +2;"
>  		"r0 =3D r2;"
> +#ifdef __clang__
>  		"gotol +1;"
> +#else
> +		/* gas mis-parses 'gotol +1' as 'goto l+1', same encoding
> +		 * without the sign (binutils PR gas/34558).
> +		 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem comment style?

The BPF subsystem requires the opening /* to be on its own line:

		/*
		 * gas mis-parses 'gotol +1' as 'goto l+1', same encoding
		 * without the sign (binutils PR gas/34558).
		 */

> +		"gotol 1;"
> +#endif
>  		"r0 =3D r3;"
>  		"exit;"
>  		:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821201316.1059=
129-1-vineet.gupta@linux.dev?part=3D3
