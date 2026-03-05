Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DE244687
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 03:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772682129; cv=pass; b=BQCaGNTfEyC40hYX8M1Qb/EwXBLFPC6M/+Invp4mbhFEYLbHBs49kn/Wf+qiHQ/HloPDmzQSSuD3VSC/0zapH/GjjWkPmYnMAdcQ++6CFW1CrynGU9LaNlPCW9tkFRyTbK5VYJFuha1QTRnMpMMhOpUTg36aKlMQj+5hoZJ4nWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772682129; c=relaxed/simple;
	bh=Q7K9Jo92G86BmPJUCWpH8Ckm6Y5l4M+EkxUH8NVeFfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSw1h3mSxfpO1yQdabwMdA3567810yE7ulIhXKbzKoFFMp1m8CMvbBCixVQorDLn0aJ5dDVsTA5ztb5e6mTmIuDi6skU3MthCxdfFW2W7c/MogWjRvWMaUqwBRaHoxsup+7dWsNK30GcACtHgUpUSjdOtWRs1wLZe07F/G/H0SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qeBM1Lw8; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qeBM1Lw8"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1270adc5121so9512230c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 19:42:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772682126; cv=none;
        d=google.com; s=arc-20240605;
        b=bnHhFqfr+JsvE7Jt8b2x+OUIanqcA3QMMSEgF1L+gXDcp7Kh+UMflY96M/fgUMG7R5
         gGdJNKJn3A7nc78XLi7K90mlsW1cmCAP3C4UiLUFjYuYVF/mYvCTZAWfZ0LVSXlwhkwL
         OeeqxSucdy64M8NbLQlW4xaTAtWso1y44dwdlOL05ogFJk4KdoR5BE0RWEIQQDq6Hors
         vysTle5RMoy9vkqRsbz9QxfJ0+JQOffucuAiiC4u30q3vvXdTDNzQfQWdq5okVRSF6Ua
         UViYWEuFCi2dHy+1OXhYOTL3wnacA1iFv+nW2uivLPCAJjNWXZW+XXk6wKJzYICB7Uev
         86pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        fh=ztui0mfXMRVg8wYBm+ceFOyvD2YEdTvXKIUTlBxpuhY=;
        b=V7cy6J6bTGuBGSDvOngZg+T+P/O1bUBxu+h5T42DpOdWJUYsIc4kidfELNMftKryc4
         7q3Jo3d6YkKt47nZ7jMsuZaiLdQgA8lQVyVQJJBEuU5r5hxPtWjaS051bipeC8x5R+53
         w74cij7tuPl3Jq5Jz8TsY1VplHgbCk6vui6hGAH+4G162QsZYuH2OcSlWdja2FgsjI7A
         UcVVDzsyo4/v/OWXTo/DwxFUgAFZmu5zIDtvSaL/+vyafZbcVv7dV1KmtiRLf3KLkKtG
         E0498K1ZBJMz0WQcorr9BPL+PMQW4I/B2bD/2fdcmNnYh+ASsy6GGe95xc3RZqRnQYjI
         wx4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772682126; x=1773286926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        b=qeBM1Lw8TbVIW9HtBKQZGUg3uAeBvcYHB9hYWbq39GRcrvYXzNoykT1wsU2RHqHDg/
         jpn9Ry5ZtbdFI8LI8u2wKe4OmhbFpoZYIRs8ZzcpDoybHv+Uys20s9dPP4m7xJ/jUGoo
         rs7a92psf9XMSiIpoVoa9r3Se4ymdtreIXFkGY+ll+iJiQQtTth7K/LMUkjpLyXB/eBQ
         LovUNOnqcrvIaTsKMG4Wb/LtdKNB//Xyb0N3Co71FiNEwiDyGYx+3pv6v4RNP+gK1lOU
         ThokUUO7K6KP/aX9NvADwJk5+pFjp+OKnOXguDMS7I3T6hcimidlI2UqiXgFnhHQJaND
         fhqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772682126; x=1773286926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBGQ9q/f7RVTwv8w49bqqAP4bXxzaJpilNMvfYhqnZ0=;
        b=T/lwtzAm2xkEU1zbiYX2UvacY9RknoUPtgqLYHFZ3OVECBIZuvFzWtOUbaWcgzZ+lM
         C2aTWz3YYHNP1pXL272AEO+ezji3ySaajq6nmcS1rZNFjZYrNQO0cVUKjtSg9Tl2cI9v
         wXj4GeFbm0R8Xga/8fr3+gNJHVGU81yEuOp57SiQFYpt3/70L6hL0W6ZzswsxE5emTmR
         mDZprPEa7mTknUdzjoiOc1WOO5DPNDyO/4MqhXWUE8ZFzQBcrXq4/EmEi9VJPfUvF/w4
         VFT+9i+8Qi6vao2c5LnBjcKiMr0iA5jMbVncVvlSidbT5rZF+GWuXqLEjcu66PH35vGQ
         SuIA==
X-Forwarded-Encrypted: i=1; AJvYcCWSnyac1hNMhs5V6gxpdYpCqVmO2Kw7g502i0gJxwM2sTJ84XoP4x+mL4BWr0Czo7IEwTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJW99payFAtgtsI6SYKiMtugYMQQRv+0Pwsq1vA2n2Am8LCHMO
	qrH9eJSy9F+2rZCMqvTBW93RALXN6pGm6nBfM2DPRah5nEIV5SFyVP9xeLnpGKx/J7ofd7ea2K3
	+j9idbQhkKzY7wf58Jz1LvTXyLFY54MGRDUjiWpTZ
X-Gm-Gg: ATEYQzwWpQdSkHPQmugs5FOZG+Uqi11Ohn85kvUGpDSxQ6rmK6aD14ck7fEfpCvAGRN
	fnan2Ky9jpu02DOEoFd8B1f+Q+XxAWHhHSfWdteGiRP34FP+WhidGdwksKKe3eU3qB1FWUT+GZO
	twyweVV6oycIBewuKiUIULhyCCgaTBjzSia2PxA1BJk4JT7lIH5YrDcWx4ogc82St5cWVGrCk8M
	i9vVfW1ltRoRrgc6LJAF3w1vUwfuyrGHoBomTJPsEDkC3rcBEa13I4sWvPzbxRpUVCpZXTMBmGP
	OX/ZlD7KmJQFMcsTJ/MLuOyQ36weCZjfXSb960ZN2MskmJ715vYr5/Tl1c7u0QtVRtXr6/7m
X-Received: by 2002:a05:7022:238e:b0:11b:ceee:a46d with SMTP id
 a92af1059eb24-128b70a403cmr1467046c88.15.1772682125291; Wed, 04 Mar 2026
 19:42:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221233234.3814768-1-kuniyu@google.com> <20260221233234.3814768-4-kuniyu@google.com>
 <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
In-Reply-To: <g7ap5glmwfoyskarflvmuiurlm7atfbospmqp4hifumv2f4thc@bgb6vsmszzpf>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 19:41:54 -0800
X-Gm-Features: AaiRm52HICgRVA9yBp1pMCjIA_v984tORy1UIdfq4YvFSooO0AOUW58dJWgIa4I
Message-ID: <CAAVpQUD1NrXM9kRQgSOFFM4j73gg7aE7Yba6XDkdL42ZQMQESg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf/net 3/6] sockmap: Fix use-after-free in udp_bpf_recvmsg().
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 6:30=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> On Sat, Feb 21, 2026 at 11:30:50PM +0800, Kuniyuki Iwashima wrote:
> > syzbot reported use-after-free of struct sk_msg in sk_msg_recvmsg(). [0=
]
> >
> > sk_msg_recvmsg() peeks sk_msg from psock->ingress_msg under a lock,
> > but its processing is lockless.
> >
> > Thus, sk_msg_recvmsg() must be serialised by callers, otherwise
> > multiple threads could touch the same sk_msg.
> >
> > For example, TCP uses lock_sock(), and AF_UNIX uses unix_sk(sk)->iolock=
.
> >
> > Initially, udp_bpf_recvmsg() had used lock_sock(), but the cited
> > commit accidentally removed it.
> >
> > Let's serialise sk_msg_recvmsg() with lock_sock() in udp_bpf_recvmsg().
> >
> > Note that holding spin_lock_bh(&sk->sk_receive_queue.lock) is not
> > an option due to copy_page_to_iter() in sk_msg_recvmsg().
> >
> > [0]:
> > BUG: KASAN: slab-use-after-free in sk_msg_recvmsg+0xb54/0xc30 net/core/=
skmsg.c:428
> > Read of size 4 at addr ffff88814cdcf000 by task syz.0.24/6020
> >
> > CPU: 1 UID: 0 PID: 6020 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/13/2026
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
>
> [...]
> > Fixes: 9f2470fbc4cb ("skmsg: Improve udp_bpf_recvmsg() accuracy")
> > Reported-by: syzbot+9307c991a6d07ce6e6d8@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69922ac9.a70a0220.2c38d7.00e0.GA=
E@google.com/
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  net/ipv4/udp_bpf.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> > index 779a3a03762f..b07774034a91 100644
> > --- a/net/ipv4/udp_bpf.c
> > +++ b/net/ipv4/udp_bpf.c
> > @@ -52,7 +52,9 @@ static int udp_msg_wait_data(struct sock *sk, struct =
sk_psock *psock,
> >       sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> >       ret =3D udp_msg_has_data(sk, psock);
> >       if (!ret) {
> > +             release_sock(sk);
> >               wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
> > +             lock_sock(sk);
> >               ret =3D udp_msg_has_data(sk, psock);
> >       }
> >       sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
> > @@ -81,6 +83,7 @@ static int udp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
> >               goto out;
> >       }
> >
> > +     lock_sock(sk);
> >  msg_bytes_ready:
> >       copied =3D sk_msg_recvmsg(sk, psock, msg, len, flags);
> >       if (!copied) {
> > @@ -92,11 +95,17 @@ static int udp_bpf_recvmsg(struct sock *sk, struct =
msghdr *msg, size_t len,
> >               if (data) {
> >                       if (psock_has_data(psock))
> >                               goto msg_bytes_ready;
> > +
> > +                     release_sock(sk);
> > +
> >                       ret =3D sk_udp_recvmsg(sk, msg, len, flags, addr_=
len);
> >                       goto out;
> >               }
> >               copied =3D -EAGAIN;
> >       }
> > +
> > +     release_sock(sk);
> > +
> >       ret =3D copied;
> >  out:
> >       sk_psock_put(sk, psock);
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
>
> LGTM.
>
> One minor observation for a possible follow-up:
> psock_has_data() is checked before lock_sock(), which leaves a TOCTOU win=
dow.

This is intentional.  We don't want to hold lock_sock()
just to check if the queue is empty, which can be done locklessly.
Otherwise, you will introduce an unnecessary lock dance
for every sk_udp_recvmsg() in case the psock queue is empty,
which is too bad.


>
> If the BPF verdict path consumes the skb from the UDP receive queue and r=
edirects it to
> psock->ingress_msg between the check and sk_udp_recvmsg(), the thread may=
 block in
> __skb_recv_udp() while data is already available in the psock.

And this is just a matter of timing.  If it's already empty before
the first check, the thread is anyway blocked in sk_udp_recvmsg().

>
> Moving lock_sock() before the psock_has_data() check (as the original cod=
e
> did before 9f2470fbc4cb) would narrow this window, similar to how
> __tcp_bpf_recvmsg() acquires lock_sock() upfront. But that can be a
> separate patch.
