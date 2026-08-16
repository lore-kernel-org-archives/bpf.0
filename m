Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EB53D3D19
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862391; cv=none; b=bkSVELibZNHuIiUTo+QZdzYbtdBbkpLn8uWAZFl7X3/DgdaYQRAI0uQeDWzgfPERVYSqws5eZcqlAc/5KetyCK/uMObMD9GbNm2MqJrzBP5PlXuAokWa2rjRT1LU47IKK3VZMir4IEXcWUWSAjWoNVqZBs5hPswlQ3VFaqLMcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862391; c=relaxed/simple;
	bh=2LFmLPdz3qR2GfXXCEuwFsvSvFgMSBkPsGt/pv2AXH0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPHp86TVz9pyXKYxP22QwdcFvhXohFTA75gzwr2PqyvAhIcvmonIaSd+/9grtfL7CZRoIo0qkAdwq7wqN3dMH/oTSiYDY9O+N+qlwYIJjbA+fAp473qr3PbceW57I9aunnbmE0jWKQLn0yFETXnXQkH320kwE7sqSJ7Qz4fZUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNdgE6xp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNdgE6xp"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceab75934dso29120465ad.2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786862389; x=1787467189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=afTrRXV4XSXTFvY24MoZk3NiX/aJ24UC3gxnkWyoToQ=;
        b=SNdgE6xpkHuNVziIaHF3pow8S9HzJJD58klbGlhbW2+pyV39Rr4bo3/b/yHgHbYmxX
         bu2jnSdILxVb+d/Szhh10JPHjaZd2XFTi0c/Vu9aDPhjwkZTLBfskJtDpj/E+dfWkIzB
         BbUGbDjhpjSDWQJMNHGmP9hzgV9hcpsHSXnSxPUV+7KFdY38oc/NrXbaDCyCmYJVIIuX
         wFO+pWEpndyD7dZbVp3TdvPkmrgCZc1WDzhrRw1MZXDNxaM/a6SNjiwyaTnmIOSeY+Vr
         hyyJlYKAikPMH/dJp7YjJbHH1dXmem69HDQPJVxsRfov7fpmmCSUObcQ8FxtRPs/Ijxl
         U3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862389; x=1787467189;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=afTrRXV4XSXTFvY24MoZk3NiX/aJ24UC3gxnkWyoToQ=;
        b=tJJ48qE58qCh0vgbH/AVmzrwU43cybJGIr57W2gtu8zwYHpXgLmRFEQPbUZgKRHWbc
         ZoOP71K64RM/+ttM2dZi6+ZXn/yK9rDL24fF2isX3NNhmPIBHhY4+HMT1U0Bzv4bO6B+
         GVJdIL0APQFKQ4PXOMRpP0F3/TShFGM+t8ZZKInejUtdv4u5pR25EQNRroFe9phVFplU
         4W82mqShiKCBJ47YQqbEhZj8DiTe1WlOlyOvf2Ce7BSeoOBNfPJebfNAPHmPFClQrcyM
         QZwjQ/EUdQMLf/X8szMLPgLp0zOnWAqCDtYtVQHtDIAQyYz1kndvhk2TR3BG9WxjYnQh
         uoJw==
X-Forwarded-Encrypted: i=1; AHgh+RoVbv7yzYAxEY6y7GrIlObq68E/Y3P5mcgMao43c1EgjMH/YC6+KbIWnyKzezWIvc0pCro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVzrtVJM//AUukACXlV2G8NtQ4F7etvd8FkBlwyO9/VWyyKNX
	qprLi4V+EFPt4c8QZL8unwJsvrcjXmesLgfhuRU3NLacLSZph546IRZ/
X-Gm-Gg: AR+sD10yPD7tw4yrY9PlVHA9AkXfxMJyCSbOthJiZVd9Y7VX/PJyeBTcxVR2jkn9UY9
	kQh5RrYdj57Riu/QUAAaf0ZaHnrkITvIUDxEWuGbpDf0uBazd9ykOaJIpCFbZa8t+6BHlHFJLYb
	AEvPOtqsYDOYUmw11CzyGW4DPrt1LyuauXH0C5FHhN45azmCauYjd6hoxAFg9fC5Cu+cufGF+S7
	zrxtJziMV9ZUolrKCFH4QIxoPGl/Dj0qXDuZQQyy5n901JZ68JofnHmJD1le3ytDNvjNPBPG5L7
	cRE+B6oKI5Xakl3MLOJJVc5E5cWjbhaBEE/vvu0sQ6qh9X7eN+Ts/njxtREwGjRtHviWTEIxXja
	PgcjG2VMRS4nmxmyvDM0W2bvCOafqE6urWt4QeMiCkE5UZcoANVWBWwh4H08MerLzKASi4AGwxw
	AEuvlAzIhGNzhBIFdY+wjRV5fTgjV5KeSR0/ZnNp7aO1uRD2kFelg5KLMsAs/kkOsSh1hFhYj4F
	RQRVbUdmhT4/vE5
X-Received: by 2002:a17:903:9ce:b0:2cf:b066:7de2 with SMTP id d9443c01a7336-2d3b0f4ab8emr167866505ad.22.1786862389270;
        Sat, 15 Aug 2026 23:39:49 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb7c2cfsm24246145ad.59.2026.08.15.23.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:39:48 -0700 (PDT)
Message-ID: <5e67f44f28df257f67350ec95e2a9cbd77864da9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 04/14] bpf: Drop dead spill diagnostic
 condition
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sat, 15 Aug 2026 23:39:46 -0700
In-Reply-To: <20260816015746.2632990-5-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:
> diag_record_mod() appears to allow identical spill events to be suppresse=
d,
> but diag_mod_keeps_lineage() only accepts register write events. The spil=
l
> producer also supplies a stack target and an explicit origin, so a spill =
can
> never satisfy this conjunction.
>=20
> Restrict the condition to writes to reflect the filter's actual contract =
and
> avoid suggesting that it applies to spills.
>=20
> Link: https://lore.kernel.org/bpf/48e6f021b89562f68850fe21ef8c78719819b04=
cf9c4e4f50bc791937d37ace8@mail.kernel.org/
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> =C2=A0kernel/bpf/diagnostics.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 33b7d9e8e2c3..37ed22a764e0 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -1531,8 +1531,7 @@ static void diag_record_mod(struct bpf_verifier_env=
 *env, u32 insn_idx,
> =C2=A0	} else if (diag_mod_insn_origin(env, insn_idx, &target, &event.mod=
.origin)) {
> =C2=A0		event.mod.origin_valid =3D true;
> =C2=A0	}
> -	if (old_reg && new_reg &&
> -	=C2=A0=C2=A0=C2=A0 (reason =3D=3D BPF_DIAG_MOD_WRITE || reason =3D=3D B=
PF_DIAG_MOD_SPILL) &&
> +	if (old_reg && new_reg && reason =3D=3D BPF_DIAG_MOD_WRITE &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !memcmp(&event.mod.old, &event.mod.new, sizeof(=
event.mod.old)) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !event.mod.origin_valid &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 diag_mod_keeps_lineage(env, &event))

Q: does this filter ever fires?
   The condition appears to be very narrow.
