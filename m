Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7100730DED5
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781388215; cv=pass; b=te7fqbZsY1zDIzywAPSaKg0qblYPCLHhfSjJIsCiKY2D1UEdzxLQVDqDhLAltJimLfI9g+/uPXkq5jPUL5IK8uy7sUU876Gpk7EERrbw5nqkotpFBvxr82ts7+waeS8o3kONBFSDZPHUpiIl1Ac/rzdPCmBslkPFK3AXvc9ig3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781388215; c=relaxed/simple;
	bh=CC2KOyzJo9c2S8ETDKWxWGYPm6Xl7L/vh9sZj+qsAq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5MLsN8B3HmagDY3DvvAmK+Rmd77690eAoj5TCBK6K+0r5goC6oF5KJLWK5MfwyaHWM+4iuFmTxPV8eolH26FhZLeMmtvpJz6cICLCkPzMIp5E6j4KPuJs2alEuN210Q3wGbjaHeMvE4llQ65XEclqF1CxQ0sw/Kfj7xIFQ5IXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okfb8Ms8; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okfb8Ms8"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68d234218bcso3683629a12.2
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 15:03:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781388213; cv=none;
        d=google.com; s=arc-20240605;
        b=Xkba9MEENOwiYMgFI9/s0eOwhmYXr3hSkO5FKwEy6ajKzzTmID+1cAuOmBl7DOIgEz
         jzFW0eAVBuDO7/U8k52AROAqUFHzDH6/CxGXTtQulRn8L7T1AmOYP3g+V2oy7hK1DeUj
         L4ZIp0GuJbOy2RecuyRAUu9IjOMLSoMh6MO9RtHKHCpv98XC4hBDR8wIfq3JNvJzMaw6
         7zJgKEAxc8UUJq2abNmiolvIahgrHA8l3AG4NZLDP6+T2UikKbN/tEnMiKZQPU/6pYVv
         kt9qIxdhKOs9RsZJhQz/JaYKysYYd5xwz06zUIBh+PZgLqt+HePR9nV2JcGSPvGeJC89
         FYCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qysF8lJhFwPgtIThDB7gwFIAI+ONbPrwLoXuG9PR2+A=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=TKOrWE8YE9ynjbBFfDgg0ilJxcsLp59CLMwrC8TTVZqIjoVUnmklDtJASoWS7TOIn1
         vsNJAxnHwQVttVxyj+AVy6QHakR1arpskvDASgLuBgHaHnUATGjTqS4+qljzHwSfqJwA
         XKU4PaIQMY9o4qfttl6LA9TjjdxrbPCLfXwLMoTlkeXm0jzuOl89cAifHl//TDNh7sQA
         QILXveBjsykLhfkWeC/scXRv642Oy8n97kJWrupEQKUTpllW5RaOIfkOsnxkkbyAlr//
         +yQvn+yeKfsM5op8T3S5ll40IJxFX+QP2Lv3JYLhabfpTSgcmjkaxt0o4PaGDIhNJaHZ
         zW7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781388213; x=1781993013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qysF8lJhFwPgtIThDB7gwFIAI+ONbPrwLoXuG9PR2+A=;
        b=okfb8Ms86TWDTH19jmKAr7ZnwEroFSoAivZA+/N0Mfs5BssWqY5ksxiiX1q7WHq8Gf
         2SG0Ve9z+fRv3E00jdnZK/grusZjjL1eozp5+Vphwax+cH2i0BhEkvi2RlkvbaJ2oU18
         oYF6Vny15eIttnavmlQxsGWgiC7m/kR/kv3VEBTNF0jO0LzFbXwUiFYgqu/W96h1Pe/V
         6+ZMyHocuOPjEoi66P2ZQwK3QhWyNcf6n5XMu8TOyRsPBIONj+hIwgIK+ddkpN3RzOZ6
         ekhco3FrTVlh0ZZs77NEfC8S7wUkU81C+3jtDOzlyrZVhePaN6jzReho6k5D+KZUjSOC
         iRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781388213; x=1781993013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qysF8lJhFwPgtIThDB7gwFIAI+ONbPrwLoXuG9PR2+A=;
        b=nW+wLw197ZqJJMU6Rgc/JHyZf+ml7ratOCihn1sMEMBNaDnp6tX+7Qw/XTvovWWehc
         VaDdzW99NVNMKoMe63vMk/wWWA71EPDzXBGVGVSo7YO+9+j63sTLVe3tQInL5MpEGC78
         XC8gd+RmzoSnGtZctTrCse/i3yWd/g+Tp5FdsOw9aibQq4OvzVMZ6kxPO3cbqFCu2j/G
         53Y49EW43mgzRQrtayyXDEKrzQie+/V3twF4Z8kJelYxtxKvHwwxg6TZLckND+mr70i/
         elkMcj5wSw0b5Yb9YEv6YroKDP79WvlRrijjcSRN3xl1JYdDB/QJxqQGa7dlnoqpuc6I
         Uw6g==
X-Gm-Message-State: AOJu0YzO2p7vmtsd/QhvJBAMfbufzMbIW7KK6GdR/fYWPpJOm+01NMkN
	3i6NRH8ViVBEO8AZMDLK4gBbQQdJHNZuQ5+oYkmi3P0FU1XwdiVq4ZyxMtfCfThkMOvCOcUMoXX
	beacwigijNWLKGcJTMcnDg1hDFXqYsI5GMiDEnG7m
X-Gm-Gg: Acq92OGt0EGeeIsrie4fIptZZUF+QZi/QW9mGhZiSLFpnMn9amM8ppWCYtP54X4uECx
	/6zvTY/pVefLaKdpRujeO+plJaGxTY5TiPDtOHbMJeHrCYCh0eeEKmhZ58R84suk7YUzJn2NE7v
	AwwXvwKBWi1XTiBM9V0X9gVWjYxwjPkz60g0mxSHcSM+Fe33LSUZi4xJWSpYr3gMqyZaFf1zwwX
	za2oZ83qqeXW0W9iYbsBLd2T7dSEIlic9x8ag5ULUR4b10XQ3WIubrHxu6pIXeT/7BHuPXoo395
	7nyS0enkptjaQHCajVQ8kpMoH6inVSANbm8oiqbXi1cTybNI0eEsNJjztrbitn258Hpd5mo2fcG
	DYceMS1JilfY+KfJ4yNG61cavjI1bnn4vbBJhO/FguWjQixF0Mw8T
X-Received: by 2002:a05:6402:3982:b0:691:b5aa:5a5c with SMTP id
 4fb4d7f45d1cf-693c6a838ecmr1690850a12.20.1781388212377; Sat, 13 Jun 2026
 15:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-5-kuniyu@google.com> <20260613012052.C30831F000E9@smtp.kernel.org>
In-Reply-To: <20260613012052.C30831F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 15:03:18 -0700
X-Gm-Features: AVVi8Cd2fngs2ft348K_ehIGvxfiiaA919q7ioHY0qEDUuYMap8QhqfoyVbRUDQ
Message-ID: <CAAVpQUAJ9s8DXVnt2Kxyga3HLqDcp+Jh0AvzhzrK0m3t1qg3OQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 4/5] bpf: Add kfunc to proxy TX HW Timestamp.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 6:20=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Incompatible `payload_offset` semantics and bounds checking betw=
een `tcx`, `cls_bpf`, and `bpf_skb_complete_tx_tstamp()` leads to false rej=
ections or packet corruption.
> - [High] Blindly clearing skb_shinfo(skb)->tx_flags destroys the SKBTX_DE=
V_ZEROCOPY flag, causing a permanent memory leak and application hang.
> --
>
> commit 07c148630f8e93ce45f5ce41dcd9ee675f05a799
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: Add kfunc to proxy TX HW Timestamp.
>
> The commit adds two kfuncs, bpf_skb_scrub_tx_tstamp() and
> bpf_skb_complete_tx_tstamp(), to proxy TX hardware timestamps. This allow=
s
> socket applications to receive TX hardware timestamps via SCM_TIMESTAMPIN=
G.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 0c6c270d9f7d1..a45cdf38616ac 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4456,6 +4456,41 @@ tcx_run(const struct bpf_mprog_entry *entry, str=
uct sk_buff *skb,
> >       return tcx_action_code(skb, ret);
> >  }
> >
> > +static int skb_do_completion(struct sk_buff *skb)
> > +{
> > +     enum skb_drop_reason drop_reason =3D SKB_DROP_REASON_TC_INGRESS;
> > +     struct bpf_redirect_info *ri =3D bpf_net_ctx_get_ri();
> > +     struct bpf_tx_tstamp_cmpl *txtscmpl;
> > +
> > +     if (!(ri->kern_flags & BPF_RI_F_TX_TS_CMPL))
> > +             goto drop;
> > +
> > +     if (skb_unclone(skb, GFP_ATOMIC))
> > +             goto drop;
> > +
> > +     __skb_push(skb, skb->mac_len);
> > +
> > +     txtscmpl =3D &ri->txtscmpl;
> > +
> > +     drop_reason =3D pskb_may_pull_reason(skb, txtscmpl->payload_offse=
t);
> > +     if (drop_reason)
> > +             goto drop;
> > +
> > +     skb->protocol =3D txtscmpl->protocol;
> > +     skb_set_network_header(skb, txtscmpl->network_offset);
> > +     __skb_pull(skb, txtscmpl->payload_offset);
> > +
> > +     skb_shinfo(skb)->tskey =3D txtscmpl->tskey;
> > +     skb_shinfo(skb)->tx_flags =3D SKBTX_HW_TSTAMP_NOBPF;
>
> [Severity: High]
> Does this direct assignment cause a memory leak if the packet was sent wi=
th
> MSG_ZEROCOPY?
>
> If the user application sends a packet with MSG_ZEROCOPY, tx_flags contai=
ns
> SKBTX_DEV_ZEROCOPY

This is pure hallucination.  No such flag exists.


> and a reference to ubuf_info is held. Blindly overwriting
> tx_flags here erases SKBTX_DEV_ZEROCOPY. This prevents skb_release_data()
> from calling skb_zcopy_clear() when the SKB is freed, leaking the ubuf_in=
fo
> reference and causing the userspace socket to hang indefinitely waiting f=
or
> the completion notification.
>
> Can we mask out only the timestamp flags or preserve SKBTX_DEV_ZEROCOPY?
>
> > +     __skb_tstamp_tx(skb, NULL, skb_hwtstamps(skb), skb->sk, SCM_TSTAM=
P_SND);
> > +
> > +     consume_skb(skb);
> > +     return NET_RX_SUCCESS;
>
> [ ... ]
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bee1e7eee5eae..fce2d24aad487 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12396,6 +12396,67 @@ __bpf_kfunc int bpf_skb_set_hwtstamp(struct __=
sk_buff *s,
> >       return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_skb_scrub_tx_tstamp(struct __sk_buff *s)
> > +{
> > +     struct sk_buff *skb =3D (struct sk_buff *)s;
> > +
> > +     if (skb_at_tc_ingress(skb))
> > +             return -EINVAL;
> > +
> > +     if (skb_unclone(skb, GFP_ATOMIC))
> > +             return -ENOMEM;
> > +
> > +     skb_shinfo(skb)->tx_flags =3D 0;
>
> [Severity: High]
> Does clearing tx_flags here also destroy SKBTX_DEV_ZEROCOPY?

Same here.

>
> Similar to skb_do_completion(), if a user application sends a packet with
> MSG_ZEROCOPY, blindly clearing tx_flags to 0 erases SKBTX_DEV_ZEROCOPY.
> When the SKB is ultimately freed after transmission, skb_release_data()
> will not call skb_zcopy_clear(), leading to a leaked ubuf_info reference
> and hanging the userspace socket waiting for completion.
>
> > +
> > +     bpf_compute_data_pointers(skb);
> > +
> > +     return 0;
> > +}
> > +
> > +__bpf_kfunc int bpf_skb_complete_tx_tstamp(struct __sk_buff *s,
> > +                                        struct bpf_tx_tstamp_cmpl *att=
rs,
> > +                                        int attrs__sz)
> > +{
> > +     int defined_sz =3D offsetofend(struct bpf_tx_tstamp_cmpl, payload=
_offset);
> > +     struct sk_buff *skb =3D (struct sk_buff *)s;
> > +     struct bpf_redirect_info *ri;
> > +     struct sock *sk =3D skb->sk;
> > +     s32 delta;
> > +
> > +     if (attrs__sz !=3D sizeof(*attrs) ||
> > +         memchr_inv((char *)attrs + defined_sz, 0, sizeof(u16)))
> > +             return -EINVAL;
> > +
> > +     if (!sk || !sk_fullsock(sk))
> > +             return -EINVAL;
> > +
> > +     if (!skb_at_tc_ingress(skb))
> > +             return -EINVAL;
> > +
> > +     if (attrs->payload_offset > skb->len)
>
> [Severity: High]
> Are there incompatible payload_offset semantics between here and legacy T=
C?

No, both are offsets from the ethhdr.


>
> In skb_do_completion(), skb->mac_len is unconditionally pushed before pul=
ling
> txtscmpl->payload_offset:
>
>         __skb_push(skb, skb->mac_len);
>         txtscmpl =3D &ri->txtscmpl;
>         drop_reason =3D pskb_may_pull_reason(skb, txtscmpl->payload_offse=
t);
>
> This structurally requires payload_offset to be relative to the MAC heade=
r.
> However, for BPF programs attached via legacy TC (cls_bpf), the MAC heade=
r
> is not pushed prior to ingress execution, meaning skb->len excludes mac_l=
en.
>
> If a MAC-relative offset is provided, it will exceed skb->len for small
> payloads (e.g., empty TCP ACKs where mac_len + offset > total_len - mac_l=
en),
> causing a false -EINVAL rejection.
>
> Conversely, if a BPF program compensates by sending a network-relative of=
fset
> to pass this validation, it will cause skb_do_completion() to pull from t=
he
> MAC header incorrectly, corrupting the packet.
>
> > +             return -EINVAL;
> > +
> > +     delta =3D attrs->payload_offset - attrs->network_offset;
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613010039.13=
62312-1-kuniyu@google.com?part=3D4
