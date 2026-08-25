Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519538DC60
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650351; cv=none; b=g6Gc7jX5dx0XZeCQhUjaMLZMiEUf3kriaBgW26PZuSxK6bkT5iKkNXbd2duO5HEt3KlpEH31jX50vkzqBWEHw7tobn84sobqPRr+IylMb7VTD+8+M5QWFWvYCSCoso77zTcv+RD+y0vViJx5N2+j8HHo7/LL+BxU8Xyo5uCnjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650351; c=relaxed/simple;
	bh=1+rvQhtKIOmtIYBPd4vIac79fjl1l9O5TkHApIhULjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MJBuLkaaEuY4f4GRBLzJOmvIJwWsn4xR4Rcd/pMy2OUBn9AE64W0w5pFnIJcyvK2ZXxQdL7xTqz/lfDEU9OScfqETd30vqznkQQ7DrWzkCRJA2ailhtyVDE6Mjl4sU//Sl+8LikwZ/Q+U22fBJdCJNrObNxoo15tWK1jwzuJX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLw25J6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLw25J6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE421F00A3A;
	Tue, 25 Aug 2026 09:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787650350;
	bh=uZXmWUPntyyMkXZNzh7YCukhQ3oyRVWZLefYbuUQ434=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CLw25J6dJN5wN67VARJx6RHYU9EJ7I15TAEYCQdMkNSenSLyKtRfL3l+u6mFfrCWX
	 sMf5XxG8Hs96aA7m4cjlLeZ3oZbZBktOvmcQunDYyO8P73rAT0w7/Gc0Fqoksp6eFu
	 3hADr6yzfCmJEIiffErJFe66PNmn7p+tQbecXmxKxkCcAfPQqpzA2rPJw1hjL8hk/s
	 DrzzUY5qhKb1MKMG5WJpmz6nFKS1x9zvNyVtxKREFdyBnKlVZxiwvtkfY+oATBQpYy
	 /XX0ULvxrLOJKf4Tt/w2gqzJuJztHGkVbz/KmvkyejkGCGdfE8eqekZcISqyax3YRR
	 3fPA36pdg9Fjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] bpf: Add a sleepable page allocator for map
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825091952.81971-2-ahemadkhawar123@gmail.com>
References: <20260825091952.81971-1-ahemadkhawar123@gmail.com>
 <20260825091952.81971-2-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:32:29 +0000
Message-Id: <20260825093229.DEE421F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Pages zeroed with __GFP_ZERO are mapped to user space without a dc=
ache flush, potentially causing information leaks on cache-aliasing archite=
ctures.
- [Medium] bpf_map_alloc_page_sleepable() silently drops the task's NUMA me=
mpolicy when the map's numa_node is NUMA_NO_NODE.
--

--- Patch [1]: [PATCH v6 1/4] bpf: Add a sleepable page allocator for map m=
emory ---
commit 11d1be8d3bd84294d43ef6eebff7ad635462636c
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Add a sleepable page allocator for map memory

This commit introduces a sleepable page allocator for BPF map memory.
It utilizes alloc_pages_node() with GFP_KERNEL to allow reclaim and
OOM handling, intending to be used by the arena page fault handler.

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
If this page is mapped to user space via a fault handler, will the use of
__GFP_ZERO included in BPF_PAGE_GFP cause an information leak on
cache-aliasing architectures?

Looking at bpf_map_alloc_page_sleepable() in kernel/bpf/syscall.c, the
allocator provides __GFP_ZERO pages. On cache-aliasing architectures, the
clear_page() function used by __GFP_ZERO clears memory via the kernel's
direct mapping but skips the dcache flush to main memory. If a page is
mapped to user space without the flush provided by clear_user_highpage(),
user programs can potentially read stale, uninitialized data directly from
main memory.

[Severity: Medium]
Does calling alloc_pages_node() unconditionally drop the task's NUMA
mempolicy when map->numa_node is NUMA_NO_NODE?

When map->numa_node is NUMA_NO_NODE in bpf_map_alloc_page_sleepable(),
passing it directly to alloc_pages_node() bypasses task NUMA policies
(such as those set by mbind() or set_mempolicy()) and defaults allocations
to the local CPU's node. This can result in pages landing on the wrong
NUMA node.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825091952.8197=
1-1-ahemadkhawar123@gmail.com?part=3D1
