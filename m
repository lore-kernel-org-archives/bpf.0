Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D3421ABAA
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632937; cv=none; b=dBlZc1hV2VNAm1kx3G/TW+jo8bf+i/PokZZruGgfX2fHtuAreVRZnXoU1Tb9u/R5yiGBw7+H8HJKvWVgFy5V9zZCZzj9YOP1xXkm2Dxf87Pfza+psHAe7K4a1sksFHWmgVlPEpKFHew0XkEmhGL2p4CUAm9sDSNQNFYLv7DDhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632937; c=relaxed/simple;
	bh=tzBIjolKj+01v0+FC1pxLMB9pTYz8lZPIG3rQjfQdQ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKs38713ioX9um3vXBxLoPnAmHbr4UnoSkb68YAJA54g04nIi52R8VimK2sRm16h/p/b8Koe0pk650Rio0SJMqmz76wn0W2o5aoSCEouchFiF+6EFKzbippbV6NyA/OTkssq2QzdEvixDZeRDOQaXA0h5HdyTgRrRuRCG7LyNI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYqzVld4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYqzVld4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B44C2BCB0;
	Wed, 13 May 2026 00:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632937;
	bh=tzBIjolKj+01v0+FC1pxLMB9pTYz8lZPIG3rQjfQdQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fYqzVld4Qb3ocyGOKuKcq4PuyPYX7/slXbgk5bAjlrIMCgTOqjmtIh/uWStngtZlD
	 D9vd3rOuM9gHGaPc5WMGgr1qPlUu27nqlyBoct164tQk9VE2J2mX5Zw8opfriih+qx
	 Avof8SMt6kI3LGFD7YhvubjWiqI/sqHBNCrwwRhe9M5KquA/nWJEXw0ScBgKb9lW3A
	 Jz+qtja1gcLKcC8NBOLysfeLFbn32177LZeiPhMg7hSyONQk4cqNbWtxBBnt7uzUPK
	 lw3kga6FyMjnek5WtWuhzy+jJswLBDUTJDyixaFV2aYHGTQzyJYs6GWXhVfXtrwyWC
	 sXUfmmQV1WD2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH bpf-next 1/2] selftests/bpf: libarena: Add rbtree
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511214100.9487-2-emil@etsalapatis.com>
References: <20260511214100.9487-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:42:16 +0000
Message-Id: <20260513004217.49B44C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Inserting duplicate keys into an `RB_DUPLICATE` rbtree overwrites =
existing subtrees, causing data loss and memory leaks.
- [High] The lock-free node freelist implementation is vulnerable to the AB=
A problem, leading to tree corruption.
--

commit 1c2293fc665383e2481f9d7ee15173fb46b0ea76
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add rbtree data structure

This commit adds a native red-black tree data structure to libarena. It
supports multiple APIs (key-value based, node based) and uses the libarena
memory allocator to manage its data.

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 0000000000000..2ce2dfe5a2235
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> @@ -0,0 +1,1032 @@
[ ... ]
> +static inline rbnode_t *rb_node_alloc_common(rbtree_t *rbtree __arg_aren=
a, u64 key, u64 value)
> +{
> +	rbnode_t *rbnode =3D NULL;
> +
> +	if (unlikely(!rbtree))
> +		return NULL;
> +
> +	/* Use the built-in node cache for the rbtree to avoid going to the all=
ocator. */
> +	do  {
> +		rbnode =3D rbtree->freelist;
> +		if (!rbnode)
> +			break;
> +
> +	} while (cmpxchg(&rbtree->freelist, rbnode, rbnode->parent) !=3D rbnode=
 && can_loop);

Could this lock-free freelist implementation be vulnerable to the ABA probl=
em
in concurrent environments?

If Thread A reads rbtree->freelist and evaluates rbnode->parent, and is then
delayed, Thread B could allocate rbnode, allocate its parent, and then free
rbnode back to the freelist. When Thread A resumes, the cmpxchg would
succeed because the freelist head is still rbnode, but it would erroneously
set the freelist head to the stale rbnode->parent. This could cause the
allocator to hand out an in-use tree node, leading to multiple concurrent
uses of the same memory and tree corruption.

[ ... ]

> +static
> +int rb_node_insert(rbtree_t *rbtree __arg_arena, rbnode_t *node __arg_ar=
ena)
> +{
> +	rbnode_t *grandparent, *parent =3D rbtree->root;
> +	enum rbnode_find_mode mode;
> +	u64 key =3D node->key;
> +	rbnode_t *uncle;
> +	int dir;
> +	int ret;
> +
> +	if (unlikely(!rbtree))
> +		return -EINVAL;
> +
> +	if (!parent) {
> +		rbtree->root =3D node;
> +		return 0;
> +	}
> +
> +	mode =3D RBN_FIND_DFL;
> +	/* Always find the first node with the key when allowing duplicates. */
> +	if (rbtree->insert =3D=3D RB_DUPLICATE)
> +		mode =3D RBN_FIND_LUB;
> +	parent =3D rbnode_find(parent, key, mode);
> +
> +	if (key =3D=3D parent->key && rbtree->insert !=3D RB_DUPLICATE) {
> +		if (rbtree->insert =3D=3D RB_UPDATE) {
> +			/*
> +			 * Replace the old node with the new one.
> +			 * Free up the old node.
> +			 */
> +			ret =3D rbnode_replace(rbtree, parent, node);
> +			if (ret)
> +				return ret;
> +
> +			if (rbtree->alloc =3D=3D RB_ALLOC)
> +				rb_node_free(rbtree, parent);
> +
> +			return 0;
> +		}
> +
> +		/* Otherwise it's RB_DEFAULT. */
> +		return -EALREADY;
> +	}
> +
> +	node->parent =3D parent;
> +	/* Also works if key =3D=3D parent->key. */
> +	if (key <=3D parent->key)
> +		parent->left =3D node;
> +	else
> +		parent->right =3D node;

Does this code overwrite existing subtrees when inserting duplicate keys
into an RB_DUPLICATE rbtree?

When rbnode_find() is called with RBN_FIND_LUB, it can break early when it
finds the target key whose child in the search direction has a different
key:

tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c:rbnode_find() {
    ...
		/*
		 * For least upper bound lookups, ensure that we
		 * stop searching once we find the rightmost key.
		 */
		if (node->key =3D=3D key && node->child[dir]->key !=3D key)
			break;
    ...
}

This causes it to return an internal node where node->child[dir] is
explicitly not NULL. Back in rb_node_insert(), the new node is
unconditionally assigned to parent->left or parent->right. This blindly
overwrites the existing child pointer, permanently detaching and leaking
the previous subtree.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511214100.9487=
-1-emil@etsalapatis.com?part=3D1
