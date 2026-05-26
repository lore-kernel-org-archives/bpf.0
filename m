Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF9D1C862F
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763948; cv=none; b=KD/SOvcWB0f8/4lyQwdo93ZfEgRvGDKRzeBx2PEOfMKnzGERyc3PrJLI8BtuRiBLAcC+8VydWRU7vp0EqbnaJG6TLMM8R1sULW3LCiijOFD+akywpLuqzPs85nMjGpnNdGdcb9ig4EZxCzIw/RIyJ/8omLke+BWldjjM1SPJEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763948; c=relaxed/simple;
	bh=5RkxAJqyXU1rhiHrKkZSRjlW+HVOrESNIP8RAbUjLOQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZsGxl1suTZjxZ8d6zbqSp/Ho1+ARkmd2gPSSEPBUArZzHgLa9a+ys8ypLu9iwqdJA51eJwUrLrKnZwMweTIEB1ZGwLalXdHgKvymcykqJjjRTfoq9N9MFuxw6nqfgyqJqWzt8JLHTr+kC0L4qTFwZLWPeUDWiwR5xfauEuRZ0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2UVY0iK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2UVY0iK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6B71F000E9;
	Tue, 26 May 2026 02:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779763947;
	bh=dbDeevtOOAIgJ0g64hjHIKr+72hf/XltTsMUGivFd3M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2UVY0iKDpvwfEqmWah1f22FTrmvasr9T0kbj4Dt5IiyFMwLC/p31CCJAhSADS/eu
	 MSFLRbw1VrCgZM6dgTCDiOE18aYoSiHWGjO6CEIqQa6lPw/k1D1GjTY9nKH6FAHp3z
	 /kd2D4ADEbOLlxt6lT3CLIiqAdaZCy7QtojNQJmPazJe812h+IwG+sQFfRiLUL0YyW
	 pqwHNzmXlPMSwqYjwYXduuURfl0j5b1KIuoYcljlPpF7xB3aXjsZ+I9sAvK2iZTCjs
	 Csbmjwiub4dwIt58opdgPib+ga3LU/vSRrj8zDz7jwr6wgtVpHW82ihpAWv1viAP4r
	 QrzekeYkJRUwQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH bpf-next v7 07/11] mm/bpf: Add
 bpf_try_to_free_mem_cgroup_pages kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, bpf@vger.kernel.org, mkoutny@suse.com
In-Reply-To: <13b10d91aff4307580d1a601f1592efe42a92b05.1779760876.git.zhuhui@kylinos.cn>
References: <13b10d91aff4307580d1a601f1592efe42a92b05.1779760876.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 02:52:26 +0000
Message-Id: <20260526025227.1B6B71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The kfunc `bpf_try_to_free_mem_cgroup_pages` returns `-EINVAL` on =
invalid arguments, but its return type is `unsigned long`.
- [High] Unsanitized `gfp_mask` passed from a BPF program to direct memory =
reclaim creates a potential deadlock with filesystem and IO locks.
- [Medium] The `bpf_try_to_free_mem_cgroup_pages` function is missing the m=
andatory `__bpf_kfunc` annotation in its definition.
--

commit b01a6dd524da08098df4a7bba12f4b90457b1089
Author: Hui Zhu <zhuhui@kylinos.cn>
   =20
mm/bpf: Add bpf_try_to_free_mem_cgroup_pages kfunc
   =20
This commit introduces the bpf_try_to_free_mem_cgroup_pages kfunc, allowing
BPF programs to trigger memory reclamation for a specific memory cgroup. It
delegates to the core try_to_free_mem_cgroup_pages function and includes
custom swappiness parsing.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 1f726a7b22e36..0353c8736aa5d 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +unsigned long bpf_try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
> +					       unsigned long nr_pages,
> +					       gfp_t gfp_mask,
> +					       unsigned int reclaim_options,
> +					       int swappiness)
> +{

[Severity: Medium]
Is the __bpf_kfunc macro missing from the function definition? Without this
annotation, the compiler might inline or optimize out the function,
especially when LTO is enabled, which would prevent the function from
appearing in BTF and cause BPF program load failures.

> +	int *swapiness_ptr;
> +
> +	if (swappiness > SWAPPINESS_ANON_ONLY)
> +		return -EINVAL;

[Severity: High]
Does returning a negative error code from a function with an unsigned long
return type cause issues for BPF programs? Returning -EINVAL here will
result in a very large positive value. A BPF program might interpret this
massive value as a highly successful reclaim operation rather than an error.
Should the return type be changed to a signed type like ssize_t, or should
it return 0 on validation failure?

> +	else if (swappiness < MIN_SWAPPINESS)
> +		swapiness_ptr =3D NULL;
> +	else
> +		swapiness_ptr =3D &swappiness;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask,
> +					    reclaim_options, swapiness_ptr);

[Severity: High]
Could an arbitrary gfp_mask passed by a BPF program cause a deadlock?

Because the function is KF_SLEEPABLE and gfp_mask is not constrained, a
BPF program executing while filesystem or IO locks are held could pass
flags like GFP_KERNEL.

If direct reclaim recurses into filesystem shrinkers, it might attempt to
acquire the exact same locks, leading to an AB-BA deadlock or system hang.
Should the gfp_mask be sanitized to strip flags like __GFP_FS and __GFP_IO
before delegating to the core reclaim path?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1779760876.gi=
t.zhuhui@kylinos.cn?part=3D7
