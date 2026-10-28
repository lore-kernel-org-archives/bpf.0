Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793188416;
	b=f8pAruqRTUd1RYSimoDJL4zHhqV2pNZWwQGpDiTGji7ZiK60u3GBETyn4Eg6x5/AKibK
	 Xo1c8p72MYaDHRJCwJB+pyTmetmeDIOpB+X/5ArXnmJml8S7a1VAXXfbw9sDQkiTjvuBO
	 +00y1qZf9ZX8uF3B2XmxsvznwgvaAL/RGQq63V2Hx5VBkhLnGmap0O8vqLnDgGsvyqm1v
	 FUOzcF+WwQLT533dIn74wb1GpeNrRmq+CREU8mKDz92WpYyIN/8GVguinTu03H16K50gR
	 hxQoME7Ql3WOGiulPl76ym8ycfFV6UzlnE3s9yXgm8SSvRNuo7GrRrIcEq5onFndtdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
	b=yrRNq53mvuREW8O1BjqFDUOxUbCtmDM8xmhxv75Cq4oP4KvBaTDTMA6vlcQaq1ckaj4h
	 2SNkiYViXRdkRHnq6TgEgkx3ZXv33qttIlxA9PHzUePq5D6MZdgdNqFM1HeUZZAeqMNxv
	 rLDsROlYYiV2NVjgKb16XFtCfsW6z1hn7+Fz9+kDErYrI7aN8hMsq+ZsfUDTtbWZh1r7P
	 KKucy5lq24tzXqzevhrWVg5fC1IADHUVx7QAobgjO3MgHj3QcnRTndZRUD/FblenIqj6k
	 fMAww7hF4tBiSOPNiPIitqpc6UO38mtZ/J7eaPY6Yv2k5EALtqcfXY9NHwVVz+qzrxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F6606A31A
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 11:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938F6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=WUVYd0kE
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd67cc518a6so639868a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 04:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793188415; cv=none;
        d=google.com; s=arc-20260327;
        b=YL+dr6msFXGvmHZonYeaF99yewgnONVc8kL66a8Y0y33PbWQ06BEbgWPWhe5bHNvUV
         epfuqHGn8MgonGza1ytGe/ZAY0ncF47Uj8p9JEd4JsgK2ueUooMBACq5YS6UxNVqxWFO
         bGP9aU/kwWPnxQQ9lR5mACu6Ei8IYWe/S0aiacnK0w/CMw09zBdRheh+lv+7T26eNFMs
         W7I9fbsool+uMXC37DC//lxhWpx5FH1AN5GnNPRsSMmEoYgUpGXg9Wqr3fgPoov8tQvL
         lOYO/U980grQ+8OGYnQsnyw76hN8Wn99ukgbyEUGjXiOV9/NSmmZuONJvrN5z/wnX77k
         h9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        fh=6337Dchl1kUdUc3WeCVB8ia1RHqhEYPyMGxDvCJVBDA=;
        b=lNqNp5p83funpfhjfnfXBbR6o1OYEGL9EHYGRjSRSWoC6P5VVFenpbYGEjnVEOTFpL
         vKzEMFvsVVn0Kzw3TwKf1b8RbFEgpLsDFx7dC62/loLdMoSQzCpKdChFBXAnZD6DgF/D
         pt+LWiD+iFTxt+vomXlcFjsrfllAXLGqVw2NHaepiP4etwHFqafKgoTMcbrU4Fo5XyS4
         9Pjek6q0kOd16vojcVcEh/vlz6eo9x9+t2aHoPWkp2OaxqNWxpyw7ZhB2crqFUM2Ziir
         7iD4v9kj+4kCFVRhoaikTpGSTwxtbm9xxYexKLW80QJpJlFttf006ymEcdzgp2udxL56
         jcrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793188415; x=1793793215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=WUVYd0kEFrDYGXYAbPFdn+FZT0g4tovRk5OV3qLEhnQMP4yhV6yXzlJfn7ZIM0in39
         uFhhYE+n4MK5SPak2DLasq4/ZRPvpv7tIBqUr1zxvixb9Lx8AisSUHghr/Uh3kVeYoDS
         1fygngZNYVuxVlLs+c5VEO2d3PfmV/8Ftw/Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188415; x=1793793215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NeMzGjC6FSwyX6NJNXU/7HdHnQEV+lVSBzUzj/MsZK0=;
        b=QUx9xiKmnNghp2gMWRVFQG0OH25GuB3anSfTglfGs59d+YqUlrFe5qWwybZRyxjTW9
         pu0athscNCJ9dXJYO6Hzqbn3XWXkNEk8tawBp+/0PFmW93yoBiUGQsen2MrYu4rskpAx
         gj4IROo0g04QNFgtK5xJ+LNyffbPYDQoTVM+ap6w30n4iVw1fPsFsxHVDUq7TfNFj+B7
         Sdqi0E0VsflOjOiYTyzAylvhGwvhZhtQ+3DnPzxLc50qaWUbpIz/1IJyB0wp0LTi3RjF
         Z0SquWzN7EjfyOUC7IzYacEi7m6At5qBZeeR6DR76Sl5M20jfqKGNDQNGfBMsmRY+knq
         5K9w==
X-Forwarded-Encrypted: i=1; AKwUvBz0K0qyyJIlOGU9M2sB8rudWyiI66cdkr6hqYOJlqYnPpQfzWhZfTKAh2hazmUduDN8or4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9rCMZ1wKGzthq67b5zU9sKHs5ygOUh26NSy8YsJTN8S7str2Z
	RQaYrq0NsIyNGGD0r8EYNLxvYr14K2Egwi1LmscdhKZCXEsOB91LwCz/dDRwYMLwvts12oc41ek
	hO7rRcfyhuWsIP1rDYRBU3OXeQW9deVo+Mx+PFBlV
X-Gm-Gg: AYBFou3YCwVXu23TrwOgD/cGOFEVrs5QuVQJJ7kNjVYSPeBhlCBkUuiSF9tsK72P8H/
	ZaNzmTb0sLTrDwStW/CfhNYwn6O36+1jmdIkAGkrpQkmB1ALgKUk0eQG6RuUDf/FvbPFgNLQpo+
	Zeglym+z7vOMt+NgiTvg7svFCsrZ2HJx4vzMi0ECLvI+wzQYkiKg5Kg3IG/vDbda5GMllJA9hhM
	fqXaCQujnIxENR18e0lKr3hYiSrQUy7+4wYkMU+x3rvCweNlC+JJm3FpAbqLfdjUseSVQRj5VER
	Syp6xy1MbVJ7WpiMY6c2fLXOmQKReJ2SoYlrDcsyuKHBqzS5xTxUzBO2ko39Iysy44aMknLLdBR
	WuWRj0Fi1QezRsjEcVjbKZTsa3VrUlOAPmk8R2QWkArbqngcSHZPdeNOzrzYpfodV2LZsqxKEj5
	ymG/XTI/h9dowEPaY=
X-Received: by 2002:a05:6a21:39a:b0:3e2:8f64:e4ff with SMTP id
 adf61e73a8af0-3e9023c11b2mr1864941637.31.1793188414925; Wed, 28 Oct 2026
 04:53:34 -0700 (PDT)
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
 <2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org>
 <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
In-Reply-To: <CAL4WiioEQsckFKbLz8mnZdK9vG93qEj40Ft8fEfqaNDHyB7DTg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 28 Oct 2026 07:53:22 -0400
X-Gm-Features: AclHuK-GhnK-qd0xLjJB1wtnuCO2c4dWn9lENZM0luOK9ZkwfIjPDiJ_LxTY9Ho
Message-ID: <CAM0EoM=ETuLerW3nd85zuEjwqydrd_9E4r0TbDekYyUZnEBSpw@mail.gmail.com>
Subject: Re: [PATCH net] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Eric Dumazet <edumazet@kernel.org>
Cc: bot+bpf-ci@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	dsahern@gmail.com, kafai@fb.com, martin.lau@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, victor@mojatatu.com, martin.lau@kernel.org, 
	mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:40=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mer. 28 oct. 2026 =C3=A0 11:19, <bot+bpf-ci@kernel.org> a =C3=A9crit :
> >
> > > bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
> >
> > TL;DR: The new skb->mac_len < ETH_HLEN check in __bpf_redirect_neigh() =
may
> > wrongly drop valid packets on tc egress and netkit, where mac_len is of=
ten 0;
> > a regression that would reach stable.
> >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index b7ac145b68b1..95a8a728a71d 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> >
> > [ ... ]
> >
> > > @@ -2451,10 +2451,14 @@ static int __bpf_redirect_neigh_v4(struct sk_=
buff *skb, struct net_device *dev,
> > >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_devi=
ce *dev,
> > >                               struct bpf_nh_params *nh)
> > >  {
> > > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > > +     struct ethhdr *ethh;
> > >
> > >       if (unlikely(skb->mac_header >=3D skb->network_header))
> > >               goto out;
> > > +     if (unlikely(skb->mac_len < ETH_HLEN ||
> > > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > > +             goto out;
> >
> > Does the new skb->mac_len < ETH_HLEN test drop valid packets on tc egre=
ss
> > and netkit?
> >
>
>
> The bot is right, sorry Jamal, I missed this when looking at your
> first version.
>

agreed - i will send a v2. I will also test egress/netkit path.
That was fast! (in 7 days on the sashiko nipa i dont remember the
context given the number of fixes)

cheers,
jamal

> skb->mac_len is only set on the receive path. On tc egress (and netkit),
> it is usually 0 for locally generated packets, so this would drop all
> bpf_redirect_neigh() traffic from egress programs.
>
> In both cases skb->data is at the MAC header when __bpf_redirect_neigh()
> runs (sch_handle_ingress() pushes skb->mac_len before skb_do_redirect()),
> so you can use skb_network_offset() instead:
>
> if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
>      !pskb_may_pull(skb, ETH_HLEN)))
>         goto out;
>
> This still rejects the 1-byte header from bpf_skb_change_head(skb, 1, 0),
> and also covers the existing mac_header >=3D network_header test.
>
>
> > skb->mac_len is only set on the receive path, where
> > __netif_receive_skb_core() calls skb_reset_mac_len().  The transmit pat=
h
> > only calls skb_reset_mac_header() in __dev_queue_xmit(), and nothing in
> > ip_finish_output2(), neigh_output(), eth_header(), sch_handle_egress(),
> > tcx_run(), cls_bpf_classify() (egress branch), netkit_xmit() or
> > netkit_prep_forward() writes mac_len.
> >
> > A packet built by a local socket starts with mac_len =3D=3D 0, because
> > skbuff_clear() zeroes everything before 'tail', and skb_clone() (used b=
y TCP
> > transmit) copies that 0.
> >
> > For example, with tc egress and a locally generated IPv4/IPv6 packet:
> >
> > ip_finish_output2()
> >   neigh_output()
> >     dev_queue_xmit()
> >       __dev_queue_xmit()          <- skb_reset_mac_header() only
> >         sch_handle_egress()
> >           tc_run() / tcx_run()
> >             prog returns bpf_redirect_neigh() =3D TC_ACT_REDIRECT
> >               skb_do_redirect()
> >                 __bpf_redirect_neigh()
> >
> > Here mac_header < network_header passes, because an Ethernet header was
> > pushed, but mac_len =3D=3D 0 < ETH_HLEN, so the skb goes to 'out', gets
> > kfree_skb() and -ENOTSUPP is returned.
> >
> > The same happens with netkit:
> >
> > netkit_xmit()
> >   netkit_run()
> >     NETKIT_REDIRECT
> >       skb_do_redirect()
> >         __bpf_redirect_neigh()
> >
> > with mac_len still 0.  Netkit programs are BPF_PROG_TYPE_SCHED_CLS, and
> > tc_cls_act_func_proto() allows BPF_FUNC_redirect_neigh.  Forwarded traf=
fic
> > that arrived on a layer 3 device (mac_len 0 on receive) and leaves thro=
ugh
> > an Ethernet device's tc egress would be dropped as well.
> >
> > Before this patch these paths worked, since the Ethernet header is line=
ar
> > (dev_hard_header() pushes it into the head) and skb_pull(skb, ETH_HLEN)=
 was
> > fine.  bpf_out_neigh_v4/v6() calling sock_confirm_neigh(skb, neigh) als=
o
> > suggests the helper is meant to handle locally generated skbs.
> >
> > Elsewhere the kernel already treats mac_len as unreliable at egress.
> > act_mirred uses:
> >
> >     mac_len =3D at_ingress ? skb->mac_len : skb_network_offset(skb);
> >
> > and act_mpls uses skb_network_offset(skb) when not at ingress.
> >
> > The bpf_redirect_neigh selftests (test_tc_neigh, test_tc_neigh_fib,
> > test_tc_dtime) all attach at tc ingress, where mac_len is valid, so the=
y
> > would not catch this.
> >
> > Would testing the real MAC header length work instead, for example
> > skb_mac_header_len(skb) < ETH_HLEN (network_header - mac_header), or
> > skb_network_offset(skb) < ETH_HLEN with skb->data at the MAC header her=
e?
> >
> > That would still reject the 1-byte header from the commit message (pop_=
eth
> > followed by bpf_skb_change_head(skb, 1, 0)) without dropping egress and
> > netkit traffic.  Since the patch carries Cc: stable, this regression wo=
uld
> > also reach stable kernels.
> >
> >
> > ---
> > AI reviewed your patch. Please fix the bug or email reply why it's not =
a bug.
> > See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/REA=
DME.md
> >
> > CI run summary: https://github.com/kernel-patches/bpf/actions/runs/4066=
6397744
