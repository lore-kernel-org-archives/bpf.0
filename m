Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789C231832
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776444915; cv=none; b=sRpLm/3XcBIhNrT8TtepeBIXOO/tSGFco0vFAyxI4Y8BnmGVcOUe4vHW/FQKXXYkkOscR/olz1G7s1WrozUoW8UlwX34A3nQ5YbS9VRI4rbnwvIv7NVBfI59m4lg2FLuyHk49QI0btLVCywc6SkVhf8jWCh9Kc21Ifog5RH8gys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776444915; c=relaxed/simple;
	bh=/lAPLi6sJX1zv35koxs4BTxe7oIjxkNkiaphK6wNLVs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pVF4AzQbSoaUamD1eutgSRUvNsoyWmB5Hxvftap1f9y9xQzKOKJZ+bYxcougVXYytmoM0ahd/SlRNcIc4z5PQA3Mnt/0IOcgQp5n2KjF9pwyTYtiC2JvRacb+PYscEYoO2xOe+kGT7w4UzmKFDhtS0wLJTDtl4FQDIMQnb85rK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hahIdCcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hahIdCcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63952C19425;
	Fri, 17 Apr 2026 16:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776444915;
	bh=/lAPLi6sJX1zv35koxs4BTxe7oIjxkNkiaphK6wNLVs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hahIdCcPaGZV4xhVdgvmjCQ73KcHhHWMVj72XvEIiL90If4CmJkWfS37U6e+9jZ9o
	 F2+3lqQ8Og7sg9sk3LNM6gtsvjpcF64xHkCpMZkhmM5/CM+S8/ttdNsHRQQZwvZDNv
	 SM6Eju/DNhneABIzMz5M7nFYxc8mkJ2qR1MKtYkXCApnbP8jKidcci8iHafWBFp+3c
	 qQHGOBqchkmZAIU5VHljauEgwZq8qz2WpISOr60obtNcOA18+kQCueZChmP3h1bhW6
	 UtP3spdqu3avlTC7iQ6tM8P6U6ZxU9/j2BQjT1A978sNjhWw19McSICJ+ZVeW2xk9+
	 5nqqYzt6wyh5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Validate node_id in arena_alloc_pages()
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260417152135.1383754-1-puranjay@kernel.org>
References: <20260417152135.1383754-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Apr 2026 16:55:14 +0000
Message-Id: <20260417165515.63952C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] This problem wasn't introduced by this patch, but apply_to_page_ra=
nge() is called within an atomic critical section with IRQs disabled.
- [Medium] Validation of user-provided NUMA node ID uses node_online() inst=
ead of node_state(..., N_MEMORY).
--

commit 312a17d46d0e6285c5b29bc93a445829df8c62c7
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Validate node_id in arena_alloc_pages()

This commit validates the node_id parameter before passing it down the
allocation chain in arena_alloc_pages().

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 9c68c9b0b24ad..523c3a61063bf 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -562,6 +562,10 @@ static long arena_alloc_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt
>  	u32 uaddr32;
>  	int ret, i;
> =20
> +	if (node_id !=3D NUMA_NO_NODE &&
> +	    ((unsigned int)node_id >=3D nr_node_ids || !node_online(node_id)))
> +		return 0;
> +

Should this check use node_state(node_id, N_MEMORY) instead of
node_online(node_id)?

A node can be online but memory-less, such as CPU-only nodes. Passing a
memory-less node down the allocation chain could ignore the user's
placement intent and cause unexpected allocator fallback.

This issue isn't introduced by this patch, but looking at the surrounding
code in arena_alloc_pages(), is it safe to call apply_to_page_range()
while holding a raw spinlock?

arena_alloc_pages()
    if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
        goto out_free_pages;
    ...
    while (remaining) {
        ...
        ret =3D apply_to_page_range(...);

Since apply_to_page_range() can sleep when allocating page table entries,
could this cause a sleeping function called from invalid context panic since
the spinlock disables interrupts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260417152135.1383=
754-1-puranjay@kernel.org?part=3D1
