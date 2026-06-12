Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB62F1FED
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243968; cv=pass; b=fWtITe/D1KwRMEPXe20RwNsLnY2w6SAI0gPuY19vjFlPbbpmmlFAASw8EALF+4G8UCRVJgLDk4rlZrYnpYhOPaGgO00clDB8WtwBVAXLajIs9E3XtydrabpnAY/N5H+UafbvODLs+RbEOTOdE0KiviCq/7UmEB/cVJ2NPNPVJa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243968; c=relaxed/simple;
	bh=NCMOSv8PebqwPmrSyGCA5at/gCV9usFfd7wYj6j8PWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfobuCGgXrV9Y5163H6jgyzUTrp1fzOYbxx5UjnxPp5qUZ2ojl9MxERQb7FwblnQx2+210UmOAT3fuUh928yD5MVrdRnj5NST2Oq8KsvEqMRk/Job1A7fpMDfJedySZEf+32VWK/6xXqN93whjH4J40Mruv8cxGm76tJnj0FNbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfbF/VXU; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfbF/VXU"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30749947917so1977049eec.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781243965; cv=none;
        d=google.com; s=arc-20240605;
        b=ay3isXOeS7w2sCDAZzBapjStAg04KSkA5dTHNwdz3Evgcz5Kp+94Gky9eVYQGtIxyO
         4mRqMo0unL5KiLueBtuIDjOYdbQ2UoPuGJFWszupBbn/q1c+RgEt/OKvXpEk+0KUiKOn
         2yULko+o+QKBMLxJ/gnJGdWP3mNPpfzbFpPO/OeztzDlcKxuXFkcYE2bbUCkC0tKBiqN
         NGisOAhqAjccRt98fr5m5/ma47dwEhEq9p7En6rHoYm7eye1SROFJ2Gwl/aKi755IRLi
         jtiYflD6ragCHE3gEhclDDiExVXghpwsAGEBIdPHCG4UGUlJB/gwWIR98Oohstm2JoZp
         Y2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PX3ObJ6hAnulchFlbqVK9HnQncb17pHwM8Q1uYSdLsA=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=PdWLOJ68xnNMSlscuNYt46wtS0d25vzSQfS2+/NNekWMGF+Bwr7HDnXpymimts/wcx
         i91PKBD4CKISaSiDoALE9kEqZucMqzTqAKqwf9doshRgo5bvWXRVePIUP1aZcN40aVfE
         0gc0zlwIFlBDCWUXv5mMOVZZVhuojGK6r5uTs7L/3MuqSGOpSDfW1UhzVZq37T21CmI+
         clHmu1eNvJRsnqc9QFSlAQj/vUO+6s4JL2VVnq1icOtj8vDAJWm6OcIr2L7OYmDyYD9I
         TYP4U4549zpoZnun6G12SOprkxd8ud9snlnDQKw4c2GIuAidVMw0t7SPTr7GbV4cxZ+5
         dffA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781243965; x=1781848765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX3ObJ6hAnulchFlbqVK9HnQncb17pHwM8Q1uYSdLsA=;
        b=XfbF/VXUQ0GQVSV3KELfWxHpfs8xqJRUjpz4PCZQleolEuVwoWOHAiOtixnSJIENOH
         q8paL36gsCKg38TUBkeDG9sV8xpPxrdCvL/SrFh9D46T3Ixm2ePFzV1mPHW5F1ZxOFEf
         V7xCJPoXJIrsihOgqKkcykpzhXBMmXgQZLtUyhsbkGSb3zUT7Ajx0xOQUBfzTdVHYhUc
         hUQ5/RBZz8VpE8oI90u+TyKCy5QXPXS9N4o+TIfYDvfZ/R0gfasbh1fiaqGq7eVRYTBI
         HTTQYZ7gtAJcb93yAskWaVOjWLz0pt0v2Mb5a9C6zELe1F0ByvurcCgFLD3mUf/hSft4
         ruHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243965; x=1781848765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PX3ObJ6hAnulchFlbqVK9HnQncb17pHwM8Q1uYSdLsA=;
        b=FEuHYCIrUZLs1+Pxrv/IsgEfmN80Um9px5jtuhnbwXXOZyErt98QD7ownzg1YCtqq1
         yoo6oEk56aVEDryJSt396TUH47m68WvSGfNiTg2Ubkvy19FACevRf0yS4Mfh7Y/ere6L
         UEScZM97KMam6PYTk1FoTT6neBu5jGYtSuJqfXcwrqgnY0uetcpzk8nsDW8qCUvAOzT0
         XMG2+rdL56gwLyfATMlr6s+R/5YKPXkBvmYKuQFgu5nc/1iWhEb62JO+CdWLwmIHViTD
         JezpmRNJdG2CJtdAgGZ8ukCL5D+6bHfRef47doOC6pq13iOxDrAK6A+1Qyh5jaAAst1c
         mnVQ==
X-Gm-Message-State: AOJu0YxPQlPOFy9SNpxbhs2pszBbHvK4RJ0DaoMK2BSVIpFDuks6ou3T
	WSL72rcHZw0IXBi31gLlLXwkZsS4lRUVsrMR6JtRlSIpSGGakSQk+d1HVsLmWEGjTgPVUH1prdq
	2xF8fTqclMyKKYi55CGUkId9KQVYskxLSnEEDqVnp
X-Gm-Gg: Acq92OGDhAh8d2mLgE1LfVn5B5wjGTRUIUtxsloyO9BBB9F4sftP0JHOSgIdJHe0jLL
	GLOaGcpiocSJhW0kRmpcpN2ZYqKwipyxYzq3DoODRfFpEUg5PJWgQc5YGz9b+4M4VwR7SeQ0J3l
	dIYDJPkD0nPjB23KZXGyD4siYDqKG6FahkVAWo/i8i7e62TRx5ruyHpZQqIuGNh+BLByQh6fF2M
	gxG0NTj7jZhdZLzEt+J+CqkGUn1Gt1ZfnxfqYx2RikIy/nVfDX+UUTYqDhXQGg8EjsOYvkV7SN2
	FchGlfgeKeFMzrOJKVVDVgd6b0/GcH35rLYx+P2rFl0Li3MnMBwlfZRYc8JK3pfPbUZZiIWo+vH
	kYM9xTqzD3v6ioLuXl520Li/iHxEndKRLOLm8WsJWPFVN47Carn+M
X-Received: by 2002:a05:7300:578e:b0:304:b15:17d6 with SMTP id
 5a478bee46e88-3081ff63c68mr958282eec.6.1781243964671; Thu, 11 Jun 2026
 22:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-5-kuniyu@google.com> <20260612003305.53D791F000E9@smtp.kernel.org>
In-Reply-To: <20260612003305.53D791F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 22:59:12 -0700
X-Gm-Features: AVVi8Cem_OB6wuchwynjCt5I59aMSQZ4TgN3C5ww0DubhLFIYFCj_2Bzyd1nYB0
Message-ID: <CAAVpQUBhoxYNst2FnTZ+NpnPp5YRLDC0+petEyObjrf7OK4QaA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] The TC_ACT_ERRQUEUE action is unhandled in sch_handle_egress(), =
causing packets to be silently transmitted instead of queued or dropped.
>
> Pre-existing issues:
> - [High] bpf_net_ctx_get_ri() will dereference a NULL pointer if bpf_skb_=
complete_tx_tstamp is called from a qdisc where bpf_net_ctx is not set.
> --
>
> commit 532ea1ea43e08b0ed268837eba11a8d463c7b97b
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: Add kfunc to proxy TX HW Timestamp.
>
> This patch introduces two new kfuncs, bpf_skb_scrub_tx_tstamp() and
> bpf_skb_complete_tx_tstamp(), to proxy TX hardware timestamps for socket
> applications using SCM_TIMESTAMPING. It also introduces the TCX_ERRQUEUE
> action to enqueue the modified packet to the socket's error queue.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0c6c270d9f7d1..a86d10659cbbc 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> [ ... ]
> > @@ -4504,6 +4539,10 @@ sch_handle_ingress(struct sk_buff *skb, struct p=
acket_type **pt_prev, int *ret,
> >               *ret =3D NET_RX_DROP;
> >               bpf_net_ctx_clear(bpf_net_ctx);
> >               return NULL;
> > +     case TC_ACT_ERRQUEUE:
> > +             *ret =3D skb_do_completion(skb);
> > +             bpf_net_ctx_clear(bpf_net_ctx);
> > +             return NULL;
>
> [Severity: High]
> Does TC_ACT_ERRQUEUE also need to be handled in sch_handle_egress()?

This is intentional.  I'll add !skb_at_tc_ingress() check
in bpf_skb_complete_tx_tstamp () instead.

>
> If a BPF program returns TCX_ERRQUEUE on egress, the switch statement in
> sch_handle_egress() will fall through. This clears the BPF network contex=
t
> and returns the skb for transmission instead of queueing or dropping it,
> which seems to bypass the intended error queue behavior.
>
> [ ... ]
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index ab7adef9c0159..0bb8122f9f2eb 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> [ ... ]
> > +__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> > +                                        struct bpf_tx_tstamp_cmpl *att=
rs,
> > +                                        int attrs__sz)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)s;
> > +     struct bpf_redirect_info *ri;
> > +     struct sock *sk =3D skb->sk;
> > +     s32 delta;
> > +
> > +     if (attrs__sz !=3D sizeof(*attrs) || attrs->reserved)
> > +             return -EINVAL;
> > +
> > +     if (!sk || !sk_fullsock(sk))
> > +             return -EINVAL;
>
> [Severity: High]
> Should this function verify it is only called on ingress?

Right, I'll add it.

>
> Without checking skb_at_tc_ingress(skb), bpf_skb_complete_tx_tstamp() cou=
ld
> be called on egress. If that happens and the program returns TCX_ERRQUEUE=
,
> the completion state would be silently discarded and the packet transmitt=
ed
> because sch_handle_egress() does not currently handle TC_ACT_ERRQUEUE.
>
> > +
> > +     if (attrs->payload_offset > skb->len)
> > +             return -EINVAL;
> > +
> > +     delta =3D attrs->payload_offset - attrs->network_offset;
> > +     switch (attrs->protocol) {
> > +     case htons(ETH_P_IP):
> > +             if (delta < (s32)sizeof(struct iphdr) || !sk_is_inet(sk))
> > +                     return -EINVAL;
> > +             break;
> > +     case htons(ETH_P_IPV6):
> > +             if (delta < (s32)sizeof(struct ipv6hdr) || sk->sk_family =
!=3D AF_INET6)
> > +                     return -EINVAL;
> > +             break;
> > +     default:
> > +             return -EAFNOSUPPORT;
> > +     }
> > +
> > +     ri =3D bpf_net_ctx_get_ri();
>
> [Severity: High]
> This is a pre-existing issue, but can bpf_net_ctx_get_ri() trigger a NULL
> pointer dereference here under certain conditions?

This is orthogonal to this series.

Also, bpf_redirect() etc do not have NULL check too.


>
> When a BPF program runs via tcf_classify() from a traditional classful qd=
isc
> enqueue callback (like HTB), sch_handle_egress() has already cleared the
> bpf_net_ctx. Calling this kfunc in that scenario would cause
> bpf_net_ctx_get_ri() to dereference a NULL pointer.
>
> > +     ri->kern_flags |=3D BPF_RI_F_TX_TS_CMPL;
> > +     ri->txtscmpl =3D *attrs;
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612001803.23=
341-1-kuniyu@google.com?part=3D4
