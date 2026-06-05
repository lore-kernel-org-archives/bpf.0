Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD5361668
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698654; cv=none; b=uZVpCHY/t5GlZXdJEV6+9jDK49S8h/+icjdei+KMkTuJt8Q2WIgybu4rFIdzCM0qV/P/VxWEaRa7fCvfDant6s40Ef/p9BS/Fpa8SghcyOiCTUgBmThtS6R98Dd6lNRvpuCTn16WCLYR+88hEBTkof8LcCXURBwfJ9m+CMIZO8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698654; c=relaxed/simple;
	bh=2iv3vA52VbZoW3zJ2lY2XhAmzE3uz/i13gMoc8jclU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ure7MuzMFR6V+FGV7s0PNrgzVXXgObhy4rHUjaeX6RZnklKeGwTrrC1pFz3Hlp1JT697GsC+gwn7jSzGVACcn3D0rXF1Jf2zKShAgGtDHbB2Wc+go3VwukZdpTGDqCZxddHfH+Z05nvV06KKC64y+WnFgAgZGKCOT61PmqPBPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0l2g+Np; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0l2g+Np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18201F00893;
	Fri,  5 Jun 2026 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698652;
	bh=ioTYT4CZjUtkeDfhRe4QN2+VqvnZnXaNxByZBbA1Dzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0l2g+NpNHgLrIg6KFfVHbzw8HFO2FMEJeWI+YtE0KXtmUDpAjLNwwfq+aYPHjYWt
	 MFpe6Wr7Wn7QGOaDGA+orFpsCB8SAwFwmBPfVVrOU/slIiAc9ieM/J8sIr5OMd/u5k
	 XvJaAZ7GPlDlNuThK2phPqtXuOUmbG5ORrW2uIZePlpqdoRm+2h6gY88rJBx4CIVPV
	 pEHs9tfnhz8eE+8zDOpdlcK9ChHw/+VKZa7CgIOZTWtt2BQnLsmdNnvluUmLSr5+6/
	 PKMwcMpE3EXBR2UEjKXqKGqkqxUuBXx1O3Uqid6YEUTVEQIMvABa3xBB+p/amazsYF
	 MjSJPZA02ZNUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: libarena: Add rbtree
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605222020.5231-2-emil@etsalapatis.com>
References: <20260605222020.5231-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 22:30:52 +0000
Message-Id: <20260605223052.D18201F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Failure to check `can_loop` termination leads to severe tree corru=
ption, memory leaks, and NULL pointer dereferences.
--

commit 090a58da31563cb07c7562cdaaf67470a54e90c0
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add rbtree data structure

This commit adds a native red-black tree data structure to libarena. It
supports multiple APIs for querying and modifying the tree, and uses the
libarena memory allocator to manage its data.

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 0000000000000..0e4aaec96b6fa
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret =3D 0;
> +
> +	arena_subprog_init();
> +
> +	if (unlikely(!rbtree))
> +		return -EINVAL;

[ ... ]

> +	while (rbtree->root && can_loop) {
> +		ret =3D rb_remove(rbtree, rbtree->root->key);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	arena_free(rbtree);

[Severity: High]
Does this code leak memory if the loop exits early due to the can_loop
limit being reached? If the loop aborts early, the rbtree container is freed
even though the remaining nodes have not been removed.

> +	return ret;
> +}

[ ... ]

> +static
> +struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *s=
ubtree, uint64_t key)
> +{
> +	struct rbnode __arena *node =3D subtree;
> +	int dir;
> +
> +	if (!subtree)
> +		return NULL;
> +
> +	while (can_loop) {
> +		dir =3D (key <=3D node->key) ? 0 : 1;
> +
> +		if (!node->child[dir])
> +			break;
> +
> +		node =3D node->child[dir];
> +	}
> +
> +	return node;

[Severity: High]
If this loop terminates early because can_loop evaluates to false, will it
return an internal tree node rather than a leaf node?

> +}

[ ... ]

> +static
> +int rb_node_insert(struct rbtree __arena *rbtree,
> +		   struct rbnode __arena *node)
> +{
> +	struct rbnode __arena *grandparent, *parent =3D rbtree->root;
> +	u64 key =3D node->key;
> +	struct rbnode __arena *uncle;
> +	int dir;
> +	int ret;

[ ... ]

> +	if (rbtree->insert !=3D RB_DUPLICATE)
> +		parent =3D rbnode_find(parent, key);
> +	else
> +		parent =3D rbnode_least_upper_bound(parent, key);

[ ... ]

> +	node->parent =3D parent;
> +	/* Also works if key =3D=3D parent->key. */
> +	if (key <=3D parent->key)
> +		parent->left =3D node;

[Severity: High]
If rbnode_find() or rbnode_least_upper_bound() returns an internal node
due to a can_loop timeout, does unconditionally overwriting parent->left or
parent->right here permanently detach and leak the existing subtree?

> +	else
> +		parent->right =3D node;

[ ... ]

> +static
> +int rb_node_remove(struct rbtree __arena *rbtree,
> +		   struct rbnode __arena *node)
> +{
> +	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephew;
> +	bool free =3D (rbtree->alloc =3D=3D RB_ALLOC);
> +	struct rbnode __arena *replace, *initial;

[ ... ]

> +	while (can_loop) {
> +
> +		/* Balancing reached the root, there can be no imbalance. */
> +		if (!parent)
> +			return 0;

[ ... ]

> +		sibling->is_red =3D true;
> +		node =3D parent;
> +		parent =3D node->parent;
> +		dir =3D rbnode_dir(node);
> +	}
> +
> +	if (node !=3D initial) {
> +		dir =3D rbnode_dir(node);
> +		parent =3D node->parent;
> +		sibling =3D parent->child[1-dir];
> +	}
> +	/*
> +	 * Almost there. We know between the parent, sibling,
> +	 * and nephews only one or two of the nephews are red. If
> +	 * it is the close one, rotate it to the sibling position,
> +	 * paint it black, and paint the previous sibling red.
> +	 */
> +
> +	close_nephew =3D sibling->child[dir];
> +	distant_nephew =3D sibling->child[1 - dir];
> +
> +	/*
> +	 * If the distant red nephew is not red, rotate
> +	 * and repaint. We need the distant nephew
> +	 * to be red. We know the close nephew is red
> +	 * because at least one of them are, so the
> +	 * distant one is black if it exists.
> +	 */
> +	if (!distant_nephew || !distant_nephew->is_red) {
> +		rbnode_rotate(rbtree, sibling, 1 - dir);
> +		sibling->is_red =3D true;
> +		close_nephew->is_red =3D false;

[Severity: High]
Can this cause a NULL pointer dereference if the rebalancing loop above
exits early due to can_loop?

An early exit bypasses the guarantee that the sibling has red children,
which means both nephews, including close_nephew, might be NULL here.

> +		distant_nephew =3D sibling;
> +		sibling =3D close_nephew;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605222020.5231=
-1-emil@etsalapatis.com?part=3D1
