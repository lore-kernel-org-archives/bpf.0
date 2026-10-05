Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CF3AA1BA
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235164; cv=pass; b=BRJPPFGj3vAOuwZHtSk9r+fhSxPS8w4ChIee0MsTK3lhu0EtfviWYOFZKkICvgX/5jZrEym32RMqlTKzKAxmC6qyXtS766/VImzJHp+2JLASiogB2OqO3C8vZJCBId54rRgR65DFQghdcg6aNqnDaghBd5YBxTuE+vEF0/O4tjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235164; c=relaxed/simple;
	bh=eELgf8GJKTiY6EXf8i7rHZjlPP/t67MdNZHvtpvKn9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rno3W3q94gKEXdJ1VxvmbeVUDEXjLjeOHdCE+Hz8O/MZIqprnwD6xBlSn1aqGqEdOYf1De23CFBQONLTM3carz4qohVv04u5JWoCJe3/Cd0MCmpSVwV16zAl2xy+zJ56FdY1x4O2ZXENdlF25EDd/5/bFhpLy8yj+Iffea9ROwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/MDxCAv; arc=pass smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/MDxCAv"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-49e32a59ad1so1628380fac.0
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 14:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791235158; cv=none;
        d=google.com; s=arc-20260327;
        b=PC1iGbyqVDDT6XBiqJcTjRqktllzebbg17abXw3WzjcKtGeFZTXDzJm0GTQeHrwe9N
         uI6Nz5dox7zdjpY0ILgVAOQnY4pMamnJwHx5gcBqsUq9LAQgkLcW4DnGxnSe4YUSxiSq
         f9zDTEAsgyZaSEzsvecDzX4e+B5P0Y2gRGJfV+XbzyKC8YGPDmA64x1PQ7SJ3rOqvun7
         Cs7peEc30JfQGO5jiNbuX3MJ2f00Ep5ICtdB86meFeTka+ytO2SRnvayaYeriSp8Pt4p
         nqn1+32L1FK7wmlOalQE9XoxTOz4Se2hk44xjBA/ADyKG5hXp6lcYzDdAiCurcif2hhg
         4jOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJp7Cx33D29CrhG+Y0yUBIDOn2zkdd4RVGfbftF4ayY=;
        fh=lQgN7zjbZVvJKDM/fftEpzvyTHLmGavjsLAD7c0bcY4=;
        b=RUEt3+py9KYVA0K/kzR0Y6UQpN55tBY91XhsfmgP4czArYjZs8LdQzdZgjQ4yKxCrk
         TGotWrmT2eUzMCdQh4D1y18fmbGPqdwZxAp8FoK4XaJQpepIksswgjgVc1xy9GhCxRBN
         6hOjiejCEOPj/u6LO6XoJWv7zyXiv6xPjc/Ggza1Wr9/Xh2WdmwKMu0rb5oux/wd1SHM
         vLVa42/4SPPTw0+R7IhoAtvmGx5VCE4Qxe6NVkpEIjtTVyU4lEbYVJ/qh5BYQRBFRuju
         EmXrMBEyX/OUMTKqFJl7tmimeRfREpiA06YYU86C3Ni9Ew/MHilDYpVt1RqnsarL9eXR
         9K1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791235158; x=1791839958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wJp7Cx33D29CrhG+Y0yUBIDOn2zkdd4RVGfbftF4ayY=;
        b=Z/MDxCAvmzWbczQUruUfaTrjS4/fNuxgASZQ8hM7dHSSdMYu+jFgl5diU1eYdpqWqa
         aelehQmkJMx3d3U7VuyXrx404B2/J+W9KSl0zsSVfiFTRJPNDzIfSmDdn/Sff4erUND0
         gnJ+BUsM3a0dIwmWDp9QE/JH0lkuOT40i2iG05PbGseQNeD+RPXCCLtDH654lR0AMwm0
         k0enk2j5ScGfCluU5TJaDRyHIL0s8Po/Xs0M95TgG67xdzx4FzxHqSGKRo89RLhs1Zp1
         J7r1srHQU27lap1ya05rKw27aCTi7ObxJ7L1TVZYNIh3A2TPUAn2P5/0oFDaQ8fFcyeE
         7EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235158; x=1791839958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJp7Cx33D29CrhG+Y0yUBIDOn2zkdd4RVGfbftF4ayY=;
        b=I8LkbdcM5LNkqBtQTkO3FxL+rq6Sxoa3AXqBXpwPeG8P5W3s3pohH5L7RIDviY4ucj
         bg8DH1lbf2sfCWzscZVsrFwXNdkOg5lGVQRPj3vZSEsUPER/kkCXTKP6TbX2PRJSTBKF
         pBxq931nuvPruNaSRGQQ+nVrVaDcybRhUG401shufeSii07mcd/vSJ7d9sEY/520iNGx
         LxlIQJpWY5XqHskZCTlhyI41tKxPxzsw/VP9s4Bk9X0HIWgj9DzCb05gygAZc67Iw/r5
         3yoBKprnwmoOI+ZehXNmm7KZqJ+Q8WPVAZUCqOHDy0MV4yBCpsgMQSvpE4sl4gn+Jx8i
         V+og==
X-Forwarded-Encrypted: i=1; AKwUvByhTkaDKyZokyDGgdd2/c9mkJZOjaka+NfHlSjLtCbE1eMNkqvHEc+oppx65h/cFlT8HUg=@vger.kernel.org
X-Gm-Message-State: AFuF++nVEClcKzrbb6Xk+gK8lb3b8l3hvZoI752wunwAGzPSXH3fy+Xq
	CMbMg71rUJIMjyKYOXHZA0ey5uJhBi19kT8Km2baAS/DL6EiBrjpNF8d2dLKH5HZvncC1xnSHuT
	wwc9n3hrjM5FF7eDQ9U9d3TDjDNYc5BI=
X-Gm-Gg: AYBFou0ya9V9AaB99VD5AUwlfB+rUVYQSrx0kNNOTUg8Ui7+LazGdD7/VnOFqvVAt3O
	9xUrEOBsfvDd3FIwe/08SlLuUX6Gb9509Iv30jUaeDoGlVJOt659EbV3I4nrqvMAirgKoB6C5rZ
	F+18KvcrZg790hH35GCW1XOHXQOqFK3aBcJoYAvKPooeSM7kWrhAeC5aifEI7bzQLDk8/5KT3XP
	FrH5KLKqYQHiFENua/dFGEle52Fh7SKnhwxRP6O3HrCVd/2C4wAOS3931BOKNDch8il3A/69Moa
	7/gou+e0ihnQztLkwcIRe8IwydHUvHtYScCFfQzwyoVpsh9Y1CykOxBxHbymKkMlW42hnZQ=
X-Received: by 2002:a05:6808:3a0f:b0:4f3:68d6:f12b with SMTP id
 5614622812f47-4f52b1aab0bmr10717262b6e.48.1791235157987; Mon, 05 Oct 2026
 14:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-3-kuniyu@google.com>
In-Reply-To: <20261005154533.4147685-3-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Oct 2026 14:19:04 -0700
X-Gm-Features: AclHuK_t3kgzE5RZg148c8b00IT5H7_r1x-arSMwOhumQnLkzcC3ewKkdlVtmCk
Message-ID: <CAMB2axNHoWyJYJ5QX9Gs0nmpwxs62t7y84729HRDq_+-cdjM9g@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
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

On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
>
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
>
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
>
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
>
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
>
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
>
> Both helpers only overwrite the field, which leads to reading and
> modifying the flags in the BPF prog and then writing them back
> via the helper.  This prevents future use from tc or cgroup_skb
> hooks where bh_lock_sock() alone cannot prevent races with process
> context.
>
> Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
> tcp_sock_read_txrx cacheline group, along with a new kfunc,
> bpf_tcp_ops_set_flags().
>
> bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
> disable and updates tp->bpf_tcp_ops_flags atomically via
> try_cmpxchg() without relying on lock_sock().
>
> The kfunc is exposed to bpf_tcp_ops and BPF_PROG_TYPE_CGROUP_SOCKOPT.
> The first argument is struct tcp_sock * so that bpf_tcp_sock() is
> required for BPF_PROG_TYPE_CGROUP_SOCKOPT, but not for bpf_tcp_ops
> where struct sock * is promoted to struct tcp_sock * automatically.
>
> The fast-path callbacks will be guarded by the new flags in a later
> patch after updating the existing selftest to avoid breaking bisection.
>
> Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX8=
32wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/linux/tcp.h            |  7 +++++
>  include/net/tcp.h              |  1 +
>  include/uapi/linux/bpf.h       |  8 +++++
>  net/ipv4/bpf_tcp_ops.c         | 56 +++++++++++++++++++++++++++++++++-
>  net/ipv4/tcp.c                 |  3 ++
>  tools/include/uapi/linux/bpf.h |  8 +++++
>  6 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 6a8c77719322..24bb751cc65a 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -233,6 +233,13 @@ struct tcp_sock {
>                 is_sack_reneg:1,    /* in recovery from loss with SACK re=
neg? */
>                 is_cwnd_limited:1,/* forward progress limited by snd_cwnd=
? */
>                 recvmsg_inq : 1;/* Indicate # of bytes in queue upon recv=
msg */
> +#ifdef CONFIG_BPF
> +       u32     bpf_tcp_ops_flags;
> +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) \
> +       (READ_ONCE((TP)->bpf_tcp_ops_flags) & BPF_TCP_OPS_FLAG_ ## ARG)
> +#else
> +#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) (0)
> +#endif
>         __cacheline_group_end(tcp_sock_read_txrx);
>
>         /* RX read-mostly hotpath cache lines */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index d61ee00052e3..f69091f5e01f 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2934,6 +2934,7 @@ static inline int tcp_call_bpf_3arg(struct sock *sk=
, int op, u32 arg1, u32 arg2,
>  static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
>  {
>         tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> +       WRITE_ONCE(tcp_sk(sk)->bpf_tcp_ops_flags, 0);
>  }
>
>  #else
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4687c3310996..6ff90b73dd38 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7334,6 +7334,14 @@ enum {
>                                          */
>  };
>
> +enum {
> +       BPF_TCP_OPS_FLAG_RTT                    =3D (1 << 0),
> +       BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL      =3D (1 << 1),
> +       BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN  =3D (1 << 2),
> +       BPF_TCP_OPS_FLAG_WRITE_HDR_OPT          =3D (1 << 3),
> +       BPF_TCP_OPS_FLAG_ALL                    =3D (1 << 4) - 1,
> +};
> +

This series changes several existing bpf_tcp_ops callbacks from
enabled-by-presence to disabled by default. Since this needs a respin,
could you also document the opt-in semantics and update the comments
for the affected members of bpf_tcp_ops to name their gating flags?

It would also be useful to document that the mask is per-socket and
shared by all effective bpf_tcp_ops programs.
