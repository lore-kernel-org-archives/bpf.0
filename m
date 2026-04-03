Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE561126F0A
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775240560; cv=pass; b=WHnwu7bxN19m8giFh2A7VpAhHG6lC6XZwrPCF1osxFGsP9urRhPGxixOcI7DgrMN2R7jS78OmgmHj1vAjVWr1wIso9+qaEf2xYY9hD2kt0Vcwki8UuypYHIfJLgUHaslZrmXahABbQS8z777AcrMuYSDZULPs4UxLSIKjuzZ8EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775240560; c=relaxed/simple;
	bh=wO8Fu1eZwALl1MK9xM52l5aTIpj5CiOpObakHlchgFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwWWQBfu0phvk0Ee9IKZdS1NRwNOGNNKvYouFboys09v/dJTVhGsHaHiVfnh4f9B+Mjn9xZHT6tuqc89TtXwB7SEn+6JzsAtoeVyUsmG4VYq+8D9ZSRAfmINueuYhYXXl6Nfe2t3hwfoM251CSzqJf/zLyau9REzLQRavELhaE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkHcjVXg; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkHcjVXg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso1221434f8f.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775240557; cv=none;
        d=google.com; s=arc-20240605;
        b=Z2Fh3qU4/vw+qkJr1FF8l18hWJLFf4kiSscTDGdSnV6ZSPPe0iLHbieGeVwFCv2ex9
         WILFPRjhLGZYvCOK3adHwP3eSbYrvSTmeIZQExbhEJhO5HyMFu0Wo8/1FdS0USoG6BHm
         omJhzeO5q1lSaAj57UFmdxxRaLKmRuW1RpEPrJMJnFPz0HhEoRTqbehLAfFINr/cWz0T
         xtLOpN+p6LNgVDmIazhVHPV3Xouba2tyTCqBm1kj/LobcZgQhNtRzAlsi84EDiEq+x1u
         dcDdUYqo0s05fL4+vhNM3epEKowI0PtJWgVe+wwXVHRpRpTU15GfI9iCojrfrP3MPyBV
         cQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ADs9ABlkuaAh3THGOqCIZYzLgsQu/KNBtojuKFogrPo=;
        fh=nK1sKfOAOlKgx9LOXsQrEFK5C3aJSpECzQWLF+tENHY=;
        b=FZXQ7JwN/jAt3nOjZLT867gAFwaXioT9E25yH6YYk267hBvvTf56hVvOvr+LmBb+cI
         QCMyDP7Qdl3Y9mr1fH9LpOW0Y2lgiPkZgV23x0b8MS7e1v6fDP5L7nhglUi9K6/OM/9d
         v77ng++k25uwrNiEMwEAon0naGiIJ+FtyWUdDb0B3/JVsgjrf3+kq7EVnJoIVduaJ4dX
         zHftTlFgE/czKIrpvPIAzbygqw7WO5rlth7gIisV8xEpmEVU41Gh6Nncc7VyvHWSNFAi
         nrOkeumKAkx9r0NK5BdkLUx22FwD7eMNpJ8/xEkjinQQ7Zp23Eh8FPVPB0bS0hyfpGLr
         MRDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775240557; x=1775845357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADs9ABlkuaAh3THGOqCIZYzLgsQu/KNBtojuKFogrPo=;
        b=RkHcjVXgZS/9Gv4Ac6d4V+gCkABWEcNVKGqzFO3qRZfXF5UPfH+akrdvSt69ihDYi3
         3QXmASHk6it90TQJfWzTJjts0gRI0EJV8ZwQi2wMf3j52K/FYqbrtfCHFq3tmqqmTacL
         R7MiRVcMmzz6OG45pvFVmukuBx2pEtQbjPx0ldQamPxp35Bzldb7DRiamwgXVU3B+67E
         vuCtxgda1ouEPe9htpTzAPqBJWcj7jKK57If8WRBeQIzvn5oLW78m9hJ3PoWIYJR7MEj
         22DYTDMbfkB2Cxs5cvCwv+POEjExUCw9y0scIHk8Z+MOW/SaF5F0M5htVMGlcdBydT56
         P8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775240557; x=1775845357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ADs9ABlkuaAh3THGOqCIZYzLgsQu/KNBtojuKFogrPo=;
        b=QOsC3iItpY0HoXGbEARICANgebftpyU32wifaBkAqmI84DY0WkvBfl5LrNTpUNu4AC
         0dxqE33n9p8O6Yr14OTP2TBfsjUyWsQTQzaFIsAYZnnwBWA/RDelrlwTS9MQdDJAyV1S
         3SNJABiQylzlrLK0WGy3D5Nc/WlLPvhqEqU0tDJuUx+LkBYKIoekkkdF2FBLIYKp/EH8
         NSeZYdHTqvQ1YJzmv0QT+p8TEqPr9N4uOxcCbcsnOE3E6r6IkC1EAbyAD9yUdBq6bzXF
         iI+ksRDy9YP60cR7o3A9HqfGwRbKNi4X4GB7bddcQHS8nx5Mzg338pxPXgt8kz7+36hx
         HDsQ==
X-Gm-Message-State: AOJu0YwVTkolh0AwhDqM90SYtZtxc37Mkvis3aqh7edrOqMDx4VhQF2T
	UDv7z+0IpWGDI5O+KDhh8OvOcAAnbJuQ+1nOwM986H/4K/AuLTTVz+JO9Xy8rJyWGNLo0AcD74L
	1LwIgM56+PHlyPQ0Xn3AQIBaiQ6dUlE0=
X-Gm-Gg: AeBDiesbmidqJ3Mktnl0SEeCT60JIHJJ9xKT35KvsvuWbq+m019etL7EfKdfj55lH8o
	ZkJCefkA4x9mYnqVxUDP2cSo0wbGFDg170twwHAr41wxDTt4vRnvE2EbSvd94lyrMxJtATQdgWy
	p3iJaRcQUAUoyEWgeSoydfgKhCmKg2rRxy94AjifhOqCfU1iSLB28TmIQk4LAIzfAFgHzmeoSTT
	GkvSRXW/obTA09/aBi1YPv+l6Gwa8AWT4lnzEIjjDktR49bZqhL6bY4ei9ssIqiLRonCcL1y9Ox
	RvvlvQ1X38bVjHhQYgOdUX38HRXf4Ay3jH0hS9tfXIvR0QMB6pEq3e+dot4TzOGA2TsoIvvEEI9
	Az3YF8FtT46x4kJ678NCaffRICw==
X-Received: by 2002:a05:6000:1a8d:b0:439:b440:b8a2 with SMTP id
 ffacd0b85a97d-43d292e3addmr6014433f8f.28.1775240557008; Fri, 03 Apr 2026
 11:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com> <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com> <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
 <ac9yriPJX9RXa5tr@mail.gmail.com> <CAADnVQK0mEAdZ3PEHv=wvbPUrEA7EPmU7w928JOd=143vt+kJA@mail.gmail.com>
 <adAChK9+GVACl8ci@mail.gmail.com>
In-Reply-To: <adAChK9+GVACl8ci@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Apr 2026 11:22:25 -0700
X-Gm-Features: AQROBzA3dYKX3NYJ10xFj0ZaQl9PtOY6rD5OUGi2X2EPk2NnB_ug-QFR2i4aX-4
Message-ID: <CAADnVQLq9X6K3_vwcsMEy_5AEk+y_gWbUHSibn5uGqbpdejirQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads from insn_arrays
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiyong Yang <ksur673@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 11:01=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> O 26/04/03 08:10AM, Alexei Starovoitov wrote:
> > On Fri, Apr 3, 2026 at 12:47=E2=80=AFAM Anton Protopopov
> > <a.s.protopopov@gmail.com> wrote:
> > >
> > > On 26/04/02 02:32PM, Alexei Starovoitov wrote:
> > > > On Thu, Apr 2, 2026 at 1:44=E2=80=AFPM Anton Protopopov
> > > > <a.s.protopopov@gmail.com> wrote:
> > > > >
> > > > > On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > > > > > On Thu, Apr 2, 2026 at 11:38=E2=80=AFAM Anton Protopopov
> > > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > >
> > > > > > > When a pointer to PTR_TO_INSN is dereferenced it is possible =
to
> > > > > > > specify an offset inside the load instruction. This is a bug,
> > > > > > > because while the verifier ignores the field, JITs are not.
> > > > > > > So, patch the verifier to not ignore this field.
> > > > > >
> > > > > > This is too terse to understand.
> > > > > > In 2nd patch you're saying:
> > > > > >
> > > > > >    r1 =3D &map + offset1
> > > > > >    r1 +=3D offset2
> > > > > >    r1 =3D *(r1 + offset3)
> > > > > >    gotox r1
> > > > > >
> > > > > > Here offset3 is, normally, equal to zero; but this is not guara=
nteed.
> > > > > >
> > > > > > What is this 'offset3'? Where did it come from?
> > > > >
> > > > > The offset3 is the .off field of the BPF_LDX_MEM instruction.
> > > > > The BPF assembler will correctly work with non-zero offsets:
> > > > >
> > > > >     r1 =3D &map;
> > > > >     r1 =3D *(r1 + offset)
> > > > >
> > > > > > What do you mean JIT handles it?
> > > > >
> > > > > JIT will issue a memory load with this offset,
> > > > > but verifier will ignore it (before this patch).
> > > > >
> > > > > > can llvm ever generate such code?
> > > > > > if not, reject it early ?
> > > > >
> > > > > LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> > > > > say, if one jumps to a structure field, like in `goto *p->j`
> > > >
> > > > sorry, I still don't get it. What kind of syntax is that?
> > > > Could you share the godbolt link where llvm actually generates
> > > > such code? If the verifier will reject it anyway it's fine.
> > > > I just want to make sure we're fixing real problem.
> > >
> > > I am not aware of any real-life code, only can construct
> > > some artificial examples:
> > >
> > >         SEC("syscall")
> > >         int test(unsigned int n)
> > >         {
> > >                 struct {
> > >                         int i;
> > >                         void *j[3];
> > >                 } x =3D {
> > >                         .i =3D n,
> > >                         .j =3D { &&l1, &&l2, &&l3 },
> > >                 };
> > >
> > >                 if (n < 3)
> > >                         goto *x.j[n];
> > >
> > >                 return 0;
> > >         l1:
> > >                 return 1;
> > >         l2:
> > >                 return 3;
> > >         l3:
> > >                 return 5;
> > >         }
> > >
> > > It will compile into
> > >
> > >         <test>:
> > >         ;               .j =3D { &&l1, &&l2, &&l3 },
> > >              160:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 r2 =3D 0x0 ll
> > >                         0000000000000500:  R_BPF_64_64  BPF.JT.4.0
> > >              162:       79 23 10 00 00 00 00 00 r3 =3D *(u64 *)(r2 + =
0x10)
> > >                                                                    ^ =
offet !=3D 0
> > >              163:       7b 3a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =
=3D r3
> > >              164:       79 23 08 00 00 00 00 00 r3 =3D *(u64 *)(r2 + =
0x8)
> > >              165:       7b 3a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =
=3D r3
> >
> > Great, but where is an actual gotox that is using that r3?
> > Looks like it's spilled into stack at 163 ?
> > Does it pass the verifier?
> > Would be great to add it as C selftest.
>
> No, this one doesn't pass the verifier (it is spilled to stack, and when
> it is loaded back the error is "invalid unbounded variable-offset
> read from stack R2", because it is loaded back from stack as
> "scalar", not "insn"). All "normal" use cases from [C-level] selftests
> (a switch or a 'goto *j[i]') compile into code which accumulate
> offset into previous instructions.
>
> Do you want me to work on this example above to pass the verifier?
> Or, for now, the best thing is to just reject non-zero offsets?
> (The latter has the benefit that the patch will be auto-backportable
> to stable trees.)

I wouldn't worry about backports. Size of the patch doesn't matter much.

Is spill issue just a matter of adding one line to is_spillable_regtype ?
If so, let's do that and have a test in C (in addition to asm) that
actually using the offset.
