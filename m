Received: from mail-wr2-f9.google.com (mail-wr2-f9.google.com [74.125.225.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2489438B127
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574888; cv=none; b=U+m2v1er1raZkDwoGoQxAGKBH0of+ICyQQMolrA+AhcxekmicM1ho9dgB5owhBWcdvleRzECZx+86v1BLmN0XZiqXpjdPch7vDEBgfx4sVT18T22yK2Ko3R16M3PYKS8ccN36/C4RkutesMwMCzdStOVaKGn4UHx17fKQw9dgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574888; c=relaxed/simple;
	bh=NoscPoXpbEHf4a7E/aNPuq1Nioi3Go+Z4DNclM+9wag=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ifaP/srVxYVqbKt5fMGvVOLP2fMyD41koqDmUSA4NtmeuxApJyeahwMccSzHvjcpvlN+T3TSzeOdBVJ/zmesfw8UWT7iPCG79evN3QDKxjB/3R6Y/xqCSN93+OdwwVs8C4LaMdn6FmKgsSQo2YJkjBazH3kmo+r3dMQycQNqsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3vM3L8Z; arc=none smtp.client-ip=74.125.225.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3vM3L8Z"
Received: by mail-wr2-f9.google.com with SMTP id ffacd0b85a97d-48437576531so1988465f8f.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789574882; x=1790179682; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5KsQIW7PSyG6OtqIsvUkJBWGONDeWeTLibfozf22Y04=;
        b=X3vM3L8Zv1fksHFtPLBAi09/r5dCbnSynoZNHx2nVP0yT3hDoy9Dtav3lAUC4qXxQV
         Eoi5VvHKt2GkwoFE1vJuO66+V9u1zkJ+8k2e+AQFGbM/v4+DH6r+V54mcl77x2FVRp7V
         6hkB9BlyfJXi4vpx6sVPZi2IT/zKVrOS2WxROlD0YoXmhvYeUk6BHyYJ147xWlGGaFIZ
         qq/JXjigow/SoDQJyEwx51O6y/VeSBiAM5K5vcrkXbDArTALogHXbzo15vWoF7orCnjB
         Arycs93Nh/NTm/jATXKhqMCgnx07EQObzOUHMTFyFzCwBlIejm6zCXg8kSHeoC8ohd/G
         w0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789574882; x=1790179682;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5KsQIW7PSyG6OtqIsvUkJBWGONDeWeTLibfozf22Y04=;
        b=d9AwadDU7uhhXGKAQvDrE7hSdwOLsQXTrD8ADm/w/4gBObhzbwAoLwp1qNdWKQ9Q1J
         7W18TVPDidxdp9rUVZMGZcIpy7SZOBTUuQ8pAikKtchHPFUxKinLwOTY7+qVzMq+WarH
         idacotYh7I7RMUrJRlAe/h1L0ZKYGVaoTLuMJn0KhUWb8thP0nu/zFNcYUWBluQKjlDX
         dI8rAZ0I42meyF+8Ly0HtQ8/LEHb0GibzZgvUChZg2eur/nsKaEjmCcW+WQjufTJXC83
         lTyObLD7Kl5AzYt5xSoRoRvlZoyx2CNC8Fxy+U8+cdImZTcv53Q0cAW3yrDh9ffCwlWn
         mxMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ1jhQdVUDcZhKU49RyQlenofi0UgbAMptcPR4kaVmg9OGGPHbciBHXP73ENuKGwAXhaI=@vger.kernel.org
X-Gm-Message-State: AFuF++n2kyXuHT5vzeJ67XJA1xqPX9JCVxDJUxpIt2+i/theS9HJfAlB
	ox9m4XLiLW7UJaRY2A198ckr5NPHxSiXgDW+wOsbTDbBlVsqqgWMjPum
X-Gm-Gg: AYBFou0X3yjA5xoNFhVhedCyC+Qa5MN4WAug3CHluvshywV/amTiNK9hFquneqPqbpe
	dUk7nID1rh5zjf+L1+B0aub608j/t4KaFdUWy23VUFkWBLC+Qcy/GbtlihTDCryICms24ubfe5d
	KICoiNtWkPOKFGcyjhF295L1fev0gbDqCixxzgkvYuYfxaJq0+47XEKtergUZc5BXGZzU6AX3Uw
	wrej29E6Lq7jBzgSg9Ni+vwLFai1NrVYXgBzAG3bRQYXflMiJkwc0nekwi3Qg3VRBwCAkVB4TOf
	10dHojBUMCx7+Msw33jNAsfovaE0cM72DPvcVeMCuoOPieyeuhyTaN4R//b/dvcstTG5z9TouMA
	ZxBnbp/np2kTeb/PRcibqF7CuRa/DgYcuC4iqPaQj1zeVdREnK+LmlnwfcaXY2vjVtheZuDE74C
	cy9hh7d5JPR/sARhiQMxEB8UZBvWSFPkExIELttXYQ5KxQcK/6GOofKzsJdRT8eQlgm3/iibiRY
	0m6Z61rGcozZxC8XeJ0hv4KkvURe8+jIJRxNWqqT+xTlqCPfMBFspRHlGaiISyFHNWGOogI7AhT
	zSDuPGAEhJQEWkdY78cLz8Qeoq/VnEUuwZGM9w==
X-Received: by 2002:a05:6000:186b:b0:487:731:c87 with SMTP id ffacd0b85a97d-4870cf0a3b7mr4109686f8f.7.1789574881919;
        Wed, 16 Sep 2026 09:08:01 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm7724481f8f.15.2026.09.16.09.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 09:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Sep 2026 18:08:00 +0200
Message-Id: <DLGVCMQKS83E.1XOH6G05DWBP0@gmail.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Fix generic __uninit kfunc output
 buffers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260915141004.1196460-1-memxor@gmail.com>
 <20260915141004.1196460-2-memxor@gmail.com>
 <309af9b05e49a62f0a721cbe04673468f11e64f4.camel@gmail.com>
In-Reply-To: <309af9b05e49a62f0a721cbe04673468f11e64f4.camel@gmail.com>

On Wed Sep 16, 2026 at 7:19 AM CEST, Eduard Zingerman wrote:
> On Tue, 2026-09-15 at 16:10 +0200, Kumar Kartikeya Dwivedi wrote:
>
> ...
>
>> =C2=A02.3.4 __nullable Annotation
>> =C2=A0---------------------------
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index cf85141ea167..9ddbb20ec1e9 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -1547,12 +1547,13 @@ struct ref_obj_desc {
>> =C2=A0};
>> =C2=A0
>> =C2=A0/*
>> - * A memory argument a call fills in. The verifier allows the stack to =
be uninitialized if
>> - * the range is a known constant. Stack slots are marked as STACK_MISC =
by check_mem_access().
>> + * Memory arguments a call fills in, indexed by argument slot. The veri=
fier allows the
>> + * stack to be uninitialized if the range is a known constant. Stack sl=
ots are marked as
>> + * STACK_MISC by check_mem_access() after all arguments have been check=
ed.
>> =C2=A0 */
>> =C2=A0struct arg_raw_mem_desc {
>> -	u8 regno;
>> -	int size;
>> +	u16 mask;
>
> Do we plan to add kfuncs with multiple __uninit parameters?
> If we do plan this, let's separate __uninit fix from the mask conversion.
> Otherwise let's keep regno.
>

I separated the patches. I don't think are any consumers yet but it makes t=
o
support multiple such arguments, so just keeping the separate patch. If you
disagree feel free to drop it when applying.

>> +	int size[MAX_BPF_FUNC_ARGS];
>> =C2=A0};
>> =C2=A0
>> =C2=A0/* Size of PTR_TO_MEM returned, taken from a constant allocation-s=
ize argument */
>
> ...
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 6c6b8d8520cd..070ec5daeec3 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -6981,7 +6981,9 @@ static int check_stack_range_initialized(
>> =C2=A0	 */
>> =C2=A0	bool allow_poison =3D access_size < 0 || clobber;
>> =C2=A0	/* The call will initialize the memory; uninitialized stack allow=
ed */
>> -	bool raw_mode =3D meta && meta->arg_raw_mem.regno =3D=3D reg_from_argn=
o(argno);
>> +	u32 arg_slot =3D abs(argno.argno) - 1;
>> +	bool raw_mode =3D meta && arg_slot < MAX_BPF_FUNC_ARGS &&
>> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (meta->arg_raw_mem.mask & BIT(ar=
g_slot));
>
> Thit BIT(abs(...)) trick is repeated several times, can it be abstracted?
>
> ...

For the other email, I decided to keep __prepare_priv, we need to resolve m=
odule
ksym kfuncs but test the unpriv case. It is a bit of a hack and nobody will=
 do
this in practice, but it helps us retain coverage for the other case.

Addressed all other comments and will respin.
