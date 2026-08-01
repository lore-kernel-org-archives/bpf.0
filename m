Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E1234973
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 04:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785559261; cv=none; b=StOcUTS4x67uu5ZiZahqzt//ccjZp5vv0Ynj/bTWguBOOIFDIpl/V4FOmRfjOBtiKCr5lLKTBx47B1aV6qRgqyhBhv0KOFYzuGyCisZGKFLK+8KzqTTHi7UqlJCVIsfO13rRTfWsyTD8W8n1oRJ2Oas3Qi14GCZ/CH8/YI974qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785559261; c=relaxed/simple;
	bh=s3x8pjbfCq9BuAbE1NyeKpd+q3MhGGcJTXsX3MJcqMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cV8Gss+SeiWsx+/peaUGfnbqjLe21DJfiHpumq4XHYk5kuogW42UGmwcNuEfpmJbKsAlqY/D+5ShpAHvm8BNIlopQfIE+Xeima+b4FQxcDCp6a1Xlcmg0FYeE6y5kfpRcfKd9hLbLtrygGkP9jDrBMG2Jt2QaF6WnlDhcQnj+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SiEgMt8i; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SiEgMt8i"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso1496731a91.1
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 21:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785559258; x=1786164058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xrL3kyFlN1rgtn9VZ4SzY44SmT1FcFVaQUll8h6EZ5M=;
        b=SiEgMt8iDsJ6aUzFm2qRcNO6sohCcwNSYmoY5WprDmfnROaP4z+UUOg+dBjvMSgkFL
         2U73KkbVN3g7VQuCGZWwzTwd7WDQIfTMTWBdKxGpeVMwhYAngIEcu0D7mPmSI0UcPF3k
         M8HryOi+YWJLMmt5c55n76c7nTOY2k9cSq8qP9EW1odQarWbq/zIYHw5u43eDFQQpqxo
         YBdWM09isiASPiJ4pcnetJ2ruF1Ime7M5YnAcZdzd7Ek6AprRRBKL9JgDpm0ePzHxxh/
         +8t2u4a0HvVIIeUR4mI3sC5v6bBX8TbRfQu3ff/RDtN/FJgHCZRqxGhmxusx9qi0iWW0
         Laeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785559258; x=1786164058;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xrL3kyFlN1rgtn9VZ4SzY44SmT1FcFVaQUll8h6EZ5M=;
        b=WGgcrxAyla2/iOlpKK5dFFAKm88ExnShPmslM79C4umy0RLAmS7zdlFTuI3403YUau
         12PnLmp/DeGqaYZ2lHsB2/a8IgCBozf+M0Eo4BIOyOcFBeGQbJvvFlrPZiJ85Ay/3DH1
         GTjvwX+n3hiiVdmwEk9xhrmEBPCDJ7ppbxXgCIpcCrhg+KnlqjfOLizJxOLiE+nuPfl/
         9YHfRMhdi1DAUt6VvLYS5CRdEhZIAeMP3KhGqx77XLSfwmM4rN1xC5nfbWMH2GHZMI2Y
         2s5Iv56fID8BeOhoEDDON5+G8H2Pp4j7mEDz8WiFl0J+iTfC5ZqCY25XfQRpgiyB0c7+
         hBPA==
X-Gm-Message-State: AOJu0Yz55vwWsD9Mh7mr26VizzaJoEALoAwdSOjfwyygOc2MneMdLuWh
	VCJ3bVe9yel7CsvItv3y0+/3OusSY/DvbaN+v88pXfhUQz99qW9vjEv9
X-Gm-Gg: AR+sD13Yml9tnUVSqpoJKtOKF3QjEwxUj7cXX83RV84CbJfeCamUIrr1ZY+r58nyI9W
	kKxA4p9vaJMdMEXX+VF+RRiSjR+8FcNN05hwYPDV2AOID1Vr6ZvIIeZZxDiQv0yASaI3eX2fO0s
	E4pHpAk0ZJjHdEjr4vJIoOhZSOG0M06pavYffKsfxhqIotXnASajUHMShpHI8D/BdBKoP4uCyLA
	KK2jJEPKKmZJVN4QM/2zpBfwdmeEMzXDTAyKizlNj+y1qZjncGF75sEtFtKniqpZ0rOhUEzFVFJ
	Nd7a/kAi8idk/o17S3S3qFuzEG54DBt7QujwXLHiZxTrZtm/nTVf2Hj7ZDoyAsokcgBkSt77GzE
	zpUDgocyj539teWiaacEULoUqnTcXYLmgNNDtIkqSZ5+ahyyTud0FU7XqqAPQzqdRkmLFSm9k8R
	J+MQXMVkTSsgScWTGI3qZZAjfAx7+hRkANw6GfJOFNQY43KxPcTXp6v/NQq/RtXhMtIZyNgJ0Tp
	xQnPjSBu0+H5V5RIw==
X-Received: by 2002:a17:90b:1d04:b0:37f:d265:18d2 with SMTP id 98e67ed59e1d1-38fbca2e26emr1649710a91.7.1785559257854;
        Fri, 31 Jul 2026 21:40:57 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb29836e7sm953217a91.1.2026.07.31.21.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 21:40:57 -0700 (PDT)
Message-ID: <47bac1633c1b55d6d8b5bfe7fb47f96b3dae6cd0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] bpf: track upper 32-bit register
 halves' liveness in compute_live_registers()
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Fri, 31 Jul 2026 21:40:53 -0700
In-Reply-To: <20260801013509.50C781F00AC4@smtp.kernel.org>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
	 <20260731-static-zext-v2-2-da4aa161e8c5@gmail.com>
	 <20260801013509.50C781F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-01 at 01:35 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Skipping zero-extension for 32-bit kfunc arguments causes ABI vi=
olations on architectures that require the caller to extend 32-bit paramete=
rs.
> --
>=20
> --- Patch [2]: [PATCH bpf-next v2 2/5] bpf: track upper 32-bit register h=
alves' liveness in compute_live_registers() ---
> commit 2a034896228b7579bf93bf8ae2024cee100ebcba
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: track upper 32-bit register halves' liveness in compute_live_registe=
rs()
>=20
> This commit extends compute_live_registers() to track the upper and lower=
=20
> register halves' liveness separately. It updates compute_insn_live_regs()=
=20
> to track these bits and infers whether the upper half of a parameter=20
> register is used by a kfunc call based on its BTF type size.
>=20
> > diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> > index ff1e68cc4bd1c..d0bd94c60fee2 100644
> > --- a/kernel/bpf/liveness.c
> > +++ b/kernel/bpf/liveness.c
>=20
> [ ... ]
>=20
> > +static u32 call_use_mask(struct bpf_verifier_env *env, struct bpf_insn=
 *insn)
> > +{
> > +	u32 i, use, size, reg_params_num;
> > +	struct bpf_call_summary cs;
> > +	const struct btf_param *p;
> > +	const struct btf_type *t;
> > +
> > +	if (!bpf_get_call_summary(env, insn, &cs))
> > +		/* e.g. a bpf-to-bpf call, assume that calls use full 64-bit for eac=
h param */
> > +		return mask_widen(ALL_CALLER_SAVED_REGS & ~BIT(BPF_REG_0));
> > +
> > +	if (cs.func_proto) {
> > +		use =3D 0;
> > +		p =3D btf_params(cs.func_proto);
> > +		reg_params_num =3D min(btf_type_vlen(cs.func_proto), MAX_BPF_FUNC_RE=
G_ARGS);
> > +		for (i =3D 0; i < reg_params_num; i++) {
> > +			t =3D btf_type_by_id(cs.btf, p[i].type);
> > +			if (IS_ERR(btf_resolve_size(cs.btf, t, &size)))
> > +				goto fallback;
> > +			use |=3D size <=3D sizeof(u32) ? reg32_mask(i + 1) : reg64_mask(i +=
 1);
>=20
> [Severity: High]
> Does this break the C ABI on architectures that require the caller to
> zero-extend or sign-extend 32-bit parameters passed in 64-bit registers?
>=20
> By only marking the lower 32 bits as used for smaller parameters with
> reg32_mask, the upper 32 bits are marked as dead before the kfunc call.
> Consequently, the verifier computes zext_dst =3D false for the instructio=
n
> that previously defined the argument.
>=20
> This causes the JIT to skip inserting a BPF_ZEXT_REG instruction to clear
> the upper 32 bits on architectures where bpf_jit_needs_zext() is true,
> such as s390x and PowerPC64.
>=20
> If a BPF program computes a 32-bit value and passes it to a kfunc expecti=
ng
> a 32-bit parameter, the kfunc might operate on garbage data in the upper
> 32 bits.

Ok, I misread the original logic:

  static void mark_insn_zext(...)
  {
        ...
	env->insn_aux_data[def_idx - 1].zext_dst =3D true;
        ...
  }

  /* mark_btf_func_reg_size() is used when the reg size is determined by
   * the BTF func_proto's return value size and argument.
   */
  static void __mark_btf_func_reg_size(...)
  {
	...
	if (regno =3D=3D BPF_REG_0) {
		/* Function return value */
		...
	} else if (reg_size =3D=3D sizeof(u64)) {
		/* Function argument */
		mark_insn_zext(env, reg);
	}
  }

Meaning that the function parameters were always marked for zero
extension. This is also confirmed by ELF Application Binary Interface
s390x Supplement [1]:

> =E2=80=B9simple_arg=E2=80=BA: A simple_arg is one of the following:
> =E2=80=A2 One of the simple integer types no more than 64 bits wide. This=
 includes
> signed char, short, int, long, long long, _BitInt(=F0=9D=91=81) with =F0=
=9D=91=81 =E2=89=A4 64,
> their unsigned counterparts, _Bool, and any enum type. If such an argumen=
t
> is shorter than 64 bits, replace it by a full 64-bit integer representing=
 the
> same number, using sign or zero extension, as appropriate.

This is good news, as it makes changes to liveness tracking much simpler,
there is no need to inspect BTF after all.

[1] https://github.com/IBM/s390x-abi/blob/main/docs/lzsabi_s390x.pdf
