Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606D4AAC5F
	for <bpf@vger.kernel.org>; Tue,  6 Oct 2026 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329133; cv=pass; b=O33SPCbXFi8KE2zizdb2BATKHOvbEDWpEmP3APQR72xPJqjeMQKDcaOfzjgPmOcS4ABekdpT5G2li66xsILr/xd/j9k2jLZG+5nRzVM6tjbwg10b7UWw020iUBrnlgZAYwkm6CsFQSCkSVJ6PFsm9CW35KSL7LDuxO6biSoAg3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329133; c=relaxed/simple;
	bh=nYcULYfEdDzmeSu0pDDBPcqBiPOmapdgJxIx7pmhvO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3UYbH6j9E5GLCkxBEy3Zzemxug++M8pucKE1ZD/boZFSACyADY2JUroJkouZKRTGgaVgGSKjBuFsbilHwYk63Yqwn4/cdb8gwMvIRIcXnn4C+retW7LU6ArdO0jafb0OmtouaRz8GVaRRkQO7QNu7fHjplkb4NSSN7jqmeuWzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHIBwUdt; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHIBwUdt"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af173320f9so1921673b6e.2
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 16:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791329126; cv=none;
        d=google.com; s=arc-20260327;
        b=USsSvcDYr4yt1HTSqU08QDYQ3+UYUlPHkXThcVVw1MfR/TcLLxV88fdconBtNBovFi
         HMY7QuDM2NaMgrpa5w+nH+JR7tmkky5AMoGg+LwKN75Xsajt7bd8PxrLL08oM5qvQK0S
         GtmVeyMKej9kJhHAL9VOFLhdLv42ywgrXehlvQDTyqr9C0pKgS3w1I6z4xI0WxU/bN/d
         7pjAy/CvcGljdt+TkELoOV+l8BqvBjuZV68BeJ5eMtCYquLRZTmQYQPcrI/EYEmB2MrO
         kPkZM5Ep+d1xMedh6wyPcRgsmyVVmM4stXEgmO1QNIZ1pv6QeRRfKffDeg6meiAY/sMx
         Za1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x6GV3gTC3wfe8RciTPNnTcrYnACROBOjZbQz4xVGm+M=;
        fh=+akM09fufzlUkjOi/FPzeTYe1HcqhTGIr9RemmzNQ8g=;
        b=X0XQYjZsAkSME8WKKXw+/e18n93jSX2IOp9TJUK79IibAecrC/DXtzdMTqnam5UX7O
         vLb9aHxBcEsn24+oQsyopsCr6o5YFOGoHTt6wN7avz/hTdN8+HVu6c3KZyU5XKlAZ62V
         MhVQOwdgxv2U/KCaAlNpUGJ0znF5WgWctT1D38PbHum6eLjjG9Zv0rdnXvjvgx+PyS0D
         ChUcRemFfiE08AsM199wAN4UoPeieSLtVMoO8qf4zEi3JWJ60vL5swak+e3Pwh/yJvWl
         5wyc57hQFyaKhEinozR96dbCDsSYpbECu/4TSAiDOWnBj8ppWtI0w/Ak4dXCoK/FBFbX
         gFNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791329126; x=1791933926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6GV3gTC3wfe8RciTPNnTcrYnACROBOjZbQz4xVGm+M=;
        b=iHIBwUdtU43S8ziJ80ZjPjS77/ANXboMNhkHYrVUZQXqt2VthFa2Z+uOdGqhDsPW29
         m+tVymLxGFsAZvUPCXRY5imGr+zAFsmaLIg7ebQxNMAyZfcmfcVoo8DL2W9RUmqd6vP3
         Xozud8iySWBhk6EfT3pziL0efT8R0IU6GON8dfKseTOlvuixsS7Ewrm36CHx8zakhOY3
         MBL2IdmLk5ZV+Y42m7KIpvU9T87em5jCsWMoqZXvqhnscH8b9dQskr0wwMgQOijkBIzI
         hx15lElkcatk6zu6yG2i95xflIR7iRhpS0Zul/14TfpBGTqqb/iL2AhKTHShBSuGBb2o
         cCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329126; x=1791933926;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=x6GV3gTC3wfe8RciTPNnTcrYnACROBOjZbQz4xVGm+M=;
        b=A6ux6cH2dVxRAqceOan2Cmp/AgyRNozmF6X52rXnadG7qetHGmFi0xc31M5ZMO8Co4
         HoxBmU9SOGA4YT00q+y2ITiQeu48hzKx77ue3bK+GgvHAXWwBzxrQuZlmqOcIrvqynW0
         hIv0HcLmlpSH2as7L7N9YzXp4biYQIsIri7754Sbba3L8cXP5zY3FYqVDphLvdb+rYs7
         mugaubyx7D8BEVO5kdP8Y5sGD6GLxV1YNRwWdzpuPnnd2Yw9QaDtE4cQs4A6Wgz64v1E
         xEtAgnctCm9UyXrmpPiw/+j9anNLtsAwq1j4wwk9H6sUxLeI+Zh+0wtZ9fydJoqPDl/g
         WPMA==
X-Forwarded-Encrypted: i=1; AKwUvBxuH1wkg+r4JYR2IrGIe6STQpOlWlTC8+eLog0PAD+yBVO0Uw8INjRqcJzm/BlRQWEI3OU=@vger.kernel.org
X-Gm-Message-State: AFuF++mFgnsI84JonA2VxlhciSwWE6fcDl7LjG46woSvMP9Kh2yOw8MJ
	EbPZhZbumni4RO9YlxiobopanW2Hn0RXNMpPkSooPh7KbenF3k1gNR1sxhQ4FmjdTERX+IG89bB
	us1CT60qreU2GOcsFQ0+Pg7NwWiyK0AY=
X-Gm-Gg: AYBFou3v2LRMLGh9VnandrUGckupCWvq7Qsi+jqebQxJBhaYniYgjuQ0RSW3mIp+1LS
	mht+tgapxDKkmhjdt2BccQ8hg1w9sxRudIT+lY/D8dNdc//Fkkk8dEU/2xFjzo1addhPFU2Y8sb
	B6BJCrDHqEAip/goBHnxdRDNNcGA985na50UwBPfADgos/nwCWDRGYKvXNZKvWtXMHZDyktlVQh
	Pdy/MC8bWvXRPbwK9sCVjEC2sb/osryXyEvvLLIXTIgNe58LwquCFx7RGgAfwS/z8nlZ/JxLElR
	o1yqiMORtOKERHmYhMjDNn9HPzk0W41PVZ6CEfs5DxJRUcQmJrGpghc=
X-Received: by 2002:a05:6808:67c6:b0:4e9:3412:14ac with SMTP id
 5614622812f47-4fc45857e8amr757775b6e.33.1791329125868; Tue, 06 Oct 2026
 16:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-5-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:25:14 -0700
X-Gm-Features: AclHuK9Vr4naT76fnHoo636tOW_1eN_We1Tb3-SYcXExkzUZkg_pjY5LkVk6gR8
Message-ID: <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> +++ b/net/ipv4/tcp_input.c
> @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
>
>  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
>  {
> +       const struct tcp_sock *tp;
> +
> +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> +               return;
> +
>         switch (sk->sk_state) {
>         case TCP_SYN_RECV:
>         case TCP_SYN_SENT:
> @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb)
>                 return;
>         }
>
> -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> +       tp = tcp_sk(sk);
> +
> +       if ((tp->rx_opt.saw_unknown &&
> +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))

nit:        ^ missing a space

> +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
>  }
>
>  static __cold void tcp_gro_dev_warn(const struct sock *sk, const struct sk_buff *skb,
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 3ac465513bf5..8770f3084efe 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
>          * writer's bytes). The writer finds the append point by scanning from
>          * first_opt_off + nr_written to the first NOP.
>          */
> -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_type,
> -                        first_opt_off + nr_written);
> +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, req,
> +                             syn_skb, synack_type, first_opt_off + nr_written);
>  }
>  #else
>  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
> @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
>  {
>         unsigned int remaining_out = remaining, reserved;
>
> -       if (!remaining)
> -               return 0;
> +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||

nit: missing a space before ||

> +           !remaining)
> +               return remaining;
>
>         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_out */
> -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
> +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_type, &remaining_out);
>
>         reserved = remaining - remaining_out;
>         if (!reserved)
> @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>                                         struct tcp_key *key)
>  {
>         struct tcp_sock *tp = tcp_sk(sk);
> -       unsigned int size = 0;
>         unsigned int eff_sacks;
> +       unsigned int remaining;
> +       unsigned int size = 0;
>
>         opts->options = 0;
>         opts->bpf_opt_len = 0;
> @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>          * left.
>          */
>         if (sk_is_mptcp(sk)) {
> -               unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
>                 bool has_ts = opts->options & OPTION_TS;
>                 int opt_size;
>
> +               remaining = MAX_TCP_OPTION_SPACE - size;
>                 opts->mptcp.drop_ts = 0;
>
>                 opt_size = mptcp_established_options(sk, skb, remaining, has_ts,
> @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>
>         eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
>         if (unlikely(eff_sacks)) {
> -               const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> +               remaining = MAX_TCP_OPTION_SPACE - size;
> +
>                 if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
>                                         TCPOLEN_SACK_PERBLOCK)) {
>                         opts->num_sack_blocks =
> @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
>
>         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
>                                             BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
> -               unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> -
> +               remaining = MAX_TCP_OPTION_SPACE - size;
>                 remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
>                                                   remaining);
>
>                 size = MAX_TCP_OPTION_SPACE - remaining;
>         }
>
> -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> -               unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
> -
> -               remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
> -                                                   remaining);
> +       remaining = MAX_TCP_OPTION_SPACE - size;
> +       remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
> +                                           remaining);
>
> -               size = MAX_TCP_OPTION_SPACE - remaining;
> -       }
> +       size = MAX_TCP_OPTION_SPACE - remaining;

This static-key check is not redundant unless
bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
tcp_established_options() unconditionally calls the out-of-line
helper, so sockets pay the call/prologue cost even when no bpf_tcp_ops
is attached.

>
>         return size;
>  }
> --
> 2.56.0.360.g66cac248cb-goog
>
