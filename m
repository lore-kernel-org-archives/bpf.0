Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE0F246782
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781498138; cv=pass; b=A7SUh+iwzVzi/zeL3v8C5mtVPmj7yjEa7bdaTXKu01hxQCfbSlP+DTPfmj1RJ08cqfdU0AD16Y4hZz91f+//MIBajIdwCiTDEBmLJBq3GoP0qdebn5PhP8h8pPvsD1SdPt7UI5FlvAmThiQ0TD+ZOt42QFUxUHLSefTddx0MObg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781498138; c=relaxed/simple;
	bh=kr69be3ayWAg9sIFtBTykti8WXAgb/Wv3JT797c4NMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rzDxemEiglDZDh7ccHXidDwW/aUHdBl1k1+OqFnNU+1jgEleVIXqAlLEUrwyZP2zgzgSqiu/AujULCBpkKPyccltV1TKSCfU6w+MI2VVtiFjxCcn1gb9lIjDznIixFi36B3J1PS5I2NkAPZbL8dSk9svYqS/tV5G5KR5ptE/sks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL/zxuTQ; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL/zxuTQ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36babe2c4bdso1633513a91.1
        for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 21:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498137; cv=none;
        d=google.com; s=arc-20240605;
        b=U/PbAYVKaVJmj8wN+FAxZuc3x+Gg1oERfHH2tAstcGciC9d1AjsD5kgpVzOsnBu2J6
         2hLAmvte4Ot9uXkHjRYzNO3HigsVM61GW2o+cWzykMMt8pYnwDcVb7UbLAUR9HzDMVrD
         AuUGXv80aQce02hsodwqglbbmxbjLNocpgDQXzvCn4+8m+YVkfuMcWS2gX2kWX9DY8hH
         yenWXpeQ6D1z4TxF0sbebtvF5TEQP7aRc2bMhLNCkLxXUgfGu4oilCuDRSg9ycvzIm7O
         xV/okDnPhF93YrIYYDN/118V5+BtVusPMO4CsMe/RjfuHt9yIrBW+V3u4+W48otV2aKg
         TyFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kr69be3ayWAg9sIFtBTykti8WXAgb/Wv3JT797c4NMs=;
        fh=Ux2T8GjMPdpwJRXCKSaOAApXySOz+17JSwVu/s7STxI=;
        b=hUkw1kniemXTX7S24UNDt3CG6ov7P9m0TKvyv+Pa6LZFYZmrz4oM4jjFKL6b7C6V16
         noG48rsb8aXudu2h0kUNyF9U6MSCjgdpN3rANuRPjVx/i9XJrEZFCyArdKiRBEGKF32E
         SBEvyhUOT3/8vPQ8r+JuK3qvdR5hg3oZi9Pw0Gu5crUMIey70SBg8qq03sUfznfgdDml
         7YRe0X+7d8WTwmbqGOlaoPc3W50WL+Ix2kyhhGBJzRl1BNOSt5erksyIaXL0pnQDOank
         QfkA+Z580A+9jIU0DJLcazBGshk8yagLIt3+IINhVmU1xYJFelY1VsDZM3GEPxCMkzRW
         5TMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781498137; x=1782102937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr69be3ayWAg9sIFtBTykti8WXAgb/Wv3JT797c4NMs=;
        b=FL/zxuTQzxfYR/GES+gSClPZ0VDDeUr4phSltscsM0dqVmv87Sjv6NxwcpAWdp4RAd
         D/wGUe8a1YSmlxChBX0+4pUA5cO1HwVZt3U2gBlVOGfJKNk0qhRWulkVUkQYZOXGORSD
         UZ+0+E08iguuvZyxPW1GKpxPLQ34OvXFHRwrVPTdSpcQQYC+Hx/7VGnWHPLpNmfv1s+F
         jrUPqkpJBIP0P1B9Vngs251KT8/GGyvTxLAiSXTH2204tOOHOBgJyVenInGwRKv8xAZO
         eNKDwJOx1x/4FMYle5CUQPpWgs/dkDGYNM4Mxa4Erqez3RblNTy9HrsWfrUSRHCNxnHM
         rlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781498137; x=1782102937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kr69be3ayWAg9sIFtBTykti8WXAgb/Wv3JT797c4NMs=;
        b=besNDOOKYVfkSkrQ0Q9bRIKA0AOaNy1J71mnS03bNJHMbqKpX2SJ/1HkQAJIf9VLmR
         CTSLe91qMQlBISFI5c8Pt8sd/4MxhwKQyCgYd34/DCL9v2MKENNRhVdut+AIHL/orxap
         e1l7GcrwPJjPrhwv9avvmnNDF4qDwQID90+3fDxEZvWPoTXHszRtCn3fxUvYXGjN0Oau
         NOf9GKPw2u5naKiwGe/tzYy2QfLapfpslyFtPsN/cT5E2xuTiuW/rFFBZqU/JCObCPtv
         eMbKuR7+aTg9GH2XC6z/srXfUIR+MCC4dAFqNrHJn8G/NdssPDZd7BB61LorK6Ypohn1
         6Ktg==
X-Gm-Message-State: AOJu0YyiXtKvg7GkVWPmGWbLF4z8RfQN8iFrvQM4sI5Iki7Qf61wECOP
	WKZ0xHzGpg6zPeH2sJlm+BdpVTomUi3V2A6bRekq5iTsVLCZs/vOituM5h1z2QBGuB9CL2lkKIc
	iEMIAq2dTY/8+hxaRXFnrvzD5IJEDnec=
X-Gm-Gg: Acq92OHNL3JqiPvWE3C0K8mCaAUVx9gg4KGMhIOvblwiJJFV8WSwrqW6fUzIb52hFUH
	9ssrr/hwcPog6xFCfIxCj+zfHAxiN3c5g96ao7Pc1lftdN5QO2bLcNHWwdWl5c/e/9TKrvKXNaA
	jHCXZ//NzpSYYuJcgh96awPR3r8ijY+IVpUgCwWMjzkvK4qanbQjXH0ZPPLrAKyw+9JSnx2nAPb
	f8SgzU9iyMzb8BdrFIV/Rs7Px9iUHhXzqs6xLZXBoNVdMNMx1sWmG3tcJ9S9f/X6DbjE7qrMx8V
	ZR0pWmU6zRnJbTf+qX9lAzDJr4RdEjLBZi0hbtDYtbqScJkh59LKjmIV97Wa2OQFJrxi+to0xQ0
	i4+MY3EQVpRpSu7ini9OB4zWz
X-Received: by 2002:a17:90b:184b:b0:368:83e6:ca95 with SMTP id
 98e67ed59e1d1-379fee6a86amr13337116a91.0.1781498136914; Sun, 14 Jun 2026
 21:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614163352.1060813-1-find.dhiraj@gmail.com>
In-Reply-To: <20260614163352.1060813-1-find.dhiraj@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 14 Jun 2026 21:35:25 -0700
X-Gm-Features: AVVi8CeSjG5b0oVhd8RvAHScR8HE8jXbxyorXU7-8c5VKOTa6az8Pno987o9DGY
Message-ID: <CAADnVQK5XpDAnqY-x6DNBYn_bK42AgayT7A2Smxvs1v9=0RzBQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add arena direct-value boundary test
To: Dhiraj Shah <find.dhiraj@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 9:34=E2=80=AFAM Dhiraj Shah <find.dhiraj@gmail.com>=
 wrote:
>
> Add coverage for direct map value access against BPF_MAP_TYPE_ARENA.
> For a one-page arena, an offset of PAGE_SIZE - 1 is valid, while
> PAGE_SIZE is one byte past the end of the mapping and must be rejected.
>
> This covers the off-by-one case in arena direct-value range checking.
>
> Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>

Sorry, not every branch in the kernel needs a selftest.
I don't think we need to spend CI cycles for every future patch
to test for this unlikely regression.

pw-bot: cr
