Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE11492182
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 19:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010241; cv=pass; b=mpUW7FU6Jdi40BW7IcYLAjmNp8sLJqzCZPJqOjr7QrF9xOtsgY8gyUN1MrgmFGVvGIsBnHQTlWOta4sJ5dy5q2lxmmZZ1mNp1FoX7rgznb7N7bjZGo83KiDumCv/32tLlVRJWOGaWq0/zeBtznZoK1TNrp0IBroZyWihRUH5/kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010241; c=relaxed/simple;
	bh=hlKPTcZBKLMUo0YHNqgYAkK/xTkVxPVfe2bRbG9SGjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgaI541IYfkzs2c9RMANkWU3DN9YDuQXsDndwnU195/HvyTNEslpFng925Jo42oLVZ0TLD/Pfphwgk6dPPt8GjE/aYvZjO+F0u2cynNxnPnmBzc7lkuX2CxKyz7RPPkeZw8FemQeE4Twv5ilBSuM3wMcCIdp3+FTMnLiGtwdfJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=buqXBdyQ; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buqXBdyQ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a877510541so2848384e87.2
        for <bpf@vger.kernel.org>; Tue, 05 May 2026 12:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778010238; cv=none;
        d=google.com; s=arc-20240605;
        b=LxKQfUhzWNnxcpAsxdiRys5H6I+VU5O2q2Ou6LeUvEdhKU4ppRVdND/NS7zWTTMtOl
         WqQaK0TAH1PIYknbao9xo/Gr1wJkNPKYRYQsrewjfawwaFGpx/AM0jHH4UDMCkUn77Ee
         uCBsFya8YNmWPuWm+g/622w8agANT/rijRuhqGi9OBXPhvrL1b4kXiRazAPSIikrIzjD
         krN7ZGfM0i6/lASM0zsxZuNkamL95fXt2VGhViTXlCoyAl2HOSqyh+LjRUlrGfuimpNR
         pxjlzwxdOHI0iA1RliV+Szt9ovjaY5wIZaj5PvAA9ch9MMxxC5w4/ETqi0AHvSHQUfpw
         8B8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLcZnduWjFr2QmT8zmnfKUhZKhkrNViMb2XdB8+qmDk=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=YNKzfZXpaD4pC9caWyYBL+7aCiB0lFoasqggL1BwiuZbQyLneMy3FqPhSm16yhg2iA
         +3KVpc8lZ16paWGAg0vHJnNHpR5TvVoy9LpiVZp6uOjb1Viot24bswedSh0UJVgmRHfn
         n0bHUxKKPMvUC3wRU+44SpJzfRf9K7Q1MolOm0HjW24OKa2KtaBXXmTojtprOWJ7n0W7
         bAJKNcM8EJcMcNAnTCpt05E20ev1XbdqpBG8lEbvnCt5y6QVOwoEklnZ4FVkm9BGWsIF
         ve56AJnsba0Aw8x/mK14iRPqnm1IRyadgfutdmvwvxQIGHO5CZwac5w/sAVdt8ehAaxm
         Usfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778010238; x=1778615038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLcZnduWjFr2QmT8zmnfKUhZKhkrNViMb2XdB8+qmDk=;
        b=buqXBdyQO31U7PP4LOnLKnVltlCfMN9w5UBAuOliROnl34AzovYu54ZXraKfcNd11p
         xtspdOzwxvwXDCQgY9vWMAtQQCFhdUh3aOESHrVzwPq7mgkj9FPgjMzIcGjPsUNhq0Sq
         Mu8vl5+MXMfJCVgycFC4zjbNLC+h8YjHyWAsIAFWU+lZGIg5yO/MSuD7Eg9P5vNPc5O1
         7bRXko3ywojV+1rHENC+1Z3DVnumM9YvMewdngryRuCsZl9ag49HvfOOggPbqtxg1hzw
         z6wlGazgHBF2uGCK3er7X8RlcaMMJ9JiQUYPRCddDtzCj4rogE2TDMXyfBQCgCImyWbg
         6lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010238; x=1778615038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLcZnduWjFr2QmT8zmnfKUhZKhkrNViMb2XdB8+qmDk=;
        b=A06Z/vcFHcQVVvKQS8iwCGRj9McmUvooFGG2XbCDvCN3AkftAZHkbzjkWxFJMb8IWC
         E4O/Jgxht3xqO7eKJZ/QEVerXxNMQ7eOYm/74f4gZ5skdSHlxEoO/qdPq4qVZ7l8X9fs
         7a+co9jKteg8GtkbQpkWsH4+tHnV6unAtnokG1KiKvrj4DM86MOq2hcTa1o7I8Z6oRVv
         T8Ekn+4Fs195CGBUNOEcpttvat/W2ieh4GtGXc6soShB4trcKTr7onIkTlqc02nKkzlk
         NshhnrDxjRWowsqwUIZGdBYDca2W+uLBR8V22QkhNu75aZMIW3TB+pi9LnM9xI1VN7fg
         F8QA==
X-Gm-Message-State: AOJu0YxqqTo6pI9M7w3Q3HXDY+ZbgciyCUBLso8PeCC4Tnmip1WdSSLN
	aenMCj7Vza/TFeoZUVuL2RidRHkMBMp1Cjs7qQHnLcaGf7syhotO8NfhV49+C6nnSJMgx341+T1
	JsY+kLaFPumGUPxmaizbIQkRgJL92IpWtqNbTNnQHZQ==
X-Gm-Gg: AeBDies5dmCRjXnEvU9yV2WN+DKCyoTTcGAyh8abK8Hgfs5LwCRow33dOst5igBCesM
	Qj9glhvobcb0jNoXYhoW4UsGL5ui+jsbDr6q5EKmDcbTLelSvJ93i5Q7xgHpUehNE6tapuDi5lk
	Cnlv5CmwW2Z+kF80Y8JSGfCl/SovY50tI04+g7Bdcm1P2zUgYMiKE5oz5ExpVXnTAFoFoG9DPhr
	oheGlLut8fsgQdOcbhvFGMCP5/tXdZv6S1Ff6oYYo4OxAG5Yz88LKTDzfv0HWyk/kwirZuL+qM9
	Ujq3zv02jeEv4X3nDeCLawOBsbNP9qFvKe1YhekwjldbeCUw
X-Received: by 2002:a05:6512:692:b0:5a8:707f:904 with SMTP id
 2adb3069b0e04-5a887a9a8abmr65729e87.0.1778010238183; Tue, 05 May 2026
 12:43:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502200722.53960-7-kerneljasonxing@gmail.com> <20260503200927.73EA1C2BCB4@smtp.kernel.org>
In-Reply-To: <20260503200927.73EA1C2BCB4@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 5 May 2026 22:43:19 +0300
X-Gm-Features: AVHnY4Lv01cINAhIEEIe6wZATxILLiiSJz-Rsic27z6kKIapgvXwSyYVKlAQsZ8
Message-ID: <CAL+tcoA01z+L6fQdN-JXk8u+jC7=2qerMEFUD3AF4QdPXVG48g@mail.gmail.com>
Subject: Re: [PATCH net v5 6/8] xsk: avoid skb leak in XDP_TX_METADATA case
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 11:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Critical] Time-of-Check to Time-of-Use (TOCTOU) vulnerability on share=
d UMEM metadata allows bypassing checksum bounds validation.
> - [High] Leaked `xsk_addrs` structure in the non-zerocopy `xsk_build_skb(=
)` error path when page allocation fails.
> --
>
> commit f1079e9399771f267ff5b6767db05016e5ee4840
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: avoid skb leak in XDP_TX_METADATA case
>
> This commit fixes an skb leak in the XDP_TX_METADATA case by explicitly a=
dding
> kfree_skb() before returning back to its caller. The issue happens when
> xsk_skb_metadata() returns an error, leading the caller to clear the skb
> without freeing it.
>
> Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kerne=
l.org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index af3c5752bb63..770ba4695a9d 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -821,8 +821,10 @@ static struct sk_buff *xsk_build_skb_zerocopy(stru=
ct xdp_sock *xs,
> >               skb_reserve(skb, hr);
> >               if (desc->options & XDP_TX_METADATA) {
> >                       err =3D xsk_skb_metadata(skb, buffer, desc, pool,=
 hr);
>
> This wasn't introduced by this patch, but is it possible for a shared UME=
M
> metadata TOCTOU race to bypass the checksum bounds validation?
>
> In xsk_skb_metadata(), meta points to the metadata area within the umem b=
uffer
> (buffer - pool->tx_metadata_len), which is memory-mapped and concurrently
> writable by userspace. The function performs a bounds check:
>
>     if (unlikely(meta->request.csum_start +
>                  meta->request.csum_offset +
>                  sizeof(__sum16) > desc->len))
>         return -EINVAL;
>
> If this passes, it re-reads the values directly from the shared memory:
>
>     skb->csum_start =3D hr + meta->request.csum_start;
>     skb->csum_offset =3D meta->request.csum_offset;
>
> Could a malicious user application race to overwrite these values with
> arbitrarily large 16-bit integers between the validation check and the
> assignment, leading to out-of-bounds DMA accesses? Might we need to copy
> the metadata to a local variable (e.g., using READ_ONCE()) before validat=
ion?
>
> > -                     if (unlikely(err))
> > +                     if (unlikely(err)) {
> > +                             kfree_skb(skb);
> >                               return ERR_PTR(err);
> > +                     }
> >               }
> >       } else {
> >               struct xsk_addrs *xsk_addr;
>
> This wasn't introduced by this patch, but does the non-zerocopy
> xsk_build_skb() leak the xsk_addrs structure on its error path?

This issue will be fixed by a standalone patch then :)

>
> When appending a fragment to an existing SKB (!skb is false) in
> xsk_build_skb(), the code converts the destructor_arg from a direct addre=
ss
> to an allocated xsk_addrs structure and initializes xsk_addr->num_descs =
=3D 1.
>
> If the subsequent alloc_page() fails, it jumps to free_err and returns
> -EAGAIN, leaving the partially built SKB in xs->skb without incrementing
> num_descs.
>
> When the socket is closed or the SKB is subsequently dropped via
> xsk_drop_skb(), xsk_consume_skb() is called. Because destructor_arg is no=
w a
> valid pointer, it fetches num_descs as 1. The cleanup logic relies on:
>
>     if (unlikely(num_descs > 1))
>
> to free the xsk_addrs structure. Since num_descs is exactly 1, does it sk=
ip
> the free, permanently leaking the xsk_tx_generic_cache object?
>
> I saw this issue is addressed later in the patch series (xsk: fix xsk_add=
rs
> slab leak on multi-buffer error path).

Yep, it is handled by the patch you said.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260502200722.53=
960-1-kerneljasonxing@gmail.com?part=3D6
