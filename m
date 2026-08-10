Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89263AFD00
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356013; cv=none; b=sHV8fAqQULW3qBbrkjywdB3x6USqCGV0IcPg48y9KebW1pRmQhLndUIJztzUYmOewkt5Hhx07wcCD8rOraTXLFYP1sHi3wV/LMFHEQvznKVj9//WIcvdPWUurB/Zi8GGMqcyJGCbVXVP2Xj/EAd8V6ihN6KC7m5uqSSFI1Zvv10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356013; c=relaxed/simple;
	bh=xHAzgQxJ4fxfUxYo5LrnadKobetp2UOW8fugVuTi/uU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YztgsZclNY2ut836mak4EPKZ77Agi+tTiLSl0xunrDb10bW8vY8Tp/vzXNiSI37Zvt4R53K4HdFOdPKfXZY+B+voJPYWkaCDF5z+8aggPB14YlDf0oTw5aPg12yOPQzGGNLxkK8K7MIDI+Na/EHfnWJlK+LLjwZGJzWIagOGZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjdoDBCr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjdoDBCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095541F000E9;
	Mon, 10 Aug 2026 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786356011;
	bh=2hLAHUYblOfIEF+FVMWZsMkH0OCf2WCg1FnZg6GXQvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QjdoDBCrUwQVBB0No7hLM+lQ3MvFkIWp2qTQJSu4dhQ//3cUJHIHbDsmoc/V9M9e+
	 oeGm5A+h2NjmCZ1cxNMO7V19ljZv1GlUcuSXKdQF85KIXH1VTSJ3XKf6smLptXSK2u
	 20NMlEeEPQY/i2USxqr4jVkl//HIDVaWLp1ComQu1V/Tj+gd2C3jcdhKGPg9he02/a
	 0hYBcteqYahb34X1zQ8iE8uF+uNrAOcoDfXIUPWX763KiFYNLg0c91BG7QncF1TEor
	 CBQ2P8JG9wJb8j7CDqEmVIp6vZd6KDKDvH7QBYvMA36iavrZO6ASuxN2dYp3vRFbXR
	 eXMjYYxdEoBCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf, arena: fix range_tree_clear
 inconsistency on kmalloc_nolock failure
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810094634.2723213-2-chenyuan_fl@163.com>
References: <20260810094634.2723213-1-chenyuan_fl@163.com>
 <20260810094634.2723213-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 10:00:10 +0000
Message-Id: <20260810100011.095541F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `range_tree_set()` leaves the interval tree in a corrupted state i=
f node allocation fails.
- [Medium] Ignored return value from `range_tree_set()` leads to permanent =
virtual space leak in the BPF arena on OOM.
--

--- Patch [1]: [PATCH bpf-next v2 1/3] bpf, arena: fix range_tree_clear inc=
onsistency on kmalloc_nolock failure ---
commit d0c75ee613a9a640e30aac20ab84b5820201a99d
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure

This commit modifies range_tree_clear() to pre-allocate the right-half node
before modifying the tree. This ensures that an allocation failure returns
-ENOMEM without leaving the range tree in an altered state.

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff75..15b588377a769 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -143,16 +143,22 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
>  		if (rn->rn_start < start && rn->rn_last > last) {
>  			u32 old_last =3D rn->rn_last;
> =20
> +			/*
> +			 * Pre-allocate the right-half node before modifying
> +			 * the tree. If allocation fails we return -ENOMEM
> +			 * without altering the range tree.
> +			 */
> +			new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +						__GFP_ACCOUNT, NUMA_NO_NODE);
> +			if (!new_rn)
> +				return -ENOMEM;
> +

[Severity: High]
This is a pre-existing issue, but does range_tree_set() suffer from a
similar state corruption if its node allocation fails?

kernel/bpf/range_tree.c:range_tree_set() {
    ...
    /* Clear out everything in the range we want to set. */
    err =3D range_tree_clear(rt, start, len);
    if (err)
        return err;
    ...
    } else {
        left =3D kmalloc_nolock(sizeof(struct range_node), ...);
        if (!left)
            return -ENOMEM;

If range_tree_set() fails to allocate 'left' due to OOM, it returns -ENOMEM
after range_tree_clear() has already destructively removed sub-ranges.
Should range_tree_set() also pre-allocate its nodes before modifying the
tree to prevent state corruption?


[Severity: Medium]
This is also a pre-existing issue, but are the return values of
range_tree_set() intentionally ignored in the arena code?

In kernel/bpf/arena.c:arena_alloc_pages():
...
        ret =3D bpf_map_alloc_pages(&arena->map, node_id, this_batch, pages=
);
        if (ret)
            goto out;
    ...
    out:
        range_tree_set(&arena->rt, pgoff + mapped, page_cnt - mapped);

And similarly in kernel/bpf/arena.c:arena_free_pages():
    ...
        range_tree_set(&arena->rt, pgoff, page_cnt);

If range_tree_set() encounters an allocation failure and returns -ENOMEM,
the failure is silently ignored. Could this cause the freed pages' virtual
space to be permanently leaked and inaccessible?

>  			/* Overlaps with the entire clearing range */
>  			range_it_remove(rn, rt);
>  			rn->rn_last =3D start - 1;
>  			range_it_insert(rn, rt);
> =20
> -			/* Add a range */
> -			new_rn =3D kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT,
> -						NUMA_NO_NODE);
> -			if (!new_rn)
> -				return -ENOMEM;
> +			/* Add right-half range */
>  			new_rn->rn_start =3D last + 1;
>  			new_rn->rn_last =3D old_last;
>  			range_it_insert(new_rn, rt);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810094634.2723=
213-1-chenyuan_fl@163.com?part=3D1
