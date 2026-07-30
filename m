Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583383B05A0
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393501; cv=none; b=CeOwbGpVgmAbl6KEJStQuwhjjdyKEBci1XubBsJRthsSeyHPQEriBtD8Gn3HFxzRUTjvXrA8oOUkm5ht+ln9+KgJgly9PxH7IXfOfKMEzA/5JDntw+FhnxCHVaZ12RrohOtHUzOnrGRv1sH2PWwx6kmcCeVv5xrhRclWhQXZwxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393501; c=relaxed/simple;
	bh=ccS/vynfAjtPWGb8cQXbw2Ma7u9Kc2So5zt5lpzwcaM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gTUAV4FpWcI4XE15l9rGfp+Tty/hddN0RPu2z3JXZ/Mr74LK+VjHKRiQlPP1+R0rTkEUeq2zZI/MG/auY/XhAn3wRGd0IwKKoC0mxt9j1gOajc9CL+rRNGhxEhWIYBXY8ie8YkwG5BcCARyC99e0aSw5DWOYix3yePyN8lohsjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=pHZHCR7C; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="pHZHCR7C"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cf50c6f235so19774245ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785393500; x=1785998300; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gGidP0vHSPV0NPul0Vyzr/cFRYrRFVowQdSQZFiXkIw=;
        b=pHZHCR7C3tPT3Z0r4VooonpWF4QZlEuUJnGudgBKFC2RitXrAmnzkSPkhrhLlF2fKs
         mLHD1MaDmhd1yr1tGy4JyXW3FhZ1dO88b04iMaW76E+hURKiq0Eu8DNLqtYVF+SpZ5+G
         gRPSWAhWz5L7D/SLEhZjJip+i+OlQTPK+NRpxxTQokfvn/lCbBmcILN7fqI88WBDcv54
         TPUQnkIZpb6pI2vwh4FIAoCWPSFWStSLMz7MZkB8F8KmMZhs8GpUy/Wyow/DEpy3aZL8
         T7s9YAVkd/I74rwyfPjcTpImFB7z3fJ+ysE2CVA/Eh9Hrl7Xi61z72WwOSWu6bAj/RmP
         Mjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393500; x=1785998300;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGidP0vHSPV0NPul0Vyzr/cFRYrRFVowQdSQZFiXkIw=;
        b=Uh/uoMsaU7NIVmawhlVXHKEcVzDLpltx7z8SHD2uc91N/bQa9YMEaxp5+O510t8Wtd
         4erNcczRbW8tBCZXLbA+yUwMZnwciJgveN1tzyKMGeEbyG3IBh939bn89HlNMXTAeL0H
         VwUo4lSWpQ99pu8v29GXLPGAgrb00ucOxN1IZvvaFYmj64sYo2iU7fsZGvz6bjUrifz6
         6Ilt1T4f+LEy0pkPBM1uWOmuRJAlNjuXq5qvUD8nGAu9MX8ywqcw4K8EnqLnY5OBsc7T
         Z0P6yQwAskumHmYtKc6S1v+wcDnr1X+DFfCeHW8UItjqSoMEudslObUQmAv2vRxhbF2p
         n/ew==
X-Forwarded-Encrypted: i=1; AHgh+RrIL+Cw+n7T8MOBxwRwYoWJoV24RivC8X+27dopOD9JNDOrz0hOmeE7R0KS1G9X5G/QHbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybo9K68aj1SGWvxebxsAmsaw47eSdgPJ0OT3UsHjXBeOJdK6y9
	zdLet6rrtUD8Yun5BhJLU5sBPtjR8mdYfcY/v1zf+zcgiVijjZplzJmPyLkPVrxJJLk=
X-Gm-Gg: AR+sD12FnDIQ2Ktba6NsNQn46KNkafK7A73K2q9/Dj4c28tQSAxqbr9okcxRzkxix6y
	51XZZm2h0UmHPQz2REx523BP/PAjG+i6MWwDIY9KjyHLO2cHOfMMIDfRiHmUWjQbg3+nra7e2Xf
	h+T3JAMd7cz4L6dnsgFFgiwNMgmAuRqYbducfHNaBAtof/1rIdwS9UwvPrHAXkXrMzq+P0RXqaC
	semslyYX8eme9BAaenPmVLbHywQN5xdlHK4XxooqPwHxNgmjQ+HlWfrP/v/1AdNvdG08W5iSo59
	cLVr4OnTG/VjD/GS64aiSJJfbI7qab4BbI4aMBJ3wmSub7CjyGhHJ5t+QTrWz/783Yzi/tgJXoE
	lFA1kIvxj3MfYSoO9Ah2mStUdT/3v8eEbyDv8H0nql1W6ZcQhUQSRWqIDTqpKF0+fDa1lMWyDby
	+CSsdL+DgdwOXi/foFhPyEk7twupolMiB0muDLA2GaLxh5NiUIg7Y1zgJNsVYC1wjV70qtwLlKP
	krCU9aMG3ztZXXXXA==
X-Received: by 2002:a17:903:1a2f:b0:2ce:8e70:3210 with SMTP id d9443c01a7336-2d035bdde67mr15176115ad.16.1785393499622;
        Wed, 29 Jul 2026 23:38:19 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a15303sm21373135ad.3.2026.07.29.23.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 23:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 02:38:18 -0400
Message-Id: <DKBP6A3V5I02.3GNQ1SEZST1F0@etsalapatis.com>
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
Subject: Re: [PATCH bpf] bpf: Fix netns reference imbalance in conntrack
 kfuncs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260729163141.213611-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260729163141.213611-1-nicoyip.dev@gmail.com>

On Wed Jul 29, 2026 at 12:31 PM EDT, Chengfeng Ye wrote:
> The opts argument of the BPF conntrack kfuncs can point to a shared map
> value.  __bpf_nf_ct_lookup() and __bpf_nf_ct_alloc_entry() read
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
> Read netns_id once with READ_ONCE() and use that value for validation
> and the matching get/put pair.  Each invocation then consistently uses
> either the calling namespace or a referenced namespace.
>
> Fixes: aed8ee7feb44 ("net: netfilter: Deduplicate code in bpf_{xdp,skb}_c=
t_lookup")
> Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert C=
T")
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Sashiko is right on this regarding all other fields of opts having the
same issue. While they can't lead to a crash, let's still snapshot them
at the beginning of the function so they don't change from under us.
This is still far from ideal - we may read an inconsistent snapshot of
the struct - but it's backed by BPF program-controlled memory so AFAICT
this is the best we can do.

pw-bot: cr

> ---
> Please queue this fix for stable kernels.
>
>  net/netfilter/nf_conntrack_bpf.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrac=
k_bpf.c
> index f98d1d4b42c3..8b540846f299 100644
> --- a/net/netfilter/nf_conntrack_bpf.c
> +++ b/net/netfilter/nf_conntrack_bpf.c
> @@ -122,6 +122,7 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_s=
ock_tuple *bpf_tuple,
>  	struct nf_conntrack_tuple otuple, rtuple;
>  	struct nf_conntrack_zone ct_zone;
>  	struct nf_conn *ct;
> +	s32 netns_id;
>  	int err;
> =20
>  	if (!(opts_len =3D=3D NF_BPF_CT_OPTS_SZ || opts_len =3D=3D 12))
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
> @@ -171,7 +173,7 @@ __bpf_nf_ct_alloc_entry(struct net *net, struct bpf_s=
ock_tuple *bpf_tuple,
>  	__nf_ct_set_timeout(ct, timeout * HZ);
> =20
>  out:
> -	if (opts->netns_id >=3D 0)
> +	if (netns_id >=3D 0)
>  		put_net(net);
> =20
>  	return ct;
> @@ -186,6 +188,7 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net =
*net,
>  	struct nf_conntrack_tuple tuple;
>  	struct nf_conntrack_zone ct_zone;
>  	struct nf_conn *ct;
> +	s32 netns_id;
>  	int err;
> =20
>  	if (!opts || !bpf_tuple)
> @@ -201,7 +204,8 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net =
*net,
>  	}
>  	if (unlikely(opts->l4proto !=3D IPPROTO_TCP && opts->l4proto !=3D IPPRO=
TO_UDP))
>  		return ERR_PTR(-EPROTO);
> -	if (unlikely(opts->netns_id < BPF_F_CURRENT_NETNS))
> +	netns_id =3D READ_ONCE(opts->netns_id);
> +	if (unlikely(netns_id < BPF_F_CURRENT_NETNS))
>  		return ERR_PTR(-EINVAL);
> =20
>  	err =3D bpf_nf_ct_tuple_parse(bpf_tuple, tuple_len, opts->l4proto,
> @@ -209,8 +213,8 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net =
*net,
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
> @@ -225,7 +229,7 @@ static struct nf_conn *__bpf_nf_ct_lookup(struct net =
*net,
>  	}
> =20
>  	hash =3D nf_conntrack_find_get(net, &ct_zone, &tuple);
> -	if (opts->netns_id >=3D 0)
> +	if (netns_id >=3D 0)
>  		put_net(net);
>  	if (!hash)
>  		return ERR_PTR(-ENOENT);

