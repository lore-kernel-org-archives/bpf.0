Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D84F403F
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668011; cv=none; b=euwpPRTJRtNZoemxs3SGdDHZ+/6wPRVyc6nQP8Ar29pj4/6I6Wz+AycuNV5sKxXojQtIOgookETSwSHTUnbRmEu24T9xSEmHs6HShg4WYWMGAVhrhOOaUi/5AGkcI4p6nTi1xu3xGec+yL1erk4uPkYQ3W5k4RgBapBzaS6qiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668011; c=relaxed/simple;
	bh=T5zLQ8pTBPq9layLSRaz9nl/VPn/MOOChYHcYv/z8uE=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:In-Reply-To:
	 References:MIME-Version; b=Gw7cgpACiWbAqrWTnNzS/B7qgC53xnSDq9LOq2JLvrSWG1LZPKsFD6Hpzl2+qaPRxqYnoJ/Se7yczYD7kVHH62t+l9hvzaSQ889LrVTzbVuV/Ci846FeU47gIBEihR+gIqEdaW5dxdDn84rSNAg3hWdAh9f3tTaaJ3gQup+WnYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5BnBq1X; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5BnBq1X"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469e211a3so979113b3a.2
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789668009; x=1790272809; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nNMoHF/9Wt6kj1uFjogQZtL9u8qRSvnR3tTYA/KhllU=;
        b=L5BnBq1XWYrIs/Nn2HFWHbUhGvMba3NXR0FPXfLRvfGy+SkojVGwN2g34lie4MWz79
         rJExw8H7vindzEs5+UO3t+E95qGu8PPZHgjVmp1B1sBA59F6ObrSENxuPmgfJ08hroom
         Gq1QVLbFHD6CJDTjOOw1nUu1JMaOWKG4gOynv4oZnWrpt++gXFXBikXjNObsWiP9HALq
         f0BvP7sfS/5UGioOZcabBPe3uUhTQdztrk6C8CaViwD/DvLT0VbiHWrKNlo2dSN56uYd
         BJdRFi1iKoSLXBX0pxnFfQmL73S0NxPkRch1p2BCQYtTdPydMWiJAZqIZoCdO+lVTqIw
         miyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789668009; x=1790272809;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :subject:cc:to:from:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nNMoHF/9Wt6kj1uFjogQZtL9u8qRSvnR3tTYA/KhllU=;
        b=wdEQ8fYkUFQgZUPxRC8UIvTU9G4B9tnMn2Ry4JMM60AIVR0KiIXerWiJvtNOIf//1/
         tNiss/mybMPtXcbJRPrT+bVlgZmEFGsES3PeDhFMtoT93Z0rvOtLpCiEql3N4KX1xXIs
         8h3O1s/ZrjoxSPnaL7tLpxHVKObiYTitaVur4aT+wp7d9s4SxwPE4SSePlsuLGQuWRwB
         smVmmc7wsYqLabAx/etqNxzCarXLa7L9k9dUTjgH47AE/4C6DQncYOiYMZbNM1x7Tx9e
         lAFwrvzaAZFl64XAwXj6Om1GoSn8Zz+1wkhONqfPtiL+Ci6NvRXXfIxSpYwCpveq3gJ/
         EZTA==
X-Forwarded-Encrypted: i=1; AKwUvBzRsPIY5ficB333QK89rwsNkwtB9ffW6eWYqmyFhKVwZbk0WOpzbMQM5XGsEVL2bcf/TQk=@vger.kernel.org
X-Gm-Message-State: AFuF++lJnhI1ltBqpz7CxZXynNgiM3G84dI9EfD1xsHpRmviqM49A/kF
	giKBJFJ4jFrpDc3jrp44PuAkfJZFY0ksV4E3YpJhZUmhx43tBi8CFfBQ
X-Gm-Gg: AYBFou2R3Y/MB4XT2JO62BHqs/AnxsJBW6zm2hCEAVQCoDO3Xm8T1OgbLleUITSnfxn
	1IwtrPop1QLZwJSZx7uRCanUzU3uhVdHVOZNJpdvDY1ttlQIlLyya3WN04N+SbxTBAnRPGI1MmZ
	MF77aG6MeOpf7JEKeuck8ACEhxPavbukPovd4qWDk6s03q29BGO+flOi1WgRzyDAutqOygJ5b/8
	CTi6E8zDT3VvSod3uZHRNcBCZ3ZVeH/fR6wScMe/imX3y/Jjzhpc4p8LowZqLzAgbNH2KfWMmEg
	0PGKOlk+zoLUoBeQL3g05veM0nQshWvGMtUTynxADzsI+kCeC57KR7PJLacBBNFBWiDySDaGmjH
	u0l0tQ4f9z9EVeNKgFM3y/HLIloe643LJLlBUYB0dav999fRwoxxqU65bglBerPMnI4aa55sx3r
	WeD6sxSlgc0mSIRVFlkHmpgLUEQkm0/yd7BowRx5zpMlZIhknF5o8KivWwaAS3yty7yxU3wz6gu
	fqqNZZfvduHiSCFRKzMGkmhy4bYlb1cGy664xiTmInPpeLD3/j4DcBP11fRAJ7UorluEBfcC7Im
	YuS2QQ==
X-Received: by 2002:a05:6a00:3698:b0:857:72f8:dc97 with SMTP id d2e1a72fcca58-8723b394555mr14996544b3a.24.1789668008323;
        Thu, 17 Sep 2026 11:00:08 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200c58282sm3296496b3a.15.2026.09.17.11.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 11:00:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 18:00:06 +0000
Message-Id: <DLHSD07GRG0W.16CFRV44ZE1DD@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <eddyz87@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [PATCH bpf-next 0/8] bpf: Add UHMUL and SHMUL instructions
In-Reply-To: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
References: <20260917041712.1860722-1-tangyazhou@zju.edu.cn>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Sep 17, 2026 at 12:17 PM Yazhou Tang <tangyazhou@zju.edu.cn> wrote:
> Patch 8/8 uses raw bytecode for UHMUL and SHMUL because LLVM support has
> not been merged yet. Once it is available, the raw encodings can be
> replaced with the uh*= and sh*= mnemonics. A draft LLVM implementation
> is available at:
>
>   https://github.com/ADSWT518/llvm-project/tree/bpf-hmul-insn
>
> We plan to finalize and submit it as an LLVM pull request after the
> kernel-side ISA changes are merged.

Pls send the LLVM PR now. It needs to be reviewed together
with kernel side.

I think it enables ISD::MULHU/MULHS legal under -mcpu=v4.
Does it mean that existing programs might generate new instructions
and stop loading on current kernels?
If so, we'd have to introduce -mcpu=v5 for that
and extra flag like we did for other insns.

>  arch/arm64/include/asm/insn.h                 |   4 +
>  arch/arm64/lib/insn.c                         |   6 +
>  arch/arm64/net/bpf_jit.h             
         |   6 +
>  arch/arm64/net/bpf_jit_comp.c                 |  15 +-
>  arch/loongarch/net/bpf_jit.c                  |   3 +
>  arch/mips/net/bpf_jit_comp32.c                |   3 +
>  arch/mips/net/bpf_jit_comp64.c                |   3 +
>  arch/parisc/net/bpf_jit_comp32.c              |   3 +
>  arch/parisc/net/bpf_jit_comp64.c              |   3 +
>  arch/powerpc/net/bpf_jit_comp32.c             |   3 +
>  arch/powerpc/net/bpf_jit_comp64.c             |   3 +
>  arch/riscv/net/bpf_jit.h                      |   5 +
>  arch/riscv/net/bpf_jit_comp32.c               |   3 +
>  arch/riscv/net/bpf_jit_comp64.c               |  18 +-

Pls cc arm64, riscv or other arch JIT maintainers on respin.
We need acks from them.

