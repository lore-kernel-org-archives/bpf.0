Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B964430DED5
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388118; cv=pass; b=qf743sOvIFkzjTwV4P6lxcIGTp3fpSl8ArhwemSUjPW9uTMeBWtInAxNq3SumT5TpGDbVsNZeWFe+JRAgCG84dNmY5D7wG17P1LceOD47icoCbGpqAnbEafQpg5NHWT72rOdbFvQuWnxUlAUqUyx+esOw3enG0518YKnZn97JPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388118; c=relaxed/simple;
	bh=f0dboT9HbEPgztSvCb5V2Mo86m1g8/W+EO+6oIonMYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3o2OFmt4rv1W+H5YzZT3e1R+kLGZ6MUvyX2bmtKzaBH5ZbKEte2kitV2FYCBWorf03QaluNJXVIhCvVuACOY3jP7ZPmkEQhGacAOziAZyGw+VQFDhZ7xU4mavHm5FM3yqZJ6RF+9Uy/+8EE8/K/8wRKfmnUL0ndDan+pPBDtlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DG1WK16i; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DG1WK16i"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68c76fb8009so2901797a12.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781388115; cv=none;
        d=google.com; s=arc-20240605;
        b=BarCxCkDsIh85F91r+VZ3VipBsZzWZzb0J0wxU6r8e6D8oQX4upCajFHjGbiJUoTgL
         L14XSfChWMN+0GAeVQSSfPp8h8kCBRuezp5neQF1jOr/gWFwwN3Q/z3/9m7mygZ6BUX4
         q+4ul1kRklMeZx/FpI+vrTxcmc0UxpVq+NnIlwX3pNrUTJH5IEidkJU0Ia8UZHXFO7LU
         AziPMMlg/g1aKnaCYzmEd5PjbHEDvkojN2d2kAEKpDd8qMB76Bph5ctJ++DdS8xQtQM5
         StjLLYAT9IJya8gGigdkJRmDgaDUHsI786Mxtjlc4+h41hO37l8GJlFdhSoS647hNwSf
         y0Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pOyPLd+VCfIBQPcIBHqp74G9VvIByXO6xAOgWcyyZtk=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=VimvLRAVm9ttSb/f4W97siGJpjE1JvYois4VhuriHkimBN8adUbZLB+5aEFeUo2dZB
         sO4c+NLG2hJbRUtKoQQnNp5dC8gOc5QRtGu891rivCArUPIKzG2GOYuE25VhB2wWlWJN
         2w7IdrxRl87tNUQ87A9yjKL+Zs5lD/Ly9uYxhnPBdvEoOdAzmc+OlpXB56+FInrtyuqd
         AlYi3KA/txRgvp7s3ko37wTz/m17VQOLGUx5UEVckQyL+b0wAs/NNOnzvwn4JzC/OOuv
         ajlob7Ayn+luEHQCyL39xe2cFaBzsP82XoF9ckSpR1alVELzMA9Yp/FOOaL4ZOftihcm
         +AXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781388115; x=1781992915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOyPLd+VCfIBQPcIBHqp74G9VvIByXO6xAOgWcyyZtk=;
        b=DG1WK16iQ2Y5ibyE1CgvwDIZSKhWQ0r0aW7qQ1HpQSviVjSwwa9y4AuhzyFfHjA30Y
         OGXhw/pAtv13BEvE3MZNbtGAm7s3klUDlZqjBEY5FFra7pNWUvgG8TP2gDTXEy17GjPi
         b66fCtYabpk37TwysggE//S6EK1U9cQZVaDfEqiWI2oxMLnQlJHu/NjT+4vX4K+pNOYW
         aRn6STO+9KLVgfAhLppky5/bqUdaTsDPOUP5pMnMA0W0oH8Ozr9pWKgOeIQ5kudFuslO
         0pOTfBHN0ttHPTrua5l5/kWuLxYyNUnTBSomONmIJild368/1eiXlsyfTMWZPFd+RvCW
         Ifhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781388115; x=1781992915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pOyPLd+VCfIBQPcIBHqp74G9VvIByXO6xAOgWcyyZtk=;
        b=W29osFWtyqxqNnyKvyQoV/PsY2SWSu58D0Uj7oEMmz98wxtKwWLOG9kPf1Vk7aRz4Q
         zFGlCQgGan12zz5gB3eknrZT+Kq9y9zMWSXtTOUhqW/LI0PxX+zluBEQiB+bOaPCU6D5
         T97LgWsMDENZzzFZao+x63N0HOZ7P9rou5CRtPe5SV4xZGDqPZzqzd9u1+M02XyDOMUU
         Drlmkro4sTvWvXDP1Fe2yLO1r9TN+h5LsneIUxAtEJG/2n/fvqZxk8H/XLqCOgoRtTiY
         8MuLM/46zSyAktG1Eh8DaxhWzMj+4lX8hEk+8mNcOmKLz6dHfHIvV46Aqh1GCityVHca
         8YzA==
X-Gm-Message-State: AOJu0YxxEtC4/BAEwNc291i5AMMkFBDEs09tix6TqdNV3bwiLIYDpZSt
	XfJhGYKodGD4ik1Ydug5puoSBCO+dTU5wztJsszAJeJsQv+sHskoRvAWDkhVvO/0lCxiIPEufUD
	cTUBl1lfb1j95Um4eLZfj73YxRFB9NYyrnh24D2Oa
X-Gm-Gg: Acq92OFeFFHIVomOqbB8I1vH5pYw1p7DnbHmebns77gWnVZbs/pDxxt1Uz0Sf3+L6uK
	Y6I5wEdbu5Cbh9Rgdwx3NdwjOXCEx8QCZjGmkhJtoe5/44HxGy39gY3tcroMKxMRMn2OXrT9VVu
	xMtplH7EnBQYHXR+D7CeP5xPvQ6D+mLYZbOqH0jXDpfOQvu1r6TG0rChh7LP+wwrM6el9CCIMaU
	SaVsOH895lY/+5yAJvv2sn9t4g46O6GVZgh53FSiW4+9OHYrtqsiIf4AwLyQT0t7kNHAPgeCWAn
	XEFo4/rhf2EXRBqLKTR9po3oxwApEFdtdEjCdyJQQ+cTeAbS/0tpqNW+D+3WaM7wNZnDyDteA3T
	PktxZJviuxlO4SorNY9ScICuA9snx8rQ1ED0cmGP1Nc4L90VaojA6
X-Received: by 2002:a05:6402:3201:b0:691:55d9:fff5 with SMTP id
 4fb4d7f45d1cf-693787ed9d8mr3849204a12.10.1781388114606; Sat, 13 Jun 2026
 15:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-4-kuniyu@google.com> <20260613011253.0CA741F000E9@smtp.kernel.org>
In-Reply-To: <20260613011253.0CA741F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 15:01:41 -0700
X-Gm-Features: AVVi8CdJkQbKL-C5Y5-uoOtUriwMeFA2JPv7tNM8BMVCLfY0s6pJBg3acXP3_6E
Message-ID: <CAAVpQUBSsAOj68rwwKLGpdu_5GHZZYdL=3n9-CuAksgzh+u93A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:12=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Potential use-after-free read of `attrs->hwtstamp` if the BPF pr=
ogram passes a pointer to the packet payload.
> --
>
> commit 41caec1764c831fb81388c5eab46d122318a01be
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: Add bpf_skb_set_hwtstamp().
>
> This commit adds a new kfunc, bpf_skb_set_hwtstamp(), to allow BPF progra=
ms
> at TC ingress to update the hardware timestamp of an skb. This enables us=
er
> space proxies to encapsulate and pass hardware timestamps to socket
> applications bypassing the kernel networking stack.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index acdc66aa4f27c..bee1e7eee5eae 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> [ ... ]
> > @@ -12372,6 +12372,30 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(=
struct bpf_sock_ops_kern *skops,
> >       return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> > +                                  struct bpf_hwtstamp *attrs, int attr=
s__sz)
> > +{
> > +     int defined_sz =3D offsetofend(struct bpf_hwtstamp, hwtstamp);
> > +     struct sk_buff *skb =3D (struct sk_buff *)s;
> > +
> > +     if (attrs__sz !=3D sizeof(*attrs) ||
> > +         memchr_inv((char *)attrs + defined_sz, 0, sizeof(u64)))
> > +             return -EINVAL;
> > +
> > +     if (!skb_at_tc_ingress(skb))
> > +             return -EINVAL;
> > +
> > +     if (skb_unclone(skb, GFP_ATOMIC))
> > +             return -ENOMEM;
> > +
> > +     skb_clear_tstamp(skb);
> > +     skb_hwtstamps(skb)->hwtstamp =3D attrs->hwtstamp;
>
> [Severity: High]
> Could this result in a use-after-free if the BPF program passes a pointer
> to the packet payload as the attrs argument?

This requires bpf_skb_store_bytes() to build attrs on skb,
which does not make sense.  Passing sane local variable
is bpf prog responsibility.


>
> The BPF verifier allows passing a packet pointer to a kfunc argument that
> has an associated size parameter (attrs__sz). If the attrs pointer points
> into the packet's payload (skb->data) and the skb happens to be cloned,
> skb_unclone() will invoke pskb_expand_head().
>
> This reallocation frees the original packet buffer, meaning the attrs
> pointer becomes dangling. The subsequent read of attrs->hwtstamp would th=
en
> dereference freed memory.
>
> Would it be safer to read the attrs->hwtstamp value into a local variable
> before calling skb_unclone()?
>
> > +
> > +     bpf_compute_data_pointers(skb);
> > +
> > +     return 0;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613010039.13=
62312-1-kuniyu@google.com?part=3D3
