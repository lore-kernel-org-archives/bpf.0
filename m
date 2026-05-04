Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF38936215A
	for <bpf@vger.kernel.org>; Mon,  4 May 2026 21:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931621; cv=pass; b=nnNRx0+dJ3JCWxUkhD/+/XQPsJHob5CxHpg9n7GIP1zTwhsjqAatwrtWvBcU4RnDxm2uc2aySI4r1YEtS0OBRUm+JH7A579aA7KNMSadJLiy+Tv9cPTzlpP/3iIhZL60JkPfIwHqKr4CR4WvHw6a5Am4wG6VcdZyewdFfLukTLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931621; c=relaxed/simple;
	bh=o1k8TbcL7uEQsmT8zaZK9TACGYgWElH9uAt/ppTSYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV2x88Isb4L0AVfPAb9J9aZSYJv7BHEV/0VlLefSywpECclqWWn1VoixS9NXfLx52CvPCZ11nR9MM4ajiz3/Fa+6WjvR3+SgIcVW/cvsEziFBW0Z52dZMP351uyqO6YpH+2pHr9nnjRwBvyfJJfLwK2rcvOJulOSepRDBa60Z80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uErvyW9W; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uErvyW9W"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c8cc7a77eso3814741c88.1
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 14:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777931619; cv=none;
        d=google.com; s=arc-20240605;
        b=h5MsgZY1u74KSoE2J8iQx4uLGNXkpxLd9EGgsybFafczV3wCYdQHe1OV1H4r/OAHOy
         RdmiBqMEdGQmgYtO28mS6QEfjz2bktKLass7A1Ctg8ldNNpeISH1r89pZlM5we36jy6/
         zYc7UPjeUcap9JJNMjJWZIEfWyAc5lXDKAjxMs8CpEK3P/imdMKCbaZd7kIYeda04pnM
         JdRXFXTos3JaDzHklKAYgKEiGHM5a9QMMP3+czchr4G0t1Q/ydnuwl2t1ZoXL5zubP0r
         vxj+cPmFqD0+4mrZlw2Q62UdwpISE8cQGxSIi74gSAOJhqhI49rybDGQNjPcP/ph8VZ0
         mIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        fh=0O2Khsq/JtLp1oNDnilgrAA4K0ndOqIBenx70g7JLQ0=;
        b=EB72PiZBH7WNKyhEMrbzmAEkN0pZUJFk0gTmQ8pZzZTXh4ss7FGE3M+9H143meIXYw
         un00fJhKT9CHl9B0wgRhH4Hhy/++Z4Fq69/Qm7G5p5sWv6ZjhTNagP4ei9muya3wsBKT
         DTVGszkA1O1EZMWZU/7EoJX6I6tkNcy26ot6gJMFTn+1sdMVzbqZrhSsnDRUOH4soDgz
         VZClQ2OqUl12x/W9MlwZUhTFejlypTNRxsDEWq0H0LaKu3TZubciU18KvAynxncwWekZ
         woysUlmX8V/RIXvgQecJzpZ/EN6AddNvaT9GdXldfDvlN38LZrhu2bZs2sSzV9WPYSw7
         Si6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777931619; x=1778536419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        b=uErvyW9W9gBjZnxrwTj98YFy/EIlI6MrYcNZFfFD+O9zFnO08Ai1BymXw3ib7R/eEk
         9b/3fqIg11M7gSz9NeqrzpmNVpTaBZ8RVsZB6dravrOtLWYLLmzL+S64eq1B6Ptz4f1Z
         BLseyKhumNXBDllcAyJoXJej3LtAUBTIRjoeJXz+7zB3smZvPOYFiPYTDUT5uzYrYG6q
         8gRVPJHxRrPopBE+qwB1x5JKvcgq6JZCeRG25w42Idcf41afzz58fMeh5pChmZZ2SdVC
         92ZRwbY7DIjxiMi8J7ujHFIdariG76A9IxaO4oAMXlW9laNRUvKdXS8qimddveXQLVf3
         PPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931619; x=1778536419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O3PEir1LZ+0vgrvNb+HSA3dhRn8skm0babc5zb8Pu7M=;
        b=JIhI+m6pk9QHeKTXCFuIPvIBvGwBBc3sNRnibQ+nIiGZ63LvBplMEeLfphQyOw+jSl
         kz4gWCUywcQxR2xphZn1M5MK3VWWin/oevrFLExTjGho3vTtGmVDvEp2D0GsPwXIUjze
         HJTSIwBho6hgxxeJrRpe/+0BjQcGDSNC8VnBttyGUKcKmSOkmivBD/KGNUzD2S5iaWb5
         omc9VLHKNzveAmTgCBl1jwJyJ4QZFYzrQe/o8T0jongjXMHXmmTpixT4oNd5UmgaACwu
         LHzGs+1cYmCT+rpsfAnq+ejJHqrYG1r/LLbKGkHWq0Z7/aZj9XSerj3mSpZCShOOHzNg
         sFNA==
X-Forwarded-Encrypted: i=1; AFNElJ+q7ZHobHBZUGfsayKJUTf47T4A2ZOExKpFGOupILrYAPZi3YGCYoRP+IkdNjsI6csCaqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+LsCZxu/uXqzbmEqmxa0CpwXwbb7aPCJtM8x8aaECxXukuqp
	MF2xt14pJH+mzmsdKAwB8jHGIcyMyFbriYsC8gP4SVXFUg5xnd8VDvKtlWaZ8tymDRhqaij0p2Y
	aJNi/Lz5q9PsQO+rYI5sUvJt+4QG4DHWuuZF48fC8
X-Gm-Gg: AeBDiev5s+19f0PcZb1Fdj1kIVFNk3Q0RMYHlwRzBExMwZGX1COLI6G9vqqzvkR3XOu
	jZN/qY+LGN1xCMJ28sWhSGKR7AsPCbb52FD0TRt86U8v3Rth6mLWmmkTXWOu5NoATECwreejglm
	G5+l1JovyCovNJ1FpIIAAduV8qBfewbZpjltluDQyxH7ubbTyH92lHI7qwGza/QOHeuGE2jbqA7
	Kl+iUBS/4Y5AwNt+KEznBuYaryd2NCQYnW0oW+f1FtG9BfQlcUyDidNeC7x7bvUrJjL4RKkwece
	Im27mEMe0OVeCzaIRpkmvVzZ3wt6eF7fl0Q+MVurZ0XEeFIBBSxuIrhVxtUH1oCa1gXWE3pMxkU
	hXXef9+aRoy5Yqn1G5AFETNMVK/EVISsyPE4/aYan8y4OX3zc7q0gWpbqbEhAoqRxJJ5gMC4=
X-Received: by 2002:a05:7022:ec86:b0:119:e569:f86d with SMTP id
 a92af1059eb24-130a9deca09mr479698c88.10.1777931618299; Mon, 04 May 2026
 14:53:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504210610.180150-2-kuniyu@google.com> <f3fb214ed73246731c525dfdccdcd379bd6d4f1e4570eba0cd19d56f888f9b0a@mail.kernel.org>
In-Reply-To: <f3fb214ed73246731c525dfdccdcd379bd6d4f1e4570eba0cd19d56f888f9b0a@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 4 May 2026 14:53:27 -0700
X-Gm-Features: AVHnY4IglCvi52y3FrnDwdstFXacRE-gfopygiqQ7Wc1b74Q6ktBMo2kGwY5mnE
Message-ID: <CAAVpQUCoxKwxafqsVrqCxkcfpxCTwYKBLmhyZJSugeLjXKa81w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in bpf_tcp_sock().
To: bot+bpf-ci@kernel.org
Cc: martin.lau@linux.dev, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	john.fastabend@gmail.com, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, edumazet@google.com, 
	kuni1840@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	melotti@google.com, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 2:50=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..cd88633f8dc1 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_acce=
ss_type type,
> >
> >  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
> >  {
> > -     if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> > +     if (sk_fullsock(sk) && sk_is_tcp(sk))
> >               return (unsigned long)sk;
> >
> >       return (unsigned long)NULL;
>
> While this patch fixes bpf_tcp_sock(), does sol_tcp_sockopt() remain

It seems Sashiko does not have context on the following patches.

All helper functions mentioned in the review comment are fixed
in the later patches separately.



> vulnerable? Since ctx->sk evaluates to PTR_TO_SOCKET in a CGROUP_SOCKOPT
> program and is directly accepted by bpf_setsockopt() and bpf_getsockopt()
> via ARG_PTR_TO_BTF_ID_SOCK_COMMON, can a user create a RAW socket with
> IPPROTO_TCP and directly pass ctx->sk to bpf_setsockopt(), bypassing
> bpf_tcp_sock() entirely?
>
> Looking at sol_tcp_sockopt():
>
> static int sol_tcp_sockopt(struct sock *sk, int optname,
>                            char *optval, int *optlen,
>                            bool getopt)
> {
>         if (sk->sk_protocol !=3D IPPROTO_TCP)
>                 return -EINVAL;
>
> This appears to only check sk->sk_protocol =3D=3D IPPROTO_TCP without ver=
ifying
> sk->sk_type =3D=3D SOCK_STREAM, which would allow the same slab out-of-bo=
unds
> access through a different code path.
>
> Additionally, do bpf_skc_to_tcp_sock() and bpf_skc_to_tcp6_sock() suffer
> from the same type confusion? They appear to check sk->sk_protocol =3D=3D
> IPPROTO_TCP without verifying sk->sk_type =3D=3D SOCK_STREAM.
>
> Could a BPF program pass a RAW socket with IPPROTO_TCP to these helpers
> and receive a valid BTF pointer to struct tcp_sock, allowing out-of-bound=
s
> slab reads?
>
> Looking at bpf_skc_to_tcp_sock():
>
> BPF_CALL_1(bpf_skc_to_tcp_sock, struct sock *, sk)
> {
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
>                 return (unsigned long)sk;
>
>         return (unsigned long)NULL;
> }
>
> And bpf_skc_to_tcp6_sock():
>
> BPF_CALL_1(bpf_skc_to_tcp6_sock, struct sock *, sk)
> {
>         /* tcp6_sock type is not generated in dwarf and hence btf,
>          * trigger an explicit type generation here.
>          */
>         BTF_TYPE_EMIT(struct tcp6_sock);
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
&
>             sk->sk_family =3D=3D AF_INET6)
>                 return (unsigned long)sk;
>
> Finally, does bpf_mptcp_sock_from_subflow() in net/mptcp/bpf.c also need
> a similar update? It checks sk->sk_protocol =3D=3D IPPROTO_TCP and immedi=
ately
> evaluates sk_is_mptcp(sk).
>
> Since sk_is_mptcp() indiscriminately casts the socket to struct tcp_sock
> and accesses tcp_sk(sk)->is_mptcp, passing a RAW socket could trigger an
> immediate out-of-bounds slab read. If this memory happens to be non-zero,
> it might proceed to call mptcp_subflow_ctx(sk)->conn, which would read a
> garbage pointer from out-of-bounds memory:
>
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk)
> {
>         if (sk && sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP &=
& sk_is_mptcp(sk))
>                 return mptcp_sk(mptcp_subflow_ctx(sk)->conn);
>
>         return NULL;
> }
>
> These issues were raised by sashiko-bot@kernel.org in v1:
> https://lore.kernel.org/bpf/20260501184452.7F46FC2BCB4@smtp.kernel.org/
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/253442=
93379
