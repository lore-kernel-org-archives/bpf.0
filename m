Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0271392821
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775496266; cv=pass; b=Wa/xo2pIwtnjBz5YiwGDljU+jnUJdzLxczV2gjnCZxvEFIVxdtuutgj0ijIobrkV96WYNfpNdCaXy7RySmWCQfPJcHit4SnzV9xjXdri5yUWshNW+wSagCnAs14EzRBXkCGrlG4Ck4Mv4Ik9MADsoA7elkVOn6kGbmm9UzxmZpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775496266; c=relaxed/simple;
	bh=2eJkeAYzCvU5HtWm85RWm+UyW/a7DrMQO4hUjEnYSg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6OGzseb6lSHI2t9IJ/6+7qzHMOozc74RPOFY07p+LYIf4cBeJgbgqfZeX9u5ARNek1HoXqPcGmT5EBCOycO4HzCm2TzX9yd3JNMviScO9QSPNkVuRfHsBk5I3/RF1NWZJy1eMSyYxhOGZbvlbQsaL15AWXGAnlPA0L+S4ava+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkMbfWPH; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkMbfWPH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so37782885e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 10:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775496263; cv=none;
        d=google.com; s=arc-20240605;
        b=Od8qCM9mTUAFgdoGFtS646AxKcxSInHW9O3A02bifHbCJlMOh9ylfgQ7eyRAt95B7b
         2BNikoK6nH7vtF+NfE0Yj6dpYZJggP+QxGU2LRYoY6qGwzTNk5BE/XwlwQ48fG+OY+RI
         CS7ZkGuxJn4DhP4x+bL8Ih04JEJNj5H1kr/WpI+tEKsOuixe0qLiNnC0/gfT/mWeR+S+
         yxXLWrci/e/E5WZW0tyfMGOSOZvm/W+pqXoTM9Oq4aNTPZzkAyB/lA0zK7anbXzz89JR
         LM3fMc7tOmGrOx1bEDqrcgKienlP2amLuD+IoibQxV77ylyUVqPslsXjuX6xo/Ez4tMv
         mIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qrbco+MF+ZgCkl4s0hCwWmBkduVPKbWqG/m9C3g7//c=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=ZpLjR9aCUX9VNDyNovAvTzCDRSJNXH0QNdUtrAwCWOBZyOirtt8SfmMIIOyZOV1Jx3
         y9C2bZcZQZRAK95lndFtz1EybaH5eQrFWxGk2f8JRS1RLM8Uca661ptMJ35usaV+XECo
         R947wv6PJqLFe0gX2+MCxZjuHK/O4p+UIK+48J0dfJqIGC+dBInbC47ENs4VhRlsTKKk
         HBPuFHjXPUNnvGde0YP1vCZbIV6Q/11sLQAiFDSX93UcroxilRn9QuynwAH64np1rtV7
         cga/v6oPanxr5AMnO4IUgqxGA4UQa8QGOKGFoUAciZH8U6nZNuS9eeAc2NjJAisPv2C3
         Z7Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775496263; x=1776101063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrbco+MF+ZgCkl4s0hCwWmBkduVPKbWqG/m9C3g7//c=;
        b=nkMbfWPHXQv6ao3q1tdwauAoXDokvamIE2JWVUMT9lWYFrGJKLNsk91N2eDVnoV1zs
         lmZpev2aucS0Bwn7/XUakZfqM6B1C/7Wt84r8uF19cSBoQ37B8oYQjqCWHF82e/GfcQX
         EuW/5kYOWZriFY5CqGNdgEMieo1aNZvYmG7gF9Cs46y4wY/EXFNNQi999V0CZFzkDO2G
         ipuAfR2Wt7Qp7X25Xczo/B2yU6TW7JMiWA80wSO/dgbgEpMhEdbW/ClbGlYqKbI7xGDQ
         xlU0ctsDD/6hJUf4mv7jVVhfNcIyVAh9evIRiMXqAvtXrJj4YI3MF8eNcKPdOI73w0zU
         sgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775496263; x=1776101063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qrbco+MF+ZgCkl4s0hCwWmBkduVPKbWqG/m9C3g7//c=;
        b=Zz9s8dQERgfO72E0QyqkqrxNF0OpyZ73awyRzdxirwS2dV+GXO85ayWJtAmn0Rvual
         QZy3S4sN91Ty741fK6UM+3jHm27BIusGMMDVpLdhaKXGMAEyR+0Whwqax2W1Z70aiKkP
         Sk4piA4CSpESjEUeFzc1VXXMPIK7/Fc8dAYXLsyTfszc0gOdDKy51CnSjT2YR3EERRPZ
         lyvnN5Nf+4i+9ognrU08imbmo2OjmUxNabAPhiNWNnPCHbg4VuH5tXUy7cyl0AqRIK37
         mMxzkTMmA2PJw1Yx5jU4P7VO0C6pPkowXnRZFIgK3STCOCFcQXazHKe7pCXaYQG0lUuF
         lqRQ==
X-Gm-Message-State: AOJu0Yz/DoYsywJnWAEqoIrS3y0HUkqUD0vCUkj1zh7J1XOASyPwAJGC
	3CZLftqaeJUUGVf90WzmCeA1pKKoaL1Bvhis4utvFF5FNAIkAwoDOfkHtX0ghU8Xj1PANIXSjw7
	CMX6+vNrCvdkPX5t4zMi00Bcu4mtWIULd/Q==
X-Gm-Gg: AeBDieueJ/eRR5Y3VCf44U5XvpA27nBo2Vn3PXV+IHUThDY0FRKA3V5ZS8niDP103sY
	FMInbU9MtPL0fy4BTqByux9TJ8CtHBEStKAH+J+koUOdVgMRiKzFufB4Me0GpxRTK6tCY9kiGMp
	OyehbaTiYDuypBE8HSF0OiVGHtoMCwyrq31AwB5zysYbMh4CzS1ZgFZj/xJeVR+tMOO+tnOD3IG
	wIucKthM6aGyPYLa6LvlbaTdl8Pa9vrW+J61HUEPSMBJdIhpXUZDf6yny1bwEHy4TpAsDn13Fy7
	Psfb1418oK+Y1lEvookF1bIAj+HPdEzd8ImNaQMrwmvomTmKjwfNa07Z1XaLQDvXSE5YFpUlhOW
	9Oesd74oQuFCUWTxKen1yTvF0iQ==
X-Received: by 2002:a05:600c:138f:b0:486:fbf6:abd4 with SMTP id
 5b1f17b1804b1-488996f250dmr187310835e9.9.1775496263060; Mon, 06 Apr 2026
 10:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev> <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
 <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev> <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
 <074ee11d-3f63-4e6c-b66d-c60a834cbb25@linux.dev> <CAADnVQ+9OdBFnUAXND-MW7epFnqwj9f2w-w0xPD7T73sTMj9Zw@mail.gmail.com>
 <5f37fcf2-05f7-47d3-b412-1515ee19fbea@linux.dev> <CAADnVQJ6y33kKOPTWvHu-ZNLFa8JOUih5qfv+e-71+W=orBNhw@mail.gmail.com>
 <2036096d-296f-4834-9181-ae895d330d22@linux.dev>
In-Reply-To: <2036096d-296f-4834-9181-ae895d330d22@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 10:24:11 -0700
X-Gm-Features: AQROBzC-rIYyOLm3idYmz92oz-SH8uLW42y9yO4U3SCuB4zvCgIAIrzfFfeDHZs
Message-ID: <CAADnVQKFA=620FCUjw5oyw7PR_FnZNosQHewsnt3WiusVtn9tQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 9:19=E2=80=AFAM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 4/6/26 8:17 AM, Alexei Starovoitov wrote:
> > On Sun, Apr 5, 2026 at 11:03=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >>
> >> On 4/5/26 9:51 PM, Alexei Starovoitov wrote:
> >>> On Sun, Apr 5, 2026 at 9:29=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>>>> For 6th argument JIT emits these two stx/ldx as moves to/from x86's=
 r9.
> >>>> For stx case, we should move the bottom stack value (6th argument)
> >>>> to r9 and pop the bottom stack slot (8 bytes).
> >>> That doesn't sound right.
> >>> Passing 6th argument should not involve stack manipulation at all.
> >>> No push and no pop.
> >> The following stack layout can avoid the above push/pop issue:
> >>
> >>      incoming stack arg N -> 1
> >>      return adderss
> >>      saved rbp
> >>      BPF program stack
> >>      tail call cnt <=3D=3D if tail call reachable
> > let's disallow mixing 6+ args and tailcalls.
>
> Okay.
>
> >
> >>      callee-saved regs
> >>      r9 <=3D=3D if priv_frame_ptr is not null
> > I guess we can also disable private stack and 6+ args.
> > Looks like it's a bit in the way.
> > The compilers will emit
> > stx [r12 - N], src_reg // store of outgoing 6th arg
> > call
> >
> > For priv stack JIT will emit push_r9 while JITing call insn.
> > But it should push_r9 before stx converts to 'mov %r9 <- %src_reg'.
>
> I guess this is not enough. we can push_r9 in prologue. But for
> priv stack, r9 is still used in the normal bpf load/store codes.
> This will interfere with jitting 'mov %r9 <- %src_reg'.
>
> As you mentioned later, disable priv_stack would work.
>
> > Maybe we can reload r9 after the call instead of push/pop.
> >
> >>      outgoing stack arg 1
> >>      outgoing stack arg M -> 2
> >>
> >> After the above pushing (outgoing stack arg M -> 2),
> >> if bpf-to-bpf, push the outgoing stack arg 1.
> >> If kfunc, move outgoing stack arg 1 to r9.
> > Ideally JIT treats subprog calls and kfunc calls the same way.
> > Why should they be different ?
> > In the callee, in both cases, the first insn in the prologue
> > can be 'mov [rbp + ] <- %r9',
> >
> > so that later 'ldx [r12 + ' can be JITed as-is. Here priv stack
> > is not in the way.
> > Without priv stack we can avoid this first 'mov [rbp + ] <- %r9'
> > in the prologue and instead JIT 'ldx [r12 + ' as 'mov %dst_reg <- %r9'
> > since nothing will be overwriting %r9.
> >
> > It feels to me that it's easier to disallow priv stack for now.
>
> So if we disallow priv_stack, we can do
>     stx[r12 - first_arg_off] =3D val/reg =3D> mov %r9, val/reg

yes.

> other arg_off will be pushed to stack in reverse orders.

no. Not pushed. they will be JITed in place stx[r12 -off] -> mov[%rbp], val
Probably needs add %rsp somewhere to grow the stack.

> So for kfunc, 'mov %r9, val' already there, so we should be okay.
> For bpf-to-bpf, do 'push %r9'.

Don't follow. why should they be different?
