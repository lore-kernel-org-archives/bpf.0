Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9A46D2A9
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785858206; cv=none; b=XfReHRDtcwBdTRhfjH0MMaawFzaujBT5t+231SXYSriBtE+J3lK7HwHnxEwGY2j2N2ScpNX+ccqO2sFQXBQ7ZgiqucctOZ/Rsk+6zpH31m26sVfUJv7hpsrJ5T3BNkZNHkc+gLy8T80thS10F0Zedlt16PaKYx7NmwM45YWZzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785858206; c=relaxed/simple;
	bh=Xu/1A7B1Qv4WZuUnM8rfeXNjGdCJvYDmZVGfEddxZbc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y3oHjRROYRZezDHUw37JHP5sNdF+TC3FfJoN6eWWMUndvhKNcpq0nTfwmUlKcfMsc1VMpWTeM+jw40TcAA5opR7H9qNP6exSalgYB3JZUVz4W6VIGKwjXr1L3L+kJChj+uABzIHC+3GlGPY+Xr3A2FRDDl++b83NEl7gAfLN094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxUct5sk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxUct5sk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3478C1F000E9;
	Tue,  4 Aug 2026 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785858203;
	bh=vF3Xp8CypQngnOBtN23/bb9TreRgaj/HHuXpCU0pRLc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxUct5sk+THM6Q5+llMveY48YUsMa2fXKFw86CPgv36mb7k4blnWcqnYp8mteIqvL
	 b7qxNvBzsQZAH9XlzOr+gxhlL1rADlzCSNNJIPThKAuExGymT0YHLjRrkzhumrhC3o
	 tdMTBIE7AHuWNH8M+JblJBIO7XsDlpcXr1f2i0un6WvkKSjWQSciPcKIHnHP+7lJp7
	 LkRwaZ6ltgGRNiXjdyE+23dZOAcJxJ457GFUAUGjjRNHkKwGFzrHcUgee0OQD5LfOO
	 pQPB7qdsH+xuYwyiINISMZFnT6VngL+MlmkO2mLd3m+fLKG4OwULo2zTOwd2VYT3Dj
	 CMMLzHT0kxLfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing
 prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260804145710.43062-2-leon.hwang@linux.dev>
References: <20260804145710.43062-1-leon.hwang@linux.dev>
 <20260804145710.43062-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:43:22 +0000
Message-Id: <20260804154323.3478C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Bypass of `bpf_d_path_allowed` allowlist using forged BTF IDs allo=
ws non-sleepable tracing programs to call `bpf_d_path`, leading to kernel d=
eadlocks.
--

--- Patch [1]: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing=
 prog ---
commit bd029887d83c0773bad79aca8216a06849cdbd32
Author: Leon Hwang <leon.hwang@linux.dev>

bpf: Fix sleepable check for tracing prog

When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing prog
is allowed to attach to '__x64_'-alike prefix symbols.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 7439afdc851a7..d4541cca7180e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19024,6 +19024,9 @@ static int btf_id_allow_sleepable(u32 btf_id, uns=
igned long addr, const struct b
> =20
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_TRACING:
> +		if (!btf_is_kernel(btf))
> +			return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does the same bypass exist for
non-sleepable tracing programs calling bpf_d_path()?

Looking at bpf_d_path_allowed() in kernel/trace/bpf_trace.c:

kernel/trace/bpf_trace.c:bpf_d_path_allowed() {
	...
	return btf_id_set_contains(&btf_allowlist_d_path,
				   prog->aux->attach_btf_id);
}

This check relies entirely on the integer attach_btf_id and fails to verify
if attach_btf is the kernel's vmlinux BTF.

Can a user load a dummy BPF program with a crafted BTF where a function's
BTF ID exactly matches an ID in btf_allowlist_d_path, and then attach a
non-sleepable tracing program to it?

If this dummy program is triggered in softirq context by network traffic,
and the tracing program extracts a valid path and calls bpf_d_path(),
this would invoke d_path() which attempts to acquire rename_lock (a seqlock=
).

If the softirq interrupts a process holding the seqlock writer spinlock,
wouldn't read_seqbegin_or_lock() retry and fall back to taking the spinlock,
causing a deadlock on the same CPU?

>  		t =3D btf_type_by_id(btf, btf_id);
>  		if (!t)
>  			return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804145710.4306=
2-1-leon.hwang@linux.dev?part=3D1
