Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52E1F30BB
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669694; cv=none; b=Y9RugyyOa8p4LhJAdRsWosDMY1FYR+VgZ8KeYRAkXzkn4jpkAPULM4GyFYtgfzyx6glidUMA12NJ9ifR736otxgiQoxTzqKLmF6BIFHZq4g+86Ql+Stk0sdaiyOcl2jCw70sr2Ee6dMXiuIuvhPhBRReGy5IumMkxwidE3IQWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669694; c=relaxed/simple;
	bh=SAx48VPpjV1C3AuUQ2meuLcGqLHTYa9IkFEkWSYx9ak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmJx3+2LvXdZMwQCcY2wYdq5lszImVmx/bKUTgeJ7iDR+2SSLO/3uH4ge/fkOv1dgTF/X2BawF8lbb1XY/dR+kv2zRLh2Ezg8Yz+NcXofZgkv+AZ2n1wxiV4iL958DiKwYx9gN50lYPJgreZC8sxf1tkKf/iSAm7zbcFfFry/04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGcWG6t2; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGcWG6t2"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so2332025a91.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785669693; x=1786274493; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bek7NZHZI39nYrjpJV/gsIRm/qNeyP8rpucs5jMbA8c=;
        b=VGcWG6t2yglWSpOFmCtmfeLpYHaS6laA6m3x73sE1C8k69HdT7NNzyhBZ8NU7BOi/4
         BAizjLMVRPd+DAvDGtHZn6JdKG5XwK3kcvC71GwtNUt5SOfMx7EGqhWfFSWgyavWYMfT
         OXYw0iiJCEc4YT7NQimtt86yJ/Yc3Z90ZjEs65UMN41RrA/cu70u7cmsjiwQA9EDwO2l
         J3uWEy2sdfPnrDOuI7pKnhq/L5aKff8nApkb+0T/RZWIEtvpeSz5bOXRPTS5gJDukYVN
         CU54/hGgP1M6I+zy5uZwcrAM+Q2Lh1mkCgIsEfi44Q7kA8HKNcwUMI9yXm9Cj645Y3K1
         MnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785669693; x=1786274493;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bek7NZHZI39nYrjpJV/gsIRm/qNeyP8rpucs5jMbA8c=;
        b=F0YkUkCAmQ6kBv1GfIQozt1MqytZveaiUlFRreLxt9FnC39MFLNs5mMK3fwK6lmU78
         nK57x9Ww4cSCXHXuUEesFmqvdlUDU+lQBcI6yeyA4NVCe5ZHzun7V0rWB1vLa9y2gwxp
         tpUWUF2ulFjlD9YDs0HyIzE6W1UyzUD5Vw+1o38nabUYnDN9mRXTf43RQekUO8bNkTm+
         vZKpMCtsJkHnXldUMziZsWg+7it40PDBtAPrKqUDicZ7D7qxXP5WGV/l7AxYQnPF8gyQ
         zfkBWbEwjG2J8yrfylFHl/ZY1/y7Vb5JCm+9+YH0HQXRqPVW9RH0KZOGWjVsTQSBEUfr
         XYVg==
X-Gm-Message-State: AOJu0Yy5c7w6D4JPenGbJn+6rBex4/oZkIucyb4tKoeyTCDIzErNEZjM
	u7ylnMxvyL50Sb4UPz6/2gcFxM7M9QZdBLQoj+PsMo7eBLPiUlgeHRwi
X-Gm-Gg: AR+sD13yolqMLwmhO2QcTxAIjqr9PuieHF9GqqyXM65zpLe2+w9bVubLXSO4RLU0eIa
	zfnoaEWjYgfjDzMjJAR7QmBTgVLD4juCoY/4J8cp7dH+LASSyrb7X/qqkE9L0N1aMft5agBgPj1
	zb4+glTzZwm/j6ywYy0Qh1FqZMV5aXJjUT/JkH0g35zJRAMyNXWD1B88ddRycCma+xw6jQW3g+5
	35D+AD85x9/50CZllF/X4rdjUf81iRVhMwlTK+wnnH+EVoZqomcfP9VY7fcuvIgm0Wbilxherpc
	S2zV3WM+8DiaBczpVmDIi0x6t/yBKzfO6shev+qsjX087reGriLLci9nJSLH0pm93lwfD7HTW//
	qvntw6OuuXaeZZ9Z3Ks9WEd9sjQV9y9BB2reaBEpfoAzASg2vos8iSqwep+Dp/UGVhKppXyg20l
	H+HuIEe3eiJqxAGUK2gG7eEnbJNjGDruRMmHDu3CcN0A28XJ4HH9QzuMoBDOp2xpmzCXtW2O00m
	dBvgBF2ThtFdwbQ
X-Received: by 2002:a17:90a:dfc4:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-38fbc409a15mr5983638a91.5.1785669692687;
        Sun, 02 Aug 2026 04:21:32 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30a3c75sm2723278a91.9.2026.08.02.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:21:32 -0700 (PDT)
Message-ID: <c4f702276cffa8d133bea614a9eac94164357870.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 4/5] bpf: simplify the bpf_is_reg64()
From: Eduard Zingerman <eddyz87@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Date: Sun, 02 Aug 2026 04:21:28 -0700
In-Reply-To: <20260801013453.2B6081F00AC4@smtp.kernel.org>
References: <20260731-static-zext-v2-0-da4aa161e8c5@gmail.com>
	 <20260731-static-zext-v2-4-da4aa161e8c5@gmail.com>
	 <20260801013453.2B6081F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-01 at 01:34 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] `bpf_is_reg64()` incorrectly identifies 32-bit `BPF_PROBE_MEM` a=
nd `BPF_PROBE_MEM32` loads as 64-bit defining instructions, bypassing expli=
cit zero-extensions.
> - [Low] Stale comment referencing a deleted parameter of `bpf_is_reg64`.
> --
>=20
> --- Patch [4]: [PATCH bpf-next v2 4/5] bpf: simplify the bpf_is_reg64() -=
--
> commit ee97fd37754941b6dd81dccf5f68e7f82c74ea6d
> Author: Eduard Zingerman <eddyz87@gmail.com>
>=20
> bpf: simplify the bpf_is_reg64()
>=20
> This patch simplifies the bpf_is_reg64() function by removing unused
> parameters and code paths related to BPF_JMP instructions. It also
> streamlines the condition expressions for identifying 64-bit registers.
>=20
> > diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> > index 6125598d16a84..ac0a388b40218 100644
> > --- a/kernel/bpf/fixups.c
> > +++ b/kernel/bpf/fixups.c
> [ ... ]
> > @@ -44,6 +44,42 @@ static int insn_def_regno(const struct bpf_insn *ins=
n)
> > =C2=A0	}
> > =C2=A0}
> > =C2=A0
> > +/*
> > + * For use only in combination with insn_def_regno() >=3D 0.
> > + * Returns TRUE if the destination register operates on 64-bit,
> > + * otherwise return FALSE.
> > + */
> > +static bool bpf_is_reg64(struct bpf_insn *insn)
> > +{
> > +	u8 class =3D BPF_CLASS(insn->code);
> > +	u8 mode =3D BPF_MODE(insn->code);
> > +	u8 size =3D BPF_SIZE(insn->code);
> > +	u8 op =3D BPF_OP(insn->code);
> [ ... ]
> > +	/* non 64-bit loads */
> > +	if (class =3D=3D BPF_LDX && mode =3D=3D BPF_MEM && size !=3D BPF_DW)
> > +		return false;
>=20
> [Severity: High]
> Does this condition miss BPF_PROBE_MEM and BPF_PROBE_MEM32 loads?
>=20
> Because this check strictly matches the BPF_MEM mode, it seems these othe=
r
> 32-bit load modes would bypass this check and fall through to returning t=
rue.
>=20
> Could this cause bpf_insn_def32() to inappropriately return -1, skipping
> necessary zero-extension for architectures that rely on explicit BPF_ZEXT=
_REG
> patching? If so, the upper 32 bits might contain garbage data, potentiall=
y
> leading to out-of-bounds memory accesses if the register is later used in=
 an
> address calculation.

I don't think this is exploitable. Both BPF_PROBE_MEM and BPF_PROBE_MEM32 a=
re
inserted by bpf_convert_ctx_accesses, that directly modify insn->code,
w/o call to bpf_patch_*(). Hence bpf_is_reg64 is not invoked for these
converted instructions second time. Hence the aux->zext_dst flag for such
instructions retains it's original inference.

Nevertheless, I modified condition to include BPF_PROBE_MEM{,32}
to make it future proof.

> > +
> > +	/* atomics, see insn_def_regno() */
> > +	if (class =3D=3D BPF_STX && size !=3D BPF_DW)
> > +		return false;
> [ ... ]
> > @@ -623,7 +659,7 @@ int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_ve=
rifier_env *env,
> > =C2=A0			 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_STX + SRC_OP, so it=
 is safe to pass NULL
> > =C2=A0			 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 here.
> > =C2=A0			 */
> > -			if (bpf_is_reg64(&insn, load_reg, NULL, DST_OP)) {
> > +			if (bpf_is_reg64(&insn)) {
>=20
> [Severity: Low]
> This isn't a bug, but should the comment directly above this call be remo=
ved
> as well?=20
>=20
> It references a fourth parameter that has been deleted by this patch, whi=
ch
> could be confusing for future readers.
>=20
> > =C2=A0				if (class =3D=3D BPF_LD &&
> > =C2=A0				=C2=A0=C2=A0=C2=A0 BPF_MODE(code) =3D=3D BPF_IMM)
> > =C2=A0					i++;
