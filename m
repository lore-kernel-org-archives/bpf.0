Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D703AF643
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561020; cv=none; b=gNmzqUyJMzVoW0Zs6XG8rEXNr8OGnrj7IPdKNb8bbIzxbHxHlj7uSX7hCdavFsZMSsY4rZjwlRLCO6rAEj2rvLKZNifIAWMOXD3w7ZUXte/9rC2EC1diOd48aUcYGLfV/rqiO6HKO7xHym6DzonEXwM/80hR4s9e7bPXSNWUK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561020; c=relaxed/simple;
	bh=zfV53D9AytvRC2ddkEKFrfhcUymgxKOEu6qXGeDpmmA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d+doVdgyIk7f8sxIOlwvGnyssKVt10/UIB20ji5LgutDtx21OFIsdXPl3DoegjCupGo+6jpzq7dtf9JarQ7NJkDGebx4Ozne3qwj7K5a6OribyHTx3rsRTry7Cf7Y39k1/eu4m+wpRJ0tH0pqJu+xTQnGEhObP6LMt9wOfLvWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsYluLg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsYluLg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501411F00A3D;
	Mon, 24 Aug 2026 08:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787561019;
	bh=mW2nKuP9JfCJx527KgrhzlIBEwJXGKvfdbtpi4ba7qY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HsYluLg4WlSC1RVIwJYCArDij79sf++7clg4cHfELto78VXcR2INO3BABzEmaPeem
	 xigA/mxXerzYJDfZcaRnFnfBAOosGIBcOI/4VYbhJSa6jrQEXD5n4AlyIOgtiGR8iK
	 /As0EDEMK5XeT7GZhaGHS4ezUk/mRWzv4IU/WXhkkf9BJ97Rzr8xQitivqn2yGLRpt
	 I7rOQNiFnxTNdRXoJQpc+wtUUP44temWX7x8YyE/JbrX1W32kStyS/niDNNfjWNuwq
	 83pDveQxoGm+3ApToNxHjHuSRTxMRWQC2va5Q0CKvDuHQGLaR11bq95YXAKJ9DbjJ/
	 cAD1TsQMTJUdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] bpf: Add sleepable arena page allocation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824082530.47553-3-emil@etsalapatis.com>
References: <20260824082530.47553-1-emil@etsalapatis.com>
 <20260824082530.47553-3-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:43:38 +0000
Message-Id: <20260824084339.501411F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hard lockup via integer overflow: `data.i << PAGE_SHIFT` passes an=
 astronomically large negative size to `flush_vmap_cache` on mapping failur=
e.
--

--- Patch [2]: [PATCH 2/3] bpf: Add sleepable arena page allocation path ---
commit a93c0f542ad1ecf8f00cde8cf86699ce952035a7
Author: Emil Tsalapatis <emil@etsalapatis.com>

bpf: Add sleepable arena page allocation path

This commit adds a separate sleepable allocation path for BPF arena memory.
It preallocates memory before taking the critical section to prevent
frequent allocation failures from sleepable BPF contexts.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index da356989786a0..126ddae763f9a 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c

[ ... ]

> +static long arena_alloc_pages_sleepable(struct bpf_arena *arena, long pa=
ge_cnt,
> +		long uaddr, long pgoff, int node_id)
> +{

[ ... ]

> +out_unmap:
> +	/* data.i pages were mapped, undo only those who failed to map */
> +	flush_vmap_cache(kern_vm_start + uaddr32, data.i << PAGE_SHIFT);

[Severity: High]
Can this shift operation overflow?

If apply_to_page_range() maps a large number of pages (e.g. over 524,287)
before failing, data.i << PAGE_SHIFT will overflow since data.i is a
signed 32-bit int.

Because flush_vmap_cache() expects an unsigned long size, a negative value
here would sign-extend to a massive 64-bit size, potentially causing a CPU
stall or lockup in the flush routine.

Would casting data.i to unsigned long before the shift prevent this?

> +	range_tree_set(&arena->rt, pgoff + data.i, page_cnt - data.i);
> +
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082530.4755=
3-1-emil@etsalapatis.com?part=3D2
