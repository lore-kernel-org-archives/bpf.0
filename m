Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D553E5A17
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051246; cv=none; b=of+s6mZjw4AjrRcdrSqL8zeZK6knPgOjvK8jRgnw6T5pgUQkLvHAojzhD3ogH8DpMu3KCg9zbo/q6BX27IBbAFa7UVDHeaCZPw4W1N0/X+O6c/EA0RBkLEYHudP2KiA8iYLa95NZGcbTQA+i5Wo6P/7Pm/ALDak4s73JjqzzsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051246; c=relaxed/simple;
	bh=VIlFuzMOthIH0zswZE3ungt6zt284wlS+Yhgeodg670=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O8KEv7ro5TmKirDKwr6UoA9RYMWax5LIug7yJX4G2ywXoB168NQBQBctI0jvxVuOaK4ZsJML5aFi9iEviOykqimaZV5+ou1eUrLKpxfkizNR+WsXOd0GJhNOiazT3LCnJPXSOzzMbfaNt+6Vp+F4Y45J6VJxvKQv44ENXGakSlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbksD+HQ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbksD+HQ"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1985018a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790051244; x=1790656044; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VIlFuzMOthIH0zswZE3ungt6zt284wlS+Yhgeodg670=;
        b=CbksD+HQMgrNwUDWdeBA2k3vTdnY3Tot+PFpLdsYI6ol/ioXcndNx2Vo61bkcQzYTn
         Lz4wfHc/gSi+eMTatZI3UTH8Aj1OHLiwkGHvoin2SpYJ3JtIvwHjS2yTHFAY9VcCOiO/
         8U971nqzGsIerXbMCAJftKp4cb4nQe3cTVWHcDLsGswLQd5CBiIKuGvZpdsQupabjVTJ
         PLIcSPHSdU0jFx/+eVRvPXDnEScghIeBFSmteyS+NqUcqcYVQaTAIy4WD0EFuMPBucja
         4PdF5hUJAbY9y9ybc1YQNEzLRhl9aTmpMqEmD/lWKuFckZNSab1tMRQayzEoFra/sYTJ
         5Imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051244; x=1790656044;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VIlFuzMOthIH0zswZE3ungt6zt284wlS+Yhgeodg670=;
        b=1X4aFuK+GCooa2tQVrCzJroRkfT+wrwHesaqHEF1VAacn3wL2yI2uFojLxqQdU4W8q
         i3D5HFDU7N+XuiX4odNnLUOiqvwFmXo9/2w03AmnVO+r66QY5lyjCEm1VwQtpghXYzK2
         h2QrMAUGErYc1VsthGjRM2+O2qgv3YZOoeANU2KZmB4FXfgJo8s3hmuk7udqzfpGnAaU
         wsJ2XyDfVB/rerW47hkH1M+wIJlliF3c31pa3i0c5o21DiTFf0nx39Iy8WlybLfvi+OS
         ee0Io90dVKmVVrdrMcwwJ+iWXYYU42Iorj28M/E4icGnqHXNbcVW0AWFcwvmFRqe+P89
         IHow==
X-Forwarded-Encrypted: i=1; AKwUvByJk9GwJUzpH08yH3ZRfx0JHTQ2b7zbYUgeux9ckASFpGjPi2bKRR+HOF5tGrotw2tJ/zY=@vger.kernel.org
X-Gm-Message-State: AFuF++mse+UhjS4sHUJtSFAyN7qLs5/Y/gmuELxy1XoTi7BvlheBGJ20
	caXIV4+I1UOKukHrwDEhzqNwJsScbaKJeb+rBlgspGDSgpjqrbm0ratQ5WqzqknpI2s=
X-Gm-Gg: AYBFou3feSbvxhE3GMChp306AHdQpvIho9jK2I4c9QD1HT/kiErxiaf5E+Tk6Oli0SM
	xSKISq2v4l43mXgeXRIYgVAsYndNcx91I4czx2mWp5zmd4NE3yM3pgqGbucavCJY9SnwCBsenyC
	6TPDCY6/D+Rl9XURwpph4PfM9JMN6k2JMyFr75xdvap3YC0rFQ+8sKlT53X8y8pjWVwYpP8zWy5
	W3CHUdcDvkggx+rmhSlQ/T3h5P0m+n7CbcfJtHBfTUdTt6vgyhwsBQZyKWxJsF/UgiwMMLt2BV5
	KH3IQlJVfqu9SiYnIr+p1U7rENl1+Y+odzub8kAbqmlFoPfOD2hyC4BW/VqeEcpyG8C+YQaZs41
	YnIo47cFP8W8Lf3VPW5CPTjK1Hj6jS3Tp+e/KL4OAqzrOLOzy5WqM5OebWbvyn6talGogMyxgXT
	ljk/ew5+aOjCHBWfrLrHnWmRCCeUNixtBu4AmQnndgXV3ig3ei0gfU9N1Yp+QOvS72ts2ym1eOv
	Iyditgto18I9BkuiV8AK3fWuw==
X-Received: by 2002:a17:90b:39ab:b0:39e:34d6:7eb5 with SMTP id 98e67ed59e1d1-39e54b85746mr18452077a91.9.1790051244527;
        Mon, 21 Sep 2026 21:27:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674df8bdsm2254478a91.16.2026.09.21.21.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:27:24 -0700 (PDT)
Message-ID: <7eba4eb055e15d5c78f463d013fa98bb21d7b494.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Mon, 21 Sep 2026 21:27:21 -0700
In-Reply-To: <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
	 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 02:16 +0000, Alexei Starovoitov wrote:
> On Tue Sep 22, 2026 at 1:08 AM UTC, Eduard Zingerman wrote:
> > On Mon, 2026-09-21 at 14:00 -0700, Yonghong Song wrote:
> >=20
> > ...
> >=20
> > > Design
> > > =3D=3D=3D=3D=3D=3D
> > >=20
> > > A pad is run, not lowered. bpf_throw() already walks the frames with
> > > arch_bpf_stack_walk(); it now looks each frame's return address up in
> > > that (sub)program's table and calls the pad as a subroutine of the wa=
lker,
> > > with the unwinding frame's frame pointer and its callee-saved registe=
rs
> > > restored from the spill its callee's prologue left. The pad therefore=
 sees
> > > its own frame but runs on the walker's stack, far below it, so nothin=
g it
> > > calls can disturb the frame it is cleaning up after. The JIT turns it=
s
> > > bpf_unwind_resume() into the way back to the walker.
> > >=20
> > > The verifier walks the same thing, step for step, so the resource rul=
es
> > > are unchanged: whatever a pad releases is released in the verifier st=
ate
> > > too, and check_resource_leak() simply moves from "a throw was seen" t=
o the
> > > end of the walk.
> >=20
> > I have two high-level questions.
> >=20
> > 1) The tables handling mechanics adds quite a lot of code to the
> > =C2=A0=C2=A0 libbpf and initial verification phases, while at the IR le=
vel
> > =C2=A0=C2=A0 it is basically an encoding for the invoke instruction:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0 invoke <target-function>
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to label <where-to-go-=
on-return>
> > =C2=A0=C2=A0=C2=A0=C2=A0 unwind label <where-to-go-on-unwind>
> >=20
> > =C2=A0=C2=A0 For the sake of discussion, wouldn't it be simpler for us =
to
> > =C2=A0=C2=A0 just add a 16-byte invoke instruction:
> >=20
> > =C2=A0=C2=A0=C2=A0 word #0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 code=C2=A0=C2=A0=C2=A0=C2=A0 INVOKE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst_reg=C2=A0 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 src_reg=C2=A0 BPF_PSEUDO_CALL or BPF_PSE=
UDO_KFUNC_CALL
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 existi=
ng call meaning, including kfunc BTF fd index
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 existi=
ng call-target encoding
> >=20
> > =C2=A0=C2=A0=C2=A0 word #1:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 code, dst_reg, src_reg, off =3D 0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 imm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signed=
 unwind displacement, measured in 8-byte slots
> >=20
> > =C2=A0=C2=A0 With an assumption that during normal execution (not unwin=
ding)
> > =C2=A0=C2=A0 upon return from invoke the control flow goes to a fallthr=
ough
> > =C2=A0=C2=A0 instruction.
> >=20
> > =C2=A0=C2=A0 The pros are:
> > =C2=A0=C2=A0 - much less frontend code
> > =C2=A0=C2=A0 - if in the future we would like to manipulate BPF program
> > =C2=A0=C2=A0=C2=A0=C2=A0 byte code, it would be significantly simpler t=
o do in such form.
>=20
> I think the amount of code will increase a lot more with such approach.
> All existing call flavors and my new callx would need to wrapped
> with this new 'invoke' insn.
> Also rust generates begin/end across more than single insn.

Total size of executable sections for all Meta BPF object files used
for CI veristat testing is 10Mb. Of these there are 30K non-helper
call instructions in total.
So we are talking about increase by 8 * 30K =3D 240K ~ 2.4% worst case.
Note that the instruction encoding optimized for size already hearts
us in src/dst registers department: we have no room for virtual
registers, which would have simplified e.g. register allocation task
for ARM64. Point being that optimizing intermediate IR for size is not
always a right target.

> > =C2=A0=C2=A0 [1] https://llvm.org/docs/LangRef.html#i-invoke
> >=20
> > 2) The final goal of the BPF/Rust project is to consume whatever code
> > =C2=A0=C2=A0 rustc generates. Ultimately, this would require supporting=
 a way
> > =C2=A0=C2=A0 to introduce runtime checks at arbitrary locations, whenev=
er the
> > =C2=A0=C2=A0 verifier can't infer that the program is safe.=20
>=20
> so far all rustc code looks clean and definitely not arbitrary.
>=20
> > Such checks won't
> > =C2=A0=C2=A0 necessarily have associated landing pads. Meaning that the=
 unwinding
>=20
> no landing pad? what? That's not rustc.
> You're talking about some random compiler that throws garbage.
>=20
> > =C2=A0=C2=A0 logic will have to be dynamic as in exceptions part #2 sen=
se discussed
> > =C2=A0=C2=A0 way back (2022?).
> >=20
> > =C2=A0=C2=A0 The argument against exceptions part #2 back then was that=
 the code
> > =C2=A0=C2=A0 is complex. Given the current environment, I don't think t=
he argument
> > =C2=A0=C2=A0 still holds.
> >=20
> > =C2=A0=C2=A0 Hence, given that dynamic abort would be necessary, and th=
at the kernel's
> > =C2=A0=C2=A0 rust code is already compiled with -Cpanic=3Dabort, do we =
need this static
> > =C2=A0=C2=A0 form of exceptions handling at all?
>=20
> This patch is static exception handling for cases where compiler generate=
d them.
>=20
> We don't know and don't care what is in those landing pads.
> rustc maybe cleaning up the objects that have no meaning for the verifier=
.
> Maybe freeing memory (but since it's arena) we don't care,
> but we will still call all the drop()s because that's what rust as a lang=
uage
> promised to users and we cannot break that promise.
> kernel's rust with panic=3Dabort needs to be fixed.
> That's orthogonal problem and definitely not something to follow.

As Kartikeya says in a sibling email, I mean generic verifier
capability to accept any program by introducing runtime checks.
Verifier's capacity to infer safety conditions for various
instructions is orthogonal to rustc's assumptions about landing pad
boundaries. E.g. rustc/llvm might infer that certain memory access is
within bounds and optimize bound checks out, it is not a given that
verifier would come to a same conclusion and that some landing pad
would be declared for an instruction.
