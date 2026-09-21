Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB04CDDFE
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007905; cv=pass; b=r9zzLlWTndDlNVJycxrjryNzgTConjNkVoDI9YR5o6rRhGazK7qddF2OelS2gC1GyYBOjGid90Frj0kE4JS0XljfmbkobnfT8kRqCOXdpgdcVEj/y4t6rdatUAbDHRYAimdWjvCD4udy5PEbiLoHbLiaK7hQUNKLaokwMAVzvNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007905; c=relaxed/simple;
	bh=tQzdD12zrT7V7gvs7VjAz44916mnPRGWzcIJa1GNvs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+x9rlQpr/1cZPvDMQH2nk0oIy/CAKn89AlXlT68CfOqzc8a2SIHMcu0P05/zy4/acYBuQmo9N1ZdStgnhAkaW/znznQLkzaodS43t9J4/dVLkW9Pv9KlphfYyL1nLucIfjPtL3dzgOl/X3N0RvHhTI3mNi6yTfc8tPrn+9wz0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzXQzUD9; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzXQzUD9"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e50968489so2929497d50.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 09:25:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007903; cv=none;
        d=google.com; s=arc-20260327;
        b=Iu+zA4Tt2BNVhT3ffUM7v+BOMz2LlZcqr/EHe/BSrXF7cva19jDf7yygo7NCSzTzYO
         Fr8CV/2qAZ7HPAclvT9F00xqTu9EuzXPCOcZHXIgzg3f9TzTJXnyH+jgc9RXFTJm3GUt
         bmIQtY8flI+7bB7ronlcZRCUCzLp62CMjO0Hj4R3zuCavQid4HPbJV3xupPDrsP28dWZ
         FNDys/EvBP66wIg6ZMV9RAYvo3uoMWDJRpL7gYClRsBEfj7vTrYbIfGETMG/20u38x1G
         eJlvxZWY7PXKX9TAqWjoF80vGphpLg/UVLp1MfB7A9q3WE5jb5Z018rqR856MqPHE5cQ
         werg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        fh=XyNoAWnAgfOuYe+SHH8a1AKhdxxzhlufrWHJcwOZt/I=;
        b=GFAGBd0K71phQ61EUNbGsqRrG2KMyVOnhgftZUVF7aiHC7K8hvnyPk2Nw9h07oBKDF
         oK6nbR7Mi/D0IZSOyHSRXhotZ4ueSuC0zh4G7fC1Zyrn/NSorTwmr77KeLhVnmB+vmXf
         c7kN9aB+2jRoBhgvjmm8ErEJgCmG8C5UqKu60CWPnGYAf5AyDjR0uNTf0X6iK18lDsIU
         dGqbcdpAZYjnYEOVoYim1FqvI5vXJvO01XswThd1hPTOHc5jTcDgsdncvWbQggwLoJeY
         evYd6ZCGixwSVRrHCoeb1r4qQnHoRq2Nvz3l6CWDGCTDAZ5yc3ap/8dYm78v4p35Vbxp
         ZzRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790007903; x=1790612703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=dzXQzUD9aQp+/l7NVQZpQWmwtie/4d36Ok64i7dmRhWmPyDvJsinw+jEZWspg54Eoe
         BQ4FHr0VznKmfLdR2p1CggwWijyS20mf15xLId08dKkZ+w6HHBd4Qa6zZmvB1shN35DU
         R/hVdgclw6I1loxNb0g1ZrgDfOs/3F5I2YrWHb/YucecdPS5Q9fReo016uHWJXBop0DQ
         pA8cBhxobYaoibgg3sUr2rQSWIuDVBZezSygK63JpmuYto+f9B/eTlsL+beRfzKRtHSl
         uB99Oo6S3bL2+CSEse+FN4TJJk7s/C0P6DPCyxQmLuIfxpg6g1Ud+mIihsHy+h1p3iF5
         rVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007903; x=1790612703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FscOTKf6GX9LsYtYTRZ38iEWAQ8+A7NhnQp2GLbb0QM=;
        b=RI/5FVTTGbkdKZOF1m+b1bRa9PlX+jGjHSqQVBulx/Q8QHNsOY4URwgDFkDN3XT+fQ
         dtKANxrK0eGTT+BM5XF+1qFgDtta9LwNmWwjD6pzohW3cDwzQkmL0bdKfU7LAkEp8Ugh
         3xnXx4x8vAbH1Z5z1+yP7OmH4v5ECnhrjMGRdh2LmSVPuwavQCUkv/DzQVEUiFIJYALi
         phpDXptKdLLlxezcVZVUlaJBsZ8uplpmCkAj9AzJvyoIXkVMPy8q6OSQAMByPwbZBKq9
         ggayVFcPBtzjxEaEXkwTOYx459CsEGKhGbvNlw79ZhV+ekzVVga6emA6oJVtt5YM+HMq
         lmtg==
X-Gm-Message-State: AFuF++lGvNVIVk/ilK/tqRk4/B9s2g1MGHt9d4tPISJx1zXJM5P0cRzJ
	Z1ovJ1IOLPiznmw+1rWFPVIMiQ7OgBbvfWmOmLyIHJVBixkAQa6qIuUz9xp13dDVil5NEZDxzYs
	qmkL+q6iHTO99e6jEaDOpiUkKKXFZUSC3UA==
X-Gm-Gg: AYBFou0Obs4KcM3MZ6TJwmK3nQ0KzfTzKM9PfiX/6je27sb2BJEi4LJOjcuOYOZ1REB
	THJCZjgLWC29AnbCZSQIqYlvR7duiX3nx1nmRIDtOAvYDHV2vbP3Cc5GxHDAVe8Cl2495t4EJ1S
	V9CiYuZBFho9KCQRfZn83LQHdfRy95Rci8XmGqPNHvCqoBQONxanoUQu+UFCTWonyGxfdzJ32N3
	Np3c5XGTPFtwiB99PYnEKgL5Iewg/MnkvtXVrk4R6ri0pM1HksCXaCBXAnYN3oe9RNs12C4bqfR
	hoohh+dAX3jdN0ZJp/VDicmWeDy/8qGNJjJWHF6Tkc5QYYnRPj7/+53iIodft5kOtjqRyw+xHHc
	UP+eCQfE/l6+ypEwRSGU0/oRjXq6vdqlDtJFSLinJrVwx9PXf54hF8VglsXZ6a1+v3rjeRt5Sv1
	4e35FptDOZVsO9M4gmevngPr0=
X-Received: by 2002:a05:690e:c4e:b0:672:be40:5eaf with SMTP id
 956f58d0204a3-672be40629dmr713487d50.54.1790007902724; Mon, 21 Sep 2026
 09:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904195132.141068-1-sidchintamaneni@gmail.com> <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
In-Reply-To: <DLKORFKGW8D8.XVSVVIH3Q6Q@gmail.com>
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Date: Mon, 21 Sep 2026 09:24:51 -0700
X-Gm-Features: AcwNN1VSvI94aKmDMDlc9C_7_9UyySkBSsqPddt2OeIwAs5C5fHNExBLC9Hitxg
Message-ID: <CAE5sdEgLFFcsQ8rpraQ4L-EvppqxUn+=ZdHFgker2Wd--EGL6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/7] Fix timed may_goto with private stacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, rlmenge@gmail.com, 
	hargar@linux.microsoft.com, apais@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<SNIP>

> I think we can keep this fix local to x86. Would be less churn in the end=
.
>
> The problem is that x86 switches the BPF frame pointer from RBP to R9 for
> private stacks, but the trampoline still uses RBP. arm64 and powerpc64 ke=
ep
> using X25 and R31 respectively for both stack modes, so their trampolines
> already use the right frame pointer.
>
> Instead of changing the generic fixup, can we resolve the pointer in the =
x86 JIT
> when emitting the call to arch_bpf_timed_may_goto()? We already know whet=
her
> priv_frame_ptr is set there. R10 contains the offset passed through BPF_R=
EG_AX,
> so we can emit:
>
> /* Private stack */
> leaq (%r9, %r10), %r10
>
> /* Normal stack */
> leaq (%rbp, %r10), %r10
>
> Then remove the LEA from the x86 trampoline, as patch 2 already does.
>

make sense! I thought that the remaining arch's have a similar private
stacks approach to x86. I'll give it a try and re-spin the patch.

> This gives bpf_check_timed_may_goto() the same address used by the genera=
ted
> loads and stores: the BPF frame pointer plus the counter=E2=80=99s stack =
offset. For
> normal stacks, we just move the existing calculation into the JIT. For pr=
ivate
> stacks, we use R9 instead of RBP, which fixes the mismatch.
>
> The existing save/restore of R9 around the call should stay. We also leav=
e RBP
> alone, since it is still needed for the native frame chain and unwinding.
>
> I haven=E2=80=99t tested this approach, so it still needs checking with b=
oth normal and
> private stacks.
>
> pw-bot: cr
>
> > Siddharth Chintamaneni (7):
> >   bpf: Fix timed may_goto stack pointer for private stacks
> >   bpf, x86: Use resolved pointer for timed may_goto
> >   bpf, arm64: Use resolved pointer for timed may_goto
> >   bpf, powerpc64: Use resolved pointer for timed may_goto
> >   bpf, riscv: Use resolved pointer for timed may_goto
> >   bpf, s390: Use resolved pointer for timed may_goto
> >   selftests/bpf: Test timed may_goto with private stacks
> >
> >  arch/arm64/net/bpf_timed_may_goto.S           | 12 ++------
> >  arch/powerpc/net/bpf_timed_may_goto.S         |  8 ++---
> >  arch/riscv/net/bpf_timed_may_goto.S           | 13 ++++----
> >  arch/s390/net/bpf_jit_comp.c                  |  6 ++--
> >  arch/s390/net/bpf_timed_may_goto.S            |  8 ++---
> >  arch/x86/net/bpf_timed_may_goto.S             |  6 ----
> >  kernel/bpf/fixups.c                           | 19 ++++++------
> >  .../bpf/progs/verifier_bpf_fastcall.c         | 30 ++++++++++---------
> >  .../selftests/bpf/progs/verifier_may_goto_1.c | 17 ++++++-----
> >  .../bpf/progs/verifier_private_stack.c        | 19 ++++++++++++
> >  10 files changed, 75 insertions(+), 63 deletions(-)
> >
> >
> > base-commit: d761934c9483ecde93fe99d8705282f716dfee50
>
