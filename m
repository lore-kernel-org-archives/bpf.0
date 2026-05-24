Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C0202963
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 03:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779594480; cv=pass; b=r20djXhNytUJGJxy7fH9GO2g+gBY4fWnU/7m5/jjG8D1QQiRaHpJotaAWrJdQhvCu3KGXDhP1BjbtqpA8pTN2kGKO348NMz2mvGjFgzuDkKqt9T0MvrPcQbngEjZXqUWN3vOufKVjqxFgirCYkCGf/qUVutp4q+PqwHT3Cm0HDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779594480; c=relaxed/simple;
	bh=5OE7VDk7Xk8tK0kdONIg6DMt2T69ox9oBKpsyuCN5qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTiGBWsLDjHRdIijCAoJZ1NpTYcipN3opmJ8KBs7XR0fKv3/gAYmSii57zhgPZGFCjC8yvP+8Fhc5rvzr/apFKorc6p51aGTYpL93jUCK0aOaRsx82yuKA+iowdtKOtb/L8euQqnDyHXqSfzeDYIOpAy5I/9B0cIfavfI80RsYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLQOq1ww; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLQOq1ww"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-136a89595c3so612496c88.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 20:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779594478; cv=none;
        d=google.com; s=arc-20240605;
        b=dK3lntIF2QAtKzS9KVcMQrAnOJFL8vaB3uDLs3Ovv8J4Rzfn1Zv3jHIa6Jmbbi7eTs
         MuiTS2aEr42+5aQXGqKHH6b2ckRDElb+pCPBc03MztS0AxmMy5cOr1uk+DMW3Dr7XtyU
         i04STEccJY+UNKAeSA0k1vGPq+ULPTQbmma9YA7aSrxBm/EvwE6cXhCRKQPBfDaMVD0A
         Zr3DMTOve8Tx2+mbXWAh63D8ZiL6KRVh+dRPJ/WjBfrkBotdlxqzsbyi+7R7LIgGDyOr
         N5lf6UcpjFyHA1ibQVhJWw02cTmbmkNJyBSELvJbbvZgZkRe/vAl2coIUqTAc1e5VZUR
         8V+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nIK0xfX2Hyamn7E86WRboAaD6BU+mm8VtXXVXqn33C0=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=CbkznxU50UaUliBaAhqdGgHpSOXWez14z53FuM6XHUAEcXCfjRhS/xCLr7LLQcKsZn
         WaRmYPL2JeKuxHs1Xy+y9ZZHtJOwhpUeHd5QpwB7KDOdm9TeZiCz4Nb82J9YT5igfRfH
         84XooKswU148lwQ5Mz6Ufbyl1SUKE4y/Yy5+ZrqmHYQWMRKoUEunOhnP2yaLXzMg8GKw
         BBG34O8ppH6QDQ25cNNJw41Uoqq2HZF3+uRlqqOCLYGroVOJ974M9PIofDQYGAjkAhcL
         Vr60Yr3I0AqmMJRhx8sW12mkaqNXd2fVgPQQWGiRjD+mNfpAtDXE9itmA41kViLkq7g+
         Bs/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779594478; x=1780199278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIK0xfX2Hyamn7E86WRboAaD6BU+mm8VtXXVXqn33C0=;
        b=vLQOq1wwhFe4ujVkBZo5KTR8FNxFuFFKiqbfZn+mYJg29fMEcO9Ckz4sr3cCiCK+i6
         0R1N1SS6rjfTqpcMbJ2bYD1+L9DqIMl/UrP+zkxf3+oGZdPRrWxLk7X5Bfe83F6/PUph
         AHGAltyyS8TIeINRR786zRvRqsi8QDkEGdegQo3FsWz23WzPwWjymnh1u/jxJM/7cjAk
         qFPhbAdTkTLwsdolWabUE86dnpSLmq62HRfX9j74fVa4j3zEJMGWnnBwEYLpmN4Tvos+
         JHSbdLPnltiGEfy7/SCnVw5IIu8bBmP8n2HhVt45soH8EyW974k4DIyqOM8vZus8zhB2
         6W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779594478; x=1780199278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nIK0xfX2Hyamn7E86WRboAaD6BU+mm8VtXXVXqn33C0=;
        b=m0UbnlF+8poId8P+ITUcbkSDG8dDO1ZY+bVmGKVUfMN9P/Fet8JUAEuUgCBm+qEJp4
         LnXWCe4ymdAgccXYwSzMB+B3B+5ligr5midc0vnbn6jwvEtjR7WrCsN/oVAL1Rp8zuyv
         uz4+GB5IRq+GmGqeizi24yqDj8Pu/IgcdBktl5JycNkEBuom2KK0EXLviRx5j1aMmnJA
         G9pV1raMIPLGe0NMu31uPNdxJpYzJ07C6jsphEWmjuB8t92u7tb+sjhr3++qarisk5BC
         +1c0mC5FG97xVyyC4KhizIemH5Hym0ReLawfskZydaiHAgS2dJSJvcz7O5nr8JXnQXG3
         B5Fw==
X-Gm-Message-State: AOJu0YwifWd5OoUTEYwZ4TNX79FEDVEY7httIpyosygu3qWYFX+vChd2
	EZmnm4eXMciOnWyLrZElremA5USYSTMyh9Dui14g88utcNux6hxgGZd3cnBIb/TprIDkx59Y5zy
	+zoVfmsQXd/5tIGsjzY61jcSJ6MRC0Xxt5IaIRCSV
X-Gm-Gg: Acq92OFoAQueoFcklv3peWwlROZNlY5YjJlQ5//TbeCz23yVkTN7+06IUUuAvtgGwpP
	bgLNUx6AZWXlU9/kquEuwFeDIyxkOkfqkrLvQgaEqTHAo5B7VPIolA8Vn1JUZDD1KstE049yGYx
	BIpmDPqhOlCf+hhX6bGFOS3+OSY77d38dCnr1OGFdjI+SJo8QpWGVSj6cecWJuMIVPO6ecaJzrS
	EU6NCWgP7KN0WEKQL/b+WJFTHektxh60TTuQyWpGDve5XNch9/v73AUlCgXLVV9VZ1lIsSffe9Y
	ZPaEcFXzS0lZbOf0hOCufG2IUmvgdISPJRMrA9BuCheZm2T2AfPPkklIEGP2gRrSIDSKWcNzLBg
	/mByTAEzoWpU2hBkm++AVcykYR4YiGPV96ksCyCyTQHz16Iw/zQ+r2XvOrlFPPos=
X-Received: by 2002:a05:7022:ea5b:b0:136:8bdd:3f66 with SMTP id
 a92af1059eb24-1368bdd40d4mr1248528c88.5.1779594477020; Sat, 23 May 2026
 20:47:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-7-kuniyu@google.com> <20260523092933.DE3551F000E9@smtp.kernel.org>
In-Reply-To: <20260523092933.DE3551F000E9@smtp.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 23 May 2026 20:47:45 -0700
X-Gm-Features: AVHnY4JlVRld-DseQgriiR1Pv_34W0zaElGZi5_HUpKyHBFKYF7flx8n3RbMLio
Message-ID: <CAAVpQUBvP0NLoc66ur=MGiHTbvdsEpHQJwQokTvkW1O9f8ehCg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and
 SOCKMAP mutually exclusive.
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 2:29=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] The mutual exclusion between BPF_SOCK_OPS_RCVQ_CB and SOCKMAP is=
 completely bypassed due to a Time-of-Check to Time-of-Use (TOCTOU) race co=
ndition.
> - [High] tcp_in_sockmap() fails to detect a sockmap if an Upper Layer Pro=
tocol (ULP) like TLS is attached, allowing the mutual exclusion to be bypas=
sed.
> - [Low] Calling tcp_in_sockmap() in net/core/filter.c breaks the build wh=
en CONFIG_BPF_SYSCALL is disabled.
> - [Low] Using relational operators on pointers from different array objec=
ts is undefined behavior in C.
> --
>
> commit ebabac3763475d472254639d69b23d839f36111b
> Author: Kuniyuki Iwashima <kuniyu@google.com>
>
> bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.
>
> This patch aims to make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusi=
ve,
> as both can intercept and handle socket receive queues. It introduces che=
cks
> in tcp_bpf_update_proto() and __bpf_sock_ops_cb_flags_set() to prevent
> both from being enabled on the same socket simultaneously.
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index c6a6853909c4b..bc95d8e7b62e8 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2853,6 +2853,7 @@ struct sk_msg;
> >  struct sk_psock;
> >
> >  #ifdef CONFIG_BPF_SYSCALL
> > +bool tcp_in_sockmap(const struct sock *sk);
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore);
> >  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
> >  #ifdef CONFIG_BPF_STREAM_PARSER
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 3608036632a81..1fb63b264b181 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> [ ... ]
> > @@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *=
sk, int optname,
> >       return 0;
> >  }
> >
> > +static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
> > +{
> > +     if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
> > +         tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG=
) {
> > +             tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +             return 0;
> > +     }
> > +
> > +     write_lock_bh(&sk->sk_callback_lock);
> > +
> > +     if (unlikely(tcp_in_sockmap(sk))) {
>
> [Severity: Low]
> Does calling tcp_in_sockmap() unconditionally here break the build when
> CONFIG_BPF_SYSCALL is disabled? The declaration in include/net/tcp.h is
> guarded by #ifdef CONFIG_BPF_SYSCALL, but there does not appear to be a
> dummy fallback for when it is disabled.

Will fix.


>
> > +             write_unlock_bh(&sk->sk_callback_lock);
> > +             return -EBUSY;
> > +     }
> > +
> > +     tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > +
> > +     write_unlock_bh(&sk->sk_callback_lock);
> > +
> > +     return 0;
> > +}
> [ ... ]
> > diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> > index cc0bd73f36b6d..7e7966b095f9a 100644
> > --- a/net/ipv4/tcp_bpf.c
> > +++ b/net/ipv4/tcp_bpf.c
> > @@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp,=
 read_descriptor_t *desc,
> >  }
> >  #endif /* CONFIG_BPF_STREAM_PARSER */
> >
> > +bool tcp_in_sockmap(const struct sock *sk)
> > +{
> > +     const struct proto *prot =3D sk->sk_prot;
> > +
> > +     lockdep_assert_held(&sk->sk_callback_lock);
> > +
> > +     return &tcp_bpf_prots[0][0] <=3D prot &&
> > +             prot <=3D &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_N=
UM_CFGS - 1];
>
> [Severity: Low]
> Is this pointer comparison safe? In C, relational comparisons (<=3D, >=3D=
)
> between pointers that do not point to the same array object result in
> undefined behavior.
>
> [Severity: High]
> Does this logic fail to detect a sockmap if an Upper Layer Protocol (ULP)
> like TLS is attached?
>
> If a socket is already in a sockmap and a ULP is attached, the ULP
> initialization replaces sk->sk_prot with its own protocol structure
> (e.g., tls_prots).
>
> This would cause tcp_in_sockmap() to return false, allowing
> __bpf_sock_ops_cb_flags_set() to enable BPF_SOCK_OPS_RCVQ_CB_FLAG
> and bypass the mutual exclusion.

I'll check sk->sk_prot->destroy() instead since it's not
overwritten by kTLS.


>
> > +}
> > +
> >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool=
 restore)
> >  {
> >       int family =3D sk->sk_family =3D=3D AF_INET6 ? TCP_BPF_IPV6 : TCP=
_BPF_IPV4;
> > @@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >                       sock_replace_proto(sk, psock->sk_proto);
> >               }
> >               return 0;
> > +     } else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_C=
B_FLAG)) {
> > +             return -EBUSY;
>
> [Severity: High]
> Can sock_map_update_elem() and bpf_sol_tcp_setsockopt() race here, allowi=
ng
> both features to be enabled?
>
> sock_map_update_elem() does not call sock_owned_by_user() and only takes
> bh_lock_sock(sk). This means it can execute concurrently with
> bpf_sol_tcp_setsockopt() from another thread which holds lock_sock(sk)
> (because lock_sock() releases the slock spinlock).
>
> If Thread A in sock_map_update_elem() calls tcp_bpf_update_proto(), it
> checks BPF_SOCK_OPS_TEST_FLAG() before sk->sk_callback_lock is ever
> acquired.
>
> Concurrently, Thread B in bpf_sol_tcp_setsockopt() takes
> sk->sk_callback_lock, finds tcp_in_sockmap() is false because Thread A
> hasn't replaced sk->sk_prot yet, sets the BPF_SOCK_OPS_RCVQ_CB_FLAG,
> and unlocks.
>
> Thread A then continues and replaces sk->sk_prot to the sockmap protocol,
> resulting in both features being active on the same socket.
>
> >       }
> >
> >       if (sk->sk_family =3D=3D AF_INET6) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523083001.29=
11931-1-kuniyu@google.com?part=3D6
