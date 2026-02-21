Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7826E71E
	for <bpf@vger.kernel.org>; Sat, 21 Feb 2026 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771633259; cv=none; b=niyItmRYCm2LsaOUFeSeWts40jCGQloKr3+WoljMKmiFESxBam3VcFvM0r2DuY1UzsOMn6GAZ/5QQfIqLML+2YWp9rar6+SeHdJD3lAogcdY6Hqsp5NiyaaD3MLZ8h+ZeKDF3oLpqWWV2Z3lu4ndYZ9lHZ0iueOODVdEFaKNROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771633259; c=relaxed/simple;
	bh=7/2/JqBPfXeyH8ZPgfj/HCZ121gtUCoggqbKoBY9ArU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWe0hNCmFqyVCkjSlk4bvKKJ8uGFE0fYI9y/3JAB5YE1rPS0pXIxo3qH2cji5esf0RFWYgCRLF5L6fj0e9ZDAA7bo0Y8VClx3rTpWV+sk1MrTyCSQK2tS6vjYc/EJuoxE199PqUimkXh+6MtLJC+7J6QVIhRz8FLSmk9rxWEh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXNPMQ4j; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXNPMQ4j"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1270be4d125so6174816c88.1
        for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 16:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771633257; x=1772238057; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GiXn5KX8iqaLuuyBqa5Y/wVobm9i9h7c0Wdu0exJ1Xs=;
        b=TXNPMQ4jKotsZLzK05JKBwcAiqCikT/guVOR8HegXtxdY0yh1tcNA5w72OhiMdyig/
         hLR14BEEZYt7tUH0JvhW79ONf9VTZJKUC48H8bx4OF6ThzqHr9PFQZjaNr4qMiDAxJ1l
         DRPSNy8bsi5400k6+mU6YTFdufgZMNojUkEKoZM8/C/oeQciCYju9aYb8rOUOtwgG/hB
         yu/FKjdSFIgsfy5XAcyA1XeAwJDsz9EMuNqjO/ynokIPv+dd3RtG5qmPtEgUZWn/q/m3
         Po0ZCnfW8lq/yY96ID1jHYcovb5Tq8xPVfkuoa0tmi/DDMy+49X1jFsOircN3u/0m/Vm
         1vlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771633257; x=1772238057;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GiXn5KX8iqaLuuyBqa5Y/wVobm9i9h7c0Wdu0exJ1Xs=;
        b=uU3TT76KDhEOsngfX2EPM4SImhYEj6lo7677keArMWgOcvj2jR79MXRJCJCtpVcReO
         ZP0+NiTeiumx1bvC5XdGRlrgQ/Rw0w6DJoIuSOGUnfx3XATHkP7JUE+EO8qtzvWosZBl
         KkoDDrZDdo89fytyxVTc5AkG+vkHnL6A+mu54QGHn3qJwVAYZkkLw+q8jIbqJoIRmCoE
         bFGFDI5h9joOT3SuWDICayzHiCY97Pr0vjz0g/gI2A7Gv2auRtda/xIHJXKsoQrlaoTE
         1Ru6OAyPDwUMh3paIz2KPcatb4/uffUuhU/CNaaGKRJ2D9FzwakSbw+qVxOGrmq5r35A
         3HwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVRGpw+ri8zy3EK/aXFIgUYF0jFO+ORLDTkzJ6zqKeiJcnQlTQHUQMoH53AWM3bMLXwPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5y/0WJda1jjqiWIuoJIKKjxxTKGtC8MQL8w7Rp932eYY1VNDK
	ArplDi/hfqMFfRLCAx+ZnWx3OgBNn7fFTWGARd+U4tp/d9E7qPtFXPr0
X-Gm-Gg: AZuq6aL31jHweccJ1xazSkW0kzMRXBKvwwaWYBAgapOtm+b+ixGycsb1h1k+pJ1qV1G
	NbBaAH4+hn6zSoDD4w/L6hzKtbAeXpOse+R0CzPoEqZpOaR7WF440ZDn1gLM+iTUkerF21cWQRI
	JBFdAuauLCEtghfXokc+o6PQ2fclqUDVV0HosE4eZlDHTjeJAAHvzUymNhQvPr9vfTdUpPIx4iJ
	yCsiEg+g5n3WeGJLY0IKkSBMIaVnzXmDacbuf7lrH3gbv+jG6Knso55YzmchX+2Keq7QnTXAGwm
	vbqimfSEFa5xVIIKPc3KWJLEFNEhuB9w8KpogL8Zy8cU9qHxHR8Wn+2cPYgJvT1hrWhFaz1ogOU
	+EhnDF5xbY7QMUQBhGfgZJBtjSp+5E+FP+On+aCoFhk5HOirlN8/FyWQEkcjPqHA8yw19mHcVhS
	cqoK0YkAzTWRTBBzwRX/MjKeqroBoe7gV5caWnM+IR93IpCMCW0esoeUcG3cZOL0WEra+2py3lZ
	bHCupLQ
X-Received: by 2002:a05:7022:618a:b0:11b:9386:a3be with SMTP id a92af1059eb24-1276ad54f5emr813229c88.41.1771633257388;
        Fri, 20 Feb 2026 16:20:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:dc10:521c:4103:cf1e? ([2620:10d:c090:500::1:a80e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af8a657sm983508c88.12.2026.02.20.16.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 16:20:57 -0800 (PST)
Message-ID: <c0ed78441523309a84ac93e962d73f202337fbb4.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 3/4] selftests/bpf: Test refinement of
 single-value tnum
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Srinivas Narayana
 <srinivas.narayana@rutgers.edu>, Santosh Nagarakatte
 <santosh.nagarakatte@rutgers.edu>
Date: Fri, 20 Feb 2026 16:20:55 -0800
In-Reply-To: <1bd78db44bef27d9d7fb549ed3eb8811ee2a5e5e.1771594636.git.paul.chaignon@gmail.com>
References: <cover.1771594636.git.paul.chaignon@gmail.com>
	 <1bd78db44bef27d9d7fb549ed3eb8811ee2a5e5e.1771594636.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-20 at 14:57 +0100, Paul Chaignon wrote:
> This patch introduces selftests to cover the new bounds refinement
> logic introduced in the previous patch. Without the previous patch,
> the first two tests fail because of the invariant violation they
> trigger. The last test fails because the R10 access is not detected as
> dead code. In addition, all tests fail because of R0 having a
> non-constant value in the verifier logs.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Hi Paul,

I have a few nitpicks, sorry for not commenting about it in v1.

>  .../selftests/bpf/progs/verifier_bounds.c     | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 560531404bce..41dd249faadd 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1863,4 +1863,95 @@ l1_%=3D:	r0 =3D 1;				\
>  	: __clobber_all);
>  }
>
> +/* This test covers the bounds deduction when the u64 range and the tnum
> + * overlap only at umax. After instruction 3, the ranges look as follows=
:
> + *
> + * 0    umin=3D0xe01     umax=3D0xf00                              U64_M=
AX
> + * |    [xxxxxxxxxxxxxx]                                       |
> + * |----------------------------|------------------------------|
> + * |   x               x                                       | tnum va=
lues
> + *
> + * The verifier can therefore deduce that the R0=3D0xf00=3D3840.
> + */
> +SEC("socket")
> +__description("bounds refinement with single-value tnum on umax")
> +__msg("3: (15) if r0 =3D=3D 0xe00 {{.*}} R0=3D3840")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void bounds_refinement_tnum_umax(void *ctx)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	r0 |=3D 0xe00;			\
> +	r0 &=3D 0xf00;			\
> +	if r0 =3D=3D 0xe00 goto +2;		\
> +	if r0 =3D=3D 0xf00 goto +1;		\
> +	r0 =3D 0;				\

Nit: make this `r10 =3D 0;`, just like in the last test?
     (and in the next test).

Also, the test works the same if I replace 0xe00 -> 0xe, 0xf00 -> 0xf.
Maybe pick the smaller constants to ease the readability?

> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* This test covers the bounds deduction when the u64 range and the tnum
> + * overlap only at umin. After instruction 3, the ranges look as follows=
:
> + *
> + * 0    umin=3D0xe00     umax=3D0xeff                              U64_M=
AX
> + * |    [xxxxxxxxxxxxxx]                                       |
> + * |----------------------------|------------------------------|
> + * |    x               x                                      | tnum va=
lues
> + *
> + * The verifier can therefore deduce that the R0=3D0xe00=3D3584.
> + */
> +SEC("socket")
> +__description("bounds refinement with single-value tnum on umin")
> +__msg("3: (15) if r0 =3D=3D 0xf00 {{.*}} R0=3D3584")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void bounds_refinement_tnum_umin(void *ctx)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	r0 |=3D 0xe00;			\
> +	r0 &=3D 0xf00;			\
> +	if r0 =3D=3D 0xf00 goto +2;		\
> +	if r0 =3D=3D 0xe00 goto +1;		\
> +	r0 =3D 0;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
> +/* This test covers the bounds deduction when the only possible tnum val=
ue is
> + * in the middle of the u64 range. After instruction 3, the ranges look =
as
> + * follows:
> + *
> + * 0    umin=3D0x7cf     umax=3D0x7df                              U64_M=
AX
> + * |    [xxxxxxxxxxxxxx]                                       |
> + * |----------------------------|------------------------------|
> + * |      x            x            x            x            x| tnum va=
lues
> + *
> + * The verifier can therefore deduce that the R0=3D0x7d0=3D2000. Instruc=
tion 5 is
> + * therefore dead code.
> + */
> +SEC("socket")
> +__description("bounds refinement with single-value tnum in middle of ran=
ge")
> +__msg("3: (a5) if r0 < 0x7cf {{.*}} R0=3D2000")
> +__success __log_level(2)
> +__naked void bounds_refinement_tnum_middle(void *ctx)
> +{
> +	asm volatile("			\
> +	call %[bpf_get_prandom_u32];	\
> +	if r0 & 0x0f goto +4;		\
> +	if r0 > 0x7df goto +3;		\
> +	if r0 < 0x7cf goto +2;		\

Could you please add comment here saying something like:

  r0 is now in a range [0x7cf..0x7df] with lower 4 bits known to be 0,
  first number > 0x7cf with lower 4 bits set to 0 is 0x7d0 with 0x7e0
  following it. Only 0x7d0 fits in the above range, hence that's the
  value of r0. (Or add labels for tnum 'x' on the diagram above?)

> +	if r0 =3D=3D 0x7d0 goto +1;		\
> +	r10 =3D 0;			\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

Also, I think a few more tests are necessary, there are three cases:

         if (umin_in_tnum && tnum_next > reg->umax_value) {  // A
	 	...
         } else if (!umin_in_tnum && tnum_next =3D=3D tmax) {    // B
	 	...
         } else if (!umin_in_tnum && tnum_next <=3D reg->umax_value && // C
	 	...
         }

If I remove 'umin_in_tnum &&' from A no tests fail.
If I remove '!umin_in_tnum &&' from B or C test cases
'verifier_bounds/verifier_bounds/bounds check based on reg_off + var_off + =
insn_off. test{1,2}' fail,
but these seem unrelated.
Maybe craft a few test cases covering these conditions?
