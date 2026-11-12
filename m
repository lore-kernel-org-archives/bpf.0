Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794503980;
	b=IWc3DuTNMZq2fhNVf9wZdNl30Rmv+rXdV7yijrtGBcgBxB+kVTMclfaqyKC1t2wXo5NS
	 qEQcBb9Ww07Xa2nXyLqkuna31497vnJZQcqMJcbFxiV37CDjBgVU0lKuhkDsjHyaTT8S4
	 UylrLlwhacedP2M3zS5f1/jVBbuqAahVDQtsP64ujNRecWxx7wZeqodHyroSGRKrzcBT9
	 LhlZRsOnTlaYtdIfgcoo6FDUCheBgDzFA7SPHJEStLQGVwvmR75OLsS86ixiZUES0WQ/j
	 ze3y8i3OKJlDTLq92BNQfHOHCaHbiImx30UNnXwNyomDA7G35/JF5QQoGALRqDOtNTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=I05mjbbFYjMFnuigmLqaWYMd5Jv9jNx+LJJbCKAKCgw=;
	b=33+35zZzLFrjojTddRRO75jELi5vna6Hn9Wc1xIPhfL+0bgjdiQ5CjA//VqulDTErInu
	 Fu6cGbHsskuiwcYV6SI7W1iJF4o+U4pkAhTOUUMc7BkRtvlTPGnfWX62iQxg1oqWZaMmo
	 0YLbgPb7C4k4DtrLkEljSR4FlcpvwDn1XixwhDs97LgW3DonACCe63MlpwVCENQiBik/i
	 Zqi8ha/6zq4n6HihBFNrh7cLdDjAJabj0PXM5cDbk6V/MA8yOAALdVtR2wZcC+ZrhlV8T
	 Opl/nXdXRmObqI/25kBR+y7oatKVMCvMGuC/1XQUc6SYzT7bR95rN040gnu9Rzt9f5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pfPiBpbJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E022606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E022606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pfPiBpbJ
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a594d313a3so21285b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 09:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794503978; cv=none;
        d=google.com; s=arc-20260327;
        b=jrk5y5z2nVrJROU6UgcR0WzghlVnotHD4sYQF62gyoUwWiLpVslhFbCD455u5k5wkB
         sKG5p3b33yc0OYf1zQbyS3STMfUk2+wL/8IvkwrgR//svaQCQ2ByT9Ruy3o+cYvjOhFI
         Ae/F49J1N6cBu2VwaC0zyp31RxPD+hnl7KuSAMOGE6zWfghfi5kzFqCfez+aETklTltW
         MkJ5sYUJ5mB+14CC7hi9vS0sAJBwnFx5YPCmyHFeQpfqEMXTI/e7kR5zwZg2gDRrYjsI
         u7YMXBdor9N222aqZYJWP0mnPKTI0i2YPLCAYT/lErI0NvldhqzjO8ChH8BUHSFoey+p
         6UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I05mjbbFYjMFnuigmLqaWYMd5Jv9jNx+LJJbCKAKCgw=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=owEwIhvh5+jbLqZ9x7kjITbOxhsrhaVuhV+Gtgxui05DWblrcrxdPsgYdeSMjea3rr
         cJj/kcbDhM4KLZrT6/yKHABU0wU/lni2+7N8OR3+5zTsT8ob/Jv4mIGGuAXveIgoDkJl
         Z1/kuG04I4pg1V7c+GbK4ZbR4E2Jppu+9HI5n3eye5a5sL38pDn5cTZspCL/hP/D97+4
         bz5zXleTw2YIjDAB41rje6yyjaEr/nHSe0QixsxJyt+Gm7p/qToANB2w8FoGivma6S+Q
         Jm89IKZLqjvbEafSy1V8w6Vqaz8n6ePt/oBpme/t3Tmg1aHzxNd96OHT7eY2bcVw8uwI
         TBVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794503978; x=1795108778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I05mjbbFYjMFnuigmLqaWYMd5Jv9jNx+LJJbCKAKCgw=;
        b=pfPiBpbJoEfqj3jDzCYA+9NSOV3nv9i1VsfAXQtSAu7t45tau93lZSaPCc28XkIWOg
         REoaietOGk1WD1NfQrA3fdG+wNo2JEnSzX/vTMQ08xgzZcMLONgkWeDiFfFxaVVe9T3T
         u5Rg7yuDTqcX3DXHxZBDiAz0XSCrgKIGNN5xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794503978; x=1795108778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I05mjbbFYjMFnuigmLqaWYMd5Jv9jNx+LJJbCKAKCgw=;
        b=pAQ26cbsHRDyCeuRS4u7Bf6wNfXV2eYjCJHBIBPRrnTO7g4qxkEHJ1Mzb7WbcRKQ2T
         oi84NweuDDFJKDDdQ5kwe77Npz/D5+ON4azJIECqrT0EwE7aKJ8a+/JmC+cpjLTTFv6P
         KkxcegjWq4w26AwpDr7TL3hsO5IO1P0QOm/1msZEaZ7egt9V/IM4uVgn/B0DFRT9/+Sf
         m7x3PGf0JsFBvWOc//HJ8DGG+DbOgnbggKctKd5dOV/r5Mwp62ThJCxkmjG7yI7lw9gc
         JcKRam4lHg0dHYBaJLxoq9ZRgiHzdeW9X19aLh+JLfub2F1R5yQw2ehnRj52Z/OCzQub
         Gv8g==
X-Gm-Message-State: APuU4Z8J4mW+p/xXeZbe5e438cTAYVfmdjoU3u1wsqybaFL8DF1XNZjd
	YngaQ9Oc67jONIH4AjQz+JWPdxgNU7utvl1CanQWmUFfZRqETnBW/Uexc1eW8molTTdFkgSBZY0
	lmG/B9nEHMS4Uf4ETgTzh+tj3x+ENiceipTULzAGYee1FnfkOdxSYJw==
X-Gm-Gg: AYBFou1IfmFoRpVgCDRF4S+LxuU1qeyB9d0+1eFlmR20BMRzaFmdZF03dKJX1jXU/Au
	bXGWOh4Qb3HitiTGQ0Qxm6OajD4/jvbX4QkQsoV363lyzUJkoDWBi8F7Mxh3A3PwS6y95VcDRF0
	RJkQWLH7LWJKQ5LxwWyQkb9REGLH12sE1uG0GMR7uxmNPUGZd6aVS/1RvEprjvhShMqT9rIYMb4
	Ojbj+f6C3ImqXuAq0lN4RZ32dx9F6Dg3EX7+vTihPf+dOHgRx3N46xVGOsob5B/bPBU+cDEzAWl
	0lfDDmA0ALSyZbFVy/m2sfQKteblzKOLZ/DDVgszm58khphp5WOqivYu96WkX4mztbfxGfM6mM7
	2EAEqkS+p0enVlOkzpz8sAo9Za74rXZIvomsEnRf1KGhQ7ET24AcPmTn9M2SfPW0JR1jMnCTKl7
	fCbT6teFlXqPW46/R6h3Ve3ZaRPZ454/NBzIcs
X-Received: by 2002:a05:6a00:228d:b0:887:1bcc:3c25 with SMTP id
 d2e1a72fcca58-8beb7c1fa13mr183814b3a.51.1794503978366; Thu, 12 Nov 2026
 09:19:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v4.r0.20261111094338@mojatatu.com> <QDISC-6HS9.v4.r0.20261111094338-2@mojatatu.com>
 <sashiko-outbox-211424@kernel.org>
In-Reply-To: <sashiko-outbox-211424@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 12 Nov 2026 12:19:26 -0500
X-Gm-Features: AclHuK9KivP4uvNIJTy9S3jlRsHLU6_tkIOdqUIAFlS5S6MwJ3jvLG5_TAhlPDI
Message-ID: <CAM0EoMnS7YSy61ojBDnpUF6iDVnxk9KAuM3H=eezEYJL+7Xzgw@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net: neighbour: reinject a parked skb through
 a headerless output device
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 10:17=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] net: neighbour: reinjecting skb onto n1->dev misroutes
>   redirected packets
> - [Low] net: neighbour: unresolvable commit SHA 1da177e4c3f4 in Fixes
>   trailer

What do they smoke in AI land for extra hallucinations? It could help
humans too.

------
$ git log 1da177e4c3f4
commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 (tag: v2.6.12-rc2)
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Sat Apr 16 15:20:36 2005 -0700

    Linux-2.6.12-rc2

    Initial git repository build. I'm not bothering with the full history,
    even though we have it. We can create a separate "historical" git
    archive of that later if we want to, and in the meantime it's about
    3.2GB when imported into git - space that would just make the early
    git days unnecessarily complicated, when we don't have a lot of good
    infrastructure for it.

    Let it rip!
-----

cheers,
jamal

> --
>
> commit 9cdb52e0469dfe26f25fc1882a3e6467660a9e45
> Author: Jamal Hadi Salim <jhs@mojatatu.com>
>
> > net: neighbour: reinject a parked skb through a headerless output devic=
e
> >
> > The issue:
> > neigh_update_process_arp_queue() drains a neighbour's arp_queue and
> > reinjects every skb through READ_ONCE(n1->output)(n1, skb), where n1 is
> > the top-level neighbour re-looked-up from the skb's dst, not the neighb=
our
> > the skb was queued on. skb->dev is whatever the producer left there.
> > Note: skb->dev and n1->dev are not guaranteed to be equal.
> >
> > When n1->dev has no header_ops, arp_constructor() and ndisc_constructor=
()
> > install neigh_direct_output(), a plain dev_queue_xmit() that transmits =
on
> > skb->dev and builds no link header. Such an output sends the skb out
> > whatever device skb->dev names, not out n1->dev, so a producer that
> > parked the skb naming a lower device has it leave without the link head=
er
> > its own transmit path builds.
> >
> > sch_teql is the producer that hits this: it parks the skb on the slave'=
s
> > neighbour while the top-level neighbour is the master's, so skb->dev an=
d
> > n1->dev differ and the reinjection has to come back through the master =
to
> > leave with a header. It names the slave on purpose, so that a parked sk=
b
> > does not outlive the master it came from.
> >
> > This half was split out of the sch_teql fix on review, so that the
> > neighbour restore carries its own commit log and its own Cc set.
> >
> > The Fix:
> > Put skb->dev back to n1->dev before the output call when that device
> > builds no link header, so a headerless output transmits on the device t=
he
> > neighbour belongs to, whatever the producer left in skb->dev.
> >
> > A forward that steers the skb to another device, nft fwd ... neigh or
> > bpf_redirect_neigh() with explicit nexthop parameters, parks it with th=
e
> > dst of the original route still attached. When the original route is
> > itself a headerless device this gate matches there and the skb goes bac=
k
> > out the original device, running its egress hook a second time. Those
> > forwards supply their own device and nexthop and do not consult the
> > retained dst, so dropping it at those two sites is where that is fixed;
> > that is a separate change to the producers.
> >
> > Conditions to recreate the bug:
> > CONFIG_NET_SCH_TEQL=3Dm and CONFIG_VETH=3Dy, run as root. This is the
> > neighbour half of the sch_teql parked-skb fix, reached once sch_teql pa=
rks
> > the skb naming the slave: create a veth pair, make one end a teql slave=
,
> > give the master an address and a route, flush the slave's neighbour ent=
ry
> > and send one packet:
> >
> >   ip link add v0 type veth peer name v0p
> >   ip link set v0 up;  ip link set v0p up
> >   tc qdisc add dev v0 root teql0
> >   ip link set teql0 up
> >   ip addr add 10.0.0.1/24 dev teql0
> >   ip route add 10.0.0.99/32 dev teql0
> >   ip neigh flush dev v0
> >   ping -I teql0 -c 1 10.0.0.99
> >
> > The packet parks on v0's arp_queue. When the solicitation resolves,
> > neigh_update_process_arp_queue() reinjects it; without this change it
> > leaves v0 directly, with no link header, and never reaches the peer.
> >
> > The window that frees the master, and the unload recipe that shows it,
> > are in the sch_teql patch.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Link: https://lore.kernel.org/netdev/20261110101908.2e64e8e9@kernel.org=
/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> [Severity: Low]
> The commit sha 1da177e4c3f4 ("Linux-2.6.12-rc2") in the Fixes: tag cannot=
 be
> resolved in the repository.
>
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index d6e9c7c59a892..1b556fa17c57c 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -1339,6 +1339,9 @@ static void neigh_update_process_arp_queue(struct=
 neighbour *neigh)
> >                       if (n2)
> >                               n1 =3D n2;
> >               }
> > +             /* headerless output transmits on skb->dev, not n1->dev *=
/
> > +             if (!n1->dev->header_ops)
> > +                     skb->dev =3D n1->dev;
> >               READ_ONCE(n1->output)(n1, skb);
> >               if (n2)
> >                       neigh_release(n2);
>
> [Severity: Medium]
> Does resetting skb->dev to n1->dev here misroute packets redirected by
> nft_fwd_neigh_eval() or __bpf_redirect_neigh_v4() / __bpf_redirect_neigh_=
v6()
> when the original route points to a headerless device?
>
> As noted in the commit message, those helpers steer the skb to a target
> device and explicit nexthop while leaving the original skb_dst(skb)
> attached, and neither net/netfilter/nft_fwd_netdev.c nor net/core/filter.=
c
> drops that dst in the tree at this commit:
>
> net/netfilter/nft_fwd_netdev.c:nft_fwd_neigh_eval() {
>         ...
>         skb->dev =3D dev;
>         skb_clear_tstamp(skb);
>
>         nf_dev_xmit_recursion_inc();
>         neigh_xmit(neigh_table, dev, addr, skb);
> }
>
> When the target neighbour is incomplete and the original route's dst->dev
> has no header_ops, neigh_update_process_arp_queue() looks up n1 from the
> retained dst, overwrites skb->dev with n1->dev, and calls n1->output()
> (neigh_direct_output() -> dev_queue_xmit()) on the original headerless
> device instead of the redirected device.  If nft_fwd_neigh_eval() ran on
> n1->dev's egress hook, this runs the egress hook a second time and
> decrements TTL or hop_limit again; otherwise the redirect is lost and the
> packet is transmitted out n1->dev.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/QDISC-6HS9.v4.r0.=
20261111094338@mojatatu.com?part=3D2
