Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFF41917CD
	for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608641; cv=pass; b=FUzs04wOY+0UzUM9NYZP9mGjHLZhso/CWGnw6y57nt5uFcQTKOnP5VLS+pFVQfkDZoOCVOufCXlMhGDC6XJkYnN4Qmz7yyLU5FRoErCRcS5BSV9etbctHLekAvKJcBu2TMPiEGprtkaUmh4GndCbIqcpExyz6FpPXT124EX7mUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608641; c=relaxed/simple;
	bh=5vWDgxO2UffpKS7zIH+0K8t5jTehWEnK5R86hF2Ikr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSpxObH0DMiLtB1bV4W+AHatr5Ncw279+OTmIZVB4wvFCzKQqtHewwPq6pFnIYGcDd/oxcsWrmLencrhaHIt4QGkFpJZ3Y05JmMVP1GymUYpwsxRR4lk0INBqGweeV+mqpUUzChc9QqqwvBVrn12vGgFhV+XsH5UEt699eLLsT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAsyr3GF; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAsyr3GF"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a40b2d268bso1771608e87.3
        for <bpf@vger.kernel.org>; Sun, 19 Apr 2026 07:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776608638; cv=none;
        d=google.com; s=arc-20240605;
        b=exDnTuVvtDRuWJD2kthHqT03n3Zm5XMVRQo1ME1GPcx+6jYOjNRx1ZFdDmFLGquN72
         il5dfPk6KFMjvh/n4lHXMtwLTczrg9VxDHEt5AFZ58cNsDnOO3JVyWXcbFL26q1Ts6WD
         fnscEFvakvrkSsUxneq1IBBYVKm1I92af8tqWj/Pkd3osDPfI9rZhMvUr9NHEV6X4WIy
         lJWdrkFabql4TdYOWMz9CGED3UMW3V+WtV9bKHpt2QNoANVOp85P4bt5fsG44NyYxF2t
         VO1rgITiDH1lGfgsu9ro9GtdjaKkG9vuA4GcSH3VIvReTfmjJ/XHX+mrJVnOfEX+FUOC
         tXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eDyWThTcQJX4agFw15Ew3AfKnI9O2+hPJiJ8JlGIJTw=;
        fh=7pQPbM1mTaKjUbZ75iTISJbipA72wUVZwkXXTYMxzFw=;
        b=avBdI2SxA/0Me+WlcZoVSUfBGqJDbNiLORNrWlBe5bv1S/uPvVztr4tSmK2lVK2fnF
         bk+dKg8Gy7UpJPYthyrALUmKmyfrrHHyemDbCKdpIm8l4hepyePoHXAUP/pMNPzdjLNF
         qiwU+PiipBTbGA/DVAVsjdetPM+j4ZLxxiPlcgLPILP/zTkmeGViBbNF+wBqTuYCBFhJ
         wYHTIb3hJWN5fDd/V0PCpCclnu8kHZhUqSf5YLT8MSwu9QUeKRBl8+G+zGgSyGzAKBWQ
         Zf0PHCIjfhOAveTH7e7dx084WuvaI2sFpPHK/WEJCLTsrgrii1wco+LDw7ZTy4pklKr9
         TLOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776608638; x=1777213438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDyWThTcQJX4agFw15Ew3AfKnI9O2+hPJiJ8JlGIJTw=;
        b=JAsyr3GFfqOoGh2Aj21PS0HJJpcxVOBR02TITRmhpbaBeNksStKX+CXMJhsS4sOp6i
         u3LWSBoc4VFP29F81PILEr3NA1IVGoXJRvRRDolEGKj+Oe5Olnr/jfS+9C8T5Y3k4+29
         pow2zsH1qTJyXVkXWnviYQbil4lxl5mKIwboErcihwdhzZeRpGl1l5qSDvs6I++M9Api
         JklwD1ekb7yCsrvnCeUtTMK842o+UxYwyD/vGjY2W8o/ApshdYsR8DLykvz76pyIaurI
         JyZeRopfdr5lzJO8fdzM9KGNWSFy9grPefqIjj0GpJGJa8gsN3lJh39c7Iw+3TcI3qfG
         /ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776608638; x=1777213438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eDyWThTcQJX4agFw15Ew3AfKnI9O2+hPJiJ8JlGIJTw=;
        b=YpnJkk6dC21jVD/lGKJGktMQKTGuHyoFi+in4Eg1jNLwMyVkhqTM+ZQLCtEylNtFQp
         cQCgkjQiBGkS//fQVV1laFpZyLlvsjA1H9JUvb5ASK18cP4UBPWdzSXemFYC7Vq/6ffj
         Y6iTjv1xS37X72RfsalH4GEjrh2aghQkH0UW1jjDGhgAjWKoTGAAvTZoeyCgzaM3Evly
         qAQj82kWDO/9XrgjlawZ7VFCVmjtQOpw+zEvbpnmlTdx5MBGy/6qSf7eE7P0LoXrNW0s
         OY49RJ39byLGK2XthUIfmH+gg6iRVjqpvKEwV76wzwYY1ZRDRHJYuXHgWetTglUGSofE
         yfkA==
X-Gm-Message-State: AOJu0YyeiP5Pbd7KACGj2mSc2lbCwHZ/gUHQNXomCUqr2A5LU4oqcS3H
	xewDhykkN/9ZcHW7ZH7LDn1Vf11MA0kgU5QS8gvtpA6A4OycuyxQ1xnljSShgdlvoW2rVJHwtL+
	au4GFUK9M/oVyisefhxlPfUNfYqBeDcQ=
X-Gm-Gg: AeBDiescQsrTTgABYzVEWdrxH3YR1O8aEUD0d4N+ddxz0uJYOvI5RyG5ahu+p39PWQ7
	HfOyEIe8HIwUohlvT8pK6I+ePvlhagYW9jnIgK+EYu9OqOirg4r0Xt1mPuMqYtJQgOVl1ChOnhF
	bi5umsrgi9SqxU1Wg0Mp/ierGS/PMrDBFDAGik/F2/lePno3uZ36jVTodqYS1Er7+dLlFUnPD3Y
	n1qQMOuF8hcZLEDUIEXyw88uHe9kVfjQY2iJelOObskdbncOD17EE5tvF5Pn/j7uxo/eOce07sM
	A+dE8fx/6zjkunodmg==
X-Received: by 2002:a05:6512:33c8:b0:5a4:2b2:75e3 with SMTP id
 2adb3069b0e04-5a4172cd812mr2838260e87.18.1776608638160; Sun, 19 Apr 2026
 07:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-5-kerneljasonxing@gmail.com> <20260419045824.D9E5EC2BCAF@smtp.kernel.org>
In-Reply-To: <20260419045824.D9E5EC2BCAF@smtp.kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 19 Apr 2026 22:23:20 +0800
X-Gm-Features: AQROBzDKamq6XkjHwX1UKcPaOBGSgjCckPrWxlYvJMrYhvVx2Tr9Hbf7__1T1gM
Message-ID: <CAL+tcoCJ5LXR_mBhRfegN6-Oo7yNtf=akTcw13nfhLAfhVbHAg@mail.gmail.com>
Subject: Re: [PATCH net 4/4] xsk: fix use-after-free of xs->skb in
 xsk_build_skb() free_err path
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 3 potential issue(s):
> - [High] Calling `kfree_skb(skb)` in `free_err` after `xsk_skb_init_misc(=
)` triggers premature CQ submission and corrupts Queue invariants.
> - [High] Memory leak of `xsk_addr` when `alloc_page()` fails during multi=
-buffer packet processing.
> - [High] On 32-bit architectures, `xsk_skb_destructor_set_addr()` truncat=
es the 64-bit UMEM offset, corrupting the Completion Queue address.
> --
>
> commit e60e7fb34b1c59698d11da732db02bb3302ab41a
> Author: Jason Xing <kerneljasonxing@gmail.com>
>
> xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
>
> When xsk_build_skb() processes multi-buffer packets in copy mode, the
> first descriptor stores data into the skb linear area without adding any
> frags. If a continuation descriptor fails, the error path frees the skb
> while xs->skb still points to it. This patch adds a check to ensure we
> only free skbs that were freshly allocated in this call.
>
> Link: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@=
gmail.com/
>
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 2f00f188533c1..470f6d25ddb93 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -974,7 +974,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_soc=
k *xs,
> >       return skb;
> >
> >  free_err:
> > -     if (skb && !skb_shinfo(skb)->nr_frags)
> > +     if (skb && !xs->skb && !skb_shinfo(skb)->nr_frags)
> >               kfree_skb(skb);
>
> This isn't a regression introduced by this patch, but could calling
> kfree_skb() here trigger a premature completion queue submission?
>
> If xsk_skb_metadata() fails earlier in the function, the skb destructor
> is already set to xsk_destruct_skb by xsk_skb_init_misc().
>
> Freeing the skb here synchronously invokes xsk_destruct_skb(), which
> submits the completion to user space and increments the queue producer.
> The error path then executes xsk_cq_cancel_locked(), which decrements the
> cached producer.
>
> Will this permanently desync the completion queue invariants and report a
> successful completion for a failed transmission? Would it be safer to
> clear the skb destructor before freeing it?

Ack, the same discussion again.

>
> Also, is there a potential memory leak of the xsk_addr struct when
> alloc_page() fails during multi-buffer packet processing?
>
> When processing a continuation descriptor, an xsk_addr struct is
> dynamically allocated and stored in skb_shinfo(skb)->destructor_arg
> with num_descs set to 1. If the subsequent alloc_page() fails, the code
> jumps here to free_err and returns -EAGAIN, leaving the partial packet
> in xs->skb for a retry.
>
> If the socket is closed instead of retrying, xsk_drop_skb() is called on
> xs->skb, which calls xsk_consume_skb(). Inside xsk_consume_skb(), the
> cleanup logic uses this condition:
>
>     if (unlikely(num_descs > 1))
>
> Since num_descs is exactly 1, the condition fails. Does this permanently
> leak the xsk_addr memory?

Right. See the following inline reply.

>
> Finally, does xsk_skb_destructor_set_addr() truncate the 64-bit umem
> offset on 32-bit architectures?
>
> The inline storage attempts to cast the address to uintptr_t:
>
>     skb_shinfo(skb)->destructor_arg =3D (void *)((uintptr_t)addr | 0x1UL)=
;
>
> On 32-bit architectures, uintptr_t is 32 bits, which drops the upper 32
> bits of the u64 addr. In af_xdp unaligned mode, the chunk offset is
> stored in bits 48-63.
>
> Could this truncation lose the offset entirely, causing
> xsk_skb_destructor_get_addr() to retrieve a truncated address and
> submit it to the user-space completion queue?

Right. It can happen!

Brilliant, sashiko found another two pre-existing bugs here! I'm so
shocked at sashiko that handles the extremely complicated path so
well. It's really useful to capture the bug beforehand.

I will include the corresponding two separate patches to fix the same
problematic commit:
commit 0ebc27a4c67d44e5ce88d21cdad8201862b78837
Author: Fernando Fernandez Mancera <fmancera@suse.de>
Date:   Mon Nov 24 18:14:09 2025 +0100

    xsk: avoid data corruption on cq descriptor number

    Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
    production"), the descriptor number is stored in skb control block and
    xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
    pool's completion queue.

    skb control block shouldn't be used for this purpose as after transmit
    xsk doesn't have control over it and other subsystems could use it. Thi=
s
    leads to the following kernel panic due to a NULL pointer dereference.

Thanks,
Jason

>
> >
> >       if (err =3D=3D -EOVERFLOW) {
> >               if (xs->skb) {
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260418045644.28=
612-1-kerneljasonxing@gmail.com?part=3D4
