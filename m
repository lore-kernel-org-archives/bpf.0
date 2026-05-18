Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C380C372EE9
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112444; cv=pass; b=PnL6uOzFEIG1DCx0aRXHl9/PTVnAtKEbRTig4qbdKV803ZpeeG3YtQVQX0Waa1nmhNwYlwnW86oHMvI3OerxZvHnr8M/3pSF3xe+8MC+gG/P/3ipPlEM68sxXegfnGKcAjfJ90H57Qbft/Fyj7YKRc/2yUnZnjseEDUSPr8qh9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112444; c=relaxed/simple;
	bh=TmD28ZM4swHtfnvSp7BEh2wcnOTb7f4zOQZTyYX2jGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EspyRkr4Q54cRJFqnmf+pas82d6TP6CJ3Sjmbom21ZLhMubfu3/tqwL2XAmKW0ifS+mheW0Prw+TqRfE1YVGoiLxN8RXN5PPHvrw/VmFbEN8w/Aiy99tE+vVn9BGgCgVrWNhFaFljlGeAo0o+GZK5lkQJFQ1JOgllhGTunQEqic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzKagooh; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzKagooh"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa1b2327c8so2206633e87.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 06:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779112441; cv=none;
        d=google.com; s=arc-20240605;
        b=XZkGiswGUVgeELvUc3YEBaT0qcR1bhx2R6WfhkJdlsCqKy3FtTmmN2MeCnlZQDU8E5
         88Xdkr47bi9HfQ/meQ6u0pQa+VrdW4U5gDrhCqmhfDeidE6LygDs4CtMTzmgjhdeGCxY
         bMhkkGN5JFqEV+8Mm0IO+/0+Fw2zjAMw0ux2Oz7NdzLqmV6VEME+7tfytX0p8vVfcCwJ
         kVch8O/KARR0bkUFAkRXSlAyM3wS2H1G3J+3HiVavdGC+AzdvNWs1YxCBiAHUZPymFgi
         ByVSPccPX2JlvvfR24pQi4lMEAxBz3HFfi4dE5K+FriCIER3Jb2QPc0K+DGQRDYDumja
         z22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        fh=y50dByX9qlzxZMDiIkTNxAjQsKoJasfU9omqLhG3rvo=;
        b=Z1i9eO2NUdUNfj189AHvj7CEc+d+HMOF1qS8gFprP+PVtCrZQbKWBoeL+Hx2eUTtIn
         n0RAYOS3n8CaUUAMqoHiKLlyEWEiE4gz2ILRXm+f9tMA5y3Bd6aAzwFZOnfOgMpJB1UA
         wSBMDPhYV06fVBbJUut5G5SbZNqBI9I+tDhiRAHyNMHZRbguoLRolGSsnwjQyBgMh9+d
         7Dfbv0KNB/xcLCYwaaAvOGJJdvX/CnNdX/nKx/7n7bv1ISWiWYPJ0jQrHtZtpW4jxfVp
         KasjPxPBJgoZBFaK5gMfW8KlIWfz0nRBCY0oQZMyTWGNCoZSeSxusRlT/0HKFZJA6l82
         GP5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112441; x=1779717241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        b=bzKagoohnB1y/ezP83W/3ILMs/mUsKluFV4HwNPYfwvdUavWnm+JlYMpx9/2x6pR9q
         RIRHHE1AseLklgY1PGLani02Y4wuxHaJqXrjW7HhkqrtAMWSRwkSdOh9MS568hRekp2C
         eV8IX2cC7hnPe13jS0TLrmYj8p54Ca01zb86IRvkMV6rvK4Z4bFHRL0uR4pOYXqCRgzC
         ErIxZGC/cTuRmdU1L3iv4bVbl59kKUFL1Hljt4EEeZwBEuSnnGcb9hVCMNRHNfMQYMnp
         0WTFnzwVI6jBcRWbeJI5+OrCqxnVsTd4wc5L9Gc05g4j5fdWdpwwShEzFd5QmNeNBrxf
         R7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112441; x=1779717241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RFk/FYkO4eFAk9o9pHJjJBzIhmqttrEmir/vP3Hc1t0=;
        b=prmBAEg1y3H8opvBix/jPXaWbRT2vcsOWPCPwwmIxaSLGGX8Dp2w+gChugT5c38niS
         0l0Y8P5d2RULPUer/mjn3aO94oKiQSMr0HG7nYfTjBK9zIkYVk5T/XrQSHDZ40aRnyf5
         hZ40xsQWzZ/A5rVlA2zeUf2p6yBSE0f9LNjBLmtakiBmKMXf0vXwo00tKQ9RkRbFb8nH
         CvhKUjgp6PT1QictOw1Mnf5OyChcj9FgmDwnWJTkWiypz6BnUSEXf5Bh8VSC4X3imhal
         lJwj0ZNkvq5FKfGsCExJCdFKENVHn1xpNJPx4emKJhf/xjdP9Zhi9f9RttYN24Ui0zVc
         Hszg==
X-Forwarded-Encrypted: i=1; AFNElJ8kB4E01FI6OzHwx6nZ6cWH14Xb68ezr8sGON1RY9/zCq5Q56rbhpQZ3G3jAOykmrxSUqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAcfZvK5x3q4wJ/Ejv5Zc7zJxY2/u8+h+If18wokF9wvoNRor9
	aZZauJwtInkdPnKYlILnF6mY8ajUsUwy1P+fx9nGpFvOD4rXmunqXheH0JzVZI4MDfsmC+o0496
	q0XEqcp9pW5OrOMBUCAiUN+EZ5kH2y2k=
X-Gm-Gg: Acq92OEYo+gOLAviFC/9Qdec3VWggRP4vI5hN7Y/6Y5zrv325w4D8gZtxztwNtXZCo8
	6qM2aHjpe8nflPo8tjTwMKivtR75Q0Xd8I83lKbTgt2WEYjF0KAHfAYd1c48O24AuFHN0T5Bc+D
	OG2IftKCUPrR9SIMeOKz804IaG+7w8i4NBRslIhYkL3TU1mdSbG2F4x8XLC1NEg2qBWMs5FG+mW
	mNbZ4lhLx6sdilSrZkdm3Tx2srz7d/Zk2tc7svbxsGRfmNECaHB0E5rI3dvzrh1Kl9zMhfiwO5p
	EGvcNsCjFHFXRzj1plSajCJRVrQ9hGglR4wYG8w=
X-Received: by 2002:a05:6512:10c9:b0:5a8:6f10:799c with SMTP id
 2adb3069b0e04-5aa0e7305demr4625853e87.21.1779112440555; Mon, 18 May 2026
 06:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com> <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
In-Reply-To: <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 21:53:22 +0800
X-Gm-Features: AVHnY4K-swb5msmI4aJefZbnvwlj0XzxaGYnWrFJPaZmGuIjZQLaUMRdNs14Qig
Message-ID: <CAL+tcoDRSpVsiCym+DYsGLBGrdEuim7AZqyBTHYzd-OSBki5-Q@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, kuniyu@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 9:01=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
> On 18/05/2026 10.23, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two if statements to accurately isolate bpf timestamping and so
> > timestamping. They can work respectively.
> >
> > As to so_timestamping, only add a loose condition via report flags
> > to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> > and performance impact. If the loose condition is hit,
> > tcp_recv_timestamp() is able to handle the exact case and doesn't
> > hamper the existing timestamping feature.
> >
> > Make it work in TCP protocol.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   net/ipv4/tcp.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 21ece4c71612..64c69bb3578a 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *=
msg, size_t len, int flags)
> >       release_sock(sk);
> >
> >       if ((cmsg_flags | msg->msg_get_inq) && ret >=3D 0) {
> > -             if (cmsg_flags & TCP_CMSG_TS)
> > -                     tcp_recv_timestamp(msg, sk, &tss);
> > +             if (cmsg_flags & TCP_CMSG_TS) {
> > +                     u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +
> > +                     if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> > +                         SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAM=
PING))
> > +                             bpf_skops_rx_timestamping(sk, &tss,
> > +                                                       BPF_SOCK_OPS_TS=
TAMP_RCV_CB);
>
> Does this mean I can enable timestamp reading per cgroup?

Yes, I think so, but I didn't try. One of the natures of sockopt
feature is supporting cgroup attach.
cgroup_bpf_prog_attach()/cgroup_bpf_link_attach() is probably
something that you're looking for.

IIUC, you can attach the prog onto the cgroup where all the sockets
are set using the bpf timestamping function. So the current impl is
cleaner and has better isolation (to filter out those unmatched
flows).

>
> In Simon's netstacklat[1] tool we are forced process all RX timestamp
> (hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] on
> the cgroup IDs that we are interested in (which is a significant
> overhead, as this is deployed at Cloudflare production scale).

I can feel the pain when filtering in this kind of relatively hot
path, which is what I'm trying to avoid internally. What I've done in
production (to cover those old kernels) is to just let the kernel
print the information, that's it, and there is an agent continuously
gathering the data, doing the match and computing latency. But it's
overall complicated.

Many thanks here, I'm always interested in hearing more useful and
real requirements and fancy ideas on how to monitor the latency :) Now
I'm still struggling to port the internal functions to bpf
timestamping.

Thanks,
Jason

>
>
> [1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat
>
> [2]
> https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/netstac=
klat.bpf.c#L484-L488
>
>
> > +                     if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> > +                         tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> > +                         tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> > +                             tcp_recv_timestamp(msg, sk, &tss);
> > +             }
> >               if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
> >                       msg->msg_inq =3D tcp_inq_hint(sk);
> >                       if (cmsg_flags & TCP_CMSG_INQ)
>
