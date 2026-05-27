Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3624386578
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917975; cv=pass; b=uaZbDvd75OK8Rku8U3fmqYxXANW1YZyU5yA30iDsSF2Z/Fj8QOB2FsCs+KWXHuXGaWgyxTsNl6u30AM/QGf+ixSRTigPeRIJp9mazknADxF2LgpH12KpxbFzllvCgj2+qpRFhMxnmyhndp8GIH1dxdD4Wnj3b+AUf17rEX6ygfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917975; c=relaxed/simple;
	bh=Azl2N1qDX28IMFT3anmcWnp4A6VApp9TiA9migTR4bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=plEier0oxKfdKdHsa7w1whq1+W/98Okq0SpdrNce7KbLPWp1IGM5c51/FAOhFrZspf+DOZjQsq8bNHRduLIFIhyCd+RiHkj48NUmzu7zzgBdVlQ5k6FHRvrEDZ2ZYRUJux/SsvLButQBLZN3Q2LWrR8IxA95sGMtcDgPF9T6c80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPQojiSA; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPQojiSA"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-135e88b8e55so6640806c88.0
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 14:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779917973; cv=none;
        d=google.com; s=arc-20240605;
        b=ILd/eAhCZ/qpNY6qh6YflmA1b2KzGhGOx//+HNFjm+MdVfI8YTtJsXmVQEdq423DZA
         FHMfUP8W6Xv3/R4wndDy5yO8ZiBDUMCQip5sFYIrB94imLPBhkBfCP46+iU55Zmm/ycA
         yjSXhhA/fkLOZpW8KZGwf9gDl9fSsFMjy/NqhXTw7gUMYOqZQCdrN47NuOkGsEiLkjdH
         MGNqrNUtQjwk/r0E9MzT8lWyFUw7C9mHEb2qFQZCt0UFJAjteT3DuijxmkJk3Ov3/DLy
         57K/cYdt9DKtz+WEM9OCSuHxO/9n2O1tDZMT4AU8851z/gsFMHNQr4TJ6RRXTMvbZffZ
         H49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        fh=I6XCVfO1tTv6gcoJNDlAkAOBBQgQjxJ01O4UXmnzxoA=;
        b=aTphH5ms+dTc6bzShCxuZsG0JlUlfADpZHTSlxT3lwnCVxvWwk4pjNUmgCHmIboQe8
         guCvALZFnXq2XFon24TXT5fJZbkcBoId6aFHIOUzVidGyRHXQq2P19NsY11QvaADpVv2
         cUteO8ZgSfkH+xXdNec5WI9I3jyd5SdfuyDJ2h14c7MbObvKshYLM+FzkyRD/N4i87jc
         Z2XcvJkPczSs7CsOCEOyfAUL21yxR6w6vUhyuC+feBcRZ1TBl1QfPoDI2VDuvDBk7EEu
         bs1EHLrX/ea3ZAtWNFvbex6lvKD5vi7mpkk4s3jl6PFhdWth7FbEHiTSj+2Y6squwjcH
         RBNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779917973; x=1780522773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        b=vPQojiSA7p0TZHjl6cQ3se2J3VYhu/NfzatXHTvTjPX5Qv5sh3mYnY+Mgdsh52g4iE
         YED3A1khsiatCMe6oEnB7god8lFTqd/CNVN2oNYY438BDAJRs/UorLffhTLD9bqvkZSr
         i+U5hEFyhlzQEm1UuFWBt0ERdXtx6qWZSzxETXvsCFIBFfNhVZ0J+NkWVQgq7/abwJxv
         mqGNNrU/U3j8gmfFOSTQ/Z8v4ogfEPIA2exF+fL+GIKg1QOF1OpwoZ+3yOvN9JVb3bgt
         2iJydvO4SaEco4hbq2GiAYGba6VtKKpahP1qKbbJUxvHfwuPcxF/ZMuYq4jNJq+Q7dnA
         KJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779917973; x=1780522773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsWR6kFTZIW/F9UtjVVCYshPAK5/7mRvni26PxYshbs=;
        b=HAoaD3dUbBFv44huUIYCT7MuluH1RLSd1/XOEtET1IYS2j7xF58OKHu6G3B9q9KKj2
         oDfuhNpENNBwc6Mh/Kj7y59xqlHYRz3kFYUOd7Y+MKKDOX+tQUXAtCB944GRXVV8igM9
         RtltJQfYR9E9swGODp0RtHPRizdg0k1GlF4ty7GqXszFEUJk0C5goJl6vliAw7nW/kYG
         96s47EulQ0ynK5JA0gHXwzCqGtP5E5vfP6D3k/6o5dvgxZ9IwtP2MjGHAruggoe2i5r4
         yoEV5nKrr/s1XqSSvNsyoEoWvyGNd2J0hW9+aS46A2Er5h3cezBt7XwUtfb9UVyxHwgG
         4kCw==
X-Forwarded-Encrypted: i=1; AFNElJ8ETR6/WwtJ9+FM1xnVz6t7GxgVTFX6a91bb2aZlpJmnOWUpKQck+ZXyTwoBt3xyv77AB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxae0AXw/YDPyM4gQtwQH70hAoSFwfJAT6BhtlGyGAyFf45RYbu
	k50tW3ipBki7flgFsW3w4tFx5tY3apLMcOzfw6XST434905aX59dfgGEXcipWTvH7O700N5uEtB
	N4f7RoK5iRXOckt1HGYW3aQKKUKAro4410A4olMFm
X-Gm-Gg: Acq92OGNKZY6Xeqj8UO5SWam2wjOGh4E90S83oC6502QtxefATO2Nd7zayz0slg7nBQ
	b8hfatjqhO79r7rtX92puiU9JZ6X42Zgqgvt+oInIAMhHNvCrUzWI4vQCxkI9or4kwroLztdEar
	WDmj1oy8dfFkK7oPe4N+zWXqr7KtroNzNKpLV6nhRGk76nlL7JX0FN6OgjlpOIw8IGU7c4mUKNA
	BfYoyz20m8vTRJU3xsCjjrCwd5iR0HlSvfh/QLFN322tdb2V7izJ5kRspw7vtI1L+LAZj4ly+kS
	SB4x3d01Wn3BaW8qFAcSb9SybxSVXs31I3cxmvgs3nDlztwrEx5mYbYpH10WE9su8b7OWNB5pqK
	y73RfsL1LylkD/cdl0KoqyTvB2v9NSjJRPz1TtFd1OGcoyWyGt1/ns/AaoUYy
X-Received: by 2002:a05:7022:68a3:b0:130:9b78:b18d with SMTP id
 a92af1059eb24-1365fc62681mr9035515c88.34.1779917972029; Wed, 27 May 2026
 14:39:32 -0700 (PDT)
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
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 May 2026 14:39:20 -0700
X-Gm-Features: AVHnY4LZ1ZekIy85DRxvpz6p_60yQs1GhUjCCtYFD08nRjEQ4pr1PZ0F3sLp3G8
Message-ID: <CAAVpQUCUV=N0dEi8H51Y0oZytnohkJT1=B6zT3gxEKvb_5bukg@mail.gmail.com>
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

On Wed, May 27, 2026 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
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

I remember the tech debt was mentioned when I implemented
BPF SYN proxy in SOCK_OPS too.

>
> >
> > Could you show me what to do next? Thanks in advance. It sounds like
> > the tx side of bpf timestamping should be adjusted accordingly?
>
> imo, the bpf_tcp_ops can land first. and then add net timestamping
> ops (existing tx and the new rx) in bpf_sock_ops.

Sounds good to me.  I'll rebase TCP AutoLOWAT feature on top
of the struct_ops series.
