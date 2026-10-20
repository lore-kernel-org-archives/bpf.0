Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483434;
	b=f4amCNVLTlgv3rTxtPRlqZ9ECQ/VpyXrYciBjmBrHckrJ6YLG909J2paI/+14vjDPwQy
	 xZvozTu9XNf3Eti9UZ8T2p99WVzU+FvRTakaVpgiE542aF+E11IFh+TuKZi2KrFoDoHof
	 BBN0Cv04Br/R7sFCT+oHKXcrCzg2qRtORaS67G93K4H6e5QeER7/1Rpb0Bp/E1tZ+i+br
	 BQxlvarKG40rVeM7b/Fi2BHn7QdopRipOV7vU5r6Kp3A9ql/aJYlvEA5Ff5fn1Gedk2c9
	 5A8WqphAe0YZgOjCU4gu2gvJwAcGXWjnPh428jxyj5weGRZf5YUEW3rOIyS3E7i+TIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483434;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W3FYn8+t+xAEUJqETz/VS7X9J4Hf4qfbk8kiNjZx1vA=;
	b=eCszYElnJXvfnpLejTF8zdXUr2JR2RSNQZCeX1cx/Bb48c0eQqU+RIW4yJJz0D5wX/4U
	 Ux+hjFjQ+yibpfV1fmSw1QH9OAziQAzy2EwzQ2Isw4If1eLcsYcVLf23jVl1JdctLgNq1
	 35qism06TNSQtl5/7QtocYDuNbqLVmwsHrRpRTJY/puk5CKGCsioijJQAnGnIVQAwsWxw
	 /1cRKpZy6VBzvmG2SRVq70saJn+Z14yEWMV1/kcAd6HOAyyAC6MwW/y524F11ffmQ5ybr
	 5XqLSKW4ZumWC1Di8qT3irzLu/Y5xaKC1LyQp4aPHpu5JLI5XolMbHlCyVG8raC5ojg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhT4oAni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F1606A31C
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fhT4oAni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A48E1F000C5
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483433;
	bh=W3FYn8+t+xAEUJqETz/VS7X9J4Hf4qfbk8kiNjZx1vA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fhT4oAni4vhn86mJutTgjqLpl0aJZd83TwHzly3cCBGWuma3P6s2sMIzvRfn2wlJ0
	 PhRnqj8kfVvPuqchmrsJmTUN2K/TEc3OxzXgfjTBUwFU86dzMRmYqsIfGIUVqycM6o
	 AsI9+Y/hHE6VfyRJOWaWFD9qFleuNnvEDVq6Ec/KWd+/UI8zigltgozH1YkgixoXBJ
	 +J0YBHKg5k0pp8a6AzJiOQ5icBnY8sDiUvkcqCZ8T3ko+X+ED60mjehHkJUwIywG2F
	 nmksFVBkp3rgw0j2/qaF+j7nUyc/fWN86FmsJ/df1kVTSePRLAbRNkzq1tdmRI9Vz5
	 Bsb1JcF8t9KRw==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-486f013db83so990391fac.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 01:03:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwT41tPcsAZhTSGtozghFN1jzCtbkT+fjdjn2mZb6FWrl8pR1qptFzShj7BP/+W+f9BGD0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzpk5HuUIAVutl0n7ujv3XQH/t3fQ+7PqTzPqZgdPIbtFZUADJ
	jrcKHu6w71g6iS8UzBdZYj5OT4px8UDWOSzkILH2G6QPUK23jGl6Ui1mWKAy+RyHRm3BzY3H/qp
	xDbp2Nd/yO+ehHbVnwzRl1xIa9Q+w6e8=
X-Received: by 2002:a05:6871:3407:b0:494:7af4:954b with SMTP id
 586e51a60fabf-4a757974186mr7725987fac.19.1792483432412; Tue, 20 Oct 2026
 01:03:52 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
 <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com> <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
In-Reply-To: <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 20 Oct 2026 10:03:41 +0200
X-Gmail-Original-Message-ID: <CAL4Wiio29vZ1V7FavAH5dXpRQB5U=dpvaHVAjvGPc7K1E=wLEQ@mail.gmail.com>
X-Gm-Features: AclHuK_ovVSChGzHdfO5X_ok_DHLL08jkCal7WDQ-6ENaDlZb3UvzrU4iI8QpLI
Message-ID: <CAL4Wiio29vZ1V7FavAH5dXpRQB5U=dpvaHVAjvGPc7K1E=wLEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
To: Neal Cardwell <ncardwell@google.com>
Cc: chia-yu.chang@nokia-bell-labs.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, kuniyu@google.com, 
	ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com, 
	srichard@netapp.com, Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 19 oct. 2026 =C3=A0 17:53, Neal Cardwell <ncardwell@google.com> a =
=C3=A9crit :
>
> On Sun, Oct 18, 2026 at 5:15=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.co=
m> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Make the CC module set the mss_cache smaller than path mtu. This is use=
ful
>
> Since many CC modules will not set the mss_cache value, rather than
> "Make the CC module set" I think it's important to say "Allow the CC
> module to set".
>
> > for a CC module that maintains an internal fractional cwnd less than 2 =
at
> > very low speed (<100kbps) and very low RTT (<1ms). In this case, the
> > minimum snd_cwnd for the stack remains at 2, but the CC module will lim=
it
> > the pacing rate to ensure that its internal fractional cwnd takes effec=
t.
> > Therefore, the CC algorithm can enable fine-grained control without
> > causing big rate saw-tooth and delay jitter.
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/linux/tcp.h   | 3 ++-
> >  net/ipv4/tcp.c        | 1 +
> >  net/ipv4/tcp_output.c | 5 +++--
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> > index e4d1720f49f0..428d63e46206 100644
> > --- a/include/linux/tcp.h
> > +++ b/include/linux/tcp.h
> > @@ -232,7 +232,8 @@ struct tcp_sock {
> >                 tcp_usec_ts : 1, /* TSval values in usec */
> >                 is_sack_reneg:1,    /* in recovery from loss with SACK =
reneg? */
> >                 is_cwnd_limited:1,/* forward progress limited by snd_cw=
nd? */
> > -               recvmsg_inq : 1;/* Indicate # of bytes in queue upon re=
cvmsg */
> > +               recvmsg_inq : 1,/* Indicate # of bytes in queue upon re=
cvmsg */
> > +               mss_cache_set_by_cca:1;/* mss_cache set by CCA */
> >         __cacheline_group_end(tcp_sock_read_txrx);
> >
> >         /* RX read-mostly hotpath cache lines */
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index f4c9101e5996..708e1830227b 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
> >         tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
> >         tp->snd_cwnd_clamp =3D ~0;
> >         tp->mss_cache =3D TCP_MSS_DEFAULT;
> > +       tp->mss_cache_set_by_cca =3D false;
> >
> >         tp->reordering =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reor=
dering);
> >         tcp_assign_congestion_control(sk);
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 3248f3895b15..c53d70718830 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -2082,7 +2082,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pm=
tu)
> >         struct inet_connection_sock *icsk =3D inet_csk(sk);
> >         int mss_now;
> >
> > -       if (icsk->icsk_mtup.search_high > pmtu)
> > +       if (icsk->icsk_mtup.search_high > pmtu && !tp->mss_cache_set_by=
_cca)
> >                 icsk->icsk_mtup.search_high =3D pmtu;
>
> This looks suspicious, or at least I don't understand the motivation
> here. What's the motivation for this?
>
> >         mss_now =3D tcp_mtu_to_mss(sk, pmtu);
> > @@ -2096,6 +2096,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pm=
tu)
> >
> >         return mss_now;
> >  }
> > +EXPORT_SYMBOL(tcp_sync_mss);
> >
> >  /* Compute the current effective MSS, taking SACKs and IP options,
> >   * and even PMTU discovery events into account.
> > @@ -2111,7 +2112,7 @@ unsigned int tcp_current_mss(struct sock *sk)
> >
> >         mss_now =3D tp->mss_cache;
> >
> > -       if (dst) {
> > +       if (dst && !tp->mss_cache_set_by_cca) {
> >                 u32 mtu =3D dst_mtu(dst);
> >                 if (mtu !=3D inet_csk(sk)->icsk_pmtu_cookie)
> >                         mss_now =3D tcp_sync_mss(sk, mtu);
>
> How is this going to work if the path MTU reduces? For example, if the
> sysadmin lowers the MTU to be lower than what's consistent with the
> MSS value the CC module chose? Won't the packets from the connection
> all be bigger than the MTU, causing weird fragmentation or
> black-holing?
>
> AFAICT, to be safe, if the dst_mtu() changes then we still have to
> call tcp_sync_mss(), even if the CC module wants some input into the
> MSS decision.
>
> Wouldn't it be safer to propose that the CC module optionally sets a
> ceiling for the MSS value, rather than giving it direct control over
> the MSS value? Along those lines, perhaps CC modules that want to do
> this could export a new optional CC module callback that we use in
> __tcp_mtu_to_mss(), perhaps something like this?
>
>         /* Clamp it (mss_clamp does not include tcp options) */
>         if (mss_now > tp->rx_opt.mss_clamp)
>                 mss_now =3D tp->rx_opt.mss_clamp;
> +       /* Optionally clamp MSS based on CC module: */
> +       if (ca_ops->max_mss)
> +               mss_now =3D min(mss_now, ca_ops->max_mss(sk));
>
> Perhaps Eric or Yuchung will have a better idea. :-)

I have not seen the patch in my mailbox.

Chia-Yu Chang I suggest you trim the CC list and make sure to not
forget linux official maintainers.

My email address has changed to edumazet@kernel.org one month ago.
