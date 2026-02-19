Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8A2BD031
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771525792; cv=pass; b=A+oZY4lBNLgzF4TzOXaSvd5+rPMsZO5LdN5nLpzyRGtf4zzT0l/q3xribkCOjJUYeRJwhaONRSThTNMcc6489NVZYxpj9uot5F2C7yTjfO/jPZrV1qAn9R/lpTbf4S5LMRAJLjk0krlREAp8bDF4LQ9AGfBHt4eLfafT6O2hASM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771525792; c=relaxed/simple;
	bh=sK3dATEtRYJyU9O0GvBO2UZs/ma4Y5ooKNy6Ml5uPSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt/MZTO48q7ygyYTr5iCHXs21CLToWTyn5MCgWhJ+3lr/0vmt7fTKc7h8HERTGkWBiqxcE2HY9K52YbaqnmIvrg5nZ5v4wpG9zEUO8euW42KHvoUypPRJCDpCwJi313mIziUYtIXUWmpWkWfgHufaE3ZDzxXiHo7LriHGnOIz9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYHfI8Xc; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYHfI8Xc"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so371995c88.1
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 10:29:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771525790; cv=none;
        d=google.com; s=arc-20240605;
        b=bP0654cImCsZR6I8Hal1PnPWmYKQqBt0QKfyAru7wGt4Gkqkct9AHDzsVmiYBaFV7u
         DImJr7DZ/aE7oPNtWwj+M67Hgg3nOp1DgbRJde63N2tgzDXeZxVpTPxaQ0L6bWjAUHrR
         5fnFV++6USXBYiXzj4lgCA1a3tdN1za4Ce93YQHib2YW2D9AnMeK/QGbQhsS/U0p6q8N
         uIoaHxz37DDZvWYxonn8dyx/AGpYJRLENGjVkRl/vqWnLCxMIS8fE69lGZGwbnTtPZ2g
         ECDsFyw0glRiX5CE9kl36bPOpziHcq+se7bspaCx0Ba+iE5aPYZRIeUPDVQnAf5KTFFj
         BmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        fh=vRgXcWzbbrwlSKYMnn/Y3horSIsgqMp2vU1ZdVtZJHk=;
        b=HVr6Y/ve0FAUpEtnYsTvSBBIQh+GJlai9eYTFGxfNA/F3fnQpRi5CprYTc4fQ7hC0P
         EVZgDMGuKra3cnBzYEDQKxeGbdlrp640a7y0fK+zehHrShrqdDHnU+soKCT40zq+vNO+
         jg/KZqpoHTRD09UrgknqjwgXjVw0q+LeJzRLClQTJ7ErrWP8Ig/QKLmpL764ZE8mq7Ub
         AtPasWhCiiuPGRosc/FlXZKGl3QSvD8qZpiOKMozAMwe0D81nEfysACIyTsnlNNO5Hkm
         GjBxg2IyycYLt1OaPzwCci5h7AjQlXdxpL25p/zM6oXkXDN3wLGREliLSsLkHz8DLZiM
         7sPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771525790; x=1772130590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        b=hYHfI8XcG57vIo0gB3FT5Q216wtoEM/WO3NeMF1AjawvfOGCq+aUl0/WwdYSw3+U/M
         iR6U1MEPJ3B9X3k70MGyMyQit8BLQPtj8rTPCOrkqfk/7VYhULfNoLfjdoxxKxSkGluk
         6Nhakm5U4LCht+R69eV///fAayuN8gGZoVNlNsgzHlJjANV1YK7t3DPtfXsMoMiBqVtB
         +UH514VWE2ELygMz6nk3xNzESjYumRhb/Q2L+vVSMTJ2nlvJqtY5nOEbAVqodI2rdzXy
         10dtKWTrBQTkW6VQnYkG490Faq4MK9/P7bNti/IHzI/LKyhPEnNBMCDelsJUyTKVU88w
         MIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771525790; x=1772130590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kmQQqYT/CltjIjkNPl9I+pPorzYiaHn8DkgthxVsmOo=;
        b=pO04BiERrhMbMpyESe+C8NXR0y3WaNjlGUulY0JYdagtTDdqgGd4fDkarPrxVVP7nT
         YtU9AbZgkdukWOCY5YJGj2f4s7BdFUVycglnRzc+6JB4y1z53KhHN6VeoPt15yPYYATp
         jDARMc9E8fVWKwro5r2jmuTC6R00AsVEsT8KSaljktGqpqTW4N1sRVYEmnkgMDLOjdkE
         BgmhuXXrFCXaH0YMnbKYZKM2yJFMiC/llY1bOxkeKyKmaMv2y6EgIkO0VPDEZ6QrThiQ
         iuNx0ZdCAv5rd+T0USxOVaoFfJDhWepiYlwGE3jBLQK/ycWeMHNceGS1q2D/J6Zqvgsv
         kfIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpcVO7aggaT3Q/1qQt58Pr1jAR5h8AX/nv0P55l56WztbxiOkaQJgD7i55UzysalPL+Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtVVb2A2yhRPfSNqWhOkBbNMDQzjxj33Im7NpGwhuoxLiGxHy
	FL+LPWkbQFy4mo9L4f4ADIWFDvPC3EmcGoV7pXX+N4PxR9Ym6hVQKfiBeV/uIdJknPPrBJoa3xu
	WC17ZqeXkTAlENVcfBiBewjDk2FfKJiXB7DI9Capf
X-Gm-Gg: AZuq6aLZzgPSgoaabkbA0h8O/B1j7MpaXNDdAk3bK1RjVkj7y/Ixcsk4wV/rJ1UHYkt
	jzVAa4H1ve+Ll1g7cAcweDRU5xdT5IDQcDo3wkLt4Y3z2GxU+JIz8fmWzpSnUHgS2MBKArMyCjP
	HAiFHaTIRY4A3375ilFYy8wX4AZST9lSzJfBbTgtg3R/cyTo2uDLQoJ+9IdowYtmfQ64opTl6Is
	Ax0X040AgpTidoB0K4+EwAl6tDpKO3riAXW971zdRrtZBY/U6PRiTvOV+plx4CczAdNnO4NmBam
	4dAVLa0a6bEvxFSsR3MAiOVFnCj00P3ZErM69kfkKfHO9h5LQBIbOJp8ugYZs0qZ1Ks/vOgF
X-Received: by 2002:a05:7022:4584:b0:11b:9386:8262 with SMTP id
 a92af1059eb24-1273ae8d7dbmr8589275c88.47.1771525789334; Thu, 19 Feb 2026
 10:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219173756.315077-7-kuniyu@google.com> <b8d59a7285647804e2c8484dc8cb118abf0ecd69657edab42393389088e349c5@mail.kernel.org>
In-Reply-To: <b8d59a7285647804e2c8484dc8cb118abf0ecd69657edab42393389088e349c5@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 19 Feb 2026 10:29:37 -0800
X-Gm-Features: AaiRm51l5uXrAtzog4Z0HbOXUmQRvcMtG17AuUmBL8-1sZuW6YVF6_oOduK8z6E
Message-ID: <CAAVpQUDHx1PYUvDeO+AdUWBBfQ8LBNqF9VpX2_Y2_2qpa+-cXw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf/net 6/6] sockmap: Fix broken memory accounting for UDP.
To: bot+bpf-ci@kernel.org
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, 
	willemdebruijn.kernel@gmail.com, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, syzbot+5b3b7e51dda1be027b7a@syzkaller.appspotmail.com, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev, 
	clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:11=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
>
> [ ... ]
>
> > @@ -576,6 +577,7 @@ static int sk_psock_skb_ingress(struct sk_psock *ps=
ock, struct sk_buff *skb,
> >                               u32 off, u32 len, gfp_t gfp_flags, bool t=
ake_ref)
> >  {
> >       struct sock *sk =3D psock->sk;
> > +     bool is_udp =3D sk_is_udp(sk);
> >       struct sk_msg *msg;
> >       int err =3D -EAGAIN;
> >
> > @@ -583,12 +585,15 @@ static int sk_psock_skb_ingress(struct sk_psock *=
psock, struct sk_buff *skb,
> >       if (!msg)
> >               goto out;
> >
> > -     if (skb->sk !=3D sk) {
> > +     if (is_udp)
> > +             spin_lock_bh(&sk->sk_receive_queue.lock);
> > +
> > +     if (skb->sk !=3D sk || is_udp) {
> >               if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
> > -                     goto free;
> > +                     goto unlock;
> >
> >               if (!sk_rmem_schedule(sk, skb, skb->truesize))
> > -                     goto free;
> > +                     goto unlock;
> >       }
>
> [ ... ]
>
> >       skb_set_owner_r(skb, sk);
>                         ^^^
>
> If sk_psock_skb_ingress_enqueue() fails after this point (for
> example, skb_to_sgvec() fails and skb_linearize() also fails under
> GFP_ATOMIC memory pressure), the error path frees msg and returns
> -EAGAIN, but the skb is kept with skb->destructor set to
> udp_sock_rfree.
>
> The caller sk_psock_verdict_apply() then queues this skb onto
> psock->ingress_skb for retry via sk_psock_backlog().
>
> On retry, sk_psock_handle_skb() calls sk_psock_skb_ingress()
> again. The function acquires sk->sk_receive_queue.lock, then calls
> skb_set_owner_r() which calls skb_orphan(). skb_orphan() invokes
> the current skb->destructor, which is now udp_sock_rfree():
>
>   sk_psock_skb_ingress()
>     spin_lock_bh(&sk->sk_receive_queue.lock)   <-- held
>     skb_set_owner_r(skb, sk)
>       skb_orphan(skb)
>         skb->destructor(skb)           [=3D udp_sock_rfree]
>           spin_lock_bh(&sk->sk_receive_queue.lock)  <-- deadlock
>
> Could this self-deadlock on the receive queue lock?

Oh exactly...
Will short-circuit to sk_psock_skb_ingress_enqueue()
in that case.


>
> > +     if (is_udp) {
> > +             skb->destructor =3D udp_sock_rfree;
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +     }
> > +
> >       err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, take_ref);
> >       if (err < 0)
> >               goto free;
> >  out:
> >       return err;
> > +
> > +unlock:
> > +     if (is_udp)
> > +             spin_unlock_bh(&sk->sk_receive_queue.lock);
> >  free:
> >       kfree(msg);
> >       goto out;
>
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
>
> [ ... ]
>
> > +void udp_sock_rfree(struct sk_buff *skb)
> > +{
> > +     struct sock *sk =3D skb->sk;
> > +
> > +     spin_lock_bh(&sk->sk_receive_queue.lock);
> > +     sock_rfree(skb);
> > +     spin_unlock_bh(&sk->sk_receive_queue.lock);
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/221933=
27667
>
> AI-authorship-score: low
> AI-authorship-explanation: The commit demonstrates deep understanding of =
UDP memory accounting internals and references a specific syzbot report, co=
nsistent with an experienced kernel networking developer.
> issues-found: 1
> issue-severity-score: high
> issue-severity-explanation: Self-deadlock on sk->sk_receive_queue.lock wh=
en sk_psock_skb_ingress is retried after enqueue failure for UDP, causing a=
 system hang.
