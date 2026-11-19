Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120157;
	b=DbSH1GzzDPM5zIEnrgGoQXPbh7XdcG6N75KE/Fworg6zuu/K7F4t2aYOJSK9rV+Dw4cG
	 r6eIdEKt9kpsTSDUI5Vrq5yxD9PT1ZxYcZfeqUD0MDx65Tbp4cJT0+dopblagJ0HhnBV5
	 aCHGeKhzssLFOZUVKV5j3co811C2tdkYh/1SqdzhuSAGhgEK+/o1EtoPYZhAJBWAYxCtd
	 vsnkXE2zJQuGyzugR+UrN0tzq16VxTeBGXpQ+eANEn9mPp3eJmVU9rMJZQLFG/hWMVK72
	 14bfrROXvr3FcUSEJEHI0P55rGx9PEr5e+/A81WrLTs9zHQv/uq98E9lxBlx1mpCVxw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=VaNqnaKYVBxAY+39/+snBNP55py7Um9F6TtNyKeIsEE=;
	b=O4TcR4F2gAh/nu33u6aE7gvSkktz+zCS+XAN/N+oRMzFcU2kdunUbaxpAx2a7IlRTwoG
	 G3Hk4hle6sv1mDuzKTz3hWj0hlHZUELtZ5i8c35sCNS2C2v/3sPxWjwVYRwKqkwfCxdGf
	 aUsYwUcfxrQFMuOD21JFFnlXNnqPjxEWcxjzzKRzjhc49UqHdDb3Tbtwex5dMkhgARAgx
	 SIn93HsmqHZZ1dqdZq5yMCpbUwQgyhIiOqWfYBcv+ArxjSytGRMgk++dlyn0WEFKmPiJb
	 T7yy29gspXlIHvzV0sxoFKvkIBBavVxjAOrEHtQs66C215Dz2ILPP0hSxpZ9ix29sKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jSZ+6KQD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EA606A32C
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 20:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 694EA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jSZ+6KQD
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so143416b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 12:29:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795120157; cv=none;
        d=google.com; s=arc-20260327;
        b=WHPREfHZ0Mwxu+V29qtNWoSlsCJbBdgx1xQWzzq4e1L4kg7gHC9VcloXBvJrC6hJEm
         Kgz9feKoOEQ4JaKKigCQuE7iFbzOOpRqwbH6O7HmBpuwxhqED6DZPgv1+N7HvX5gRVdZ
         3shvlr4UFO3Aj19c5HVhkhhNN67EOHQ7K3pBjdA2in4cuxgLKpF83EFvQFDbHU5iTnQT
         11hauLv+oGhd0RhXAYyqt+3ahjGva31pJNl/zzWzvjAwiO2calbG8eo0PBG9NaGhAnkJ
         kHAtnnHjvxLeSoTI8Whit9Kv++gEgiPdLbs+CHwoAoLW1M/lga9IKEIyMmRFKWtHrxHy
         zewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VaNqnaKYVBxAY+39/+snBNP55py7Um9F6TtNyKeIsEE=;
        fh=FDhbklRvvk6/Mtp1dswtuvnp+GWtJ+WfWDUWGtWcEhk=;
        b=dz0UddYFS8/Lmnvx7eK8UX2AnlM+lVexTBPQ74f4CTbN9+QuVyuU3ldm1ntH5Z6W8V
         fSh9CkR3+N6yL7Sk+oLQ5jjPEBr43YPSXDpN3gaZdihgqXYAoTOAH9uMVKBI1d04g1nl
         HspnVA9gp1kVPvdbZzHVvQtDPARAE86mTdTT2YHqhBYa5kZm86mV+LZiLhf6zz0dUbPw
         n/Cqnn4SKc2YEaPRPxU+xG5x6ZePLQL2747nBRGel7V6/IhCC0N9jOF47NYOPS5ga6Hc
         9pdIh8LnIn1/6MKm+RDEKXE4vJg84aPTZztphoJNgAbhLQRtnkZ3aRrKCgpnJB0ttJIT
         Ki2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795120157; x=1795724957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VaNqnaKYVBxAY+39/+snBNP55py7Um9F6TtNyKeIsEE=;
        b=jSZ+6KQD5xKgjGX6InXuwUCnleGA0oi9Jieh50NwikLivOEkIX777npmeFW57bo4/e
         ALl4nQc5WIJBkTNiDl2+5pAruZh/bwcLjbwffuagsD+i4AfalNbqpdIdZ1AvbbefYbc3
         EMxWNuyO3bwQE2oBcvRnm8mAfKEgS3S+gf/70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795120157; x=1795724957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaNqnaKYVBxAY+39/+snBNP55py7Um9F6TtNyKeIsEE=;
        b=HTy0UYphi/psso57f8EfaepGseJJtRL+kNI1434srGO8/pebtADNOSQ6iqF5tCZchf
         +MjyQO6ygyX6l+VA+VBtBwB3qXNR5u0mdcLXYGs6hDVWd4hm1zDfCVM1wFR9x/KAGEfV
         GEOHmwFaE3EhN0eZ7c92tM4UEwW8K+EJMv5fgOVngYaI27ngxSDx3FEGVv9nsssDK15d
         +1GJtrmGA3Hj1N+SKTxRWW+nBNPJVrdfkrT1Crpo3hGHyMsb4MfG/oxGm9/kizxz+a75
         429p+bypWvOv8tRzrxAVb5/esQxnM6NTCaNq2hH1Pq0pO/3p98/G19PEHO2seHgCfMmm
         q6bQ==
X-Forwarded-Encrypted: i=1; AL+hErEiR0CvOxeG2X3JH9GnDWEDp9dnGJaNatvf5AkOmiREHNVdaHEDclSF8Y+SrOxgeFWCYjw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8KAFdwJL0ts4fCvu9eZS9e7srHZzID6ITONkRSrJRlhkfvNrHM
	zjK2T04f0dskgEgdzjXVF+UPZFXmO0zUsTatn8CPgGJfnfQ8NeLj9/MoKlXvOB/yweF16/2a2Of
	vI5AAyuKJiOixAdC3o1qaUhdGogAKo1j/osnYYjI9
X-Gm-Gg: AYBFou1pjhLZYgh35n5GMq2fxK+wrhmYATRVXcPedrP3Gr4cI4JZjan3tLDxaXrzHIS
	i45SdqvvHORSPY0uvpL2XnNAosKXmfdqIqa49grlJSwvrnSBDupX/m9kXNDC9dxPn7oQbx29NOh
	DU0c3MkuRkUwk4bax0WE9wvUNQFxcd2f9idVQjnJ7GgeUUYjd+Ze5jiTn7KlOsHZaP1ED6KgdcZ
	NCnY8YZwfpyewJl7L5Z835QyHXDuLW7mPYeJnL5KbXWGyrMEMXNT3WzSRCwyJRd66M+b0Ns9KBv
	jdFGvYPuz2yJaZnQrAKVmaia+xzPHp/MYz0F5eXyOs5tj94fBogTSQ0ftbjN39hupqWM7weITX/
	+FpJCKzaUvI/AWWdT0iNR8SWph+4DZXJ1iE1fUf1GPvFgf2eDiMCusJ+2l2H4uFXDN9hlWjtq/e
	Te6M5Z5MEAsty78S76
X-Received: by 2002:a05:6a00:b42:b0:8b6:12fd:7271 with SMTP id
 d2e1a72fcca58-8c87c38846bmr710703b3a.25.1795120156313; Thu, 19 Nov 2026
 12:29:16 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-9NOG.v4.r0.20261116135311-4@mojatatu.com> <179511856597.3136.7846835490904436138@kernel.org>
In-Reply-To: <179511856597.3136.7846835490904436138@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 19 Nov 2026 15:29:05 -0500
X-Gm-Features: AclHuK8yAi4mDoEg2Fjwj9CTASd_XfeaP5nznF0v3utPb3bDCPcw5_zH_LgmqFM
Message-ID: <CAM0EoMkppFKECwmjw+E3tWpXEL3=cyg2VYhgpL+StaSiQf+WAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 4/4] bpf: drop the stale dst when redirecting
 to an explicit nexthop
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, bpf@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 3:02=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In the explicit-nexthop branch of __bpf_redirect_neigh_v4(),
>   the new skb_dst_drop_keep_metadata() call can replace a real struct=E2=
=80=A6
> - [Low] The patch fixes a long-standing, user-visible bug but has no
>   Fixes: tag and no Cc: stable.
>

This is still under discussion with Alexei  - so:

pw-bot: cr

I will consider this feedback if we have to resend the whole series or
per Alexei's pov 1 or 2.

cheers,
jamal

> --
>
> bpf: drop the stale dst when redirecting to an explicit nexthop
>
> This patch changes __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6(=
)
> so they release the arrival dst through skb_dst_drop_keep_metadata() when
> the BPF program supplies an explicit nexthop. Without it, a packet parked
> on the target device's incomplete neighbour can later leave with the
> original device's link-layer header. Encapsulation parameters carried by
> the route are moved onto a metadata dst.
>
> Link: https://lore.kernel.org/netdev/QDISC-6HS9.v3.r0.20261103062649-2@mo=
jatatu.com/
> Link: https://lore.kernel.org/netdev/avTfQjFQYR2NNdRg@chamomile/
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bd98d29ed7f8f..ae5346d6abd23 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2318,6 +2318,8 @@ static int __bpf_redirect_neigh_v6(struct sk_buff=
 *skb, struct net_device *dev,
> >               skb_dst_set(skb, dst);
> >       } else if (nh->nh_family !=3D AF_INET6) {
> >               goto out_drop;
> > +     } else if (!skb_dst_drop_keep_metadata(skb)) {
> > +             goto out_drop;
> >       }
> >
> >       err =3D bpf_out_neigh_v6(net, skb, dev, nh);
>
> [Severity: Low]
> Should this patch carry a Fixes: tag, and maybe Cc: stable?
>
> The nh !=3D NULL branch in __bpf_redirect_neigh_v4() and
> __bpf_redirect_neigh_v6() skips the FIB lookup and keeps the incoming
> dst. That branch appears to come from commit ba452c9e996d ("bpf: Fix
> bpf_redirect_neigh helper api to support supplying nexthop"). Before that
> commit, bpf_redirect_neigh() always did a FIB lookup on the target device
> and installed the resulting route.
>
> The commit message gives a reproducer that puts wrong addresses on the
> wire. Would a tag like this one help stable trees that carry ba452c9e996d
> pick up the fix?
>
> Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support s=
upplying nexthop")
>
> > @@ -2433,6 +2435,8 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
> >
> >               skb_dst_drop(skb);
> >               skb_dst_set(skb, &rt->dst);
> > +     } else if (!skb_dst_drop_keep_metadata(skb)) {
> > +             goto out_drop;
> >       }
> >
> >       err =3D bpf_out_neigh_v4(net, skb, dev, nh);
>
> [Severity: Medium]
> Can this pass a metadata_dst to code that still casts the skb dst to a
> struct rtable?
>
> Suppose the arrival route has lwtstate of type LWTUNNEL_ENCAP_IP,
> LWTUNNEL_ENCAP_IP6 or LWTUNNEL_ENCAP_XFRM. Then
> skb_dst_drop_keep_metadata() replaces the rtable with a METADATA_IP_TUNNE=
L
> or METADATA_XFRM dst, and that dst uses dst_blackhole_ops:
>
> net/core/dst.c:skb_dst_drop_keep_metadata() {
>     ...
>                 md_dst =3D metadata_dst_alloc(src->options_len,
>                                             METADATA_IP_TUNNEL, GFP_ATOMI=
C);
>     ...
>         skb_dst_drop(skb);
>         if (md_dst)
>                 skb_dst_set(skb, &md_dst->dst);
>     ...
> }
>
> If the redirect target is a non-collect_md NBMA tunnel, its transmit path
> still calls skb_rtable() on that dst. For an IPv4 payload with raddr set
> to any:
>
> net/ipv6/ip6_tunnel.c:ip6_tnl_xmit() {
>     ...
>                 } else if (payload_protocol =3D=3D htons(ETH_P_IP)) {
>                         const struct rtable *rt =3D skb_rtable(skb);
>
>                         if (!rt)
>                                 goto tx_err_link_failure;
>
>                         if (rt->rt_gw_family =3D=3D AF_INET6)
>                                 memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(f=
l6->daddr));
>                 }
>     ...
> }
>
> ip_tunnel_xmit() falls back the same way when skb_tunnel_info() gives no
> usable AF_INET key dst. That covers METADATA_XFRM, an AF_INET6 key from
> LWTUNNEL_ENCAP_IP6 on an IPv4 route, and a key.u.ipv4.dst of zero:
>
> net/ipv4/ip_tunnel.c:ip_tunnel_xmit() {
>     ...
>                 } else if (payload_protocol =3D=3D htons(ETH_P_IP)) {
>                         rt =3D skb_rtable(skb);
>                         dst =3D rt_nexthop(rt, inner_iph->daddr);
>                 }
>     ...
> }
>
> On 64-bit, rt_gw_family and rt_gw4/rt_gw6 land on the tun_info.key
> address fields in the metadata_dst union. So rt_gw_family reads the first
> byte of key.u.ipv4.src, and rt_gw6 starts at key.u.ipv4.dst.
>
> Here is an example. An IPv4 route carries "encap ip ... src 10.x.x.x dst
> D", and a tc egress program redirects with a supplied nexthop to an NBMA
> ip4ip6 tunnel. Then rt_gw_family reads as 10, which is AF_INET6.
> ip6_tnl_xmit() copies 16 bytes starting at key.u.ipv4.dst into
> fl6->daddr, and the packet is encapsulated towards an outer IPv6 address
> made of tunnel key bytes.
>
> Before this patch the skb kept the real rtable on this path, so the cast
> read real route fields.
>
> The METADATA_XFRM layout does not seem to match AF_INET or AF_INET6.
> IPv6 payloads coming from __bpf_redirect_neigh_v6() look like they are
> dropped, because dst_blackhole_neigh_lookup() returns NULL. So this looks
> limited to IPv4 payloads in the IP/IP6 encap case.
>
> The commit message says:
>
>   The release here can leave one behind as well, when the parameters a
>   route carries are not usable for the payload. The cast is repaired
>   separately.
>
> ip_tunnel_xmit() and ip6_tnl_xmit() are unchanged at this commit. Should
> this patch go after the skb_rtable() fix, or include it? Otherwise this
> path is exposed until that fix lands.
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/CORE-9NOG.v4.r0.20261116135311%40mojatatu.com
