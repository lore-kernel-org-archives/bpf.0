Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9424140E5F
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682198; cv=pass; b=FZgMqx6h9PCbzMjDnG5rYJ65rQHRpy8sT+vpsHF5M4wnBW5Hm0DM0NsRaR7eSKkFBB6aGxOmy0Tib0c49dXPV9jGrf1EqebOJvVKqSuVhpCiq2MgR8E5M9L6B9S+JeRyXdfkds3+TuFuR5+A4wmvk9lEfkN6UoB8AAxq3ogpN+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682198; c=relaxed/simple;
	bh=ootrVtgPccogVZf5ithD1dZ0iHB8qkN6uJMW91uTino=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODGcGmznUNzrWnoSMnPQXxmtMBuCBnrZojKC72xyeFVD8WoVb/93riUBa1YyX8usu97f4H42Pc3d5nL9w3snZA1p2GiYjjKhMhXbnLWg3XE9gxKWIyjSoaFbTt6cz8qeGNpeYqHjFtK/rT0goKhJ9me1PoP4rx52Z1NdNaCD2YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRmVE107; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRmVE107"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-128b9b7e3edso1596890c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:43:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682196; cv=none;
        d=google.com; s=arc-20240605;
        b=TapwLTeN+xmgGNeQTBndqUVApPQdd5NUYmfDxiJ3g4p8Gh+ajI7tQjU/CVhLOkwk2F
         ry9glJTXA1Uy3u32PYpjzitF+FrROkJbi2hYe9jUNy6akeLSA4qSO/709fK8FlmDZVhI
         y8ZotYB7yc4djjmqRzBWj4wU34bYd1FVlZwRQgMDeGXrs/xDTx3b1gB1tk3mDedvDBmY
         i1tP8wHcVSkqc6kLIxGr9CV7mKbjJ7Xxt5h56SHAwVGiffsM1EsctMKn7OyZ4IrjziCH
         RfHsIgF7bjLKrsUsp4qwK9U87xRsiZIbwBL9hTAagv6PWUktlfS3VWI224vC87J5n+4i
         HJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        fh=sw4UX9QyRxbn/VYb5Cf5evsvZPlbqy+5KIhsTzQNBI4=;
        b=JndGoLPAWGBMwxK+7NrEyaGUyN26jR4WQwt5lfoUuwReyLBsaKn/ZiyWES2Oh5maBI
         NcnVjJHfwi53XQShbcuqqMYMvf5FXnlkUDJGbemvRz/Ln2+S2wri3guvnoPHIOhtItNM
         QjPhxD2ArSOoJPbFfisI853ZUT2GDind4KEtqHcyXazSV3QfDRfmubHdDE572/e0fiF5
         jFeTVW/xLSp6BjTCQve0ElhyZTgjBINPtti/5oBUcvsXE9ISbr+6uXam1i1ZJE4NpLn5
         wT3NjmobWUoWK3au7vr23V2xfBzP0aD62ZOqa8MKk9HJK0jSykxJeux6R3G7WUOU7kXF
         SN1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772682196; x=1773286996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        b=mRmVE107dCyuLGH2mESEAOazzRcz4uvYuqX+lfD0ghIDG9UADSgGgdmQM/eUEoKotD
         gecv2+iQgRXiukDqX9Cusx+MmVnTCItW3vVo32Rjmxk0J4HSUY07zXZ8A9JxeO+eYJbc
         I1KA3zhNi+Tdi+arTWjpbD/6a5ZJL2atrX+gl5CIPtW00N8WpNc0YNXoDyanpR9McASV
         9TEnfNX2f25k2x5c+vxYLnL+6qsH5O5dH/ytrrJsByaIJWsFH7m6AoL5NzqgKzfW/Q23
         OEEJ9Q5i2KUCkuknj2wqyUVofIl2mNj5Zi23Utkd83OYGgMhKrmib+RBXZQA/9pFoj/O
         9lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682196; x=1773286996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laZackGfUZPohc8rpn7q9sGIcb8hpmuUOav/5ISxzRQ=;
        b=qvJPDdUpQIUAb9HQgnv6MagwI1rB9CxWD3fvgO0RlGE9zYP2AejzUD8w+YUvhzqHtW
         Spg/U4oJODyJsy/4CTko+h3NA2RiDzpk/1F4CBZgLH0OZ8Mol+W4bkXK2dvYZAacICpG
         2FwCxOXj+iboVPxT6+hqsp055FmW8MdpLgxIvHCP0xf4EmKtKeEvBdJpPsA56pY3EmIX
         zGG17ak8K0huJJttpDit1BVhmkNRXAD8CDxvvHTVBmitD0qiPlApl+yBdhwsHheXeOZ1
         yp4raxzesybMSIO1WYW1xXHwgZ27gzv5QJSVZRL2xnLBff6xMCCDuVI093Zw/tELff9b
         7z8g==
X-Forwarded-Encrypted: i=1; AJvYcCUoaNETdeOtpxnX+dMxa5uCnf91mmoWc3+5VRATsfg9lJJs8RjChZLoHXjpobMR7O9v/TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymrk9eA3zBEgyXLZtciUKhyz0QBXrznkJ58bHxBBjg875UKWiJ
	wDmOyresjHock8UxFcM8oDg2l4xCcG4LPmrYozScxo0FPKgplqOl49s7BWoJiAX1NtkGoB0Qh8E
	nKJSUGMx84Wmf6/YXSk118lIGgS1f/diUf75J3Cm+
X-Gm-Gg: ATEYQzy8pg5NEiRfd/7G+8bTOLwDqBezacZUDgW76WckJemXmTOIycvGZggGPgXc1dY
	fo33tefQLVQI3vPOgZ8X7lSX8U1yi4UkF5rLkGCPcb024bgJVVhqFoiLXLZhD1A/rSci1YMkOEW
	3nQemWnsQnPcg+pD+TWNWBh4Tr2KHi8nLNOQ2XT6Cn7knk5TrkdvdZUAqiDRU3Bxp85NGFWhrhr
	8u7B0KcrDMZjKVlTRIG/VTxmSn6wnyYTYfJ5wOIWD4mkcE88tWu/Mtt76/UQuka9JOFX5mLDwzd
	huccpmkgl7FF22lvGH0G77dTh1JqQYMxjgytp+dgf/YQiriEEDriWbaT8PQ/ivmSDk9B6fQ9
X-Received: by 2002:a05:7022:611:b0:127:3440:e5d5 with SMTP id
 a92af1059eb24-128b70d1277mr2482271c88.21.1772682195309; Wed, 04 Mar 2026
 19:43:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-3-kuniyu@google.com>
 <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
In-Reply-To: <fjt7fesjnzwuzeuiouv6rpvoxebounjqv3jlc34tvmzh252zep@hizdvwr2qwe4>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 19:43:04 -0800
X-Gm-Features: AaiRm50tdKTJcrkl2TV6ugHeYrljxXQn_6A_T7cC2LyOcuGXEOHGEE6Yysg1wcY
Message-ID: <CAAVpQUAJgFtcJGtuMufS9mhaShs7OQDxx7jTGOSbG9wCdeCN7Q@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 2/6] sockmap: Annotate sk->sk_write_space() for UDP.
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 5:48=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:49PM +0800, Kuniyuki Iwashima wrote:
> > UDP TX skb->destructor() is sock_wfree(), and UDP only
> > holds lock_sock() for UDP_CORK / MSG_MORE sendmsg().
> >
> > Otherwise, sk->sk_write_space() is read locklessly.
> >
> > Let's use WRITE_ONCE() and READ_ONCE() for sk->sk_write_space().
> >
> > Fixes: 7b98cd42b049 ("bpf: sockmap: Add UDP support")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v3: Use WRITE_ONCE() in udp_bpf_update_proto()
> > v2: Cache sk->sk_write_space in sock_wfree()
> > ---
> >  net/core/skmsg.c   | 2 +-
> >  net/core/sock.c    | 8 ++++++--
> >  net/ipv4/udp_bpf.c | 2 +-
> >  3 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> > index 75fa94217e1e..3d7eb2f4ac98 100644
> > --- a/net/core/skmsg.c
> > +++ b/net/core/skmsg.c
> > @@ -1297,7 +1297,7 @@ void sk_psock_start_verdict(struct sock *sk, stru=
ct sk_psock *psock)
> >
> >       psock->saved_data_ready =3D sk->sk_data_ready;
> >       WRITE_ONCE(sk->sk_data_ready, sk_psock_verdict_data_ready);
> > -     sk->sk_write_space =3D sk_psock_write_space;
> > +     WRITE_ONCE(sk->sk_write_space, sk_psock_write_space);
> >  }
>
> I noticed that Patch 1 and 2 were submitted earlier and are on bpf tree.
> Given that Eric's commit (which you reviewed) is now in net.git, these tw=
o patches
> should probably be dropped in the next version, right? Just confirming.

I was thinking git can just handle them well, and even the
patch 2 has a delta in sock_wfree().


>
> https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit=
/?id=3D2ef2b20cf4e04ac8a6ba68493f8780776ff84300
>
> >  void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 693e6d80f501..710f57ff3768 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2673,8 +2673,12 @@ void sock_wfree(struct sk_buff *skb)
> >       int old;
> >
> >       if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE)) {
> > +             void (*sk_write_space)(struct sock *sk);
> > +
> > +             sk_write_space =3D READ_ONCE(sk->sk_write_space);
> > +
> >               if (sock_flag(sk, SOCK_RCU_FREE) &&
> > -                 sk->sk_write_space =3D=3D sock_def_write_space) {
> > +                 sk_write_space =3D=3D sock_def_write_space) {
> >                       rcu_read_lock();
> >                       free =3D __refcount_sub_and_test(len, &sk->sk_wme=
m_alloc,
> >                                                      &old);
> > @@ -2690,7 +2694,7 @@ void sock_wfree(struct sk_buff *skb)
> >                * after sk_write_space() call
> >                */
> >               WARN_ON(refcount_sub_and_test(len - 1, &sk->sk_wmem_alloc=
));
> > -             sk->sk_write_space(sk);
> > +             sk_write_space(sk);
> >               len =3D 1;
> >       }
> >       /*
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 91233e37cd97..779a3a03762f 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -158,7 +158,7 @@ int udp_bpf_update_proto(struct sock *sk, struct sk=
_psock *psock, bool restore)
> >       int family =3D sk->sk_family =3D=3D AF_INET ? UDP_BPF_IPV4 : UDP_=
BPF_IPV6;
> >
> >       if (restore) {
> > -             sk->sk_write_space =3D psock->saved_write_space;
> > +             WRITE_ONCE(sk->sk_write_space, psock->saved_write_space);
> >               sock_replace_proto(sk, psock->sk_proto);
> >               return 0;
> >       }
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
