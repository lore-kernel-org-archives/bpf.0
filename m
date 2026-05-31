Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863461DE4EF
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780203680; cv=pass; b=Y2fLohlaGRlnOy0gqnjViku8hkiBOUrRrmxt3ti91A7UReFvMuNkUcHxViqjp7nwfXrlkuKBZwYl9JV00G7rK++Sf0BaCkpi50GS992F9MRYcMw1BUgiXf9hq5DLht3eULe2IPSQCKMi2pmLT+WsA0V/j2NNfdD3mI28O3mwgNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780203680; c=relaxed/simple;
	bh=uDqPR19CBC2h8AzQ/4XtSluc0ZTH7/6e2TiZJ2kK5hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0N+BLxbfWeL0MWyDqWFeEtHCB+JrQnANwBUNyAkMrlW6YxwB9ZSIiaHcWOMgePIaPdSGCSHyFtdqBygmErY9+CypwoUWEvWgKQugLJPauA5h/aqlx2u6LINIoHtFjrszE8F7W+mtd+vj/gc5GrLuQz9gQapoKv4QYaMm7DyLEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXQNiSJ8; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXQNiSJ8"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa653221d1so785546e87.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 22:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780203677; cv=none;
        d=google.com; s=arc-20240605;
        b=dIaZcULyayELBt1mhKuJ0bzEE5cCbCrtUeaB+3XeB+c25XavzfhLY3cP4qLhHW8Fwc
         3+qZTCOJ+MzcjY7cE4z7DqHgDpGp58QBJm0uzbpQYdLPooIKgAcp32QJq3eo8L/VC0cA
         os7umvufToaqEvRSTc/pmw96AjQqGtEMhnRRslEe4cCrOSezCmfLMA5hkqKZcMlbpDfk
         PjKfE6GxRyYckjshv3ELAAfdyvxsYuJx3aj0FLQyvD8BsQU9/JHy6C/YNVLY4m0Yr5xA
         oXFwGMkCfiEZ15eCCDLdoLppGCx1wp/m7B7Mp1Q/T97hLLi1EXfcT0SCDGCkOZd+O3gr
         D+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nqgOgNRdeGO3Yt8rRsoJuC9RkIgPZyiihaZvjuvwF3w=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=ivilXdZWQWbnlhZ9CyAzZJRPaU8oF4tdSfvMWNfXyBqCVznaVEbPl2zjWBPV4cXVBV
         Ff/VZPmfs4g79PP0l8SwezUtnNQ7+iZCi2KPx5MJ1MFP5an3ECX14Y0AzgWrSLjiSkfP
         +3qTQVgAoxqZrmV6son1U6/55R8Fk9HKhcce277sBw5F62Q6olQlminCfz4jxTmI0Xrb
         fYfquZnr0g5iIqLud7kW9nsJ46J/ymFF0c3oaydDTD2GwAJtvDQweRSirU8+f0SvbYPB
         2mCu/RbRS5dtbd14Z4Oml4914Pm3oVhdnAFz5CYf5c5xVF5IfR6L+WOGTZStJl+T+9Oi
         GySw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780203677; x=1780808477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqgOgNRdeGO3Yt8rRsoJuC9RkIgPZyiihaZvjuvwF3w=;
        b=LXQNiSJ86kR81WV6oyKULiljtIGsc7IeXvyZsl14FsKTwYCA+J7IS1UcbMUZYx03Oj
         ZmYQmg6tv4d/xkaHoOvxXBSA+KLgEPCTHwmPu3/5G/DdP9Uer3AxZ5O7LmxkqFvLJ/xR
         mxthuBXkKU/S9VXVixjR3duSYAmmKHWtgJt41ojSFGZlPg2Ht1nQBfSeWzmovPAdgeNH
         vlLFtg7hdm0fiSCrQpkk6Pu0Ye4Up7pZkwLggoTRKRDm1QAh76xf5WAuXztusXWTK9++
         nTIYGT0ZMW8UXlzXSbEpN6waxHYPVwd5Qqb8IxwmbLnpTVXAgEPPiD6SsQ8A6iW0EkKt
         qTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780203677; x=1780808477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nqgOgNRdeGO3Yt8rRsoJuC9RkIgPZyiihaZvjuvwF3w=;
        b=Zpnzw3Qt6vetfSbFa9IqjzyFRxu8w6txJocQ5dNMPtJiTs/lNGdzC2igDTLVbs10OQ
         29RAhtPZozxujtxHsJgp+CBmsPv9t+DFst7n8I2n2pSqpzOybAU28AePuA7ZMjVNQMt2
         KWBlsM97Snoa0cAzWxtVWSHAdmsdhPj0p47sWUDizWljOE8FFaLhDAGwz7WQixLR2vFk
         iOxNB3talRS+ZLfX0F5su55Cq0MzJGPHgXLFFWZuAkQJtxE665FWLIBCyQcVEEZqxp0y
         hcGUSMYvvBz5Ig3JspAu2Sepf9vZQeTgRvd4xW/iksFZJHeufD/yNg4ZS9PUAG8DKyoF
         /gRQ==
X-Gm-Message-State: AOJu0Yy7UlgS1bvSi37QWfoJxCUDYvg7jxIbuVHjbBc/OD4RZZb3rs84
	CqYGc3OJ/pY3aLqqoQA1WAxPGO7/mWVRVgrIzSkDbLTwde5aMbjAX/fey8iv2q/HJeR4Al39zkF
	PiZeRty6Cq24l15wvz4MEWVFwi/BiqJtzSZrBTYYhnA==
X-Gm-Gg: Acq92OFhVKJFfgHe5Zs9PWgWJThjpkUD+cJBKESNgH9FHtnzz3UdwSKFj/yYrbDaJMx
	0vDx2MLtXzzi0n986xJhIFbR8MJdh0uhSk+GxV1LqWV72sncZzcstn+uLx3oc0CMrNu2RbLqbmo
	byBEfmCsWoc1uWL/LxBpGTeH5p2XXBizzgHbwr1JqiRs+laAJj4n8jJhnVcBZRMjhG24pEAKwuA
	zz2mE+5WgKkf7tGa3QLiW12SLCTZHvXojaaqqL+nXUf7/KeMAb70bKCJ7gpM7KNTb8Bc6FT9GYQ
	CNG+rjW1meX9pHdHZ42vkGCLdCQaur5VOOYkBadZ1Ee3nuN6Fg==
X-Received: by 2002:a05:6512:1413:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5aa62dfd973mr728016e87.2.1780203676357; Sat, 30 May 2026
 22:01:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530042630.80626-1-kerneljasonxing@gmail.com> <20260531042721.DBD4B1F00893@smtp.kernel.org>
In-Reply-To: <20260531042721.DBD4B1F00893@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 31 May 2026 13:00:38 +0800
X-Gm-Features: AVHnY4LqahcWtg1FhRj5ewX96RmJQ76PvHXyzLtz7MffAph-ztRPjQzAQCAHMGw
Message-ID: <CAL+tcoCgXG5MdPVzXavwMwk=jmPXgcB5aKpLK+TNXMVrsGmS9w@mail.gmail.com>
Subject: Re: [PATCH net v5] xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 12:27=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] The `struct xsk_tx_metadata` UAPI structure has an inconsistent =
memory layout between 32-bit and 64-bit architectures, breaking compat mode=
 due to implicit padding.
> - [High] Silent 16-bit integer overflow when calculating `skb->csum_start=
` leads to a negative checksum offset and out-of-bounds hardware DMA faults=
.
> --
>
> commit 8339ac65115fadb8d99c0e54d06d57fab30b5e84
> Author: Jason Xing <kerneljasonxing@gmail.com>
> Subject: xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metad=
ata()
>
> This commit addresses a TOCTOU vulnerability where userspace could modify
> csum_start and csum_offset between bounds validation and assignment. It f=
ixes
> this by using READ_ONCE() to cache the values into local variables, ensur=
ing
> that the same validated values are used for SKB assignment.
>
> Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kerne=
l.org/
> Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload suppo=
rt")
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 5e5786cd9af55..f8c8a8c9dfba5 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -811,13 +812,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, =
void *buffer,
> >               return -EINVAL;
> >
> >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > -             if (unlikely(meta->request.csum_start +
> > -                          meta->request.csum_offset +
> > +             csum_start =3D READ_ONCE(meta->request.csum_start);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but can the UAPI layout for
> xsk_tx_metadata cause issues for 32-bit userspace?
>
> include/uapi/linux/if_xdp.h:
> struct xsk_tx_metadata {
>         __u64 flags;
>
>         union {
>                 struct {
>                         /* XDP_TXMD_FLAGS_CHECKSUM */
>
>                         /* Offset from desc->addr where checksumming shou=
ld start. */
>                         __u16 csum_start;
>                         /* Offset from csum_start where checksum should b=
e stored. */
>                         __u16 csum_offset;
>
>                         /* XDP_TXMD_FLAGS_LAUNCH_TIME */
>                         /* Launch time in nanosecond against the PTP HW C=
lock */
>                         __u64 launch_time;
>                 } request;
>
> Because launch_time is an 8-byte type following two 2-byte types, on 64-b=
it
> architectures there will be 4 bytes of implicit padding inserted after
> csum_offset. On 32-bit architectures like x86, __u64 only requires 4-byte
> alignment, so there is no padding.
>
> Does this mean a 32-bit compat userspace will write launch_time to an off=
set
> 4 bytes earlier than where a 64-bit kernel will read it?
>
> > +             csum_offset =3D READ_ONCE(meta->request.csum_offset);
> > +
> > +             if (unlikely(csum_start + csum_offset +
> >                            sizeof(__sum16) > desc->len))
> >                       return -EINVAL;
> >
> > -             skb->csum_start =3D hr + meta->request.csum_start;
> > -             skb->csum_offset =3D meta->request.csum_offset;
> > +             skb->csum_start =3D hr + csum_start;
> > +             skb->csum_offset =3D csum_offset;
>
> [Severity: High]
> This is a pre-existing issue, but is it possible for skb->csum_start to s=
ilently
> overflow here?
>
> If desc->len is large (e.g. in unaligned_chunks mode or on platforms with
> >=3D 64KB PAGE_SIZE) and csum_start is near 65535, could hr + csum_start =
exceed
> the 16-bit skb->csum_start field?
>
> For example, if hr is 256 and csum_start is 65500, hr + csum_start is 657=
56
> which truncates to 220. Later, skb_checksum_start_offset(skb) calculates
> skb->csum_start - skb_headroom(skb) (e.g. 220 - 256 =3D -36).
>
> When hardware checksum offload is used, NIC drivers might use this negati=
ve
> offset to compute header lengths and shift it into the TX descriptor,
> potentially causing hardware DMA faults or PCIe completion timeouts.

They were brought up a few times before... The second one will be
fixed shortly after this patch, I said.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530042630.80=
626-1-kerneljasonxing@gmail.com?part=3D1
