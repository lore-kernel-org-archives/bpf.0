Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96579418361
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791412604; cv=pass; b=pT3FL6Un63s0vPLFGqqZXsrnpwgyajL8cs1M0aN57yFgQQkQt8SpdFNUHULOiD6hI6lKPabQdbDPTERhvJgVzNIs3J/oApLZldXHb4U7yNJsdH9dQV6OAi8mDdrPueOKSVF4MJ5rNOzXSX/pRrnc7QbuGIbhNwPl/utKRcQCxIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791412604; c=relaxed/simple;
	bh=kuwLwNIaS0PjQyg5DDxE7ag7kQm8wcJCAsbzZkLra1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoHRNV1PEMq91itMICJfohv992khyt2PFFgNqxgLJTFfChdNwCS/BHE+qlei5eXfWqnE/eygD9vQGzG09wljxQNtQQApDqEO2mmQdiI5TyygL67yOh3y9kF9TWGspLyefXSD0m/QFCgBn3tWwjCOaCzBal47Zr+zAPo3Getcu4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5uqPRxr; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5uqPRxr"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-504db7f7870so146310b6e.1
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 15:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791412601; cv=none;
        d=google.com; s=arc-20260327;
        b=lzR2n/pMHlBoST9SS7jPtX6KaBM2+ZQmF0k8xhAjQ2L+oRytr8Hy8dyE24dgFZH7Nu
         KAG6V5oYSUdIIW42lQVLOxvXWm93PjfxPoMm0TkFgxi/cXbk6vVL7bBpcIYd7u/8ZECS
         LzqFj7SR0Ql0stn13xw+uf2mRZsLphQwa2saodHo9UJD0588b1mgUZ9qjhQHTidE/l0P
         f8cxBvsLqRE29Q+Lb6TtBsk/8L5ATN6lJ3O5sdjoMnW+D7NJsZpBk33av8K19Y5HzSrR
         KmGxi75S2yTppVPMnBqkcC51E/9If2DYBCKpMDtEIg4sVkj1HZ+PqXLRFUsxQUo2WIYd
         Xetg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        fh=fzyqD75giaQ2OfXC+EpNlPyJtxFpnjALdzJ28pno6tw=;
        b=Hl5hEx0vFjeXofOlIFJJ+YesdEB1XM3+y5bheTyB9O+Mmv0RI/JoXbRG6lSIfM7R6E
         kSpokCM3vFLs58zR7JCl6gOJG6umzwwNiSrfeoVzyifaGR2RR57A8qdvufQUrveG1A8f
         c5t8mIPOIXpRkB4uVZHa7ldki2Q/0XSSMpULpO0ChzwAkr+rpHQ4w+teJkB06WfUCD32
         xu8oix+889LlNmHbxlB7JYQCxxDZb+sR9urjfO5KKFfBrxn8Zb+IY3GwmctSkW8bhJ9v
         ii/69dPdqo4tIBrY/3EqSej8RTvItPONOGPozbqtwaH416SjojFBPf28kOCCI9CzqVaL
         MokA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791412601; x=1792017401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        b=j5uqPRxrEF9MhYkrsYLyVDs5ydia4wZ7S0oruAI68beh/oAmIOndyukk+V0HofNwnC
         UF5xbwDefLNQdRqYEZUV2hjaOUtH3x81ZtgdhQDZcGxviS5WiDqSR27MTflWil0nCbv7
         ASf1P9TAueI6C0uHCcdoBkUlzwqUN4iDrcwg0/rXkXK/QPjhIgmjm7VYo2Yf1GqYSSZx
         l/JHQ0rI2d+zTdAByIqZC56ZRI3KJXOZoMi3xEdZsw9J1ObCKoqSVhyh//7iSTjpYATQ
         z1n1AxOstpCzHOm5LeT22CloX8IUx3wyS20PetJ0MrAIgz8IeHIM0LAkDfWEgHDR90RZ
         zzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791412601; x=1792017401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9ZmRP+/mWYldgCkpzW6OiHxi4sAaJjqTFFMOvBqFLs=;
        b=zLyHGIF/FL697bbswgsVdwUnaR9EG9fKWHrHFt7uICoLWE/fP5+xFEWFj3kE3anld7
         WwJ85ZeJUaZLBs4fgLGp7WD4aoZiDhO82J9GGkb9fz3tDrpZKxcEQTXStPxpYqA0imYS
         2WhK/CC9YmRWDXWRQXEDMxlrSgQy0GTPnYRmkTGSEOVYHe1rlZpook7w98WD6628oM98
         SCb4JYKzOM680dGaaKaf0G4LO3nyb4sarq5CEPZRZ1Yawy4OBLPc/xz+qxw1MZn+6S4X
         mks3D2MW++zKEh6O1WFr9gZSdUDYqqrv5g00zCsg1Bfb7/lWrRQKeG81HgdrtFBjTzyS
         ZLPg==
X-Forwarded-Encrypted: i=1; AKwUvByqQqb8MER3bvaBOxjQtAJu/B4UOtKWIROOF1p7/1pcVtUTsbChBlw/pzJ6aFb1WtG2ejM=@vger.kernel.org
X-Gm-Message-State: AFuF++m/jj0c16G2yM8mD0sw0MPbtPphhnk7LchMNtZhj5FwJPCshuJX
	eNz9Yyc+lDozQSN77uVwmYZjwtsbev9Q3q3XE2nFDjC1S8FQ0IMiZcW5RcqUoa+ndf6IDsmMN1d
	kPpcBbJb6KsFni/DeOvfWdd8sqTSL3RA=
X-Gm-Gg: AYBFou0cSrDX0/6rZSPpBd0s5PfHzkrO2WrsJU+Ndxh5baE+fsVJA7jO57v/oFAHtW1
	YxedVNYf0VHWapUFRvrmDLmUgSSEPMZgBMzpUal9IRjXwWznUEgh/Qopz0f1WVyKsE0wNOFmv+U
	7VT9Sdyw1Tc6a535rSSEmhjgV3a/Wvll/gyI/SByynjjbI4iP0aBvyhwPxMmnAitRexojPtRdVH
	wUG4H58MIJrbhR4NmrKTq2lZTSqh3O4ZAITruZj6XQ3MvP5y+5W04WCm57R70jxiohryRYnqBsN
	cSHP1RvaDGZht8hx3M/llbccRWoO5sRWsGz+O7lBM7G46pdKW8sIMi4=
X-Received: by 2002:a05:6808:228b:b0:4e7:8f9b:1191 with SMTP id
 5614622812f47-4fc473ae762mr3907604b6e.52.1791412601453; Wed, 07 Oct 2026
 15:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-5-kuniyu@google.com>
 <CAMB2axM8+eW=jiDgV4EHgCxXpzZDdj3PVZc-8hZ9_3bMWMMDYg@mail.gmail.com> <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
In-Reply-To: <CAAVpQUD5eBzZJ3+1y+HbPhDf0q9juZc9g8v5J_ghHssEg2wXwg@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 7 Oct 2026 15:36:30 -0700
X-Gm-Features: AclHuK-X967fdbhZ58Ih9UEarwnuA6UR8PfbZ78119IQkH91wzNvZrk0ge0spWo
Message-ID: <CAMB2axPVrw-OGz_35yKw=QzHfcqRvtuhiLVs-_h5B1FUpN84mA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 7:48=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Tue, Oct 6, 2026 at 4:25=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
> >
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -210,6 +210,11 @@ static void bpf_skops_established(struct sock *s=
k, int bpf_op,
> > >
> > >  static void bpf_tcp_ops_parse_hdr(struct sock *sk, struct sk_buff *s=
kb)
> > >  {
> > > +       const struct tcp_sock *tp;
> > > +
> > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
> > > +               return;
> > > +
> > >         switch (sk->sk_state) {
> > >         case TCP_SYN_RECV:
> > >         case TCP_SYN_SENT:
> > > @@ -217,7 +222,12 @@ static void bpf_tcp_ops_parse_hdr(struct sock *s=
k, struct sk_buff *skb)
> > >                 return;
> > >         }
> > >
> > > -       bpf_tcp_ops_call(parse_hdr, sk, skb);
> > > +       tp =3D tcp_sk(sk);
> > > +
> > > +       if ((tp->rx_opt.saw_unknown &&
> > > +            BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_UNKNOWN)) ||
> > > +           BPF_TCP_OPS_TEST_FLAG(tp, PARSE_HDR_OPT_ALL))
> >
> > nit:        ^ missing a space
>
> this indentation is correct.

Sorry. False alarm.

>
> >
> > > +               __bpf_tcp_ops_call(parse_hdr, sk, skb);
> > >  }
> > >
> > >  static __cold void tcp_gro_dev_warn(const struct sock *sk, const str=
uct sk_buff *skb,
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 3ac465513bf5..8770f3084efe 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -581,8 +581,8 @@ static void bpf_skops_write_hdr_opt(struct sock *=
sk, struct sk_buff *skb,
> > >          * writer's bytes). The writer finds the append point by scan=
ning from
> > >          * first_opt_off + nr_written to the first NOP.
> > >          */
> > > -       bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack=
_type,
> > > -                        first_opt_off + nr_written);
> > > +       bpf_tcp_ops_call_flag(write_hdr_opt, WRITE_HDR_OPT, sk, skb, =
req,
> > > +                             syn_skb, synack_type, first_opt_off + n=
r_written);
> > >  }
> > >  #else
> > >  static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *sk=
b,
> > > @@ -613,11 +613,13 @@ static u32 bpf_tcp_ops_hdr_opt_len(struct sock =
*sk, struct sk_buff *skb,
> > >  {
> > >         unsigned int remaining_out =3D remaining, reserved;
> > >
> > > -       if (!remaining)
> > > -               return 0;
> > > +       if (!cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) ||
> > > +           !BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), WRITE_HDR_OPT)||
> >
> > nit: missing a space before ||
>
> oops, due to last minute edit :/
>
> >
> > > +           !remaining)
> > > +               return remaining;
> > >
> > >         /* bpf_tcp_ops_reserve_hdr_opt() reserves space via remaining=
_out */
> > > -       bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack_t=
ype, &remaining_out);
> > > +       __bpf_tcp_ops_call(hdr_opt_len, sk, skb, req, syn_skb, synack=
_type, &remaining_out);
> > >
> > >         reserved =3D remaining - remaining_out;
> > >         if (!reserved)
> > > @@ -1193,8 +1195,9 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> > >                                         struct tcp_key *key)
> > >  {
> > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > > -       unsigned int size =3D 0;
> > >         unsigned int eff_sacks;
> > > +       unsigned int remaining;
> > > +       unsigned int size =3D 0;
> > >
> > >         opts->options =3D 0;
> > >         opts->bpf_opt_len =3D 0;
> > > @@ -1224,10 +1227,10 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > >          * left.
> > >          */
> > >         if (sk_is_mptcp(sk)) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > >                 bool has_ts =3D opts->options & OPTION_TS;
> > >                 int opt_size;
> > >
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > >                 opts->mptcp.drop_ts =3D 0;
> > >
> > >                 opt_size =3D mptcp_established_options(sk, skb, remai=
ning, has_ts,
> > > @@ -1244,7 +1247,8 @@ static unsigned int tcp_established_options(str=
uct sock *sk, struct sk_buff *skb
> > >
> > >         eff_sacks =3D tp->rx_opt.num_sacks + tp->rx_opt.dsack;
> > >         if (unlikely(eff_sacks)) {
> > > -               const unsigned int remaining =3D MAX_TCP_OPTION_SPACE=
 - size;
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > +
> > >                 if (likely(remaining >=3D TCPOLEN_SACK_BASE_ALIGNED +
> > >                                         TCPOLEN_SACK_PERBLOCK)) {
> > >                         opts->num_sack_blocks =3D
> > > @@ -1277,22 +1281,18 @@ static unsigned int tcp_established_options(s=
truct sock *sk, struct sk_buff *skb
> > >
> > >         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
> > >                                             BPF_SOCK_OPS_WRITE_HDR_OP=
T_CB_FLAG))) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > > -
> > > +               remaining =3D MAX_TCP_OPTION_SPACE - size;
> > >                 remaining =3D bpf_skops_hdr_opt_len(sk, skb, NULL, NU=
LL, 0, opts,
> > >                                                   remaining);
> > >
> > >                 size =3D MAX_TCP_OPTION_SPACE - remaining;
> > >         }
> > >
> > > -       if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > > -               unsigned int remaining =3D MAX_TCP_OPTION_SPACE - siz=
e;
> > > -
> > > -               remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, =
NULL, 0, opts,
> > > -                                                   remaining);
> > > +       remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > +       remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL, 0,=
 opts,
> > > +                                           remaining);
> > >
> > > -               size =3D MAX_TCP_OPTION_SPACE - remaining;
> > > -       }
> > > +       size =3D MAX_TCP_OPTION_SPACE - remaining;
> >
> > This static-key check is not redundant unless
> > bpf_tcp_ops_hdr_opt_len() is inlined. In my build,
> > tcp_established_options() unconditionally calls the out-of-line
> > helper, so sockets pay the call/prologue cost even when no bpf_tcp_ops
> > is attached.
>
> Interesting, I guess you don't use FDO ?

Thanks for explaining. Yes. I did not use FDO for my local build.

>
> On my FDO build, even tcp_established_options() is inlined
> to __tcp_transmit_skb() and both bpf_tcp_ops_hdr_opt_len()
> and bpf_tcp_ops_hdr_opt_len() are NOPs as expected.
>
>     ffffffff8224a511: 41 bc 28 00 00 00     movl    $0x28, %r12d
>    # remaining =3D MAX_TCP_OPTION_SPACE (40)
>     ffffffff8224a517: 45 29 ec              subl    %r13d, %r12d
>    # remaining -=3D size
>     ffffffff8224a51a: 0f 1f 44 00 00        nopl    (%rax,%rax)
>    # bpf_skops_hdr_opt_len()
>     ffffffff8224a51f: 44 89 64 24 78        movl    %r12d, 0x78(%rsp)
>    # remaining_out =3D remaining
>     ffffffff8224a524: 0f 1f 44 00 00        nopl    (%rax,%rax)
>    # bpf_tcp_ops_hdr_opt_len()
>
> I will add a static inline function and move both
> cgroup_bpf_enabled() there and reuse it in 3 places.
> (same for bpf_tcp_ops_parse_hdr())
>
> Then, the unnecessary movl will also disappear.
