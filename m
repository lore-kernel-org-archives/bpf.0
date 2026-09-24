Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6C4119F9
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 04:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223051; cv=pass; b=OlEHjwOarc26lAoibcK2fq2zkd/Oy34XszyxAmAU9bO0Wpvkg3wGGyxLKJyPCAqkkbaUMLXxCPIZqcheHYHJFsKz0PnKK5d3ulujmrRbDcXKZHdsfQxoNWiXcvf151qN5K55mcMSIejLQVxgskP9XuVvozLmz7JcM2KRAxktxFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223051; c=relaxed/simple;
	bh=OY16eW825/0zzI0jWgFlw8UIWOwP4TT9m8DqFhegVQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGBTEckug0uK64D4r4T7+UOEyl/xpLtBqGf6VbwEnxd8KzZcqfNz0rc0HRYAa2fYLopk+q2S9XwUahUMVkMShjTKAMN0l1myxRxGZRPtOhw1/t3ovOB9RtZGhdPh3iECYecj7x6suRcBE0sz+sAZ8msAfmUr4XH4c5l3nECozbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z811ider; arc=pass smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z811ider"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144df39b6cfso1197809c88.1
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 21:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790223049; cv=none;
        d=google.com; s=arc-20260327;
        b=q4B6tDmAff4+fslYADZGfh//MvYNn1gIGQkIsaZJUC3k08948P/JVInCLezv8deQGX
         VTmllm171NIJWl94xt0aVzg9ZfYla4BJ2TIvoP7tCV0xrMce3KHInWzImsh5mGQobxlL
         uCeI60WL5syW35LKKxNHONVBP5g0iupoV3oFY8+DZy91BU0SWQXYYzy8bB3Plv0MlHH5
         9GbnlXdIqSnw4VJSpz/KktGqkIZlDq0LNiv10/nfUDntKHWVdPrzbWlPjvEShE04ZgDL
         ayw3xmCpaT2i4BygJ0yBhlsMpI4RvBcK6haa8tdLaeIkL1JovgYC/uDI/WlGDGc2Qmxp
         cs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        fh=gijAOO6OuSZJtgENSXEp96ACISZ7Z3k5OD/LCceIjRc=;
        b=ijrINm2y8gNuuUeIo//di4GMTXknFASHxwedI5ZOpv5UR+vinBbxzd+01d4qtXH1lf
         Tl8Ytz6UfSxbMenpnF9BOc1GffO3Z6KJBDKDyCqqOPFYvgemwIvIA9Vc9X0UY1cD9ECy
         fwkVh+w/QFXVT1S4YLhkertIl/o/TwrJqmJ88T1tn8b4ar1ckxhpJ04FHx3Em0NUP20h
         plPbHBc5EFvdGUGixzkERYEGhiyuTDNM8AlQK4eLlq59hUOTm0WaFxqco3+bp+gjaSyu
         bEBkR0AbQts3Fzu3oF0RfbEJv1n8VS7oQuMLU4a05D/bkzQ+f6zhDwVhR1iGE1GRiMGf
         b31w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790223049; x=1790827849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        b=Z811iderKhZQwyx5uVDJOn4e9BytOCI6kwJPWNF2tBdMIX/kjgwi3p82GhaxlHCHUx
         enf+HS42pSxG1YG18GAvgBR3L7xbHNQHgUbZTWQ7lpi5LDonwi+uY4HsV6VbPBh9Zy3F
         w+YTQGfcHB1j8qWqzKJjjhA4tSikQgVLLJOUPWNDqF/ygQMS9s6lZqdM2jeOCvosjh9l
         63wvkL2Jy+0Dct3+jtsWquGTJf+nIUbSxj0NSPXQqDZtP/tKP5GguRJkcKv5QD72+/u5
         n5/mq1nP25DtxcE8JXsab6Aq3ItLjtfVHiAmaL76qTYVKujWy0gbKN87dEJ97Flpq+OL
         heCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790223049; x=1790827849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GS5obY1p7B2nbQlfsPiLBUctJugKJ38DpZDAW2iqf7U=;
        b=FjPZzyN3ZCvprY0p1fkEnGuhvMWha74MxZk6vMwkfrebCOlLijdXvUQOJrw8VEb0As
         6GQbmlSSWCg0/VwKX+CiNQ7ubPEG2K4tx7ES2beap9FNSoGLZb6lzMqs/MKsSHlusIf5
         DRtL3Crx6HsEe6hBRcNgeF0bw1t5jSyhIENCogVwI1BDdF74sKWlz64jr2m8oCq40mxu
         yEBZBK4MC5jkcCf/U5uRsqzwf/p9OahgqbdJl84ty3A80peXfSiwrj36fQ2o6XCKAHwt
         gQLxwg1CXtof/Y53gc/7s+PafePyTGfl0xEDNOHtMIuIeYMZZikbVUQX4Ni5nsbPk2RO
         9GlQ==
X-Forwarded-Encrypted: i=1; AKwUvBw4W3YZX/qFzS0QMJrBS6L6TKQj8YHshOmUipEq7XxO5XrgSG3NILREQvyXb0ZrmRySCYQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lJOknIJBGr8lDPzohG6Ct/FC7mEa6vdRY1CIjoKDSRUNXP1OIj
	30IhCcAZgBKqhf1qkG1+JMq72JpKJ+isSkWknyFirhTZp1CgLn7RE700s01llzWwL5x+yd3A8ZE
	oGfuflqJclsXaXoISAR/JJyEJAZ2ViE4wFZWCS36i
X-Gm-Gg: AYBFou0gz85PSqPdWh+oQAdFhhfZ/+GVVRc599UrkZzVUNNmvywR+VPlgdX/LZoezYn
	EScAnW44TwAd4SdLd9KWaNjzBFQy3HIF8GSEMKFRltsqqmiUCQtrI+QCAP3KUczyNW80sP+CYve
	3KGAh2CvJvB3Tp6xBVisV2zc/cVZpGKLvPcWTk5pc9apIQgumb2DWlRe2dPMGIw64hIarHKxSVs
	OESNqxc8R+xi+7rh8Wx4/npdugOMGe+YKkTxoaLA+YdZgi1YIedmWTAV471EluePlrYFs6bNxNq
	i+4QpQffx5t/Ww9GOmUX+U72/Hq1uZ6buIr0RuuSnI/zyy1calIMmedY73hHRnX/aqVyo1orYAp
	SXtM5EDjBA53GtX0QsFbPVB/yvg2cWW3h+AeyaSnKhrMUmRNGx+yGYemX/4/sl7/HbDeoHbjIjW
	fQgJ2TNji3Qt+W98beCmDfjlfN
X-Received: by 2002:a05:701b:42c2:20b0:145:4d:5abc with SMTP id
 a92af1059eb24-14503f84ff3mr920212c88.10.1790223047852; Wed, 23 Sep 2026
 21:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-7-kuniyu@google.com>
 <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
In-Reply-To: <DLN8MMAY53A6.31EWYOHJ1YWLV@etsalapatis.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 23 Sep 2026 21:10:35 -0700
X-Gm-Features: AclHuK_rQysdfujvjch6jsLzKg2dWxuawnvJ_0QiW0wm-klcapEkEeN4nBG-uN0
Message-ID: <CAAVpQUAwHL6NJS-kA0aE_Fcn1wcp7qRjZoTaTqbmMbTED6RFFg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/8] bpf: mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB_FLAG.
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:48=E2=80=AFPM Emil Tsalapatis <emil@etsalapatis.c=
om> wrote:
>
> On Wed Sep 23, 2026 at 9:35 PM UTC, Kuniyuki Iwashima wrote:
> > The next patch exposes a new kfunc calling __tcp_set_rcvlowat()
> > to bpf_tcp_ops.
> >
> > MPTCP has its own sock->ops->set_rcvlowat() / mptcp_set_rcvlowat(),
> > so we should not allow calling __tcp_set_rcvlowat() on MPTCP
> > subflows.
> >
> > Let's disable BPF_SOCK_OPS_RCVQ_CB_FLAG for MPTCP for now.
> >
> > If needed in the future, bpf_tcp_ops_set_rcvlowat() could be
> > extended to properly support MPTCP.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/tcp.h      | 15 +++++++++++++++
> >  net/core/filter.c      | 10 ++++++----
> >  net/ipv4/bpf_tcp_ops.c |  5 ++++-
> >  3 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 07426e8641b7..d3cf655da9ec 100644
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
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     return 0;
> > +}
> > +
> >  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> >  {
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> > @@ -2954,6 +2964,11 @@ static inline int tcp_call_bpf_3arg(struct sock =
*sk, int op, u32 arg1, u32 arg2,
> >       return -EPERM;
> >  }
> >
> > +static inline int tcp_set_sock_ops_cb_flags(struct sock *sk, int val)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> >  {
> >  }
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 5feb99884682..f29c061bb066 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5588,8 +5588,7 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk=
, int optname,
> >       case TCP_BPF_SOCK_OPS_CB_FLAGS:
> >               if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
> >                       return -EINVAL;
> > -             tp->bpf_sock_ops_cb_flags =3D val;
> > -             break;
> > +             return tcp_set_sock_ops_cb_flags(sk, val);
> >       default:
> >               return -EINVAL;
> >       }
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
> Afaict the tcp_set_sock_ops_cb_flags is inconsistent with the previous re=
turn values,

tcp_set_sock_ops_cb_flags() already returns error when
something goes wrong, and this is just a new validation.

The intention here is just to ensure, in the slow path, that no one
blindly uses such an unsupported combination and to avoid
unnecessary validation in kfunc called from the fast path.

Note that enabling BPF_SOCK_OPS_ALL_CB_FLAGS in the
program is clearly wrong, or it must accept that it could break
when a new (opt-in) hook is added.

So no one should stumble on the new error in practice.


> in that it returns an errno instead of the flags it couldn't set (it also=
 doesn't
> set the flags that we can set for MPTCP when BPF_SOCK_OPS_RCVQ_CB_FLAG is=
 set, which
> is the convention of its callers). Would changing the error path to
>
>         tp->bpf_sock_ops_cb_flags =3D val & BPF_SOCK_OPS_RCVQ_CB_FLAG;
>         return (val & (~(BPF_SOCK_OPS_ALL_CB_FLAGS ^ BPF_SOCK_OPS_RCVQ_CB=
_FLAG);
>
> work?

Regarding the consistency, this is rather inconsistent because
previously any flag in BPF_SOCK_OPS_RCVQ_CB_FLAG cannot
be returned.


>
>
> >
> >       return argval & (~BPF_SOCK_OPS_ALL_CB_FLAGS);
> >  }
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index 4b48711d92a2..b0cade34cce6 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -223,8 +223,11 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval=
_proto =3D {
> >  BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
> >  {
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > +     int err;
> >
> > -     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +     err =3D tcp_set_sock_ops_cb_flags(sk, val);
> > +     if (err)
> > +             return err;
> >
> >       return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
> >  }
>
