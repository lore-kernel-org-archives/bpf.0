Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195635B65D
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778912; cv=none; b=dwm//nQpGN5XfQ7vbbKZYzJGl9+6YJyfaGsW1PQLYiU9tQyTCh1KgNTwrgs0LIBqzQcKvsvQvxOZXSjjNpoKvYrFB+QqRf5Ym5j4L+xdcJzm/uHn8svsHCf0iZEcHeFr+4nJGDhdASN+grcegAjfkawiFFvmOUWGvWWmlvss0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778912; c=relaxed/simple;
	bh=LEUWI/v6EYlRZ7WoyXnmqZYW2uNM8SWdu+5GiaZhZtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9l5DLBxe2FK25wmLDjPc72W2o7EGH/Pb/vfOtxOJECR5im02bPcuyztFhSkzn1tKb2KV6kVNqjDVYs1pGRcD3HH9ZD6HG+vaq2v3v3EMt46YI2ANvfbBWF+U8bD6mIvKhkqGoHLRYu5u87/B873gt5Lki38n+Tv67LHrHN+kUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhiSLIAG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhiSLIAG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B061F000E9;
	Thu, 18 Jun 2026 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781778911;
	bh=uuaL6W6KVNrKJpCaoWIbOh/NQw+9LisDOEJtdLd+1sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WhiSLIAG1aE+ByddjfmCzN18/EweF2OzB5CajGs2ojh+GVeRAv6ABqAlPj0zyLTaQ
	 xt5kXYm4fG048ofJ0BSUCKslfl6u+VClFT4jkW5uHHbmMTeVBka8qIDWbs7If2EjZZ
	 TNhF6/taX4Pkm4Snn9PvfS16tsGETop1pVouYjzvbza4twILS9jZ/4CB/Ru2Ccw/FH
	 3HX5X+z22Pl89AuuKuSUVzpyvLcjBR99gkMilWXZEx+iWzPXyjGae8zOe0u7YOlIP7
	 Igzdupx0G5vNZnjn76/vdBFSOhnjv6NToIx/lTYSxPtz8vmLc79W6kzTy5HJCusaUV
	 0RBpH4YUYWMyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Guard conntrack opts error writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <9535e781fe14449b1d4e9bbc3baa7566a93bf512.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
 <cover.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
 <9535e781fe14449b1d4e9bbc3baa7566a93bf512.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 10:35:10 +0000
Message-Id: <20260618103511.09B061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A TOCTOU race condition exists on `opts->netns_id` which can lead =
to a `struct net` reference count underflow.
--

commit 6a009d88e07d68168e19d68a21a35e332591db32
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

bpf: Guard conntrack opts error writes

This commit updates the BPF conntrack lookup and allocation kfuncs to
validate the size of the opts struct before writing to the error field.
This prevents out-of-bounds writes when the supplied opts__sz is smaller
than the offset of the error field.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index 40c261cd0af38..f98d1d4b42c3d 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c

[ ... ]

> @@ -297,12 +306,7 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_=
sock_tuple *bpf_tuple,
> =20
>  	nfct =3D __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tup=
le__sz,
>  				       opts, opts__sz, 10);

[Severity: High]
This is a pre-existing issue, but since the opts pointer points to memory
provided by the BPF program, which can be a shared BPF map value accessible
concurrently from user-space, does __bpf_nf_ct_alloc_entry() have a TOCTOU
race on opts->netns_id?

Inside net/netfilter/nf_conntrack_bpf.c:__bpf_nf_ct_alloc_entry():

	if (opts->netns_id >=3D 0) {
		net =3D get_net_ns_by_id(net, opts->netns_id);
		...
	}
...
out:
	if (opts->netns_id >=3D 0)
		put_net(net);

If a concurrent process modifies opts->netns_id from < 0 to >=3D 0 between
these checks, put_net() could be called on the unreferenced original net,
dropping a reference that was never acquired and leading to a use-after-free
of the network namespace. Similarly, changing the value from >=3D 0 to < 0
would leak a newly acquired net reference.

The exact same pattern is present in __bpf_nf_ct_lookup(). Could we read
opts->netns_id once using READ_ONCE() or cache its value locally?

> -	if (IS_ERR(nfct)) {
> -		opts->error =3D PTR_ERR(nfct);
> -		return NULL;
> -	}
> -
> -	return (struct nf_conn___init *)nfct;
> +	return (struct nf_conn___init *)bpf_ct_opts_result(opts, opts__sz, nfct=
);
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781765747.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D1
