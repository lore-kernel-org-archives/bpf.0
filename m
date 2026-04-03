Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2C3368B4
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239669; cv=none; b=ID5LQ98p2zWghvjnRAWuStLJJUIxPsjpChGiJWpiq0InuVx0KruO7WVLYUEs+rWVFSYVep2mpU7xNfn2Sy96fxT9Qsj1rOXuUTIB036u07n0KnhY1Y+7poVfJ32r8dMItQdX3UYYkA3arZirxbW/3AHuG9+MXLVEModAU63gQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239669; c=relaxed/simple;
	bh=3LWK7fB7zVTrWUVVHfaqncumZYmP5FGmEnhV05wNv0Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JFjY7zrP9RPquNT5UoibdH4fNx17JpmJqPM70taETHIjMCy+nuTx9co7r6LBUxrbYMOt4o3W3nGC5HQ5BIijlZNUGD6MrjkI7fn16WUhl8EF2cGEZPYONChyvuVooMtEW/SXX+5clGQDjAwKT9Dd6ZCI6yxmavZU8Ppz1VuxvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=mo1PK25P; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="mo1PK25P"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2aae4816912so13259285ad.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775239668; x=1775844468; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e21/azQxOfprjIRCm4cyq4TRL+eiu3i4WJuJSrkzJoQ=;
        b=mo1PK25Pn1b/+eb6kn8iS0WMR1oFPIRU4Ool81PNz3T4GftoFCsV6ooFsNs12zzqIL
         /Fnp3AHAnwaKAz09gX4GOFqXca9CR5bVyIm/1RkS87vxqXlt61RfW4jbe32fEDMxxhTO
         jOXFy1t6jFHyR+db2eimhZOYJe7UsXOqhPxG44V7nYkCc47dJp29u5kq8rxHOzq/Owwy
         3IlPfFrWxGUlzUhkclR2u/7bBQuSgJostzA24yvajaMgEGPwdYu1nw5V9sS90YhBnauD
         H7Dn7DUICFzgpOjT+9bHbk816ym32nsCheGi/N4Rvbu0tlBCC92Ioqde/UVIIaTTvodM
         OPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239668; x=1775844468;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e21/azQxOfprjIRCm4cyq4TRL+eiu3i4WJuJSrkzJoQ=;
        b=fEzfRmKZogVV1wGq1ksAgaYeM8twO2VLVACGTtVYq3QWKQqq9JB46A1o+OEhsZSFjq
         Bf1dndixMw2tr4agfrP5Gjii/nw60CzdhD4RWNs0FHdrzBJ/7pikHfJa7CSIr696NEqv
         qITrO+zxuMv7sovV4vyMEfZwTypaVPXRZwqfzQIrCfTHW1w/w1qOlAAx5GrVG3X6LaXH
         cjb7cRSwl/aPf30TiXHX8D/Zo85eFGKCp/wQx+H16ExqByiivCdPjfAEbXQcQsn0QrPJ
         2WDWUOVa/I7AYCrpKUDcbm928nFsv2jKZMliv6JFyPVtKRp7uXv0jls+K6sksBEev1Tz
         DR0w==
X-Forwarded-Encrypted: i=1; AJvYcCUzNNtHupjuqBrV5th7jpN8pWqhKikkim9yI8ntX8f/ukf6AdLh/IKOS8Mwf8wsk/su2x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yNVTP8jol+KajEFJCtPNylPUrhFmIxIsG18g22rDVENHziP/
	HDvGig3WSeVdvmA2Axw9GpodOsLmDCO+2XlkeKFupbGIoKjZ/VejdcwgBeBZWGOYIWc=
X-Gm-Gg: AeBDietSfvrrbXz6wuspljXYMz67TGpKVTOoaUiNkz1sw3fms2jxdTeBK2BcgULhJhp
	15xiJ3l+cAuSAbyyOwU93cWB7o8TtOFtO55HSz/uTtjyk1fo/W0k/3P1zErJVEXfzjK+K1PZlNH
	LENaaDRpq3klpW1J49Mj0KMTFnIKNQgkIqS5ja3AKddbIle5Zxnb8qFDQWUhVj0muUlS+9Kz5Kf
	8uXzzA8r0veMOtcnIPwX1c1LcTdGtfmyXgGwd4CCQqanmbcMWklH38addRxTl6iG4gqP3gKXBdU
	dPYPBHrWuQ/EMINGaZ3RJiPhbANlmEy4vVBwL/iNS4nqZz2p1AA6yS27bFQOtDU5MGGqnbqdImn
	N0jCbiymQdRuzSxHJopjSEYpdEEzLGP8OxnkJyNc3CzuvLTfD4NrYfAW+xtnyUp6y3QoZXGBFM9
	ShyXcMNpxXKNyD+9Sj9w==
X-Received: by 2002:a17:903:22d1:b0:2b0:7531:b61e with SMTP id d9443c01a7336-2b28188a0b6mr41119885ad.41.1775239667508;
        Fri, 03 Apr 2026 11:07:47 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27479d0fbsm83833725ad.35.2026.04.03.11.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 14:07:45 -0400
Message-Id: <DHJPXVNL60NO.1RIVY1CBVEB9P@etsalapatis.com>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <etsal@meta.com>,
 <martin.lau@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Upgrade scalar to PTR_TO_ARENA on
 arena pointer addition
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403042720.18862-2-emil@etsalapatis.com>
 <deb90258dc2746693419d66c4dda30b686a35434bdb8c1b85a6e6df059ccf4ae@mail.kernel.org>
In-Reply-To: <deb90258dc2746693419d66c4dda30b686a35434bdb8c1b85a6e6df059ccf4ae@mail.kernel.org>

On Fri Apr 3, 2026 at 1:04 AM EDT, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index a431b7d50e1b..a0e6522833ae 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -16354,6 +16354,24 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>>  				return -EACCES;
>>  			} else {
>> +				/*
>> +				 * The compiler sometimes stores the result of
>> +				 * PTR_TO_ARENA + SCALAR addition to the scalar
>> +				 * register. Upgrade it to a PTR_TO_ARENA.
>> +				 */
>> +				if (src_reg->type =3D=3D PTR_TO_ARENA && opcode =3D=3D BPF_ADD) {
>> +					struct bpf_insn_aux_data *aux =3D cur_aux(env);
>> +
>> +					__mark_reg_unknown(env, dst_reg);
>> +					dst_reg->type =3D PTR_TO_ARENA;
>> +					dst_reg->subreg_def =3D env->insn_idx + 1;
>> +
>> +					if (BPF_CLASS(insn->code) =3D=3D BPF_ALU64)
>> +						aux->needs_zext =3D true;
>> +
>> +					return 0;
>> +				}
>
> This appears to fix a gap in the original PTR_TO_ARENA support added by
> commit 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the
> verifier."), which handled arithmetic when the destination was already
> PTR_TO_ARENA but missed the commutative case where the scalar register
> is the destination.
>
> Should this carry a Fixes: tag?
>
> Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the v=
erifier.")
>
Ack, I will add the tag in subsequent versions.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/239341=
76047

