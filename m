Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C3747532F
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403641; cv=none; b=aAB/dEFKszBDSg+sQCWiOsSGuaSQz65gjcHs2s8n5ztukvA4gRVabhOue3CFnIjlKEJFCfpICVbR8/qRTsRJAHx9PUt4/JvjnXrGDskpwUbZ0ZsDgcppcHDBwLbgocljX0iQiXgvGnPiKEnwGJynIAeZ8jxvs8Wq7PYPKwXN2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403641; c=relaxed/simple;
	bh=w2NuJeF4xZrPcKb501YrUyVVkI1q+glCYE/WcDT0Avs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOhLoA8+C/myGCX0rKA981doUqYM3TrZ8lWxhck8Ty/r0/l0653RIOadLlxBLrT3WVjm6SOOUg451/NIYg0H9prG5nDdiJwBbhBRk+RYNVaowJNeDDBBjYu/xkJhMPqKRk1PrtWsr/0efU8MJufv0bYSzSLYG0HljBkkz8eujTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yti93smk; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yti93smk"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so1847989b3a.0
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789403639; x=1790008439; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=w2NuJeF4xZrPcKb501YrUyVVkI1q+glCYE/WcDT0Avs=;
        b=Yti93smk+vkeMJMQwG1tN5gu2AcZ67XVdzW090yI9MK2dlFMD5o1/8xTzDj/P2DZ9P
         xOGHg+i8/GDTLTZ040AsVh7PREu+uI/HmiJrYU2ZiMC4gXKo/+4f/HJIlIM3ol9gnRO1
         nIkJOy63Aws2JQvoubqrt7OZwF8ztrNJcScHDAp/nJFOKaLdP/08GDtVLQWYfGHdO/7h
         rV/9sxxHN8fnY48iANFCof5T+hXRiuZIRYty9LAs8C2bGXnZy9OO6o6emm/HNiBaZMTy
         zgETMXeNguRZ30hq2VtmKLZzsblIM+wDlFqPAtAceCcMqFBU2en6Uw7fJ4xVmUkd32Y9
         HK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789403639; x=1790008439;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2NuJeF4xZrPcKb501YrUyVVkI1q+glCYE/WcDT0Avs=;
        b=Q4QdKPmyzxqlm7wB5hvcpAykD1P7VKVsEtBjxXyGaqDwgnaPPfcwzmBb5SU37LEBSX
         DsQQXVkzw3FYyi2zhKxJv6SW/mNK3y5KSaf3jnNYb3Puos58aZ18AFi2MQzrtJHCJnRw
         xGFI5/uA8ey2IwQSkFoigrqhUda34MisJ3PrcKJtxWWrT8uPHVu5tCJhIJW0QALyZgnA
         Pf5e0OHWpF15qPp77J6569lUqw0U4Hg/PiSs93Tp9vHjPFnng1HsjCNchKlpNx7dFjft
         bd2DLCakhlfcduoskYHvkcjYBRtfVzsp3j4rIrtJSih8FZ0oT+oE89GFcSKwAgeU98om
         a8ng==
X-Forwarded-Encrypted: i=1; AKwUvBxaJcMLY/nqepxwQncteUWw9AM4oh0c/oEtn1brbTcdoknGzkuPvmHWBlK/BqpnnC16Gaw=@vger.kernel.org
X-Gm-Message-State: AFuF++lDEakYmShJJnJDZlkJcFMZkXeLb1LUjSnpD5JFbcGOZKTkBTSJ
	hkPBIg935RKSIfs1xtcEJI5m/trWlLz6sNBk6JL9iY7TgS+tZmYTKEQS
X-Gm-Gg: AYBFou0YE4y8lBRpOrlHtLtX4yUrLtcclrDtpPpR2Opc8jCcgmB6KsXWaplh0ylVGXN
	qUCM9wKWalOHHRLnQVnGTZY5t/DQEthchx/txoHO/mNRbXzPiGVyzELbCLkiffC+R7pjeibN5xt
	lKHwIZna549Vxcp+bf8EWP+86xYnxLciXPimS4NVJDYmZlT1CgXtk39pyMwIJ1Q3RzF7/DO92nh
	UMace+XDazxZXS77Kja6BmXAukrNnq5LLOL9ooHTJ6FhwbC7MmZ8mpsbIWzSPEFGt5hxYoSSYTk
	H2ujJe5VbtGTty2kd5dhOPnYv1CEN5TGxyZlyT85cTd1glEYDCekzW5uhR+pxSVQkNycTRmLoFt
	Tlr90mgq5Msk8KPGUZX6szN/h80RMQz4118RGKT8TGYkgSuRF7SDYpnHsBjvRNTTSrD7FIjWoTL
	uTyPdcmDuKy+9SqcUr0U8Ou1VqlWc2paTf3rcTqgIZYdB79uzMkuTjgdxI0x/G/vNr0W12QI50V
	QmbqRAfP7MyzOeQD7QYpvx4uPU=
X-Received: by 2002:a05:6a20:7287:b0:3da:7154:2ebf with SMTP id adf61e73a8af0-3db404df598mr6624038637.9.1789403639228;
        Mon, 14 Sep 2026 09:33:59 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550df9sm5181292a12.16.2026.09.14.09.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 09:33:58 -0700 (PDT)
Message-ID: <9c64f514a0afb6a491ff316246ec6cefa4adeff7.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/2] bpf: Compare stack frames in regs_exact()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Mon, 14 Sep 2026 09:33:55 -0700
In-Reply-To: <20260914161340.3419141-2-memxor@gmail.com>
References: <20260914161340.3419141-1-memxor@gmail.com>
	 <20260914161340.3419141-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-09-14 at 18:13 +0200, Kumar Kartikeya Dwivedi wrote:
> regs_exact() compares the register state up to id, followed by the ID
> mappings, but does not compare frameno. The PTR_TO_STACK case in regsafe(=
)
> checks frameno separately, which is bypassed when exact comparison is
> requested. Consequently, infinite-loop detection can treat pointers to
> different stack frames as the same pointer and reject a finite loop.
>=20
> For example, initialize fp-8 to zero in the caller and to one in the
> callee, then pass the caller's fp-8 to the callee as r1:
>=20
> =C2=A0=C2=A0=C2=A0 loop:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r0 =3D *(u64 *)(r1 + 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r0 !=3D 0 goto done;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r1 =3D r10;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r1 +=3D -8;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto loop;
> =C2=A0=C2=A0=C2=A0 done:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit;
>=20
> The loop terminates after reading the callee's slot on its second
> iteration. At the loop header, however, the only relevant difference is
> r1's frameno, so exact comparison incorrectly reports an infinite loop.
> The same problem occurs when the pointer is spilled to the stack.
>=20
> Include frameno in regs_exact() so both exact and ordinary stack-pointer
> comparisons enforce it. The field stays zero for other register types.
>=20
> Continue to ignore precise. Precision marks control whether pruning may
> ignore scalar ranges; they do not change the represented values, and exac=
t
> comparison already compares those ranges unconditionally. Marks can also
> change through backtracking while an ancestor state is still being
> explored.
>=20
> Fixes: d5b892fd607a ("bpf: make infinite loop detection in is_state_visit=
ed() exact")
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I'm going to land '[PATCH bpf v3 0/7] Misc bug fixes - part 5',
which would be in conflict with this one.
After that, could you please respin, but try to move frameno inside
the bpf_reg_state's union or near the delta field?

...
