Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B422A4FC
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345191; cv=pass; b=cu94iqtx3ooBOf8L/t3Idz1kHHqPd7sDP4US7GYkLe3i4B65oUKgdWzyvhCx3abaIYBv5Kl0nyoAOnzGpq57f3jRb9H9SACJin1cirL+Guf9NsENbFvtoYTE4OUQwqVsujTPNSQwIY/ddIfrSGlVmhz+wDnMufalhYZdTSHP7EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345191; c=relaxed/simple;
	bh=Igi6tnJY9dqW2uqFEAkI8yxBTN/zxFPDtJhiiuyAWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4eOAwh86L1Eooci+WUdd3FBM6NCmnQZHEZd/pibOY+CFB3nMutw/pZnfCgQS8fx4hqWAtPlYv91o1khyGMN8DqbYLtqX57td+P77rnz6cC38qiJZxkq2LQGkpOfgNHe3b3K7WnykjjNht41E8Cq4qaoY93lD/5f3zNF8KZRJwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3f5l8Xj; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3f5l8Xj"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a4113ab355so567624e87.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 06:13:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776345187; cv=none;
        d=google.com; s=arc-20240605;
        b=bFbnHYxRwkYjS2amOqIVP/cUHJe/iGKE1oiJmJKw00QWHmRC5e2HCWxcfIIu9hjhdl
         MUlBcNnqrrxPH1wuhtaLdIXeKJRKJ6nGb8LUVPb03r2Td73AWdt6kix+EGywxHwr6G3B
         AhbnwUMpGVIkaslRPeO6MGQyqrSIE6Tg6UPvZ9KY4L5L5zz+RlX3eULhMfWzbwkIo00H
         L5wUaE7GxPsvl9zwv9+z44RTW3VVaSx4j9TACu+Dnxf/QgNP5siS7FYPAqRK6f00GLhx
         jF+EMwRXA2JNqL8fHVXUqgGh7/43HPREYi5ut1Wp+GWhTj4r5eIgIaih/7jvVCCU3xbi
         f0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JloOiKR7gKouLV0lGcQMz03Isz+4TmwR02S2Q3iy2ZE=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=RPfBKiC2pxAOJB61TZCs28Z9lvt8QlMbU83OvTwiV5q+TXt2+7bMlSK3guFNFwEV9d
         +NcV6OAJ5SByUe1zc/FinQAXz0EQmgUiidTKMK4HJvl4asc/4bLkaYaxLGlT+aQdotBF
         8UIk4NcwU9/UYyBcCmMPd2mReAv4xXWGupyWUSB6PVmQIGylmOKzM5ZwilwvlEOkUUph
         4RUCc1v257EdV+HZdkPJ+53yJw0U70t4vAYPZuihAwTiCaMO+FVyWerAFWWS/VctGBkW
         B5IzauVYpimiOQl+Vyy4W21LTkUfBmjduI+GUGXw1U/8R2wB5Ll98rSSKhT6JkoxECXU
         0IkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776345187; x=1776949987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JloOiKR7gKouLV0lGcQMz03Isz+4TmwR02S2Q3iy2ZE=;
        b=p3f5l8XjYkzIh4q4uNLAnMR7O2UXUNnJvJti9dD8GANa+b4E2R0e7xdTz6oXc/qPyu
         zb8JGre3mGKWgu/BTz0mydD6V4qlOfi7mbht6cDca70mwur7UMihlxR5YmXy2eBOosZB
         aG4d4WpgQrXGELO4dmRU5GH6mlSxqZM0UUJsCWque9XA8MJxb/bhAsxLyNaG5IDsTV+C
         NDf9QIghT2dsh/7QiwS750cnWlkoFaQ8NQhnqJVVXfMqIOJvCKk5iOa10u77S4Oobadm
         TAHGj2KS593UCnlY9KRmpGtbm3ka+m0GvQH0+QeqKA9jDX8IaWHm5ugBw6eAyHPQWnhh
         BUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776345187; x=1776949987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JloOiKR7gKouLV0lGcQMz03Isz+4TmwR02S2Q3iy2ZE=;
        b=sSkkKmb5Tr01tvGHqDakhWADDqJNJo9CwZw9oFsnJb26M+X0bJ+TQgS0yuG1MW6a7F
         vUGO6AhQCr+Qi2RzB/6TKgqW3hISdHlqIeudW0EwEi1nhFsyn17ZDibyOial003iINdN
         xer9uaynbXaLaJuImGvgdGGlyAUPsrYXJeIB9h3Tpg0q7stiQ2Gld4p2XMLn9RyqccBk
         jN5ZEdVqm6wO9QPr1lZ19+RsMgqramefJlE+GFw1llFc9fYfXlbKvqUmRh1RG2aZuDRX
         gzjQRHkOLO1tSV3gsh5IKRiezHNSUWUo1ohbyTJbPp47yVGYnwZKHDM+HsjPp2Z0iQkN
         r7nA==
X-Gm-Message-State: AOJu0YzxZG6cNwTpCJcEerQyx0TCu4KUmizTKkKS0JK/MZhkTNXs3IyE
	NQMu0gPpYCil5lj6zeu61qok+22FCSdT6t06GvOn+/NnKmCmovDB5v1FHcb1SoFRhKuHBqDWqYq
	ZnEDV9d0LVMMFAmroP7pYB//NL67062KWah9HdVwWAQ==
X-Gm-Gg: AeBDies4mmLzJrGgjDi+C4mT0BUK+JqyfZ7cL1lRR1zMi8ZZoAwy5EYoM7mh3+41w8E
	4LAxwqxOJl199D+JQvi/ZJxEdAm0iQhc9FDX07JpJn0USBSKCP5/bXifbcpYmUNPcO4qZe1+SAo
	fn6ZFZ2h90VJiEtkgMIjibd0cXt2hRWaIkU/aZetMDoWOQ06AJ2Own0IZDrp7r7Ewq1v/fklbEY
	Whv4XUCdoxA4wKIFJmntIYbMITmrTSJfYHNnJb35vCHm+YqcXeUANGXngeSob/1jm+p0dzDdyet
	hAlsfFjE03w+u6DKBA8=
X-Received: by 2002:a05:6512:1248:b0:5a3:ffc6:6600 with SMTP id
 2adb3069b0e04-5a3ffc66782mr5756835e87.31.1776345186718; Thu, 16 Apr 2026
 06:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-15-kerneljasonxing@gmail.com> <20260415094721.7C052C19424@smtp.kernel.org>
In-Reply-To: <20260415094721.7C052C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 21:12:29 +0800
X-Gm-Features: AQROBzCeGXvciSVxk-HpPiNiOGKinHbcNq2f1IMKWCFDQrCxv3yvqsdRowIHJ0E
Message-ID: <CAL+tcoDN3CDCyvgQasEF+7H5K20rJQov6UoVffytY37=ajnFpA@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 14/14] xsk: optimize xsk_build_skb for
 batch copy-mode fast path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] An SKB memory leak occurs when xsk_build_skb() returns an error =
for a newly assigned SKB.
> - [Medium] The prefetch instruction uses the raw AF_XDP descriptor addres=
s without extracting the offset, creating an invalid pointer in unaligned m=
ode.
> --
>
> commit 7bdeef673e571c57c404cb8d05446f46b3e2676e
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: optimize xsk_build_skb for batch copy-mode fast path
>
> This commit introduces three targeted optimizations for the batch
> copy-mode TX hot path in XDP sockets, including replacing skb_store_bits(=
)
> with memcpy(), inlining UMEM address computation, and prefetching the
> next descriptor's UMEM data.
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 3b3969adfd23f..0fccb0c8cbe90 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -751,14 +751,28 @@ int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 =
nb_pkts, u32 nb_descs, int *err
> >       if (total_truesize)
> >               refcount_add(total_truesize, &xs->sk.sk_wmem_alloc);
> >
> > -     /* Phase 3: Build SKBs with packet data */
> > +     /* Phase 3: Build SKBs with packet data. */
> > +     struct xsk_buff_pool *pool =3D xs->pool;
> > +     void *pool_addrs =3D pool->addrs;
> > +     bool unaligned =3D pool->unaligned;
> > +
> >       for (j =3D 0; j < alloc_descs; j++) {
> > +             u64 addr =3D descs[j].addr;
> > +             void *buffer;
> > +
> > +             if (unaligned)
> > +                     addr =3D xp_unaligned_add_offset_to_addr(addr);
> > +             buffer =3D pool_addrs + addr;
> > +
> > +             if (j + 1 < alloc_descs)
> > +                     prefetch(pool_addrs + descs[j + 1].addr);
>
> Does this prefetch use the raw AF_XDP descriptor address without extracti=
ng
> the offset?
>
> In unaligned mode, an AF_XDP descriptor addr field encodes a chunk offset
> in its upper 16 bits. While xp_unaligned_add_offset_to_addr() is used to
> decode the current descriptor address, the prefetch directly adds
> descs[j + 1].addr to pool_addrs.
>
> Could this result in an out-of-bounds pointer in unaligned mode, failing =
to
> hide memory latency and causing cache pollution?

Will handle unaligned mode soon.

>
> > +
> >               if (!xs->skb) {
> >                       skb =3D skbs[skb_count - 1 - k];
> >                       k++;
> >               }
> >
> > -             skb =3D xsk_build_skb(xs, skb, &descs[j]);
> > +             skb =3D xsk_build_skb(xs, skb, &descs[j], buffer);
> >               if (IS_ERR(skb)) {
> >                       *err =3D PTR_ERR(skb);
> >                       break;
>
> Can this leak the newly assigned SKB if xsk_build_skb() returns an error?

This patch doesn't introduce any new stuff here...

>
> If xsk_build_skb() fails, it returns ERR_PTR(err) and the loop breaks. Si=
nce
> k was already incremented, the cleanup loop in Phase 4 (while (k < i)
> kfree_skb(...)) reclaims unused SKBs starting from the current k, skippin=
g
> the failed SKB at index k - 1.
>
> Could a malicious userspace program exploit this to systematically leak S=
KBs
> by triggering metadata errors?

I confirm this claim is wrong because 1) xsk_build_skb() frees the skb
directly if frag is zero, or 2) __xsk_generic_xmit_batch() takes
responsibility to free xs->skb if frag is not zero and err is not
-EAGAIN.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D14
