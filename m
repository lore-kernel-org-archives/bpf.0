Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7D3A5440
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791425415; cv=pass; b=jeYQlBmFMMZ1/QRw6RWhoRAB0U4CWr5s9MxmyTALq6pGbrDJMbpoBtHqVtE7aF0kRDdjW2serLGT0u4vszUe5bpKZOwGD+IgEu6wITfj3ildBdU4UglsS3MQrZ+y7wjNnI3iOwRvE4h8yuUHliY8OMZ2K94y1NWJDDb5j1psCNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791425415; c=relaxed/simple;
	bh=ZOVaJwmVYAzFkFw1CPFhggqT+fTktUCLy+BYC7fgQX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NHuEM5bigXKsVNjirETSCsJvPK59vm3c2fbHEueOyOp31zBxliqfjn/MxZ9w8GBA5O+tRKfw4truqCZm3E/nGcbgjrjXgd6U6vZu502pPsNkxBCqxyXgXj/yOYK4knLYtChwkiBDI20xTfUrgxHEVVEbRo0dHOy+PMvtC7sAXOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpirUKNr; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpirUKNr"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-16079d54c17so1650050c88.0
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 19:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791425413; cv=none;
        d=google.com; s=arc-20260327;
        b=lgrd6InIXUABElaJDYoy6p51Z+41njcKHDehL/k0qIxyLqwUyPIhHnytJ5hp4Dx+K7
         1jZsWcgvJqQkqsRmGzQZR0U+9KV5Gi8N+qx0fUC8BoSVCn/vynCziHAP4/EQufs1LF8O
         bayKY0urbVf2KExxViFueFUnaqUK+yWXKiZ4068jZziJ89entaoX1LQ+3sEcTfunqJqg
         A9AXK8UdTbjaf5IrKxzUVHoFi0slaSipaCDzu+BJw/+rZpIZSKI8iQbw0wwAJ7LSIn5X
         BkcRJ8O9hq/GXFfXD/M0YBCZA4L1Ko8kWJUm4Ga33t3jAGWo7NWNDXa6f1XgITvuZB4T
         42Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        fh=wDGPnY2avkT+P4SHczPTuDtkGM0JjzKvV2Sa66gXSow=;
        b=QXlyR7HOWKT0gySxirwissKPh6wqTeDCMroRH3Uu//RoRXlmAjADcl8l/7jZbNfafz
         nFe0s038E8P0bIunPtsYB9O1lmXEBgYSEm/3E+FvQLyRTIcpsYXCd/NcnhuZXycYNzmL
         BApo0zUrmae9RFHlihJWu1acn064LEKvPbq1H7+wqGugTOO0oWQIRlQOmnLH7l5q77Hg
         h3Cvp4TozpANvGuXxDfCTj9HsG4DQmv/u6XSj1lSwcw2+WYwy33W72N/dCsPO9hvKTNu
         JyrvxwTqLKWeiPS49KOV/PFwp7C27E5nLKZAH27r8447TvhrvfM/6+uMa6K1QKbNijWf
         3wow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791425413; x=1792030213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        b=dpirUKNrDGrXQMLLlBjlCBHH9w2eN6FVWnbCACPQpp+4CB42/hI1lquJ/DCnzqecNu
         va6/U0aF3o5W+J5UVnmbuZrhAj+vKleNE8JFjBLw+/jwW+h0Dm82c9p5dAFTeT+k+gsw
         kqQdO0Zd2SCtLj48LfB8BatXapFL0VGL1vDUxg3AudocJWqOTSuYu40em5sp/riCYSQX
         YxbTkcZ0oOkh8iOKkv2HTNIynn3BMZU6x0V39K5k5B02WZNbGaQTKd2M3fzB2ocugYn5
         zLG6CfDFqbAQqsAPN2g3pZwFJ/52ZeW5jn5T7t7bwpBAyjHuvZ5W4N/hr5GP4ixeEiMf
         jzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791425413; x=1792030213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFZP461PmZ8EPveXILwgmKH/qLivHDnih8QZEqAhY6Y=;
        b=zNdbPf1XF6zYM7q2e8z6NXA6ecVeFPSF2o0lfaj/n6UoqkVd5H4c4JoQrBWaJsmBIa
         fcjejKF8BWqVblPLHvbwACI5FJbyo5EpB9nZoJTuFxiWiwhP4uDfzZyoM5Wo025GRo+M
         +vhPfbF/k6krrCgwJ5uGb24RngGbpTXDl3ZZPh5VMt6WqbQTq8EMDsrSyzGeMubf7RB6
         2K0h3xkpZlnJvZt5GXKH2aLOtUnoltla1bxSWba98ZWnmPvlTeoXxdIr59c4Lr4BUD53
         F15F9U/bkxWX1Frl6jxiRFrQBcpGs7Bbp9bVnDG5EQpQjx3BOUyXuPL8l1TZsUHAyEws
         CPhw==
X-Forwarded-Encrypted: i=1; AKwUvByw/Js1uejacyR4PihoCEQ3OO+w406SufdArMxZTuAFyOGl1NK2qWpewYvLTU1RmhFRsm4=@vger.kernel.org
X-Gm-Message-State: AFuF++mtG+WY4o4Lu6id4cAA3I68U2h84MeFE8F1/M5ql94N45M/lgxL
	dwIOsA0Rqr9GM+dzl+5Gmx4yWpmBP/M+7LOMxJbn6aY+LhQttbfp0FERiT6KSvBhWkhe3V0DvXR
	/4uLuc+ge16FBjoZ4M4mmi69Vma1VmK0+PF5deu/d
X-Gm-Gg: AYBFou0rf8mKkv7b83i63f4QiBjwpwQZKA+Mc8zEjf5dwsg4gaz8qWYiU7mHlwkwlmE
	DOUFq1W+0xKK1luoYCi7gf0nLRsGOtcJ69cD9whDQLEovNnMneZALcIne8yLcEJalcWsVY9bMXQ
	MuNKfq/QtZAAhhlQacILs52pYCRMKLD/8f0I1q7bE8OFUHdgUxRL2RCM8iHV8Q9vjmccFbmcHUH
	jGc/gilPC9AkKAnA1u5aQEsd2tUSGeYcz1VhlhDz8TiBSTngDLUrK2/+ReWe9cWCeuhfmnlhINq
	02Bnxgu/95DzAKLF550ebPcHIknFaGjdTYXXmCMmP6lvvi8GG99bGCQ0/b+y7bYIITAG3zDsiIy
	M0FZteEWzEW+uHlkLm/c3P7EG/XZjXtw3OUwWkoV/4ZDA0T+wE8mP7tCyUhZ7hYJsBZIDgRSWkb
	AkJ8RbGoabDamSeBHIVdTj4+EM
X-Received: by 2002:a05:7023:903:b0:164:475f:1a07 with SMTP id
 a92af1059eb24-164476e5caemr3086317c88.1.1791425411194; Wed, 07 Oct 2026
 19:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com>
 <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com> <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
In-Reply-To: <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 19:10:00 -0700
X-Gm-Features: AclHuK-XZFetzrUoSNSyi7ByTn6WwEK8QHUZG2LiUx-VNosyEMhEXX5eGB7K85Q
Message-ID: <CAAVpQUCmMNUNnNfBMVNpv84T3+7mKM7qtbN2Xke=V4RgyUp9dA@mail.gmail.com>
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

On Wed, Oct 7, 2026 at 3:36=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Oct 6, 2026 at 7:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> > >
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock =
*sk, int bpf_op,
> > > >
> > > >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff =
*skb)
> > > >  {
> > > > +       const struct tcp_sock *tp;
> > > > +
> > > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > > > +               return;
> > > > +
> > > >         switch (sk->sk_state) {
> > > >         case TCP_SYN_RECV:
> > > >         case TCP_SYN_SENT:
> > > > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock =
*sk, struct sk_buff *skb)
> > > >                 return;
> > > >         }
> > > >
> > > > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > > +       tp =3D tcp_sk(sk);
> > > > +
> > > > +       if ((tp->rx_opt.saw_unknown &&
> > > > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > > > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
> > >
> > > nit:        ^ missing a space
> >
> > this indentation is correct.
>
> Sorry. False alarm.
>
> >
> > >
> > > > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > >  }
> > > >
> > > >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const s=
truct sk_buff *skb,
> > > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > > index 3ac465513bf5..8770f3084efe 100644
> > > > --- a/net/ipv4/tcp_output.c
> > > > +++ b/net/ipv4/tcp_output.c
> > > > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock=
 *sk, struct sk_buff *skb,
> > > >          * writer's bytes). The writer finds the append point by sc=
anning from
> > > >          * first_opt_off + nr_written to the first NOP.
> > > >          */
> > > > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, syna=
ck_type,
> > > > -                        first_opt_off + nr_written);
> > > > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb=
, req,
> > > > +                             syn_skb, synack_type, first_opt_off +=
 nr_written);
> > > >  }
> > > >  #else
> > > >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *=
skb,
> > > > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct soc=
k *sk, struct sk_buff *skb,
> > > >  {
> > > >         unsigned int remaining_out =3D remaining, reserved;
> > > >
> > > > -       if (!remaining)
> > > > -               return 0;
> > > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > > > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
> > >
> > > nit: missing a space before ||
> >
> > oops, due to last minute edit :/
> >
> > >
> > > > +           !remaining)
> > > > +               return remaining;
> > > >
> > > >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaini=
ng_out */
> > > > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack=
_type, &remaining_out);
> > > > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, syna=
ck_type, &remaining_out);
> > > >
> > > >         reserved =3D remaining - remaining_out;
> > > >         if (!reserved)
> > > > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > > >                                         struct tcp_key *key)
> > > >  {
> > > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > > > -       unsigned int size =3D 0;
> > > >         unsigned int eff_sacks;
> > > > +       unsigned int remaining;
> > > > +       unsigned int size =3D 0;
> > > >
> > > >         opts->options =3D 0;
> > > >         opts->bpf_opt_len =3D 0;
> > > > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options=
(struct sock *sk, struct sk_buff *skb
> > > >          * left.
> > > >          */
> > > >         if (sk_is_mptcp(sk)) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > >                 bool has_ts =3D opts->options & OPTION_TS;
> > > >                 int opt_size;
> > > >
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > >                 opts->mptcp.drop_ts =3D 0;
> > > >
> > > >                 opt_size =3D mptcp_established_options(sk, skb, rem=
aining, has_ts,
> > > > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > > >
> > > >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> > > >         if (unlikely(eff_sacks)) {
> > > > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPA=
CE - size;
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > > +
> > > >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED=
 +
> > > >                                         TCPOLEN_SACK_PERBLOCK)) {
> > > >                         opts->num_sack_blocks =3D
> > > > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options=
(struct sock *sk, struct sk_buff *skb
> > > >
> > > >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> > > >                                             BPF_SOCK_OPS_WRITE_HDR_=
OPT_CB_FLAG))) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > > -
> > > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, =
NULL, 0, opts,
> > > >                                                   remaining);
> > > >
> > > >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > >         }
> > > >
> > > > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - s=
ize;
> > > > -
> > > > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL=
, NULL, 0, opts,
> > > > -                                                   remaining);
> > > > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, =
0, opts,
> > > > +                                           remaining);
> > > >
> > > > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > > -       }
> > > > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
> > >
> > > This static-key check is not redundant unless
> > > bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> > > tcp_established_options() unconditionally calls the out-of-line
> > > helper, so sockets pay the call/prologue cost even when no bpf_tcp_op=
s
> > > is attached.
> >
> > Interesting, I guess you don't use FDO ?
>
> Thanks for explaining. Yes. I did not use FDO for my local build.

I updated patch 4&5 and now I don't see callq for
bpf_tcp_ops_hdr_opt_len() even without FDO.

I still see callq for bpf_skops_write_hdr_opt() but it can be
follow-up if needed.

I'll post v5 shortly.

Thanks !

>
> >
> > On my FDO build, even tcp_established_options() is inlined
> > to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
> > and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.
> >
> >     ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
> >    # remaining =3D MAX_TCP_OPTION_SPACE (40)
> >     ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
> >    # remaining -=3D size
> >     ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
> >    # bpf_skops_hdr_opt_len()
> >     ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
> >    # remaining_out =3D remaining
> >     ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
> >    # bpf_tcp_ops_hdr_opt_len()
> >
> > I will add a static inline function and move both
> > cgroup_bpf_enabled() there and reuse it in 3 places.
> > (same for bpf_tcp_ops_parse_hdr())
> >
> > Then, the unnecessary movl will also disappear.
