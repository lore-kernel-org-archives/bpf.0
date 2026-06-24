Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC872BF3E2
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294589; cv=none; b=spWmOetL4AeDYRES4LK3fI1vF+pLQmngeJolbuDOHO8Q9YGHSn2JJQhTrB384wyqPRENayynuZUN5cN9ncye5EkB/XkJ5JcJNN3dpVFYSIpaUCQ6GOk67V3wyV7bthaAOi0pp9FziexTaw5OeyhT14bBxnHWRv62tXTQ819szTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294589; c=relaxed/simple;
	bh=PRNk2RU3YFuax/m/YN7etZhRcZxY3cWmP1nTPsVR+gg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iVys/J5A+3b5s+O57h0naH7rv0uRXVHOk2ryF7BSLc+161rHURYndOFCLPGdrmk2GHtHHYrr5we8QnAXQfqrfoLR82U02TuO6i0u3DUAzj+CoFxXYRd6gTEcmsth15WMnyr+R3m/6ik7ZHpcE7cm6jvSx5m5EHiM86vhrogtKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MENYKDOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MENYKDOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9ED1F000E9;
	Wed, 24 Jun 2026 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782294588;
	bh=gnZa23TByYK5fZvXbq0Lf4L6pcOtME6CAQTNymQL6R4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MENYKDOyL11nWoHN3D1fhfdzftH6fC8HTQK6qi1VIQGgnfjGSEvdJScFPklxyqFd4
	 xAMZcB++VPUSFl5gMwzN2IxXePLNVTwCZhKPqq61lgeknwuCKMUdarf2/Adf84ex2A
	 JNcEkk/HIusj6LrTeCjg7JelItvISpesE2dX1DICqMVMROTq8wzjrjDGIX2oEYmAs7
	 dR8d30Gl5smIKCqk5yiFWkZ2CxmRrUsAOhwBNW1D8xNDyHjT40WqADxfyrYg0NuSyX
	 SjlcyQSJDp7bQUbHCZREGbY3SHY1xwEehnUBmZ5NTeAMuk0OKBbE9CMErN8Mliw13s
	 syhRNZDCv4s7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] bpf: add bpf_strpbrk kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260624093638.117062-5-lange_tang@163.com>
References: <20260624093638.117062-1-lange_tang@163.com>
 <20260624093638.117062-5-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 09:49:47 +0000
Message-Id: <20260624094948.2D9ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] Incomplete bounds check in `bpf_strpbrk` allows pointer wrapar=
ound and out-of-bounds reads.
- [High] Unoptimized O(N*M) nested loop in `bpf_strpbrk` causes CPU exhaust=
ion and Denial of Service.

Pre-existing issues:
- [Critical] Incomplete bounds checks in pre-existing string kfuncs allow p=
ointer wraparound and arbitrary memory reads.
- [High] Pre-existing string kfuncs (`bpf_strcspn`, `bpf_strspn`, `bpf_strn=
str`, etc.) contain O(N*M) nested loops vulnerable to CPU exhaustion.
--

commit eccea6a6a708ac6a6e30a1e094434ed92118f8f0
Author: Longjun Tang <tanglongjun@kylinos.cn>

bpf: add bpf_strpbrk kfunc

Add bpf_strpbrk() that returns the index of the first character in a
string matching any character from the accept set, or -ENOENT if no
match is found.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc int bpf_strpbrk(const char *s__ign, const char *accept__ign)
> +{
> +	char cs, ca;
> +	int i, j;
> +
> +	if (!copy_from_kernel_nofault_allowed(s__ign, 1) ||
> +	    !copy_from_kernel_nofault_allowed(accept__ign, 1)) {

[Severity: Critical]
Since the __ign suffix allows arbitrary scalar values as pointers, could
checking only the first byte allow a pointer near ULONG_MAX
(e.g. ULONG_MAX - 5) to pass this validation?

Because the loop below increments the pointer up to XATTR_SIZE_MAX times,
it appears the pointer could wrap around to user space (0). Since
__get_kernel_nofault() uses __get_user(), could this allow reading
arbitrary user-space memory, bypassing security boundaries?

[Severity: Critical]
This is a pre-existing issue, but other string functions like bpf_strcspn()
and __bpf_strnstr() use this same 1-byte validation pattern.

In __bpf_strnstr(), accessing s1 + i + j can reach up to 131,070 bytes past
the start pointer, bypassing mmap_min_addr and allowing direct user space
memory reads from within BPF. Could this be updated across all string kfuncs
to validate the entire memory range being accessed?

> +		return -ERANGE;
> +	}
> +
> +	guard(pagefault)();
> +	for (i =3D 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&cs, s__ign, char, err_out);
> +		if (cs =3D=3D '\0')
> +			return -ENOENT;
> +		for (j =3D 0; j < XATTR_SIZE_MAX; j++) {

[Severity: High]
Does this nested loop introduce a potential CPU stall or soft lockup?

If a BPF program passes 64KB strings for both s__ign and accept__ign where
no characters match and the null terminator is placed near the end of
accept__ign, the outer loop could execute 65,536 times with the inner loop
executing ~65,535 times per iteration.

With page faults disabled via guard(pagefault)(), could this lead to
~4.29 billion memory accesses, potentially causing a Denial of Service?

[Severity: High]
This is a pre-existing issue, but other kfuncs like bpf_strcspn() and
bpf_strspn() also contain these XATTR_SIZE_MAX nested loops.

Could crafted strings force those inner loops to run fully for every
iteration of the outer loop, causing the same CPU exhaustion? Is there a
way to optimize these searches or limit the execution time?

> +			__get_kernel_nofault(&ca, accept__ign + j, char, err_out);
> +			if (ca =3D=3D '\0')
> +				break;
> +			if (cs =3D=3D ca)
> +				return i;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624093638.1170=
62-1-lange_tang@163.com?part=3D4
