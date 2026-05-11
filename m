Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C74238333A
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538283; cv=none; b=K709bvW3C5ihiaQ3Ok0oMsAodv9IeJg5tC9PhNHQj0xqZb5vzBNGC2IV2evpbOhNHpqdsfk7Xk3ZarJElSUgeBoZ+yrtScBPRMmD7vV37hncvtVyxF9OAK52dQJNGWB4AoopcRmmr1ajtA+FK+GSP0qdwcFVJBpEdAZFac3Lwco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538283; c=relaxed/simple;
	bh=ptyk4lUImyA6k3GhCQH+NYOCzuuUFOXX3h8wLCsjAVA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fljShyjW1+qk8NiBsQXt+JS5JT6fmmYnorJNK6EPC/t+U+ksxDJ2DgDYC3VzlIPzn4qx3E+cxFyLsStdj1fch3rPCuECBKN1w4SME33Mkf+219XKKR2LEKUXE6loIQG43DsIwctjYtISlZ6AIniHgRx8Ei4zi23waIU5xHEnhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZgynCXt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZgynCXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B95C2BCF7;
	Mon, 11 May 2026 22:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778538282;
	bh=ptyk4lUImyA6k3GhCQH+NYOCzuuUFOXX3h8wLCsjAVA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=TZgynCXty8m6nC4J8DVQG/H8Mgbn4csLtZZKvNizm48ec3pXNEnNNsLg9ekfawgKy
	 FJHamuE3eD4mw70ZYy1xxb4H9W5d9TAyEFxA/c47HZtm30Os5WMUbjZlGVMmAyu0dO
	 kJzQwRd4EuG0ZveiBWyW8kN2eBLh27SwsUde9moBgi9UQNley0UhZK2RL4zpZc7onN
	 FL/cJ5DH3N9GTvvMwC6bnEiMep4DAzYjIsfHAPsf8evEkjg6ShD8shTZQ0DlC+133r
	 8X9tapajoO7pNlCHLVHBeLlFZc7xt9tKRLFCI5p0uWoLUkeJZuCCkUdVsPy+mQfbtj
	 7dWV1Erg5iJNw==
Content-Type: multipart/mixed; boundary="===============1603180960552303213=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c0b69fc93d31fa42e47ee102dfd9b88fbcc8c7d0431e617c02a0e5f27025d36@mail.kernel.org>
In-Reply-To: <20260511214100.9487-2-emil@etsalapatis.com>
References: <20260511214100.9487-2-emil@etsalapatis.com>
Subject: Re: [RESEND PATCH bpf-next 1/2] selftests/bpf: libarena: Add rbtree data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 11 May 2026 22:24:41 +0000 (UTC)

--===============1603180960552303213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
> new file mode 100644
> index 000000000000..17d46c4af332
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
> @@ -0,0 +1,974 @@

[ ... ]

> +SEC("syscall")
> +__weak int test_rbtree_find_nonexistent(void)
> +{
> +	u64 key = 0xdeadbeef;
> +	u64 value = 0;
> +	int ret;
> +
> +	rbtree_t *rbtree;
> +
> +	rbtree = rb_create(RB_ALLOC, RB_DEFAULT);
> +	if (!rbtree)
> +		return 1;
> +
> +	/* Should return -EINVAL */
> +	ret = rb_find(rbtree, key, &value);
> +	if (!ret)
> +		return 2;
> +
> +	return rb_destroy(rbtree);
> +}

The comment says rb_find should return -EINVAL when looking for a
non-existent key in an empty tree, but looking at rb_find in
rbtree.bpf.c:

int rb_find(rbtree_t *rbtree, u64 key, u64 *value)
{
    rbnode_t *node;

    if (unlikely(!rbtree))
        return -EINVAL;

    if (unlikely(!value))
        return -EINVAL;

    node = rbnode_find(rbtree->root, key, RBN_FIND_DFL);
    if (!node || node->key != key)
        return -ENOENT;
        ^^^^

rb_find returns -EINVAL only when rbtree or value is NULL. For a valid
rbtree with no matching node, rbnode_find returns NULL and rb_find
returns -ENOENT. Should the comment say "Should return -ENOENT" instead?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 000000000000..2ce2dfe5a223
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> @@ -0,0 +1,1032 @@

[ ... ]

> +static
> +rbnode_t *rbnode_find(rbnode_t *subtree, u64 key, enum rbnode_find_mode mode)
> +{
> +	rbnode_t *node = subtree;
> +	int dir;
> +
> +	if (!subtree)
> +		return NULL;
> +
> +	while (can_loop) {
> +		/*
> +		 * If we are not looking for the least upper bound,
> +		 * we have found the only key. Otherwise keep going
> +		 * until we find the "leftmost" instance of the key.
> +		 */
> +		if (mode == RBN_FIND_DFL && node->key == key)
> +			break;
> +
> +		dir = (key <= node->key) ? 0 : 1;
> +
> +		if (!node->child[dir])
> +			break;
> +
> +		/*
> +		 * For least upper bound lookups, ensure that we
> +		 * stop searching once we find the rightmost key.
> +		 */
> +		if (node->key == key && node->child[dir]->key != key)
> +			break;
> +
> +		node = node->child[dir];
> +	}
> +
> +	return node;
> +}

[ ... ]

> +static
> +int rb_node_insert(rbtree_t *rbtree __arg_arena, rbnode_t *node __arg_arena)
> +{
> +	rbnode_t *grandparent, *parent = rbtree->root;
> +	enum rbnode_find_mode mode;
> +	u64 key = node->key;
> +	rbnode_t *uncle;
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
> +	mode = RBN_FIND_DFL;
> +	/* Always find the first node with the key when allowing duplicates. */
> +	if (rbtree->insert == RB_DUPLICATE)
> +		mode = RBN_FIND_LUB;
> +	parent = rbnode_find(parent, key, mode);
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
> +				rb_node_free(rbtree, parent);
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

Can this overwrite an existing left subtree in RB_DUPLICATE mode?

When rbnode_find is called with RBN_FIND_LUB mode, it has a third break
condition that stops the search when it finds a node with a matching key
whose next-direction child has a different key:

rbnode_find() {
    ...
    if (node->key == key && node->child[dir]->key != key)
        break;
    ...
}

With key == node->key, dir is computed as (key <= node->key) ? 0 : 1 = 0.
The search stops at a matching node that has a non-NULL left child with a
smaller key.

Back in rb_node_insert, the code skips the RB_DEFAULT check when
rbtree->insert == RB_DUPLICATE, and falls through to:

    node->parent = parent;
    /* Also works if key == parent->key. */
    if (key <= parent->key)
        parent->left = node;

Since key == parent->key, the condition is true and parent->left is
overwritten with the new node. But parent->left already points to an
existing subtree (the smaller node that triggered the third break
condition). That existing left child is overwritten, orphaning its entire
subtree.

Reproduction:
  1) rb_insert(rbtree, 5, v1) in RB_DUPLICATE mode -> tree: {5}
  2) rb_insert(rbtree, 3, v2)                       -> tree: {5->left = 3}
  3) rb_insert(rbtree, 5, v3)

In step 3, rbnode_find returns the root node 5 via the third break
condition (because child 3 has key != 5). Then rb_node_insert sets
parent->left = new_node, overwriting the pointer to node 3. Node 3 is now
orphaned and leaked.

The comment claims "Also works if key == parent->key", but this only holds
when rbnode_find returns a node with an empty left slot, as in the typical
duplicate-chain case where all keys are identical. As soon as a duplicate
insertion meets a matching node that has a pre-existing smaller left child,
the assignment corrupts the tree.

The tree integrity check in rb_integrity_check walks only nodes reachable
from the root, so it does not detect orphaned nodes. The existing test
test_rbtree_duplicate uses a single key value for all insertions, so it
never exercises the interleaved case where a smaller key exists between
duplicates.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25699461713
--===============1603180960552303213==--
