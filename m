Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9D3612EC
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 05:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115937; cv=none; b=mhMb4nXDo6DmNv0sNtdR4ylONB+bos00uCRO1cWeVH9qKhj8BCdbcqP1Ckka4sZbF+Hz7xBujSymQvV5l0zsIXoSpv+26BiDhjNogSz9PGePSYqXmf2qC2f3a0aFaHa/615LKPERuB61kvyUSTE2/+Af0mlOdwnqfu6XLCXNEII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115937; c=relaxed/simple;
	bh=ESVl2l+jCjGfwzTUm5kjJLy66cWwvSgAKIr9oR5taao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OD5MyXQxNDvMs6yp7TKWXJxmchSK3mvo+ea1gjTJGGdjeXQpNIIZZp/XsfuGbSWYTSvBgNz0vpWuaEqFgsn2WBCpMduiKX0hZOEUBja9TEEqYCHalvltuSq+ciVxw1WDIDLD+iPSAZXjgUDkZTKQ8zrFknUa05JITaIqst4775w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeCg+rlF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeCg+rlF"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso469497a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 22:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787115936; x=1787720736; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UNb9D6xoKPP/4uKuy81gSrLLYpF2N2DZ3ii3QwO65zM=;
        b=LeCg+rlFkaKuA7ez3c/YNMT/DkmdKaLXr3GwNXHeYDAN8uZRaqIayGpN9HsuLMvAli
         8zvqPB4geM8CuI4fKVccWPmNk+LJ2bH9cLx+sPFHRAnisaedCfs6mb51zf03Uk/D08Vb
         aYW18vWiCvlsYEnUS7uPIZZ/0WEq57kbzA+QfT8/HTkeRdaJ/qmnmgaszqsy81wD+pR+
         q9xVQyHskJ+DcNAbJ8hst6Zzh1qAaBdIXxsALfFrit+wGhyYOdUiTSuM8JaK7h9Q5UTO
         Fhj2sYOsr3qCRtEtlu2kIBNnfi3UmrfYS37iekpOtTY4KeJeGOQdiJPi6rhgjGrKyse9
         lQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787115936; x=1787720736;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNb9D6xoKPP/4uKuy81gSrLLYpF2N2DZ3ii3QwO65zM=;
        b=Uy+wY/8+txoDVDN9Unoc9omLZfjUrultzcO+7e8/L+4Hq8G5yPULDkPiBS54GcWi6c
         6vXtdA8giLzwzzNVvaDjGYHIhniQkD+Cos2fuuSmyjn9W8N4d6qq2Z6kFQmr3iszJbKF
         jKSxdr4158hoMyyp5V+qjzb+QfYc5QhuYMFOu+qmAs1GQcvrdRJhiv4ZhXbFu2bGdlGf
         CpXIJJOUUrjg/KICCIRNbwsjN1yGb41fiHCi/4zSxXlb/bc9c6usrd2hUCYlCqIwKTOV
         N5UKAeTsAhNqTVVb5fQfZJ5tK8OSXI8eB6HZcrSuPDpB3rJcqXyWj3KXDYYBujzhuIKD
         4Lsg==
X-Forwarded-Encrypted: i=1; AHgh+Rqac+rcGJuZYi4udhLoTobd6hX5bH6gLYkZ/ANDSwvykY8kcfloGYozEAX4sTmfuXijsvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+7YJcvhnYA6GA8dUcmlPUaN589+21g5w4JL8GrSvV98DaCPO
	GwmzU0E+tnEBnRtlFKD7LprDy4pis+08tSkSTiiw4tw/2OpVBw3X/5fh
X-Gm-Gg: AR+sD12DafmYGyW+yr4GPO6lrEKH24ll4g72bxxNEQgIegpQohD+2uuAFA9Y+oXVoE3
	ruazaqWvTguVgU2Zgs/7MgiKkfX/NTol8L91HUd86bHkMYgjWPPiU77GEOsfjzlp1DdkWN9Fxxy
	haCG/r69fyjtFcTMyHOoEcyw+UcJnRKc9lC2aQYyiuRaLWWGTTTFQ7EW4aUvDiKrnGGUBOOrW4+
	HJBAVx3Nii+uqAFc29j04NYicZkivusrIethNtokGX6dpQXGROZmU17GnlFVwYBjb/1YHZpbofz
	9X7Q6WDAYi7OPFAGg/i0UdHZMBJmsLcJYr0Fa9/lRqVlbnYu8B5AUR/HYBwPHoqtdwETVTHEqi0
	MONUZQU+vUqG4kX9VJTn2WaqWBcdPyny1J+XTRAb+Zjpxjm9dhskvaNIZDFjXHS/2nzvbfcw5Ia
	S6PXST0zWl25CI+HYz01A5Cypm48B6dS8hNPpdUytLR16BnCKWnKVOJzOZnwIvEnJlSc2w4Inuo
	FddwAzfd9O5HE5g
X-Received: by 2002:a17:90b:4d83:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-39580a91ad5mr3710120a91.2.1787115935585;
        Tue, 18 Aug 2026 22:05:35 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fc82965sm390147a91.4.2026.08.18.22.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 22:05:35 -0700 (PDT)
Message-ID: <54bed44859f9de519c56ed0fb9366160f625fce7.camel@gmail.com>
Subject: Re: [RFC bpf-next 4/6] selftests/bpf: cover low-32 subreg-equal
 link for zero-extending movs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 22:05:32 -0700
In-Reply-To: <20260814231945.3884596-5-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-5-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:

Nit: let's keep all tests for this feature under verifier_linked_scalars.c.

...

> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 1a273e416fed..6169a61269b2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1516,7 +1516,15 @@ __naked void sub32_full_overflow(void)
> =C2=A0SEC("socket")
> =C2=A0__description("32-bit subtraction, partial overflow, result in unbo=
unded u32 bounds")
> =C2=A0__success __log_level(2)
> -__msg("3: (1c) w3 -=3D w2 {{.*}} R3=3Dscalar(smin=3D0,smax=3Dumax=3D0xff=
ffffff,var_off=3D(0x0; 0xffffffff))")
> +/*
> + * w3 =3D w0 forms a low-32 BPF_FLAG_SUBREG_ZEXT link, so R3 carries an =
id here
> + * where it did not before; the bounds are unchanged. The id is determin=
istic
> + * (raw asm, same bytecode in every flavour) so require it rather than m=
aking
> + * it optional -- otherwise the assertion would still pass if the link w=
ere
> + * dropped again. The delta suffix is left general: log.c prints ->delta
> + * directly after the id with no separator when BPF_FLAG_ADD_CONST is se=
t.
> + */

Please cleanup LLM generated comments. All that changed here is 'id' for R3=
.
Is it important for this specific test to match the exact regex?
Given the intended purpose of the test I think that the above comment is no=
t warranted.

> +__msg("3: (1c) w3 -=3D w2 {{.*}} R3=3Dscalar(id=3D{{[0-9]+([+-][0-9]+)?}=
},smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))")
> =C2=A0__retval(0)
> =C2=A0__naked void sub32_partial_overflow(void)
> =C2=A0{
> diff --git a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c =
b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> index c80747c16bcf..2cc6f9e45aff 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_linked_scalars.c
> @@ -711,4 +711,119 @@ l_exit_%=3D:							\
> =C2=A0	: __clobber_all);
> =C2=A0}
>
> +/*
> + * A 32-bit zero-extending mov (w7 =3D w6) from a source with unknown hi=
gh bits
> + * shares only the low 32 bits (w7.lo =3D=3D w6.lo, w7.hi =3D=3D 0). A l=
ater narrowing of
> + * the source's low 32 bits must propagate to the destination via the
> + * BPF_FLAG_SUBREG_ZEXT (low-32-only) link. This is the pattern bpf-gcc =
emits when it
> + * reuses "w0 =3D idx" for "return 0" on the idx=3D=3D0 path of a callba=
ck.
> + */
> +SEC("socket")
> +__success
> +__naked void subreg_eq_zext_mov_narrow(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;		/* r6 =3D 64-bit unknown (helper ret is unbounded) */ \
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;		/* r0 =3D unknown high bits */	\
> +	r6 |=3D r0;		/* still 64-bit unknown; makes it explicit */ \

Why the second bpf_get_prandom_u32() call is necessary?
LLM got confused by the _u32() in the function name?

> +	w7 =3D w6;		/* 32-bit zero-extend mov, wide src */	\
> +	if w6 !=3D 0 goto l_out_%=3D;	/* w6 low =3D=3D 0 on fall-through */ \
> +	/* w7 =3D zext32(w6 low) must be 0 here */		\

All three comments above can be dropped. What should be commented on
is that `w7 =3D w6' forms a link and `w6 !=3D 0` propagates ranges through
this link.

> +	if w7 =3D=3D 0 goto l_out_%=3D;	/* provably 0 iff linked */	\
> +	r0 /=3D 0;		/* reached only if w7 not deduced 0 */	\
> +l_out_%=3D:							\

Nit: please prefer `2: goto 1f; 1: goto 2b;' style labels.

> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/*
> + * A 32-bit zero-extending mov (w7 =3D w5) whose SOURCE is a wide ADD_CO=
NST-linked
> + * register (r5 =3D base + K) must NOT disturb that source. Forming the =
low-32
> + * BPF_FLAG_SUBREG_ZEXT link on the destination would need assign_scalar=
_id_before_mov()
> + * on the source, which clears its base+delta link -- and a combined
> + * subreg+delta link isn't modeled anyway (sync_linked_regs() skips it).=
 So for a
> + * wide ADD_CONST src the mov leaves the source's link intact and just c=
lears the
> + * destination.
> + *
> + * Here r5 =3D r6 + 3 (ADD_CONST, wide). After the mov, narrowing the ba=
se r6 must
> + * still reach r5 through the preserved link: r6 in [0, 10] =3D> r5 in [=
3, 13], so
> + * the guarded div-by-zero is unreachable. Had the mov cleared r5's link=
 (calling
> + * assign_scalar_id_before_mov() unconditionally), r5 would stay unbound=
ed and the
> + * div would be reachable (rejected).
> + *
> + * Note this is a no-regression guard rather than coverage of the new li=
nk:
> + * before this feature the wide-source path also left the source untouch=
ed, so
> + * the test passes either way. What it pins is the choice not to call
> + * assign_scalar_id_before_mov() unconditionally.
> + *
> + * Written in asm so the bytecode is identical regardless of the host BP=
F compiler.

Please try to make the comments less verbose.

> + */
> +SEC("socket")
> +__success
> +__naked void zext_mov_keeps_add_const_src(void)
> +{
> +	asm volatile ("						\
> +	call %[bpf_get_prandom_u32];				\
> +	r6 =3D r0;		/* r6 low =3D unknown u32 */	\
> +	call %[bpf_get_prandom_u32];				\
> +	r0 <<=3D 32;						\
> +	r6 |=3D r0;		/* r6 =3D full 64-bit unknown (base) */ \
> +	r5 =3D r6;		/* r5, r6 linked (shared id) */	\
> +	r5 +=3D 3;		/* r5 =3D base + 3: ADD_CONST, still wide */ \
> +	w7 =3D w5;		/* 32-bit zext mov, wide ADD_CONST src */ \
> +	if r6 > 10 goto l_out_%=3D;/* r6 in [0, 10] */		\
> +	/* r5 =3D r6 + 3 must be in [3, 13] here (needs the kept link) */ \
> +	if r5 > 13 goto l_err_%=3D;/* taken only if r5 not narrowed */ \
> +	goto l_out_%=3D;						\
> +l_err_%=3D:							\
> +	r0 /=3D 0;		/* reachable iff r5's link was cleared */ \
> +l_out_%=3D:							\
> +	r0 =3D 0;							\
> +	exit;							\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}

...

Given the changes in regsafe/check_alu_op/sync_linked_regs,
I think the following cases are not covered:
- regsafe: a state whose register carries BPF_FLAG_SUBREG_ZEXT must
  not be deemed safe against one without it.
- check_alu_op: a provably-u32 source takes the full-equality path and
  must not be flagged ZEXT.
- check_alu_op: a self-mov w6 =3D w6 must not generate a self-link and
  should clear dst's id.
- check_alu_op: a ZEXT-linked source must survive
  assign_scalar_id_before_mov(), so a chain of 32-bit assignments
  should preserve the id and the flag.
- sync_linked_regs: no propagation when reg has ZEXT and known_reg has ADD_=
CONST.
- sync_linked_regs: no propagation when known_reg has ZEXT and reg has ADD_=
CONST.
- sync_linked_regs: low-32 reconstruction must still propagate when
  both reg and known_reg have ZEXT.
