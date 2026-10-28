Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188497;
	b=A0D7YruiOLusjIkWTS3WPNh5s8V9Af6X/JB7aE9nQJM3PJAZ9NHzpN7/uDDa5aYPF5vt
	 mdx0LpJp0koK+c657IYtoZmmruax/3t2v4VOVewtGw8M2C83+WbIhVROOxMkAl/OqCYhP
	 HkPrfieawMJAzvA/YX8Dp3YqKf2cufrsOuQZbGqORzJNbxJM/bTmKCNML2OCw/MRqOsUx
	 eEECJuRyFKoS0ZDS7Y9AJvCVwz8xMNDlRV9xzFJUA9CLBqjEj7yut+bKBbtu6BxWm1vH+
	 fBkXwEhdik0BhXJ/tTZhpcmG6WyQ6T4oPTfR36xGBhHPQ6Rnyz3UNC//umsn3ZRz0LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
	b=RWrUbrrF4xjaXrG0pXqJACUwYyrhnvJGZR2WO9VtYhq6QgvFPJjDayoSd1LUwmM0z0HL
	 6QBWhwI9Br0EZnZfE3IlO2r0/f/gF0CVPBUchRnWAQIUNkO6fPAvDS2F3aYAS5puKdDXt
	 RGFHKFl/7bpyztLx5yS2haU5CJ84PQUUdr8G7gVH0wy2T4GMkkfNIc5C+KZMRun09Y7d1
	 VUkQF2V8CHOLA0ioi//38JdlNHFqxKrgueUkS6+tVoUUICB8PnhOp4LHtORcklC6pRjL4
	 FV8+afSyfFaWYl2bRVdGj1isFDrLpXIuskwnKL7okS0MYsoEM3NeVoqOio3rq0E/d1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83947606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83947606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GepBUTsu
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89d6bd67045so380185b3a.0
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188496; cv=none;
        d=google.com; s=arc-20260327;
        b=IeELy0Hyee91aRan3dDQM44HBaUyr49Jehd5K8tsrQcOc65aKc4Qh+7ShUVpjBAWtG
         RxxIUAHUOAWama2WKaU0MxzLxWoVR9vsr5PZLaCE4nwUtU+xEX8ooGylvZcdjXizbyj/
         nt9amlMKqXW2WeSmh7JNz+Cv5Yq5/J/d0AOWrriMrMzr4J8vqCbSBSRTiaEuW+aTYc4t
         HJ2AqB92o3izcyVrpNJjQvm2oQ7E3cbXWmAA8wYZoKiqF+WW9lufC8RffwbkzgdSa+vi
         FqOYQYv5CHXvzPXiud6SF2LWnG50Yx/OA4PPFIHJPc6NbbWKtU2SW/bWNo8fzeLzeiAO
         izsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        fh=l1zg378WYkZOf3x4HiNqUyeCqLsOn1TWr56U4rFof6c=;
        b=UrF0/qrdBww7/L0TPq6k3BTJBbD9zDOURpsH5ijM6aBzjNHA3XpRefwOex037n3lN3
         6Kuy7usQ6aS751DASW/5vz6G+BdqiokrC8WIstQk6T1f3klByLMq4CV3f/4N/mv5kxGJ
         /HZiBZHC7dxtKCKakEHNRnU4jN2muaQVeLIlsW0GoolkjNF5gO4wovQHS2GBGSlY7ZyG
         NNoIgBgjZXRN9ncX4O0DuwnfV51nvvF4spoq0IpIkj4HXDQS8PSHWBYvItJt795hzz8+
         2ztnXmojDMi4GLTa1UrZWVdx1x4mFX5+QK9P9YLRrE1ULgtL1VPlf/fk46g8J3ldOkSA
         Qg7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188496; x=1793793296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=GepBUTsumw8B4jf7+5KsVIfO5khMkRoPJ6+MFUMalfeb4q/FoMETrLQTAanFOOmnMz
         Pqa8pZ4flYMTlyMDol2VB4cEXZ3yBtiPuZpBMkpM/MRee6V9hj6Vzn++AjQh7Yn9u5VU
         8B6nCqi2CkM96kUhqxa5KQ9foXclVftX4roG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188496; x=1793793296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lx6Zbw4MgTbea9Oek/HKn7SBODwaBqEspj7Hz7Ai6x4=;
        b=jB2yXhRdeYRelKg5rJTeYHjdYojmIuihvxVhzGHujQ3XNSZIKO8yDn3Rqze/3+npxn
         pJxnx/WWyhaqKTXI/yhuAU467+w1ewvM1JfqnlpNJxmdsmO/wcvdbZSK2bdxPtMPBA0v
         bvGOfKBeUeblk5MlxGub4GmJezRCPO9CSlbPvvOxbZamA+kwDeUNxKne1sGSOfIR715H
         5NiaCHwWg5ORovfm20h+L/U4dyM0xRLi2gMMTLY5loG9uU3HX4MXI++5cDsu4D+tVopI
         N7feLDsxfq3rzGY4fPhp8mist3bqSCI+yoEcOfXOxPGn0CH3yfnEAS8VZ2cS6pc8RlEx
         g32Q==
X-Forwarded-Encrypted: i=1; AKwUvByed5qMicCJC1p175uFCkKATXL02j2DE8Ip8g0wDndYXyBcFLTKoQLCBb3OFHFt1yX9o2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJy9jRkDbuusp9tWxXvCpOfDXjCTNV4iBMp0JXw3uJldmXkESYe
	W7INiOjNhnaz0+Y+MiDG74/sCmjnFD8jXvkef52Y2z6wwYGmhfUJsbPWO/8zyWiFqH78DB5n7Ip
	392v7csgeaWyeb2IP94P7Z6ZwUgFgJ2I5xUk03/51
X-Gm-Gg: AYBFou3scsijaZwpyA6XO05sI5o5fZErdR5EpihxS7mYSOx42edrK+QjxNw9PkB4kYU
	b2pRA8b3pAn40OsHqYtnngZ/lvQqvysw5jmyIrFHtk8rhBQrf0VhfSdL0EM63ZutxZmzPg2H8w9
	GiOW+nlAb53CZRTf3E2Y4vjIK3rlcEulUb62LdHwQQ67140BZDK5wCxkJ9os7R7IEl0uaNHFrle
	MFwlfhjFFglLqpjf8mIqIJtgzZLVUY4JAb4BqNkyW4qXXtmitlkEwL5rUs74ZoiH9PJQFvpd6Qr
	LYzWcBYdYBWfV5/7wM6UvCx+4KlR/ISjEGqbF+HIDIdXwAaG7mPZ37bfBVOfGhRjHNh5xFz/u00
	nt3CstuZVrVp8i4U7xeccMH5HWaC9ZOLJIE5dT1POrAHZcPkg3LCzb70M4QcwOWLT4yK9PpCnbT
	Gk0+3u7KmTumV7S2Y=
X-Received: by 2002:a05:6a00:298d:b0:8a0:4e73:7e1e with SMTP id
 d2e1a72fcca58-8a5a61d5a21mr3166982b3a.44.1793188495937; Wed, 28 Oct 2026
 04:54:55 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
In-Reply-To: <bpf_redirect_neigh_short_linear.v1.r0.20261028033717-1@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:54:42 -0400
X-Gm-Features: AclHuK8FFpZ2c_Jj5uxJu1FiuE7Oufyw0mcohrzYGLVHSyYoRc0o8GsFlrm80gs
Message-ID: <CAM0EoMnuCin5C_ZJa2Mx+VT9CFSEznG-9hWjkBz7=Ntwi-AUxA@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, David Ahern <dsahern@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 5:19=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> The issue:
> This is a follow-up to the short link-layer header fixes[Link].  After
> vlan pop_eth, a privileged SCHED_ACT BPF program can call
> bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().
>
> __bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
> only that mac_header < network_header.  It does not check that the MAC
> header is long enough or that it is linear.
>
> A SCHED_ACT BPF program can do:
>
>     bpf_skb_change_head(skb, 1, 0);
>     bpf_redirect_neigh(lo, NULL, 0, 0);
>
> after vlan pop_eth.  The skb then has mac_len =3D=3D 1 and only one byte =
of
> linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
> __skb_pull():
>
>     kernel BUG at include/linux/skbuff.h:2839
>     RIP: skb_pull+0xc5/0x100
>     Call Trace: skb_do_redirect -> ...
>
> The Fix:
> Drop skbs whose MAC header is shorter than ETH_HLEN, and use
> pskb_may_pull() to ensure the Ethernet header is linear before reading or
> pulling it.  Re-read ethh after pskb_may_pull(), which may reallocate
> skb->head.
>

pw-bot: cr


cheers,
jamal

> Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in"=
)
> Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@ke=
rnel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/core/filter.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 70dc621672f2..4d344ec09736 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2432,10 +2432,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> +       struct ethhdr *ethh;
>
>         if (unlikely(skb->mac_header >=3D skb->network_header))
>                 goto out;
> +       if (unlikely(skb->mac_len < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
> +               goto out;
> +       ethh =3D eth_hdr(skb);
>         bpf_push_mac_rcsum(skb);
>         if (is_multicast_ether_addr(ethh->h_dest))
>                 goto out;
> --
> 2.43.0
>
