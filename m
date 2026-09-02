Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F72397E85
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350180; cv=pass; b=tbmXMhKYmfObgD4ci6jyzBiL0/WUr4FN0Lq1nuey5RUjBcRJnnwtK1ACRNXp3jtYabnAuoKAbqocqvLl+3PUT25ahYa3Binuy9pQvVh81yasuufSLtzjnLbv6qZQaL7++0J+lZ2ItEXAwwqV4Ba+MBQMr39B3q5GIOaXKaLsleE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350180; c=relaxed/simple;
	bh=9aTnB/VsolXmMC6foR77V4yJLHZj5i7uyuB5JvSk0e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQM0g7pkL3o+KK5B8sf3CWGyq6v6+vvOo8L5DRfjUXLskdMyk6OiBL9iXs8opQfnWzPuLsDrz6eoViwTbcrC2ZJJI8LxJpSTOzsi7q76U5VKLjSf00v3OZl5FqDfd+er4WE1wTMPJxdLcM8NOUKJ5iqP57d4yg33KHQl2n138Q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjwR2HTV; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjwR2HTV"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b5f21afe8cso2804908e87.1
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 04:56:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788350163; cv=none;
        d=google.com; s=arc-20260327;
        b=OA9ozgWyIAJz5LyxSo6kXQ1P6fshxpGi6DLrGuZsXgl5haX0lnbUg3Xo+VOcvluJvi
         dnt+UqPIzUA3kCOEJlgv9KcgS0g9IvB+jL2gO8fFo2lxfOmzth2UtQ8tHbWwL07BVJoR
         neXVYUYEkHkzkhJ1XHh6f0zPTpZMjKsvQL7T7nJaIZzrNN0PMG7MeSGiJIcTuOvbIsCa
         Fe714R5yUXbCv6MVqpIU6civC5lYY/9cbIz2+xdNS8Cyhqw4up6XalLTkdyy0r+D6A9M
         I5dKpEoSzKy5fd7O8FIBnyBLS2EoqAnzkwRTj/w3WnJkF0euJbMpo3ZkZJJo9mR6x/3L
         +zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y22TOZ6sV36PcowpSzMqJvb3Bgbt/VKIj2SdBO0JWFE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=gQrThL0nvY3mxUqnvNA7e5rjqZX78dzdEuR3EKQcT8YI+dYay4Hdskt7dNAfIG6Qj0
         eEz3Pd1WY4188z8Qe+EGsWZnvuoWG6ZMxDh+rEHI2YCAZwD6sws3FotyJU+kZrAPgK/l
         ZVlfwakwY8X6ma39eXMrv3VXX6/NupTwuWW3nbRhhnjsijR40FujYveGfUOvZjDW2KJV
         8Ydml1n6aipTsaNZ9fFMNvu3cgGcq7WTEmGIQU3Rl1+ZWdzvNa4P1Q1gHLHBB34A+S7/
         5AJ1hFMT9mDb7GribtTlqbQ069XWzpVy+TWkE2bLjyJa72STnCNbZtAqg3iZkRUxN2hH
         m1LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788350163; x=1788954963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y22TOZ6sV36PcowpSzMqJvb3Bgbt/VKIj2SdBO0JWFE=;
        b=DjwR2HTVDzluvjZiAsLxJRzSlPpWKJ8EOHH53GdWK+BFeDkocxUakMrUpAXg5oeXPC
         CD74s6QvY1coli509CXCFLlarU/42LcwBYCudERq2oQ7XJfC89IrU5GA9A5Ght2dQNT2
         3LPIBgDXYgCHz7VSMFOwBTDTpPT+NKwQ/luy0LObllm0UuoVUiDbpsD0aQuSfpYLbOmF
         mUxZsFunZXyw/eZ6rDPHq1xe15LR6R5aa8+VeGJLEYDHtGrmkRyU5p2MeCsSNOVHPwen
         qyBvWGgKG3M9Pt2FZJK7I1v6AJcgTePopDCP2gZzDg8mc+P6OGKnqSJiR5t/yISKY6YG
         O0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788350163; x=1788954963;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y22TOZ6sV36PcowpSzMqJvb3Bgbt/VKIj2SdBO0JWFE=;
        b=no6vL6yzFkj/9/pVeIKnwiEQ2vvAzACzSM5CqqEtUx1rQydFEuwpsZgrLWFDaUaBQM
         iDvJCYOSUrEsyiMh/ubelmAzpM/zWB1Fn9XuSfeWKCfOS11Yed2uqGBeCFDsQ+ngUXOU
         fiolIgbYzB9YUpwJmmKEiiz6LBW33jU3cRG1blRlE2hbFQ5c6Ee9b0U3u2sFLYxuZTBf
         VtW2nIhe5k0HTO76FC2aKAcQZfgZqifdtpQi1h1yUn0ACmvpQHxaJsyrqFbiLd6KJVKF
         rbO/tg1zDx4hPKpwxUll3oy3Q9A0R7aVI0/NGvyrLbU56k98rRVf9thN8jzzZPZYwKwL
         ueZw==
X-Gm-Message-State: AFuF++n0ZUUZVlGbhXTk2QpVuYHR/q7b7eiZargdNOLtyOK6TKEBwg7q
	zITEpOq9F/amADImMYYqh70yAU7GKBxo5NuMDAlqS0GwfKKkAaKql118PR96aUv3y8U8npmaUvm
	OYS79QU2a89W5r4SX56WYXuduDu2R6s77JigSWBg=
X-Gm-Gg: AYBFou16GOO2WLCouQvF6pepZG8Dg9x1wRhzKXz4oePiYZBpNydmuOPrA0IAE2nlpwm
	ylS5fh/jCq5SY+ovN9Lf9m/NsyoyWCCoyRnkRCMtB4Vk5mW9iqBkh7SS/oxndvFIOK3brLTbJzJ
	4t8riBFi2eLn7N2RzicyFq3wVToFVRLynxb6VMfGHwbSjXT87oYkuUWco30NwN79uBfyskv0GNN
	NK8VF+qQbMIHB6IkzRicwPXFQ+lAzlErBErY27soTVJlSZpL5h3VHg0aplgp4lGqrnmH5pYOtoZ
	Api5StO2GWQLWZdl+d1Tvlj5jTjdeksyVFw35LyGhrkkSRV5IuHpEzKLWteU8NzoPoH3BUN/XjF
	OWz/gVTXZ29npJ0arUfZw1et22BqoSHLInJW1hQkd/+fsmTlH9BkeJgrhkA==
X-Received: by 2002:a05:6512:130c:b0:5b6:421:8adb with SMTP id
 2adb3069b0e04-5b60c31a2bdmr833645e87.16.1788350162785; Wed, 02 Sep 2026
 04:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901083325.3445-1-kerneljasonxing@gmail.com> <20260902083344.1D9311F00A3A@smtp.kernel.org>
In-Reply-To: <20260902083344.1D9311F00A3A@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 2 Sep 2026 19:55:25 +0800
X-Gm-Features: AcwNN1UKyixZhZk_9axNe7uo1mtPY0hJ2kYRqzyzHcRHmsAWEFEpNH_CSNhZsJQ
Message-ID: <CAL+tcoBBqzUo5cKS1MSUSvYd9P3obf210tKZNdUEhz538KPYhA@mail.gmail.com>
Subject: Re: [PATCH net v2] xsk: set network header on skb at generic transmit
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [Medium] The patch incorrectly anchors the network header at the L2 bou=
ndary (MAC header), which violates standard SKB semantics and contradicts t=
he AF_PACKET convention it claims to follow.
>
> Pre-existing issues:
> - [High] Missing initialization of `skb->mac_header` in the AF_XDP generi=
c transmit path leaves it at `~0U` (0xFFFF), causing out-of-bounds memory a=
ccesses in network drivers that unconditionally read the MAC header.
> --
>
> commit 8222314e7d9b572394dd3fc2b9acb0b3706abd3e
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: set network header on skb at generic transmit
>
> This commit fixes an issue in the XSK generic transmit path where the net=
work
> header was left uninitialized. It adds a call to skb_reset_network_header=
(skb)
> in xsk_skb_init_misc() to ensure the network header is correctly anchored=
 to
> the start of the frame. This prevents a crash when the skb is handled by
> tunnel drivers.
>
> Closes: https://syzkaller.appspot.com/bug?extid=3Df16c1b285c9f63994eec
> Link: https://lore.kernel.org/all/20260826012052.51028-1-kerneljasonxing@=
gmail.com/
>
> >     Reset the network header so skb_network_offset() is valid (0). Note=
 this
> >     anchors it at the start of the frame (L2 for an ethernet device), w=
hich
> >     is the same convention AF_PACKET uses on TX.
>
> [Severity: Medium]
> Does anchoring the network header at the L2 boundary (MAC header) here
> violate SKB semantics and contradict the AF_PACKET convention?
>
> In AF_PACKET's packet_snd(), skb_reset_network_header(skb) is explicitly
> called before skb_reserve(skb, -reserve) prepends the L2 header, correctl=
y
> anchoring the network header at the L3 boundary (after hard_header_len by=
tes).

I will remove this in V3. I misunderstood the boundary in AF_PACKET logic.

>
> By anchoring the network header directly at skb->data (the L2 header) in
> xsk_skb_init_misc(), won't any subsystem, offload logic, or tunneling dri=
ver
> that relies on skb_network_header(skb) erroneously parse the Ethernet hea=
der
> as an IP header?

No, at least until now. That's why resetting is sufficient.

>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 33475b180ea6f..2077bb6299ca9 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -947,6 +947,8 @@ static int xsk_skb_init_misc(struct sk_buff *skb, s=
truct xdp_sock *xs,
> >  {
> >       int err;
> >
> > +     skb_reset_network_header(skb);
> > +
>
> [Severity: High]
> This isn't a bug introduced by this patch, but is it also necessary to ca=
ll
> skb_reset_mac_header(skb) here?

I think it should be merged as a fix:
https://lore.kernel.org/all/20260817153957.3177627-1-poros@redhat.com/

Thanks,
Jason

>
> The AF_XDP generic TX path allocates packets via __alloc_skb(), which lea=
ves
> mac_header uninitialized at ~0U (0xFFFF). Because AF_XDP generic TX bypas=
ses
> standard egress paths (like __dev_queue_xmit()) that would normally set t=
he
> MAC header, the SKB is handed to __dev_direct_xmit() with an invalid
> mac_header.
>
> When physical NIC drivers unconditionally read eth->h_proto via
> skb_mac_header(skb) during transmit, this evaluates to skb->head + 0xFFFF=
.
>
> For example, in drivers/net/ethernet/intel/ice/ice_txrx.c:ice_xmit_frame_=
ring():
>
>         eth =3D (struct ethhdr *)skb_mac_header(skb);
>
>         if ((ice_is_switchdev_running(vsi->back) ||
>              ice_lag_is_switchdev_running(vsi->back)) &&
>             vsi->type !=3D ICE_VSI_SF)
>                 ice_eswitch_set_target_vsi(skb, &offload);
>         else if (unlikely((skb->priority =3D=3D TC_PRIO_CONTROL ||
>                            eth->h_proto =3D=3D htons(ETH_P_LLDP)) &&
>                            vsi->type =3D=3D ICE_VSI_PF &&
>                            vsi->port_info->qos_cfg.is_sw_lldp))
>
> Dereferencing this out-of-bounds pointer crosses page boundaries and caus=
es
> a paging violation (kernel panic). Should skb_reset_mac_header(skb) be ad=
ded
> alongside the network header reset to prevent this out-of-bounds read?
>
> >       err =3D xsk_skb_destructor_set_addr(skb, addr);
> >       if (unlikely(err))
> >               return err;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901083325.34=
45-1-kerneljasonxing@gmail.com?part=3D1
