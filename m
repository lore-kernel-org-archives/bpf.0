Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FB3A7F72
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511923; cv=none; b=QZ40VgVsN3f4kW69MFhJmsMDRVD5M85f80DhxAMOwzAujre/8aQG/u/fqs9VMII+rNmP11mqW4Nauhba+9LxErhiNYxmSNrb6E7QYNWKbbJdz6YNrkxNzr2VJcvTVWZQ6O+4kuuhCkRxNer7U/efsx9dnYhlMqAkSJxFmrnRchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511923; c=relaxed/simple;
	bh=rZ/kc73k3fbF26MnNTQkFw83EnKRcXFjo+VQ81pLDS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hV/fAftrfCWThgm2T3Z+iNek0F2tOxnkYiCmcMg60iFgqywKlNsMrqDttWHb4RT0636k+mwEqKbewFv9Y+9GCrkh3jJTjKw01v/GGKzFEnY94hS+54GzPRLsxesGK6OJtvRw5xej8Dn6q2aucF7nHZZ85qrMnNI2ydWPGMznVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh490ZBt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh490ZBt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B938C1F00893;
	Wed,  3 Jun 2026 18:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780511921;
	bh=73xjnYjQkog2xkSEyMzc2K6fE6oTBnhlCaqvrdbS87I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mh490ZBtNcdDc+tchxe3ZFNYoRFrBr2sbjJvokQSLpvXm6dBJuugaUtfi9V/NduPm
	 uwHloYa1GRWXi3az15mzcN0KmxcxZsM2+mC2249D89lz/m4qos8U0droylO7iD+LCq
	 EfrMJRd8ncAvwKimhn/90zt2h4LCgFrbmYw5Ja5Ys0kFiLbZEbV9Ph/bpJg4+tx3yS
	 1K/eLjyMhK/en3D18MKEVEGnUZFpyS78vuIHYcRouuneEaGQb5+kS6ztf8yjrIh2v7
	 BcFpMnTuh5VFOoXKpHkVfZ64K5Ws57geTM+9jttTkB949bF02Yd4YiTFxspjK/TPob
	 zFoYI5kGJNVCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: libarena: Add rbtree
 data structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emil Tsalapatis" <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603182727.3922-2-emil@etsalapatis.com>
References: <20260603182727.3922-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 18:38:41 +0000
Message-Id: <20260603183841.B938C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] rb_print() causes a NULL pointer dereference when called on an e=
mpty tree.
- [Medium] rb_destroy() leaks the rbtree structure if node removal fails.
--

commit 02f60ec9e8c02b47259587dc8e3bbe9137e1e4ed
Author: Emil Tsalapatis <emil@etsalapatis.com>
selftests/bpf: libarena: Add rbtree data structure

This commit adds a native red-black tree data structure to libarena. It
supports multiple APIs to query and modify the tree, using the libarena mem=
ory
allocator to manage its data.

> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/tool=
s/testing/selftests/bpf/libarena/src/rbtree.bpf.c
> new file mode 100644
> index 0000000000000..7379eba6570af
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c

[ ... ]

> +__weak
> +int rb_destroy(struct rbtree __arena *rbtree)
> +{
> +	int ret;
> +
> +	arena_subprog_init();
> +
> +	if (rbtree->alloc =3D=3D RB_NOALLOC) {

[ ... ]

> +		goto out;
> +	}
> +
> +	while (rbtree->root && can_loop) {
> +		ret =3D rb_remove(rbtree, rbtree->root->key);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Does this leak the rbtree structure if rb_remove() fails?

If rb_remove() encounters an error (for example, due to tree corruption), it
returns early here. This skips the arena_free(rbtree) call at the out label,
potentially leaking the rbtree structure and any remaining nodes.

> +	}
> +
> +out:
> +	arena_free(rbtree);
> +	return 0;
> +}

[ ... ]

> +__weak
> +int rb_print(struct rbtree __arena *rbtree)
> +{
> +	enum rb_print_state stack[RB_MAXLVL_PRINT];
> +	struct rbnode __arena *rbnode =3D rbtree->root;
> +	enum rb_print_state state;
> +	struct rbnode __arena *next;
> +	u64 next_addr;
> +	u8 depth;
> +	int ret;
> +
> +	if (unlikely(!rbtree))
> +		return -EINVAL;
> +
> +	depth =3D 0;
> +	state =3D RB_NONE_VISITED;
> +
> +	arena_stderr("=3D=3D=3D RB TREE START =3D=3D=3D\n");
> +
> +	/* Even with can_loop, the verifier doesn't like infinite loops. */
> +	while (can_loop) {
> +		if (state =3D=3D RB_NONE_VISITED)
> +			rbnode_print(depth, rbnode);

[Severity: Medium]
Does this cause a NULL pointer dereference if the tree is empty?

If a user calls rb_print() on an empty tree, rbtree->root is NULL. The loop
is entered and rb_print() passes the NULL rbnode to rbnode_print().

Looking at rbnode_print(), it unconditionally dereferences the node:

inline void rbnode_print(size_t depth, struct rbnode __arena *rbn)
{
        arena_stderr("[DEPTH %d] %p (%s)\n PARENT %p", depth, rbn,
                     rbn->is_red ? "red" : "black", rbn->parent);
        ...
}

Could this lead to a crash when calling rb_print() on an empty tree?

> +
> +		/* Find which child to traverse next. */
> +		state =3D rb_print_next_state(rbnode, state, &next_addr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603182727.3922=
-1-emil@etsalapatis.com?part=3D1
