Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C7935A3BF
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 05:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781242931; cv=pass; b=In8tixt/crV+jidGk2Fbd5LEoPIfmVCMZPNr3H1WMJHU7LRCD4xaonCmfUS7UuAFxPJLEEZJjD4IIVm7I5++tdRCDNj3ScfiUiDPDgT7/AGLzK/p9mfG+KUOcwmuc0zPj7DK7lb4ROaXqQFnVcfL7/n8hQ/aF6WJWv0T943A9l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781242931; c=relaxed/simple;
	bh=b7ssKyEPRr2Vb5DDqAHfIT1SDpMFdyWHnpD92KViFkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwazJwzAuzexZ7SGYBjRoyHo8rt1cokQGcbj/p/N9ztv2tlQXjMMxte80uMppjcrqWhMXNbc6u0Kf7LuxDGSG9TQL6eQSh3ook3gGn4TMcZKQenvQXn5yo/d1XGhZsjq4CdW17GzKLEzL/cAWLlUyxHHIdcDINL3R3gQySFDgwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EqfjiCb+; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EqfjiCb+"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1370417c01cso699658c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 22:42:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781242929; cv=none;
        d=google.com; s=arc-20240605;
        b=HBAlPcbxQCYhltJo+4dqzKayHJFjszPM2WdDnH7HprXZJ3lD9/dED/G93Pqds50q4m
         vbXyJCHeaRyPBVOjYhzWNrXVUqfSc1SaI2KTyh4NJ2ZraidmYhw534DmjR9NU0h0BgcI
         7JB3j7z9x9BRPX3wu6EQ8GN4/DK/oWhOSwLn40Tet2d6eq6PfabUFKqPx2vtapdjLLSu
         W+z0OlI+lOywVlYx5xZdfhvDoFx9AL1Ewy1F8fiwNs5gDXjvG0HqhuODKMKam7QlNLQw
         gIK8rFYQwQlZzeWLYBskrZOTxTIH9542kOcJtKS9PqjUsio3QyzTBlpJoRV72YPWpne0
         CF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TJ1nugW/8fu1vZ5ssTBZ0A1vU90yVL1AO+VaIOxrxis=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=Ovwnl7LXgquFVyarzBUQP4ap7GCgn8Tm0iEKDyZO0UikC9uYz4ljMO/bje6WNDkrjj
         7u9TMY7bYRBIswljJpcrUjJnNlwqtMHiWsX8TKLX4sRumynubeLGWzB5YSGoZaGjuSuX
         GjKwPRkSgo8YZkgQBd1ixRd2gdJ4XxdqqwufF+cVqccFQ0jWZEkCvMHVAwOkVH5P4vU3
         xoQplrhQH/3HtYLO6rKqmOgZlsXRLfoOnPJxF1A7JAtmilH6gk9NeQZ86kLmSL5bThDF
         hvqcjrdDZ7OCATizDQiG25Y3k1+u1BV6TKSea+giCH1vXuzRzz6lfdG9fTvVFXjN/cxb
         F68Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781242929; x=1781847729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJ1nugW/8fu1vZ5ssTBZ0A1vU90yVL1AO+VaIOxrxis=;
        b=EqfjiCb+55Hj0y9grsFzbc1cGYAzk8NloDJCNQZrHWTYSwHf3kkz2yDThRETNIEjyo
         VWVJ/I4p9E2sxPeSvmLG0aDdTGYl5DFYno8YVbnijvNXPjKZh02rQRBPa3f0/VWCc1wj
         Gn0AoCuIwzVS6knHBZlD4Y/kTB9Fwo4urP6sRrGjCUal5fTooUxvu79wKUUmj0rrBQcW
         YppIL2bP8yCDF00rHSbo0g64o75qRC7dgI7JqLalb8yJnOfmx785pLxJNxU78+ecnvc/
         +2s4bynKFn9WjMNpfQ8uSVwE9xb3RuTsJpEbcEEKeuyzujPVygxanLBfv4klEaDwIG5t
         75eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781242929; x=1781847729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TJ1nugW/8fu1vZ5ssTBZ0A1vU90yVL1AO+VaIOxrxis=;
        b=IdWEgg24N1kUrNvz4CT0SWPetjSptRzS7ugyI9CQmyLkVtYmuyx5bBRgqgly6OB0w5
         9odkO2DXuO+i6dFDnyYUu2HkUV+masxqbx1T56tpAPq7tjDt6jW+iOH8De3ht5Zo51p6
         6TfGWtvBtdW9xoDs7jZFpw0YkGFzCYO6vnXomsPSipRGoCom+QhL9VRlLXgKPAIoITlx
         edtP5G0w9lbtBq4k5vw7ld1y9VB2gS/yheT1TmDAYdKI1WJrYD/xbh9eTBC3lxx1HlIO
         rjnYTXqYNLU/pCDEITiL1URLY14cdEP400gXecohUhSsVu37QOTnwnrHmWLOAClY3WDP
         FU2w==
X-Gm-Message-State: AOJu0YyeRzGYdB/1wmUq8OF054P+iQr3o6IlVd8BsuVNsYifguBxSg1M
	aYJ1Z9izGWHW/p5wVYq1p6i61j8MeZtRo4KFk+uaKLjwkM/YitGjf6iwBXsYy9Ux3XM74AcZsef
	S1kvWubxeOAUqW1LMZu+s6UkxLaBmzcwXHGK8ytVKkf8X0U7qt5jdCOP4WhsyWg==
X-Gm-Gg: Acq92OE7aRiE+9Fxq74jVumpxr25P7lAoFWon4DOUK0GnFislsKqlrACvYTBVo6LhDu
	0E89BeFub+BsDDczvZfc9RE/DhVVnTZcenOeQPkWRW3tu8q8DnSXBzTBPsnsbsfz+BvW1SbChhN
	fRasx0ZLErJo5kphFqH1myu4UV8wLRA7kz7/qXDQpuzjB0rF6yhhq4YifqhfhnSMKN3hLL8rdIy
	QuoOw9zyUPYOtk7XpAF7PnIYx+z7/Hs6k31Gn9A6GMYjIfU4fvISt/Mj0r4Iam3t7ecdn/XsHau
	BZo63ZXmNnb3Wh2aiGTrM6Sg2/CyvP/B0pSoUyO1M0g3TDIcQFVZ6LiFOEtHeYI0muZNRpxdzFO
	piYiYIxRcnqwzeDp4MIUjWUo+Xdw3/qB2EqqnYAMV6JE7q15mGDx9
X-Received: by 2002:a05:7022:5f12:b0:137:f532:e34a with SMTP id
 a92af1059eb24-1384bb2d069mr412838c88.8.1781242928052; Thu, 11 Jun 2026
 22:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612001803.23341-4-kuniyu@google.com> <20260612003353.4977F1F000E9@smtp.kernel.org>
In-Reply-To: <20260612003353.4977F1F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 11 Jun 2026 22:41:56 -0700
X-Gm-Features: AVVi8CfEiVFr0M6hRN3rfWkjVoSVyBffGMIcU1eHrMLX4u0ZU-ew2qj-mdydr5k
Message-ID: <CAAVpQUDTfftqVVSrX25S=Rq=gWoJ5pgsHuf7xW-v_Pqtdm7cMA@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next/net 3/5] bpf: Add bpf_skb_set_hwtstamp().
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:33=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Unsafe modification of shared SKB data (skb_shinfo) via insuffic=
ient uncloning
> --
>
> commit 96bf1885d42f4593da3e164388ab66653eb4e518
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: Add bpf_skb_set_hwtstamp().
>
> Adds a kfunc to update skb_hwtstamps(skb)->hwtstamp at tc/ingress. This
> allows transparent proxying of RX hardware timestamps via SCM_TIMESTAMPIN=
G to
> socket applications.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index acdc66aa4f27c..ab7adef9c0159 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
>
> [ ... ]
>
> > @@ -12372,6 +12372,28 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(=
struct bpf_sock_ops_kern *skops,
> >       return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_skb_set_hwtstamp(struct __sk_buff *s,
> > +                                  struct bpf_hwtstamp *attrs, int attr=
s__sz)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)s;
> > +
> > +     if (attrs__sz !=3D sizeof(*attrs) || attrs->reserved)
> > +             return -EINVAL;
> > +
> > +     if (!skb_at_tc_ingress(skb))
> > +             return -EINVAL;
> > +
> > +     if (skb_header_unclone(skb, GFP_ATOMIC))
> > +             return -ENOMEM;
> > +
> > +     skb_clear_tstamp(skb);
> > +     skb_hwtstamps(skb)->hwtstamp =3D attrs->hwtstamp;
>
> [Severity: High]
> Does using skb_header_unclone() safely protect against modifying a shared
> skb_shinfo(skb) here?
>
> For TCP transmit clones, the header is released and skb->nohdr is set to =
1.
> This makes skb_header_cloned() return false, even though the data buffer =
and
> skb_shinfo are still shared with the original packet in the TCP write que=
ue.
>
> When these packets loop back to TC ingress, such as via veth or loopback,
> and are modified by the BPF program, skb_header_unclone() will skip
> reallocation.

I missed this loopback scenario.

Actually I have another patch to avoid skb_header_unclone() in
bpf_skb_scrub_tx_tstamp() for TCP skb (skb->destructor =3D=3D
tcp_wfree()).


>
> Could this lead to silent data corruption of the original socket buffer's
> skb_shinfo? Would using skb_unclone() instead be necessary to prevent thi=
s?

Will use skb_unclone().
