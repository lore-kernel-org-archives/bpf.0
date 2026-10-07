Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3769A3AAF50
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 02:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791341304; cv=pass; b=tf72thQcjnN8dmN5qX3OB78riRGrSRuGdfXiTcMQO+KFapXcV9KfQsttJQRMBpbAZuTL25xLges+ldJCoyIg/yQHbEAsba0+KFvzSeS2hEQvUMNjtsj4zN7UQXLxmdgrwhDbDsoApOx0RH3lz7yk/Ni5TNKJ59TSIyG3asRRQf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791341304; c=relaxed/simple;
	bh=Pol2x2aR+ztfSV8OAuK2uGHcpqU+lgY9bEO0kITZYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8QDmCrFVGY32N9bsc1uXe8rharQR7cwK+zy6zp4tLgHF1HYRkv0NPRWOSOrL12jNQnHs5VmnqxhpDwMJ32uv9+uK/hE3BBFW1Ei5PjOEuqi9HcqCDJVGOateBJfYQjzhj7573wmgi2/+pxw80PlgLLVQOWta/xoTpLcQX3pSKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GVPlaxs+; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GVPlaxs+"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-34ceab2900eso2073849eec.0
        for <bpf@vger.kernel.org>; Tue, 06 Oct 2026 19:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791341302; cv=none;
        d=google.com; s=arc-20260327;
        b=GvziEExx7f4yNxUwEDNXuaZo2g31a9YNMCi0Y2zNH7jnpCCAoozSdgOPmS1MMRQaPB
         vXKJAZ2AfTQIKeKY083E0ic5runX+NQ0kyHC4xyPYeZM2Mq1ZV3fawZ1FM1jUKz4l25+
         Q3/bVy8nlSH458tvxSxnbPao7n4mywAwC9Vco19M1xFHraOEyeVxYgi1WmEflTCVGiGF
         Bi2k8rxToITRxsNULq1CkLyTc5fsXn8l/fOYZc8+l0Yk1xwwjnLmkCbaYQaeSgLuynga
         7+ZJgMrrKhNMFAyG0CxxpfSnZS2bI+fnvPsgyiCOu9OgYARHEXDUtrE/3vMuexBhFhDf
         O1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        fh=hTyrH6U8o6oUBKeUjno5OJ0BeFEbAGaCuUWl6lv760o=;
        b=NgZgQc1szSziA7kKSJR+QIPn+U3t11PjZLTGEqJ5fpNVpRJSSKk9jz53aI4D4vSTHt
         V6zOuhWIDwQFIM2WmOc/PvzgPbcuXxj8+3yNOm4NKryp3z6ECYVkdlg5adMDcVBIv352
         veRerWs/oaFC1ZIxt6amK63tWGVpXWkipdkWeEl0Bhud9HFr2bIpEpzmrUM5xknarmkl
         HczF24ZVAhkmz4U3dkhQVsHnLEYO1bgtpZyT95Zu4x062d79lv4GU+xGvEbR/t2JM4Tu
         Grb1uAYZY+AIIZcAzgJ1dounsEQQXJ301ZWy0LdnTJ74wzGKRJukLR6D1HnGV3tM7t4Q
         y/vA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791341302; x=1791946102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        b=GVPlaxs+DS/sNjcL9tnKt90ejYEEgqLfP0MWOvpHM8KxljKtYLLw9hVvuORoGD24XN
         xMUiKfFRMZ4qZw48CkK2OUrOmvstzWYUGNSHdEswMTIrL/XvqXML9a7lN28Vz6/HoOAT
         UzvUjkLLI/6rqqdGrLFvHnniVBu10H/Y68vb+FmEJQrleC3/NU+SEy0EkaJTQlymUr44
         nzsjToE2WmJrCVOO20gp46GWQEAiQHMnJQyRHRy+/o36tQ5TLFedL6ziNun3DHekZ1nw
         giubKcYm8z5rVzI2IFSUJA3GoI594T3daEg+rPqogrjUrl2oGnVGxREGwHaHlNOT7QSd
         I8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791341302; x=1791946102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sHy1JYFdoI2r/bttA4e6UY6RBQWw0EiOqXBwtjtNkw8=;
        b=tqXymgKHZrW+DPt56ClPA1FPVCU53EYe218MVWKAK9qfxW9WQhHMUsH5HSK7Qj38D1
         tBISrUwc7WRJ8g7aqcYRQE9F+kglvydhJVsaggFeT96cZjgOV07fUF69Z5hrVX9V8e+r
         NW4Kx5Z+EKrEIKAoT71xsHWhxRxLFYjUeio4AGOQ391tVGum7q/I+SzfYdHPNpBIrZSD
         or9x4xXAENvcgP+kfYMN1SXlCSpqGigBQ17uqgEomQ+PNBqNGyiU5CCpVM1LIRB1RLlJ
         2rqvpzms/glDHGAcr/l41DwUUCFpabm+hUVEv2jNpi/Y/JNpaox3bDQeEgAlwgmfV6Q3
         rz5A==
X-Forwarded-Encrypted: i=1; AKwUvBy9l0HBz0aLHSTQWu0TyxKN0eaKJ38UcPa9myYGUxGYKcrNYtKkF2rB0orgupC/fKOfNuk=@vger.kernel.org
X-Gm-Message-State: AFuF++kJnJiobn8xm0W7OT23Dx0g6oc1Tf2Zq5mKqC+UYMCiG3Obgfj8
	ulru8O6dlUt/SDbYCYaPpcN0qvndMXuZMctjlqbERwLyrLQkRh4UuAXzG6Jbscl1x8E+SCYkEfo
	kWQad8uuqf4BYu8di+ik+kzDitHpV367ctRe0/zT3
X-Gm-Gg: AYBFou36XXIkXWOoXHNoeZogCEqk6cpEYRVn+vR6LG/W7lgMaaIr7jvnB1A/X9MD7M9
	pIaEMs358lwzWYM+IuUSy3MAcHd/A+lCyUexvcxH5zemEAUEa7suXGbmPSEAxO2DUhRrnNtofyg
	APnZwqWRAx9PaEE4oAs2Il7x3bBP9cO91wORTOvzduOJJ68o4XnbEUnTgQ2uB/EX9jFNpLVTEJn
	zRpObPfDE9ncwdfspXMoMnTB4OjEnl8MGA166jmx1TSVciuPdWNdGWpuOa0VxY13qqVjh2kJORJ
	t4ixR0Lh5F4gHTZm8Do40rFK++1DDnDv9EqLV8zL/ipmsUQ0EKfz08LFhpyIxIBBDHrtbKfpziK
	t5oFp9LLnWPknPTDLsl93Sv8/4ykSr+jgjpZgCbIaSZjtKLZSEia90FULem8A9FVY/AVdO+3AW1
	uLpzerw+jcNQi1PvSMH1MWujoVH+ffvsnIcw==
X-Received: by 2002:a05:7022:f50c:b0:13d:974:a2c6 with SMTP id
 a92af1059eb24-162041de438mr586698c88.7.1791341301323; Tue, 06 Oct 2026
 19:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
In-Reply-To: <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Oct 2026 19:48:09 -0700
X-Gm-Features: AclHuK-b4xtcvLSySTGi8doGUlPhLvVZt8LyR1rIaCDcdYBbjAPE6iawj02D-e0
Message-ID: <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Amery Hung <ameryhung@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> > +++ b/net/ipv4/tcp_input.c
> > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *sk,=
 int bpf_op,
> >
> >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *skb=
)
> >  {
> > +       const struct tcp_sock *tp;
> > +
> > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > +               return;
> > +
> >         switch (sk->sk_state) {
> >         case TCP_SYN_RECV:
> >         case TCP_SYN_SENT:
> > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *sk,=
 struct sk_buff *skb)
> >                 return;
> >         }
> >
> > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > +       tp =3D tcp_sk(sk);
> > +
> > +       if ((tp->rx_opt.saw_unknown &&
> > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
>
> nit:        ^ missing a space

this indentation is correct.

>
> > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> >  }
> >
> >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const struc=
t sk_buff *skb,
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 3ac465513bf5..8770f3084efe 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk=
, struct sk_buff *skb,
> >          * writer's bytes). The writer finds the append point by scanni=
ng from
> >          * first_opt_off + nr_written to the first NOP.
> >          */
> > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_t=
ype,
> > -                        first_opt_off + nr_written);
> > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, re=
q,
> > +                             syn_skb, synack_type, first_opt_off + nr_=
written);
> >  }
> >  #else
> >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
> > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock *s=
k, struct sk_buff *skb,
> >  {
> >         unsigned int remaining_out =3D remaining, reserved;
> >
> > -       if (!remaining)
> > -               return 0;
> > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
>
> nit: missing a space before ||

oops, due to last minute edit :/

>
> > +           !remaining)
> > +               return remaining;
> >
> >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining_o=
ut */
> > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_typ=
e, &remaining_out);
> > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_t=
ype, &remaining_out);
> >
> >         reserved =3D remaining - remaining_out;
> >         if (!reserved)
> > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
> >                                         struct tcp_key *key)
> >  {
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> > -       unsigned int size =3D 0;
> >         unsigned int eff_sacks;
> > +       unsigned int remaining;
> > +       unsigned int size =3D 0;
> >
> >         opts->options =3D 0;
> >         opts->bpf_opt_len =3D 0;
> > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> >          * left.
> >          */
> >         if (sk_is_mptcp(sk)) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 bool has_ts =3D opts->options & OPTION_TS;
> >                 int opt_size;
> >
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 opts->mptcp.drop_ts =3D 0;
> >
> >                 opt_size =3D mptcp_established_options(sk, skb, remaini=
ng, has_ts,
> > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(struc=
t sock *sk, struct sk_buff *skb
> >
> >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> >         if (unlikely(eff_sacks)) {
> > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPACE -=
 size;
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > +
> >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED +
> >                                         TCPOLEN_SACK_PERBLOCK)) {
> >                         opts->num_sack_blocks =3D
> > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> >
> >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> >                                             BPF_SOCK_OPS_WRITE_HDR_OPT_=
CB_FLAG))) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > -
> > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, NULL=
, 0, opts,
> >                                                   remaining);
> >
> >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> >         }
> >
> > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > -
> > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NU=
LL, 0, opts,
> > -                                                   remaining);
> > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0, o=
pts,
> > +                                           remaining);
> >
> > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > -       }
> > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
>
> This static-key check is not redundant unless
> bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> tcp_established_options() unconditionally calls the out-of-line
> helper, so sockets pay the call/prologue cost even when no bpf_tcp_ops
> is attached.

Interesting, I guess you don't use FDO ?

On my FDO build, even tcp_established_options() is inlined
to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.

    ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
   # remaining =3D MAX_TCP_OPTION_SPACE (40)
    ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
   # remaining -=3D size
    ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
   # bpf_skops_hdr_opt_len()
    ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
   # remaining_out =3D remaining
    ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
   # bpf_tcp_ops_hdr_opt_len()

I will add a static inline function and move both
cgroup_bpf_enabled() there and reuse it in 3 places.
(same for bpf_tcp_ops_parse_hdr())

Then, the unnecessary movl will also disappear.
