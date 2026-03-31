Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941323E3D88
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961851; cv=pass; b=qAkwQIFZ3r4kzQa4B6qfzBfavBgKCY51T/+SQCnZtguvq6uH5SyZjbHzfo9J3m8bMcyIE93jy7GyTqeJcoHrR+4TayDZvb7vrLv8P2fxVYfmavc3PL6V/kWID3AuiS9hGAfO3BlRTyXlx7ij0NeBnZz3+uoJCINSIfSZS8Qq/8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961851; c=relaxed/simple;
	bh=YUl4gyK6/e7FfbOW1z9y5JbPYdtrBVvIHyTKNDhIfJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hamfWRym7VoGkHKdPG18TO1qdgfNdm4dvTWa/we7Fk8W2I/2kFVTtDImyZKPdw5TrUYV08LquXNVD5bZKsRuAD/dFrbm2p3BbAysIEyS+lvMdVj8n6x5Fgn9T8nn76g6b12jJX/ut6wQu+NSotnxRPPbuBTImmjU5gJFLv+vOhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chw3eSyr; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chw3eSyr"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46704177543so3766675b6e.2
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 05:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774961848; cv=none;
        d=google.com; s=arc-20240605;
        b=GGsX30NB6WQmRtIJ77QKYMVTsbL0VbqKeql+lgZ3EOhyJuDzlDPhzkuUQ0fKZL4SSI
         YltByXbWx1WR/crYhGXR73I5hhAyq4Tm5AHwinQk1t/l7ua6vziLWnzAu2jzVPgwLe0+
         ZeV9KWZlGrLEh1jO9AxmcQxly42Y64fJFdfBJfQ9TbLIGSCHaHRmacHJiuOMUFEqbayO
         WAA6H7h/JWTdEf5IHvmOl0rI4fyZ6Hdm0gN9snGMs0AMsPendCb2/qHMt0s941KGDmig
         Bx6tRu/K4JZlhfGU9/mYatji5NhhMNnt8TjiT/ElYKMeIbCObuwfgRjovw7F7kVpAEAA
         7jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1i/IWNKmQViYlpNZcHjjgV2r5bCSVKhRNI2n0Z4OVes=;
        fh=700IbvxiHUJGJxk6FBc4SWfdhh/4hfZf0GNwzmBVKas=;
        b=PT4oZwexf+3k4Yx83e9CWWesE7yrTVaK/Acz7tVcQwuS1RsrJftm2rYVy9M4on9sR3
         NKkPBOKpAKJQ+6zcIng0K3q9UutPzYQfEPvjhseiPnzhDqr+BnADmV8r+mStsCh6H2yF
         gZCWHkmcpTNsApIM+yGFK7eRcS3LLGHeW8f8q6YEvcSE8dHDVXutrDgMsKzEzkKK2HQo
         ktLxq1+/KFsfyCxykEhXaZYRZ3gcDTB3M33Fneq27VoSZmFZy+Y7/K8FwYqID674Yb29
         x6dhQB+q9yRkzPEFEfG6ttmftl/KuJnqsLd/CYGa4sN6BahncFU1M4PRl+Wr8TgdQJkT
         i34w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774961848; x=1775566648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i/IWNKmQViYlpNZcHjjgV2r5bCSVKhRNI2n0Z4OVes=;
        b=chw3eSyrS8uLLDOLiP6PTrMa8rS8jNRWfJAK7sbOYESudZtHupYJ2L6htlLLlZHuvS
         s4OHMB4D+rBt+IMFqqen9om8fbCGipL7fP/VLRq3nzO3HGxTsQ5oq3c8BiP2SDmFIcG6
         9xFalUbxkpGQCV0Cx3LeYk4ZThsfZt0fW6NgjJZ6JZtz2UBMC5Hlt9v4zsGCcLrbRPhp
         O+5PCyHMRQv0Iu6TDXUaXwhHczgfmVa3/b88dOhPTRWEp+zMwHPXdjAYwixkABNp9viv
         4ALXoIOULl+nB023a41cmcgxR+OrnHYKGZsjsZ2Qo/0dD2os1odCfSj51O6FJIaXjjl3
         8HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774961848; x=1775566648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1i/IWNKmQViYlpNZcHjjgV2r5bCSVKhRNI2n0Z4OVes=;
        b=ouxTVxDQd9/q03pGm3VbrmDStF4QQTmb3e6WqEW4zwUI1fEtkaAMM0LWElgLljEG7M
         1uwIlwEhyHN/VVbxCiljkE+AqFr6F3wM6lDYyTNPinG0Z6KZ1gjG3/FBWdAwkZgfybzg
         s41r14hem/OQnldIA8KUUFWuzvheHdgvYYCQsMymqFMXetoGgA9XcB+sVD1og4+F0rgJ
         AZE5830pJisPytLfotlhXfRAdEvjynTDFTU5rChdmOJK5USIY9gpqv/PkyzSu3Hqlnk7
         GUVLYBBq0HazFPOFlCdBKCdLVOmhMGc1sxpSO6JUDr0gydPwCKnXM4M/rknn7AfUpF9G
         XICQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZqnCGLYBFOGct6N1jRrvl50ORx2hFvipzLZQCIwrzOt1PwuAH9kiCafloitkljCy1YS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTPTYEL1t3Zv3TAkiiQkrI7segHO07WcPARQtP95/zr+nqPPsK
	Fagt3YgR5VerskJVub0tn9ID529HygXxwiwqwXCBKq5Xp+QS0bOP6lrSGCje1hxryG451cvElD4
	syvxKJWKhLg3eGER7zfjIupfsMILwkcU=
X-Gm-Gg: ATEYQzxe/P+fF+9eFKWuQUqIcZZQQn1kV90rYK2DSZLCqTRGk1Hr/D2al3xR2eY3TiO
	XOpfrw64eOvpP5MdP/k4yJNUZ2mxAjnMKK+bu05tX3Y+cK3QjYQbYTd6tS3N/pHgFsuqawkLD60
	SVvtd89Lw+YM96Zldwp4MStnO6vtrnD8wAzXeW8JLJQl3+zqMVeNI3W5LAeyQ4KXE2r87ovWC3O
	XGdmH8vW/ZmwBRiSYoaDB+AJC++To/Y48/Rbgly5yVNEQ436hdBWEAeCYwVgN7GVNivsCezWTze
	Y5qheIM=
X-Received: by 2002:a05:6808:130f:b0:45f:13fe:4a3d with SMTP id
 5614622812f47-46a8a390638mr8325719b6e.7.1774961848385; Tue, 31 Mar 2026
 05:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330121732.1601352-1-eyal.birger@gmail.com> <CAEf4BzbEMuUMZZwhPMEkOpxLxue26EhjUUYNYnDyUzMAMX6GwA@mail.gmail.com>
In-Reply-To: <CAEf4BzbEMuUMZZwhPMEkOpxLxue26EhjUUYNYnDyUzMAMX6GwA@mail.gmail.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Tue, 31 Mar 2026 05:57:06 -0700
X-Gm-Features: AQROBzCFqPgo4MzzeJZkX-mtUUic_knLFIoAj5yOYf1kt3AtgoRSvViNfspwlu8
Message-ID: <CAHsH6GvKcJc2-P9tG=KzUEAy2T=GmW+xVOJ7q92ZF2Dp7hnzKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: warn against BPF_RB_NO_WAKEUP in bpf_ringbuf_discard()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, paul.chaignon@gmail.com, 
	chen.dylane@linux.dev, kpsingh@kernel.org, a.s.protopopov@gmail.com, 
	yatsenko@meta.com, ameryhung@gmail.com, tklauser@distanz.ch, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 30, 2026 at 5:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Mar 30, 2026 at 5:18=E2=80=AFAM Eyal Birger <eyal.birger@gmail.co=
m> wrote:
> >
> > Document that BPF_RB_NO_WAKEUP is not recommended for
> > bpf_ringbuf_discard().
> >
> > A discard done with BPF_RB_NO_WAKEUP can suppress a later adaptive
> > wakeup from a valid record, leaving an epoll-based userspace consumer
> > asleep even though data is available in the ring buffer.
> >
> > Scenario:
> >
> > epoll_wait(rb_fd);                     // blocks
> >
> > rec =3D bpf_ringbuf_reserve(&rb, ...);
> > bpf_ringbuf_discard(rec, BPF_RB_NO_WAKEUP);
> >
> > rec =3D bpf_ringbuf_reserve(&rb, ...);
> > bpf_ringbuf_submit(rec, 0);           // valid record, but no wakeup
> >
> > This behavior is surprising in the context of bpf_ringbuf_discard()
> > as it seems natural not to want to wake userspace.
>
> why? discarded record still takes space in ringbuf and needs to be
> consumed by user-space. So all the same concerns apply here whether
> it's discarded or submitted ringbuf record.

Right, but sadly this isn't obvious to someone who hasn't carefully
inspected the implementation.

>
> >
> > Reported-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 3 ++-
> >  tools/include/uapi/linux/bpf.h | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c8d400b7680a..c46b06d45904 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -4645,7 +4645,8 @@ union bpf_attr {
> >   *     Description
> >   *             Discard reserved ring buffer sample, pointed to by *dat=
a*.
> >   *             If **BPF_RB_NO_WAKEUP** is specified in *flags*, no not=
ification
> > - *             of new data availability is sent.
> > + *             of new data availability is sent, which is not recommen=
ded as
> > + *             it can suppress a later adaptive wakeup from a subseque=
nt submit.
>
> NAK, it's not "not recommended". If you are using NO_WAKEUP you
> normally would use it with FORCE_WAKEUP as well. It's not a rule, but
> that's the most practical combination. But if you are fancy and know
> what you are doing, you are free to combine NO_WAKEUP, FORCE_WAKEUP
> and "adaptive wakeup" in any form or shape you want.

There are still possible corner cases - for example, multiple silent
discards might fill the ringbuf preventing a later placement of a
valid record - even if it's meant to use "force".
Point is, the user should be extra careful, that fact is documented
in other places, and imho should be noted here too.

>
>
> If anything, instead, it might maybe help to emphasize that
> bpf_ringbuf_discard() does live data in the ringbuf that needs to be
> consumed by user-space code (normally transparently in libbpf or other
> BPF libraries), and the only distinction between submitted and
> discarded record is whether application's user code sees that record
> or it's silently skipped.

Ack. Will send a v2 in that spirit.

Eyal.
>
> >   *             If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, not=
ification
> >   *             of new data availability is sent unconditionally.
> >   *             If **0** is specified in *flags*, an adaptive notificat=
ion
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 5e38b4887de6..96de37c3b896 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -4645,7 +4645,8 @@ union bpf_attr {
> >   *     Description
> >   *             Discard reserved ring buffer sample, pointed to by *dat=
a*.
> >   *             If **BPF_RB_NO_WAKEUP** is specified in *flags*, no not=
ification
> > - *             of new data availability is sent.
> > + *             of new data availability is sent, which is not recommen=
ded as
> > + *             it can suppress a later adaptive wakeup from a subseque=
nt submit.
> >   *             If **BPF_RB_FORCE_WAKEUP** is specified in *flags*, not=
ification
> >   *             of new data availability is sent unconditionally.
> >   *             If **0** is specified in *flags*, an adaptive notificat=
ion
> > --
> > 2.43.0
> >
