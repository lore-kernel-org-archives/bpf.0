Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B633C140D
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830532; cv=pass; b=pcbHPGfPaoFEMbSM5e8cXDcZRRt483OEBfQ7SfEgYAZWdjn6VRbdo+Wteb/Za2MS3vZDFPwxCUsxb3cuU/dvwAPB+8p5p5oflkqeC3tCgApmPwYT56032qzJ1V921nbVVRDob8mU5OVYFFJpZXQVm6GEtm5Zf95JooIe4N/Ywao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830532; c=relaxed/simple;
	bh=h2pRzbCs5OlGfRvvPszd4XwFbSVhfsO5zU3RTXajg64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWlVPmJ+oNy5d3Xy/LF2a2U4AuALnSZjup1/w9RKMgqMfKmzvsHDNFcOvuP5UfEZmZQK+t/CEaHxU5drGSrf66vnotQyvfU8zYc2BKTWKp6zwNybj/hTPw1xWjXOH/kh4+6ESYuMdLzsN4qgmLV4oK7u/5WsafJnAPlz8KeCEMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQhNTL8+; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQhNTL8+"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1363e78746eso6538374c88.1
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 14:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779830530; cv=none;
        d=google.com; s=arc-20240605;
        b=Tz0fRqUmAsEwn+KIzsvamrSTe+JAYqf5UfTZRXxqGdkH5vs6QB3OaaGi2DzVq9ew+T
         q5ivGxo86GpQ36NKjg5L/V2rh/8Ft03io0EERoovIH1Bo0tgjsjfml6Ln04igMLZPxuI
         CT000CDlvG4JPvpsRTrezERs1YHaRjl34NPVX2m1q4crYjkxr3j9DNNQ6AJFTOcFCLx2
         gex6uNCnS7i9+Li5nYk90zUjEkUC9tPm81i61ONp/R9fZNKUQbfiF09UyCg2ZBPoRirn
         QXva75Fog72hMgdBljedQ6v39EgMZJD4D4bp1qdg3ggTRQ7scnEnLTLOj/od4txY+foM
         pbQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        fh=SXZ4xXwIgbC0A0NvnlSueHgFPnWcVI6GXW2uxP7JU8M=;
        b=aPB00TfMovmpNDnqICsxW35C6E5ctXew2hYDRUp5nHdOQsJX3qvwjebHPFckHErEfF
         LizBwMCX8+dXWXUUJqkkjkUVfg7EOibeCXkTcmQYKih70/DAfi1QvxT22W45sNkd5oZo
         kU+MPrvHmOzX2ALgk9f2xVhHlvLsg70qWwCOJPwLz3rFlGhFYnuNhFWPCLK7fFNY/HaS
         7kWfXBRD0O0BdfT965kIW4sVzeuNCgLRw0w/ASsgCWr3ZiJeIbxv6TOuGqszVv6aG7Ls
         Wr5oEIAbcvO/079LAB//oX7TD1HSkradIcer3GCPHcfTwl45YYN5f7QRIGym8DcTM9pp
         tS/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779830530; x=1780435330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        b=vQhNTL8+e8b5J1mAiDM8tKggXDpSqD8JOqidf7yV9ca6HZZDKcd1o1WjjM1ZQXWKA9
         LItYMBazZHJI+tHwaCjs7XEXNbQS5IkGvDcb4fYZ/KsIBlQrSQIEsmZSZmblRtxJTHuo
         Gw72fhDTFDrNJPYtKjqF+IpYjOEmH8w3tXTqqYd9eadAoEQctuii7r5maoy7A5nQAG/i
         REjmy/kLXNQsIMHLh9Jo23HngDyxGACMkb+fBrU2Mk3hyZ3ji3eHaM20LM2qLgymLe/N
         ZJNq4hPjB3kglGQwK2f5jP0As5OIaYjBrxeFJ6/g5P9bXdAeY7N4fxh5FzGe+yA+lrnv
         AegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830530; x=1780435330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        b=VlkVO6SnHu0ZXXC9CGLAO/vGIql+OnSFZ+OLp2ykqcxg2JzeJf5CjZpvQ6FqyUslZw
         L7BlCPUjnLs0AI8Ll1z39PiMGXMdM1OmTqjMtpDfw+OqbeLuev7UHPXTV5xJM6nXlY7a
         FJZmA0TBhe5fQ5lhKEi9ntxijX9kwrZTBWlFK2xB8xUOgWTYAjkQlth9WoZNQPk4VfB9
         Www+G/mf+w30p3NweQaqRnfQhknRnUBU1QTMIYZwSogZZt7rxuytFVos95doegIruoPv
         95op3LBi5bQp1eFNhhDcv4ZVGsBKatJ8ONyCJTb4vcGqoqjMd6AqFSqLtHO0b24Gc3I6
         vzJQ==
X-Forwarded-Encrypted: i=1; AFNElJ82OnRJRjScMEK4CFch6wG2N4rNPjmLIfbaUvkeTgB8JWd+b6vbeTSlCxNPNe3FtofNqtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsCB2kEE63lUS3e8zn7L+rmGopR5DL0vuqyF03ZmCoaS5sw95
	JVDyBOHsd/ucBSEKxDRHT9nKEsS7d9AjtGBi7IDhbEUqSwsVR8EKi8B1c8BXZmT3WSLl0k7PYc1
	a0Q818jIh1tIigD1sbvsXZhHFTT6n166Te+c8pSvM
X-Gm-Gg: Acq92OELh8bgSR/etE9kfaG291dcyf+I19/FZ4ACJd0GI5gVWcDWsL77M2NmK0OAd8Q
	EDwc3Mke7RuzxfBSlgDkqgYiV9016AhQApznPnLNyrTS2GqG36pof9Eo6NHjIySGejEMmmJP4C1
	bN3snGafocD2MN2lMgcTztj2wu3J9yAAJLOJkNJPcHOjqXCLxkB1eYRWkiCOu02OJNS43G6+jZ/
	ghewJotrGzzjKjJ1YQZVf6v54zP4FUjVqxp9Aqgo/qeipRP4BisIKyFBMOl3WpXm/KyDAP5bNQ3
	g+qPcJOEpCy/xml7fQc8CKSGo15K877P0xUTkgrYm2ZASjIXe6OtQiLh9bRq8VzPuuPy1lKPQ8V
	lT0CBqKNwilu1gSaI8ltQWxqFCI54z8FxeJUWPRkGxuRK1VSeEbMZHlG6+Qh/
X-Received: by 2002:a05:7022:e997:b0:134:feba:40e with SMTP id
 a92af1059eb24-1365f600934mr6305256c88.6.1779830529265; Tue, 26 May 2026
 14:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev>
In-Reply-To: <202652620632.prOx.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:21:56 -0700
X-Gm-Features: AVHnY4IrxL6GuXy1gEDVGjcRdn1esdgGUIAOzsUq5l9tkNCP9wmrwYPRcO3ehEA
Message-ID: <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:34=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote:
> > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> >
> > In this hook, we want to parse the RPC descriptor in the skb
> > and adjust sk->sk_rcvlowat based on the RPC frame size.
> >
> > However, we cannot access payload via bpf_sock_ops.data on
> > modern NICs with TCP header/data split on as the payload is
> > not placed in the linear area.
> >
> > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> >
> > Three notes:
> >
> >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> >       invoked from recvmsg().
> >
> >   2) Access to bpf_sock_ops.data will be disabled by passing
> >       0 end_offset to bpf_skops_init_skb().
> >
> >   3) ____bpf_skb_load_bytes() is called directly instead of
> >      __bpf_skb_load_bytes() to allow compilers to inline it
> >      instead of generating a tail-call.
>
> Some observations below.
>
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Explain why using ____ version instead of __
> > ---
> >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign=
_proto =3D {
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bp=
f_sock,
> > +        u32, offset, void *, to, u32, len)
> > +{
> > +     int err;
> > +
> > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB) {
>
> bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be consider=
ed.
> One less bpf_sock->op check in filter.c to maintain and could also avoid
> a data copy. There is a bpf_cast_to_kern_ctx() to get to a trusted
> skops_kern pointer but this will need changes in verifier.c to get to
> skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the tradeof=
f.

Maybe a dumb question, but does it add extra cost (extra dynptr
function call?) if data overlaps two frags, or can dynptr handle it
seamlessly with a single bpf_dynptr_slice() ?

In our case, the data copy is ~16 bytes, so the cost will not be
a big problem I think.


>
> If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
> all this will go away. 'struct sk_buff *skb' can be directly passed to an
> ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has already
> been done in the bpf_qdisc.
>
> [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau@lin=
ux.dev/

Oh I missed the series, the struct_ops conversion looks nice !
Since this work isn't urgent, I can wait for your series if mine
churns it.

Jason's series is adding a new op, and I guess this can be
integrated too ?
https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@gmail.co=
m/
