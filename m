Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B83BFE52
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867628; cv=none; b=FA6IUMEC6AjHDqjAzdPdRBMhHvdBAwIlB/TAMsL+E32Y1PkpmqQsjXNt5fA9ZytDLqzzyPnJ4dLunxB5tKLtUV+mGRgQ5bwdfjV9G0B8Jc62lBGTaNt3/75vx8tavzAkhxSLZpDcDFSFfb0JZWhXIDF78BLUagDaDZE1RZ17Z5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867628; c=relaxed/simple;
	bh=efensNxT45SQDbuVpwcoyfSMOxWOtLuQ0yNFZg/xil0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mRzIBtcao3QthFxRzAeQijJbuD5696/ZmfvralEwXo8GZpYF/IFe/glLAwWOJB84Zd31Qfmpk1ipfPOOTaUKY81ta1gJXMrMAVeeKeamsyI2PkmIt3P7rnflgXvM4hjAPU/s2B4dPFnFsQJmfzGF7ymHzK+WCTFOukZn7cdtCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbdOdL2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbdOdL2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282BF1F00A3A;
	Wed, 27 May 2026 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779867627;
	bh=3VaNjYW7Vq83ea4sn+s2BF0TeVjiFUkv3KK/OiEFWPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbdOdL2XEA8JGl9qjC3JKX5dQ6Seu+I3UfdocJGdHMfqQsFXSTgHUfRsyYlNk+w3o
	 wzmEevYqI/smVYU5OE5GxbEtfW4uDHM5TyGOCcyO2oOoqfh7gbDkGeE8gojHKbdMr1
	 vBMCqCpWsmukdqIvYeLpcl3ZpQIo7tYvocoY4L2txErFWlwT2E9XyQ3dofjufy9hEf
	 s3ecKnv2+VX2kZo608Aux8H8sfZR7wAV8ypYGKUJalQE8aiG3HHqN5rBEeVqEe8+Ty
	 u1BGCfCnfNyBQ0gFjg1nZ14QDy47tMtTUHjRafrCD2lxcb6rYDseZcDjrc4lFawQup
	 HEqzPsrMI98NQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1] bpf: Use hlist_nulls_replace_rcu() when
 updating htab elements
Reply-To: sashiko-reviews@lists.linux.dev
To: xuanqiang.luo@linux.dev
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
References: <20260527070139.223386-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 07:40:26 +0000
Message-Id: <20260527074027.282BF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using hlist_nulls_replace_rcu() violates the hlist_nulls invariant=
 that reused elements must be inserted at the head, leading to spurious loo=
kup failures in preallocated and LRU maps.
--

commit 152c68c8990ac2fd12423e6b3208030a31a5a41d
Author: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

bpf: Use hlist_nulls_replace_rcu() when updating htab elements

This patch modifies the BPF hash map update logic to use
hlist_nulls_replace_rcu() instead of adding the new element to the head
and deleting the old one.

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4f..b20e82bd253dc 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
[ ... ]
> @@ -1246,18 +1246,16 @@ static long htab_map_update_elem(struct bpf_map *=
map, void *key, void *value,
>  		goto err;
>  	}
> =20
> -	/* add new element to the head of the list, so that
> -	 * concurrent search will find it before old elem
> -	 */
> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>  	if (l_old) {
> -		hlist_nulls_del_rcu(&l_old->hash_node);
> +		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);

[Severity: High]
Does using hlist_nulls_replace_rcu() here violate the hlist_nulls lockless
traversal invariants for reused elements?

For BPF preallocated and LRU hash maps, elements are recycled without an RCU
grace period. The hlist_nulls algorithm relies on the invariant that such
recycled elements must be inserted at the head of the list.

If a lockless reader is preempted while holding a reference to an element
that is subsequently deleted and then reused as l_new, replacing l_old in
the middle of the chain means l_new->next will point to l_old->next.

When the preempted reader resumes and follows the next pointer, could it
skip all elements that were located before l_old in the bucket chain,
potentially resulting in spurious lookup failures?

[ ... ]
> @@ -1319,13 +1317,11 @@ static long htab_lru_map_update_elem(struct bpf_m=
ap *map, void *key, void *value
>  	if (ret)
>  		goto err;
> =20
> -	/* add new element to the head of the list, so that
> -	 * concurrent search will find it before old elem
> -	 */
> -	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
>  	if (l_old) {
>  		bpf_lru_node_set_ref(&l_new->lru_node);
> -		hlist_nulls_del_rcu(&l_old->hash_node);
> +		hlist_nulls_replace_rcu(&l_old->hash_node, &l_new->hash_node);

[Severity: High]
Would this suffer from the same lockless traversal issue mentioned above?

Since LRU maps heavily recycle elements without an RCU grace period,
inserting a recycled element anywhere other than the head of the chain could
cause concurrent readers to miss elements.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527070139.2233=
86-1-xuanqiang.luo@linux.dev?part=3D1
