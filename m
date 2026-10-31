Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793453539;
	b=ejWcbOc7sonllW+YsVnT63h07lNVedHKE1lXcqZ95bQe1mUwGM0wSgGcSKMXSvwyzNsP
	 mvJRDRt71JJUVHXf1+MJG/05rArQ3FK62myqNKXj5xUU8tbFjMHbpmAZxOR0JXoKRiCFC
	 /DnZiFzLRaYRx0pmqf0DsPeyuSwpYkqnbjDvWBjNr7K8vZInB/qOeccaEOVrrU/DUQZB2
	 QhUJrDTqHbx6oDLodPrhuvAsj3d6dxxgt2lnVUXVcSfB/uULHLaJULEEUyUphMTmA72kk
	 924m4v+WqkRAYwRgWC/XWADlWTNo5GgRF2CZQV9k1ZT+w3LXLK54rfDJCo6e8PmcEgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
	b=TpJGSbT2zcHclSA0llyj936vdnJetwFwGAJIXS+XIrzW6JG3hN/17UhPGQQm2+FZSLFW
	 234sfxNHwfox/Lz+PjPbgCZ+SC9ZCaxP5sbOVlQWTFwatd7Pprg90AwkjF9eKpVtPPOOc
	 rlKmI0jrz+0wIrh6vQAOOF49+q4HMaDVhO6Rdc0X+FpUYgqm7ka8sy6auCwFYaHydaJw2
	 wt8E0+RzkcGOz452iXTQSY7CC0PdHXvvyChbR5PtiUCtPyZZYEHzHZ3QaulExkcHHSojd
	 UqFl7jvY7sqyJcHE4VMeM9QNxzaUYBhOtOwstcTV2MBLJWl+94eeYEP2PaVKuRCFAKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CFC606A31F
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 13:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25CFC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a058f74a54so621794b3a.1
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 06:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793453538; cv=none;
        d=google.com; s=arc-20260327;
        b=ST1IMigqqN/PZ2N9ABZCERvK1TN3GN2PDveDWdfzeHqSqsncL0OxvP0JnaqE1lfhQU
         TtnD7hXYUH/oMkEFjXEk+EEW1wBP6L/J3o7tOAQJT3yCstLOJdp1N49XTlZuNHs2Yv0p
         2/S09X/dxc5eLxOGUehNtd/HSk2QFxZNqMv+0ERKO6Pz9DVV9OAhkL4Mfr8VmpYeA9zJ
         2AP6WuVuZxKNxW0fDXekyn1ZCoeUFTHeMLkogwqmlz6zMGrFi6ZF5Evo5ux9vVcZhuV1
         ziuW0fygJHqFtwLShNRuTX1ABgDGgL8Qjksmr62Eej8n2r4YD9RYBNa9VWWZBf7D3gtk
         nLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        fh=PAWUf9svO4hj7N26HOMPqebDnYPl6LJWOMNtuDChdkA=;
        b=nwGlmeczHsYr3vFNBmGBJhZ3a6eC+pSp4Z3ueI3sVU0p8y2kWyqC7FlhmsT1RMOAW6
         yfrZNyv1KmfE61+xGFq8yGTaS9iWeLJzQdsKR83ZKC7kZn3xICEMKfIIdY+iIE3onYop
         v4wbpJvGpRIVjXOPILB9ZppoR4+cxY6dnjLwWeZg8jj3WiyMfkaN1tq6p079HvE5UwQV
         emJjoC7IQwnaN1sTHb0UwF9W/25E0QFMaq6tXY7oxwdyTnN0Td58+kB7HA0Gmj1NW9/M
         yeSciHDPVNapNZ8bzZhpCWMV064+IcqYg53OQuCjwCNYu613EZ1xXGuIkGMAObbohjwJ
         2Mqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793453538; x=1794058338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=XKnOjMRPi1xowFEnisIR1z4LU2wkmPn460uIbnYFo262VHWeQFoTh/HoQdkw60dc1a
         1zdDrd+OqzuW41lm62mCj7dcoHFjgW2MOlHyj83i9lgrOZCcxL6XKUo55Ov0N0HUDQ5d
         EdoSbP9yfU2qWOluiS20Xn3hWPcx7/ZppJ26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453538; x=1794058338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=VAbky60VOLOEbs0EBsht16pR2CH3W0G7R4x+oCezI+dDktxll/T8p6cHfWspaayMwq
         Nd8e8v5MgHrBH9PrglqrCCTYfdbYSjPjee4DSKzYI/IJDGNS67zVaFPAwsqZ4heqvXQI
         xW4wydabasdpwhtk7AbmBEPOjdOwJVhdYIPgqxKT9z0V+GjY6uBv/NiP0DJoKDrGGEdy
         l3bRXek8wc6NEe2pGC0rSUXuL+r2sq9x8vhPW5ZmY69wI+ghTNLV7OT/5NtlQgsxZIwI
         6UuknUZtaKuP5t8RzuoQ2IKGGYdLn4/TdxbpTlmorM6nYxpn8qfYCnKtQUCVZCKd2IJr
         kTbw==
X-Forwarded-Encrypted: i=1; AKwUvBySZBAm/izGxnnmFWrZT86Im4IQUKr4O+wN3yy6YXbm4ES2vi3dp8URDPiRokDmidkn2RA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaXs/6rdoiUf32tMf3HdWlQy3N5RfkDifn31RWfng/06YQJSJD
	MTPWp5yqn3L0IYRwF0HoEFV7lNJtxknitdlh/e1orfPfpnHW5/0d+ioJhvl+udacjOrmkgT4p/T
	otc3cNAIlGRsIDg6JbkGxYL2QpXzham6QmlwxxjjY
X-Gm-Gg: AYBFou2K/fDl6flsAhTPOTC+k8j81dtmILuYEFOr6N38FLwkAtYdzzG0tQ6wM0phZ76
	rrs24aRJJZ3ABxfhscWousyuoNaP+uMH0xqyVX3j4vVedTzmDf1nEUZw6xH0+wIugNoOajshjO5
	1hruVrNsg+qJ7nu+kKTjV6Obmb49HN+dcdIuNysYbkBDlhlf3EZVKKDB6DJrlvqWc+tITi8Mngf
	9qDWV81+IkT1PitzKizu2VxpN5uWSW+Rg3srWAOjUEoR2vHX4YAO305V2U+RelmsqpDZ2vYXDiU
	0zA+TiLCv7B90ShtEP6w4Kl/xbh/9jgaepqFtqmJFBNBGMj7TMsfIg6neoH4yIOISyF0dzKn7Mr
	DxoTey/TaqzfVIx4mAINJ8WWJEk15F3v6o7Uz4TB+Op980TKpigYX+P7KrSjQtiHcjIPtSa1Xce
	s/0gR86lHypMdSf7g=
X-Received: by 2002:a05:6a00:4b12:b0:89e:fc56:a25e with SMTP id
 d2e1a72fcca58-8a9bfa02bd4mr4056675b3a.41.1793453538349; Sat, 31 Oct 2026
 06:32:18 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
 <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
In-Reply-To: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 09:32:06 -0400
X-Gm-Features: AclHuK-ddqUaxwQGu_QsdsX_5VreQz3XrjlPaOLjbuJHGuyWX_YBYrjskp5eDDg
Message-ID: <CAM0EoMn7kvsfZbsOdU3jHiT1Ypc6OHHu_+empy=Fmu33Etfhug@mail.gmail.com>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, 
	bot+bpf-ci@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@gmail.com>, Martin KaFai Lau <kafai@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > Add egress coverage to tc_redirect_neigh: the existing test only attach=
es
> > redirect_neigh at ingress, where mac_len is populated.
>
> This test cannot hit the BUG.

It was reachable _before_ the fix, normally useful to include such tests.
I will drop it, but if you think it is still useful and you catch me
before i send v3 i can include it (or can be sent afterwards).


> Just drop it and respin as [PATCH bpf v3].
>

Will do a v3 sometimes today for below...

cheers,
jamal
> >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device=
 *dev,
> >                               struct bpf_nh_params *nh)
> >  {
> > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > +     struct ethhdr *ethh;
> >
> >       if (unlikely(skb->mac_header >=3D skb->network_header))
> >               goto out;
> > +     if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > +             goto out;
> > +     ethh =3D eth_hdr(skb);
>
> ETH_HLEN is not enough.
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
> and ipv6_hdr() right after the pull. Nothing makes these headers linear.
> Take the AF_PACKET frame from the commit log without pop_eth and
> bpf_skb_change_head():
>
>   packet_snd()                     headlen =3D=3D 14, IP header in frags
>   skb_pull(skb, ETH_HLEN)          headlen =3D=3D 0
>   skb_reset_network_header(skb)    network header =3D=3D skb->tail
>   ip4h->daddr, ip4h->saddr         read past skb->tail
>
> The route lookup runs on garbage.
>
> Eric's skb_network_offset() check also covers
> mac_header >=3D network_header. No need for two checks.
>
> Something like this:
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct ipv6hdr *ip6h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
> +               goto out_drop;
> +       ip6h =3D ipv6_hdr(skb);
>
>         if (!nh) {
>                 struct dst_entry *dst;
>                 struct flowi6 fl6 =3D {
> @@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct iphdr *ip4h =3D ip_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct iphdr *ip4h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
> +               goto out_drop;
> +       ip4h =3D ip_hdr(skb);
>
>         if (!nh) {
>                 struct flowi4 fl4 =3D {
>                         .flowi4_flags =3D FLOWI_FLAG_ANYSRC,
> @@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> -
> -       if (unlikely(skb->mac_header >=3D skb->network_header))
> +       if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
>                 goto out;
>         bpf_push_mac_rcsum(skb);
> -       if (is_multicast_ether_addr(ethh->h_dest))
> +       if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
>                 goto out;
>
> -       skb_pull(skb, sizeof(*ethh));
> +       skb_pull(skb, ETH_HLEN);
>         skb_unset_mac_header(skb);
>         skb_reset_network_header(skb);
>
>
> pw-bot: cr
