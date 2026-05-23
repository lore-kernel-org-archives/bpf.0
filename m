Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84619004A
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496924; cv=pass; b=VTJW6CHwqGFr37o7YXMBwDSUuLbSU5u6mEo5l+JM3/Dgf0Ki8BeO1Ar5p2Ieoee+ovcdI+pR1x0LFTWvRIXiOChzzwCLlIZu/JQmvvMCfpoq8ycRdA7ruE+odFAevXFrc80BZEr+di957Z3EsphRjP3x6ZC2uEgacsd86rOnb5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496924; c=relaxed/simple;
	bh=oLJfdMAe+v7hyzd6eHHmnfwAbB1cGlc0CxsWfS4//I4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JsR/Q6JC/DsFxZyMTjHhjf6EjUma4kmgJMdKd6wu7XapgD/48Qip0BpoUoHmB0gjITZX+iijSy27Ec/DfZrQZ+64JGsIBkNp7osjq1ifexzjJtRqLxFpKvIZPd1oDHD+TZZFO3ZMmz5Neq3fuoyh6on3SgHwlnAtgBk6jARoIPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7VpDA8W; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7VpDA8W"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1357c851a48so10093051c88.1
        for <bpf@vger.kernel.org>; Fri, 22 May 2026 17:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779496922; cv=none;
        d=google.com; s=arc-20240605;
        b=QUQpy5zFFzNAANfY5ZuBh5cU1lETk3I+0pTt5NeJGrSrhKvz+hQPnwsj2l8HADSQxv
         v3rx8+Hh2tbO0drsSCchYRUXfQ03/XGqqoasbpWwffb2gOmVdFTGWXFEnh9C90gCxgd0
         U/WB4nlZoe5qYGV5BU+p2wnzGnSP0CKlWkQTsZQx+dwIla3z2nrHkP4TVMdFDYI3IQgL
         SWqjZcMMrIWlHPZ91djYTevYVGxGIlXCoV3bLAZ1J0GMKnkp/q8mfMaHplJGFbqHNR00
         TCxR960lYeKES5Ibbcjmw/rQM7/JIEP70Sk7a5BTcEa5q6gVzJBvUiWkfH04JvCS88IS
         lJnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=af+VkUquvxRk1a32iTVzsOEkTiwhLgx64pdwoW9F56w=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=aiSwKUyQ0Zzbg+svK6wc4zV3UQ3+OJwvYXy60QvUXh11bvs329L5xSfAUBzfAMYGLW
         qorkAUHIKIc2WQ9VnA+gM58UHJl3Yr8GMkbl/S2QgYeXiehUPYwVzTjdY1CVCO2hEFGK
         xyze3Hln/sCCjAN0Z4E7GrO7u5w/srTAkV50rdoBtovcIpXwl/Q3C3Wn1AxiTQZXsQMQ
         YT8/VY5lWLdXw/y/7LskDeD3FmITi5lmG3fOL694Q5KavCPiC4W9M3DQ39DAPgZUR9RM
         LqXpGqRIfsEkfx05tS5hSP+NuDG9ZGO9KhAIUbWrpCTyN4wsjY/eWtu2p2w8rq3++T/i
         jC7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779496922; x=1780101722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af+VkUquvxRk1a32iTVzsOEkTiwhLgx64pdwoW9F56w=;
        b=A7VpDA8WHikWQDITs96XwMlw9UmVbGkVEF39Vpbzhf8H53Vt8RJgCSSgD9qidyGtMk
         ny3fbC0TEIjR7J/5hZC5JnZZFlXHJsIpZkjfh3z+mXK7L/ZS+4CZet0q/X2dzyioAk1T
         U24C9LFFv7cp7X0wpITuvwJ4tQXgZ7oMj3IqNc7rAnaWzqY1jQcAylqi7lHWPm8IsAdO
         qeSjQyv+qqqB5zgmxP10bk9/F05VbldhFq+XGEhfQEQihCzdlZd5QhPS2n8/Plgp4yzn
         II/Kgskw9ywO6V5tu245At77tAr/krKGA7ODkpefJmGLvjG5I9RtWXAzMmKzY7btudiS
         Eekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496922; x=1780101722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af+VkUquvxRk1a32iTVzsOEkTiwhLgx64pdwoW9F56w=;
        b=LgM5IYvnJpB9n0naJ/425BmJmjUkylBLOupwkV/olCISTR9uLrt7kyCZJbigWZRVrk
         ZWXBnQhiO5e1gwVpW9tdmsyNNWJHOtHd/E9EJ3/IRcY+ulv7C0zBNDA0tBkgDRa9PC+N
         FBV3l799TTTmCJg5cwRiHkg/GrIzvWnpTzUiOmlrroZAy0e0MMcSRlH/DGz/I1ETtbNb
         iHkAlOWkJLht5tfst+SboMeq5PLJCYDZfWHUHIyI1+rYMHAopPXt2h1yvjIoC3kRmxob
         2FlEZbzEBaha6t7dT0IEZuKp6uAAYKoeUwIFrwyCKfIg6J+e0zPCfuPm+7QyVBG1b9SF
         YPCA==
X-Gm-Message-State: AOJu0YwzN0r0qMgLZi2RJQbSIjZmyledIDwrmvOS6UTYIXmgxC7G/57R
	KDYdcH/8kpWKxbTBlzTYhZIjdG23HJera/DyaqjgBk4tF4S6nFbCC5nZxQI1JASNWzNkyJerEUY
	/dKhjQiuRFYZt4qbQUK9yeHYcirUHIkkl73jP2a5CPPvLZzuV8FZ22/AM0oU=
X-Gm-Gg: Acq92OFLIU2rkfN2LDo4VUTuSTwguQfJeCA9PSPCphcz7/Ky9Vj0qKCWO/CLee3Kp4H
	MLipGuhnPI5pncszwLuC49GRuhAOc5viWMS2xc9aHhOIgVaS+5XHUeaLLcXgiMJvFmzMMmFwbkX
	RCMm2eq7qoX39wGd0UaN6mUMzGlcfa/7tHmHOhlODj8nhX5YH39XCO3QPYR+QmUr+DYxfAPaLVa
	tHLojr8m4OEYfBSm9w74LrzbUsGibK9PkNv3Dsmy4QtDct2tiHRH97nG8IgFK03AznuoFPyMjxC
	uW7WOynB6eria5wCCFX6E9rQLor0dyGN+6mZEe9l+Jzt1Ai5EnYjBOepl4mYtyjk59sMfXkCEVP
	HFfzgyCx0i7wGO+O/A2EoXS/EPF84fCu+qEm6o9GaGN7RNzVZT7A9oKIJG+MTYEI=
X-Received: by 2002:a05:7022:68a4:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-1365f6fd8ecmr2066179c88.2.1779496920838; Fri, 22 May 2026
 17:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522074601.1658705-7-kuniyu@google.com> <20260522084614.05FC71F00A3E@smtp.kernel.org>
In-Reply-To: <20260522084614.05FC71F00A3E@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 17:41:49 -0700
X-Gm-Features: AVHnY4JQUJ2C2KHQsCPBeUSA5XtylFgRWRvtNJRwOZUkM1N3p4jA5dJ25jSBM78
Message-ID: <CAAVpQUAFrEMtPoprus7K9j1ZueE+zGM21M=3j8Zd00OMFBXmhg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 1:46=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Using `sk->sk_prot !=3D &tcp_prot` to detect SOCKMAP incorrectly=
 blocks other features (like KTLS and MPTCP) and introduces an order-of-ope=
rations bypass.
> - [High] The mutual exclusion check is broken due to a TOCTOU race becaus=
e `setsockopt` and SOCKMAP map updates use different synchronization primit=
ives.
> - [Medium] Lockless double read of `sk->sk_prot` without `READ_ONCE()` le=
ads to a data race.
>
> Pre-existing issues:
> - [High] A failed map update for an existing `psock` leaves newly attache=
d BPF programs active in `psock->progs`.
> --
>
> commit 5e984d100188fbad217fad5406d80666b989f1b9
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.
>
> Both BPF_SOCK_OPS_RCVQ_CB and SOCKMAP can intercept and handle
> socket receive queues, leading to overlapping use cases.
>
> While BPF_SOCK_OPS_RCVQ_CB focuses on optimizing single-socket
> performance by reducing EPOLLIN wakeups and fully preserves TCP
> zerocopy support, SOCKMAP is designed to facilitate multi-socket
> routing at the cost of higher overhead and no zerocopy support.
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3608036632a81..ff7fd415486a6 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5382,12 +5382,27 @@ static int bpf_sol_tcp_getsockopt(struct sock *=
sk, int optname,
> >       return 0;
> >  }
> >
> > +static int bpf_sock_ops_check_rcvq_cb(struct sock *sk, int val)
> > +{
> > +     if (val & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
> > +             bool not_tcp_prot =3D sk->sk_prot !=3D &tcp_prot;
> > +
> > +#if IS_ENABLED(CONFIG_IPV6)
> > +             not_tcp_prot &=3D sk->sk_prot !=3D &tcpv6_prot;
>
> [Severity: High]
> Does this check falsely block other features like KTLS and MPTCP?
>
> Since features like KTLS also override sk->sk_prot, if KTLS is attached
> first, the check would falsely reject enabling BPF_SOCK_OPS_RCVQ_CB_FLAG
> with -EBUSY. Conversely, if the BPF flag is set first, the check passes,
> and a subsequent KTLS attachment would blindly overwrite sk->sk_prot,
> allowing both features to operate simultaneously and bypassing the mutual
> exclusion.

Disabling ktls is okay, but I'll check if sk->sk_prot is in tcp_bpf_prots.

tcp_bpf_prots < sk->sk_prot <
&tcp_bpf_prots[TCP_BPF_NUM_PROTS][TCP_BPF_NUM_CFGS]


> > @@ -5424,6 +5439,11 @@ static int bpf_sol_tcp_setsockopt(struct sock *s=
k, int optname,
> >       case TCP_BPF_SOCK_OPS_CB_FLAGS:
> >               if (val & ~(BPF_SOCK_OPS_ALL_CB_FLAGS))
> >                       return -EINVAL;
> > +
> > +             err =3D bpf_sock_ops_check_rcvq_cb(sk, val);
> > +             if (err)
> > +                     return err;
> > +
>
> [Severity: High]
> The commit message asserts that checks in setsockopt and SOCKMAP map upda=
tes
> are performed under lock_sock(), but can a TOCTOU race occur here because
> they use different synchronization primitives?
>
> While bpf_sol_tcp_setsockopt() uses lock_sock(sk), BPF helpers updating
> SOCKMAP (like bpf_map_update_elem called from BPF_PROG_TYPE_XDP or generi=
c
> map updates via sock_map_update_elem()) only acquire the spinlock
> bh_lock_sock(sk) and disable bottom halves.

Hmm.. I'll protect bpf_sock_ops_cb_flags with sk_callback_lock.


> Because bh_lock_sock() does not
> wait for lock_sock()'s sk_lock.owned flag, these operations can run
> concurrently.
>
> A concurrent SOCKMAP update could check tp->bpf_sock_ops_cb_flags (seeing=
 0)
> and override sk->sk_prot while the user's setsockopt is validating
> sk->sk_prot and subsequently setting tp->bpf_sock_ops_cb_flags. This allo=
ws
> both features to be successfully attached to the same socket.
>
> >               tp->bpf_sock_ops_cb_flags =3D val;
> >               break;
> >       default:
>
> [ ... ]
>
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6d..5c5c67080740a 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -729,6 +729,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >                       sock_replace_proto(sk, psock->sk_proto);
> >               }
> >               return 0;
> > +     } else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_C=
B_FLAG)) {
> > +             return -EBUSY;
> >       }
>
> [Severity: High]
> This is a pre-existing issue, but does a failed map update for an existin=
g
> psock leave newly attached BPF programs active in psock->progs?

Orthogonal to this series.


>
> When adding new programs (e.g., stream_parser) to a socket that already h=
as
> a psock in sock_map_link(), the program pointers are updated immediately =
via
> psock_set_prog(). If a subsequent initialization step like
> sk_psock_init_strp() fails, the function aborts and calls sk_psock_put().
>
> However, sk_psock_put() only drops the temporary refcount acquired earlie=
r in
> the function and does not revert the psock->progs changes. As a result, t=
he
> newly attached BPF programs remain permanently active on the socket despi=
te
> the map update failing.
>
> >
> >       if (sk->sk_family =3D=3D AF_INET6) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522074601.16=
58705-1-kuniyu@google.com?part=3D6
