Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2439F399D08
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 03:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122269; cv=pass; b=GNdLYrbG4ei3R4qPzSgC9oaoHdF1HMBn0j5p42FQ13MWad0AWj640LCmg4dUEGI4XfTtmzilwxp/jhU333skfGXcJL7EopopQtjrRXSR9maOktLnEOeHqwNG7ZPkvZVsx9hYU4mmlu6JtB0fuOkyM5lRhqxNwnAChTot168C6Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122269; c=relaxed/simple;
	bh=YYI72lySTmWGCOX7Pagi7+kqJl1I9aBv6sQuY8k0tgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SLY9v5HibVOGlMs48VFBzdjWNnplkpv5MsxyVDu0DOl09Q/KFrwxVKtxN7WVGneHvdnl647FsqJ8sNtjzMsj0d6/CgVuikcO+gd7yHSfwVGE3GP+W9KlWcG0JGbSn72lbEhuOMNwz37BNFdmFofFxUiPyvuPWE5A9yKj/Au/MDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUJiQtqk; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUJiQtqk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso3865a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 20:44:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792122263; cv=none;
        d=google.com; s=arc-20260327;
        b=LRMEGq0LKXCNKnDiVw7qMPhgftGtoVlKOD86DKNozSy+6niIFVKewT4UA7/+WXpS4u
         5FGHulEjMxkqyXh6f8nJj57+iGCo3bfeb/3u8BiWpB5HqPQbne8jjiYKDeNV8eT5OS7U
         4CFlV1W/MJXtF7Dy+/cpd6RWncqZuzPI0x2M4RCMZbdYYEFh8YLKJGaHMP9aFFC32EZg
         Az8yl27ZxP9KpxD9XST7aPOb8+8k/RssEe4ejxmtrnc34dPcQ1Kng8KUF5zruNzwJVKl
         9nh0zwPIqZEtIJole2A8Kz63F+pEJSSRJe6OXE+A1SUxlUA4T1tfvMNTil29RUTxGq+A
         jwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ARhpOy9hpz9ipUHAeNJOJtGmLehX9Lp4TUcEpx4ik4=;
        fh=cEjW5lkruEuJdJrkM/yQea6GKBUyDjhBofWiCXV8SrE=;
        b=nyRjyQRlP53zj4qVQ+14Ag3Jk432pCvuTddd3qPhwDzGYbaEjYGu0IpPIFLfuHC9iO
         uGRAY0dV8KIqWEnfbDH+Qn9ob1WBnHAWdPr3dIqoK4Xi5ChpZ1lyycgEe6RXWgpwKNgv
         ghVaw72W9PEFndrCY4NchKQjqIDWCkA2Fl6eVgsR/CHyZEKdQd+MmCNM4WAjfEVkxE5i
         i1Tl9Ad/C1p0bY8GIulWKVviyqStwiSAaxkyaA9sbK/fmAmrlves4ARc1X2kOtIUYZ0X
         2ahV7LesBIFPGZyOnyYOzz+aJ9Xeybvgdcw7D+3BdhqT3sqB2KH+jqZiTgtIeiEfMOWI
         Xk/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792122263; x=1792727063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9ARhpOy9hpz9ipUHAeNJOJtGmLehX9Lp4TUcEpx4ik4=;
        b=YUJiQtqkTrt6feVFqGQCGwLB2qnZzADg3Uis52z7J89aQEYaMq1kKAOU8qcHkFIcsh
         LZIojymcHxwSB1La3faXjnniNLv9ZiyXbyXyhGgBwDcj53KUdARL0HvKxJGO0gTGlng2
         Y/7gjdjHbQ7b6PUpEp8cGY4Cvg/ejEB+dh2M4oAPciEOK24iZ/VRr4YtlYRoWjru5GzZ
         WNv1L2XYmuxe0tVGPng0NARj+1duoN1gz0O6REMOvVfLHDHyE7gf0Vuww70eHRT0viZX
         MDk4KLvBeC6A4RolcRtxVlIjS9g2E74Be1J6mlUdRbPf1ORVYLl110adQpWfuozeDAs8
         teLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122263; x=1792727063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9ARhpOy9hpz9ipUHAeNJOJtGmLehX9Lp4TUcEpx4ik4=;
        b=At96vv95nFCHr7Ci1yYtG/065ki03CEnyTfOCZ7kmlqh5npb4phhXxn3DfoozIsj7y
         254WSplprprqP/D+b3LcbBffgyg6aP037gLkbn1YZ+HmjKgbckHxIZRll9wKETfbgDLK
         FtEkiefbpRNjecRKpNyyM7iWZsXaeZOzHJdoBN7JTcqHAm6sHY2+fy/YJte0pO0dGPcs
         RZpD4ECF0Jhtw2+gS1h3Y4ycFeGFFMTtLs4L4yNNfDM0jkWwqPSgE3yfySX4JGwfrJxJ
         kue585/0vdUZ3fU6ufONZnCtB++y7MfBLp/W8wl5svFBCrD7yH+nitOMMn6jBdsLUGqs
         ErqA==
X-Forwarded-Encrypted: i=1; AKwUvBxL2ywcvqfCipE7lwo8qi4rhJrO6LybnhfTni2utl/Yw/BwoXdFWoc0zURXrc2qHoT6KOY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo0B3LfxpnJJzozi7WHBYXUm5f8dqwxysi+q/M/z8Y5di7Oh/7
	l2ZQaPs9fjGKzFBH0Ywd/tYiICNepEvz17Nr9KCf7ABWy+6uT/j+kA3ThccYKbYBac+nEjbHTLy
	rzTATdmA4kcfT7k0VFbE2pDvN5iEenUF5z2PtLQvS
X-Gm-Gg: AYBFou1iJ2khMpC8wxgWdKo5FesMszchuvlR7tDdUgmYmuQ4GLEZGQYuCt+szP5xfWf
	cbbjjOvARZm0QeZiymSDDJs2hjh6N+Y0LzxwesLd8txgIUqKuD9TnCDTJ/pnVB2lc23c5oPkHpu
	YKlr+SCBG2oBLof8r85TlH7aEXltRyuCX6BklmyoJHU8bd8vdWTs3VZo2a0SozfkLoFEcrxnG7h
	BZglv7L04E0TyaOyZz0ptfFaxzie5Ynm8+ZJunpmY5o0KYwDcTBe/Zlg6ZqdvInC6Vckoi3CcO4
	yaJ8v1YljffXHPLW8mHA8LNp6hTGJXx7+fn+Byk582HFEeOAvJMkzQ==
X-Received: by 2002:a05:6402:5168:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b38c3c0061mr20821a12.11.1792122262666; Thu, 15 Oct 2026
 20:44:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014173945.373295-2-almasrymina@google.com> <179209665647.434549.4410094840593695015@kernel.org>
In-Reply-To: <179209665647.434549.4410094840593695015@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 15 Oct 2026 20:44:10 -0700
X-Gm-Features: AclHuK_AY7S3EHhUJkVZl3m_UeQ2fg420IBocWoHLNeVVf6pF9O3oqXG1dOFVmw
Message-ID: <CAHS8izN47FP2nuY26hZSCekf2vB1SXqz59h66NOWA_C6T8+vCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/6] netmem: rename __get/__put_netmem() to get/put_net_iov()
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, ayush.sawal@chelsio.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, tariqt@nvidia.com, horms@kernel.org, 
	steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	ncardwell@google.com, kuniyu@google.com, john.fastabend@gmail.com, 
	sd@queasysnail.net, ebiggers@kernel.org, kees@kernel.org, 
	aleksandr.loktionov@intel.com, petrm@nvidia.com, u.kleine-koenig@baylibre.com, 
	j.raczynski@samsung.com, wang.zhan@smartx.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 1:37=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
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
> - [Medium] At this commit, generic RX skb handling can reach the new
>   else-branch DEBUG_NET_WARN_ON_ONCE(true) in get_net_iov()=E2=80=A6
> - [Low] The new kerneldoc for get_netmem()/put_netmem() in
>   include/net/netmem.h says they always take or drop a non-pp backing=E2=
=80=A6
>
> --
>
> netmem: rename __get/__put_netmem() to get/put_net_iov()
>
> This commit renames __get_netmem()/__put_netmem() to get_net_iov() and
> put_net_iov(), which now take a struct net_iov directly. It adds kerneldo=
c
> for get_netmem()/put_netmem() and the new helpers. It also adds a
> DEBUG_NET_WARN_ON_ONCE() for net_iov types that do not support non-pp
> references.
>
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 0cc8572f62caf..697d50c51a5ee 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -399,21 +399,37 @@ static inline bool net_is_devmem_iov(const struct=
 net_iov *niov)
> >  }
> >  #endif
> >
> > -void __get_netmem(netmem_ref netmem);
> > -void __put_netmem(netmem_ref netmem);
> > +void get_net_iov(struct net_iov *niov);
> > +void put_net_iov(struct net_iov *niov);
> >
> > +/**
> > + * get_netmem - acquire a non-page_pool reference on a netmem
> > + * @netmem: netmem to reference
> > + *
> > + * Acquires a non-pp backing reference (page._refcount via get_page() =
or
> > + * binding->ref via get_net_iov()) regardless of page_pool membership.
> > + * Counterpart to put_netmem().
> > + */
>
> [Severity: Low]
> Does this description hold for every net_iov type?
>
> io_uring zcrx sets up its net_iovs with net_iov_init(..., NET_IOV_IOURING=
)
> in io_uring/zcrx.c, so net_is_devmem_iov() returns false for them. For
> those niovs, get_net_iov() and put_net_iov() don't change any refcount:
>
> net/core/skbuff.c:get_net_iov() {
>         if (net_is_devmem_iov(niov))
>                 net_devmem_get_net_iov(niov);
>         else
>                 DEBUG_NET_WARN_ON_ONCE(true);
> }
>
> Without CONFIG_DEBUG_NET, the else branch compiles to
> BUILD_BUG_ON_INVALID(). The same is true for every net_iov when
> CONFIG_NET_DEVMEM=3Dn.
>
> The kerneldoc for get_net_iov() does mention the warning. get_netmem() is
> the public entry point, though, and its kerneldoc doesn't mention this
> limit.
>
> The put_netmem() kerneldoc below uses the same wording. So does the commi=
t
> message:
>
>     always acquiring or releasing a non-pp reference regardless of
>     page_pool membership.
>
> The skb_netmem_ref()/skb_netmem_unref() kerneldoc added later in the seri=
es
> repeats the claim ("otherwise acquires a non-pp backing reference via
> get_netmem()").
>
> Could these comments say that only pages and devmem net_iovs get a
> reference here?
>
> >  static __always_inline void get_netmem(netmem_ref netmem)
> >  {
> >       if (netmem_is_net_iov(netmem))
> > -             __get_netmem(netmem);
> > +             get_net_iov(netmem_to_net_iov(netmem));
> >       else
> >               get_page(netmem_to_page(netmem));
> >  }
>
> [ ... ]
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b25d8e2c9aafe..23a40e1ec2b15 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -7555,23 +7555,39 @@ bool csum_and_copy_from_iter_full(void *addr, s=
ize_t bytes,
>
> [ ... ]
>
> > +void get_net_iov(struct net_iov *niov)
> >  {
> > -     struct net_iov *niov =3D netmem_to_net_iov(netmem);
> > -
> >       if (net_is_devmem_iov(niov))
> > -             net_devmem_get_net_iov(netmem_to_net_iov(netmem));
> > +             net_devmem_get_net_iov(niov);
> > +     else
> > +             DEBUG_NET_WARN_ON_ONCE(true);
>
> [Severity: Medium]
> At this point in the series, can generic RX skb handling hit this warning
> for io_uring zcrx niovs?
>
> packet_rcv() accepts unreadable skbs and clones shared ones, so the
> original skb is left cloned. If pskb_expand_head() later runs on that skb=
,
> for example from ___pskb_trim() or from skb_ensure_writable() in netfilte=
r
> or tc, it takes a reference on every frag:
>
> pskb_expand_head()
>   skb_frag_ref()
>     __skb_frag_ref()
>       get_netmem()
>         get_net_iov()
>           DEBUG_NET_WARN_ON_ONCE(true)
>
> skb_release_data() then sets skb->pp_recycle =3D 0. The final free theref=
ore
> goes through put_netmem()->put_net_iov() and hits the same warning in
> put_net_iov().
>
> Before this patch, both calls were silent no-ops for these niovs. With
> CONFIG_DEBUG_NET this gives a WARN splat, or a panic with panic_on_warn.
> The trigger is RX traffic on a zcrx queue while a packet socket tap is
> active.
>
> The later patch in this series, "net: skbuff: replace __skb_frag_ref() wi=
th
> symmetric skb_netmem_ref()", seems to fix this. It changes skb_frag_ref()
> to use napi_pp_get_page() when pp_recycle is set. It also stops
> skb_release_data() from clearing pp_recycle, and it carries pp_recycle
> through the copy, split and segment paths.
>
> Could the series be reordered so this warning can't be reached at
> intermediate commits, which would help bisection?
>

It cannot be re-ordered easily no. This is a very minor concern IMO.

--=20
Thanks,
Mina
