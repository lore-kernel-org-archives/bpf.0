Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E12F3C18
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775423276; cv=pass; b=t4RTMj7ODf3wk7j99eGE5tqTfO76YhAkXvVvsXoDsMibiAllVO1J5hauklwXymEw+AjrjDYfCOQmL/hKlQIzeAFyRZJuo3MRUjnSBlmdn7UbGP1Nh3RTLFpVySKW8q71q9Dr/XMnyck9im9T6tmSlHzb6bT/k8sAW1T5uNulHOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775423276; c=relaxed/simple;
	bh=W1s3+BTCyDWU8RRXuqs7nN+nbf/gz094wub+edyVqKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXFv0gJ2spRZ2KDEmWhb87AOKpHQ6BFmIq4VdXG8D5iZMj2NJHO95Pn76/nWoERUpyajB5V/bcsBHCVkF2BWEd4OSq5lvI9Z0+I78bMfNH91cDE8nGz277pUHNW2xyJx5SomnD8Uu0HODjW2g7TEFegLEc8t2HvNmpURfPiFkjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQIDFNXp; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQIDFNXp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1978389f8f.2
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 14:07:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775423274; cv=none;
        d=google.com; s=arc-20240605;
        b=AG5Og6EKbu6UtS2UmMR/rwnlp0IBVnR5s9wD5q6flPzxCY9nDYj4/DOexByIEgRkTy
         5eyj8HegM1hmoTq0AExLF6wWa+uxDvIWA9OcMB8dduWxP27Kgd2VXAhW7Ta3SegxY9QD
         JWx/nPKp9SLM7A+ql+efdp55JGr60tXtn5QRASxc9OsNeysfFvHTnRv08V9OPZz2JnjF
         T0QcGEm7UiAWQeeDmN1DdTiwoSLZkk/MU614w2xlRYA5t7SeY/qtmFmPO2cibuAFXARf
         xotTQa/sdGnu/3JwB7AN0f/17QhU1KRtDzOhAtsliZN32Bet8ixVospoLZ7nkNOh5LPc
         6zgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GLj+ibKCkIIANJAGVwUNxNvmd87hkXg9ucEGkWnTYGg=;
        fh=wi89WQjOF2HvnYB0v50Lj11/w784Fae/K3mXW7+OEdE=;
        b=XEzXztPBzeNYQ3TbIUVUxvswGA6wGBW2ovlcG8cKJftIP95jmvoGF3Ho92NiBeUp5c
         RjBbyZVIs1dXdDEcB7ZCifAPLS4veSUzVyRXkyUIi3AcWURv/tPaG1HVVuMxSqjCf6Oz
         d7Upw5CYV5Gyk+3FoExEwp+vtTakSPaOnI2ztBCUWsJ501oELTur02s0+B+U4UHvYbGY
         yGuXBAGpnW/zdWaefPnkb8Tsa9R+6qFUDNsxCGeYAwpK4ey2qibnGMja1kBU4n1i22nf
         gilcnZjEEs/jHn4xa0dUiNEsJgDXBPWtDXM3HVd8Rpss59xCeV9ivF7d3pYgpdvPdmFR
         2QgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775423274; x=1776028074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLj+ibKCkIIANJAGVwUNxNvmd87hkXg9ucEGkWnTYGg=;
        b=kQIDFNXpL9rSy1w0yHhDOTzParPXCHN2aKW9e5W/y2y1++IBUhnCdPRGIVcaithsVD
         FJG85ohx07e5np9X9ziMfIw8+jsCDJq/teH7g3cTX8aCG1ImzesfJgGpdTszac4y9N4O
         +iSWkDth6S6fIkZT813fqWzMbxmttPiskM99G5UZ01LF8H4u+9uVveNiCWF3CAIjsbR0
         DIGOpWgWyEkUFzzdW5jQoxBuQmcdZTz5JaCoBFg+5tsSLxBT/8cU+sJewLSie8RZEq04
         r54FqPwnfPXsX1AtFQXICe1YSxL6uBXpeMv4YAAVjh9CGTlin5z+RvJupgs+/4nG6iTn
         88zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775423274; x=1776028074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GLj+ibKCkIIANJAGVwUNxNvmd87hkXg9ucEGkWnTYGg=;
        b=eCQKucQJbbrSEa/IqcdYdD+y0oeijdrCzVVDf/BRWq01eeBBkyyn7sgYJ+5Egw/S8U
         p9zYeRDM4M444l5K9N4LKBHOrywBAiHD9Qh3xe2UF2uelrhcuAY9c/xeencYEr8TeS9P
         x9vT/jTnRN5HT9IfyiNfsd0mtJNszd8V/Y8qn0q0D0KhwNdwAy8Ow4qfZQl1YKkOczve
         VZlMp6rVYlNhqOBwRPMbzn7+5exTmqRedz8QxaV27jxbC6/9gkM4HQd65CD5rtqE5JHW
         FnOyusQLw8hYwTz4OCjVUNtCqUkTsH3orqW3ANnNPkMZ80U5Dr9rR2RzMbFrSQND4oCb
         OZ9w==
X-Gm-Message-State: AOJu0YxY0dZaSNvFmqvbdA89CEHrtAZUN9CpAkE+VDvmrqcCISVpCE1h
	kG40s7YFDoK5dW7nIaB5+sC4zzAm0F5mFtVnTifdZ1f7a20K6xyKkHeuaX+2keO3PfiGNQI94k7
	3vikqWIeoVa16e/h0gKaKsmn0DjIEuk0=
X-Gm-Gg: AeBDietAUVTE7lci/yT+GxW2FN5HAnG+qlMioNursTYbq5FzdEU0YOds9w7iSQFBndb
	t4p+kptc/gyfW9tKqBf2fku5pGD/zorPTW0LbMsVmN5s5B0uRH6OwRi2pJh13xgtJNeooLinAfb
	I5vTEj+/0+ekrarmzZVGoBbxr1SQvmCN4rDL9ZISxSbGqceF9dYbWi0TvUHfjYxyPHwrv1DU1ed
	K/IhCsbt/URZxcJdj9b+1xyViLOVMxpl/ER0xymorxF1jY0aoUyz1JfabCWmlp05VOctlX88109
	S5o4bGnNTIYPXBvxGQLgHXZKwbr/E5wSnQlOzLRsP1RT/uCdXgNyeDHS7X9w6ldUCSBA8P2KgeN
	Um8+lQz/yDPW01NU+kdzlU8/cvA==
X-Received: by 2002:a05:6000:1a8d:b0:43d:61:6525 with SMTP id
 ffacd0b85a97d-43d292f8aa8mr15319119f8f.46.1775423273965; Sun, 05 Apr 2026
 14:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402012727.3916819-1-yonghong.song@linux.dev>
 <20260402012742.3917613-1-yonghong.song@linux.dev> <CAADnVQ+y1jZZTyNcXghD0UQ+JzD0pEu=icSP7=+QY4b=9dzv7A@mail.gmail.com>
 <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev>
In-Reply-To: <924fde92-d28f-471d-9f0a-0c176958139c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 5 Apr 2026 14:07:43 -0700
X-Gm-Features: AQROBzDrSdMB4HVoyFT_f2WB8-AhPULUu-qCoB0WLhH_UxjLg6c973QU74y9_EY
Message-ID: <CAADnVQJdTffT5sdqZVdWX9W-jG2vPjiPAA0OT3iMPPsY9-KFmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/10] bpf: Support stack arguments for bpf functions
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:11=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
>
> On 4/2/26 4:38 PM, Alexei Starovoitov wrote:
> > On Wed, Apr 1, 2026 at 6:27=E2=80=AFPM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
> >> Currently BPF functions (subprogs) are limited to 5 register arguments=
.
> >> With [1], the compiler can emit code that passes additional arguments
> >> via a dedicated stack area through bpf register
> >> BPF_REG_STACK_ARG_BASE (r12), introduced in the previous patch.
> >>
> >> The following is an example to show how stack arguments are saved
> >> and transferred between caller and callee:
> >>
> >>    int foo(int a1, int a2, int a3, int a4, int a5, int a6, int a7) {
> >>      ...
> >>      bar(a1, a2, a3, a4, a5, a6, a7, a8);
> >>      ...
> >>    }
> >>
> >> The following is a illustration of stack allocation:
> >>
> >>     Caller (foo)                           Callee (bar)
> >>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>     r12-relative stack arg area:           r12-relative stack arg area=
:
> >>
> >>     r12-8:  [incoming arg 6]          +--> r12-8:  [incoming arg 6] (f=
rom caller's outgoing r12-24)
> >>     r12-16: [incoming arg 7]          |+-> r12-16: [incoming arg 7] (f=
rom caller's outgoing r12-32)
> >>                                       ||+> r12-24: [incoming arg 8] (f=
rom caller's outgoing r12-40)
> >>     ---- incoming/outgoing boundary   |||  ---- incoming/outgoing boun=
dary
> >>     r12-24: [outgoing arg 6 to callee]+||   ...
> >>     r12-32: [outgoing arg 7 to callee]-+|
> >>     r12-40: [outgoing arg 8 to callee]--+
> > I haven't looked at the patch itself only at this diagram.
> > How does it suppose to map to x86 calling convention?
> > The shift is unusual.
> > x86 is using fp-N for outgoing and fp+N for incoming.
> > Why can't we use the same?
> >
> This is not for jit. The above transfer is for verification purpose.
> For example, for callee, a load 'rX =3D *(u64 *)(r12 - 8)' can easily
> get the value rX in callee since the value is copied from caller to calle=
e.

There shouldn't be any extra copy.
For 7th and higher argument:
the caller does 'stx [r12 - N]' and the callee does 'ldx [r12 + M]'
and JIT emits them as-is only adjusting N and M constants.

For 6th argument JIT emits these two stx/ldx as moves to/from x86's r9.
