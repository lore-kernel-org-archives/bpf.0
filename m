Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB94921A6
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007231; cv=pass; b=um1GlNGrzvrTVABQe1sRuBe/AO98CLOJT9iig5QyXvPPti2Iwt8gldVOWlb1XDIH2mDhzH3TC1J7CIvx1tsPa+cEz52yqC3KjfXS46L/DUVcVRjFwJ1+0F0yulQDcPBwYwvBq1cXQ5oPsjXktM6otr6fXy7E4umzQT1lxW4dxKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007231; c=relaxed/simple;
	bh=fzzbb3QnFJsxDqCdwHKZh0HE+sgF9Ktls9W4VFfaNa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQbkuEuqfB+L3CQpypitQGNXGob+reLyAYITTkdhAhA/tGLbQbvLVbToRjkrDts8vG4NgZwjgtqvT5jsH8URX0bIdsPAgWkdB0vsg7ASBf0G3XmhYWFSugseGUS1GbMOz/aAD3VePMxjWA4ooxfMBJnfUp7eQuW5NKQOwZoW3Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCRWD+mF; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCRWD+mF"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-502a98c66f7so42051731cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 06:53:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007227; cv=none;
        d=google.com; s=arc-20240605;
        b=hBH791tl8U1uHVo7QdGknqTjedL2l7+5iUQDhfgLMsVdCYMwQmNAeHDUuR7CVD8+mn
         Y+eIVeW9AH5O0qVDb756FMOrTIsiFBYoGUPRgooqbW6C3zO22ZuXU3jfTqS1XBq+yHkS
         wUxOvXuRcixovaUG7XfBs/bIuTkWrRcyVaFv+Q/myoV9K6IE911eOd/aV5VpMf4GWTUe
         +LNTfI185a+54bbuUIeHsXBM5btdo0E5NnRRLfivVrdIr4qsDgUEJJA3n+k96U5LlGPW
         hPiZd985VbS9KZju1qt+Esi5Y8ParlHqyPL0Zf5k/bk2u1bACUU8O169+7MPKh9bBgLZ
         DRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        fh=xGW8fjzb6nBtbY1psO4oe3MGXyzb37wsE/w8LTjcZqU=;
        b=WkfXB/1k/BcWW8R4+fGWquIZeTFk2aiE1rj1tSE3e+hvRYzSz/amyF7ZbCy1evw1fT
         bSHm2O/aosG3+ObIeMW/7UvXYoitOr6ln9igiFvPISl9Ou7MeO2TPxe0nAosiP5tG87k
         OTNs9LzJeG2aNVbdz2excCBq0Dm9XDq+k50Sx/xa7KhrSbWmmfoSCHLY44aJr8LrNZVH
         VN5wkWfGBYPzs1kJb6P/NKYqAgK3KRp/AWtUpNJT/Qvmsn/GkC35AebeLoaY2jrguzEj
         8uL1PE2rVEvkOK4v4r/mwCUmL11TkPqCsJomkSJah12ANRJJ8GLLdfLF404601xeQCM0
         GG+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007227; x=1769612027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        b=YCRWD+mFIOKM5HQ3+01g/xz3wtxwx5SlnwrWw6d/uiMV6QbsHYC00G3TdvAI9D0ZxM
         DDAs26O+GVH632Ai3G0rxdJK2k7b1gR2EgCcyoyQpQiYjvtH1NdsL3wEJXulolQM7nlh
         zJoNwGDfmclV1Hw/rkc+dDMIvZjqhgs0SWN2m2fHpsBcbTBwCH7LoLI1QjeWR6r3rkKL
         91yrpTuIjkt2VCPGbo1eMBFcxaRqd5GoW9M9f0pdCnp74lTJtSxaGRjJra76P1NPxq9u
         71ENWv4plPZmGy8AZDgxGA1kIKBSuIc9HaHDoS6ntwNsa2zKFDddEg7JxbvquIyEa0MO
         qO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007227; x=1769612027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c9qXnOSUTaJRqoKVmmvJ/aC55OLxhDJSo/Of+Pk4eZE=;
        b=rVvoWbE4zwT+CZ3EhYGSD7TVkBpq3hiFRdoXpdWqkKpTWfBUDv7Kk533yqyFg4Al72
         F4oE0iVmzRO1SymZCYcvRcmZsw+h03XNOcNn8trJhjRKySskDWFFxjCNrWStgkYut35m
         602sfmEOCERqbD7e9N9OxABZV5IxwS1n3a9lNUJxNPamEVUOdKh3UchE0JIyHnTc+anU
         SdQUTck/je4JMhK+XjmTbXF4D/GyuFkUF+CSArAQPYiVoSwaYB51LhTKshPf0bSNo+ip
         qHeljqyq6ZZcvOGEdEuQlObJonzxY7SqduCzDux74tGw8zb8S6NACCMZhn2gzuBoH/ad
         pDyg==
X-Forwarded-Encrypted: i=1; AJvYcCW3k7ojK9Kw7thO88MrB6k3gRjpb1E9OOAKDPuA+1LF2kcuYxruHtfAb1XkroQCSMgsGYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+JcjXDNOpqqol4As4s82z5Ll5Z0kEiFPDm1TjQHHSY0JQCvp
	cB2pnckRxQpl5t0GOtErq0HQg0vSJytRHkkDwg1OJjitdqqTXthiUYXqTV2N3uO1D8WW4LrTf1y
	gOYXZKRml86fy7n9kAyzsBbXN41gQdLIn8SpwULTO
X-Gm-Gg: AZuq6aKFAZ654l41WaM1jaV/JVuMNFT48Z5X9M8s3ZtrIqHL+F2TYTMUehnvz6W4jOV
	Bq71C1zXc28UDYa4ZOiK0QuS/HD8WQObzA+AilL2px8CuVN9wK8QxRZm9QYfAnD10ru0FqbcyGw
	Jps3e47JzMWopDWnAywtMTSssHIMXgpDgrjhupq3LeAL1rR1i5HZP87iV7r04oWrLfxpdnKeOjb
	UYcPHoZKmjv+CjRxCXhK5GBYcj8AsCst3geGMf9Vsd71Nqajmx5CePVVmEx86TePulCDLQ=
X-Received: by 2002:a05:622a:11ce:b0:4ed:a7ba:69c with SMTP id
 d75a77b69052e-502a17dbec7mr276708241cf.83.1769007227139; Wed, 21 Jan 2026
 06:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-13-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:53:36 +0100
X-Gm-Features: AZwV_QiGb7YuJm7CkwrDqLPsRX6j1FfwcEyo2MwarcIKsN7ZaUyiwGIstnxbToI
Message-ID: <CANn89iLvMkeKG_VBrJi3vA5agDxc5+VLz_L3JNT0ALsRUF32xg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 12/15] tcp: accecn: detect loss ACK w/ AccECN
 option and add TCP_ACCECN_OPTION_PERSIST
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Detect spurious retransmission of a previously sent ACK carrying the
> AccECN option after the second retransmission. Since this might be caused
> by the middlebox dropping ACK with options it does not recognize, disable
> the sending of the AccECN option in all subsequent ACKs. This patch
> follows Section 3.2.3.2.2 of AccECN spec (RFC9768).
>
> Also, a new AccECN option sending mode is added to tcp_ecn_option sysctl:
> (TCP_ECN_OPTION_PERSIST), which ignores the AccECN fallback policy and
> persistently sends AccECN option once it fits into TCP option space.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> ---
> v5:
> - Add empty line between variable declarations and code
> ---
>  Documentation/networking/ip-sysctl.rst |  4 +++-
>  include/linux/tcp.h                    |  3 ++-
>  include/net/tcp_ecn.h                  |  2 ++
>  net/ipv4/sysctl_net_ipv4.c             |  2 +-
>  net/ipv4/tcp_input.c                   | 10 ++++++++++
>  net/ipv4/tcp_output.c                  |  7 ++++++-
>  6 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/netwo=
rking/ip-sysctl.rst
> index bc9a01606daf..28c7e4f5ecf9 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -482,7 +482,9 @@ tcp_ecn_option - INTEGER
>         1 Send AccECN option sparingly according to the minimum option
>           rules outlined in draft-ietf-tcpm-accurate-ecn.
>         2 Send AccECN option on every packet whenever it fits into TCP
> -         option space.
> +         option space except when AccECN fallback is triggered.
> +       3 Send AccECN option on every packet whenever it fits into TCP
> +         option space even when AccECN fallback is triggered.
>         =3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>         Default: 2
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 683f38362977..32b031d09294 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -294,7 +294,8 @@ struct tcp_sock {
>         u8      nonagle     : 4,/* Disable Nagle algorithm?             *=
/
>                 rate_app_limited:1;  /* rate_{delivered,interval_us} limi=
ted? */
>         u8      received_ce_pending:4, /* Not yet transmit cnt of receive=
d_ce */
> -               unused2:4;
> +               accecn_opt_sent:1,/* Sent AccECN option in previous ACK *=
/
> +               unused2:3;
>         u8      accecn_minlen:2,/* Minimum length of AccECN option sent *=
/
>                 est_ecnfield:2,/* ECN field for AccECN delivered estimate=
s */
>                 accecn_opt_demand:2,/* Demand AccECN option for n next AC=
Ks */
> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index bf7d3f9f22c7..41b593ece1dd 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
> @@ -29,6 +29,7 @@ enum tcp_accecn_option {
>         TCP_ACCECN_OPTION_DISABLED =3D 0,
>         TCP_ACCECN_OPTION_MINIMUM =3D 1,
>         TCP_ACCECN_OPTION_FULL =3D 2,
> +       TCP_ACCECN_OPTION_PERSIST =3D 3,
>  };
>
>  /* Apply either ECT(0) or ECT(1) based on TCP_CONG_ECT_1_NEGOTIATION fla=
g */
> @@ -413,6 +414,7 @@ static inline void tcp_accecn_init_counters(struct tc=
p_sock *tp)
>         tp->received_ce_pending =3D 0;
>         __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
>         __tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +       tp->accecn_opt_sent =3D 0;
>         tp->accecn_minlen =3D 0;
>         tp->accecn_opt_demand =3D 0;
>         tp->est_ecnfield =3D 0;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index a1a50a5c80dc..385b5b986d23 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -749,7 +749,7 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dou8vec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
> -               .extra2         =3D SYSCTL_TWO,
> +               .extra2         =3D SYSCTL_THREE,
>         },
>         {
>                 .procname       =3D "tcp_ecn_option_beacon",
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 8b774019a3a6..472bd57913ae 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4863,6 +4863,8 @@ static void tcp_dsack_extend(struct sock *sk, u32 s=
eq, u32 end_seq)
>
>  static void tcp_rcv_spurious_retrans(struct sock *sk, const struct sk_bu=
ff *skb)
>  {
> +       struct tcp_sock *tp =3D tcp_sk(sk);
> +
>         /* When the ACK path fails or drops most ACKs, the sender would
>          * timeout and spuriously retransmit the same segment repeatedly.
>          * If it seems our ACKs are not reaching the other side,
> @@ -4882,6 +4884,14 @@ static void tcp_rcv_spurious_retrans(struct sock *=
sk, const struct sk_buff *skb)
>         /* Save last flowlabel after a spurious retrans. */
>         tcp_save_lrcv_flowlabel(sk, skb);
>  #endif
> +       /* Check DSACK info to detect that the previous ACK carrying the
> +        * AccECN option was lost after the second retransmision, and the=
n
> +        * stop sending AccECN option in all subsequent ACKs.
> +        */
> +       if (tcp_ecn_mode_accecn(tp) &&
> +           TCP_SKB_CB(skb)->seq =3D=3D tp->duplicate_sack[0].start_seq &=
&
> +           tp->accecn_opt_sent)
> +               tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_SEND);
>  }

tcp_rcv_spurious_retrans() has two callers.

tcp_send_dupack() checked dsack is enabled.

tcp_data_queue() : No such check.

So I wonder if tp->duplicate_sack[0].start_seq could contain garbage ?

Perhaps test tp->rx_opt.dsack ?

>
>  static void tcp_send_dupack(struct sock *sk, const struct sk_buff *skb)
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 042e7e9b13cc..0cbba38ea87a 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -713,9 +713,12 @@ static void tcp_options_write(struct tcphdr *th, str=
uct tcp_sock *tp,
>                 if (tp) {
>                         tp->accecn_minlen =3D 0;
>                         tp->accecn_opt_tstamp =3D tp->tcp_mstamp;
> +                       tp->accecn_opt_sent =3D 1;
>                         if (tp->accecn_opt_demand)
>                                 tp->accecn_opt_demand--;
>                 }
> +       } else if (tp) {
> +               tp->accecn_opt_sent =3D 0;
>         }
>
>         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> @@ -1187,7 +1190,9 @@ static unsigned int tcp_established_options(struct =
sock *sk, struct sk_buff *skb
>         if (tcp_ecn_mode_accecn(tp)) {
>                 int ecn_opt =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_e=
cn_option);
>
> -               if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail=
_send(tp) &&
> +               if (ecn_opt && tp->saw_accecn_opt &&
> +                   (ecn_opt >=3D TCP_ACCECN_OPTION_PERSIST ||
> +                    !tcp_accecn_opt_fail_send(tp)) &&
>                     (ecn_opt >=3D TCP_ACCECN_OPTION_FULL || tp->accecn_op=
t_demand ||
>                      tcp_accecn_option_beacon_check(sk))) {
>                         opts->use_synack_ecn_bytes =3D 0;
> --
> 2.34.1
>
