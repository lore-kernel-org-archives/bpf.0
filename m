Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2383C7696
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787122236; cv=none; b=mqZUv8qqnXSCzB8CPxnPtSM792Xwg5lbD4AfIJbbsXTRU0wdLNAVGQSeNvbduxpX2+olvJTxHxNBLMIxde5bmg8jjRJS2pIHcGYmWdfmhkID5GR0pxsypWYXaNQ+vf7cS3jQFZqlnjIL6HH1s9oK8WUVgyDWq7dV2J+tW+WSyzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787122236; c=relaxed/simple;
	bh=n2B4gQjZF5AArEGdz8osAqTuoOCA9DQ6ek6s+wZme/I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YemVxyuQLm2mnsNJ6gk6KXQud7y+Pls8QD5TTbhcoxn3i+RbK6RrWzkrPVLsP1H2eqD3HXkAye/jQjlISNBiHLNr5ANShr4L2j6UmUsjykPZhSUW5ChPa+eoVEWod6yLBkj7C8Ok9yoazcOEfofh9cu3GpYXubs1j6Bnn51stW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5medLCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5medLCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0786C1F000E9;
	Wed, 19 Aug 2026 06:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787122235;
	bh=xnioa/AxbMZpXtnONYexSBCkLYTvuyeYK3bYc4IHGlE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5medLCfFLc05ITqve/fijL/RTRkoRBn8XITIucYeYJv+gbOM6Nq46SjR/jy7IMzP
	 t4qsMMXCjUAH1Wnm0oCh6n3BHZcmEcZh7G6E7Tmx0Fpkd+jHZ2OdZXYAoT33P9StR9
	 9Ains/7G81xfvbuHzVP04FebnCBPDhL1PGqJEGPgmcEXqP45g0CyyRb9yL4j97BaE1
	 zLC36cNVhmxOxQ8pJS8mk1dIVJArVMPlJt0alsw2H0OQhI/rC+rC92vlvfkd/oPQrU
	 l1jNL8ysz6pcRRBMZ5TYHl/n6qxh8gz9Zg0kinQhUUGs2GxzyMjp19ZHcwCYv5HjJ8
	 RO3IPwYQyW3tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] mm/bpf: Add bpf_proactive_reclaim
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Zhu" <hui.zhu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <0a2355a169c0900427b6e3c0d73ca6ae1be56f13.1787120833.git.zhuhui@kylinos.cn>
References: <cover.1787120833.git.zhuhui@kylinos.cn>
 <0a2355a169c0900427b6e3c0d73ca6ae1be56f13.1787120833.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:50:34 +0000
Message-Id: <20260819065035.0786C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling `try_to_free_mem_cgroup_pages` with `GFP_KERNEL` from arbi=
trary sleepable BPF programs can cause lock inversion deadlocks.
--

--- Patch [1]: [PATCH bpf-next v3 1/2] mm/bpf: Add bpf_proactive_reclaim kf=
uncs ---
commit 55d679bb7cd0ded2c29ec1fcf65b2396144cddad
Author: Hui Zhu <zhuhui@kylinos.cn>

mm/bpf: Add bpf_proactive_reclaim kfuncs

This commit introduces bpf_proactive_reclaim and
bpf_proactive_reclaim_swappiness kfuncs to expose memcg proactive reclaim
to sleepable BPF programs. They allow BPF programs to trigger one reclaim
pass on a given memcg with specific swappiness and size limits.

> diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
> index 716df49d76477..b0a0d4c55dc4e 100644
> --- a/mm/bpf_memcontrol.c
> +++ b/mm/bpf_memcontrol.c

[ ... ]

> +static unsigned long
> +bpf_proactive_reclaim_pages(struct mem_cgroup *memcg, unsigned long nr_p=
ages,
> +			    int *swappiness)
> +{
> +	if (!nr_pages || unlikely(bpf_in_reclaim_context()))
> +		return 0;
> +
> +	return try_to_free_mem_cgroup_pages(memcg, nr_pages, GFP_KERNEL,
> +					    MEMCG_RECLAIM_MAY_SWAP |
> +					    MEMCG_RECLAIM_PROACTIVE,
> +					    swappiness);

[Severity: High]
Can calling try_to_free_mem_cgroup_pages() with GFP_KERNEL from arbitrary
sleepable BPF programs cause lock inversion deadlocks?

If a sleepable BPF program attaches to an LSM hook or fentry point where a
filesystem lock is already held (for example, bpf_lsm_inode_mkdir where
inode_lock is held), and the program calls bpf_proactive_reclaim(),
GFP_KERNEL will allow __GFP_FS reclaim.

The memory reclaim path could then enter filesystem shrinkers which attempt
to acquire the same lock, leading to a self-deadlock.=20

Should this use a more restricted GFP mask, or perhaps dynamically inherit
the context's GFP constraints to avoid bypassing lock-context protections?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787120833.gi=
t.zhuhui@kylinos.cn?part=3D1
