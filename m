Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E952DC357
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 03:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986097; cv=none; b=sYJ4iYv2LGI7o8QveXF5kW2BI5kn7lizlwHHgCHc6v3n+DEIjh/BthGwOG3/AUjl5cITrcC1O2mtVBPUxqAnnqif6+2lKlzOiI7HY4k0qxBo8WlmlcGpfk+70OHTF9FS8skxJNjQe7MXeauqZztfnsszg0oy3X7EwZGGUExGe7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986097; c=relaxed/simple;
	bh=wePU6JOYwiDsJGzp6LtFPVpLZra4WfRocq96r/FGyRw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bfO/VqAz9qlaS+gmAhywNJBOYlymVWSdgwmxVn09ntz0dwistWad1d2woaBu9J+Fru+8H1b17j7oKQGreIHqQBhaHe7Q9WEcLM6OyRSmE3EpKeAIgMpwAcdWOKjrqdiVqf64sETbkfCz4O6kmBs582u7opBIPZ4Xhbt56QlgImo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVGOTcUg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVGOTcUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06D31F000E9;
	Thu,  6 Aug 2026 03:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785986096;
	bh=PYi/PuirB0XSqxCwDjdffpllUk5p07G7HL+UK78Nmfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZVGOTcUgUPrieIGOZyKCaHTiIK9tcFOlAWQ6+2ppqRQE7coyMrmla2IIOSSxgNIBi
	 dx9Mlguxx+Zaml/FAUi5mVtVaDaLHOn0cMSCvnzoZLF642UIlp+s3wTqflzrX95ygr
	 OCfQ1hBjYn03wwdsVoeoXvL0W9NJtsS/ym8FGeh7lA/db0+uTtgan+mTufYUcMI5AE
	 G4/Qnj6yE06w+aze8KZxcBrB6xrja0FwDEzxmH5t02mApWXg/lap++DbjpX1NQqb4W
	 bBUnVabLRbbGzoCLc9w46HkvoqChBUd5D2iIhVsP4JKqTiUtvrn6J0VrxcmDp9Yxl9
	 fnV2vsl+BYlQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf, arena: fix range_tree_clear
 inconsistency on kmalloc_nolock failure
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260806030359.299480-2-chenyuan_fl@163.com>
References: <20260806030359.299480-1-chenyuan_fl@163.com>
 <20260806030359.299480-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 03:14:55 +0000
Message-Id: <20260806031455.E06D31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `range_tree_set()` suffers from the exact same partial-modificatio=
n flaw that the patch fixes in `range_tree_clear()`, leading to permanent a=
rena slot leaks.
--

--- Patch [1]: [PATCH bpf-next v1 1/3] bpf, arena: fix range_tree_clear inc=
onsistency on kmalloc_nolock failure ---
commit 8092890527e00050d54d5c7b5deedf81e64396d7
Author: Yuan Chen <chenyuan@kylinos.cn>

bpf, arena: fix range_tree_clear inconsistency on kmalloc_nolock failure

This patch addresses an inconsistency in range_tree_clear() where memory
allocation failures could leave the range tree partially modified. It fixes
this by pre-allocating the required node before altering the tree structure.

> diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> index 2f28886f3ff75..24fa32d4356bb 100644
> --- a/kernel/bpf/range_tree.c
> +++ b/kernel/bpf/range_tree.c
> @@ -143,16 +143,21 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
>  		if (rn->rn_start < start && rn->rn_last > last) {
>  			u32 old_last =3D rn->rn_last;
> =20
> +			/* Pre-allocate the right-half node before modifying
> +			 * the tree. If allocation fails we return -ENOMEM
> +			 * without altering the range tree.
> +			 */
> +			new_rn =3D kmalloc_nolock(sizeof(struct range_node),
> +						__GFP_ACCOUNT, NUMA_NO_NODE);
> +			if (!new_rn)
> +				return -ENOMEM;
> +
>  			/* Overlaps with the entire clearing range */
>  			range_it_remove(rn, rt);

[Severity: High]
This isn't a bug introduced by this patch, but does range_tree_set()
suffer from the exact same partial-modification flaw?

Looking at range_tree_set() in kernel/bpf/range_tree.c, it also modifies the
tree before attempting an allocation:

	/* Clear out everything in the range we want to set. */
	err =3D range_tree_clear(rt, start, len);
	if (err)
		return err;
...
	} else {
		left =3D kmalloc_nolock(sizeof(struct range_node), __GFP_ACCOUNT, NUMA_NO=
_NODE);
		if (!left)
			return -ENOMEM;

If kmalloc_nolock() fails here, the function returns -ENOMEM but leaves the
tree with the overlapping nodes already deleted by range_tree_clear(). Any
previously free sub-ranges that were cleared could be permanently lost.

Furthermore, in kernel/bpf/arena.c, arena_free_pages() appears to ignore the
return value entirely:

	range_tree_set(&arena->rt, pgoff, page_cnt);

Could an allocation failure here result in a silent, permanent leak of arena
virtual address space?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806030359.2994=
80-1-chenyuan_fl@163.com?part=3D1
