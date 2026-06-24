Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7F7308F26
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782329872; cv=pass; b=mqMQqGNqs+HkHplzC1+DwZnE0Q0Yp7HlG+jJKSk5QRBLi4MDuz/Dbj9/E+H9dXNXGD+5OZgPmzA8PRW9eOeXOIKxGckOUClChgkd6rNPeYCWi+q8Zp4rknoCCM6S3ilLqClMqhvhismvIa/ofRHeIuUPEKRrEpV3z9LIDC7NHN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782329872; c=relaxed/simple;
	bh=GllgBcs7itEW4894JZAopXwN8/rtekGyTgYh7QSrd3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGuHofknZoZu4cLvNVY/U7fhbeTK1mjvDTpXMDblE5rBunfLEoDUZ6yfNpdup5ooWnqmDvAtJrHRhnMEWwgSbGZvZjw3eMs+RWZN49d7y6a0KHvaAIY4ErnUYMMkikct5oXTQagiNXYWijn7RbECoopcqpWfIx4WXgsnhpdXugY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8gC3kdz; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8gC3kdz"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-662b95934dcso1699702d50.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 12:37:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782329870; cv=none;
        d=google.com; s=arc-20240605;
        b=JijmQnkmWHAVdyMhYiYpQdnEmNPR5hbcFI8HyqdVVCePU6kTC7c8/nwEe61anAEl7A
         ity1jUdSF4YyG4pIkmYgvgB2DkCemc6dFk3HND/efdzp6XnBtYa7C8gjG14R1727tZsv
         yIXXurtf15NpZBc0Fil16p/h4rq8CzqEtjruIdrMV4meSrMgk6xOuiZ28VfFdpcgMPWh
         1u0nfJ7F+dEfnXTlsbyI1mfiO2er99dM8mNaHnpGDIE8cWkdZ86lLVm+ebDTKe/NnzOW
         eFkBfV9xfy0iIeXwvlQaIamzJpKojCdnRQJRKwJ50R6y+LZP0Hbcqog0awUzflQ76Gbp
         M8Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=URp0L1lYBHGwRqyQw+KN67MjI1sc7tNut0CrqAxYvkI=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=hAzTolWTPy3rZysAWKusEu0gYtQ+XxOfI0MNWswGezbaPLCroM50Gwg8v23Zy2ujjL
         2HS4VFV28Bix1TrnAwSTOzKsulce9Qtg6ZdIlrWlIbytAipYqBLKrxOOrAwBXroESVgV
         oo7P0Jerfaht4aExZd8bVJeSqzC+ZCegZ6r+YXoNmMJOt92cpH6LGKnc9VJlxmDond6E
         7Si9Yu55l52lVc9oODiwn2fVHq8+M5UFGs39O6Fzq/AQYCP4wYVHtRkq0J/ZifKB+lzh
         pwFrC8hVvoqA6uxwLxwhOtsetCh9nC8YBdltRvG46BsudEpeKDRnmkJuv1N4A94iGRvs
         Hlsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782329870; x=1782934670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URp0L1lYBHGwRqyQw+KN67MjI1sc7tNut0CrqAxYvkI=;
        b=b8gC3kdzFZ5D7SWDtPkR4QmuMxkaAUXDPt7HIXOyTJqD5Coyxcj+HJY04nCwXk+NPh
         fjQ2f9rcm3ZbJVcNOc+P3ciAFKZS3IaQYHQOMc9WJ/YfHHEZrzXXHJvZujumKRDbKKt4
         XQyGBnoOwXMdYu0sIGb7hcAsYS7WbR8/UJMHUFWCgu8vJ7Dt+HoIesPDtQLKTHICK/hv
         Msuw57LK4EQDsNcy+alAsq26urJA4MHdF6/qilFQaxsHYnTfp7yvqQ2BkehOsNHnCjd8
         6PXfr77xTWyNZ6SFKzN6Ocp8IIqklBTePiVzyjSfQErBtMcbVs7qIJ0GJ6Ne4KE9W+zQ
         X1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782329870; x=1782934670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URp0L1lYBHGwRqyQw+KN67MjI1sc7tNut0CrqAxYvkI=;
        b=EwUnHfvUir5pjNh5c7zwOtyA0JNqIKykFDtcJ19o+dwJOpM661LWwPyPTfiNABDunG
         +QTd1Iq5YVm2JZc51rUEdAyi86RU3KMSAkjgSYXuOwHqSRGQ8fZcjDOs03XqdKVY5Ebk
         iew6kdzrKXMkMqMUn1hysZuyEiKATxJCtiQUtfSjrqQfVPRC89xs6QWAH8ajg3kzsxsn
         G4NsdCtiHbY0CL6qgHVheAykrOweYJ3Pfb9gSLIE3N1axq/Jg8WqCJ7XMJVpwuHsHMEw
         JjQxjq89ir+qP8qnAp5pE+WA41yL239MD/WbhWi16DkCaTvJXT5GK5Z9P2boBvmQhzjr
         GXEw==
X-Gm-Message-State: AOJu0Yw0ht5PL4z2Z/G01m/Ge7JrWVuyy6yT0AW+0rzDQ/fF8yHNb10g
	3+t9mADAjLLt8wHGjSrZ8nsBlxFwATp0fx/o4s3x/X3PEKIDdgKSg9Spbf4BOgEdlOiviX3NKIp
	qrlkjXWZWQ03j/gFkjuod1wa5aCFbm++f1TiT
X-Gm-Gg: AfdE7cmuS3qdfe3HNNcrLP0iJo3xFqB4LjtG3EsWk3kE7lVuCo7BWMx7ccv9p4/drRq
	GqOOx92agYxTKSGppMamMn2+qKMsJyy/qDlEtuzv2cyktfKG3+GHUtbZfgOK28RVTRXlRQooTe6
	CS000WfkOlqvPFNuyyLlhAlN6H3Lf7LmZKzKuCenHJgn5pkmBcT2TzBvNrMpxhcKzPregAo7pSS
	j349C1XD0bd5+6xI/RGeFnWgWTnvc/KxQ8sUgDe6/vX4sy7OMYHcbj6rX2pEv7iCaTezhlC
X-Received: by 2002:a05:690e:124a:b0:660:e09c:d57 with SMTP id
 956f58d0204a3-66359eda206mr7571115d50.29.1782329870009; Wed, 24 Jun 2026
 12:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623175006.3136053-1-ameryhung@gmail.com> <20260623175006.3136053-13-ameryhung@gmail.com>
 <20260623234059.132101F000E9@smtp.kernel.org>
In-Reply-To: <20260623234059.132101F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jun 2026 12:37:39 -0700
X-Gm-Features: AVVi8CePzLI1GItTni-IRcFpJEANx5x0teJCdRQsOaLFcwXMDm4RX1VHNkz46nw
Message-ID: <CAMB2axO0UnZDC6Ea0y8fL0cxz8qmXzU5UdqAarL_JVLfcOn29Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:41=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Incorrect pointer arithmetic on the BPF context array causes NUL=
L pointer dereferences on 32-bit architectures.
> - [High] A missing bounds check in TCP option parsing combined with a TOC=
TOU double-fetch allows a malicious BPF program to cause a heap buffer over=
flow.
> - [Medium] The struct_ops TCP option reservation is gated by a completely=
 unrelated cgroup BPF static key, breaking the feature for established conn=
ections.
> - [Low] Multi-line comments in BPF subsystem files violate the required c=
omment style.
> --
>
> commit d91122a96beff2abb78548435a7fd30a3c89c2ac
> Author: Amery Hung <ameryhung@gmail.com>
>
> Add the TCP header option callbacks to the bpf_tcp_ops struct_ops type
>
> This patch exposes TCP header option callbacks as struct_ops members to
> allow BPF programs to parse, reserve, and write TCP header options. It
> mirrors the legacy BPF_SOCK_OPS callbacks and shares the reserved window.
>
> > The hdr_opt_len fast path in tcp_established_options() is gated by
> > cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS). Note this is a global,
> > per-attach-type static branch: it is enabled whenever any bpf_tcp_ops i=
s
> > attached, even one that does not implement hdr_opt_len or that is attac=
hed
> > to a different cgroup.
>
> [Severity: Medium]
> Is this description accurate? Struct_ops do not enable this cgroup static
> key. Will this check evaluate to false in non-cgroup-bpf deployments,
> skipping space reservation for established connections but still calling
> write_hdr_opt later?

See reply at the end.

>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> [ ... ]
> > @@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
> >
> >       /* Called on listen(2), right after the socket enters TCP_LISTEN.=
 */
> >       void (*listen)(struct sock *sk);
> > +
> [Severity: Low]
> This isn't a bug, but does the BPF subsystem prefer the opening /* to be =
on
> its own line for multi-line comments?
>
> > +     /* Parse the TCP header options of an incoming skb received on an
> > +      * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load=
_bytes()
> > +      * to access the options.
> > +      */
> > +     void (*parse_hdr)(struct sock *sk, struct sk_buff *skb);
> > +
> [ ... ]
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> [ ... ]
> > @@ -66,6 +87,99 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
> >       .retrans =3D retrans_stub,
> >       .connect =3D connect_stub,
> >       .listen =3D listen_stub,
> > +     .parse_hdr =3D parse_hdr_stub,
> > +     .hdr_opt_len =3D hdr_opt_len_stub,
> > +     .write_hdr_opt =3D write_hdr_opt_stub,
> > +};
> > +
> > +BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> > +        u32, len, u64, flags)
> > +{
> [Severity: High]
> Can this pointer cast lead to reading the wrong offset on 32-bit systems?
> The ctx array contains 64-bit integers, so casting directly to a pointer
> array might result in reading the upper 32 bits (which are zero) on
> little-endian architectures, causing a NULL pointer dereference.

struct_ops is backed by trampoline which is only on 64-bit arches so
NULL pointer dereference should be a non-issue.

I will still change bpf_tcp_ops_{load, store, reserve}_hdr_opt to the
following style to silence -Wint-to-pointer-cast warning on 32-bit.

u64 *args =3D (u64 *)ctx;

struct sk_buff *skb =3D (void *)(unsigned long)args[1];

>
> > +     struct sk_buff *skb =3D ((struct sk_buff **)ctx)[1];
> > +     struct bpf_sock_ops_kern sock_ops =3D {};
> > +     u32 opt_off =3D ((u64 *)ctx)[5];
> > +     u8 *op, *opend;
> > +
> [Severity: Low]
> This isn't a bug, but multi-line comments in the BPF subsystem typically
> place the opening /* on a separate line.
>
> > +     /* bpf_tcp_ops does not keep track of the end of the written TCP =
header
> > +      * options, so search for it every time the helper is called. The=
 free
> > +      * space is NOP-filled, so a TCPOPT_NOP ends the search rather th=
an being
> > +      * skipped as in a normal option walk in sockops.
> > +      */
> > +     op =3D skb->data + opt_off;
> > +     opend =3D skb->data + tcp_hdrlen(skb);
> > +     while (op < opend && *op !=3D TCPOPT_NOP) {
> [Severity: High]
> Does this loop prevent op from advancing past opend if the option length
> byte is forged? If op[1] is maliciously modified concurrently in the BPF
> map memory before __bpf_sock_ops_store_hdr_opt() does its memcpy, could
> the next call to bpf_tcp_ops_store_hdr_opt() advance op past opend and
> cause an out-of-bounds memcpy?

OOB is not possible here. The loop only walks the BPF-reserved option
region, and that region is NOP-filled and written exclusively by the
store_hdr_opt helper. __bpf_sock_ops_store_hdr_opt() rejects any option
that doesn't fit.

>
> > +             if (*op =3D=3D TCPOPT_EOL || op + 1 >=3D opend || op[1] <=
 2)
> > +                     break;
> > +             op +=3D op[1];
> > +     }
> > +
> > +     sock_ops.skb =3D skb;
> > +     sock_ops.skb_data_end =3D op;
> > +     sock_ops.remaining_opt_len =3D opend - op;
> > +
> > +     return __bpf_sock_ops_store_hdr_opt(&sock_ops, from, len, flags);
> > +}
> [ ... ]
> > +BPF_CALL_4(bpf_tcp_ops_load_hdr_opt, void *, ctx, void *, search_res,
> > +        u32, len, u64, flags)
> > +{
> [Severity: High]
> Will this cast misalign the array index on 32-bit architectures? Treating
> the 64-bit integer array as an array of 32-bit pointers will cause the
> wrong bytes to be read for the context argument.

Not a bug. Will change silence compilation warning on 32-bit arch.

>
> > +     struct sk_buff *skb =3D ((struct sk_buff **)ctx)[1];
> > +     struct bpf_sock_ops_kern sock_ops =3D {};
> [ ... ]
> > +BPF_CALL_3(bpf_tcp_ops_reserve_hdr_opt, void *, ctx, u32, len, u64, fl=
ags)
> > +{
> [Severity: High]
> Could casting ctx to a pointer array here also lead to a NULL pointer
> dereference on 32-bit systems due to reading the upper 32 bits of the
> previous 64-bit argument?

Not a bug. Will change silence compilation warning on 32-bit arch.

>
> > +     unsigned int *remaining =3D ((unsigned int **)ctx)[5];
> > +
> > +     if (flags || len < 2)
> > +             return -EINVAL;
> [ ... ]
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> [ ... ]
> > @@ -1244,6 +1281,15 @@ static unsigned int tcp_established_options(stru=
ct sock *sk, struct sk_buff *skb
> >               size =3D MAX_TCP_OPTION_SPACE - remaining;
> >       }
> >
> [Severity: Medium]
> Does this cgroup check evaluate to false for struct_ops in non-cgroup-bpf
> deployments? If so, does it silently skip reserving space in
> bpf_tcp_ops_hdr_opt_len() for established connections, while still callin=
g
> write_hdr_opt unconditionally later?

No. CGROUP_TCP_SOCK_OPS hooks are turned on and off all together.
write_hdr_opt is also guarded by
cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS).

>
> > +     if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS)) {
> > +             unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > +
> > +             remaining =3D bpf_tcp_ops_hdr_opt_len(sk, skb, NULL, NULL=
, 0, opts,
> > +                                                 remaining);
> > +
> > +             size =3D MAX_TCP_OPTION_SPACE - remaining;
> > +     }
> > +
> >       return size;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.31=
36053-1-ameryhung@gmail.com?part=3D12
