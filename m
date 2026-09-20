Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E99394496
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938567; cv=pass; b=XBSeGweO9e/JkaAJM+fNNhjUHNiLD/WjPTiH3HlM1DHVloJmFb9fKCSXgcHTTntb5cNSkIxiRd949dzbzP6qNra0BuYZvh5ECUFlvrN0Nff3AFBd9wgXhZfFTr/V9hOv1g95kUJRWgbOCZLZPr9NzS4ZFowfc3BB9Z+XIkRhh+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938567; c=relaxed/simple;
	bh=kt+rv5k3eLDWYabDgymlVriZ9r09FN0YWounlJrDsaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IP0TdeSs1aJjGuzgtl4PPqnQ3BeI13Dc9LaQY27fubOdoDwELR6P9pFgCDsI5ZkZah6DuuUGJ016arLyUkvD2TnF21uF4Y1lm2iyivHSR0XjBDPVXhl/XShwvgD+18C3AixG0IyCMNvjPCvU7IFW9B7dIU//dwecoKjWe28/ITc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nApsssJy; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nApsssJy"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a803458ba0so3027619a12.0
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938563; cv=none;
        d=google.com; s=arc-20260327;
        b=NgGqS3ai10Pzzo7IUK66Pk2zu3JseZI63ZvU7P5+GluCMhPOceU1OI6rJIHe4W0irt
         G7uSAA5lttKULBxJfXDUuMx60e3PI18PGDgf0KBfPYjMtBl1Ag6zwNGCeSLcihdA3weF
         6s5p1D4qxoctocr8jJEgKRQVRZdXX1NFN9P3vWBJ7DmTQ5RRRBSWbBUIkzCAdfgw7G7J
         u17eU1LZJ3m35VtxbhS7nMwurh1aNzJPiHLecs2fIo3Tv4S7dfqJ8UtbWst8f47R4556
         soMOchGakdgSUTeKuFaU80x23ryOZH29DjFlUbqSHjDxO1Pq8Vy9b7+j0K8XRjH6zQLF
         w3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aG9IMXzuXxs35bjhn377gOMi4c4fmeb2RQf/8lDCjFs=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=h0EgIPeRoVqJgyr+ER/kDd8obHE7mXdldLvR7tH9Q/+2b4mKFcRyKyWJkuIzqBJ1ut
         bo/cM3u/purhy4qwBrgamWN3pgkvSCUkpzP6dHQ1TTzQAaLCLGAko9JO7SWdYzGBLPqD
         8qmsmJRjBn4hQTLaCMzkuofP5eWSOlLqlJUuW1HRsHgdyC5dbS0CckFrUlWtw9jBAjXq
         2HSm9m8Q47wbV3cWyQYyp90eePu8ZRRdMmhSKlS8p3wnf6B7x0xrf0mlZ37R+GH5faxU
         HVdqr/kA4m3UIWZyUjm4T1m/jMqAI4nIwByV5K20w3VrILGoPyf4PZ+buTugD7uVeqKJ
         3/dw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789938563; x=1790543363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aG9IMXzuXxs35bjhn377gOMi4c4fmeb2RQf/8lDCjFs=;
        b=nApsssJyBSbzOx5w675nGYtfXvLtdKTc5Qg9CyCHqJgiKvaXMOWf4Qbv5T4SIFRmbl
         Ly4wULprtRbaNE+ufaewaNt4MS9s60pNXzKazaoqhHFyKBaoY67uYlznzo//NgtaMGhj
         +lQ25Uh1dSiyMh/uq+lX02Vq+orpj+rhLXFTfoEcXd9mGQnGSyl1q4OBOaQOF7wndGzF
         vzFtDUcMf5zQqxCmSKCNMO0juwqGfj6mvCRdfTveR5xr5m0jdlDMH/1EH/DN3gNGwws9
         kj6xpM17lTGcyB3o5Hl8PQSRrecjSyVKkIP3Ajo6m/OpFwlkIa2/1wfRBZ/qbs5H08nj
         uknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938563; x=1790543363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aG9IMXzuXxs35bjhn377gOMi4c4fmeb2RQf/8lDCjFs=;
        b=KDcQrHiLORfHUrajqgHFslMjoVAQnxZmwQCnY9kPjeMpPOyewFv2AlWigV517poMKW
         jqgWq13HSrUzHJIZBjT/8kgL2fkhLN+I4vpve06hm2MhjtfJZkwwhkfG1xgddmm2A2uI
         MieMNJHu42e8qKnXPZWPvb1ZKfwWRczJl4YBZ2XwwTH+NPgDkPze5WvTzzKyi13mqWfY
         Vn3giZbzTDnAGfwCFkx9bT3dT4JoeAu6Og07r6B2d5cNYbtTE7nKoTtu5I9Ww6XUrKLl
         +rEvywx1Sq096L4o6SYgwYJ/kZVxVvdk2ybbazS47S20jCkr0158Evx9tyUH5zGxC5Q9
         ONAg==
X-Gm-Message-State: AFuF++lkfQkjtntQ3tOk8mX41vPiBqVVRwukZlTurvcYghKfCd7nLt6Z
	xqK5BtBT18X6cQY3IrbwJaoXqqRLJYQr0qOrLBb9KmJq7et71hM//ZBpRZFBkHND5VMZi/rKd7w
	lwxUfpuNPP+NmFN4K10EUlo4LQtDBAjPuRLPHoBwXCxeAbicciE102ZsCATI=
X-Gm-Gg: AYBFou3wDkFhBMM4BArZSzbWBCjheoCZ/1kRfzo8GeiKnwBywLWJnyqNpnApYRW4y0L
	8E1i/GXn3iOUCqafyVEsarZdFpWQi7iLnPfkkFo8CLj/E8MDcfy9XWHy/CMejKUpJrPyvk0C94i
	/oZNOr5FKk4LtJo3kvbrMoc1bNi7ZgrenxXvFONV8YUd9N75wRa98kiMcww5a/yp100waLvym6Z
	YuyAgLXPE6/oBdZMnL5UzyWFUGTBfRaOXarq+f+0lUTkJitB5ez/E3wo/memV/iRwq2r5E18QcA
	/C/bvPxJVH5klZ/9JBqSbKoASzu6Vf77UY8Tu4/hBwqRBs9wSx5wxH5G5KHvKLWXgZwz4e92UAp
	TYgYk9CHjilUdftbZK3Ok3s+nGDWgbZ3p+Hu3oXs0sv7vUGtrJAgukIhs52B2O0zZArA=
X-Received: by 2002:a05:6402:52d7:b0:6a9:8dad:f351 with SMTP id
 4fb4d7f45d1cf-6aa564cf5a3mr5500843a12.39.1789938562315; Sun, 20 Sep 2026
 14:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-1-kuniyu@google.com> <20260920195633.3033620-6-kuniyu@google.com>
 <20260920200548.E18441F000FF@smtp.kernel.org>
In-Reply-To: <20260920200548.E18441F000FF@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 14:09:06 -0700
X-Gm-Features: AcwNN1W8dHp7vjuLuHw_rdApVjuYf5gpqSkoLbV1SL_ByL7U_KaMKWGKzwIk-RY
Message-ID: <CAAVpQUCyt8XuxET6eYhOKbkHitkb15yYUaRQHdXAx_EBZMr3QQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 1:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] bpf: tcp_set_sock_ops_cb_flags breaks ALL_CB_FLAGS for MPTCP
> --
>
> commit 578335638acc4a540df534d791edf9c63d563e32
> Author: Kuniyuki Iwashima <kuniyu@google.com>
> Subject: bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
>
> This patch prepares for a new kfunc by disabling BPF_SOCK_OPS_RCVQ_CB_FLA=
G
> for MPTCP subflows. It returns -EOPNOTSUPP if this flag is used on an MPT=
CP
> socket.
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 07426e8641b7e..d3cf655da9ecd 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2932,6 +2932,16 @@ static inline int tcp_call_bpf_3arg(struct sock =
*sk, int op, u32 arg1, u32 arg2,
> >       return tcp_call_bpf(sk, op, 3, args);
> >  }
> >
> > +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> > +{
> > +     if (sk_is_mptcp(sk) &&
> > +         (val & BPF_SOCK_OPS_RCVQ_CB_FLAG))
> > +             return -EOPNOTSUPP;
> > +
>
> [Severity: Medium]
> Will this check unintentionally break existing BPF programs that use
> BPF_SOCK_OPS_ALL_CB_FLAGS to enable all callbacks?

This is rather a userspace problem.

BPF_SOCK_OPS_ALL_CB_FLAGS should not be used in such a way.
The flag is to be used to opt-in hooks.



>
> If a program passes BPF_SOCK_OPS_ALL_CB_FLAGS (which is expanded in this
> patch series to include the new BPF_SOCK_OPS_RCVQ_CB_FLAG bit), this rigi=
d
> check evaluates to true for MPTCP subflows and rejects the entire multi-f=
lag
> request instead of ignoring the unsupported bit.
>
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     return 0;
> > +}
> > +
>
> [ ... ]
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5feb998846825..f29c061bb0664 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
>
> [ ... ]
>
> > @@ -6178,8 +6177,9 @@ static const struct bpf_func_proto bpf_sock_ops_g=
etsockopt_proto =3D {
> >  BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_=
sock,
> >          int, argval)
> >  {
> > -     struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +     struct sock *sk =3D bpf_sock->sk;
> > +     int err;
> >
> >       if (!is_locked_tcp_sock_ops(bpf_sock))
> >               return -EOPNOTSUPP;
> > @@ -6187,7 +6187,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> >               return -EINVAL;
> >
> > -     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     err =3D tcp_set_sock_ops_cb_flags(sk, val);
> > +     if (err)
> > +             return err;
>
> [Severity: Medium]
> Does returning early here prevent any of the other valid callbacks reques=
ted
> in val from being enabled?

Same, this is intentional.

>
> Because tcp_set_sock_ops_cb_flags() returns -EOPNOTSUPP when the new flag=
 is
> present, the BPF helper propagates the error without applying any of the
> previously supported flags. This effectively turns a wildcard request for
> "all supported flags" into a total failure on MPTCP subflows.
>
> >
> >       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920195633.30=
33620-1-kuniyu@google.com?part=3D5
