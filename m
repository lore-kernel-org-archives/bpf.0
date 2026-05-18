Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FCD3E51DF
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095225; cv=pass; b=OuZDxvvV9oSpyRZyu4L25qzI5qW6XnWuw44p+WBxfRpmb6anNfhxsvHwg5OR+6WyerPj+WJPw1huChsAGFK2NbkYG3fO14fjP/Z28bWLLjXyjM4QlHXPYz75sdc8lW1OWRW1cUQxnkbihG6v5EXfSygiU5CnNLjlbpLOGYZElFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095225; c=relaxed/simple;
	bh=9DM4qFj/buo+UBPSULdadhr2vBlrJYfk5WdGNzc/i6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvmeB6nPRX3UBN20eN/AgQdShnAB0ei5UqAlv2lF4wbgPZQpeEsczVpq+C43g7dV1PZVc4kDn27QLQxkbxOldHJ2BK8bnJPCPSW1YeV3pXykxC0jzPrVIITAEMQJwzTiGEMmUg6NfFfl0xwkFo1LGnvgiw8rg7ib8dXLG27fzjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaezeYyl; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaezeYyl"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so3544285e87.3
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779095222; cv=none;
        d=google.com; s=arc-20240605;
        b=KTpkUPdyRy2rJ8yf423DtMCUVa4hHinduXGyRTbtP63AWUu//UJadagb6BorSalTMb
         REFHiTC2sMhYgOk2j/szf9j6k6p77sSkU2HYngiEAfWj6Jd/3ieXyQrD7k32pzGtCAHS
         F7cETNgwzNraw3BLSGTV5GpcMamKsoK1Sv7wA8lp8hcpvOodBFYczdv73wGV1KTUHOI8
         WEG0W89qTXn2MOVjRuPMGSNaOTnIb6i+4Uv8YszdObhevQh7hONEVipxj7mCgq7BT/N4
         VpI5JFx3w3z/W86ex8I3Kao+wz01Q1IK6kj0gi5hDjrbQznCTqsPUB+04509Cfse35eC
         pB4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TmMV+o90q+i4tF81/qjwEZD+GrK37jZ87CMwSL7czsQ=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=M0vW/+PbE9DAzQKDjq8FTSEb2A26CoW6EMv7qgSmr1WZdW0qnQZM09rhVkAqr4aZcG
         nWOH6+ZuZWQJlLpUYegizcIU9exkrJgaCbyxVOwLWXM2TgcdANpqdqeiJXeUjv6tNvzy
         CHdJGqXoLFN41lQKASaK9QoZ3jyMlHhZcdwX3RgBfDEUmqmwyWo8bHoWRq5/rH2H8Z4n
         Dfm8XHQH6LLSHY/bv3ReiU2JuEKVhqeI0cEuIn0u0k9VcOPnCXDVRnbiZ1f1L/wotYp0
         nGxO93rZWDKX6d0BENnmAHRL2lAeXYjRfjIfvVDAu0oF1EepaB14bCSQwbY2EOltVXJL
         groQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779095222; x=1779700022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmMV+o90q+i4tF81/qjwEZD+GrK37jZ87CMwSL7czsQ=;
        b=NaezeYylLjOpjrp+1fTjPWRl/sflsFN4CiR1Gi3L8pgISxuVjSRaMx6IEk4UYCtI/o
         iZRYIGRv0Yr3uFcMEDxn4SrP56/oVAw3qxQU7h84lVLlvxk80VYfiQ1NTrHkj9CQbJrn
         uHBYRC1SQ5uB5mrnXyePVdtZkcwxuUyKEvs4+OSj/mUXQPTdRPsdo5LpAGdYpUqtBuRL
         CQ+zFn1VUPPytRPPKro0LMyerB07A93MONICu8qoZcPUIcxTDEk4QjE6d3q9JZ/g0WCo
         V7YBlJ+Ti/wO44d7L43oT56ELXoCAkwJ3hyi6nzF3bVhPQTVrMyLvU5BfksCIenqrcpl
         HJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095222; x=1779700022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmMV+o90q+i4tF81/qjwEZD+GrK37jZ87CMwSL7czsQ=;
        b=P0gFI1wgmG3lsu9SokMf5/TdK9uMgDo4rsHDEJgBUOXrBd4xPQetbtCyewXkrpAHnB
         GwIxYiv7bdDEP1cZIMLawD5nSC+9s4dZyzuQU8l68Sl3RzfPVtXU4wyVc7QRCoTJzZKX
         SkOxlfXbOL0KtKaNY2/mQZYFHSf+e1WyjfIPkcqYs6z0F6NAp425rbBXNVoIhFNoAlMS
         hgVLOJNmbV8vJeQ4y6GM+IA8MZZjFjO+a7GBKJNQ47ehpKqdp4aesLIg1W9npnwDI0DN
         0PS6tlKDPlTd0Q7IeH+MmhNoSkuklSV+OgKhQSumGbpfXzkfueGc+uff50uh3fSisIkL
         Wlfw==
X-Gm-Message-State: AOJu0YyW/1c0uiZRAwsopHJCjmqGrN9vmyGiAARmerHrBuK1j+/VleNd
	0u8OtiQfxCl6Q506nOmi+VxJ9F2IGPpoGRATGkQEeGByF+lgeUp9Rkn6sN/NUQaSZhZZoohesC6
	w0n87fVMLkUfKr1NAfYH0oS8jYj0BJQ4=
X-Gm-Gg: Acq92OF+C8+529/KNfrRoF579j4Y1FmJK2MsBWcOc29z8z9o9CVoESF5SO0u9OaF1Sl
	NN5EwVj6tfHY1vAW6F0n2fuWZjJmULniA5LpdbebmDtg7gtdZxs2+yEZxnmOpcM6/w/35pYXCx8
	qa/cdBTGcLpmtIjRNxv1xvVPQl2ZnKCta7BVlrT3Xq3JCIR2FwRxhRnAJ9vwY43ax4UMB+v5bty
	+w5wKYwX7u4OyDS9FFpxJSajXYzTaZyW3QcwLEG62CUQQTl3s0OzRW373/4xRHpdiBmTmOkvVwG
	dYk9bKuFsMIJ9/wyuXDLhlR8Ym6AP5uhoOEWcrzW
X-Received: by 2002:a05:6512:1053:b0:5a8:99c8:94b7 with SMTP id
 2adb3069b0e04-5aa0e616b94mr4663489e87.18.1779095221568; Mon, 18 May 2026
 02:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517063311.28921-2-kerneljasonxing@gmail.com> <20260518063407.C3B99C2BCB7@smtp.kernel.org>
In-Reply-To: <20260518063407.C3B99C2BCB7@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 18 May 2026 17:06:23 +0800
X-Gm-Features: AVHnY4LKrw0qFtbHGKqfXcu-V7tP9AzJn4y6fuq2eTHGnnu_X0lVCJt5SRs-J-k
Message-ID: <CAL+tcoCp19F2rNxYL_LoGsY5MuBZ6cGKSZsj6D7kvQZcYp0wJg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/5] xsk: cache csum_start/csum_offset to fix
 TOCTOU in xsk_skb_metadata()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:34=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Critical] The `skb->csum_start` assignment in `xsk_skb_metadata` can s=
ilently wrap around 16 bits on architectures with large page sizes (e.g., 6=
4KB), leading to negative checksum offsets and hardware descriptor corrupti=
on.
> - [High] Software checksum fallback (`skb_checksum_help`) in `xsk_build_s=
kb_zerocopy()` operates on an empty linear SKB, unconditionally failing and=
 dropping packets.
> - [High] Returning `-EINVAL` from `xsk_skb_metadata` permanently wedges t=
he AF_XDP TX queue, causing a local Denial of Service.
> --
>
> commit a101fbe76c494016d6edebf7d5d5e0dc173c0af5
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_metadata()
>
> The TX metadata area resides in the UMEM buffer which is memory-mapped
> and concurrently writable by userspace. In xsk_skb_metadata(),
> csum_start and csum_offset are read from shared memory for bounds
> validation, then read again for skb assignment. This commit fixes a TOCTO=
U
> race by reading these values into local variables once.
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
> > +             csum_offset =3D READ_ONCE(meta->request.csum_offset);
> > +
> > +             if (unlikely(csum_start + csum_offset +
> >                            sizeof(__sum16) > desc->len))
> >                       return -EINVAL;
>
> Does returning -EINVAL here wedge the AF_XDP TX queue?
>
> If xsk_skb_metadata() rejects invalid metadata and returns -EINVAL,
> xsk_build_skb() appears to propagate this error without advancing the
> consumer pointer via xskq_cons_release(xs->tx).
>
> When __xsk_generic_xmit() receives the -EINVAL error, it bypasses
> the post-loop cleanup and the invalid descriptor is never consumed.
>
> Could this put the socket into an infinite loop on subsequent sendmsg() c=
alls?

I should state that the first two bugs are valid and pre-existing, so
no action needs to be performed in this series.

Yes, it will cause xsk to get stuck in the send syscall infinitely. I
think -EINVAL should be dealt with the same method as -EOVERFLOW:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..c6cf2434a7c9 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1010,6 +1010,10 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock=
 *xs,
                        xs->tx->invalid_descs++;
                }
                xskq_cons_release(xs->tx);
+       } else if (err =3D=3D -EINVAL) {
+               xsk_cq_cancel_locked(xs->pool, 1);
+               xs->tx->invalid_descs++;
+               xskq_cons_release(xs->tx);
        } else {
                /* Let application retry */
                xsk_cq_cancel_locked(xs->pool, 1);
@@ -1059,7 +1063,7 @@ static int __xsk_generic_xmit(struct sock *sk)
                skb =3D xsk_build_skb(xs, &desc);
                if (IS_ERR(skb)) {
                        err =3D PTR_ERR(skb);
-                       if (err !=3D -EOVERFLOW)
+                       if (err !=3D -EOVERFLOW && err !=3D -EINVAL)
                                goto out;
                        err =3D 0;
                        continue;

>
> > -             skb->csum_start =3D hr + meta->request.csum_start;
> > -             skb->csum_offset =3D meta->request.csum_offset;
> > +             skb->csum_start =3D hr + csum_start;
> > +             skb->csum_offset =3D csum_offset;
>
> Could this addition overflow skb->csum_start on architectures with large =
page
> sizes?
>
> Since desc->len can be up to PAGE_SIZE (e.g., 65536 bytes on ARM64 or
> PowerPC), csum_start could be as large as 65534. Adding the driver headro=
om
> (hr) could cause the sum to exceed 65535, truncating when assigned to the
> 16-bit skb->csum_start field.
>
> When the driver later computes skb_checksum_start_offset(skb), could this
> result in a negative integer and cause out-of-bounds offsets to be progra=
mmed
> into the hardware?

Ack, it should be checked in advance like this:
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 5e5786cd9af5..1fd7a70e5d38 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -816,6 +816,9 @@ static int xsk_skb_metadata(struct sk_buff *skb,
void *buffer,
                             sizeof(__sum16) > desc->len))
                        return -EINVAL;

+               if (unlikely((u32)hr + csum_start > U16_MAX))
+                       return -EINVAL;
+
                skb->csum_start =3D hr + meta->request.csum_start;
                skb->csum_offset =3D meta->request.csum_offset;
                skb->ip_summed =3D CHECKSUM_PARTIAL;

>
> >               skb->ip_summed =3D CHECKSUM_PARTIAL;
> >
> >               if (unlikely(pool->tx_sw_csum)) {
> >                       int err;
> >
> >                       err =3D skb_checksum_help(skb);
> >                       if (err)
> >                               return err;
> >               }
>
> Does skb_checksum_help() unconditionally fail here for zero-copy AF_XDP
> sockets?
>
> xsk_build_skb_zerocopy() creates a non-linear SKB where data is stored in
> fragments, meaning skb_headlen(skb) is 0.
>
> Inside skb_checksum_help(), it checks if the offset is greater than or eq=
ual
> to skb_headlen(skb). Since skb_headlen() is 0, this check always evaluate=
s
> to true, triggering a WARN_ONCE and returning -EINVAL.
>
> Could this cause all checksummed packets to be dropped when hardware offl=
oad
> is unsupported and pool->tx_sw_csum is true?

I don't think we need to move the check ahead as warn_once is simply enough=
...

Thanks,
Jason
