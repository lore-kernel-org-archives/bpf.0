Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795261021;
	b=SjzyP6fzmoxWL63EqvaxWbLTvrRdE3/GSKqEaAzA0qaTfGlZrn/NJmfKTUB/ERfmNtVD
	 EgBDxYLaIaoB4XMoPXw63QN2inn8roU+qupDIZJclnQn6bhUUXW+W4g+H2T1ibwgcKGCw
	 eu2+u3TO85BqTVfilhWINln5+V1n7UY4a/Y8Lj5pKrFb2JXyY5zM1R9OalbQL5Sy7slm8
	 fQ/UU6n+v5xfOniGiDBFqRGD0o5/XtVoZsD/rog6ROeb5gZps55lzY2SnZcVLJhBn1DMy
	 SYsSmJEWgNYhWVJyLcvoG0dsExR+VdPTmAy7W2te4H7DSq+pyTr87tQy0ixi87z6wmg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=gpxUmT1DXpteToj1Lp4HCEtZ/G9nbHGyPF9Kc8ok+s4=;
	b=W4u1k2TbaZhqRniFW5XbOc5vyorggXUo+oSpYcn8Xs1M1pkBPax/+69+BCuVFHVVb0Fh
	 6qF3G/23O7sqUk/hjQMfX+AqaPBC5l2B0ZUHEipKXp9hAzMVbiD+NHt9nx/l8bGkjrmLQ
	 19AQ+8o10NuTYaRJJRit40iv45OuntH4Rlt5PgO2LE3D+OBnF23wpIqeI0dadtvMgCUM8
	 SChcOcDs3OIHSK9T7oAV9W0zv00VIC/j8Undp2skB8IOPjbb580jt1UBCd4QKcckzJ/vn
	 C9g6M8CnCysspSdyAcKopYWqntpZsl5uppORIcj+OJAC84Kn8Iot73WCPfC7USbYL2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=li9wo0Wn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33175606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33175606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=li9wo0Wn
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so1350227b3a.3
        for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 03:37:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795261019; cv=none;
        d=google.com; s=arc-20260327;
        b=mwnTrmRPxkSde4YpWCv9kIAFZnMhHw1zVltHvPxjuhcONaxatGMAVyfsbryvqHp/+9
         WnysTpaRLweScD/3ywgZGnuNmrK/y0U20O9Qe1bfHPu5K44ZXYzekyVoqkvR9k3aWV79
         2LaAA8bDYxaPlCVUidFxICmteFmcR1v+5D3ntgQjLWRuWf54qJUEn0UH2C6Pvp2SfJzr
         NZd2YpgtQmRI5JHBeFTEsr/uy6F5YmZ1Llsbdhs8GW1mrgtrF1up8hGGg4PG24shgxO6
         Z9SkmhljiR8w/T7qRow3m0n4w3utf8c6oj9o7h86RTDrAUmQcYrBlQ+IwIHwY+9C/hR/
         lFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpxUmT1DXpteToj1Lp4HCEtZ/G9nbHGyPF9Kc8ok+s4=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=XPP4nlfX7pHp3c0OGSkog/aypJ3pRKC9/8KZQj/gAqE+u9bd3I6w8gRoUUT8bmNPmw
         IjLGpcVUQSgJK0DFnz3gEO+C5M8p7uJM0Ct9coL+r0iwTOWr5GX6VvE0EX7CGO/T1Sx0
         qgZEZSrzImvBgmXy/h7wScoljKH3vX2gvfV7KNxab4PC2u3AD1PGl13nqDsOq5q2WegG
         e1MJ2y+2mtOq5ssRMRsMdr7MJQnDvn53CXQlzLllxgAuFa92HGMP9ew1HZy8KokGJlxM
         idU8A89aFujXAGuZZTGLQW4bFCOpKUp0xLsAMJEUxJ7v7DO0zdsffvCU4tl+e/clwroT
         48Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795261019; x=1795865819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpxUmT1DXpteToj1Lp4HCEtZ/G9nbHGyPF9Kc8ok+s4=;
        b=li9wo0WnVdf8mzC8n74OxDUr/gadhAlyYmjRgaShl5I70T3r+djqFaQB57RCsoSkf2
         GYR6YPZForxR3m7bFowP4azaygO+5HbEWZ0HyiXyMVzXwR77MDyivU9q0nK//IuVegM4
         avNC0f5TeKW4NcgsJOWw3CjloY1hD0h1SAK5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795261019; x=1795865819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpxUmT1DXpteToj1Lp4HCEtZ/G9nbHGyPF9Kc8ok+s4=;
        b=WupEMwpJ77gCj3+/69NWsLipvg8m1nY6JgeblJ39XAWyoZd/luHQftJVRxq/Q6iuni
         El5yxvCItcI40Kv2T5tbFwJlDXUhjNbYhFoet6vpTWufg7FgPGxV81SMSD4u3+qq1O/p
         i4RWi2dsPjb2KNoxcme9/Cannop7qW67GegpUxqZdHmgYNtyAiTb4sWgEiPI8/0J/yN/
         DQxHxHQxQVGQRty1GhEwDSYDHQFug3jUD0UjSbZle/jbHLRRPSoluvCDvdu/O2rWioQU
         uIiWGGekbq1KG43LoiVBX29p6k1csdRI9u8UFVcAu8G2r4ylJs8c+zB3uWHixCWyLQ4c
         q9lQ==
X-Gm-Message-State: APuU4Z/4/pGJcngqmq8JrcQoftW4nfdU5Jkwo5ZR8OnNUO9PFBrTWBYI
	QyqM3QATNGy0TnWrv5DJqbYf+vs48f2YXmFRs4J/P8j8OQU4scOYDw7B1Zrk/mwHk7jch8t7L1i
	TglH+W5mcSFRpN5FPVe3Bspk+X5W2/kGCvdcmmC9TEz9hVHKXuoc=
X-Gm-Gg: AZFdTZfdvsE+6aw8NdMFTgfkyI596xkBUAmJZ5hnOWTBegkri1/tj44jp4Mn0JIskK1
	XcMmIin+Nw0QA0BzcXf3uXM8dWBawekFPUqwcAEjqfD7GVKpC947YrQZ1fdvBrw9/XEhcBoMXkO
	cX0ZVnAUX8uRkgiS8RaYyBleB+nH1od0gmXLvvYSjxEvpLuobYTlDmnjKb8F6tqEQTAfaqhLVDe
	OjRzIb4EXRmUKSVbl7bfPs0d3g0rtMDbVH0xVaEPkZJ98gDPRLOiUntWmHmVn1rknLjKV4zR1JS
	QD66qmS+8zsQS+HC9IkomldIvjcOVdPdkEIYKuAE6JFdaCxr+6YG1dr0eH1TzG2Ye9VqV18r/3e
	gKaUT9LUIu8qte75mHjuyDYBYxjyuAawdCLU9BC8JxO08giA7Dhgr9OMoA7UP9HExEC7tS1KUjG
	5DUIWMxnJ9W3aCvMVHzGxY
X-Received: by 2002:a05:6a21:d83:b0:3f7:8096:254a with SMTP id
 adf61e73a8af0-4014d76478cmr5859141637.42.1795261019528; Sat, 21 Nov 2026
 03:36:59 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v6.r0.20261119070330@mojatatu.com> <QDISC-6HS9.v6.r0.20261119070330-2@mojatatu.com>
 <sashiko-outbox-225153@kernel.org>
In-Reply-To: <sashiko-outbox-225153@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 21 Nov 2026 06:36:48 -0500
X-Gm-Features: Aa3M54pgLaAdx6r-YmeXtilib-Ky2ELKZp-WJOZtHqBg6iwZDGGNIq4wUb5NCkg
Message-ID: <CAM0EoMnrLDHJQfC2fPdmnxW+L51XRArcL1nWggKXHcO06VEiiw@mail.gmail.com>
Subject: Re: [PATCH net v6 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:40=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] net: neighbour: reinjecting skb onto n1->dev misroutes
>   redirected packets

This is addressed in the commit log of this series. I know you read them.

cheers,
jamal
> --
>
> commit dce8515be5271f5a3b9c463a37e73a62aef0f6af
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> net: neighbour: reinject a parked skb through a headerless output device
>
> This commit restores skb->dev to n1->dev in neigh_update_process_arp_queu=
e()
> when n1->dev has no header_ops before calling n1->output().
>
> Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org/
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index ae2db3912454a..d36d86cfc441c 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1342,6 +1342,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless output transmits on skb->dev, not n1->dev *=
/
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
> >               READ_ONCE(n1->output)(n1, skb);
>
> [Severity: Medium]
> Can setting skb->dev =3D n1->dev misroute packets that were steered to an=
other
> device while retaining a dst pointing to a headerless device?
>
> As the commit message notes, nft_fwd_neigh_eval() and
> __bpf_redirect_neigh_v4() / __bpf_redirect_neigh_v6() (when nh is provide=
d)
> steer the packet to a target device and nexthop while leaving the origina=
l
> skb_dst(skb) attached, and neither site drops that dst in this tree.  Whe=
n a
> packet originally routed to a headerless device is redirected to an
> unresolved neighbour on another device, neigh_update_process_arp_queue()
> re-looks up n1 from the retained dst, resets skb->dev to the original
> headerless device, and transmits the packet there instead of on the targe=
t
> device (or re-runs n1->dev's egress hook and decrements TTL a second time=
 if
> redirected from NF_NETDEV_EGRESS).
>
> An egress redirect or mirror via tcf_mirred_to_dev() from a headerless
> device to teql0 hits the same issue, and cannot drop skb_dst(skb) because
> teql_resolve() requires the dst to resolve the slave neighbour.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-6HS9.v6.r0.=
20261119070330@mojatatu.com?part=3D2
