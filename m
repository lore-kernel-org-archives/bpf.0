Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307041F7D4
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 18:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361534; cv=pass; b=bpj+rfG/BXLjTDpIcXFG1GPt1NHQuXis0AWsWtIigmT6o3w5ZvPQ96VGXeuo5EXFvlQFgszevUDJQBh8+wDC/s4K7hQJStygdOcYx20OlQfXxgOl6vuyWQ1uaztLLlaLQPizGwwPsb5MICMVou1gK795OF5Wu5UK8enZegGGsyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361534; c=relaxed/simple;
	bh=yiA+n7/p+x0XswDYuq/psbx3K499HHj0wTZI2TToCVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzT8ENo/U1mhws9325Tjd+T93HpB5rx519pzqVziqUO/Wu0O30gkmILbiLeyLbgyjxqnmhLNxaS94UYvvYFX2vaDfvkKwOE0ndmef1/Gsxi8+CM33eS/kUHY2rw1DxnaHASaqP178MEpVE/L1S+Tp0YYGyTVcwFvUNL8R1VYb80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZUgrndq; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZUgrndq"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664bb15d05dso4634559d50.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 11:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361532; cv=none;
        d=google.com; s=arc-20260327;
        b=LrQABJi3guoi83LiWnkoc37i9zlnKS4Ep5WsWzJGWoyhqEezJnt1cCuRDxL9q/Xt6U
         4p2E/nyhW2nm2F3VFzQPOul+CEVwQT3Qs+CfexWnNsLfOurX24GVXyzY/8NBuexU0xnS
         iTjh0R6dqwuyKHd0/zhROIDe3FX1G3WW2I1c9Goafr7NT3Rg+XaqFnXcWchflnar/IlQ
         Q7l3AFzmPQV3XKKlDvQ5yCgT44MgVoDNoTSZE+IZzowR3tjEqZSLNSRO9wVJ0+FQl3aq
         Q7RvKDdFJYJ6a5Mm1AdFEQPnSxUgNGsYKyZ4l20lTOB/8gRNuD4LSyPuTMZe/WKzTVx3
         Q+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WOW5B8HB09NWaWZjxdzfciyn9Tp1/iVKci05x54f4+k=;
        fh=btPKo7YsCbdbIVoDN7YphrazC+uxmUnpbp5xBdp5prw=;
        b=URPIU0fXCxsPd5In84Anmgqjr5i5ejEijt9Ymy3o6ARl0Cby1c4ufjYSRqohOM9qgu
         2cs0LVPWw6ZAWdIK1MKQJL9ej9hLEgcYr8UKxUM9nqUa5P4rzZObbcT8yt/ckg3p1dZp
         ErlEw00DseJ/DfcnkNpmzMwx+up8h3KYaKT5aBf12PTsl+pSSVMF3RtoF/+MhlcLHukL
         11OD3Peh8BajR449lcrRM6k6Iv+qzSzO+EzbuDQcJXVK29eaQByxuWEW7M32kKVlzbRM
         H9FUF2/WIiPe85k7fCyMlK3yBExrtA2Y54A2xVz46js+FD7oxV6nT7ZAt7EZXR7iq64y
         GkNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361532; x=1783966332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOW5B8HB09NWaWZjxdzfciyn9Tp1/iVKci05x54f4+k=;
        b=KZUgrndqpAkYckKZQAo+3NIwLael5lgRf9BWFnh3ZbW7x/yMWcqBb8jQxgA9m+lCfK
         IBA/oY+7C5Ju3YLS9MKFCDF67fgKpzG8VxiORnZ/8CwvMsF4oB7liATVU9cMvG7ktFZB
         eoun5dnLx9FPaPMocghbl5fXm7x6bW7irfyj1u6VEfDWMmM7Sffhqryvkueb/BAw+Dys
         gtK/onW+29lOnml8kv7kcfsGMVEutXtdgjaPyOAdBBeDEBZkQxPHmMvDQy1SEn4l8ufT
         sk/vFAHrNMuj7oWDsXwPGaWZmwbQEa4FB5wMl0osjbwPdHbAnbKVN0HH5ljrF+NRJCnr
         b56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361532; x=1783966332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOW5B8HB09NWaWZjxdzfciyn9Tp1/iVKci05x54f4+k=;
        b=Nw17fp4gNFlktWfeGfCjfeoy7Jsq4cue7XlPX459G8A/wogARO9xRMrgXrHx/E9YvF
         PVGql+esnlJctm8u4gYwtappNMGW7tgWBsjfNgbVaasJSKPwH8uTeIOKxn01ZqF3r7dd
         E/mFReEgHlx3hWdJDVib0/DwK3dgyOzVnd35EccCz+MkLdkn/h79QHp+eMMKOxDDeBgD
         deC3+tdUbY7Y7iQmRk/AtZvRFcZd1cjycUh0aXRGlnZDGHaHUZ394EoKB/6fkD0q4Wjy
         EMRbQ5MkE5+PPVJ+PzQIWEVKYiSZ0ZYoBgRKyWcrcmeApvJZFMA09tDP9jnZh3i21IQY
         6scg==
X-Forwarded-Encrypted: i=1; AHgh+Rq6BA4knxz4Ocpo7mBhPSTTHcRh3p3fe1+929hwR3MhGX3GWa8N/wQSlZoDZmO/2IjQKUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHR5ZHf5m0ccLCaM6lWaKRUjKWweT4qn9JnGy0z48S5iWglH2
	DdgzCfAvV6ECZ5cph1YMf/hUx0ckUbTzj7EOOng/wEV/giwXEQeq4YVVJ2z6vwRaiUFk1v0HDUn
	rXf4ri+e2wnilVVa0DUrsVBhOR2UvVVj1kg8o
X-Gm-Gg: AfdE7clzCtS7OTMTXBsAr3uqitjDiFCbDQJkRUHrtACiIPYZSm683ZGsw3ClaRXYCMV
	/FBTMCeaUJ5BgdgxsoHXd1fHwz91z35vBUXwTNhu0CdV6j+npRU5N6M1xW7vu01jOEtE46R+C51
	SZZiIBP56jIcATeuLtYtH2UVJYEPoGb9baVOHyBBRHEWxSD+8vegSS8N5MHFwrUEmQv0Zizl7Tw
	zieueqA6G5BQwu3/+a/pAp8FhVslaJWJvX+E+9MDXg4yPtAA2rnc6qNVrYQBp40NjH4ioswTOrk
	Y36wwdw=
X-Received: by 2002:a05:690e:4842:b0:664:cf93:40d5 with SMTP id
 956f58d0204a3-6677fb7ce06mr1083778d50.31.1783361531427; Mon, 06 Jul 2026
 11:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702224519.800135-1-xmei5@asu.edu> <20260702230504.0E65E1F000E9@smtp.kernel.org>
 <e6ec128e-1acf-4dc7-8884-e4d7ed14d25b@linux.dev> <po6jpmx5q72uvblx23atsbwvxhoszpmrlkjd6txljljufnjeqj@v3yov32574sm>
In-Reply-To: <po6jpmx5q72uvblx23atsbwvxhoszpmrlkjd6txljljufnjeqj@v3yov32574sm>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 11:11:59 -0700
X-Gm-Features: AVVi8CcfvnGrpK11jF1WTN0KSLfHGDORby9ZO5VYKuT9fxtIDga1jzrdHDerLjg
Message-ID: <CAMB2axN8r-B1gc4f-BSh5d=VFttxGLu+ubB_53nzpAqvYd0HVA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
To: Jordan Rife <jordan@jrife.io>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, sashiko-reviews@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 10:45=E2=80=AFPM Jordan Rife <jordan@jrife.io> wrote=
:
>
> On Fri, Jul 03, 2026 at 10:15:27AM +0800, Jiayuan Chen wrote:
> >
> > On 7/3/26 7:05 AM, sashiko-bot@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 2 potential =
issue(s) to consider:
> > >
> > > New issues:
> > > - [High] The patch causes a functional regression by completely disab=
ling bpf_sock_destroy() for TCP mini-sockets (TIME_WAIT and NEW_SYN_RECV).
> > >
> > > Pre-existing issues:
> > > - [High] The helpers bpf_tcp_check_syncookie and bpf_tcp_gen_syncooki=
e suffer from the same type confusion and out-of-bounds read as bpf_sock_de=
stroy, but remain unfixed.
> > > --
> > >
> > > commit cf46da8728e7f1fca4584ccdb089c82b7fd3061f
> > > Author: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > >
> > > bpf: reject mini-sockets in bpf_sock_destroy()
> > >
> > > The patch tries to fix a KASAN slab-out-of-bounds read in
> > > bpf_sock_destroy() by checking sk_fullsock(sk) before accessing
> > > sk->sk_protocol. It casts sock_common to sock and early exits if it i=
s
> > > a mini-socket.
> > >
> > > Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> > > Reported-by: AutonomousCodeSecurity@microsoft.com
> > > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> > >
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index b446aa8be5c37..3e70c8ab5aab1 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct soc=
k_common *sock)
> > > >   {
> > > >           struct sock *sk =3D (struct sock *)sock;
> > > > + if (!sk_fullsock(sk))
> > > > +         return -EOPNOTSUPP;
> > >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > [Severity: High]
> > > Does this unconditionally reject mini-sockets?
> > >
> > > The commit message states that mini-sockets have no diag_destroy() ha=
ndler,
> > > but as documented in the original commit 4ddbcb886268, request socket=
s are
> > > explicitly supported because their protocol diag_destroy handler
> > > (tcp_abort) correctly handles TCP_TIME_WAIT and TCP_NEW_SYN_RECV stat=
es.
> > >
> > > If we unconditionally reject non-full sockets, wouldn't this break BP=
F
> > > programs that rely on bpf_sock_destroy() to forcefully terminate pend=
ing
> > > connections or TIME_WAIT sockets?
> >
> > It's true. Please also include a selftest to reproduce the issue and,
> > another one to cover the non-full socket.
>
> +1 to the selftests.
>
> I'd just extend tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>
> Considering the original intent was to support request sockets and time
> wait sockets and tcp_abort already supports both, perhaps something like
> this would be better.
>
> __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>  {
> +       int (*diag_destroy)(struct sock *sk, int err);
>         struct sock *sk =3D (struct sock *)sock;
>
>         /* The locking semantics that allow for synchronous execution of =
the
> @@ -12672,11 +12674,16 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_co=
mmon *sock)
>          * Supporting protocols will need to acquire sock lock in the BPF=
 context
>          * prior to invoking this kfunc.
>          */
> -       if (!sk->sk_prot->diag_destroy || (sk->sk_protocol !=3D IPPROTO_T=
CP &&
> -                                          sk->sk_protocol !=3D IPPROTO_U=
DP))
> +       if (!sk_fullsock(sk))
> +               diag_destroy =3D tcp_abort;
> +       else if(sk->sk_prot->diag_destroy &&
> +               (sk->sk_protocol =3D=3D IPPROTO_TCP ||
> +                sk->sk_protocol =3D=3D IPPROTO_UDP))
> +               diag_destroy =3D sk->sk_prot->diag_destroy;
> +       else
>                 return -EOPNOTSUPP;
>
> -       return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> +       return diag_destroy(sk, ECONNABORTED);
>  }
>
> (Note: I haven't tested this)
>

Looks correct to me but I think it would be cleaner if we just guard
sk->sk_protocol with sk_fullsock().

-       if (!sk->sk_prot->diag_destroy || (sk->sk_protocol !=3D IPPROTO_TCP=
 &&
-                                          sk->sk_protocol !=3D IPPROTO_UDP=
))
+       if (!sk->sk_prot->diag_destroy)
+               return -EOPNOTSUPP;
+
+       if (sk_fullsock(sk) && sk->sk_protocol !=3D IPPROTO_TCP &&
+           sk->sk_protocol !=3D IPPROTO_UDP)
                return -EOPNOTSUPP;

> >
> > >
> > > [Severity: High]
> > > This is a pre-existing issue, but does this same type confusion exist
> > > in bpf_tcp_check_syncookie() and bpf_tcp_gen_syncookie()?
> > >
> > > Both of those helpers take ARG_PTR_TO_BTF_ID_SOCK_COMMON and cast it =
to
> > > a full struct sock *. They then immediately dereference sk->sk_protoc=
ol
> > > without an sk_fullsock() check:
> > >
> > > net/core/filter.c:bpf_tcp_check_syncookie() {
> > >      ...
> > >     if (sk->sk_protocol !=3D IPPROTO_TCP || sk->sk_state !=3D TCP_LIS=
TEN)
> > >             return -EINVAL;
> > >      ...
> > > }
> > >
> > > If an XDP or TC BPF program passes a tw_sock or req_sock from
> > > bpf_skc_lookup_tcp(), won't this result in the same KASAN
> > > slab-out-of-bounds read since sk_protocol resides outside the bounds
> > > of struct sock_common?
> > >
> > > > +
> > > >           /* The locking semantics that allow for synchronous execu=
tion of the
> > > >            * destroy handlers are only supported for TCP and UDP.
> > > >            * Supporting protocols will need to acquire sock lock in=
 the BPF context
>
> Jordan
>
