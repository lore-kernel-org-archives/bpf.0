Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845183FDBFE;
	Wed,  5 Aug 2026 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922376; cv=none; b=XRij57lTWMoFAFMKj4RNFsrV9B+X6LwC4kjxvVItqb8iU58jw6Czz4N8Fyus96RJ4BN4hiZtOYEQ3MsENHkiPFJQRznlHpetsCjshUqSo16Gn1kWd48LIHjWmn+3MraJINPCUJj7fD7IgR9+DzmHhlsmpIYnUfRhwMNJXJXTYBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922376; c=relaxed/simple;
	bh=mjwNKfmguINfE8famuXuBmFGkPMhvK3rwl3FIheRUU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lwoaihpNctoegdMLshkpJEgVrmjNaiDdMTb0y85mpKPkcN2TOzdYi6P74WJDudcWQ/2p7/DmH+RhgFWLaL2pFJ2eelsPL2r+BGpyOz1uUIwiNECTiL0BLzhQ4wh1PEw+Qg0b+0TH3cvpH/3Jja5IP/LoX7spNmwlLBFuQgW/yzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOzp8wEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOzp8wEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636CC1F00A3A;
	Wed,  5 Aug 2026 09:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785922371;
	bh=zw9qYlpt5uINRefD5tX3v7mfMJjvMEr6Upn3njNK8XE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOzp8wEEz+uH7ZI91iH9ig/4CTKrveW4XhBHRIVynmmzHCP/d3nI6Tu2QKu6+wB6x
	 12rOGxLkXpGv7Kdef3KavnJO+2CD4xhESYZgW2SXv+XB4tBw/Pa3lPxRVWjXc5AIv8
	 DHBaHiCiamXNPlMkgex0Qf+POoazaE57BQ/6Uy+5mDNkLBXrMbpHeho9TH7dWbV1cO
	 ioqtLIEuHGGkzGmzTGe3ewVswAQtzmETm8h/YxxfHZc7FB6g0pfEgyx9D1GbV02rax
	 3ZbnGvWZnLz7Ibaw9La/GDg2l+ussdEwt0i6dot/hVIRAzSadzJ/DrGVHBz5UPeE5m
	 OouOlieyE+fEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Add a sleepable page allocator for
 map memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260805091720.139924-2-jiayuan.chen@linux.dev>
References: <20260805091720.139924-1-jiayuan.chen@linux.dev>
 <20260805091720.139924-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 09:32:50 +0000
Message-Id: <20260805093251.636CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Using __GFP_ZERO to zero pages intended for user-space mapping ski=
ps required dcache flushes on cache-aliasing architectures.
- [Medium] bpf_map_alloc_page_sleepable() and __bpf_alloc_page() silently b=
ypass task/VMA NUMA mempolicy when the requested node is NUMA_NO_NODE.

Pre-existing issues:
- [High] The fallback allocation path in __bpf_alloc_page() omits __GFP_ZER=
O, returning uninitialized kernel memory that can be exposed to user space.
--

--- Patch [1]: [PATCH bpf-next v2 1/4] bpf: Add a sleepable page allocator =
for map memory ---
commit 2a4210c942ca919834ce20218ab8bedc6cbb40a8
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Add a sleepable page allocator for map memory

This patch adds bpf_map_alloc_page_sleepable() to provide a blocking page
allocator for sleepable contexts. This avoids using the non-blocking
allocator, which never reclaims or engages the OOM machinery, for contexts
that can actually sleep.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8d111da886553..67d8157c6623e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -602,15 +602,14 @@ static bool can_alloc_pages(void)
>  		!IS_ENABLED(CONFIG_PREEMPT_RT);
>  }
> =20
> +#define BPF_PAGE_GFP (GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT | __GFP_NO=
WARN)
> +
>  static struct page *__bpf_alloc_page(int nid)
>  {
>  	if (!can_alloc_pages())
>  		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);

[Severity: High]
This is a pre-existing issue, but does this fallback path leak uninitialized
kernel memory?=20

The call to alloc_pages_nolock() passes only __GFP_ACCOUNT and completely
omits __GFP_ZERO. If a BPF map is allocated on PREEMPT_RT where
can_alloc_pages() returns false, this could expose uninitialized pages to
user space.

> =20
> -	return alloc_pages_node(nid,
> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> -				| __GFP_NOWARN,
> -				0);
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);

[Severity: Medium]
When nid is NUMA_NO_NODE, does alloc_pages_node() bypass the task's NUMA
mempolicy?

Since alloc_pages_node() automatically resolves NUMA_NO_NODE to the local
CPU node rather than defaulting to the task's mempolicy, this could cause
pages to land on the wrong nodes for user applications.

>  }
> =20
[ ... ]
> @@ -636,6 +635,20 @@ int bpf_map_alloc_pages(const struct bpf_map *map, i=
nt nid,
>  	return ret;
>  }
> =20
> +/*
> + * For callers that know they run in a sleepable context, e.g. a user pa=
ge
> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
> + * program context - notably it is always false on PREEMPT_RT - so going
> + * through bpf_map_alloc_pages() there would needlessly pick the
> + * non-blocking allocator, which never reclaims and never engages the OOM
> + * machinery.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
> +{
> +	might_sleep();
> +	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);

[Severity: High]
Does using __GFP_ZERO (via BPF_PAGE_GFP) skip required dcache flushes on
cache-aliasing architectures?=20

When allocating pages destined for user-space mapping (like the arena page
fault handler), __GFP_ZERO uses clear_page() which leaves zeros in the
kernel's dcache. Could user processes reading from these pages see stale,
uninitialized physical memory instead of zeros?

[Severity: Medium]
Similar to the issue in __bpf_alloc_page(), does using alloc_pages_node()
here bypass the task mempolicy when map->numa_node is NUMA_NO_NODE?

> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805091720.1399=
24-1-jiayuan.chen@linux.dev?part=3D1
