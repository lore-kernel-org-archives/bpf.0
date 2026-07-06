Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D40435A92
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 22:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377124; cv=pass; b=KfqBdr7mcYZTuhaWZYyfKvlHmyTiA7qJxUrMHFyPkZTTSfoJSq4qCsVKzWatgzupr4f7kRTxf6KI/q7caYG04PPwooyl/5n5frDlqKruJOQSkaWOTzlJE7PfhnlnAbqCT7Li2RPObbmYRsN3WooY23ol56kkNlPSNkO/08n4SB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377124; c=relaxed/simple;
	bh=VkMptyWzBPx8wBS35jJuVIhCQolKJDhtL7+V/Nw/XiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CQspdmC61IXzH9s8/lsFlm1pzBWvXUfKtW8MSf0gQe72xQzbe1Kxm+/SzuO7vyjjZTKKd7jOr71iXsRzH5p7MUgUG5KqgNwEL23gBEzf4dBolaOcYKomc88MzCUlMv414qxqfRtoYjN9bFHq7/es/QmZ5JrfYKC+1oex5hFNGig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ovf+5MOl; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ovf+5MOl"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6651bc5730dso5681846d50.2
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 15:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783377122; cv=none;
        d=google.com; s=arc-20260327;
        b=szCxAYOsGxGqEJXK3ieo1Broq7kTYjnWpIQO45XjE6NRB232mIzD0G+SU+POxfkNgW
         islCEaz2jktFvxu3blCq6m95xWYPRrdiXE/docJ7snH+Bosp+sK1BHkBzslLtWr2UVgF
         T/Kr1Q/ts+tk2e982qg33xGWU+vmrRiW4qVF8rhzByLXkHm+J51nYi4bV4CEYVH3iKbZ
         ER2M1zR73wDCQpt8qE9CNPKv37aPQOgnivAAEHe3VdAvC3pUH+pKQ4G5Lm5DXBzZIXM+
         APO1AGghwxd3UIRsB+Gu00Tzj+TjO3Ywy+ffLNE21bR7Zur7GDh5d5GpcTbB7u1e0mzs
         B6Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I6Kjbx3XUGCt0E7myA9GzyrUsA48dN9R24sT3zkPd6A=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=aLPPVNZsWx1YvSdapWvpbPPZUgrAKgN83hW0d1E8DOOxKuBCMv4CQFRAXH7bmul4qN
         4stvkX0myRcYb8pdOTglHxOwIag/Ipc9DRL+61cao2TX1JEy+pZDsAimgdIlo5fdxaKN
         w5KrbJ2ME6gO7gi+yMjFp+Ddy9AgdqQ31ZKKDgk8qmmkZ8+IozNYJs/AXVzGkmkC6GEQ
         27IbHCzaSUnXlH0aq9cGKJWZHdH8Hdnq1U8t7jyYPpkA9/zc5lLOkqWron+1349OafSB
         l/PsIJhTIYGg3hu2ImIreaglWO48ZRykmxp+CrguohDIsI9dx8aFXwxgyiz5afgFdMBp
         27Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377122; x=1783981922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6Kjbx3XUGCt0E7myA9GzyrUsA48dN9R24sT3zkPd6A=;
        b=Ovf+5MOllz8mIAy1sEKZ1na+dhJkwNhZA0oSV6SVjzFjoP6zUlKebgK+KHi7aaawBb
         drVksn+4r5M98K1u5EbWt6WFM5Cu5EPdtAJwXLrlJL7/ru67WvYac5a2AG9e5CFGPN36
         pbHd4IZOO5fXIJEEDHS9aSILfI/lcEblZBZUtGkdT/ROSNdlUtCWFFj85vGZYXLRRebZ
         aH5Nl41WVMWwKoFkZBVJwwElkE7XOnhyloUdgj6p6N0MseygGXaC4awl43vNIwKWw38T
         Ida7Zanm1GeF36HTr+bk3F0h/yyOSxX5qebTjwvxpQTWux9lJQtzPkYbkVVt93WPeH6x
         oKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377122; x=1783981922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I6Kjbx3XUGCt0E7myA9GzyrUsA48dN9R24sT3zkPd6A=;
        b=VYkzAvffeJZoo++7TOK+dyeSwEsB/x/dXLGOlga1CLBFnQc9iWpcQC2aSM/q4y8cHs
         tUc7QHPYZ+gzYx4u6KhcsO8Eg6K15kGqu8etif1Czf8pqnF/BwzWIrTTjZxIAs66KZUS
         /EdBQTSDq/58OarGwTzN7NYaWntvA4iDMj1uLXYWkE4WoZJqdb1NfP2rKACJpityq0UT
         w7+luviV3lV3jh0G/iXmTAXN9h1yqUXHAQ7TrG8awKmFMX7f4JJZLRAVhE+SWyncbfDq
         uSSP6P1b7eHJjPqzt749H+hKL1EjvfZ8eckLYa7VKoOmvJIp8qfZUHhcboSwDQ52CNpH
         EO+Q==
X-Gm-Message-State: AOJu0Yw6N2huc4nUKdoF60mg6DQPQ3ToKFDGrVCRUVCnuWpGNDOfv1l7
	se6basKH4o5qL6JT9MHrbC2Nnahwei5ANf7RQT5WHY/47GrYf8bmKNo6ItaBwsgWQlsDDDp6dof
	2FHKA8EjMP6mF+Kso53wUdkX72aPBp7TONthW
X-Gm-Gg: AfdE7ck/2xJexeY2HSt7o245v+zivjbRsrm6w5dYff4QNQzPrH9PT9xWlqfIt4Txnmz
	S7iuuw0vYX6yjfAQoJhYIyXAtlKQLVzJyNtHZyDtQW9pMr8XTAbvw3SMKA/fRXdjbfw+OpCtg3k
	aRd9ZrOOL0SIOksfxV8ycydC0kexVr2v2UU5sLqBbtwvjrcXJBV/WSLgWPjgu9ROiWkNp9y47rf
	Meoqw4M7ImVRkaUFIZkgt8rt5BOVhZ3Q04bmdwzNWj5aZ7ZWkYQB6WvEyjoayeyhze2UGDk
X-Received: by 2002:a05:690e:488c:20b0:664:d231:2f73 with SMTP id
 956f58d0204a3-6677fbd4331mr1524615d50.50.1783377122477; Mon, 06 Jul 2026
 15:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706171918.317102-1-ameryhung@gmail.com> <20260706171918.317102-13-ameryhung@gmail.com>
 <20260706174538.9597A1F000E9@smtp.kernel.org>
In-Reply-To: <20260706174538.9597A1F000E9@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 6 Jul 2026 15:31:51 -0700
X-Gm-Features: AVVi8Cfq0h-o8TKHV6WzOcuV2FkiGWUwG67nsfP3MjAUS5MRYZGMhzXN1WzytIs
Message-ID: <CAMB2axNVV3vFKke1S08_nr0Vbwd47QFBRhSbJv=TjwEkzBzjzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/15] bpf: tcp: Support parse/len/write
 header option hooks in bpf_tcp_ops
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 10:45=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [High] Out-of-bounds write in bpf_tcp_ops_store_hdr_opt via TOCTOU race=
 condition.
> - [Medium] Logical starvation of bpf_tcp_ops header option space due to s=
hared reservation allocation.
> - [Low] BPF multi-line comment style violation.
> --
>
> commit 16cbab0861ea029c828cf9218ec942f85b8d7050
> Author: Amery Hung <ameryhung@gmail.com>
>
> bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops
>
> This commit adds TCP header option callbacks to the bpf_tcp_ops struct_op=
s
> type. These mirror the legacy sockops callbacks but expose them as
> struct_ops members for regular function signatures.
>
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 2102f9f2afd63..7bf702117602d 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -3005,6 +3005,45 @@ struct bpf_tcp_ops {
> >
> >       /* Called on listen(2), right after the socket enters TCP_LISTEN.=
 */
> >       void (*listen)(struct sock *sk);
> > +
> > +     /* Parse the TCP header options of an incoming skb received on an
> > +      * established connection. Use bpf_dynptr_from_skb()/bpf_skb_load=
_bytes()
> > +      * to access the options.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment start on the same line=
 as
> the opening /*? The BPF subsystem coding style prefers the text to start =
on
> the next line.
>
> [ ... ]
> > diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> > index 3febbc8dd1a06..b27613898337e 100644
> > --- a/net/ipv4/bpf_tcp_ops.c
> > +++ b/net/ipv4/bpf_tcp_ops.c
> > @@ -66,6 +87,102 @@ static struct bpf_tcp_ops __bpf_tcp_ops =3D {
> [ ... ]
> > +BPF_CALL_4(bpf_tcp_ops_store_hdr_opt, void *, ctx, const void *, from,
> > +        u32, len, u64, flags)
> > +{
> > +     u64 *args =3D ctx;
> > +     struct sk_buff *skb =3D (void *)(unsigned long)args[1];
> > +     struct bpf_sock_ops_kern sock_ops =3D {};
> > +     u32 opt_off =3D args[5];
> > +     u8 *op, *opend;
> > +
> > +     /* bpf_tcp_ops does not keep track of the end of the written TCP =
header
> > +      * options, so search for it every time the helper is called. The=
 free
> > +      * space is NOP-filled, so a TCPOPT_NOP ends the search rather th=
an being
> > +      * skipped as in a normal option walk in sockops.
> > +      */
>
> [Severity: Low]
> This isn't a bug, but does this multi-line comment start on the same line=
 as
> the opening /*? The BPF subsystem coding style prefers the text to start =
on
> the next line.
>
> > +     op =3D skb->data + opt_off;
> > +     opend =3D skb->data + tcp_hdrlen(skb);
> > +     while (op < opend && *op !=3D TCPOPT_NOP) {
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
>
> [Severity: High]
> If a concurrent BPF program modifies the map value containing the TCP opt=
ion
> length during the helper execution, could the copied length cause the loo=
p to
> advance op beyond opend?

The loop before calling __bpf_sock_ops_store_hdr_opt() is scanning
skb->data not bpf map value. Therefore, a concurrent BPF program won't
change it and cause an OOB.

A separate oberservation is that "from" passed to
__bpf_sock_ops_store_hdr_opt() can be a map value and modified
concurrently by another bpf program before memcpy(). This is not a
memory-safety issue, though: the copy length (new_kind_len) and the
bounds checks are taken from a local copy. The only effect is a
possibly malformed TCP option on the wire, which could be a functional
caveat, not a bug to fix here.

>
> If op exceeds opend, would the calculation opend - op underflow the u8
> remaining_opt_len into a large positive value? This could lead to an
> out-of-bounds write when __bpf_sock_ops_store_hdr_opt() calls memcpy() us=
ing
> skb_data_end.
>
> [ ... ]
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 978d8474460b0..15915d452d6a1 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -573,6 +573,13 @@ static void bpf_skops_write_hdr_opt(struct sock *s=
k, struct sk_buff *skb,
> >       if (nr_written < max_opt_len)
> >               memset(skb->data + first_opt_off + nr_written, TCPOPT_NOP=
,
> >                      max_opt_len - nr_written);
> > +
> > +     /* bpf_tcp_ops portion is NOP-filled (everything past the sockops
> > +      * writer's bytes). The writer find the append point by scanning =
from
> > +      * first_opt_off + nr_written to the first NOP.
> > +      */
> > +     bpf_tcp_ops_call(write_hdr_opt, sk, skb, req, syn_skb, synack_typ=
e,
> > +                      first_opt_off + nr_written);
> >  }
>
> [Severity: Medium]
> Does max_opt_len contain the combined space reserved by both the legacy h=
ook
> and the new bpf_tcp_ops hook?
>
> If a legacy program dynamically writes more options than it initially res=
erved,
> could it incorrectly consume the space intended for bpf_tcp_ops, causing =
later
> store_hdr_opt calls to fail with -ENOSPC?

Yes and this is by design. Sockops and bpf_tcp_ops writers share one
reservation to avoid another layer of bookkeeping.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.31=
7102-1-ameryhung@gmail.com?part=3D12
