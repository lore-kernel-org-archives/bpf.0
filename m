Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897D049482E
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379998; cv=none; b=pFn+bTJTZreLIbnSLt9D3RfeIXlGse6/aZvRqgI3G7D1yNjFGMXgqbP2AgkprVFoA70f3leI/jW1ey0vCy4M2LK4kmvtjzCnpq5RarU0hJD9o9yCRpkL1W3eQULyvvUoPEFTHy0+BaCBtRKnJU6v0IDplczpNJKJjZXS3S9/b/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379998; c=relaxed/simple;
	bh=k7Lp3ayr7SQvfSvs3rfM27fL0Mjj8o2ct4BMfFzbm0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vl7zPoyoJXt3IcQi5QWV6Ekl2dYgcoysXPn3G1v02bblFxvt7+3kRzQdIK+kB8sFZrfOOg6eICuumMgdPg3N/G1AsbPHZDhurOp9jVLzW8GoHMHsXD9HHvR4FzlwQOk0A+rJR/BYeS2nhttkZ8Xmnou1KoqBd6NoFw1AyrM6/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eijUAVXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eijUAVXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC33F1F000FF;
	Fri, 25 Sep 2026 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790379993;
	bh=TaWvETN4DWEk5UKCSue4WTryzuWiXaQq7p16D4S/ua0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eijUAVXtU6Dvnl4wXDik4xGWjRPL0FjemIjElO4o/oBqjuMw3y3IfLBon+9olXeOB
	 Bn2NKfjKJV1TES54fZ2GGIPYm5C4ffu+INTZfbod9OJ2PgtO+Xr6446YKDkNtkr1KU
	 nr7yZFB9yP0du9Y7l01gtnKowA9jCVCMzpHfYoIkJzVV0w7s9I8O2i+eeh8z4EhQDi
	 DUmVZkw+uGDK7ZlngUfYQP93zppVMPrCFi+uQHnC4s0dBNfh5ZbNZzRMcWi8Whuu6o
	 9tTFNxzpP91nSIdZfBO8lzP+7kW+J7WB5m9JP46HYwr8cxwLetX9VDmtu6Y0fgyS50
	 5REjGK0inX1Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Add sleepable arena page
 allocation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925233538.5708-4-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
 <20260925233538.5708-4-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 23:46:33 +0000
Message-Id: <20260925234633.AC33F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: CPU lockups and memory pressure due to massive page allocatio=
ns before range validation
--

commit 0ff0c13da92aa5b627b22373d01f9a6a0085c43f
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Add sleepable arena page allocation path

This commit modifies the BPF arena allocator to allocate physical pages
outside the spinlock. This allows sleepable BPF programs to use the
blocking allocator slow path when under memory pressure.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> @@ -747,8 +769,12 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>  			/* requested address will be outside of user VMA */
>  			return 0;
>  	}
> -
>  	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +
> +	ret =3D bpf_alloc_pages(node_id, page_cnt, &pages, sleepable);
> +	if (ret)
> +		goto out_memcg;
> +

[Severity: High]
Could this early allocation trigger system instability or CPU lockups under
pressure?=20

By moving bpf_alloc_pages() before the arena_adjust_tree() check, a BPF
program can request a huge page_cnt (up to the entire arena size). Because
the physical pages are allocated before we verify if the requested virtual
address range is actually available in the range tree, this could result in
massive physical memory allocations and blocking reclaims.

If the requested virtual range is already occupied, the allocation will just
immediately free everything when the range check fails under the lock. Could
this be used by a BPF program to induce excessive memory pressure?

>  	data.arena =3D arena;
>  	data.pages =3D &pages;
>  	data.i =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925233538.5708=
-1-emil@etsalapatis.com?part=3D3
