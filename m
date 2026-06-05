Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9838A3F825C
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699871; cv=none; b=K9FanQHQcaTI4wY9aGaS0FZmjj11HaZzWo7AGm7dM+9R0xpFQxX6xAHp3BlCglvm5zioGnLE5oZudH1SWlRdVGF5oVhXwU3Qnp6KC/tKKb9qS1U87pnX7YxNs6OfKbwFg+cqYnm+BD+jsVzYBXAKVrbPR/K10QJNxTV33HSnVJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699871; c=relaxed/simple;
	bh=4K5WRt0VRO7oU5MGSy25GQuxjXx79outJbFKakOXNSU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hqlXchRvrBAbOdFd2y3kCac0ivxUmbjNsrhL6kLUezQl4DU0k1k9DO43ngZPnaFJJFOG8y9dUoVYD46JkMck2YUcwiLbz6Gj6ONU5ECKm3AsXQwW4qQPWRCzFAujwnVjg3NM4n7JOtYpNn5Eq56k3YvAD42jHJX9M43to9LsEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSQ3fmum; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSQ3fmum"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA5A1F00893;
	Fri,  5 Jun 2026 22:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780699870;
	bh=5SmSHKTe2O2VX9a48SIb7UsWYitODXckJRjY7RaPVrI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CSQ3fmum9nXymjE5EIb8ssikwWU1PvB1ZQAS33okaqCN+OLXu9B19r0i7ebmcvz6G
	 b0Mekj7Q9VptS/yh4LW+bi+kzSfIql6n+166Q7vUwyYBwA0kNCTlMMhM+58gvY0Dm3
	 GHQZICiHs7tRcP2uCdaYO/ALyzUs7C7kAYc22X/LSUvAsXN3CsfQX2ryStXg6pazCB
	 j4PhGzYTLzpZefSO7AwCLDSbHsb7n6fo/8hBLH4xYBn7JegHB6DmztjQ+dcepPY74r
	 H144zk7Gki2VIKPOrLdZ073pQuUoCKJtvlSfjuRyYmI30ySPquuKEQoKZtcn0SQgp1
	 mmLpkdW8TgbwA==
Content-Type: multipart/mixed; boundary="===============8247276677176119832=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f2373d65834540a4f1d5fe7c7372c6d3589a9fc63964d098c108aeb1bb8cc83@mail.kernel.org>
In-Reply-To: <20260605222020.5231-2-emil@etsalapatis.com>
References: <20260605222020.5231-2-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: libarena: Add rbtree data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 22:51:09 +0000 (UTC)

--===============8247276677176119832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 000000000000..7f0f6dc3e17d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret = 0;
> +
> +	arena_subprog_init();
> +
> +	if (unlikely(!rbtree))
> +		return -EINVAL;
> +
> +	if (rbtree->alloc == RB_NOALLOC) {
> +		/*
> +		 * We cannot do anything about RB_NOALLOC nodes. The whole
> +		 * point of RB_NOALLOC is that the nodes are directly owned
> +		 * by the caller that allocates and inserts them. We could
> +		 * unilaterally grab all nodes and free them anyway, but that
> +		 * would almost certainly cause UAF as the callers keep accessing
> +		 * the now freed nodes. Throw an error instead.
> +		 */
> +		if (rbtree->root) {
> +			arena_stderr("WARNING: Destroying RB_NOALLOC tree with > 0 nodes");
> +			return -EBUSY;
> +		}
> +
> +		goto out;
> +	}
> +
> +	while (rbtree->root && can_loop) {
> +		ret = rb_remove(rbtree, rbtree->root->key);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	arena_free(rbtree);
> +	return ret;
> +}

Does this code leak memory if the loop exits early due to the can_loop
limit being reached?

If the loop aborts early, the rbtree container is freed even though the
remaining nodes have not been removed.

This was flagged in the v4 review by sashiko-bot:

https://lore.kernel.org/bpf/20260605223052.D18201F00893@smtp.kernel.org/

[ ... ]

> +static
> +struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *subtree, uint64_t key)
> +{
> +	struct rbnode __arena *node = subtree;
> +	int dir;
> +
> +	if (!subtree)
> +		return NULL;
> +
> +	while (can_loop) {
> +		dir = (key <= node->key) ? 0 : 1;
> +
> +		if (!node->child[dir])
> +			break;
> +
> +		node = node->child[dir];
> +	}
> +
> +	return node;
> +}

If this loop terminates early because can_loop evaluates to false, will
it return an internal tree node rather than a leaf node?

This was flagged in the v4 review by sashiko-bot:

https://lore.kernel.org/bpf/20260605223052.D18201F00893@smtp.kernel.org/

[ ... ]

> +static
> +int rb_node_insert(struct rbtree __arena *rbtree,
> +		   struct rbnode __arena *node)
> +{
> +	struct rbnode __arena *grandparent, *parent = rbtree->root;
> +	u64 key = node->key;
> +	struct rbnode __arena *uncle;
> +	int dir;
> +	int ret;
> +
> +	if (unlikely(!rbtree))
> +		return -EINVAL;
> +
> +	if (!parent) {
> +		rbtree->root = node;
> +		return 0;
> +	}
> +
> +	if (rbtree->insert != RB_DUPLICATE)
> +		parent = rbnode_find(parent, key);
> +	else
> +		parent = rbnode_least_upper_bound(parent, key);
> +
> +	if (key == parent->key && rbtree->insert != RB_DUPLICATE) {
> +		if (rbtree->insert == RB_UPDATE) {
> +			/*
> +			 * Replace the old node with the new one.
> +			 * Free up the old node.
> +			 */
> +			ret = rbnode_replace(rbtree, parent, node);
> +			if (ret)
> +				return ret;
> +
> +			if (rbtree->alloc == RB_ALLOC)
> +				rb_node_free(parent);
> +
> +			return 0;
> +		}
> +
> +		/* Otherwise it's RB_DEFAULT. */
> +		return -EALREADY;
> +	}
> +
> +	node->parent = parent;
> +	/* Also works if key == parent->key. */
> +	if (key <= parent->key)
> +		parent->left = node;
> +	else
> +		parent->right = node;

If rbnode_find() or rbnode_least_upper_bound() returns an internal node
due to a can_loop timeout, does unconditionally overwriting parent->left
or parent->right here permanently detach and leak the existing subtree?

This was flagged in the v4 review by sashiko-bot:

https://lore.kernel.org/bpf/20260605223052.D18201F00893@smtp.kernel.org/

[ ... ]

> +static
> +int rb_node_remove(struct rbtree __arena *rbtree,
> +		   struct rbnode __arena *node)
> +{
> +	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephew;
> +	bool free = (rbtree->alloc == RB_ALLOC);
> +	struct rbnode __arena *replace, *initial;
> +	bool is_red;
> +	int dir;

[ ... ]

> +	while (can_loop) {
> +
> +		/* Balancing reached the root, there can be no imbalance. */
> +		if (!parent)
> +			return 0;

[ ... ]

> +		/* Sibling is red, turn it into the grandparent. */
> +		if (sibling->is_red) {
> +			/*
> +			 * Sibling is red. Transform the tree to turn
> +			 * the sibling into the parent's position, and
> +			 * repaint them. This does not balance the tree
> +			 * but makes it so we know the sibling is black
> +			 * and so can use the transformations to balance.
> +			 */
> +			rbnode_rotate(rbtree, parent, dir);
> +			parent->is_red = true;
> +			sibling->is_red = false;
> +
> +			/* Our new sibling is now the close nephew. */
> +			sibling = parent->child[1 - dir];
> +			/* If sibling has any red siblings, break out. */
> +			if (rbnode_has_red_children(sibling))
> +				break;
> +
> +			/* We can repaint the sibling and parent, we're done. */
> +			sibling->is_red = true;
> +			parent->is_red = false;
> +
> +			return 0;
> +		}
> +
> +		/* Sibling guaranteed to be black. If it has red children, break out. */
> +		if (rbnode_has_red_children(sibling))
> +			break;
> +
> +		/*
> +		 * Both sibling and children are black. If parent is red, swap
> +		 * colors with the sibling. Otherwise
> +		 */
> +		if (parent->is_red) {
> +			parent->is_red = false;
> +			sibling->is_red = true;
> +			return 0;
> +		}
> +
> +		/*
> +		 * Parent, sibling, and all its children are black. Repaint the sibling.
> +		 * This shortens the paths through it, so pop up a level in the
> +		 * tree and repeat the balancing.
> +		 */
> +		sibling->is_red = true;
> +		node = parent;
> +		parent = node->parent;
> +		dir = rbnode_dir(node);
> +	}
> +
> +	if (node != initial) {
> +		dir = rbnode_dir(node);
> +		parent = node->parent;
> +		sibling = parent->child[1-dir];
> +	}
> +	/*
> +	 * Almost there. We know between the parent, sibling,
> +	 * and nephews only one or two of the nephews are red. If
> +	 * it is the close one, rotate it to the sibling position,
> +	 * paint it black, and paint the previous sibling red.
> +	 */
> +
> +	close_nephew = sibling->child[dir];
> +	distant_nephew = sibling->child[1 - dir];
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
> +		sibling->is_red = true;
> +		close_nephew->is_red = false;
> +		distant_nephew = sibling;
> +		sibling = close_nephew;
> +	}

Can this cause a NULL pointer dereference if the rebalancing loop exits
early due to can_loop?

An early exit bypasses the guarantee that the sibling has red children,
which means both nephews, including close_nephew, might be NULL here.

This was flagged in the v4 review by sashiko-bot:

https://lore.kernel.org/bpf/20260605223052.D18201F00893@smtp.kernel.org/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27043406243
--===============8247276677176119832==--
