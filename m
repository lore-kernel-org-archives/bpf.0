Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1D1A6828
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779653; cv=pass; b=Ne1MQZNGOily056yQ3/aBhXVOyeNRz8miFP43NfDM5oI/IoNm3fdnkgoc5SLEu7gq3A4zXE/qxt7AAWhW2/twUsBS3Wrzq9hPYryBrc2ng8DyNnastpbVqiJARtut4kUrGcM5Pua4e9SGOQpVNveFqakYq43aaI2C0iX5XYu+jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779653; c=relaxed/simple;
	bh=6v9hXkwbfTuR7Bp5PDEPEtAB3PzOFxBdNLqPa13nNto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDAIkZcvlhAHXlxUUnAavMN/v0Z16jQhXCdDfyp2/hznluiyvsxZCeGWn3wsJYE21hMEwnHxfyW9qCzFMN6bz/VkhLc36l55b5zkzLJSnzFW6stMBrNQoH5Qyf818gZCXlyVUoxmBjchQGiQobvTEMxTcmqHH9I3+AQQoEYpQCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKV+P8IZ; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKV+P8IZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d73422431so3668818f8f.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 06:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776779650; cv=none;
        d=google.com; s=arc-20240605;
        b=OGfGC5r5ZcTgzkiM7cxz+d2cuFEcd4csCHpBRdjSluATrFY8oqdH3bmLBVZim0L9j3
         u3H0N7mvYDTbfwPheAnhEgub+BkOCqVYGrSmJr23hqdmIW3iYklWHwoDRtCv9nv0Qh25
         PnU2oe8iccXZZuXNwIseGtDCszlG/aSQfRzKRrBsqb0RmK6orq8uZAQqSEVxwm/uun6x
         GIMVG9SSGe59JSzI9mPH9mf2cUg2KLPV5klBz5U1JKnELYyKOI9BZXvUDiWugGaDf6oZ
         r1bVPg88y3g0dgqYZlrHFkq3gg4fm3borGH/nPSupvnO0KC5d4NWmUH7ckh8YCB7vzU7
         +QRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BlfqCNW/FSeVJzbOG+jGMfxmKYm1QRHmd46Cb7BacKU=;
        fh=mSx45Ie9hdO1AXjTRA5R70BfnIv6fntYbNMIBQYhNnE=;
        b=krunO/pqpwo8sCts0q+ccHl9BLDbnSiL7aba7i6SoCbv/84pBrmPo3unf/KyLUPnx1
         j18a7yxpxoJJyMNTFnQjaCyBNaZgrMMzu0NclCFWBOjuCja8R8UVnT/35oxrEpHuXhMs
         vHL3vpvrF8MJTitLAJ3hss9/cd6e102j4wx4puokJU1EZ9sfYMSrgXnA6lqoHlpFmPru
         jcUX/Fd1z27EybjdxDF2FuSAO6ReWqFBwMPdsqnkWn1spBaV6STxsZbY+H6QU9PQp7oI
         VufqTnhccj0w/3A8ou301VFqn+DS6rceobOI6LsCR2ylnIS6ZDy0WN2XX7y+1Ov+3LFK
         UNRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779650; x=1777384450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlfqCNW/FSeVJzbOG+jGMfxmKYm1QRHmd46Cb7BacKU=;
        b=hKV+P8IZoZRwi/SxbTrwsAObDXdt5pY/gV61zSSaSUyguf22brjmgj4ZslrIKvfD7k
         Bg319z6ANlWTqVEKmr1zDsuLGQzhzGW7NHw3uIiMSkW+8DCNIX7N2NmaLuGsRMuywMKD
         3wNYg6p2uElOLmnfi85WnLEQVm2gHJsbYK+nTKyWbQlqlKJhvZWkhA1b2bPQSuQe8XqY
         G997+GwwIn3bpdiT08bTEGU1NhPTH82DrW7NyeqB4saEDr19/bh0lXeYXtg/FaWEx+L2
         R8323Bh+aS9gQ0BOyIvAijAvSdBqPH6xF0PzXiAXvVnCx9UChU4/EawJwVh67N04npOl
         1SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779650; x=1777384450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlfqCNW/FSeVJzbOG+jGMfxmKYm1QRHmd46Cb7BacKU=;
        b=dUjPgkmxiZ/UqZqVhGlKUIVCdl9GN+fYiyn0uoC9zhNLDwNzrJnneDBhtB13bkmt+z
         VvfsIUJZXt3hjZInvoZV/gSaHSkZshqxVA9GISgW3HeYwPdRCOaB1QeY3XV5WmVVniqJ
         AByptD600PRS1RWvWq8vY2+0V5a0YW7ipzdee/fES3JBvoR1j+JGEcJF050pLVJ++ShC
         6KCDzpsFZ1cyRwdRcjR1n45aoBLf4tmjrOpnOY/G1vAFjYbNG4NkxVbZlcRCWCR6r7n1
         kcfz+C9ANW7OaXbaTCj+5Oz0u9raN/XGT/kbxAMEPPlHqnBnZ2l3CL7IBKTKCfijMKoB
         1Wgw==
X-Gm-Message-State: AOJu0Yzf0Iee5HzVJt6PDA/Ll8kUM/pkIxMwoeWTVYLgyAbMBkeRWyQ5
	okU6NLEBZOtNAS4DTtGaiBMjc+ni2h1959h0xaDceb7+4zs0tB74nWqru6lAbudHMHhfuR3hg1n
	mUMBpCdR5mUdyEEZ5g66OHiyhFA/nglaMWh31
X-Gm-Gg: AeBDiesX4FRydFHbvNgBFhwrIM0gN+qIaVxkZAnguAKzyPZX5b2/AxGzG88DLKKV9oC
	Wfdvzs8d3gL/UAQ485q+AZZgJGSHuKfaDo2P2R6ZBQOMEBRvdMzIKjMZeLKhcgU0w6uc/sR0Eli
	fAiGVpjo1TOnspe9eIClXYWP+DK7NUlvk5ai5Cu8hzbSAmQjiK0fguJWstfl1dobV70EG+dMJ9m
	NHePS0OF9mrUs2D2kqovOQRA0OAsbGn9XK61bZ1x1B75VjqisxQn696K/t7X1aOUiUW4RgH4z+v
	kdvjvSXdErt2UoG1evLl1FWSKryg1TrzAai0z50kup59L4k0pEoS1RhbFU3Rn1U9+fcxMB+7Z8W
	ZURnbJIcnEEU0fI6u1Puo33nkrEViXOzY4an/
X-Received: by 2002:a5d:5f82:0:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-43fe3dc842bmr28527313f8f.7.1776779649652; Tue, 21 Apr 2026
 06:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153603.4097618-1-puranjay@kernel.org> <20260420153603.4097618-3-puranjay@kernel.org>
 <CAADnVQJ_D6XyvMHPr59dxZSgFY3+6UayhcWrDC-U2k-Epv-9eA@mail.gmail.com> <CANk7y0gNqm7U_0Kc6ZP9jd19gHKScOaTVDa4yxkxTVDonM0iUA@mail.gmail.com>
In-Reply-To: <CANk7y0gNqm7U_0Kc6ZP9jd19gHKScOaTVDa4yxkxTVDonM0iUA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Apr 2026 06:53:58 -0700
X-Gm-Features: AQROBzDOw5Wnk3onvAJHz6qXwZ-uXC7yQdgyNnhy8J7Zkrt3nHngFVmkI6QtdTk
Message-ID: <CAADnVQ+uNGK_XKwb09d+xHZk_5-RWk=4_ZQTaQP24ej4+Gc8HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf, arm64: Add JIT support for stack arguments
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:53=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On Tue, Apr 21, 2026 at 3:58=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Apr 20, 2026 at 8:36=E2=80=AFAM Puranjay Mohan <puranjay@kernel=
.org> wrote:
> > >
> >
> > nice and clean. I like how it maps to arm64 calling convention.
> >
> > > +       if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_ar=
g_depth) {
> > > +               u16 outgoing =3D prog->aux->stack_arg_depth - prog->a=
ux->incoming_stack_arg_depth;
> > > +               int nr_on_stack =3D outgoing / sizeof(u64) - NR_STACK=
_ARG_REGS;
> > > +
> > > +               if (nr_on_stack > 0)
> > > +                       ctx.stack_arg_size =3D round_up(nr_on_stack *=
 sizeof(u64), 16);
> > > +       }
> >
> > I'm struggling to understand this part.
> > Why do this when this func calls more than what callee passed in?
> > Looks fishy. I'd like to see selftests with more than 6,7,8 args.
> > Because only then this logic will kick in?
>
> Your confusion stems from the naming of "incoming_stack_arg_depth" and
> "stack_arg_depth" (this should be called total_stack_arg_depth in my
> opinion)
>
> So, if you see fixups.c
>
>                 func[i]->aux->incoming_stack_arg_depth =3D
> env->subprog_info[i].incoming_stack_arg_depth;
>                 func[i]->aux->stack_arg_depth =3D
> env->subprog_info[i].incoming_stack_arg_depth +
>
> env->subprog_info[i].outgoing_stack_arg_depth;
>
> prog->aux->stack_arg_depth doesn't store outgoing stack depth, rather
> it has the sum of both incoming and outgoing, that means if a func
> doesn't call any function with more than 5 arguments but receives more
> than five arguments, incoming_stack_arg_depth will be equal to
> stack_arg_depth.

Ohh. That's indeed all too confusing.
See my response to Yonghong.
I think stack_arg_depth should mean outgoing
and incoming_stack_arg_depth should mean incoming only and
it shouldn't be even used by JIT.
That memory was allocated by caller, so to JIT this callee
the conversion of r11+const is straightforward and no checks necessary.

> if (prog->aux->stack_arg_depth > prog->aux->incoming_stack_arg_depth)
>
> This check is for - "Does this function call any function with more
> than 5 arguments", if yes, is it more than 8? if yes allocate stack
> space, otherwise stack space is not needed because argument 6,7,8 can
> live in arm64 registers.

I think it should really be one check based on stack_arg_depth.
