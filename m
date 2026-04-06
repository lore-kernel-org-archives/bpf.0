Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4100323C51D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488690; cv=pass; b=CewhwOHAEqcLBwEy1JJFov/pF674lQSjOMd7zA45zReRQv9qWQAeiRtHAzqUPOy6i19H0c5EuB+zkDLBMhW3x9rBdZZapL5HU0eiQBvifYJ+E6LMENWOz/nO00mxLa0OdMy0I2lJJbDVB3Ly7X9lZIu1C/mDs1um65U8tKvR1Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488690; c=relaxed/simple;
	bh=zwhdRNtzlC8uf2fcuU+aJK/smegOIuhk+fTgxhkFq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KnrQ3K0sd/9/AHSJp2loNPnkChZscmTSl1Ta5GZmiPENTGC6uVZD+Ai/K1+Pp1HAKwzL2BckwhIDO9MLysRww3q/gd8BEK/wXjwkKkGHcN4Pe+aNmxNhV90prY6kX8FOR2i9n46DrpUJy8ATRR9IGbcaXiAuWuFDTftxwwgEFFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5PKj0rf; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5PKj0rf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso10129875e9.0
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775488688; cv=none;
        d=google.com; s=arc-20240605;
        b=iOJL0hKwNPjUigRywnGpaHlIbjoS2YHtHlNJfnXRYIOmmAQD+eY2dIVNiFdcKfHPwb
         RifivBjhr/RBs/zlUTE5F63aoOxbX+8MUdekK2f5ETVamJKOiliLDELUlHwBP5OgvgUL
         j8YDrh1F6TkdtSZ2W++IylNQoP1MMWyyPs0Al4rzalkipVbu+fZ0rgbyVZbmE/dUVrNy
         q0rHfAsRiUHQLFefoSPy27GEZUJJhN/N5wVMESsDoBAmXCsjkaFyBzgZ3waR0Q1q1lah
         RYKWZEaSCrnZsqLXI4azll+afWxz5lG91OnPqivKwYGonMmXnZxKV5TYCrbzgeMBE+3c
         0ddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MRFjMPYiK9CkQzf7uTvUjM9YzCK4Q69sInzTRadu42A=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=DskAhG4mWfi2MFz4LtBwtcuyn1rhGqgAyAuLyklg4nSSAlq9z7TNBUF1juAkxFlv1f
         TdBHkRA/SrUpZh+QG3+kM6dZIcLZ/qzTeT4mnQbfzYVKbCBivgUFtJBRShjtYBQLN+A5
         1s78orMTYrRVGwcEwlGxwhhDz4VXT4Lwr8fe+V5u7ydxCPQNnxw/hNjQth0hM0QmCJ1g
         xVVxivaHZ1PRqUMqzJht06xKpV8eO+3VLZy+Yl7hxiQP665hHLUAKpfMtg+NRtWuFNwQ
         bCxWrxSTcemk/TStdqF2b9EPi62XA/Q65KdpEEH8WIZWlkswzX99PxMOm/RiJlL5M/fF
         sBkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775488688; x=1776093488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRFjMPYiK9CkQzf7uTvUjM9YzCK4Q69sInzTRadu42A=;
        b=D5PKj0rfTkTWkM5Rl+xVjuhtCf5szJTBpHjWO+yV2+F80IFo3khv3wDOSzEoEAygnL
         jDOa2wF04sYZKIvGkSpkl3TYQyJ4YJEewErekRud2/CXwVLgHu/Rv0bSLmQh88NCYsR4
         G9JTcg6OryQn+EzoEnHtIKaujSoaM9XcSCGE25aa1c96/GWm2zblil4P8tg8hw4n63hU
         GEhT15uAYcSNuQFtvgpWNSrhMMVmEbRIQwL6ttStFzxQWyPTyBKH4DranaPmviiZBTFW
         WxqS5O/WS4UE+knIO3Ek6MEC0UxfIqij2jA8sa8QM5q3FL0ulS0HZqyecMk1sDMRNL2V
         L6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775488688; x=1776093488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRFjMPYiK9CkQzf7uTvUjM9YzCK4Q69sInzTRadu42A=;
        b=XZvSG5CEdvV2580nbmsE2pB0Cztym1JEQsqmvWtA0kaXu5rDDOdT+2BiGFIOEkqpY5
         b/9gJYqrrDcurUhH69vXp4WhSWZQiRVmqhBe+omGD7mdBW9vvWSvCrX3QebV707BF9rB
         bpszN+haGYVEdVMHGCpm/eucIr9SeOqC1QZVC3bMKAseKr2+DlyfUvq6AJYWINNBMXMO
         vdp1HlBFrYZTOPryPRktNP2bTWbGMCfuUHvk2KH6EEhpKrGavfGGclBdkC7GxdRzqBKa
         vdk60qqf+r8y7//qDp+m+NU/6+pqPiTpuT3OvveDPfC56w9mZHx0VSiCAYe3puFoVTma
         1Gzg==
X-Gm-Message-State: AOJu0YzHsx0YP4stauarY7f4UAW57KlUKQZM32rVEtOutDg5gAtvEb5Z
	gLTo9UJPJeRElQ6eX8HCPhsUbLsT8CSk03Mngqyp6Ll8x7a1RRA9MW1IcbQw8pQoVBxei+icEZc
	/CWoc8jWxzsJnD7RLskHFUVyD+y7wRQvJYUFg
X-Gm-Gg: AeBDietBkbtCxppmSmMRN2U2x2YOiQSzqxbH2Y3NHTOCRcjznJw0fhAiP2dLf8+K5Qq
	wgj60t+GgRq5YySS6CGr+mDDSX9mhWzdVTM8cj9vQLnxH60Tnvd1dyOqVYBoKw3PFC72pxPDppz
	g6aiWZTfwmQqWk79+eFBicj3bPzPyeorIf8prgSx1UXEpnr2ncs7pPqtFVcWeoRXGdyE1EMWpTW
	WMB7DQOVRsAtm0duU5xRM6jruPxzGZ1/aveSyht+2W1UxeNDhuSYeo+zDruQg/gzIPsmNVMJkGL
	2Hatu0IxiSyuwamnWe3rS+jXIeGRBsa48HEFzFkxqICJk5fZOCX4+XXOVoq0x4nK4uBWp8wKxA2
	jWHfFTEt7RJB9EcyX8MyTpEyGyA==
X-Received: by 2002:a05:600c:6216:b0:488:b9c6:11ba with SMTP id
 5b1f17b1804b1-488b9c6139amr12538175e9.28.1775488687443; Mon, 06 Apr 2026
 08:18:07 -0700 (PDT)
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
 <5f37fcf2-05f7-47d3-b412-1515ee19fbea@linux.dev>
In-Reply-To: <5f37fcf2-05f7-47d3-b412-1515ee19fbea@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 08:17:56 -0700
X-Gm-Features: AQROBzCVGekmxn_ylGCv4g1izid6yA-6dhRt8RdAhWujp1DYsrJqn8LTQj2qR9M
Message-ID: <CAADnVQJ6y33kKOPTWvHu-ZNLFa8JOUih5qfv+e-71+W=orBNhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 5, 2026 at 11:03=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 4/5/26 9:51 PM, Alexei Starovoitov wrote:
> > On Sun, Apr 5, 2026 at 9:29=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >>
> >>> For 6th argument JIT emits these two stx/ldx as moves to/from x86's r=
9.
> >> For stx case, we should move the bottom stack value (6th argument)
> >> to r9 and pop the bottom stack slot (8 bytes).
> > That doesn't sound right.
> > Passing 6th argument should not involve stack manipulation at all.
> > No push and no pop.
>
> The following stack layout can avoid the above push/pop issue:
>
>     incoming stack arg N -> 1
>     return adderss
>     saved rbp
>     BPF program stack
>     tail call cnt <=3D=3D if tail call reachable

let's disallow mixing 6+ args and tailcalls.

>     callee-saved regs
>     r9 <=3D=3D if priv_frame_ptr is not null

I guess we can also disable private stack and 6+ args.
Looks like it's a bit in the way.
The compilers will emit
stx [r12 - N], src_reg // store of outgoing 6th arg
call

For priv stack JIT will emit push_r9 while JITing call insn.
But it should push_r9 before stx converts to 'mov %r9 <- %src_reg'.
Maybe we can reload r9 after the call instead of push/pop.

>     outgoing stack arg 1
>     outgoing stack arg M -> 2
>
> After the above pushing (outgoing stack arg M -> 2),
> if bpf-to-bpf, push the outgoing stack arg 1.
> If kfunc, move outgoing stack arg 1 to r9.

Ideally JIT treats subprog calls and kfunc calls the same way.
Why should they be different ?
In the callee, in both cases, the first insn in the prologue
can be 'mov [rbp + ] <- %r9',

so that later 'ldx [r12 + ' can be JITed as-is. Here priv stack
is not in the way.
Without priv stack we can avoid this first 'mov [rbp + ] <- %r9'
in the prologue and instead JIT 'ldx [r12 + ' as 'mov %dst_reg <- %r9'
since nothing will be overwriting %r9.

It feels to me that it's easier to disallow priv stack for now.
