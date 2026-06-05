Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C0628C854
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700484; cv=none; b=J3Rtp6cRmz3cU4dfQPJs//Pw+pPPbnausXQGY6FB0H7fdC/fB8RKtc4MYHcRoxf0FKCM2CklPoEtMpL5f13JFuc8srBG6E+cbmfjuQDTAngpWMQYKf/lBcz6sCWLFT7GHEMs6XnxjYYKs1OI3vMyYvI+1yprOah9RThiM7l3Mvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700484; c=relaxed/simple;
	bh=O8GdzxxXiZ3G7l1nv/53S34k1iKnVwkdcP6Nvg3W3iM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=PkosYa2GILeGXzUOKj1Q9DCzZ/ZAA6SZ/4+cWOE4frr8NxwpjR2qNAcQevekj5TcU+xLgL8F+uhu79Fpm9wxwcyQ2ZcS7GpelQIPWqll3UjLpAv3keDteCWIZ1GHrdbVg0anZLnBOgyHL/tWruat3tWLbSkLwFeMDuaXvUQfFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=a8IZ1p4J; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="a8IZ1p4J"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842848fd613so1972179b3a.3
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 16:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780700482; x=1781305282; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMUU/6j6qQEoXyWYhsfpILaPga52Ykc268OSJ9blCEU=;
        b=a8IZ1p4JRzwBSV2vVvvtrdo4BSGeKsrJke+mZlghR+XuyM9236tG1Bd1h/a2MJEx7L
         f+xbkXGCz1dAfb9mVCo5fE2sokbXBbQcLqwl4UF75oziA1Boaqh/vPNdLm7W3+Um4EdK
         OgHfOLro4VhqiMiWAYkRsRdtTr9/7tA4b3z/UdmMcmUPpcmwPcBNOFzBSHX2TFchNwSQ
         2g/MM2BsF5yeCTlQd0FF9eCODEfPte9SQPUH5o6CNbphxtQFoFDSL/IaHp+MXCskw5pX
         GrBD2YfKEPGlFnpJB/m0bqY9+15fMgTWEomuztV0yPJeSyhcG3vaiZlb00lc/J/H3Q+J
         sn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780700482; x=1781305282;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMUU/6j6qQEoXyWYhsfpILaPga52Ykc268OSJ9blCEU=;
        b=pu8b3O0c9o+HveBoOSFhMCft9kmTtEApaaUbALFvy7PmTK5T7KCSNwXRB2Pd298CN/
         X1pmonqsKQkPdfwBwD9A3J7PCESeUxd8paiBlHC7fr0ReCpikDXXKmYklmSxZ4Vhxwyx
         qeZeU9J0WYskJqqGD1FMMpIkKZ+9trEr+if6RatB6eCWoUH9SilsQOQq7n9OuDs1lwnp
         9J0i6AHK5vbw4xCB7oYFawq/1Nyw2Fz+Zaw2opDnZ5cBPskMfJ51RIFW+HHx6dmtqAId
         mKnAfuD/Fvm3I16v1Jo9+xc5EPIMcAvKpDqekro05o4YYSz4kYLOXuzGVgU3Poq0M64v
         qnyQ==
X-Gm-Message-State: AOJu0YzFFZS2JecMDgNepGoY3/jRBYbBRPYdIuHdr8VuQ/5LfV5zKAGL
	KfyCu+Z8nwSBG1CXWJGrCuyaxnI3YX7EpnwDHvHSbdvgZ93MvGbvZoAw+wOt0vo46sOf7EbO0bE
	Cjuth3G1jrP/o
X-Gm-Gg: Acq92OEfnDfncqDSlVfjCU8X5uwAREf74ZomQiw8lK0/FSQu+1FyVlKEN0aYfyTkcCs
	tjoPZ0ciJZ2Jao8m3lOt+v9h0fWPOkYJOi91PirpzloABuyxTD6a6J64mGGc0PqcoShEcgED21p
	M7VRwvNK2oILk8R6zoLirgvJH6Bhh0S8dw6RN0yjo6MUOSeePTbVLpp3jzIYsO1eXNc8TvJSSmR
	rSFuWn/wLrvTmd8BOh+seKqWET7sxeu3uKBbdOXiLmhwpSyt0AS3P6h4aouoK/4zP7WnP+5QW+b
	L7/tnkAoWobdfPlpQsn3a8ec3eNKCdMkLsKOWltJNNTInwbI/2tedAhZzdEbpSucbpDXFQRuSr1
	bWdSVtWKws1vjghjoHRw3SnblwEDHNx+4j1exhrJ0mXwhQESYoFnt7AEtUOQlB5Vld7XfiDLdvV
	JUuX4+U7FVLwVkWwpzQEUWzequa2bmKVdEyNR4LKNsoiY49A==
X-Received: by 2002:a05:6a00:338c:b0:842:48ae:1d56 with SMTP id d2e1a72fcca58-842b104d70dmr5980160b3a.35.1780700482310;
        Fri, 05 Jun 2026 16:01:22 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882751sm10488015b3a.39.2026.06.05.16.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 16:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jun 2026 19:01:21 -0400
Message-Id: <DJ1HN00TAYO9.3MAYZZJMB84PJ@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 1/3] selftests/bpf: libarena: Add rbtree
 data structure
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260605222020.5231-2-emil@etsalapatis.com>
 <20260605223052.D18201F00893@smtp.kernel.org>
In-Reply-To: <20260605223052.D18201F00893@smtp.kernel.org>

On Fri Jun 5, 2026 at 6:30 PM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Failure to check `can_loop` termination leads to severe tree cor=
ruption, memory leaks, and NULL pointer dereferences.
> --
>
> commit 090a58da31563cb07c7562cdaaf67470a54e90c0
> Author: Emil Tsalapatis <emil@etsalapatis.com>
>
> selftests/bpf: libarena: Add rbtree data structure
>
> This commit adds a native red-black tree data structure to libarena. It
> supports multiple APIs for querying and modifying the tree, and uses the
> libarena memory allocator to manage its data.
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>> new file mode 100644
>> index 0000000000000..0e4aaec96b6fa
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/rbtree.bpf.c
>
> [ ... ]
>
>> +__weak
>> +int rb_destroy(struct rbtree __arena *rbtree)
>> +{
>> +	int ret =3D 0;
>> +
>> +	arena_subprog_init();
>> +
>> +	if (unlikely(!rbtree))
>> +		return -EINVAL;
>
> [ ... ]
>
>> +	while (rbtree->root && can_loop) {
>> +		ret =3D rb_remove(rbtree, rbtree->root->key);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +out:
>> +	arena_free(rbtree);
>
> [Severity: High]
> Does this code leak memory if the loop exits early due to the can_loop
> limit being reached? If the loop aborts early, the rbtree container is fr=
eed
> even though the remaining nodes have not been removed.
>
>> +	return ret;
>> +}
>
> [ ... ]
>
>> +static
>> +struct rbnode __arena *rbnode_least_upper_bound(struct rbnode __arena *=
subtree, uint64_t key)
>> +{
>> +	struct rbnode __arena *node =3D subtree;
>> +	int dir;
>> +
>> +	if (!subtree)
>> +		return NULL;
>> +
>> +	while (can_loop) {
>> +		dir =3D (key <=3D node->key) ? 0 : 1;
>> +
>> +		if (!node->child[dir])
>> +			break;
>> +
>> +		node =3D node->child[dir];
>> +	}
>> +
>> +	return node;
>
> [Severity: High]
> If this loop terminates early because can_loop evaluates to false, will i=
t
> return an internal tree node rather than a leaf node?
>
>> +}
>
> [ ... ]
>
>> +static
>> +int rb_node_insert(struct rbtree __arena *rbtree,
>> +		   struct rbnode __arena *node)
>> +{
>> +	struct rbnode __arena *grandparent, *parent =3D rbtree->root;
>> +	u64 key =3D node->key;
>> +	struct rbnode __arena *uncle;
>> +	int dir;
>> +	int ret;
>
> [ ... ]
>
>> +	if (rbtree->insert !=3D RB_DUPLICATE)
>> +		parent =3D rbnode_find(parent, key);
>> +	else
>> +		parent =3D rbnode_least_upper_bound(parent, key);
>
> [ ... ]
>
>> +	node->parent =3D parent;
>> +	/* Also works if key =3D=3D parent->key. */
>> +	if (key <=3D parent->key)
>> +		parent->left =3D node;
>
> [Severity: High]
> If rbnode_find() or rbnode_least_upper_bound() returns an internal node
> due to a can_loop timeout, does unconditionally overwriting parent->left =
or
> parent->right here permanently detach and leak the existing subtree?
>
>> +	else
>> +		parent->right =3D node;
>
> [ ... ]
>
>> +static
>> +int rb_node_remove(struct rbtree __arena *rbtree,
>> +		   struct rbnode __arena *node)
>> +{
>> +	struct rbnode __arena *parent, *sibling, *close_nephew, *distant_nephe=
w;
>> +	bool free =3D (rbtree->alloc =3D=3D RB_ALLOC);
>> +	struct rbnode __arena *replace, *initial;
>
> [ ... ]
>
>> +	while (can_loop) {
>> +
>> +		/* Balancing reached the root, there can be no imbalance. */
>> +		if (!parent)
>> +			return 0;
>
> [ ... ]
>
>> +		sibling->is_red =3D true;
>> +		node =3D parent;
>> +		parent =3D node->parent;
>> +		dir =3D rbnode_dir(node);
>> +	}
>> +
>> +	if (node !=3D initial) {
>> +		dir =3D rbnode_dir(node);
>> +		parent =3D node->parent;
>> +		sibling =3D parent->child[1-dir];
>> +	}
>> +	/*
>> +	 * Almost there. We know between the parent, sibling,
>> +	 * and nephews only one or two of the nephews are red. If
>> +	 * it is the close one, rotate it to the sibling position,
>> +	 * paint it black, and paint the previous sibling red.
>> +	 */
>> +
>> +	close_nephew =3D sibling->child[dir];
>> +	distant_nephew =3D sibling->child[1 - dir];
>> +
>> +	/*
>> +	 * If the distant red nephew is not red, rotate
>> +	 * and repaint. We need the distant nephew
>> +	 * to be red. We know the close nephew is red
>> +	 * because at least one of them are, so the
>> +	 * distant one is black if it exists.
>> +	 */
>> +	if (!distant_nephew || !distant_nephew->is_red) {
>> +		rbnode_rotate(rbtree, sibling, 1 - dir);
>> +		sibling->is_red =3D true;
>> +		close_nephew->is_red =3D false;
>
> [Severity: High]
> Can this cause a NULL pointer dereference if the rebalancing loop above
> exits early due to can_loop?
>
> An early exit bypasses the guarantee that the sibling has red children,
> which means both nephews, including close_nephew, might be NULL here.

No. We don't care what happens if can_loop triggers. Same for the rest
of the bot feedback. The only outstanding actionable nit is imo the
mismatch between the function names in the patch description and the
actual code for spmc, for which I can send another version if necessary.

>
>> +		distant_nephew =3D sibling;
>> +		sibling =3D close_nephew;
>> +	}

