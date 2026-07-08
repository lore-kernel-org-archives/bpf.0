Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5723F6C33
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545945; cv=none; b=RTO22GBX2Zw2cNA6+BzsyQYZeYvm3o8ElHNpN9WI0Snf6u8HPM8cUr92XKPSAzhM9HTCuZI9n4/IemjKRnMr4AG6R/WfywkVYknuObHXy/fZEVJNAfdcYR45zZq5PUteWZYk/yvJXOKB4qoUhMIVqnCPG1dkPWMsQx+MOLus7K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545945; c=relaxed/simple;
	bh=9w3sSeCx65Hhnr6yJDVNN4KYeuwBUZ7QJ/H24SkljVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aBs6+NF8/H21hAjLbg3LlFyadT2zN45g8Dhxkn4pkWYVCNvJkA9w70z+A8U+7o6P8JKFg4v8aJH7+S3ZkfnKmwC8Lywici6qTp9V8cj9ievlxS8Vrp7KWknIKGkyDCpAjlN+BaTaKJgEu+7Fl3TmBvKC78PAe5eXMZ75r2rmpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLnfqSWJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLnfqSWJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E431F000E9;
	Wed,  8 Jul 2026 21:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545944;
	bh=XqwfK/Z90Q+KdMAdXaJM3gOLqMFhhyvnf2mASSVyX7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZLnfqSWJMnjs6wgfCloeeBZOxewqDkLEhlUelwUZmu4ha1CRDFvfs6xU7xRe05HkQ
	 TpaSH8QyipIxa1DQd+5EEfOO8qNPQhvBm8NXfu2pELZFeO1gTwZWVpnjJMTgDxz55p
	 6TrO0P/3FpIGoHbAK4/RTe8NODLRnKTQMVk90+QQht9jIKH1B960axZzHaz4/IHaj1
	 FgEqx2S62hhDi3KJ7rybHlGbMu28B2YbBWnuGGQKsp0WMHiOMTS+ryhjZy1tlvxU3P
	 eL0RaFt2+nw+NuUq461t5P084dvFawRR3gDUhE9CsNL5YhKIAwN43Jpt6WDBdR0G9w
	 QO+jlpA0EanIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/4] bpf: Account scratch buffer in
 bpf_prog_calc_tag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daniel Borkmann" <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708211537.371874-5-daniel@iogearbox.net>
References: <20260708211537.371874-1-daniel@iogearbox.net>
 <20260708211537.371874-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 21:25:43 +0000
Message-Id: <20260708212544.48E431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing memcg accounting for the temporary JIT scratch buffer `r=
w_header`.
--

--- Patch [4]: [PATCH bpf-next 4/4] bpf: Account scratch buffer in bpf_prog=
_calc_tag ---
commit 57c46cbb1e055c7c0a73414dd57ed04bc1cb8b73
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: Account scratch buffer in bpf_prog_calc_tag

This commit updates bpf_prog_calc_tag() to use GFP_KERNEL_ACCOUNT for its
vmalloc scratch buffer. This ensures the temporary memory, which scales with
the program size, is properly charged to the loader's memory cgroup.

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -305,7 +305,7 @@ int bpf_prog_calc_tag(struct bpf_prog *fp)
>  	bool was_ld_map;
>  	u32 i;
> =20
> -	dst =3D vmalloc(size);
> +	dst =3D __vmalloc(size, GFP_KERNEL_ACCOUNT);

[Severity: Medium]
This is a pre-existing issue, but since this patch correctly applies memcg
accounting to load-time scratch memory, should we also account the
temporary JIT scratch buffer?

Looking at bpf_jit_binary_pack_alloc() in the same file, rw_header scales
with the program size but uses GFP_KERNEL instead of GFP_KERNEL_ACCOUNT:

kernel/bpf/core.c:bpf_jit_binary_pack_alloc() {
    ...
    *rw_header =3D kvmalloc(size, GFP_KERNEL);
    ...
}

Does this missing accounting allow a process to bypass its memcg limits by
triggering concurrent JIT compilations?

>  	if (!dst)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708211537.3718=
74-1-daniel@iogearbox.net?part=3D4
