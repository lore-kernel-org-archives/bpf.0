Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3EF1A9F82
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632210; cv=none; b=kPkB/vAP294CSGYqUYLL98EnNUnwbqNn/CzEYSD9+OufHFaI/VYGsaI1Itqb6KZvqkmiWCkBHUIXHkawj4LBUERN+p1mMIKauuRX5IIfx7AuJjb7syqHz6Ph3NwZJqftIGJQ4guuacKbNyNROqc/ewh6Qz2SODpYjGflePDeWsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632210; c=relaxed/simple;
	bh=3qn+tx6ThoGvSIVaSfU+vUteF/u1F5TqudRj/+oTY/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BKupRbGsPQMKzJ1jMrP7BH7A3+VZlBizuKTp+aXLlVDKNlRPuzN+KZ1Wzz1PaYmRKzTrHIS9HLVXO5qLsgYQ/H6BG1MOEM0/xgiRH60vf7lwwulG/RvHLUsfGIWdcbXvyxlaMN01hTtVKquVe9YCNzoU9SL2t5sW+0GSVyPBaQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1S5S/tl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1S5S/tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145F2C2BCB0;
	Wed, 13 May 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778632210;
	bh=3qn+tx6ThoGvSIVaSfU+vUteF/u1F5TqudRj/+oTY/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=u1S5S/tlUE2GGAY92NokLob8dH1E5J3SjoVESkO3rokTFhQs/rjWDKHw++Pd46nLQ
	 91V1b/lobITeMDkO7lPv+7WwqOhFo1b879jbVcxHrZBpHAMZXnNE8ER/IVQBnSq9aX
	 ydRzuPm+yry4Pj8oUdiiTSljBXW3DfNSnq8nI+d5CM6zlOV3P0fj1PE9mJXD4Mgtj2
	 vRCeoZ68iT4uapzqW89BJ6gzIJezHHFJdVh/GMdFTAzWwmm4n7NbqspqmFqYhkSfSN
	 J6oUQdi+w6CLx8vNc93tYICMfaLI3i07OWk8aH1CAOpG2+GEu9Hsj+QwWdH/AaQ+jx
	 Pwl5Fh8YySpgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: libarena: Add rbtree data
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511210740.5395-2-emil@etsalapatis.com>
References: <20260511210740.5395-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 00:30:09 +0000
Message-Id: <20260513003010.145F2C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] ABA vulnerability in lock-free freelist operations leads to me=
mory corruption
- [High] Inserting duplicate keys in `RB_DUPLICATE` mode silently overwrite=
s subtrees and leaks memory
- [High] Unchecked early loop termination (`can_loop`) corrupts the tree st=
ructure and causes massive memory leaks
- [Medium] Missing build system integration renders new tests as dead code
--

commit 3a9a1af9570223a1c9cf74c5f2e9d724407fddac
Author: Emil Tsalapatis <emil@etsalapatis.com>

selftests/bpf: libarena: Add rbtree data structure

This commit adds a native red-black tree data structure to libarena.
The data structure supports key-value and node-based APIs, and uses
the libarena memory allocator to manage its data.

> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf=
.c b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
> new file mode 100644
> index 0000000000000..17d46c4af3324
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/selftests/st_rbtree.bpf.c
> @@ -0,0 +1,974 @@
> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
> +
> +#include <libarena/common.h>

These new test files are added to the selftests directory, but they do not
appear to be integrated into the build system. Per the selftests subsystem
guidelines, files not explicitly added to variables like TEST_PROGS or
TEST_GEN_FILES in the Makefile won't be compiled or executed during normal
runs. Should these be added to the Makefile?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 0000000000000..2ce2dfe5a2235
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +static
> +rbnode_t *rbnode_find(rbnode_t *subtree, u64 key, enum rbnode_find_mode =
mode)
> +{
> +	rbnode_t *node =3D subtree;
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
> +		if (mode =3D=3D RBN_FIND_DFL && node->key =3D=3D key)
> +			break;
> +
> +		dir =3D (key <=3D node->key) ? 0 : 1;
> +
> +		if (!node->child[dir])
> +			break;
> +
> +		/*
> +		 * For least upper bound lookups, ensure that we
> +		 * stop searching once we find the rightmost key.
> +		 */
> +		if (node->key =3D=3D key && node->child[dir]->key !=3D key)
> +			break;
> +
> +		node =3D node->child[dir];
> +	}
> +
> +	return node;
> +}

When mode is RBN_FIND_LUB, this loop can break early and return an internal
node that has a valid, non-NULL child. Back in rb_node_insert(), the new
node is unconditionally assigned to parent->left (since key <=3D parent->ke=
y)
which could silently overwrite the existing child pointer and leak the
existing subtree. Does this correctly handle duplicate key insertions witho=
ut
detaching subtrees?

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

Could this lockless cmpxchg sequence suffer from the ABA problem?

If a thread is preempted after evaluating rbnode->parent but before executi=
ng
cmpxchg, another thread could pop rbnode, allocate it, and free it back to
the freelist with a completely different parent pointer. When the original
thread resumes, the cmpxchg succeeds but erroneously sets the freelist head
to the stale parent pointer. This could link an actively used tree node back
into the freelist and lead to memory corruption.

[ ... ]

> +__weak
> +int rb_node_free(rbtree_t *rbtree __arg_arena, rbnode_t *rbnode __arg_ar=
ena)
> +{
> +	rbnode_t *old;
> +
> +	do {
> +		old =3D rbtree->freelist;
> +		rbnode->parent =3D old;
> +	} while (cmpxchg(&rbtree->freelist, old, rbnode) !=3D old && can_loop);
> +
> +	return 0;
> +}

Similarly, could this free implementation also be vulnerable to the ABA
problem if the freelist head is rapidly popped and pushed concurrently?

[ ... ]

> +static inline rbnode_t *rbnode_least(rbnode_t *subtree)
> +{
> +	while (subtree->left && can_loop)
> +		subtree =3D subtree->left;
> +
> +	return subtree;
> +}

If the loop limit is reached and can_loop terminates early, could this
return a node that still has a left child?

During node removal, this node would be swapped with the target node, leavi=
ng
the target node with both left and potentially right children. The removal
logic evaluates if (!node->left !=3D !node->right) which would then bypass
the single-child handler and fall through to the zero-child path, setting t=
he
parent's child pointer to NULL and leaking both subtrees. Are early loop
terminations via can_loop safely handled without leaving the tree structure
corrupted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511210740.5395=
-1-emil@etsalapatis.com?part=3D1
