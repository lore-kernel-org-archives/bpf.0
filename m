Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7C4C14E8
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015518; cv=pass; b=S7Kpu5/TWAC6o6+vqhdz1JhjtI85A3QWIuXVP7xBPInWBFQ91pC5cyTJG/dBNX51+ZJp5zlNkXY6qPAmo50cvq3s8HyjA8DTlNOnXIQC3sni/cjQ8VWIs+CT+kGKDeRPiQc1QJ6dAbx927Iz6L4CGpjOy4WbOnfNNjbjhPHIU08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015518; c=relaxed/simple;
	bh=QZdOOfmt8Jm5RLQIZramMvHmus/nQmnbFJOBNJAfNVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d24m7PYLN1uFXl365LIZCFl0FlkzxYzQDKZf/aQemsKcsKLf92EHHB0Np4nxXHdvbZzbk+YipRxc/mV2z6CpFTNBMFsqULSfvtEgJj2jZoTCCsPY/OMudM0JeiDgucfqdUs5ZQxyBdf76IgBJQcG1vfJeBadjg2Qfce3KmwgCpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OQtAfgFu; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OQtAfgFu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso399a12.1
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 15:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792015514; cv=none;
        d=google.com; s=arc-20260327;
        b=ecn3N33AAYzv4tg/mz9UA2Usgdymio1YW7LmGhQ7f1FF3sdBYfvXXGtpo1mOfwLiHa
         KK65pXgCUMiLmAJgSB/n82y7O/Hnh5HLYro0imJyqJSGkvzbITO7SHTtrF8RtIzNkp1y
         mnp9We//8E7ZX3/gme1BIvlZ8Ok3Z4gBPBpPzIzhgTjWxM5AA9/PGThLyfIQuNN4kz7N
         mw+dmHEtPGtWoCoFibTcKgkLe7qh2zVtcR8072MN503OJrP1S1fbpA2rq0Nsiwl1RfEU
         yxL/z/wl3TXXAWfmu9jqBFhUHIBIpNowgIUOJPURNm/dsXqsQdgyRBpclodmFvyuVo7r
         kVUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zqIxtdg7oikaNaEElNQna4r57IwoPY41P2qZQ85S8yE=;
        fh=0or6QdVodJoe8JBWOHE1l1TJu2HjXNuzMvJcQhtMxKM=;
        b=PCXu0fBgBkDiZWIP2n1ddThHCKeK62BjUxS+/4eviGQs/0coW9obAvYk0G5GsW/fII
         Bg9MjYgGTTXBioshayjUP4qJrMNHBTjowmCOFLRkDEY+74fqwiEUv7IVPRpTF2AL/rbp
         5H2CmQYzHaNYVn8nZ3CBP5NMY+yWup1vniDnqwnDr/kOpZNQLE1A/9BPh5FaB1obHbLP
         +3TYhSKv/4XmrXhvmkJaWBeYWdwTmggz7oPC/3fSiqWMq4MdUBEyp5AqfNib0fHje1HG
         UkPsDNx+L0keSrpFZD/YegTO1iIim7KyjWQVBLIQeQSq1vaIibDFxA4Y0RrQs2pZ5Wpe
         GUdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792015514; x=1792620314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zqIxtdg7oikaNaEElNQna4r57IwoPY41P2qZQ85S8yE=;
        b=OQtAfgFuI+aksZ26HjL7EshBs6MTo3digml8NK5k0ktcP2F2Z7bdmOveJXQwX3MS12
         N7K8yKWa2lAdm9OgkkvtTc0qLTaKQTokxtRBQ+rV3wShdqK0Ym2o8N4XIBXcSLU2DVUh
         seoUsXSR9IiRhL3VlsSLiC8yPL+sc9g1n5CsJF0U/oHbTadk80T/7Aq65Pv1nd7MOZHN
         yCzioHbXOPo5/3v/5wfUDTV0f/nCArg4/WF7tDW+DAvdvx0tGknmCMJUSoI5YSPXMueF
         smYcQJ+MaFMg9c0xxcuLVwNDsK7SdBXwEouF41mCLqD19hCjNvULw9+ymqY2BbRtZ53x
         nCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015514; x=1792620314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zqIxtdg7oikaNaEElNQna4r57IwoPY41P2qZQ85S8yE=;
        b=hak7uNf8I5ViehA9z9bGCtqzDcs6QRt+FM1hDk9Hz4OMsURgbIcrMPxJGK2KjJC2F5
         ZMq5WF373VQvzQIqfp15uYCGr6Pgq9vgSrxwEbNOfX7AkIPCr9sRILDdRchcJNAbFhrf
         mSmOoAVUknZ1lCz7ARWyvlDQkwbjJpgVD7ToeUNTM6ygnBxedZHpp0YX+Vuisnq4fc/R
         6itrNT05IaUHoRkW+84d2ovqFhcl6tXym7F7hQYvcAuJHxTmJL6zZJ6b4vHm5UD/traq
         itkZGJU/mXMRJ5eWKOx0Qo23/UuO2IHy3GrqgpjrGIcbrux6Bua9dIqCbf3+vpAaDDn2
         IiMA==
X-Forwarded-Encrypted: i=1; AKwUvBzfUZ1NEOCvJ6hWmON2fG5Z1vlVyjEOfPC4OIR5TxP8kpk0U/Yro/jW0s1l/oeWs6RMoNQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPsiEY8pNZvZqMcgT8ROVwT68lWcCAfZ6/bmQyaEKdB5L+lZmK
	PpLh/x2PBfKq6oW0Qwvy2HB5hjAyE/n+hZEWOhnlVFDR2qzASbYrVNqZxBbsbcZeDwKbMLJm3Dt
	r4NxAyA2bIpFbrR5rpbuIDRFeddrGaVHKo8YIREiN
X-Gm-Gg: AYBFou2bxVYZt9rAcV7aEo7AAZkObTVIMqaph8QI389o/2UP8CQPpfeBWpSmcmLSBA4
	iWuJ7dvKP8vvYikHTs2KLocFCLL105JRJjA85X8Uf2kKsvGxSvDO9dZveOjexoxxX7NhLK4bPdz
	iWJu+4TnyeNkX9VRZVicRuLHWTjcuJd6eEv/2BJHREC6k0DhD2A24CfUBCLhmOfpHYJ00dX2Z+k
	qStg7SI/SVzlUR8ELw6LYkU/Iw/IlQsVcK7bvhgv3fImW4UsI8dveU0q8eZ9zyix+CIq1oOKeV0
	hFk1kOecsxasLPxk0FhQlhjXNI7wbvcBRvEhCgDC2mElkAakS9Tezg==
X-Received: by 2002:a05:6402:22dc:b0:6aa:128c:36ad with SMTP id
 4fb4d7f45d1cf-6b20aae61dcmr66690a12.10.1792015513640; Wed, 14 Oct 2026
 15:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-1-almasrymina@google.com>
 <20261014173945.373295-4-almasrymina@google.com> <as_yg4hCCfpkukZB@devvm7509.cco0.facebook.com>
In-Reply-To: <as_yg4hCCfpkukZB@devvm7509.cco0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 14 Oct 2026 15:05:01 -0700
X-Gm-Features: AclHuK-FIIYIfRHu7yhPBoI9CQSDVknHHqcppKY8ZRAq6RJPc2uOk0RIcUIsbQU
Message-ID: <CAHS8izPDAjfRFCM2LrC7tzVQRkGCcn6zsghEvHJ9FJ1ET9odYg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] net: skbuff: replace skb_page_unref() and
 __skb_frag_unref() with skb_netmem_unref()
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Petr Machata <petrm@nvidia.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Jakub Raczynski <j.raczynski@samsung.com>, Wang Zhan <wang.zhan@smartx.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:25=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 10/14, Mina Almasry wrote:
> > Unreferencing a page_pool fragment with recycle=3Dfalse decrements the
> > non-pp backing refcount instead of pp_ref_count, underflowing the page
> > refcount when the fragment was owned via page_pool (as on mlx4's RX
> > error path). Having both skb_page_unref() and __skb_frag_unref(frag,
> > recycle) made it easy for callers to pass hardcoded recycle=3Dfalse on
> > SKB-owned fragments.
> >
> > Replace skb_page_unref() and __skb_frag_unref() with
> > skb_netmem_unref(netmem, recycle), which dispatches to
> > napi_pp_put_page() when recycle is true and put_netmem() otherwise:
> >
> > - Use skb_frag_unref(skb, ...) on SKB-owned fragments in mlx4, sky2,
> >   tls_strp, and skb_shift() so unrefs always match skb->pp_recycle.
> > - Use put_netmem() directly in tls_device's destroy_record(), which
> >   releases raw non-pp page references outside an SKB.
> >
> > Found by code inspection and confirmed with the KUnit tests added later
> > in this series; not observed in production. The mlx4, sky2, and TLS
> > call-site changes are compile-tested only.
> >
> > Assisted-by: LLM
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > ---
> > v2:
> > - Note how the issue was found and how the change was tested.
> > - Link to v1: https://lore.kernel.org/netdev/20261010083935.3274178-4-a=
lmasrymina@google.com/
> > ---
> >  drivers/net/ethernet/marvell/sky2.c        |  2 +-
> >  drivers/net/ethernet/mellanox/mlx4/en_rx.c |  2 +-
> >  include/linux/skbuff_ref.h                 | 34 +++++++++++-----------
> >  net/core/skbuff.c                          |  7 +++--
> >  net/ipv4/esp4.c                            |  4 +--
> >  net/ipv6/esp6.c                            |  4 +--
> >  net/tls/tls_device.c                       |  2 +-
> >  net/tls/tls_strp.c                         |  2 +-
> >  8 files changed, 29 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/marvell/sky2.c b/drivers/net/ethernet=
/marvell/sky2.c
> > index 30facdece3e29..1d42a82db8f2b 100644
>
> [..]
>
> > --- a/drivers/net/ethernet/marvell/sky2.c
> > +++ b/drivers/net/ethernet/marvell/sky2.c
> > @@ -2501,7 +2501,7 @@ static void skb_put_frags(struct sk_buff *skb, un=
signed int hdr_space,
> >
> >               if (length =3D=3D 0) {
> >                       /* don't need this page */
> > -                     __skb_frag_unref(frag, false);
> > +                     skb_frag_unref(skb, i);
> >                       --skb_shinfo(skb)->nr_frags;
> >               } else {
> >                       size =3D min(length, (unsigned) PAGE_SIZE);
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/en_rx.c b/drivers/net/e=
thernet/mellanox/mlx4/en_rx.c
> > index 96f97fa0f5489..fe18606c2ab55 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/en_rx.c
> > @@ -497,7 +497,7 @@ static int mlx4_en_complete_rx_desc(struct mlx4_en_=
priv *priv,
> >  fail:
> >       while (nr > 0) {
> >               nr--;
> > -             __skb_frag_unref(skb_shinfo(skb)->frags + nr, false);
> > +             skb_frag_unref(skb, nr);
> >       }
> >       return 0;
> >  }
>
> These do not support qops and don't advertise devmem tx, so they are not
> going to deal with netmems anytime soon, why touch these?
>

They're still using page-backed netmems that have 2 refcounts, and
frag ref/unref needs to pick the right one. Before they were
hardcoding false for the pp-recycle bit, so if a skb->pp_recycle=3D=3Dtrue
here for any reason, this code would hit a ref imbalance. Now after
this series both skb_frag_ref and skb_frag_unref do the right thing by
checking skb->pp_recycle.

This has nothing to do with net-iovs or devmem.

[...]
> > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > index f11d0528fc431..b333a9a72cdae 100644
> > --- a/net/tls/tls_device.c
> > +++ b/net/tls/tls_device.c
> > @@ -143,7 +143,7 @@ static void destroy_record(struct tls_record_info *=
record)
> >       int i;
> >
> >       for (i =3D 0; i < record->num_frags; i++)
> > -             __skb_frag_unref(&record->frags[i], false);
> > +             put_netmem(skb_frag_netmem(&record->frags[i]));
> >       kfree(record);
> >  }
> >
> > diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
> > index 6cc222008d95c..53d3256d0114a 100644
> > --- a/net/tls/tls_strp.c
> > +++ b/net/tls/tls_strp.c
> > @@ -197,7 +197,7 @@ static void tls_strp_flush_anchor_copy(struct tls_s=
trparser *strp)
> >       DEBUG_NET_WARN_ON_ONCE(atomic_read(&shinfo->dataref) !=3D 1);
> >
> >       for (i =3D 0; i < shinfo->nr_frags; i++)
> > -             __skb_frag_unref(&shinfo->frags[i], false);
> > +             skb_frag_unref(strp->anchor, i);
> >       shinfo->nr_frags =3D 0;
> >       if (strp->copy_mode) {
> >               kfree_skb_list(shinfo->frag_list);
>
> Idk this part, seems harmless.. But are you sure we can even reach xfrm
> (supposedly that's how we get to esp4) with netmems?

Same, this is still using page-backed netmems, and hard-coding fales
for the skb->pp_recycle bit. If anchor->pp_recycle=3D=3Dtrue ever here,
this code would run into a ref imbalance and potentially crash. Now
skb_frag_ref and skb_frag_unref are mirrors of each other and we don't
have to prove beyond a doubt that dropping a non-pp ref is always the
right thing to do here.

--=20
Thanks,
Mina
