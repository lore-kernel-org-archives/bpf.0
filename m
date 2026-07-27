Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AD3DAAD4;
	Mon, 27 Jul 2026 06:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785134231; cv=none; b=DFx7blTeZTGJ+QZE9U0PIjgcOMooqvOiDi2aF7RRH7YVqs+oi2PT+1MDaXcAyim6h2K9jrtnF7VWP5sCz4utNNIxWfp15AWl0zXyQt/+1TiGSrhisdgLy0SAPnoh58j2IvezSG8uorluWZalNBxA+secQ9Wzy3+rawCmjKjnkso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785134231; c=relaxed/simple;
	bh=/RGcTVT4rqHTsGZ5rX8KrUr9gH/FUZqxDCspVAPrhtY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9n2wVYMoa2FDjRLFXtT8Xn2+9nSQU3xBVpmqJvWSpURgr/5nYA93uyiGLuibVUoG+0L25LarHXAj0PnB9wyFmyhPSsm+SXI1aF70RGQrr7I7l7oWTgp7RsIsWWxD5VS1LAwv90H/7XcbKJtLysNew3H1SDsbXizpKcKHdQ6QKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuoBJNK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuoBJNK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F3B1F000E9;
	Mon, 27 Jul 2026 06:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785134229;
	bh=CsX0c5I6IcTNrRLJuL360y3d38COmxrp71ovedV2GZE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DuoBJNK4LQIDwk1ypFeLwX/5Bz0cGXbZg+omdAQyzv6T+lk2nBqsrJS1mMbPTkxf1
	 u1m1s5FPhrpUQfXA7KRLqHFXonJmO/6+yr/YHgRHZVKQ+tLjFvuN8XzDBKgqQrv/6D
	 V7hYrikHWU2FbWl3q2Fa4XNf8J2h8Jl0CNS2p3Hz43JJ2CaB9Znb+66NJjigjkDjEA
	 BIG6fSOHEIIcTICitOqlx9LsFeMWKe5B4yRsK7h0mEkUfKkMVaEYGs7azRuNkiBbq7
	 RUQKfrPnBF8HYBmcsp1IuuFjmjsVFsvTYC1Ay8R+CGw9tTQZmRhy+EziTRgmf/+CMt
	 tsFAHntA9U0Xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for
 map memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260727062521.376231-2-jiayuan.chen@linux.dev>
References: <20260727062521.376231-1-jiayuan.chen@linux.dev>
 <20260727062521.376231-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 06:37:09 +0000
Message-Id: <20260727063709.99F3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] NUMA Mempolicy Bypass in bpf_map_alloc_page_sleepable() and __bp=
f_alloc_page()
--

--- Patch [1]: [PATCH bpf-next 1/3] bpf: Add a sleepable page allocator for=
 map memory ---
commit 7a6023ef7f19fc884e94ffe457ae83ff0d4b5e1e
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Add a sleepable page allocator for map memory

This commit introduces bpf_map_alloc_page_sleepable() to provide a blocking
page allocator for callers known to be in a sleepable context, such as user
page fault handlers. This avoids the conservative, non-blocking behavior of
can_alloc_pages() which is always false under PREEMPT_RT.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
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
> =20
> -	return alloc_pages_node(nid,
> -				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> -				| __GFP_NOWARN,
> -				0);
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);

[Severity: Medium]
This isn't a bug introduced by this patch, but does using alloc_pages_node()
here bypass the task's NUMA mempolicy?

Because alloc_pages_node() ignores task mempolicy, pages might land on the
current CPU's local NUMA node instead of the node requested by the task.
Could this branch to use a mempolicy-aware allocation when nid is
NUMA_NO_NODE?

>  }
[ ... ]
> +/*
> + * For callers that know they run in a sleepable context, e.g. a user pa=
ge
> + * fault handler. can_alloc_pages() is a conservative guess made for BPF
> + * program context - notably it is always false on PREEMPT_RT - so going
> + * through bpf_map_alloc_pages() there would needlessly pick the
> + * non-blocking allocator, which never reclaims and never engages the OOM
> + * machinery.
> + */
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map, int=
 nid)
> +{
> +	might_sleep();
> +	return alloc_pages_node(nid, BPF_PAGE_GFP, 0);

[Severity: Medium]
Since this function is intended for user space page fault handlers, will
unconditionally calling alloc_pages_node() cause the allocation to ignore
the user task's mempolicy?

Similar to __bpf_alloc_page(), if nid is NUMA_NO_NODE, replacing this with a
mempolicy-aware allocation might prevent silent performance regressions from
misaligned memory placement during page faults.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727062521.3762=
31-1-jiayuan.chen@linux.dev?part=3D1
