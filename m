Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1F271476
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986431; cv=pass; b=gb4OkAtQoKvwMeFRg4zuwMl/WRauc1uY5J+l82JbuXKzK6R/HnO45Ztoemod7OGeS+fj68O2k0UTP6ubMtpELIQVMxB+tldcvucBVVX4eTdMWf2MDeAmqtTi5qNo19MemI9uZf5c0eDRL1Pz6wym//q8YKU3RiXTRLdw8AhhptQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986431; c=relaxed/simple;
	bh=gohU0oHrqyfC2YvEsI3bsCd8kFWaPia1W/kE1EJeMTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVFYVAJm9jHuCcKBGDdx2uSusM/ZFU9xUlP62qeDCJ0Y8KqG2fcjsP0yE+AMwraCCX/SRFHxDi/JQeYrW0nWdhnaWuYeyXmQkyAu6f07d7K0awx7NbbRNWWlV/yom9CshVjbiVNmhIEKkzVAabU7pisloiMifRnkxdbNBDAAzyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gYS4ejna; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gYS4ejna"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-509062d829dso247811cf.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 23:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773986414; cv=none;
        d=google.com; s=arc-20240605;
        b=Zh6HlGR+OY/dWoIfevJ4pM24nypaEx2aeO6Z2KVleRS+hnYKexDjmyyrIIYxvat+Lo
         2kbtP2+JiTua6/AO6tMtIGhNsqPbjtJRnrLPv6yw8LxsKJPQ5yzXxeKBrO58amfnEYb+
         dTXcMOMSItWNH8lI/cZT8DNGr0CW7g1Is6y8Yd7tiS3U08OCOmFYeex3ATcVf1h3mLYs
         Img+LOYbx4KYMCG3VyG/sRyvtxze7b4aRcasWGbNh9lI6CW2vd3/IFIFl6RyZbeZYxXy
         I8eP3nPPCKVDR3SvSafuKePmrZeZ5lOEOWJnr55ifjFI5xLucGlJfOw7gjguvSI0I1aw
         n4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3AnVHiBXZex/xrLVAMzeCF2kXP3o0tCzeT0IjBMeI3M=;
        fh=6OsT/aQ5TQHU1ur2pQAhS+f8iM9kq3NmNXGnwcNcfSs=;
        b=ekvDOht8SD4fabD7r9RoSEi8GAz3K1pSaq1SWlBhAKDbGgwF+lwIrHUxPXcImZ431T
         FfOF3vwrjbDbQCGmP7YMUtDo5JhIOMY7j3FSaY++Zzgp7yaYF9lmWsieHuw/HP6lil1e
         Nylyn6R9Wrw/MqM9LYmZmL4XSy7Mzu7/bXYHcrp+vhdaR5XvHlYd2aKDiuvGTo56zVW3
         VxKKdJPuzeFuSicq6GTpXKXkVC4xdZLz6sHuyIOLkklAiS3XxFTJ0x6dX15zMoIIUdsx
         Nc4nuRZ8w71o/o2tfmVfCFBogsqzsiRQV/fTdlzWpADmZPGgRH4lvS12Lt9YfSlZcK3L
         zQXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773986414; x=1774591214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AnVHiBXZex/xrLVAMzeCF2kXP3o0tCzeT0IjBMeI3M=;
        b=gYS4ejnaQ0M/5yCpw4phkKEAKekO0s0XWGDgtb1yArfG6+hgX82qvuyjO3RwFtOVZi
         lESFou6RN8t5Yd6xySTWUjTgi52nNtTqlswT4DJREjJIKzUYynyuktNd3yHoEyaI33if
         Sx+0bx5Z53ARfdCvTfy5z1mOeYpuDaWJCtme/c2NC9m3n97BB0DUHjNdZrdcEPKda45H
         XnzHRWuLXUpRIYb1Ajd+1sixau5uXtoosw/Jz/HGeg1WK5M9wm4P76+gL4OAXfDedYHY
         sl8aCCbrVWhvaA3hPZXp5brnkH2AAACILXDrivJWBy0TShRK/JnayiTuIY1oEZ/I7AEG
         5zxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773986414; x=1774591214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AnVHiBXZex/xrLVAMzeCF2kXP3o0tCzeT0IjBMeI3M=;
        b=dorjlbI+v3DFnsZdA4vGp59XcmprV6bmdg/U6ZHdr71LOygGxwkBeppLDnkSAfk8zS
         BgzExeou2QVN8TFidMrbnwCpjaYUb5jgUng/eI9QzwN7du+YBQb3TVuuSUGyeJKUR08B
         r0Ka1kQyP8zPJDQzLfkW31ACHuwUaAuFqZybMITIlo/xHYeYuyUs88Vfp1TBZDq7n7+Y
         Djd2nQSKHixsleYCKLbOUnrF/H7ioWzmrZJDUWa9BHhou6X/B5kR+T0NdKGtyMZ8/G4A
         BVBMNks0V5LfkNl38V/Od0n7Ez7xR2HnWq6/fNwPLP4npO5it7A/Pez8vy+9W6z+YfQU
         k5lA==
X-Gm-Message-State: AOJu0Yzm4o7iOMWqrX77NoEdKN7GQPEDUwB8M1PscJq2fwXhDpvUqej2
	PzhlEJIzKnXiR6ASiiV65JOhjtixBtGFH79skHDDyeIWFqprN0X31bnNAg6mnrj2LKa4F0QWArc
	QhkszF0NGEAMF2LOZ05ICAfhAjABaAustaGEIFrz0
X-Gm-Gg: ATEYQzxEinhyCsJsCF6cKwj4nwZ9BUh8ZjyRjE4ji38OSOg4z2mFT7NWRpeaBiBYbUh
	31M34qxQjhhISg7GJoVxzOCXAlUvABtbrAgFx86KoOZHpXFlQStJS8fx6kkPags1vdRGx1CmEvW
	WyMsU25rV44kRCRG5OIcVDJXNdfbJhY+vMT6VAcaOA7JYpc3chFbf+kEBQQIYsy83mpr/7Ap1t3
	2CFZBzwOYRKBfUKpe6/o+tmCQ3nw5uCV6oTJ9tl8yk63mKEkcOPjwuNUeU0N35Zn6CLt2vkVIKu
	GAKZc7A9RIorftVOKLnHL18Gm0T2tiBSDVJIdj7Ascffl2vPVw==
X-Received: by 2002:a05:622a:5c87:b0:4e8:aa24:80ec with SMTP id
 d75a77b69052e-50b3737a259mr9929901cf.14.1773986413752; Thu, 19 Mar 2026
 23:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319234531.3022634-1-kuba@kernel.org>
In-Reply-To: <20260319234531.3022634-1-kuba@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 19 Mar 2026 23:00:01 -0700
X-Gm-Features: AaiRm52lbfeoU9mjP6ESSPBEuFpRfOFcTEV2rgm_CDvZ4gM8LWz8VbS2CfUboCI
Message-ID: <CANP3RGd0BpEicWGxuktjhMDy8qEaE=HwBbS=Lx42PpXcbPYCkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] net: clear the dst when performing encap / decap
To: Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, willemdebruijn.kernel@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yup, makes sense.

Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>

On Thu, Mar 19, 2026 at 4:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Commit ba9db6f907ac ("net: clear the dst when changing skb protocol")
> added dst clearing when a BPF program changes the skb protocol
> (e.g. IPv4 to IPv6). Since that was a fix we only cleared the dst when
> the L3 protocol actually changes to keep it minimal. As suggested during
> the discussion (see Link) encap or decap operation which wraps or unwraps
> a same-protocol header may also render the existing dst incorrect - even
> if that doesn't result in a crash, just the wrong route for the now-outer=
most
> IP dst.
>
> Make dropping dst unconditional for bpf_skb_change_proto() and all
> L3 encap / decap ops.
>
> Link: https://lore.kernel.org/CANP3RGfRaYwve_xgxH6Tp2zenzKn2-DjZ9tg023WVz=
fdJF3p_w@mail.gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: maze@google.com
> CC: willemdebruijn.kernel@gmail.com
>
> CC: ast@kernel.org
> CC: daniel@iogearbox.net
> CC: andrii@kernel.org
> CC: martin.lau@linux.dev
> CC: eddyz87@gmail.com
> CC: song@kernel.org
> CC: yonghong.song@linux.dev
> CC: john.fastabend@gmail.com
> CC: kpsingh@kernel.org
> CC: sdf@fomichev.me
> CC: haoluo@google.com
> CC: jolsa@kernel.org
> CC: bpf@vger.kernel.org
> ---
>  net/core/filter.c | 50 +++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2f023999f046..0f8c508c5f8b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3257,13 +3257,6 @@ static const struct bpf_func_proto bpf_skb_vlan_po=
p_proto =3D {
>         .arg1_type      =3D ARG_PTR_TO_CTX,
>  };
>
> -static void bpf_skb_change_protocol(struct sk_buff *skb, u16 proto)
> -{
> -       skb->protocol =3D htons(proto);
> -       if (skb_valid_dst(skb))
> -               skb_dst_drop(skb);
> -}
> -
>  static int bpf_skb_generic_push(struct sk_buff *skb, u32 off, u32 len)
>  {
>         /* Caller already did skb_cow() with meta_len+len as headroom,
> @@ -3362,7 +3355,7 @@ static int bpf_skb_proto_4_to_6(struct sk_buff *skb=
)
>                 shinfo->gso_type |=3D  SKB_GSO_DODGY;
>         }
>
> -       bpf_skb_change_protocol(skb, ETH_P_IPV6);
> +       skb->protocol =3D htons(ETH_P_IPV6);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3393,7 +3386,7 @@ static int bpf_skb_proto_6_to_4(struct sk_buff *skb=
)
>                 shinfo->gso_type |=3D  SKB_GSO_DODGY;
>         }
>
> -       bpf_skb_change_protocol(skb, ETH_P_IP);
> +       skb->protocol =3D htons(ETH_P_IP);
>         skb_clear_hash(skb);
>
>         return 0;
> @@ -3440,8 +3433,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *,=
 skb, __be16, proto,
>          * need to be verified first.
>          */
>         ret =3D bpf_skb_proto_xlat(skb, proto);
> +       if (ret)
> +               return ret;
> +
>         bpf_compute_data_pointers(skb);
> -       return ret;
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +
> +       return 0;
>  }
>
>  static const struct bpf_func_proto bpf_skb_change_proto_proto =3D {
> @@ -3583,12 +3582,13 @@ static int bpf_skb_net_grow(struct sk_buff *skb, =
u32 off, u32 len_diff,
>                 }
>
>                 /* Match skb->protocol to new outer l3 protocol */
> -               if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> -                   flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> -                       bpf_skb_change_protocol(skb, ETH_P_IPV6);
> -               else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> -                        flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> -                       bpf_skb_change_protocol(skb, ETH_P_IP);
> +               if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV6)
> +                       skb->protocol =3D htons(ETH_P_IPV6);
> +               else if (flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
> +                       skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
>         }
>
>         if (skb_is_gso(skb)) {
> @@ -3616,6 +3616,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u3=
2 off, u32 len_diff,
>  static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff=
,
>                               u64 flags)
>  {
> +       bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
>         int ret;
>
>         if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> @@ -3638,13 +3639,16 @@ static int bpf_skb_net_shrink(struct sk_buff *skb=
, u32 off, u32 len_diff,
>         if (unlikely(ret < 0))
>                 return ret;
>
> -       /* Match skb->protocol to new outer l3 protocol */
> -       if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> -           flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> -               bpf_skb_change_protocol(skb, ETH_P_IPV6);
> -       else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> -                flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> -               bpf_skb_change_protocol(skb, ETH_P_IP);
> +       if (decap) {
> +               /* Match skb->protocol to new outer l3 protocol */
> +               if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> +                       skb->protocol =3D htons(ETH_P_IPV6);
> +               else if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> +                       skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
> +       }
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> --
> 2.53.0
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
