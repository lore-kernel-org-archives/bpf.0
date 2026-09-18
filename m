Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B7C4F93D2
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755208; cv=none; b=GST2RADY99NGdt172a/LwitGQfMndiGHqJAUKQ8xjTtFcIQG50sC0pGB3t+LFpW1HvwVn/tVUVbM5XQ42n2ntt9pMSRJI5Z4wQ41GmvuR366mYOLX5s5hSrfMp57Sbn55IxkJX3kAZhq6uKPpCvsQtZ6uzxqR4ju52dYw30LQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755208; c=relaxed/simple;
	bh=mqY0SP1qtB4rg0i16H54rlaMkHHjWsjE+yZLjAPA734=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SWbC8o7x1dgrMLEOp6NEtB+fL24TGSHnRuffW0HNzpmGJ468o4mgnE+81G4kUNxjSphDDzuNA+mCUF8joKdbuD84EjkRgd5r86q+LxDf4rh8zypNeas/o5laEzgV4ZLwgiiHkMfxhwY5+X/y1g0WvZOuspozokxmu+KB+7N2lIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5Ik09x5; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Ik09x5"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a1676000so974033a91.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789755207; x=1790360007; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZHAIpjNEFBK0U5ZPthhUSNAp6Hi9MuBq9qgMHDGVbR4=;
        b=m5Ik09x55UkRdynenG7Zqre8XWhrPv9+uidJLMw5VnHgS4wBb1bNbBPOvT9uoHnNqT
         RzYf2CMC81maxO0G6tCbzQRIbhAv7bC+XvHmrog/FpgowbEfvLogTRFQAcYDjYsfrM73
         CWe35ui27IzRvejt9cPqrP8maOxQAky7dPnxQRAse6wYeVzhx5SNyXJTGqEwOmIPL/41
         g0wcV+mNnvTDV1QvcXP9/ZYt61CbAjEs+OVVO9KOu0P6MtR+Qs4hKC7MMnZ9klufhLBD
         FMoYIK9wETFMWmrfGwEKxJu6S08D9nBYrfZFf8eO2GDVvCAVQnU8ejoOQrriHAEhXJPe
         nyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755207; x=1790360007;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHAIpjNEFBK0U5ZPthhUSNAp6Hi9MuBq9qgMHDGVbR4=;
        b=J9xRbKM27cY2RUjhMdP0pxfayQqVjax8SpeZXHTVoso8nmLLgKW2CdQe2t+Qr/IO98
         jjdFiWFMnTskQmPo/x9dC87srBdLfif+CTS6aBl6w0omT7GnmeZNZvPVtF0Qk+kmIiAp
         qekaJ7z78afofPshLCg0L1ldBzi/yBDHCB8Q+CVEqe05i+NvStsYtu/0MNQU8ADmWKa3
         5yLymfH6QS5pJfw6+VwqUSXREdBjzqh+3ipB9VMPvzthxdG+OrWOm/JPUbsFq3/+vosK
         5wNeMBPTQCh/m7UfX8hhBOlE5firEjpTPcUpdAZXqqvuEwa/KsV0uKTaJqAz4alAicTm
         K4Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxV6ZOZgfi2EyIkCYcov2HdFbVRxSEAia5yXYvgfeo4Pmzk7qRZgCTNnCbJ5Ab1PUxaPZI=@vger.kernel.org
X-Gm-Message-State: AFuF++m6Y+zd9jkd0sEfpvSFznN8+wPgNHVDVB+FFUBBxFvjettLyAwI
	9jE5AMVUD08opGWgR34nKwYaoyxPh1PECGoN7c3/0+CPxtH0mF+niIkM
X-Gm-Gg: AYBFou2gkSwyeHyMGHwVYQ59aIaHUxHFrNswUQfSRQtofJM9IOe2W0hpHBLvxsKXn1E
	YBCJ77jbK9Xj3DXadSB+nwTb1J27tTMWx2cnik8AhS2Sfrk7wGBN92g+9vyX/iKJ9bkCsrEVAIO
	BePhGdso4oLSX8rZco8h66jbK2rnHfBsIw3dad993sT+OEiqWOXSpayOfWt2e5fQCw0U9TvpAK1
	s4aC9mTlf7Gbql7egnVUnt5TuXsSv7PpiyfVo4rKjvffpPEcpZKL0vfyeYILSA8mQwqOmqPjUk6
	aSDwpDVEpaeSioMtbXKui2wXoZDRbNSFBFPAsOj+SC4vnWt1jeL8ISi5ucr5ivkbBZPxqn8+7j+
	d8hwAmtpmAY16Ofh1MBzAlH6pbrHoLsIEh/TiMmwc/twjF0uVyziVsKUnfbyde/ckZ6k+SPHpRK
	W/4K6Zj16y9Qk17lnSgaZLjb7wZmVV5+0GO6dSGDnxGQa+4pLbOxWSDjAYs7PAouQpQGjrwae5d
	2JuTD9uMQjxIN0vDPlB4pWNuThnss8FOgoV+Tkd0cZjanskurJp/a5WVA==
X-Received: by 2002:a17:90b:2b45:b0:39e:6a81:f34c with SMTP id 98e67ed59e1d1-39e6a81fd19mr1067218a91.38.1789755206824;
        Fri, 18 Sep 2026 11:13:26 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d55cfsm374771eec.30.2026.09.18.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:13:26 -0700 (PDT)
Message-ID: <c6c10b90702c49a3d791751a09df4f97799a1f28.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Compare stack frames in regs_exact()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Nicholas Carlini <npc@anthropic.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Fri, 18 Sep 2026 11:13:24 -0700
In-Reply-To: <20260918011313.3053497-2-memxor@gmail.com>
References: <20260918011313.3053497-1-memxor@gmail.com>
	 <20260918011313.3053497-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-09-18 at 03:13 +0200, Kumar Kartikeya Dwivedi wrote:
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
>     loop:
>         r0 =3D *(u64 *)(r1 + 0);
>         if r0 !=3D 0 goto done;
>         r1 =3D r10;
>         r1 +=3D -8;
>         goto loop;
>     done:
>         exit;
>=20
> The loop terminates after reading the callee's slot on its second
> iteration. At the loop header, however, the only relevant difference is
> r1's frameno, so exact comparison incorrectly reports an infinite loop.
> The same problem occurs when the pointer is spilled to the stack.
>=20
> Move frameno into the type-specific metadata union, ahead of id, so the
> existing prefix comparison in regs_exact() covers it. Ordinary stack
> pointers do not use another union member. Iterator and IRQ stack-slot
> states use their dedicated union views and do not need a frame lookup.
> This also keeps bpf_reg_state at 80 bytes.
>=20
> Move the states_maybe_looping() boundary from frameno to precise after th=
e
> field relocation. Its prefix comparison continues to cover the complete
> value state and now includes frameno.
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
