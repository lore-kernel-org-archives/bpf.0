Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B2337757D
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531146; cv=none; b=ZzzAKZMustTHKdX/2zczIsiZi45ZZ9b97iFAXepeAlIPiNyp61w21pkRmYB0Xfgbi03YxIFcuc5eB0aelNv7M+yvArQqc6GlZeB+iLsk3Q1BG7qrw7CyRLeEKgKi6XvVgmutu72GFMlQPcKPrxPCNDZ8G4ZNFiL+uFi/9HdCdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531146; c=relaxed/simple;
	bh=sLjIwu4tmNHdvcjwg/pEi7VShxPEnzLfOCPpy3bjzng=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mrP7YuWwdnLDtU19kPftQ+0ClIMHQ3uc5px9u7ShdRMJzAlTai+uon+F3/zIkPRzbv8tDUFcHRTv9EX9t6g8GDuHnTcrcswlNX8HVIZHLxrIfaefjy4rKllvsXkoSzomAf19IZJdmYd1APM3YDTLKdE9cDoUaIr9x2rQu1n0BlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=BKF0MIdH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="BKF0MIdH"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1244279a91.3
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785531143; x=1786135943; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7+TPRx2tkhyaW3YvrP0FE1NEWjjzjNC+jDfcFdsC2BU=;
        b=BKF0MIdHOsgciPrK/bIMfDIPTjHPSHeoVWrXEVV2QZ0pryRR4t6enKiJc0djfTUeul
         x+5bPmxfmFnGsv/DoZ7lO/ftOBiugS8tG70M6MglBnbWNlq7XL+rOWxJG5a5nb9zyTmA
         mNelYGsD29U5g86EwQP0GhqZ9t8ZdqSmBaXovEgjXTCQDmQzOvM0Bkm2emw0tdfSz3hO
         xiMg1YRVavd08dq2out6yr3tex58Qd0bB2zY69cQfrzu56+ukZqX2Ch4IHaAg2cpehq7
         37gzVC+f8itfFXkRNY7Uhlju3GRTmC/Xk5zGATp/Ucowsb1cRSpVBIUP0HX1wAGF1s+U
         hfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785531143; x=1786135943;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+TPRx2tkhyaW3YvrP0FE1NEWjjzjNC+jDfcFdsC2BU=;
        b=oN61SYFHgOdmpsew4NtFl3jWjG+hX/FxBk+zmbN9taxFc5lTHaqEQRpctEQ1zkehfZ
         /0JmpatGPcH5Db9O9NpsRWdHHoepty+umG0xdbWB7SAEUa7pMVZGPZbA9IDujDtGZlAl
         MVwBwD2bMYMub4ne0A41le5oVBub1MqKJRD/hqEHtJXofm5+mg/97F6WFIWeWQQ4odr/
         EYAm5z/o6cij9n9HnAjMH34Xx2RctPt5msvBjeBPrdDApUc9xT4XHGnCSAmGoZfbRau2
         YZRrT9zPaX8d2PtEiKnZ/F0n3H1xoFN8U1MhAirg+MAOvUUzgNWglP5dENg6qJP5LjTV
         fmgA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7kqcV7+0B8HfHMpTK/lTsPuYVe3V3XPY+l0zvySRhOBZjbY+wN2AUk97MRZwAB2ekhPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdb1CG3d6IAB/YnBE2HqZmY5QRt54ScQCnLxA+eP2YZhmkvmt
	TS9s431KnsMBygchcppWjmzAWgeA6XY9V3N2jkPnfGhaHJ8He+GphVQi3z5D1cF4IbU=
X-Gm-Gg: AR+sD11dQHs6TCl46TikmMIVH82NrCzT6IKe3QE0KDmoigFlKVLnOwrMVuq+GkgYcTk
	N+ZpbDBHvoFQ3s2Oldo6D9d4ixR/CqJe57hbLJZwpp0QrdgQQ9SLpw6wMl7d0GMCE57OOJYu+8i
	UJckzTou5MEurPMRayNVnXFU3bfr6shfpmv+28AQ9VejQLCAwzpRH9BHUZxy5DQHrNQJtpRdqRZ
	QTt3r9izRr/kvnQwTkMPK0TrybcGFucjN3AwDSDGbv6+NGxLvEDkhJEBwJI/eKMhcyJt3jpdfuy
	qNOEH0nwX4k/+IRGEEYSO4UizwM0iBbKmc0gWayGwCvEl8r+i+7TthB4Ww8WGXnLqHZYcC634JS
	qhKhkXpDuzgPAropIJrbcYqN5H32VUCezVkfIZyRUiTaPOaKc2VQRW9CHyLOGEj2OxLIutThl73
	Cz3eTF3rdd7LaFBtl9Z2RjtkE2XRfyNaobVTfHbJY2ixvZERL1NfjAu1vKma7yOa2wu/G3c+xC6
	K/hUx7L4tBNJyKqH+by/vlgVauL6Q==
X-Received: by 2002:a17:90b:5888:b0:38e:7268:220c with SMTP id 98e67ed59e1d1-38fbc4eb925mr1073811a91.32.1785531142984;
        Fri, 31 Jul 2026 13:52:22 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29836e7sm713472a91.1.2026.07.31.13.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 13:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 16:52:20 -0400
Message-Id: <DKD1YQ8Z52QD.HUDM65AALUYG@etsalapatis.com>
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>, "Pablo Neira Ayuso"
 <pablo@netfilter.org>, "Florian Westphal" <fw@strlen.de>, "Phil Sutter"
 <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Lorenzo Bianconi"
 <lorenzo@kernel.org>
Cc: <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v3] bpf: Fix netns reference imbalance in conntrack
 kfuncs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260731160921.3245840-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260731160921.3245840-1-nicoyip.dev@gmail.com>

On Fri Jul 31, 2026 at 12:09 PM EDT, Chengfeng Ye wrote:
> The opts argument of the BPF conntrack kfuncs can point to a shared
> map value.  __bpf_nf_ct_lookup() and __bpf_nf_ct_alloc_entry() read
> opts->netns_id separately when acquiring and releasing the network
> namespace reference.
>
> The reference imbalance can occur as follows:
>
>   CPU 0                                  CPU 1
>   read opts->netns_id (-1)
>   skip get_net_ns_by_id()
>                                          write opts->netns_id (id)
>   read opts->netns_id (id)
>   put_net(net) /* no matching get */
>
> The reverse transition leaks the reference.  Repeating the unmatched put
> can destroy a live namespace and crash later users.
>
> The kernel reported:
>
>   Oops: general protection fault, probably for non-canonical address
>   KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
>   RIP: 0010:bpf_prog_test_run_xdp+0x52c/0x1700
>   Call Trace:
>    __sys_bpf+0x1662/0x50c0
>    __x64_sys_bpf+0x73/0xb0
>    do_syscall_64+0xf9/0x540
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>   Kernel panic - not syncing: Fatal exception
>
> Snapshot every input field of opts with READ_ONCE() before validating or
> using it.  The netns_id snapshot keeps the namespace get/put pair
> balanced, while the other snapshots keep the remaining options from
> changing partway through an invocation.  The individual reads can still
> observe an inconsistent combination during a concurrent update, but each
> selected field value remains stable for that invocation.
>
> Fixes: aed8ee7feb44 ("net: netfilter: Deduplicate code in bpf_{xdp,skb}_c=
t_lookup")
> Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert C=
T")
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
> Changes in v3:
> - Inline the one-use reserved-byte READ_ONCE() checks instead of
>   copying them into a local array.
> - Reorder the new local declarations in reverse-xmas-tree order.
>
> Link: https://lore.kernel.org/bpf/20260730082958.2065194-1-nicoyip.dev@gm=
ail.com/ [v2]
>
> Changes in v2:
> - Snapshot l4proto, ct_zone_id, ct_zone_dir, and the reserved bytes in
>   addition to netns_id, as requested in review.
> - Rebase onto bpf/master.
>
> Link: https://lore.kernel.org/bpf/20260729163141.213611-1-nicoyip.dev@gma=
il.com/ [v1]
>
> Please queue this fix for stable kernels.
>
>  net/netfilter/nf_conntrack_bpf.c | 72 +++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 24 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index f98d1d4b42c3..c2df7c948281 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -122,42 +122,54 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf=
_sock_tuple *bpf_tuple,
>  	struct nf_conntrack_tuple otuple, rtuple;
>  	struct nf_conntrack_zone ct_zone;
>  	struct nf_conn *ct;
> +	u8 ct_zone_dir =3D 0;
> +	u16 ct_zone_id;
> +	s32 netns_id;
> +	u8 l4proto;
>  	int err;
> =20
>  	if (!(opts_len =3D=3D NF_BPF_CT_OPTS_SZ || opts_len =3D=3D 12))
>  		return ERR_PTR(-EINVAL);
> +
> +	netns_id =3D READ_ONCE(opts->netns_id);
> +	l4proto =3D READ_ONCE(opts->l4proto);
> +	ct_zone_id =3D READ_ONCE(opts->ct_zone_id);
>  	if (opts_len =3D=3D NF_BPF_CT_OPTS_SZ) {
> -		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
> +		ct_zone_dir =3D READ_ONCE(opts->ct_zone_dir);
> +		if (READ_ONCE(opts->reserved[0]) ||
> +		    READ_ONCE(opts->reserved[1]) ||
> +		    READ_ONCE(opts->reserved[2]))
>  			return ERR_PTR(-EINVAL);
>  	} else {
> -		if (opts->ct_zone_id)
> +		if (ct_zone_id)
>  			return ERR_PTR(-EINVAL);
>  	}
> =20
> -	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
>  		return ERR_PTR(-EINVAL);
> =20
> -	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
> +	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
>  				    IP_CT_DIR_ORIGINAL, &otuple);
>  	if (err < 0)
>  		return ERR_PTR(err);
> =20
> -	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
> +	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
>  				    IP_CT_DIR_REPLY, &rtuple);
>  	if (err < 0)
>  		return ERR_PTR(err);
> =20
> -	if (opts->netns_id >=3D 0) {
> -		net =3D get_net_ns_by_id(net, opts->netns_id);
> +	if (netns_id >=3D 0) {
> +		net =3D get_net_ns_by_id(net, netns_id);
>  		if (unlikely(!net))
>  			return ERR_PTR(-ENONET);
>  	}
> =20
>  	if (opts_len =3D=3D NF_BPF_CT_OPTS_SZ) {
> -		if (opts->ct_zone_dir =3D=3D 0)
> -			opts->ct_zone_dir =3D NF_CT_DEFAULT_ZONE_DIR;
> -		nf_ct_zone_init(&ct_zone,
> -				opts->ct_zone_id, opts->ct_zone_dir, 0);
> +		if (ct_zone_dir =3D=3D 0) {
> +			ct_zone_dir =3D NF_CT_DEFAULT_ZONE_DIR;
> +			opts->ct_zone_dir =3D ct_zone_dir;
> +		}
> +		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
>  	} else {
>  		ct_zone =3D nf_ct_zone_dflt;
>  	}
> @@ -171,7 +183,7 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_s=
ock_tuple *bpf_tuple,
>  	__nf_ct_set_timeout(ct, timeout * HZ);
> =20
>  out:
> -	if (opts->netns_id >=3D 0)
> +	if (netns_id >=3D 0)
>  		put_net(net);
> =20
>  	return ct;
> @@ -186,46 +198,58 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct ne=
t *net,
>  	struct nf_conntrack_tuple tuple;
>  	struct nf_conntrack_zone ct_zone;
>  	struct nf_conn *ct;
> +	u8 ct_zone_dir =3D 0;
> +	u16 ct_zone_id;
> +	s32 netns_id;
> +	u8 l4proto;
>  	int err;
> =20
>  	if (!opts || !bpf_tuple)
>  		return ERR_PTR(-EINVAL);
>  	if (!(opts_len =3D=3D NF_BPF_CT_OPTS_SZ || opts_len =3D=3D 12))
>  		return ERR_PTR(-EINVAL);
> +
> +	netns_id =3D READ_ONCE(opts->netns_id);
> +	l4proto =3D READ_ONCE(opts->l4proto);
> +	ct_zone_id =3D READ_ONCE(opts->ct_zone_id);
>  	if (opts_len =3D=3D NF_BPF_CT_OPTS_SZ) {
> -		if (opts->reserved[0] || opts->reserved[1] || opts->reserved[2])
> +		ct_zone_dir =3D READ_ONCE(opts->ct_zone_dir);
> +		if (READ_ONCE(opts->reserved[0]) ||
> +		    READ_ONCE(opts->reserved[1]) ||
> +		    READ_ONCE(opts->reserved[2]))
>  			return ERR_PTR(-EINVAL);
>  	} else {
> -		if (opts->ct_zone_id)
> +		if (ct_zone_id)
>  			return ERR_PTR(-EINVAL);
>  	}
> -	if (unlikely(opts->l4proto !=3D IPPROTO_TCP && opts->l4proto !=3D IPPRO=
TO_UDP))
> +	if (unlikely(l4proto !=3D IPPROTO_TCP && l4proto !=3D IPPROTO_UDP))
>  		return ERR_PTR(-EPROTO);
> -	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
>  		return ERR_PTR(-EINVAL);
> =20
> -	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
> +	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, l4proto,
>  				    IP_CT_DIR_ORIGINAL, &tuple);
>  	if (err < 0)
>  		return ERR_PTR(err);
> =20
> -	if (opts->netns_id >=3D 0) {
> -		net =3D get_net_ns_by_id(net, opts->netns_id);
> +	if (netns_id >=3D 0) {
> +		net =3D get_net_ns_by_id(net, netns_id);
>  		if (unlikely(!net))
>  			return ERR_PTR(-ENONET);
>  	}
> =20
>  	if (opts_len =3D=3D NF_BPF_CT_OPTS_SZ) {
> -		if (opts->ct_zone_dir =3D=3D 0)
> -			opts->ct_zone_dir =3D NF_CT_DEFAULT_ZONE_DIR;
> -		nf_ct_zone_init(&ct_zone,
> -				opts->ct_zone_id, opts->ct_zone_dir, 0);
> +		if (ct_zone_dir =3D=3D 0) {
> +			ct_zone_dir =3D NF_CT_DEFAULT_ZONE_DIR;
> +			opts->ct_zone_dir =3D ct_zone_dir;
> +		}
> +		nf_ct_zone_init(&ct_zone, ct_zone_id, ct_zone_dir, 0);
>  	} else {
>  		ct_zone =3D nf_ct_zone_dflt;
>  	}
> =20
>  	hash =3D nf_conntrack_find_get(net, &ct_zone, &tuple);
> -	if (opts->netns_id >=3D 0)
> +	if (netns_id >=3D 0)
>  		put_net(net);
>  	if (!hash)
>  		return ERR_PTR(-ENOENT);

