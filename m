Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC93EDAA3
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650090; cv=none; b=m6dHUB2ajETz+PklfFscNHvxUY9V3X1ymFjAPjMvAfFJaB+te8YzUDzANX+lLPzqmX2B7EFMm+nbzY6S3A0KIfiqagj5yuLAgEpMzY6wLUSaiRDcB8W7dCgR4KDIvmQZor/t3h5ccPt7NgeaNwz0Gn6nLnPDBulg0u07B6snuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650090; c=relaxed/simple;
	bh=31CVPDNVFza2GjefPUCv0HmB7fmrEtoL8BmX1+bRMVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HAbBC2FhGKnNMBGvSTqkOMBBRwgUOAvBKd7zRZFLV6wHE/PrUHB/7RWR84Qagbleno/oeXCCbN+4+DV7aC0APci9tNCfd0UlQRKeOTSkpzZ/Wn7efUh+aeIAwsshGGzP0/6YLDtVxVKO/NuYe4tmbg+yGsTljiHH8y1gSUcdrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf37C7gN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf37C7gN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D1B1F000E9;
	Tue, 25 Aug 2026 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787650088;
	bh=DzYRzOH0XfeUCLU55z0odaMVQj+cSyPVZFrrrajZy44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jf37C7gNDxVFBRM//UFRYW2Y23RtRYdad7NJ5G40HqoVniXJpF+fYQ/KmrdqaiPqZ
	 OOEh4+7ppM9RXgBV5VvsjQdqoIuBD4C8sjc2wF/JMuIWRBcEui046BD8ENIYggJuU4
	 MESF2gDwosmTJIsp4agho3lxLwkkiR/EPhUugr15nraTZGweuDVtRPPGI1ZVAN8UeN
	 jxs8j7Hlbw7nKYFOBt6R1Xnia6qD51D4v4b6dBKLN0dyEhC8NPy0RZozVCB/LkckX6
	 XnREBWFzyGcwcNaW5CObmaB127bqLiO4Ej2ywE7uNY+phco8UA3rvmSZSviYf1GZqZ
	 zI9YBFhb2LYUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] bpf: Add a sleepable page allocator for map
 memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Khawar Ahemad" <ahemadkhawar123@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260825091647.81632-2-ahemadkhawar123@gmail.com>
References: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
 <20260825091647.81632-2-ahemadkhawar123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 09:28:07 +0000
Message-Id: <20260825092808.60D1B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pages allocated with `__GFP_ZERO` for user-space mapping (BPF Aren=
a) lack necessary dcache flushes on cache-aliasing architectures, potential=
ly leaking uninitialized kernel memory to user space.
--

--- Patch [1]: [PATCH v6 1/4] bpf: Add a sleepable page allocator for map m=
emory ---
commit 50003cab10c1c00ca87711f66767e18f684829b8
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: Add a sleepable page allocator for map memory

This patch adds bpf_map_alloc_page_sleepable() for callers in sleepable
contexts, such as the arena page fault handler. It avoids the non-blocking
allocator and allocates a page directly from the map's NUMA node.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af0..f9b81638e537a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

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
> +struct page *bpf_map_alloc_page_sleepable(const struct bpf_map *map)
> +{
> +	might_sleep();
> +	return alloc_pages_node(map->numa_node, BPF_PAGE_GFP, 0);

[Severity: High]
This isn't a bug introduced by this patch, but does the use of __GFP_ZERO
safely zero user-mapped pages on cache-aliasing architectures?

The __GFP_ZERO flag zeroes memory using clear_page() via the kernel's
direct mapping, which skips the dcache flush provided by functions like
clear_user_highpage().

On cache-aliasing architectures, this can cause user space to read stale da=
ta
directly from physical memory if the zeroes remain in the dcache when the
page is mapped to a different user space virtual address.

Since this function is intended for the BPF arena page fault handler to map
memory to user space, should it instead use user_alloc_needs_zeroing() and
clear_user_highpage() or folio_zero_user() rather than relying on the
__GFP_ZERO bit in BPF_PAGE_GFP?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825091647.8163=
2-1-ahemadkhawar123@gmail.com?part=3D1
