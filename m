Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED263E0C4C
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938645; cv=pass; b=HKwlttBCTpx0j+/iOo3ICdw4FWx27C3Yzf5DZ5dLGE6f3sdN0vhRqkPYure6NuVpbhQQJyf5BZPEp0kB7WWNMNRv+gOVpcDKg6f9XCc0s7uXTOIddGftYEtmi/KkiGFchQeO7YKMwAKH3eDHS4pt9q643pj2AACLYfBHxn8b4BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938645; c=relaxed/simple;
	bh=69/FIpXcRvK5VlNg8OdO/Vit0CelQGLcfTglHil7KWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpqjB/I2DhhJqv66Qe+X/8toxWvHnTnMnCbWythB7t/iXfPE2pCDy2z/Ho2r1j18TQHTIJeSfMFUdR3Qob3S0QQnZJBuK8XElXTOPwjkHjutMGJl54QCQFoM1pub9KZ7eOPAHvwAxZeNiB/qs1R/5ee/UCLa0yRhz5yW5FhN1Eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r4IDczSJ; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r4IDczSJ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so3028359a12.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938642; cv=none;
        d=google.com; s=arc-20260327;
        b=euoLfbnCy7XBpRekvzHbVYZ5B9AiTPQpgPGNgcfWiX84nyFIqVHbSf4NXAXPjXn3qO
         Nus9Nc14xh+f5iT6bOBzmOErgZ2am6YOpYQFLhzHf9SLUHGShzfn6s+EiFEAj+upb7gb
         Hnzznfqdhdx8ZwmRcX9OSOXAau7gbOpAKTMbCgBYk4TgFaLKiJcBmkKcAQIYe5DKjHvY
         JXJn9PFD23F+FUpvFzEOgWPBN1Ppwyx2IVEDl6VUHMqTu5n8/tscUkbcoTbbJmwR60j6
         kyAXx5Bw4A9UHSy0bS/GSVudeo6w1Qsclj3HBHL9/TtbHImpg0T+4XGDWax9uoW59pdv
         YP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EYvxESqkXL+/6XOtOcDBnAusVQ1+xIAcUiUyD6HUoSY=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=GLAF0m7OMUvGvbJQBvyR52hotq/EZYNQBhYTUZQhMSqKpw/wgYN+o8fDeLh0/bS+sy
         T7c381OsufoHO4OgqqFIXvMrQnmlXbUYAQ8FKgGEFUc/fPGBpz9NKcyQv/x8S45bV3dK
         Mvkrl/s9FSSYUOGg5nFqArMzSVf5oMBTu07ond/1xIYYVoQgFujv5Enhyt41TVwwPNhe
         5slLdA/R6kP5PKgpJ3rM5LukpPMff2eBbg5VoY96b1uC6C5u+CS1BsJYbjXcg/Da6luG
         UR8bzc8ddhy9YYnyWIjDe1bCI5VWcxEHvu5dks4F8phmUCwtJ2TGDaQKA43Wp69XnxIT
         Weow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789938642; x=1790543442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EYvxESqkXL+/6XOtOcDBnAusVQ1+xIAcUiUyD6HUoSY=;
        b=r4IDczSJzux4rzvGBNh/fLLfXOnRYxFlD4Hdn/tNGpZq52Egc1Q3/AkR99mb5EdUD8
         GHbwdbAJcWirRclz4oRcnwYdEhKltOMNWBRxuwtveY7iU4FGChDFDEaZbGDwtwNue2WM
         OcjeRpYCxsism/6yPAmO0uOz25m0JuCbIb9kMUhSY0aQC6P2hVL1msEf7xoJUnXMBQ5y
         SGPTemwMdPU/ENYZC5Vg6lHKToleljE0MAytRnGGcf4dxDQDz6b/HDyLO72+UuSPkI6h
         Xg5tp+QBMPLuJCqmZXGXKdTJk81iGHABpc1YLKVWsmcUn6gcAqpxvSL827b66uWiXmOM
         2ocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938642; x=1790543442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYvxESqkXL+/6XOtOcDBnAusVQ1+xIAcUiUyD6HUoSY=;
        b=xFnBhVG6Ky8MV067igbWdMS18qr9d+hhMcmt+sfIwp1iL1tU1+a9S0dNoJ4drjUYLX
         ve+ujX8/6DjuE31U4DIHkv/0N0ijRyo5JKV7HMbjyba0YF43iX4hnWBSbm+ist2mgMDc
         HgUGfqx/ohYE/7A6z8RrFMp/hy00BQ3ZYCJC0glcN8tH2n/ZFc6psZTYDCbYq9BGtJd2
         sl3zrlr16plSDWFSLIiepFGVP29Jv1c56jc9byBCJQKNE5lity3xDT1OI5U7LJbnjdGb
         NYsSYgOtz8Xc6ouEEq9Ia36Rfu6zyjCRXJQZ50hdUr2RQgkv5LR4qmcRgIPxKJPTUijv
         ZvIQ==
X-Gm-Message-State: AFuF++kIAzUYsjBs2AefHW+PAD2dtnoQALS0ZDJjOWTgJouC1h/pZrgT
	UF1vUnfk7NrZRTGh/g/oxiBQkd63xsayXLyUREkqRGt3x5ziDntbbSSeWGHcSWXOChJUnoc1ttG
	am0WQU0YaJ4VGT1FImBJD7EH7bu3Lfmi2HJ1kR5pFS5xs3A6rikUFa/j3lCc=
X-Gm-Gg: AYBFou19kXDOP5NZOgFARkb4x3C5alnMTNYk4iOOGIdh+JMXjg7lAFL2GUkJdtOfdfq
	PNVXs2BC2JCO2aBNgcOrHSn9+1DQaH4jCWps9a7OqSlDNsw0X+Za/X/37OVKn4m030O9RvNJ9sD
	7Up9ZInzgG1ErkZJmzBd8+f8fYmrXd3Nf/tj65GWKP20FbTa1mp0AY3kFRJeid8rF9CIKpm6ZSo
	BgXeka38IZ1lAghLmNPexdRSc3o7OUOnz1ANX6ogTekSi9mqaUC9XLljwy3BzlECkrcPkGngNPL
	XBGCLrAD1PqZMBsDG2ejcuKq0/v4HsNrTmTfbcAwhKKThENpQIs+h+EvrDNPY5JJx7I4AhE9Gyp
	Qn2sKVSvX0KgyKYgIU2Vc1r0e7QmLKkWCLRJMTxyfrVV3QxhOBYo+RzfJx/tg2MTZw+I=
X-Received: by 2002:a05:6402:42cb:b0:6a9:4edc:849a with SMTP id
 4fb4d7f45d1cf-6aa55edb017mr6546558a12.3.1789938641410; Sun, 20 Sep 2026
 14:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-7-kuniyu@google.com>
 <20260920201333.A40C81F000FF@smtp.kernel.org>
In-Reply-To: <20260920201333.A40C81F000FF@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 14:10:26 -0700
X-Gm-Features: AcwNN1WlwcrlxX3Pn_Cb1NE8oUHBEHoAjP2yqHBfg1NXE2grE4ZnMmSHo80OmKU
Message-ID: <CAAVpQUAJJ2RmL_dTH=M2s2Tj9mypL2YtYK7t6tCSaEj4bYY9Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 1:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: tcp: OOB access and type confusion in bpf_tcp_ops_set_rcvlo=
wat()
> --
>
> commit c903e36ae4ed7b68c1aea9023743a57be672cd2a
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
>
> This commit adds a new BPF kfunc bpf_tcp_ops_set_rcvlowat() to dynamicall=
y
> adjust the receive low watermark for TCP sockets. It clamps negative valu=
es
> to INT_MAX and configures the wakeup flag appropriately depending on the
> calling hook (enqueue vs dequeue).
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index b0e14b54917eb..3768b1440eb77 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -359,8 +359,62 @@ static struct bpf_struct_ops bpf_tcp_ops =3D {
> >       .owner =3D THIS_MODULE,
> >  };
> >
> > +__bpf_kfunc_start_defs();
> > +
> > +__bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat=
,
> > +                                      const struct bpf_prog_aux *aux)
> > +{
> > +     u32 moff =3D aux->attach_st_ops_member_off;
> > +     bool wakeup =3D false;
> > +
> > +     if (moff =3D=3D offsetof(struct bpf_tcp_ops, dequeue_rcvq))
> > +             wakeup =3D true;
> > +
> > +     if (rcvlowat < 0)
> > +             rcvlowat =3D INT_MAX;
> > +
> > +     return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
>
> [Severity: High]
> Could this lead to an out-of-bounds slab memory access if a BPF program
> passes a non-TCP socket?

No, false-positive.

This kfunc is supported in encode_rcvq() and decode_rcvq()
only, and we don't support lookup helpers there.


>
> Because the kfunc accepts a generic struct sock *sk parameter, the BPF
> verifier allows passing any socket type. For example, a trusted UDP
> socket could be obtained via bpf_sk_lookup_udp() and passed directly here=
.
>
> However, __tcp_set_rcvlowat() blindly casts the socket to struct tcp_sock=
 *:
>
> net/ipv4/tcp.c:__tcp_set_rcvlowat() {
>     struct tcp_sock *tp =3D tcp_sk(sk);
>     ...
>     if (tp->window_clamp && tp->window_clamp < val)
>         WRITE_ONCE(tp->window_clamp, val);
> }
>
> This writes to tp->window_clamp, which resides well beyond the bounds of =
a
> UDP socket structure.
>
> Additionally, does this permit concurrent modification of the socket stat=
e
> since the looked-up socket isn't guaranteed to be locked?
>
> > +}
> > +
> > +__bpf_kfunc_end_defs();
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920195633.30=
33620-1-kuniyu@google.com?part=3D6
