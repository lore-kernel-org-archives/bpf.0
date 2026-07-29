Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D445C6EE
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343688; cv=none; b=rAfOePIw6wfiO5572jURMoEqXgFkXBPhvhg+qVMd+JPSRzcwCa69TdPPf8gDhmIu2fgIlrR95u8eMAk4/9AopRZWo6uOhko6aedwKy5AdKHcXtvZ0r4KfCoQF8egigfnH8yySxmmdvcRfk0mydmj2tlUFAwJTWP5h+T68CC8f1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343688; c=relaxed/simple;
	bh=I6vlKHn+Q/rqetnfyPR/QpneIW4SUACCsOUMXI181ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXqlhcimwdYUc235VA7pNotYeAuwmUZDN1vm6UTEmcRuQAmHizP0CbTDO5o4RZKKF1kIOqHuzlZWhXGowTcuucp+QjdFYMC5zyUH1qF6ry8+Lka66P7ZnqPTtGP3e0JmL9kIHe+5ZI1TTPh869DCX05uHW0BoltnXsbuGLBlWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHbqFYw5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHbqFYw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4961F000E9;
	Wed, 29 Jul 2026 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343685;
	bh=uFmmdYutr2lFqc930BLjm60KcodwRViefOwStVdi65Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHbqFYw5Vc6SQyfCf18TBa9o4i5Ystj7xGeFh50015UcBQO3PkxGU+vEgGbBajC6b
	 NWxjJYSpXhYbQrbpKndwnV8cSY5R+SE7+++hjqs7lJW3kkU4brGXWvy4R7EM3K9f1h
	 ZtULVN7urC6by9mg1Mo0qEk3B9m1jP7kqQzKcRIGHMMMsyZYD3HOEr/AOJEI8HgDpT
	 uOprbCJSjfKSp8munZ1sdD7Q0RAt5AAQuCQ2Tg1lff/ND4hiEePW05hKQlawPOFxTx
	 QouIMiHDoJ+FsxaxdAK5FP2tx2wZD5kiMlZR5FWtpaW/L28O1NBJwcCySiIUJmksFC
	 JZDybtUHQd1GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix netns reference imbalance in conntrack
 kfuncs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260729163141.213611-1-nicoyip.dev@gmail.com>
References: <20260729163141.213611-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:48:04 +0000
Message-Id: <20260729164805.5E4961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU races on `bpf_tuple` and `opts->l4proto` allow creation of =
asymmetrical and corrupted conntrack entries.
--

--- Patch [1]: [PATCH bpf] bpf: Fix netns reference imbalance in conntrack =
kfuncs ---
commit a848b567930cfe1aaae045cb53d2955c9b1029c6
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

bpf: Fix netns reference imbalance in conntrack kfuncs

This commit fixes a netns reference leak in the conntrack BPF kfuncs.
It reads opts->netns_id once using READ_ONCE() to prevent a race
condition where a shared BPF map value is modified concurrently.

> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index f98d1d4b42c3d..8b540846f2992 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
[ ... ]
> @@ -134,7 +135,8 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_s=
ock_tuple *bpf_tuple,
>  			return ERR_PTR(-EINVAL);
>  	}
> =20
> -	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> +	netns_id =3D READ_ONCE(opts->netns_id);
> +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
>  		return ERR_PTR(-EINVAL);
> =20
>  	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
> @@ -147,8 +149,8 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_s=
ock_tuple *bpf_tuple,

[Severity: High]
This is a pre-existing issue, but since this patch addresses a TOCTOU race
with opts->netns_id, could similar races occur with bpf_tuple and
opts->l4proto?

In net/netfilter/nf_conntrack_bpf.c:__bpf_nf_ct_alloc_entry(),
bpf_nf_ct_tuple_parse() is called twice sequentially:

    err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
                                IP_CT_DIR_ORIGINAL, &otuple);
    if (err < 0)
        return ERR_PTR(err);

    err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
                                IP_CT_DIR_REPLY, &rtuple);

If a BPF program concurrently modifies the shared map value containing
bpf_tuple or opts->l4proto between these two calls, could this create a
conntrack entry with mismatched original and reply tuples?

Could this also result in mismatched L4 protocols, violating core conntrack
invariants?

Additionally, later in the same function, we write directly back to the map
memory:

    if (opts->ct_zone_dir =3D=3D 0)
        opts->ct_zone_dir =3D NF_CT_DEFAULT_ZONE_DIR;

Does this inappropriately modify BPF map memory or introduce another
TOCTOU vulnerability if the value is accessed concurrently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729163141.2136=
11-1-nicoyip.dev@gmail.com?part=3D1
