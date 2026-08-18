Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F045A29E
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 13:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058669; cv=pass; b=o1QqpWqHZQEQ8gg1PXYC34stSRWz/vurTj5L9y9hFTwOPh3jEba52dWj3DczwIiorVCULzo/mL7/LsIMNEvOhBumpY0V9dI8ExZPuo01QRxfpu4dhwPekAYuXJqki09emg9ZRZAS5gVdzIDB7H8PJbZcB6Dx1frUULD+07Kvk0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058669; c=relaxed/simple;
	bh=c36X0NWMKu7+KHbODZSDBkET192+cMQSiS2WCjFChvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAWlIUSCKYYK/0u5TwY91ph2iE41Q6poyGKss//xOXio/7v2GCe8ZEKu9vT4eChxnE6yFJ2KKsiL3dNCWx63Qnz5ZVUcgIuqke9fLbG41GJIQ6ynZtHWZEO+sh32P+lWsYYCnQwH+bZdOy64dWb/+GHc7lRapgw2hGAAdbwiN5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlZ7nbyx; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlZ7nbyx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c16794450aeso596560866b.2
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 06:11:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787058666; cv=none;
        d=google.com; s=arc-20260327;
        b=Vhz4CE3qIWBKyTgFCQftQxe7PtdW2FNjDHgxBsx4HiFTE08mu3l97TSC5Ku1Uu7TOn
         C3hA9ZUAeMb483bRdMq9VKp+rTBBM2e5b1VMVsrMVMRsBuVsbodKIplzXPRTQGRUrkn3
         PF3A014sCHAb+lwNqRUUYaY3VUiO4MBJV93nbqixg8PH+MMBPAmfRjNRmKpuNnLUdcqI
         rmoQtnEV5FAs7F3lIUDlBeusQA92GSccPajhSLCkR5/FEebHW3m/5EBqnHI90ARh/QNI
         q+HCuZ2HlEAtk6ZL5ZgePjRvi1L1SaeLQqXuAq86mQDAGq/eV0ht+1keYVPUuWBN4RNK
         BEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c36X0NWMKu7+KHbODZSDBkET192+cMQSiS2WCjFChvA=;
        fh=hlucYbrgBlxz+O3jlbRq18gg/GVTiRe2n8Jyz0H6iQA=;
        b=rj/oT6WtEk+vSvv9z/JNKc0BswrzNXx8m2mzIDWOHeIhpn/VdzkEUBvLuoiP9iW17H
         VhxXe85iUCLNGCUrbae3uFT/zg7AGTdmZzs3uaDJaYAY8Nv5arQSea7om5p8oAX0TJ4U
         ok40Va5No7rycTfKY3L0kzuW0wXhfXY3eaCMtvlF2ngMl0ZcndQGxr15MpyWfdSASewP
         mcgshBVWeBBmusxh9e8VFwNf6CCzo/H9ak6h9lVG70iR96ATLcBRFD/KQFIUPqEdRXKD
         5hWTxEMSVna5XfpSUyGBFqdVmCJT+71qmEoCTYbMdepJk2Re6hEhFOfkVJIFKK3SismJ
         sTRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787058666; x=1787663466; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c36X0NWMKu7+KHbODZSDBkET192+cMQSiS2WCjFChvA=;
        b=UlZ7nbyxE2cpDdszld1I8iXmRozRpoALnW557wzwZkR/G/sg+1+fHba0b/XGARll/G
         oww7v4yKLi6TbuBatJ2gVBRE8zfLRzRdd5lbo+aUw05sj1//augFZ2Z/ywFnRpYp0Ra1
         e88XTeHTUJu3tV0S+HqyLDGA4jIRens7Lom63CXrgGQWBMXd/VOCz4I5cUvRVOKtlQcO
         gyQsySW5vDcvhSNpGdcGKgjZc3ZJVZJa7u/gWVWgbzC6CSVbwGKa2BxrsX1Gcm8L/WcN
         Xde8FIMEQD5Ih+L7HZrCFLEY3kJiMIIf2RstDIvzM1ALuoUkjv/9qUA7beUya20FofZh
         DdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787058666; x=1787663466;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c36X0NWMKu7+KHbODZSDBkET192+cMQSiS2WCjFChvA=;
        b=GCmUHmujys2tHnvihxVE3CKMqBRO18Rn1PdIFftAAtZ8gbOu/bZLnOlJYx727fLqnf
         wWCMM7GOjqb6FV7AH4X3t/ZqKxNFc7kEYzqtDh8ApkplGoClAqJs1glxiTWU4fzFi0xU
         qA6LbDTajsM70/ItlZzhUSRND0i751crjQvWRufQnTdYQMDI2Xzyw7aYpjXJNsXLZ5gm
         89lmDdrPqvlTRMlVsr62GKjb0fXpNpHoxiegyja0QhhJ3yRsJNYeiz5dKTXiZ2L++9jg
         Y7SKhE5Bpy+W7xRMKJLCA2NiLutKkR5g4xv9GPXzQ1bq9Bek1tczWkzLXibB22uxkYJx
         P3Gg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/HQ8HzlJunwp7A6zb5OdZrw7S/ri3ayuptUIaihX7t4mwtKH17PLj7RrAFAUvxX6xHow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KR3IM8Q210jUY1iQUzXvprDWQKemxAlo0zy7IZ5ub3wbggfr
	cL4hlh/Hk2ntT9tocHRjeVgD0CfEo5JNYZOlb/mK47owk3usajKhl0oWOdGzHDjpZBq7gMy8ynM
	GQYNWBvGEf5Z4XxhPiV19z3Bfwqj+HOE=
X-Gm-Gg: AR+sD13lDKa7gttCh8P/KPpO3Zz/yPxyouRkC0qHek0fuGRpBvFhmhoQc3bqx3pzwbf
	5FN7jghSRN4L+gOaBes85feZI2R++uMbBQBQDtIT3Y0Zbn4tvEs1wA0UhnwtlyQ7hK2ub7hBeHM
	d1TOmA8ARkVg5O+q24Xu5wV6bCKn37wXojYtyw85sxMn8CioM9dvWhVUcjaKuXXu7EIi9jwBewQ
	BjW/zqSyjNS6VniEC/rjaqpdL3K0CVsSm9AGpDics1oG8XxMWt5i9daqbVsfGDac6Bqv7gOAeZz
	XZzBhUyL1PmfSWfaJRvRcwgEaWTAjnyJihqrn8kMKWtXUw==
X-Received: by 2002:a17:907:9814:b0:c19:45df:1856 with SMTP id
 a640c23a62f3a-c2188a9c1dcmr527333466b.17.1787058665803; Tue, 18 Aug 2026
 06:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810194215.3754591-1-main.kalliope@gmail.com> <CAM1=_QTvdWzBpSGnoLV7wiW0dsn_nc04V8KnYuntptQ5mF9Pyg@mail.gmail.com>
In-Reply-To: <CAM1=_QTvdWzBpSGnoLV7wiW0dsn_nc04V8KnYuntptQ5mF9Pyg@mail.gmail.com>
From: Nicholas Dudar <main.kalliope@gmail.com>
Date: Tue, 18 Aug 2026 09:10:53 -0400
X-Gm-Features: AcwNN1XHCMx74YekEORVzWx4CGffmWW6Q4DUtR82Aia7lWjSu0IKoMhZW4rDKTg
Message-ID: <CAJZwKkis=3NGw9At0WfiZaRYEoMPbQfqJKN0e+vtRDvp4VY5Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/3] bpf, mips: Add signed div/mod support
To: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, tsbogend@alpha.franken.de, paulburton@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	philmd@oss.qualcomm.com, bpf@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Please proceed with the remaining opcodes in the meantime. I will do
> the same on my part as we discussed, and then we can wrap up this
> whole v4 compliance work when I am back.

Sorry to bother you while you're away, I hope the holiday is going well.
No rush on this, but one ordering dependency fell out of my testing.
MOVSX and SDIV/SMOD need to land before MEMSX, BSWAP, or JMP32_JA.

MEMSX, BSWAP, and JMP32_JA are currently unhandled, so any program
containing one causes the MIPS JIT to abandon compilation. Adding support
for one removes the fallback, so a mixed program can reach the existing
MOV or DIV/MOD paths before their off encodings are supported and be
miscompiled.

I plan to post MOVSX today. For MEMSX, I will base it after MOVSX and
SDIV/SMOD and call out the dependency in the commit message. This avoids
carrying a temporary fail-closed check. Does that ordering work for BSWAP
and JMP32_JA?

Thanks,
Nick
