Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B6485CD2
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038765; cv=none; b=aqZ63vbWxB1zGyMu6DIDTcgpkhqUZauMYQCBjBxkwCE/MOhW9nZqjZisbIBwxaowMjQ0C+jjuukR2DDFeEXYKYk670y2yOjjk45NK4nwPF+Z2Pkw49Z5QRKKdjL98Vgk1NlthewtFGJZB1koEoSO/YYc6WNpVkWUYZtzRDSSffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038765; c=relaxed/simple;
	bh=a7wOn0pjXHD0na2aGU6TVSGIFgOYkbQuqX9Lcqop1WU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UefElE9orwp3dcC16N5eW1TZJOWlFkJwkaSAJJ33CGT/b86HR3npRBkp2uTN1BWd/H5nSFKgKiNcvZugH2leXsKdZ/7AYgNfLiOqi00cg4gClJXZBLTyjsY0gFGNtljM9c3pwTCaJ1/I77jPBoocDPXLW6k9l7ho/2GXkajpr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ns7vi7+8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns7vi7+8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce7d2adef4so37920795ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 10:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786038762; x=1786643562; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0oeQGuaaIr4hCEO8GZ9uSCtwbawrrV19zd+n/INCc84=;
        b=Ns7vi7+8cj018//pTKry8ngVSGN7xivwuu5jwss+c8m1Nvn/mWAd/vkjrTKVCTXzUl
         rVY8mlejNqYwoeDQ1djKbNSVCOEZR8O/u+TOMccb81HkR/K9rTksDvaKWWR/C3ov+1H2
         u0wzNdgW67GcAj4cNTSFrBgQiwR3bFpauXDrVJNGl13hI8LsY4Uo1lB8sOEt9gbMlk7t
         eRXGQb9GnWoczzvldyYZGYlhaLfopDEV6otBkdPHfEM/q25b/0nBB/dITfYQRaaN1Wtj
         HBXG/sEBMwejavTxYmC4z56JbY1dHH5xejrFQ59gmdwCeseiUlC0h6sLz9hD6sum5ZN8
         nPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786038762; x=1786643562;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oeQGuaaIr4hCEO8GZ9uSCtwbawrrV19zd+n/INCc84=;
        b=QC3dyCw5Zbo3sPYTjtu61fPUHDfbA3hrMz3WrGnNlaymmphyQKgVRFxLfnJN5NJ4Iu
         nDjScvXKLlHtEJQGNbpYQbfyatQXBLpruY3FE0p9K3+DIpBhRvcaA28s++Lx/k9B2v0S
         q9GPwSd3eY0kVdhVihp44xGZjtCgRa4sChs7vg9H254OPF30LsKS6dGNxtGTXCbUALds
         bGY3cFjiegSqwa/aPYDn4qnSgebBmRjtawl1Bx7Zm/SvU3M6SJmJxDWuIKPZEPfYLDR3
         IXbUrzUVH81zWQsF25QStVJjYaOzQ0kmsQnZIbEPhU6bC1JWAB2NXAU6G7a23X1AWvwf
         sgGw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5wfVUOnTfpevxqwaCnb//Xn7L9yfnPhpaTHvgYSUA4htGU/1y8b8cZcYz54A55YH72GY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvj1g9ABpoD+hsOfGeg+GaE0l6fnOCDbiAjgKOc4Afd/8lFAzK
	s6W20s02bx7G/JF6WPhKc7jvh+52RBTT0V6JldtKAOIAILhVQAmCDfVA
X-Gm-Gg: AR+sD11q5lLpHmo77eP9RGG4LjNkbLUGF55Dq/rteNrppP/IYqifv+K5TQB99H6vuhj
	q5cDxgcaq3Y7MMtD1a7hvuQb48vXA9aH8eZLQW2CFnDARnEAnFL/0J1xNsAXoIlSOOf4Yxvtgul
	Ir94IBOoYFjukDOJ1QlgQRNukmX6SPCS8N4QrcOivfpDNAZOphzycBzqIhdcUoYq/OMq+yB50DP
	hwA68Tfh+es5ZrN/G1FvGxfyLWwOi1Pdp+OWibz4AGzy2wi9jHrpUmoA0srw8me6TdCTIFKqdQ5
	Hzxx9lWux7UNn9ajd4ymcejdcU0GTviWrhyy0AfJ61DyWIk6v5b42u7IHfA2ww9NzNF7jxFONw2
	mfu8fIxAI/F81bEGvMpEpcU9RVfCVuAMsfz012PcKx39xU1ZV88eOB8L/KPY3qtsnwMDk6gFaen
	Eg9IX1i6FI5cVpelMaOdwLzMG3iYNHRJSBug0ZUH6kCW3H5keIDLCWQk0GYzipDb1fZB3qwnAGS
	acd01F8OODmR1Ax3NZv8Mj5akGq
X-Received: by 2002:a17:902:d2c8:b0:2cf:84bb:1ebc with SMTP id d9443c01a7336-2d0ca77eceemr184374955ad.15.1786038762243;
        Thu, 06 Aug 2026 10:52:42 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d120706518sm266455ad.5.2026.08.06.10.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 10:52:41 -0700 (PDT)
Message-ID: <9bcb8e2b7d4fa998f4811e77fb6920edd3dced18.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix sanitize_err() register selection for BPF_K
From: Eduard Zingerman <eddyz87@gmail.com>
To: bot+bpf-ci@kernel.org, chenyy23@mails.tsinghua.edu.cn, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sashiko-bot@kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Date: Thu, 06 Aug 2026 10:52:38 -0700
In-Reply-To: <18e8ba9303a6041520433c7bad9187e29a756908385e6b2607de1ae82db67beb@mail.kernel.org>
References: 
	<20260803-c3-035-sanitize-err-v1-v1-1-93e5ff61731f@mails.tsinghua.edu.cn>
	 <18e8ba9303a6041520433c7bad9187e29a756908385e6b2607de1ae82db67beb@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-03 at 15:25 +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index fdc5fbb1f78c..e5a8547ad723 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13562,6 +13562,7 @@ static int sanitize_err(struct bpf_verifier_env=
 *env, const struct bpf_insn *ins
> > =C2=A0	static const char *err =3D "pointer arithmetic with it prohibite=
d for !root";
> > =C2=A0	const char *op =3D BPF_OP(insn->code) =3D=3D BPF_ADD ? "add" : "=
sub";
> > =C2=A0	u32 dst =3D insn->dst_reg, src =3D insn->src_reg;
> > +	bool src_is_imm =3D BPF_SRC(insn->code) =3D=3D BPF_K;
> > =C2=A0	struct bpf_reg_state *regs =3D cur_regs(env);
> >=20
> > =C2=A0	switch (reason) {
> > @@ -13571,7 +13572,7 @@ static int sanitize_err(struct bpf_verifier_env=
 *env, const struct bpf_insn *ins
> > =C2=A0		break;
> > =C2=A0	case REASON_TYPE:
> > =C2=A0		verbose(env, "R%d has pointer with unsupported alu operation, %=
s\n",
> > -			regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);
> > +			src_is_imm || regs[src].type =3D=3D SCALAR_VALUE ? dst : src, err);
> > =C2=A0		break;
> > =C2=A0	case REASON_PATHS:
> > =C2=A0		verbose(env, "R%d tried to %s from different maps, paths or sca=
lars, %s\n",
>=20
> Can this code path be reached for BPF_K instructions? The new src_is_imm
> check appears to be unreachable.
>
> All three call sites of sanitize_err() (at verifier.c:13765, :13858 and
> :14610) fire only when sanitize_ptr_alu() or sanitize_val_alu() return a
> negative REASON_* code. Both of those functions begin with:
>=20
> static bool can_skip_alu_sanitation(const struct bpf_verifier_env *env,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struc=
t bpf_insn *insn)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return env->bypass_spec_v1 ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 BPF_SRC(insn->code) =3D=3D BPF_K ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cur_aux(env)->nospec;
> }
>=20
> and check this at their entry:
>=20
> =C2=A0 sanitize_val_alu()=C2=A0 verifier.c:13415:=C2=A0 if (can_skip_alu_=
sanitation(env, insn)) return 0;
> =C2=A0 sanitize_ptr_alu()=C2=A0 verifier.c:13469:=C2=A0 if (can_skip_alu_=
sanitation(env, insn)) return 0;

Hi Yiyang,

Thank you for the follow-up. I double-checked what bot is saying,
and it correct. The original report from Sashiko was a false positive.
Given this, let's keep the code as-is for now.

...
