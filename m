Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DBC4207A
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 00:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929413; cv=pass; b=p9FTrbuG0Fehk2KGRPidRdtIeGSWhSJIM6ev55aYPTY9kAJfom853FDGAEK8F0+17nE37slC5VsUcFsg+DXF4cEKRR2ONXV+zFgphT97b5geSVNgwho1J8eEDGsN/3T3URiT4LGREcnmgcRRLomxVhDmgRXTe5vmhgjTq5nGD60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929413; c=relaxed/simple;
	bh=xYhARfwZEM66RbtIZaWA9wEg+I6VTgAPes922/8IbTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TeJB8Kc+LtpvNBzZ43uXZn5APxuMK9ktYBN5H6+IquD46U5kTdMZqyyAdI80I1zPw2sHKLkKPrhBh7A8ZSzT0wmqMtDUnMf11YgNy0OdY/g7b7WzEuluLSY9IuYxPcRCLibwM4ydvu6vRvxAwqK3KYYVqyUF7AK1k0VnKUo1LD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRew8Bns; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRew8Bns"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa2d5a1d51so5324744e87.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 17:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929406; cv=none;
        d=google.com; s=arc-20240605;
        b=EB/QzI+Oor88WDuP+yqmK2vRFQU1dI6qYaEzyxvmcmJOcSESAoQ5Ycrtysj5F2YMD7
         ZgNfKxQ7WjXOYm18BRG9UjsB5wacbp9hHqY1uqSPcGuT5cnWFx4DFE+Pgvtm8Y6cGvAz
         UnqaaA/8JQX/uEfGBsf3oX5PEgniSfR2d0QdeoJCv5p57yaCUudfG6Xh718fbAAOdxX3
         dTcZ86/uIG7xS1CBer1lVt/i8t5UT0rFfG2ewhPz5MWPD8Fjc5N+G6jla5f+QwbXUS4b
         bIf773WXMTw4yPyTmtDYU5zsvuXK46YHfb/MRqnUwB2LgqNsQ6LkAqUSVFKENwuTp8Xi
         yNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        fh=ZIvvg3514Y/1hqVQgbTKOP+DQm5TC491cAhAUqCU54g=;
        b=KCxzsyAc6M4Ecm5jMR1AnJB11c9EaLESbxS6fUo3f3yECDISHJIJACr/AM+gAIOL32
         wS1DjSEqgtyYIm4shCoUJRBbxzFr/EYgb9aIfbpsEXuY7haGiPhyGKdP7+QZNifP0OGR
         um+b76IF0q1CaJ2OSNW+C86PK2uUObfVYUQudT3DUEdnCiIMhZoXVGZ+vQASCD7PYH2w
         AI8jzE/9pSofQkD3UqEOKGxjCOzKexbym7cbcF556unFvmcvLsZr/J8e91Zkh1bNrXZn
         MWLd/WfwhgG9EsswxaVfD180sjgK/FFtx6Bvqe0omGOXPFrkY5s6gPFBJaVYZUaq+OAI
         fAqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929406; x=1780534206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        b=mRew8BnswQhCUpUV1sSdAqFT9+jlSQkkCJckkfRsQBKKHCrJ2+BqbqXR4TImd1+eYG
         IRLNEU9LeQJP/TpcCW+ekXdpe6CsH/I5KYhXkuw0LZd61jrWBXTZV6pE1N7y0gfA9GMI
         0zjZRgEM+nfmW62JpnandErG90whxOTS/fHh/besVXCezeedikWJy2l7F9Rm0Aslk9QV
         YM6gMZj9eJAgOxKA6LM099mphzCeqCUX75aMheE76gaimQiQcUfSptX/RdU6K5opfV75
         KAbVAkDEz3fTn6vla/7WHFc5WWWj0zBbtF6EjM6ZpxkPMIA/UwbuO/lQvF/Ab+kRphPP
         4okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929406; x=1780534206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RruAHf3R1iczwm3Zy1aUkt69+/qOGV8X/zp2I0JUps=;
        b=kU+8Xy9NVzZwN2Rx0scx9i9yjULQg79LRYHNYfEZSxlQ0eVdGmzZl/nRx1m6Qd8uX9
         EV90q8WKxq5G7thsvZTY9k6FUEgt0n+ZJ9cqTquyEhXbEbKbi7nU2ijzoglny8sJ1hA6
         I3H+l/e8iDSP9+PBI6F+EIuyoTHT7dHr0+2om1vdodeJhCAcAGyUalQsaqfJND2RnWEM
         SO2JXL8faGNn4hogvZ0V+0Ej11Tg+/1lNvSLM0Wjn9mp0eV1SkPeOKkSBDC075SDut+g
         mc4/JRtu+LSKAcWij0vryLPnfzYlEscPggQMR5MKcL1/J3hZyopRhTv5Ny2/8fEtgYMp
         plqQ==
X-Forwarded-Encrypted: i=1; AFNElJ90I6YnGyNi0guoQTDgxRvWHJJXklFZqnMNuQYoxszvIasFpQrQ4bbT3Y86BXWyEbCF3YY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxY27O2V3KomP+Uga81kMYuL8wNEWMJz+NFbR9PESl90CpLNsa
	NVsmFumYggYXD+LS+2W3OEHzrTsr7qVRcVYSgPGpYzZejeQab0SvbqsNZJ5p/ZR6J0O54+9RklS
	bPkkIISiaeiDZBnJnv19bEFx426HML3w=
X-Gm-Gg: Acq92OFwpGp2/gHZjgX7EVVBHbt8xHUEur0sme4EXROU4sO5BBakXClu54MHiiaSn4H
	jqzAwcv01G0NLSnzlxC/jANUwpiJ6+S4nXRAMwmxqdXgqB6BKNlgx+ckNjDfA7QebuXgKhsM2dE
	xfP5/nPbLoDfNpfmmlLCBTltopA18MrZsqrDB0hUWR3Px3xvKNvLkhLRx2Aq6s0mXCnQ4Zp3I4v
	JJrzk+S3OAHODL8VPdsmsyI0c1TpCqpolYx+qxCHLUQTlRv1B6L5JlvBqsxci74/UE3JiHQ38G5
	nVydd91hY7YW6LCo8HOz9QK02jhkHA3sI6SEPZ4ndNdywKBh6w==
X-Received: by 2002:a05:6512:38c5:b0:5a8:fb56:e322 with SMTP id
 2adb3069b0e04-5aa323cd973mr5362329e87.36.1779929405522; Wed, 27 May 2026
 17:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev> <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
 <2026526214538.Vhly.martin.lau@linux.dev> <CAL+tcoCSU9KFZsV33LE2R89iUzb5b3Xm+h6QObs5GOuRYR3sMQ@mail.gmail.com>
 <2026527192229.olv9.martin.lau@linux.dev>
In-Reply-To: <2026527192229.olv9.martin.lau@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 28 May 2026 08:49:27 +0800
X-Gm-Features: AVHnY4Lm6VOcSFNccR8V2egxgBLwuwM8XRk3VQR9XX6AG1Yyaz6z1iyik6SXvJc
Message-ID: <CAL+tcoChM9j1ehCeNsiFNoEk0t2TPr6ENt+hfif585hYo=mXcw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 3:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Wed, May 27, 2026 at 12:01:11PM +0800, Jason Xing wrote:
> > On Wed, May 27, 2026 at 6:19=E2=80=AFAM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On Tue, May 26, 2026 at 02:21:56PM -0700, Kuniyuki Iwashima wrote:
> > > > On Tue, May 26, 2026 at 1:34=E2=80=AFPM Martin KaFai Lau <martin.la=
u@linux.dev> wrote:
> > > > >
> > > > > On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote=
:
> > > > > > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > > > > > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> > > > > >
> > > > > > In this hook, we want to parse the RPC descriptor in the skb
> > > > > > and adjust sk->sk_rcvlowat based on the RPC frame size.
> > > > > >
> > > > > > However, we cannot access payload via bpf_sock_ops.data on
> > > > > > modern NICs with TCP header/data split on as the payload is
> > > > > > not placed in the linear area.
> > > > > >
> > > > > > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> > > > > >
> > > > > > Three notes:
> > > > > >
> > > > > >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> > > > > >       invoked from recvmsg().
> > > > > >
> > > > > >   2) Access to bpf_sock_ops.data will be disabled by passing
> > > > > >       0 end_offset to bpf_skops_init_skb().
> > > > > >
> > > > > >   3) ____bpf_skb_load_bytes() is called directly instead of
> > > > > >      __bpf_skb_load_bytes() to allow compilers to inline it
> > > > > >      instead of generating a tail-call.
> > > > >
> > > > > Some observations below.
> > > > >
> > > > > >
> > > > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > ---
> > > > > > v2: Explain why using ____ version instead of __
> > > > > > ---
> > > > > >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 34 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > > > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > > > > > --- a/net/core/filter.c
> > > > > > +++ b/net/core/filter.c
> > > > > > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_s=
k_assign_proto =3D {
> > > > > >       .arg3_type      =3D ARG_ANYTHING,
> > > > > >  };
> > > > > >
> > > > > > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_ke=
rn *, bpf_sock,
> > > > > > +        u32, offset, void *, to, u32, len)
> > > > > > +{
> > > > > > +     int err;
> > > > > > +
> > > > > > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB) {
> > > > >
> > > > > bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be =
considered.
> > > > > One less bpf_sock->op check in filter.c to maintain and could als=
o avoid
> > > > > a data copy. There is a bpf_cast_to_kern_ctx() to get to a truste=
d
> > > > > skops_kern pointer but this will need changes in verifier.c to ge=
t to
> > > > > skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the=
 tradeoff.
> > > >
> > > > Maybe a dumb question, but does it add extra cost (extra dynptr
> > > > function call?) if data overlaps two frags, or can dynptr handle it
> > > > seamlessly with a single bpf_dynptr_slice() ?
> > >
> > > Right, there is an extra bpf_dynptr_from_skb(). I don't think we have
> > > benchmarked it.
> > >
> > > If I read it correctly, unlike bpf_xdp_pointer, the skb_header_pointe=
r
> > > will still copy even if the data is in one frag. It works well if the=
 data
> > > is in the headlen and the worst case is to copy, which is the same as
> > > load_bytes.
> > >
> > > It is a readonly use case. Maybe the bpf prog can directly read the f=
rag.
> > > Regardless, it is useful to have a kfunc/helper to read it.
> > >
> > > >
> > > > In our case, the data copy is ~16 bytes, so the cost will not be
> > > > a big problem I think.
> > > >
> > > >
> > > > >
> > > > > If this new rcvq callback is added to the 'bpf_tcp_ops' proposal =
[1],
> > > > > all this will go away. 'struct sk_buff *skb' can be directly pass=
ed to an
> > > > > ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has a=
lready
> > > > > been done in the bpf_qdisc.
> > > > >
> > > > > [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin=
.lau@linux.dev/
> > > >
> > > > Oh I missed the series, the struct_ops conversion looks nice !
> > > > Since this work isn't urgent, I can wait for your series if mine
> > > > churns it.
> > > >
> > > > Jason's series is adding a new op, and I guess this can be
> > > > integrated too ?
> > > > https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@=
gmail.com/
> > >
> > > imo, a new sock_ops cb should be added as an ops in struct_ops. For e=
xample,
> > > in patch 4 of that series, bpf_skops_rx_timestamping assigns u64 to '=
u32
> > > args[4]', which is adding tech debt to the current sock_ops interface=
.
> > > For the timestamping case, it could be a separate ops for the
> > > 'struct sock' instead of 'struct tcp_sock' because it should
> > > at least work for both TCP and UDP.
> >
> > Sorry, I don't get it. What is the tech debt in this? And
> > bpf_skops_rx_timestamping() only outputs the timestamps, which has
> > nothing to do with either 'sock' or 'tcp_sock'.
>
> Did I say the tech debt is in bpf_skops_rx_timestamping?
> I said the tech debt of the bpf_sock_ops[_kern] interface.
> Besides always memzero the whole &sockops, the way that the bpf prog
> needs to get a u64 timestamp from u32 is not thrilling in 2026.
> args[4] is also not reliable when the earlier cgroup bpf prog
> writes to replylong. We had already hit some of these in our rx net
> timestamping discussion a few years ago. I suggest you go back
> and revisit.

Actually I revisited some historical threads and didn't notice
something like this probably because of too much information there.
Anyway, thanks for your information.

>
> >
> > Could you show me what to do next? Thanks in advance. It sounds like
> > the tx side of bpf timestamping should be adjusted accordingly?
>
> imo, the bpf_tcp_ops can land first. and then add net timestamping
> ops (existing tx and the new rx) in bpf_sock_ops.

I'll rework after your series gets landed.

Thanks,
Jason
