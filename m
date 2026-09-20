Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92D3E0C7A
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938364; cv=pass; b=ZCu7WALewJeuKtNogic1wfC17MjmzV0FJBQ41zjAvtRxkzbWrFbIJuo51W0khMeOIcQpmAYLnN0somKgwS6NQ1uiZyD63B31BNPy2o/IoidIly3/B/oLwU4qB6y2KO93WHrCiwbt5qKWke/tPQHeN/WTF9lI+nG2QDUASETHlCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938364; c=relaxed/simple;
	bh=ezRCTTrs6uvQwF5UbpYaqGjiPx6ukx27ZxH2gOL/sak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0b5idSu0pT7rqP6cZ8jwcFdpp6Ej0PIECneUDQ15z3WDSWfTKf+dB3XNgZJh/APq5jPME3aHuZn4Rg4u6f3KzvSmSVGCmIwcyD68W9xmte1iUkS+wKEfnVCiO+Z9w4uQ51N/UHruPIAxyXewFZKrY2gGKOM5mShqMKCGt0UU3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nSOxkM9J; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nSOxkM9J"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso2717902a12.3
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:06:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938361; cv=none;
        d=google.com; s=arc-20260327;
        b=YEHKlzTqPJaJbu65E2kkIJNvDy23FAG6EJtuLjGdG2gmicC7ZfIXNCWlv91CmeTtQa
         AMViV++LqpKRJ6/0o0q1e5YuAafVAnhzymFdsikeH/Xh4RjZDUl/Id7WaBCHlqLs4qdA
         3wehXuEWBsJCJp+077zVe0SzIY6L/ihvvlDOjeP70gOkVr2cnJO9AyAea+FWnQGho23U
         /+YQbDF8vdHpBvwoJGxOwGJGg0YvDgA5W+XAu3j5cn6eww7KBjlS8Hidwj5MY1l392Uo
         a4CgI5GmpkZ68iKCID1rFLK0BYatouGm2ApxIOeIBBs6Czg02OEteKbx/saeyhzDw3ro
         iZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTysyvua/pHRkgj+3i2IdhzgN1OTX4ZBg0dHDR1pdSM=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=KXLagTYMCu7FADj43uXt6u4AI/mCJPK+h8MFG7a5CwxxMaDKgYaDnRP4k+cw5URSaa
         w0UIRwh4qxR1GE4AZIXDYjylJhr1SEW6YxxyXuLVyqbfgW3B6qiSJEOwXLBwKQl1OVOy
         DN9THCclTuxw2fC3bVq2E7NSUTh5JB3tF9A7JSRUW/gXybRh8UsIPwaepiPiz9uCUPzh
         GpYtAA96pdZWhDkGF+BkrkZeWJVhzscqzKPtUIYl5i4z7r8pLAo5Eu3SoiAsLcvTAIPm
         gfTRNWTD9nKth+vctPNhNqeOYXZiAJj7T16WMARA0PWAoMufTcSav7oQMQxpS0OVWTr0
         +Xtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789938361; x=1790543161; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTysyvua/pHRkgj+3i2IdhzgN1OTX4ZBg0dHDR1pdSM=;
        b=nSOxkM9JY1Z0ohaPKwTsn+k5xano2MO+n08zG89cj6M0z7oHEoMkRR65XFqyodrQrI
         1GHGgAVx4fyuhvrZ05D75VKAhBgjnREcnAcQUklEQKaQxvsAbYnYJ+3GtpxBmA+xp0kE
         9d2xLtZAdurv7izJB3iuASAWXac2Cs3FTGsDfxnm3F18uI0tfSi+9g9KzdffChmlrtfe
         5/14ZrjahhULURFseJrKIyol7GvtvAwh1VariMbFMjLA7ZEMwhZDen7P1V3RANv6dVvu
         D1yF9Ob9HxA9/ZlW5VKyayGX1VBuMkQ+nMG4aHXgZO0RTG8mms1i6bFMPmuQTVPV3sZo
         0MOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938361; x=1790543161;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTysyvua/pHRkgj+3i2IdhzgN1OTX4ZBg0dHDR1pdSM=;
        b=aeDSSAg58OgUdAUzNaIV3jOpYzoA3xXkNsS8GUoeFLdJ2ahriQ0h8jOGRfO2GeL/XE
         uy5ztOBQvkymXY7erbFpV/0esSSGC3nUrbEEyycd2jNu15f00ec6vsHon3lauEtCYCSQ
         VghpQi+gT6pu1ATygW9+1/uLcL81lhQvHG5sEADqOBRagtq7eGcmhGKj8pIYFlseXJ30
         fJJvujjJKxBXe5wwqrcXjHSoeExtOUnGI2oh0ETT3adr3WJ7rv4YS25m3WuJmxDlAHUb
         pCWjEZ2CV6I1JgytfTnF4z4ta/yHAR08+p5/HAHynQVlCmSUPRyftcLyzM11id/M1aMk
         roBQ==
X-Gm-Message-State: AFuF++mrfT1jKXLuT98PjLiTpL6HSlkhDR0RKo9G8jaT8Qx95f9PLWUm
	86cqvR8Hg7RNepCjl2CLdDsMs6HTVnTnoscDG5NuymFCXAUJjq0wRdP5DlwhirkNSUc7qZ7aVRl
	dZ0litBhaf2JhvHFwWvwLy1GH/hZUll5bm1RmEOWUboC1z4Do9cvmQEjjfTs=
X-Gm-Gg: AYBFou1DawdTkzf81arcMPmosWiZXkPoi66n2LqPXBwtkKOHhXxWiCkQcXL8TCbzy2h
	OOg+vMgotrlTqjbUU2SeQ6gy5HW87NYVjOt9g008NPcRqMb9pE5R3FYcj3ft0qZO5PFBFITwdNF
	4yCI9qtDM3CztRv4cXI12TyAa/d2MYlVxEollppxnCM0cawHjnU2qKNPO2u3Gy/pGONmvM1u6Zd
	X0+FOaCJfa4+LRlbcxwbUITcgRWfgB8tKRbr7FwqG1IjK3Gf7Krz2/Oaqpz9rNmOOvcClz6VmAc
	dGIxXqOjh8uYy8pGI5R+hZOCokWrQzYFZxvb89j25jEsL5YzM5e2QfnNOOzpiSn6+y6MJ1/EhXU
	Zq2yAoQiQlEVXOGpbo+pmgwMG2CpWJI2ywlKcsFy4zWQJe/jrHNv5WMXKzfuOB0wkB8k=
X-Received: by 2002:a05:6402:23c7:b0:6aa:4529:4cb7 with SMTP id
 4fb4d7f45d1cf-6aa53135128mr6241277a12.16.1789938360721; Sun, 20 Sep 2026
 14:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-4-kuniyu@google.com>
 <20260920201152.8CED21F000FF@smtp.kernel.org>
In-Reply-To: <20260920201152.8CED21F000FF@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 14:05:44 -0700
X-Gm-Features: AcwNN1VEogJIW5LP6aFMhmS47H4x3mFx-fob5a_vGfNv5ifJJNAKN1ium1p3ZmE
Message-ID: <CAAVpQUCXjzvPo868ygwA8-xzyYG8woDqSHpHctTB86i9WR_QSA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/7] bpf: tcp: Support bpf_sock_ops_cb_flags_set()
 for bpf_tcp_ops.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 1:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] bpf: data race in bpf_tcp_ops_cb_flags_set() on unlocked sockets
> --
>
> commit 56d7f542a8c499237807954e17f2fae35e5e276b
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Support bpf_sock_ops_cb_flags_set() for bpf_tcp_ops.
>
> This patch allows clearing or setting bpf_sock_ops_cb_flags via the
> bpf_sock_ops_cb_flags_set() helper within various bpf_tcp_ops callbacks.
>
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index c68d1fa323058..6d0452441b6c5 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> [ ... ]
> > @@ -220,6 +220,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval=
_proto =3D {
> >       .ret_type       =3D RET_INTEGER,
> >  };
> >
> > +BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
> > +{
> > +     int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
> If an unlocked socket is passed to bpf_tcp_ops_cb_flags_set(),

This should not happen.

The hook is only supported on hooks under sock_owned_by_me(),
and bpf_tcp_ops does not support socket lookup helpers.


> it looks like
> concurrent updates to the flags from other CPUs could be clobbered, causi=
ng
> BPF TCP callbacks to fail to invoke when expected.
>
> Does this code modify the socket flags without acquiring the socket lock
> or asserting that the socket is currently owned by the caller?
>
> > +
> > +     return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_tcp_ops_cb_flags_set_proto =3D =
{
> > +     .func           =3D bpf_tcp_ops_cb_flags_set,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_BTF_ID,
> > +     .arg1_btf_id    =3D &btf_sock_ids[BTF_SOCK_TYPE_TCP],
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: High]
> Since the verifier accepts any PTR_TO_BTF_ID of type TCP here, it seems
> privileged BPF programs could pass refcounted but unlocked sockets, leadi=
ng
> to the data race mentioned above.
>
> Could the use of ARG_PTR_TO_BTF_ID allow a BPF program to pass an unlocke=
d
> socket obtained via helpers like bpf_sk_lookup_tcp() and bpf_skc_to_tcp_s=
ock()?

Same false-positive.  bpf_tcp_ops does not support such lookup helpers.
