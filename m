Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F737F305
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 05:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598659; cv=none; b=Egq4ljp74bJjov7SOCDheVtVaDBO3PZskRydGgmV+Cr963MzEypxQKmgIBiVKQrkfpDn5u6BtmIcK9P5KfJm4g0WMSyYyovlCuNm1pGGyJFdRdaXh1sFUketDzLRuSbIm40xHZVRf8YEV/gI9xZI7j+EE4Uz8T0JONZ+dPj6lRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598659; c=relaxed/simple;
	bh=POEIsJUkU0CDtxe2Km1C79rXeeJOLoPw7843S8twfH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b8/NXuPc9qlrw9k64qiUQTHgTE9geESMICLeO2GHwQiVIofbXjOHTMlnIB24gZxmRlpR+AAVdEzrqtqYNAjnwrN8GwNk/8dC0UlqBj+mOUUb13VNptyr6XCasXpO2W6H6GGwox1qPvG5v9sGnw1Bn1JxGJP10FjLQPZ9/TgJvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1H5ERD3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1H5ERD3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FFD1F000E9;
	Thu, 13 Aug 2026 05:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786598648;
	bh=llINEJzttQV4NWoXBb4gg9pu9Or+cHqeyDSeJFnzpDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S1H5ERD3ULBEqzFLFdgYY0va6vlwAHFeCID2YG5gZIvm7SAUKzWNUS16xELaUeup2
	 jExJgKQ25SJSYZQm1VkdgKJ2PsDhj5iBgMy8lj8sA9gU2th+ZOaU8suNBf+tLAUab2
	 WbCy9wwSfWN5XOaLL9/99H1LhsGmRTDpFq2cST1c1x/ZKYPfKp12aVPwnxhSolXh8X
	 QOxRKKMx2luIJBjpg607tE5n+IA+Hf8rZ2I6Gtgvv66EiYldMn11Gys/jLbSxyog9R
	 vVc3i/G0D77BqucPXzxXyGacdEDUyjBl7i0evs5XxjMOC7GNTyi/alBnIqiPtzRs6a
	 RB1wtaIolznlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1] selftests/bpf: Fix insn count expectations
 in chained global subprogs test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813051635.121670-1-jiayuan.chen@linux.dev>
References: <20260813051635.121670-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 05:24:08 +0000
Message-Id: <20260813052408.A2FFD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly introduced multi-line comments violate the mandatory BPF =
kernel comment style by placing text on the same line as the opening `/*`.
--

--- Patch [1]: [PATCH net-next v1] selftests/bpf: Fix insn count expectatio=
ns in chained global subprogs test ---
commit 0f391b5a2f4f9b30c1e20dfe376da213cfa9c650
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

selftests/bpf: Fix insn count expectations in chained global subprogs test

This commit rewrites the involved subprograms as naked functions with
hand-written instruction sequences using only v1 instructions. This ensures
that the verified instruction counts no longer depend on CPU version or
compiler codegen, resolving failures on the cpuv4 flavor.

Fixes: c2e6c7de8830 ("bpf: Show more useful info in stack depth stats")

> diff --git a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c=
 b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> index 7b65eea97ebc2..3352dc177ec15 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -25,9 +25,22 @@ __noinline long global_bad(void)
>  	return arr[unkn_idx]; /* BOOM */
>  }
> =20
> -__noinline long global_good(void)
> +/* Insn counts asserted in chained_global_func_calls_success() depend on
> + * the exact instruction sequences of this function and its callers, so
> + * they are written in inline asm to be independent of compiler codegen.
> + */

[Severity: Low]
This isn't a bug, but does this violate the preferred BPF multi-line comment
style? The BPF subsystem guidelines specify that multi-line comments should
have the opening /* on its own line.

> +__naked __noinline long global_good(void)

[ ... ]

> @@ -56,13 +73,30 @@ __msg("subprog 0 (chained_global_func_calls_success) =
main insns_self 7 insns_tot
>  __msg("subprog {{[0-9]+}} (global_calls_good_only) global insns_self 2 i=
nsns_total 2 stack")
>  __msg("subprog {{[0-9]+}} (global_good) global insns_self 5 insns_total =
5 stack")
>  __msg("processed 14 insns")
> -int chained_global_func_calls_success(void)
> -{
> -	int sum =3D 0;
> -
> -	if (call_dead_subprog)
> -		sum +=3D global_dead();
> -	return global_calls_good_only() + sum;
> +__naked int chained_global_func_calls_success(void)
> +{
> +	/* int sum =3D 0;
> +	 * if (call_dead_subprog)
> +	 *	sum +=3D global_dead();
> +	 * return global_calls_good_only() + sum;
> +	 *
> +	 * call_dead_subprog is known false, so 7 insns are processed:
> +	 * the branch to l0 is always taken and global_dead() is dead code.
> +	 */

[Severity: Low]
This isn't a bug, but it looks like this comment block also places text on
the same line as the opening /*. Could this be updated to place the /* on
its own line to match the rest of the BPF subsystem?

> +	asm volatile (

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813051635.1216=
70-1-jiayuan.chen@linux.dev?part=3D1
