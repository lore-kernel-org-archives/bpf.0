Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76A3BC695
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776514; cv=pass; b=JavSo8Pf2FgMCW2l2fE06kq8bTUOH5+2bIToGpvj5qO03hI+KSQTeQs51LOYzOogYG6GZ3xEflzolhYahYBdAjAIVWLaxnFwLvVKrgsBh8VNjsmk4mgeEmh681Vqi+st9JPU6FmWxe2gKij5BCS0+J6WbFqK+7K5Dlv6lq+NZWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776514; c=relaxed/simple;
	bh=GaHJWlX9w3tg5UyScKN1/yNMH01yHW+l6j4ppLF6A8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5jupXs7IpZj3YTcs2qGM0ovlcgqHfk1tc4KTNib126+TSClq7eN2sDfEHcRHKBN/jiwJXHTfxYz1VYNjD9+2CSj4fT/guuig31VOEE/lCJt+RrbF0mrlZRFu2a65Kb4TkBwlAhfiZHBYfhVXTh1n3xRX1iucktttMg2ushshUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lh/VPxqe; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh/VPxqe"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a402b2d102so4898919e87.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 06:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776776511; cv=none;
        d=google.com; s=arc-20240605;
        b=fZE2dLW6BRkCBRZwcOT56KSiMOx3wrp9NeVgZbN1yaSBXJ5tQW9A9MfSj6pILXnnBV
         g5yt0d2YwkgAVbiMEQqDwe6dQB0w5CXQIJRbHSQADPpcxr4DhZ/pUsS3dVUWy67NwYOZ
         bPCxJnAgt34YalE10jLNPlfZ+UjkfBVkyiuB4suB/0tI/ocAp4guEd0jGHDWXIB6vLlm
         V6UUBtDPFzCQnDQC3P5ilS0kkyzasjpA9vzYJX16ffC0zMQ+N47gPTA9CQcbN0IyQVw2
         FYyymvaaqAT05qoULt6S7rAXHfkSZ9NJ0tevvR4/rEwMFR98LPpA+I82nMHP8jZZ7W67
         6hCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzSfaOp3OPbvUmyrJZzWnTnI3+fy8AsLaeuFNHP8ETw=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=MRXS6VOFmRzDLmDQwFCk0LuEGldle0HyMaJlV0vA4yMadcBq6beUcQ20U+LbM0jssv
         AYCWMpLxjwKFLcR7yXB3DQcK6+zIRURqkgQnrHpBONWeqAe0WUnogowkVRR1PF8NRI1r
         mm/de4dGqISgPs6Pbx1YtHWwo7kq6QEwwoOHagslpcXGFMvfhieKkPfJnaCHRrKvp6/L
         NVCQEA23B76w+PI7RojGUtAwserVysBnUP1PxNdyQCC5Z4ddzgZlD81rMOWQ6LlEyI7C
         fd+IxgIGYWHMVkpiBQh15+0VC8jScm35sn0QN6reL5vv52whVXKgvqh+0cX6aSc8HJ90
         5l9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776776511; x=1777381311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzSfaOp3OPbvUmyrJZzWnTnI3+fy8AsLaeuFNHP8ETw=;
        b=lh/VPxqerfVndzvXll3CdGNtpEPyGZ/g9Efi7cdJsT99FNlYmiDjlS6VvoeQVO1Le/
         tH04BLdecsjtxBt5UdPjlE5CbKbwhz+DH/x7VY3T5kfeRUbOAr3PtQSJ1hF0GOxDaU0k
         s7x2f6Oia852mRMExlrJC7yvBhrxSnIHqm46f0ojJmeAezkRS8qgngwZ+NYNPnsHjy0L
         k5SeEQG+bD+IwJeHBFcidiKGYlaprnBXcHoKr0eFigl7RqbiolSje+9XpwJAiUf/DQx8
         XogxykAaWkVhuinCK63Y7AxqXVMODq35I3Kt2Bb1c9NOU++yOANR7yphyFF8hRKgOzdw
         AM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776776511; x=1777381311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PzSfaOp3OPbvUmyrJZzWnTnI3+fy8AsLaeuFNHP8ETw=;
        b=rjyZtaSG7iBhDf0ckCNYDrW4RQPOhCbDS4ruMc9B4ac6cvuH2Yr1/iVE+Xonfv/Pqu
         duznulzfRUCYZIFGanu+g3X5t/T+8p7kECll2dyS+nqlgL3Pb6ZA5X2XUNTjM38+c9yH
         Wge4ybtM10B5Fr4467vOAgG/YKq1S1Mzf6Nlzh9l3psSusnTazobBRkhOQg3Yb8rfoa1
         Cyg2sz/LnmLYr6KO5y4PgKKHRmOkL8Yssw1i6mexikKyEFMBWlHz6UXeA33Yyukg/XJ2
         5UZtBleDYtF35pZydnBtGcUvC75309P7JYNUkNov7Xamml0rXovjnC+U+n+x5zSnRpy2
         EHyA==
X-Gm-Message-State: AOJu0Yw+rrDv/hIa3wzlgqVQnEjOKD2KHihLRC6RSdZ9Y4YXiO3Fl+pO
	J8/d6DURzUxfjpXpE5Bv6/5Oy+8VEvKCiGINk+EtjxGtLq6rmYLgr3FUWGnStCVFkmhXIXxPcB7
	0ilJqIrtK1BYCzoZFAtx6hGxETx7mV+wiATjN
X-Gm-Gg: AeBDietUwXMeFeY1LFXSmFHKqiTELIDtQBwmWs5s8Gy4OsFEzc/4KcN+1z7+SG7WfvK
	y/V7Fh7pbqLYdS7r7WiekTFSh+Cy7CUCwdMpsdVzia+0Y6HP2NXyth2mLMjb6YW4EE+mTtdeR+k
	Iw0cqOLreJqTQxhd1REWacp3DG1xEPqCHXZqMuNPpJ3poQrl8TKhq+lUamQzsB50KGuiCNIzf2k
	J0isJqqMK5DMjeZdB+dtswQUFKnpL+7Ip+IEYX2x9fmcQUWYMByYSkzJOVgpXo41KG4l0nYEYyT
	TzpD6J37kiuMk7SWcQ==
X-Received: by 2002:a05:6512:3b14:b0:5a3:cc81:eff3 with SMTP id
 2adb3069b0e04-5a4172de8bcmr7078744e87.26.1776776509571; Tue, 21 Apr 2026
 06:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-9-kerneljasonxing@gmail.com> <20260421094026.6543DC2BCB0@smtp.kernel.org>
In-Reply-To: <20260421094026.6543DC2BCB0@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 21:01:12 +0800
X-Gm-Features: AQROBzBxpLyVgyjRklod6h-NoILWg6y-B3K75HS_oiwFefqG5VLPxmKczA37GFA
Message-ID: <CAL+tcoBZw3jQYnuDJYciOtLmTNvwyJpNHwgo-=Rs47c155P1sg@mail.gmail.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 5:40=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [High] On 32-bit systems, xsk_drop_untrans_skb() will call kmem_cache_f=
ree() on an uninitialized destructor_arg pointer in early allocation failur=
e paths, causing slab corruption.
> --
>
> commit cf643670755512ad76d19d6d0707e86a2a05c671
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: fix u64 descriptor address truncation on 32-bit architectures
>
> This commit fixes a truncation issue of the 64-bit descriptor address
> on 32-bit architectures by allocating an xsk_addrs struct to store the
> full address instead of packing it into the destructor_arg pointer.
> It also updates the related cleanup and initialization functions to
> handle the newly allocated struct.
>
> Link: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.=
org/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 9c06a4e868725..0232559d5348f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> [ ... ]
> > @@ -799,6 +825,12 @@ static int xsk_skb_metadata(struct sk_buff *skb, v=
oid *buffer,
> >
> >  static void xsk_drop_untrans_skb(struct sk_buff *skb)
> >  {
> > +     if (!IS_ENABLED(CONFIG_64BIT) && !xsk_skb_destructor_is_addr(skb)=
) {
> > +             struct xsk_addrs *xsk_addr;
> > +
> > +             xsk_addr =3D (struct xsk_addrs *)skb_shinfo(skb)->destruc=
tor_arg;
> > +             kmem_cache_free(xsk_tx_generic_cache, xsk_addr);
> > +     }
>
> Could this pass an uninitialized pointer to kmem_cache_free() and cause s=
lab
> corruption?
>
> When a new socket buffer is allocated via sock_alloc_send_skb(), the
> networking core's __alloc_skb() function only zeroes the skb_shared_info
> struct up to the dataref field. The destructor_arg field resides after
> dataref and contains uninitialized garbage from the slab.
>
> If an error occurs before destructor_arg is explicitly initialized, such =
as
> when xsk_skb_init_misc() returns -ENOMEM:
>
> xsk_build_skb_zerocopy()
>     ...
>     skb =3D sock_alloc_send_skb(&xs->sk, hr, 1, &err);
>     ...
>     err =3D xsk_skb_init_misc(skb, xs, desc->addr);
>     if (unlikely(err)) {
>         xsk_drop_untrans_skb(skb);
>         return ERR_PTR(err);
>     }
>
> In xsk_drop_untrans_skb() on 32-bit systems, xsk_skb_destructor_is_addr(s=
kb)
> evaluates to !skb_shinfo(skb)->destructor_arg. Because destructor_arg
> contains non-zero garbage, the function returns false. The check in
> xsk_drop_untrans_skb() (!xsk_skb_destructor_is_addr(skb)) then succeeds,
> passing the garbage pointer to kmem_cache_free().

Yes, you're right. After I removed the untrans_skb code block as
suggested by Stan, the problem is gone :)

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420082805.14=
844-1-kerneljasonxing@gmail.com?part=3D8
