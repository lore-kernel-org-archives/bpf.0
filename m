Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB94B1D0E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748695; cv=none; b=M41W6mUc9yCEHtS09qNz+YX+BGWDtNYWkS+/Itjl1Lw4D61XwJ9EFEm2PlTuFUcqeW5cVtfiJ3kqN35blvm8YXhAzGMMR/hNP1EOq4GD/IzRZucj4/9dGc1ncNspy18nIznMpEGzCr7QaaPv+B2GYvuTYE5R6pbci7gIIuAZcBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748695; c=relaxed/simple;
	bh=imAz1NKwfEGNjHVum+7Yu/fCSNq4z3Ww+t9/A3I472M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7ycFKjomSIZ+oDrpKPr40mIqDKgrXgo3b1PjWeHe517l4DfgBOnSF7D3QnpXdmpvi3u28tkQgHT09N9NTWmONHlybTYWc0htVWKANuSfhReM7FkMtk8F86B7K1W/L5wUSGO0MmQ5khu/UecgGqaPTwdT1o3cThE8NxpZrJu0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdjU38XN; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdjU38XN"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db18fe459dso6062965ad.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748691; x=1790353491; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=H29afRO72eAhfZjCnHiUttxmtQQVvrx3Id9aR1vO2o0=;
        b=RdjU38XNiGyagku6FYGAiYiLzzkHI2trx7rxitKcffXyceyj2FJJ5sTwXXTEHwfMca
         /gABIHOkxHFXDvtWF+LtsUBxOD+kXWG9tEX28PGERASxTZzG2VBH4oBvrNLY7wfIzgx3
         uBXuIeyYEnCUuz/CQ5RnRibPifY526jZcS64EHLitCVbPL6rDa7Edc13f2VBdo0LCbJP
         ecZbsbHIt6uOybW7n6OuZF7FLf68CdKs2qJ290osvxcw+g2VB6+qGajtFrORu9ElGqQY
         zEM3ZxajjPdpJEuLhSP59nCE2jJ5P262qqY+sBJ71GMkkJLWZOouqtIxD31HY71+JK+M
         lTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748691; x=1790353491;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H29afRO72eAhfZjCnHiUttxmtQQVvrx3Id9aR1vO2o0=;
        b=NjXQG3od3VA3AKtJ18XYnhjfx8EMGCYCgM9SWYKf+KYTE/dsVxVVUQ2K8s4NhXL/K8
         fc3Itmy4IL19E2sBktgPUAnBuZ/J+NKHGAVc9hmrk3J91DrWJusyi96L0nMRdyGf2bGJ
         SPNZiryymF/HqcYSVUJ9jL2tnir0CHFIVV/Q/f3TcJmCSYSd1skGCTbdzwPMooRzSAUS
         unsiANXHfIsIKu6iD9AJBdWnFaRGm1bmtvHFckaNuVbjVr6dvHq4Q2TrvDe/elgcD70W
         X0/FwvplBYI3+0IyeaYCH8o9VfAyQg1kSlZFyZ6CMMdkPtfP4GwIueL2NWF5KDlOIDth
         x13A==
X-Forwarded-Encrypted: i=1; AKwUvBxGkMS2T25T3nPVd/g/OEcabYH9rN1c7490pkwibvRZ04zmbQUYqNvm3HmQGgg1kx6exAs=@vger.kernel.org
X-Gm-Message-State: AFuF++kkU8HyDvCQEvs53/Su8N95MPmoduLyOAD6637WVTttpC78iPxh
	7lA0r1uFtPc8IgEBgnFt1bx5MtGKQCbaypFwMqNsArbTM4uekT8+rPQ+
X-Gm-Gg: AYBFou3UKw//osdNXcda1YwX63m7IQwrdRz35132ffYKOORDETUnJuMTWcDHK+IT3od
	zECTGCKT2Je7vhBxA2GQo/nzgEqtsrIA8m0gRnRc5owEiTC9LTGUh3reCZIkbyVNckOp+E6vfle
	449CWoof6t37lYSFUOPweyKBhDK2NeA7YSj0MQe8A4gpxWdAafVzBAmdJ0KdKC5u0SfR6HItm4B
	/LsbogCda0aD9rcGaPSr3sOtsnOPacJbXNh6kWGfJu/0IVmUzNhxLxQL73T+EU8v+fVaTKA8rSN
	F9thVPM2aT+okgX3M14t/A85id8iqaekhsg60yJVEERlxbcBW2uYBlM4wUffThXed+ZCMmiA+Uy
	DjMRwkCfLX0O2TQ9eunwLRn6D2MQx2dl20vkcK9STZbGwoMaCdFKj/ba6uuqH4p63KK5hmU2+gb
	tHKe553sDyFGgvg8CfFAN8StNG6N6sEsLbjxdYAhbs9zFeikKo9bV6P7IL+5nYS+h0pIifSBkuj
	f+ZeOwX/pOVURWad3tJPlZZ2e+DYoGXzrKacyCsjJ9nxsQNBKtecR0j5uB0iZ45h2cM
X-Received: by 2002:a17:903:2349:b0:2dd:c100:4b73 with SMTP id d9443c01a7336-2ddc1005ee4mr2247825ad.42.1789748690750;
        Fri, 18 Sep 2026 09:24:50 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb75819d7sm11084225ad.54.2026.09.18.09.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:24:50 -0700 (PDT)
Message-ID: <f4f90cfb55d6275f552fc3ad619f35ef64901cbe.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: Record raw memory arguments during
 argument checking
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, memxor@gmail.com, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 emil@etsalapatis.com, 	tj@kernel.org, ameryhung@gmail.com, kkd@meta.com,
 kernel-team@meta.com, 	martin.lau@kernel.org, yonghong.song@linux.dev,
 mason@kernel.org, 	ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 09:24:47 -0700
In-Reply-To: <0ddd64a1da65d48b189f5a88ccee3d5544fb503c715d4881bc63b8176cb27a54@mail.kernel.org>
References: <20260918052906.12226-3-memxor@gmail.com>
	 <0ddd64a1da65d48b189f5a88ccee3d5544fb503c715d4881bc63b8176cb27a54@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 06:35 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6c6b8d8520cdf..1d5e4ee64fc00 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>=20
> [ ... ]
>=20
> > @@ -7215,7 +7215,8 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> > =C2=A0	 * raw mode so that the program is required to initialize all
> > =C2=A0	 * the memory that the helper could just partially fill up.
> > =C2=A0	 */
> > -	if (!tnum_is_const(size_reg->var_off))
> > +	if (!tnum_is_const(size_reg->var_off) &&
> > +	    meta->arg_raw_mem.regno =3D=3D reg_from_argno(mem_argno))
> > =C2=A0		meta->arg_raw_mem.regno =3D 0;
>=20
> This isn't a bug, but would it help to say which helpers this actually
> changes (bpf_strtol/bpf_strtoul/bpf_kallsyms_lookup_name, where the
> unrelated variable-length input is checked before the output is recorded)
> and that the effect is to stop withdrawing raw mode from their output
> buffer?
>=20
> The commit message states that an unrelated memory argument must not
> discard the output's identity after its initialization size has been
> recorded. Scanning the existing helper protos, the three that have both
> an unrelated variable-size pair and a MEM_UNINIT output all place the
> variable-size input before the output:
>=20
> =C2=A0=C2=A0bpf_strtol_proto / bpf_strtoul_proto (kernel/bpf/helpers.c)
> =C2=A0=C2=A0bpf_kallsyms_lookup_name_proto (kernel/bpf/syscall.c)
> =C2=A0=C2=A0=C2=A0=C2=A0.arg1_type =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> =C2=A0=C2=A0=C2=A0=C2=A0.arg2_type =3D ARG_MEM_SIZE[_OR_ZERO],
> =C2=A0=C2=A0=C2=A0=C2=A0.arg4_type =3D ARG_PTR_TO_FIXED_SIZE_MEM | MEM_UN=
INIT | ...
>=20
> So the observable effect today is the opposite ordering: a variable
> buf_len / name_sz no longer withdraws raw mode from the arg4 output
> buffer.

Extending the commit message might make sense.

> [ ... ]
>=20
> > @@ -8929,6 +8930,11 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg, u32 slot, u32 p
> > =C2=A0	if (err)
> > =C2=A0		return err;
> >=20
> > +	if (!meta->btf && (arg_type & MEM_UNINIT) &&
> > +	    (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM ||
> > +	     base_type(arg_type) =3D=3D ARG_PTR_TO_MAP_VALUE))
> > +		meta->arg_raw_mem.regno =3D slot + 1;
>=20
> This isn't a bug, but could this reuse arg_type_is_raw_mem() (defined at
> verifier.c:8155) so the recording site and check_raw_mode_ok() share one
> definition of a raw memory argument, or are the two predicates meant to
> diverge later in the series?
>=20
> The new predicate is term-for-term the body of arg_type_is_raw_mem():
>=20
> =C2=A0=C2=A0static bool arg_type_is_raw_mem(enum bpf_arg_type type)
> =C2=A0=C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return (base_type(type) =3D=3D ARG_PT=
R_TO_MEM ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0base_type(type) =3D=3D ARG_PTR_TO_MAP_VALUE) &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0type & MEM_UNINIT;
> =C2=A0=C2=A0}
>=20
> which is still used by check_raw_mode_ok().

Let's indeed reuse the helper.

...
