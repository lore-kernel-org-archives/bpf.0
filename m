Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A5E217F27
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776302345; cv=pass; b=T7Eqa+6iJtAMpL3Fpvq7Oz92PEb9kL171PdSBh7+JB31mKrZEYckMuxK3YeZZ/HWPxT9XExaFCpXfMgEdTt7p2mhadPlXbE+YNAXRrI/45d1FAjc2Hozamyix/lXqOwpjlGmg1i5zXwn+Uw8wuN55b/mVsdfi3Tr+hjBfMSErqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776302345; c=relaxed/simple;
	bh=XCtJXo6oKu5qJcO35V9S1Ifbd7LnW/zGipwZFVwFPkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtGkJx4w4LBftCxWCK88YH5cRhQTX0KjL6FLHaSz9boXbsWBySL2XqkZtbljoBDWoskiCnDSERxr3mYzvwb8t+6pnIR/dzU6z6YYmXuYMHtEvXAYyS5vnBf3v2aJfUJpAKRx+/hTdyD8qWnQewU9A+XzGVoHFAhT3uqoZ0Wfkhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfedMLCG; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfedMLCG"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so7578096e87.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 18:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776302342; cv=none;
        d=google.com; s=arc-20240605;
        b=f/A2XZ/biUzUTn7swhU+2z40UxQ1sjIZiJII+OY+F+wZzRZg1IxTMnaOmIW4SRtJBW
         jXROdoLfshP0phfi7joyXk2zQWaQSgqIntur4jU/ERp9fqllG5hdbvwSollaRxnhtrnK
         jwomCmlXinTyyCGqRYfljM6RKCOxcb6REszJKnV7nRlnBU8RnmmL/d/hmf8eYZXIDW8L
         CvHDLEK6W0mhtprUhEAuvyzbAEg6PkgaA7OQ/6kcMbnu/fFVHDrYqZyW55zHYP/YD+5Q
         9dt3M3FJTdDh1N0ermN2GXF6RlS2SzreUb0yc3fOSyI4XY44Ro1bPwcK5K9RG7h6O2PD
         gWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZNhlsmlO+2dvKw7ULeWGa/3ZgJ/3xNp9y/uk0LituQ=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=GGtQhqDH33CUGtJCfvnjyR5txhJtcXa7P10abjeIprl8tgDty3B37YhDA+2tZVh+3m
         kF2HG/i+1hxUzmI2aeD2JcfwaFmubmEebkonTBoyMHRt5xokSTDCw4fYt7PcXDpda8AW
         pz9kp2/WIygnreGbjKjDLBoA56Hbp9p9X/e2LGpXtvg4JXT3Mk/BW1rSUI+GStVLHrME
         nTlDelZmvvDsDeByBkrwCe1wdQY7bVOtuO/AW0CMyI1cUkfj768KnS0QTtTSS2WECRsp
         qdUrer/QCSo79E5bJ4dhjWBygNKtWm4GaabWTDyaGtgOPnaIKF+Xa42fTu1Dx/8sBFm7
         N0UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776302342; x=1776907142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZNhlsmlO+2dvKw7ULeWGa/3ZgJ/3xNp9y/uk0LituQ=;
        b=rfedMLCGdSPAAoDpSqRsQoXR6S6NUlCdyk4y7fHEad/hra5O/MMZP0utTZwNvfwFb+
         TMibOGRMfgzAC+aOsGE+iPwREhj4qxffb+4ZsvICVUzFJ/905ThyrkeChmlCT5o3KhLI
         0J08p6/CPm2bwl+DDbOm+mx3nU7m030rLOlAerWAgJOiPQrnM9C3OvT4UIUmAESb3Cgl
         TIh4bFEK0RD6m/YhQOKrDNhF6H21kLLTYLFPdBv93bftRxeyxfkIU4TejUxpESHjnW1k
         VqfOJFryG2wJwpqaoLaClX2a7XCL1IfrjcfFc1YdXTddDScSO5Q4/uGz1ygGsTE1ebZn
         pNAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776302342; x=1776907142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jZNhlsmlO+2dvKw7ULeWGa/3ZgJ/3xNp9y/uk0LituQ=;
        b=XlbPsegHlA5YFYhV1dwkXHAFNaqW9k7R28B6+FQ+uwQEFsjDjUGDgeFUf/nntpf8eX
         14UCSF7oMWIgTxsk0xKqvz0Dr6IwtMINEgRRpQTDffOmj5zm8Bjhv/Pi6NR/SE5PJC39
         PKlococ7ty6EarToacnVW8YDJyNwY+xhshFqPxlGvVeD2gyJv9If20hQb3xc0IuaSze0
         n/3iObi9HukRI6N7QeGDAVnNNnoe8hxOuYgPOx6+bjPYgVDHHgirZ5EQRPekuKDSDWmk
         urZe7mVPVf3bNvkIeHNKGM0cSM5XfaDgn6mEC9AMa0tzHiHxsYMHJFwlzSVGFJF/RHqE
         vhvA==
X-Gm-Message-State: AOJu0Ywh9exyKhBLlSyFBwRTowZ7NAAPCI6CrmDXTkkviLAvYmlBhztD
	xJnh3nw60bMfbZBSiw7chQKis3V607KAFcVHHIlCNXtkpoupQ1iOxj/HCuMyTe2MLzPBGgMU+pe
	wvHCycPFoVQKvAtOb4CVewmxPK9yf9BMaS3uicKv0EA==
X-Gm-Gg: AeBDiesbu2l1FtWKjKRwqaod9OdaxODZuy0dBQyIsbccqE+djNNH/xo7BU5V5A67+KS
	yJe/TVX89jqsC/rf0WkbU1Ig+JmGvxd/6FMTQOdgdULAeZ4gWb+eSCXFCsnu+S72fKFJmGFeGHm
	+COTmmABKim6FDl72M/QffIIaaimVK0sG5s3Ngn3XfV7I1HSg0OJ/4GpBlH/PUNiIvflbmTJ4JG
	F9T5S6WGiYGcaws+2NzCekOG8vd8JOqDHdlRqyHMnH+z52b87X9yNkhpRoZWTXaORbBZw71Wx0X
	vGIBtSFfmjP17U9ZkKMURJNXK4p9
X-Received: by 2002:a05:6512:3a90:b0:5a2:b903:3b43 with SMTP id
 2adb3069b0e04-5a3efb2c5a2mr9974360e87.7.1776302341381; Wed, 15 Apr 2026
 18:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415082654.21026-4-kerneljasonxing@gmail.com> <20260415091743.97FA1C19424@smtp.kernel.org>
In-Reply-To: <20260415091743.97FA1C19424@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Apr 2026 09:18:23 +0800
X-Gm-Features: AQROBzDY8Xm2_8Cu4ecozfQPST7XLRuJGrF9Z76mRu-0wA7GQDyWPFtrQn7sF58
Message-ID: <CAL+tcoD9g4M9iv+oLzSzPs1pcyQDe+R9wnHvn-DfnuZVysxbSQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next v4 03/14] xsk: add xsk_alloc_batch_skb() to
 build skbs in batch
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 5:17=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 2 potential issue(s):
> - [High] Pre-allocated SKB and socket memory charge (`sk_wmem_alloc`) are=
 permanently leaked when zerocopy metadata processing fails.
> - [High] Double-free and Use-After-Free of `xs->skb` when fragment alloca=
tion fails with `-EAGAIN` in copy mode.
> --
>
> commit 3ef2c03b6204759327ab337fe34617d9dd8e04ef
> Author: Jason Xing <kernelxing@tencent.com>
>
> xsk: add xsk_alloc_batch_skb() to build skbs in batch
>
> This commit introduces xsk_alloc_batch_skb() to support allocating and
> building skbs in batch. It reserves skbs, batches the sk_wmem_alloc charg=
e,
> and then copies data to complete initialization.
>
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
>
> [ ... ]
>
> > +     /* Phase 3: Build SKBs with packet data */
> > +     for (j =3D 0; j < alloc_descs; j++) {
> > +             if (!xs->skb) {
> > +                     skb =3D skbs[skb_count - 1 - k];
> > +                     k++;
> > +             }
> > +
> > +             skb =3D xsk_build_skb(xs, skb, &descs[j]);
> > +             if (IS_ERR(skb)) {
> > +                     *err =3D PTR_ERR(skb);
> > +                     break;
> > +             }
>
> Can this lead to a double-free and use-after-free of xs->skb if a fragmen=
t
> allocation fails?
>
> If xsk_build_skb() fails to allocate a page for a subsequent fragment in =
copy
> mode, it frees the partially built skb and returns -EAGAIN. However, it
> leaves xs->skb pointing to this freed memory.
>
> When this loop breaks and returns -EAGAIN up the call chain, the caller
> __xsk_generic_xmit_batch() checks xs->skb and calls xsk_drop_skb(xs->skb)=
,
> which would double-free the skb. Furthermore, any subsequent transmission=
s
> could dereference the dangling pointer. Should xs->skb be explicitly clea=
red
> when handling this error?

Ah, great job! Sashiko again found a real pre-existing bug! I will
include it in my separate fixes.

The corresponding fix would be adding a more strict check in
xsk_build_skb() to exclude the case and let the caller to free it:
free_err:
        if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
                kfree_skb(skb);

>
> > +
> > +             if (xp_mb_desc(&descs[j])) {
> > +                     xs->skb =3D skb;
> > +                     continue;
> > +             }
> > +
> > +             xs->skb =3D NULL;
> > +             __skb_queue_tail(&batch->send_queue, skb);
> > +     }
> > +
> > +     /* Phase 4: Reclaim unused allocated SKBs */
> > +     while (k < i)
> > +             kfree_skb(skbs[skb_count - 1 - k++]);
>
> Does this permanently leak the pre-allocated skb and its socket memory ch=
arge
> if xsk_build_skb() fails?
>
> When xsk_build_skb() encounters an error like a zerocopy metadata process=
ing
> failure, it returns an ERR_PTR() without freeing the skb. Because k was
> already incremented before the xsk_build_skb() call, the Phase 4 loop sta=
rts
> reclaiming at the next skb.
>
> The failed skb at index k - 1 is bypassed. Since it is never freed,
> sock_wfree is skipped, leaking both the skb and the batched sk_wmem_alloc
> charge.

This is the pre-existing bug that you pointed out in patch 2. I'll
take care of it for sure.

Thanks,
Jason

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260415082654.21=
026-1-kerneljasonxing@gmail.com?part=3D3
