Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425223;
	b=eHKqCDXPxa6pcqdg3Tokk5kNuYnFiRwdcqHaw2t5AKiRJ6LgJ+eZXbCFCipyNRdVyiEt
	 5lGEp0CkC5H58MALepghGsp4WLJ7vskTHgUbGz/abYpCRs77lQ+PKxmslqz45s7vDvi8Y
	 N8BIi2y2tnIg3cbL3h05Z4jcpP5XPxsMmBKRvza+eWOWdnBnvdAwgXnDf284HTtHUl/En
	 rlmi/FhlbRTkbaOiTQNf0jhnWZN1Ar8EfRP0AXgs/u8CjTTNsFeKjDFzwGRRHBG2sjEMP
	 UE5zpon5dynfat/77ds5gPXwE+XSSfDYOUd2OEM+atZ1f9vyTLfKIb+JNhyIKxIof/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6NcDKQ3CQHRlm94fb+y6wjDFmyC79P2GiX9bB2T9H8w=;
	b=5MdY7wDjO4FLOGr/bfgMaODaMLV/2vHLhenefEIPT043n2UD7wbr3FraBS6uJ/ab9PJ+
	 cC/GMW1dJtZK8426cZi4mA7c4ZFN53r2FscOEaWA1fFUVT9lSTdutzuU/OYWrQoLZJCRN
	 VMMth1QFu5zbFj+Q81afn7xiJSl15MEs+LfKTaobgOHgwPJsgmCfbGNUS/2xLV5Ytdvbm
	 JR0JzacRcS2WfhS/WXn1ehJVFTYOjDmKYUMUIsX1DYdo2F+N4e6rP7nDhQa5p9b+bxT/g
	 F+XPNj8UbqsaCtOCDB+bUCruFrUErdVLiw/jfrGVxID+C9Zw27rS/qq3cDbo3F9Z9Zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r8sjLJMI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A000606AFB0
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 15:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A000606AFB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=r8sjLJMI
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-535f598d126so441671cf.1
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 08:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792425221; cv=none;
        d=google.com; s=arc-20260327;
        b=WxsIsaeuHg2Quav7kBmhDRkXU/uhVTUzu6x20DGWu8ngs/c0eks2Lkinuhx95okRuV
         zplzC77F1TMx3hHQ8VLU+ulmmQ5EJKNworKorYwpqwG+AVfu3d8QSLUNR2Eda+P6KRZ5
         78r6Zi2ByYYRgfbu8rAHU4JfGnz0kaqdJgQgF6f3vAunao/ctj0xkQXiNDhLEZrvhX3e
         mOZ4Tm5mcTSpRjmjlAGmfydnhseXswTpCXBBgsNu7DJ6N/UQJ162pw2N5Ox0l/qDvBFE
         cTYEumxBSBuoTcS0FGF/ZOMUjwKEpiiBUJkrho86e9SZixYmwrgy/EUr8c3Ry8COAHRZ
         H95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6NcDKQ3CQHRlm94fb+y6wjDFmyC79P2GiX9bB2T9H8w=;
        fh=COoeuE3NdVZgaO2q5r80gUdTorkbN8zB0qf8GnHijT0=;
        b=EfHoARDOAcM8g8BRCRgDGlpxmmct15/jjF9o3K4s61vBXOZD9+wE1yvCrL3TcXj2pL
         NDxHla/mlmiLthtnXcl/vQ4v5s/eP2jKf21efAw/+5SOTs2e94NbH+++A8AyGvB+MNxj
         seHjSvudnIZ5jWgkTWKIrZKa8UTipe8SB96/8ggJfUJZVlhctSb2DwNKMRoqTcXPOKp1
         /5JRtZjuHBDH/M7HGN+T7A0A1F/eAtuQUN4nxE3xyVBSdn4+3CCz6Un9Y1FkKtSoOnX/
         XKJOrLvYlw0qqyJthm4pZZu6IoxjCrWJZcRaWnqxiC9+zDRG6dD2PVfB/GFldfPpaTaj
         EoFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792425221; x=1793030021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6NcDKQ3CQHRlm94fb+y6wjDFmyC79P2GiX9bB2T9H8w=;
        b=r8sjLJMIwgB9xutl6pJjP/QUzSKPFv2UXLERc+vgRpuysAuDTS7BpGdpzsjJ2JbnER
         itY8EF0HTgUsAqSSN9G5St3M5574ImYzhoKOS0qFWIi1Q3Agu/DrWReIfLWS180JmHa0
         YDse1R8q5Eq7/I578BtySMAklCURKIRdZ/AKQ4BO477lCJ4g5NN9hMSF2QvMEHufI7xN
         dwgbc80NWkZYxWmCq2JDdEro8fE30FWvEx0znIDgmns+zy7wibHU+dRmrxdOwXSEMO0r
         RhY7Fzc2oqOnmObNq0+HkSEB2f887Mxj382GFQf7rWYEop2yF6ejVDHWcn7+po/dW5d4
         A98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425221; x=1793030021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NcDKQ3CQHRlm94fb+y6wjDFmyC79P2GiX9bB2T9H8w=;
        b=Q0uGecJRfoB9xkzKEdA6OpONOXoS1aOG2YwAnVHsz9rf04nM067ORiJ711pJxB28mR
         XLClxmJEHC+cPTNxrGphhVcEO94aqIlYoAqmiFUn9VUMROXMx1/1SG1gYYX9iuvssXuG
         q8InE3hwphaVizas5yYuVTU21Dv36jn1MywR1i4ebCzhp8zV4WOqWs+29g6naVwJsPJJ
         bYRdJJXRe8+1ZvrSEdoxVlcSHLRvxai3tWYxcTVKl5J1IWJR+yQoohbsLg7l+pyvxJCr
         7HTS0/lppOv3L64sOHrrPqMLpu0RbBjf8+0MFD1pt+s52lr6gomEjEomYWg/cZHaazwd
         UA8g==
X-Forwarded-Encrypted: i=1; AKwUvBxmImkmVi8xdqGZM5CKdGGReay7K0z82uXz6gQLTJlkFNmL6syxQp+2NDXZceE0L4Ap3Qk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJigVIgJS6+VWO4YVD772zseGgKIKnQxoCKh7Q+rSMCUG1bwv44
	avsVefgfu4ZaGWHlWewqlnK+kxxERCta5D88oQ9jQJDMSQZmvStMLY5/84SFcqQQn+8llO4x2zi
	5QwZyy9gHwNULSdDh7DB9scnuFaD2SYGpBvTCM6sN
X-Gm-Gg: AYBFou2hwfNfeFmAzqw6Wm62KmNOqYf2Uzsvys7nwIRBrhsRlFHfgHqw7Lewm9txaD+
	UIkixQcjNQW4twdIYL3rlFEjSMe6EAImQaMDqGp1AOOTCxNndNznQ+u1L83eUbsJLCUR33h0lWQ
	0hTDcrmlvob7f6fP10mBkdWnZ2w8WeVp6a0vV8opV33wDPn8wly8Ndkl1ACG1OBmNHLXKwngQO9
	oO79GtOayGFyFCbqlGbHuB+4g+mZRZ3tfWYRX4XLqtkTwk6s8buKKAc4v5sWAgml1rE/srayWZ6
	fxJGSp0NZi3oM0S36ZKeukVIZx6INv/TL6Rj0RNvj4bmrYVzstTwpPikHFCc3XMs1dx/e3FEHEF
	q2QvpI2ZYLARFLEJBdI63jhU5V3szrt/jZlRdJ6G/8jLD
X-Received: by 2002:a05:622a:4ccd:b0:535:30a:76c7 with SMTP id
 d75a77b69052e-53649a535b1mr41412171cf.3.1792425220585; Mon, 19 Oct 2026
 08:53:40 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com> <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 19 Oct 2026 11:53:23 -0400
X-Gm-Features: AclHuK_1jUVxI4Ba9SwLVrMjxrP5yi_6VMujUmIp5B2h4zHaQtt1sXCgtYIXGeA
Message-ID: <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
To: chia-yu.chang@nokia-bell-labs.com
Cc: ihor.solodrai@linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, linux-kselftest@vger.kernel.org, 
	shuah@kernel.org, horms@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	jhs@mojatatu.com, stephen@networkplumber.org, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, kuniyu@google.com, 
	ij@kernel.org, koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Mike_Rudolph@comcast.com, Jeff_Howe@comcast.com, 
	srichard@netapp.com, Eric Dumazet <edumazet@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 5:15=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Make the CC module set the mss_cache smaller than path mtu. This is usefu=
l

Since many CC modules will not set the mss_cache value, rather than
"Make the CC module set" I think it's important to say "Allow the CC
module to set".

> for a CC module that maintains an internal fractional cwnd less than 2 at
> very low speed (<100kbps) and very low RTT (<1ms). In this case, the
> minimum snd_cwnd for the stack remains at 2, but the CC module will limit
> the pacing rate to ensure that its internal fractional cwnd takes effect.
> Therefore, the CC algorithm can enable fine-grained control without
> causing big rate saw-tooth and delay jitter.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h   | 3 ++-
>  net/ipv4/tcp.c        | 1 +
>  net/ipv4/tcp_output.c | 5 +++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index e4d1720f49f0..428d63e46206 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -232,7 +232,8 @@ struct tcp_sock {
>                 tcp_usec_ts : 1, /* TSval values in usec */
>                 is_sack_reneg:1,    /* in recovery from loss with SACK re=
neg? */
>                 is_cwnd_limited:1,/* forward progress limited by snd_cwnd=
? */
> -               recvmsg_inq : 1;/* Indicate # of bytes in queue upon recv=
msg */
> +               recvmsg_inq : 1,/* Indicate # of bytes in queue upon recv=
msg */
> +               mss_cache_set_by_cca:1;/* mss_cache set by CCA */
>         __cacheline_group_end(tcp_sock_read_txrx);
>
>         /* RX read-mostly hotpath cache lines */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index f4c9101e5996..708e1830227b 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -457,6 +457,7 @@ void tcp_init_sock(struct sock *sk)
>         tp->snd_ssthresh =3D TCP_INFINITE_SSTHRESH;
>         tp->snd_cwnd_clamp =3D ~0;
>         tp->mss_cache =3D TCP_MSS_DEFAULT;
> +       tp->mss_cache_set_by_cca =3D false;
>
>         tp->reordering =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reorde=
ring);
>         tcp_assign_congestion_control(sk);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3248f3895b15..c53d70718830 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2082,7 +2082,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu=
)
>         struct inet_connection_sock *icsk =3D inet_csk(sk);
>         int mss_now;
>
> -       if (icsk->icsk_mtup.search_high > pmtu)
> +       if (icsk->icsk_mtup.search_high > pmtu && !tp->mss_cache_set_by_c=
ca)
>                 icsk->icsk_mtup.search_high =3D pmtu;

This looks suspicious, or at least I don't understand the motivation
here. What's the motivation for this?

>         mss_now =3D tcp_mtu_to_mss(sk, pmtu);
> @@ -2096,6 +2096,7 @@ unsigned int tcp_sync_mss(struct sock *sk, u32 pmtu=
)
>
>         return mss_now;
>  }
> +EXPORT_SYMBOL(tcp_sync_mss);
>
>  /* Compute the current effective MSS, taking SACKs and IP options,
>   * and even PMTU discovery events into account.
> @@ -2111,7 +2112,7 @@ unsigned int tcp_current_mss(struct sock *sk)
>
>         mss_now =3D tp->mss_cache;
>
> -       if (dst) {
> +       if (dst && !tp->mss_cache_set_by_cca) {
>                 u32 mtu =3D dst_mtu(dst);
>                 if (mtu !=3D inet_csk(sk)->icsk_pmtu_cookie)
>                         mss_now =3D tcp_sync_mss(sk, mtu);

How is this going to work if the path MTU reduces? For example, if the
sysadmin lowers the MTU to be lower than what's consistent with the
MSS value the CC module chose? Won't the packets from the connection
all be bigger than the MTU, causing weird fragmentation or
black-holing?

AFAICT, to be safe, if the dst_mtu() changes then we still have to
call tcp_sync_mss(), even if the CC module wants some input into the
MSS decision.

Wouldn't it be safer to propose that the CC module optionally sets a
ceiling for the MSS value, rather than giving it direct control over
the MSS value? Along those lines, perhaps CC modules that want to do
this could export a new optional CC module callback that we use in
__tcp_mtu_to_mss(), perhaps something like this?

        /* Clamp it (mss_clamp does not include tcp options) */
        if (mss_now > tp->rx_opt.mss_clamp)
                mss_now =3D tp->rx_opt.mss_clamp;
+       /* Optionally clamp MSS based on CC module: */
+       if (ca_ops->max_mss)
+               mss_now =3D min(mss_now, ca_ops->max_mss(sk));

Perhaps Eric or Yuchung will have a better idea. :-)

Best,
neal
