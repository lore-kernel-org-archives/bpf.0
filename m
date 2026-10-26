Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986794;
	b=Qj0LVr+7ZbhSeuaP4HOWT2IMczSXFWMrvb7rmQqO+IEjzTxI1TzCrwewMYWXRkOPo+0g
	 PtoweX22oQk+RUY8I9QZ3KOCrK9rupFrS7GBRww0cRqQKIJ0fw6ac6eF1MmSETz4PgJ1B
	 XFSU/P7R4VsF16B2lm9hCQYPn3YwBHv+776aUNo66rKkEI3tX7B45yfVG25UinD8e5TUr
	 vKeecdqE84N9lCttZ2SpUo3bovNmyzbQHx0r2NEFJsJAik4eXXpNZninVG7n+Qrw7xyJN
	 YblQ26dTSn3LWBe2IUoU2MKGXiSwIGObvrD+bFUEPF+FXRTHzPj8zqelF/DPR6eaF3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986794;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uFQ0R4JAyO5OiaeVhDeObjUBW0Dkh/ZQyTGNKhfTjnw=;
	b=YMOTnoUpNAkKRZT41UCq5Ue7eo5yVSS2FTo5CGGafByXFdXftN1z+V3Tvn2ovMRzJuoJ
	 xsHernsh3vrrJfVIlPfVnXseHfhbYXa3tIIxbHjiYT2IbaKyri0X+HK3iau625L7HRCVe
	 nr+ARzXfuKQi/851Gv1Ed6pSqTxWNad/NBzmOgnwYxYHKKqf36pdA4FhoGNed9PggPMCD
	 BKcl525jnfBTDczj/YYnkuhJiCGeliCSXcG1Iv1sQCgIXJtv/W/rKX5IICeei5ekz5w7X
	 BH/s/Lzpc1eVneKc4Rl/u99IdeJjZSLh5+fJ1Q+lO8egfCqd+MKMusNtlwqxH5/pPgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkl5U4R3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D67606A31E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkl5U4R3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A338C1F01825;
	Mon, 26 Oct 2026 03:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986793;
	bh=uFQ0R4JAyO5OiaeVhDeObjUBW0Dkh/ZQyTGNKhfTjnw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kkl5U4R3PxxQqiagsajKMY0Ds4u182uAukdrOm1xQHsXqX3XIMHbc7hn2LKpsKdSZ
	 RPOo5w4bX/umAPijFSTc3VPHuGWkwFlnT6m4SxjNR6t54tiK0IucWGdu3Y4/DbqpYa
	 AeZt/9ZJ5WHWaZ75sOh4IuomaTGJhaPHl1LYs58gFLMlnVB71848whEz+mhQJPNh/5
	 /zfrD9WaYDc75cDwvN42w15zj+qPrefqqIaBgWdjxZLw+GEhiF0NcXVx+KfPZJk9n3
	 JWr3iVC8nBixm4JEzHabbDUerN38F40LAYTbHinyehTCR0A8AnrJK+R/XVUi7Wh7Cv
	 xJFpkvrqy6CBA==
Content-Type: multipart/mixed; boundary="===============1185326115924076152=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <66926cb5270b1529b7813d2675c710e4ca5962001b5415e89e47e4d582ca960b@mail.kernel.org>
In-Reply-To: <20261026025943.404450-78-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-78-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 77/81] selftests/bpf: Test states that are not joined
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:13 +0000 (UTC)

--===============1185326115924076152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test states that are not joined

TL;DR: Nit only, in the selftests: depth_40() and depth_200() repeat the
PUSH_OR_POP asm sequence with different constants; the macro could take the
stack size as an argument.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
> index d92215c5b923..1891995df973 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c

[ ... ]

> +#define PUSH_OR_POP					\
> +		"r1 = *(u64 *)(r6 + 0);"		\
> +		"if r1 == 0 goto 2f;"			\
> +		"w7 = w8;"				\
> +		"w7 &= 255;"				\
> +		"if w7 > 9 goto 9f;"			\
> +		"r1 = r8;"				\
> +		"r1 &= 255;"				\
> +		"r2 = r10;"				\
> +		"r2 += -10;"				\
> +		"r2 += r1;"				\
> +		"*(u8 *)(r2 + 0) = r1;"			\

[ ... ]

> +__naked void depth_40(void)
> +{
> +	asm volatile (
> +		"r6 = %[zero] ll;"

[ ... ]

> +		"r1 = *(u64 *)(r6 + 0);"
> +		"if r1 == 0 goto 2f;"
> +		"w7 = w8;"
> +		"w7 &= 255;"
> +		"if w7 > 39 goto 9f;"
> +		"r1 = r8;"
> +		"r1 &= 255;"
> +		"r2 = r10;"
> +		"r2 += -40;"
> +		"r2 += r1;"
> +		"*(u8 *)(r2 + 0) = r1;"
> +		"w8 += 1;"
> +		"goto 1b;"

[ ... ]

This isn't a bug, but depth_40() and depth_200() repeat the PUSH_OR_POP
sequence above instruction for instruction, changing only the bound (9, 39,
199) and the base offset (-10, -40, -200).  Could PUSH_OR_POP take the stack
size as an argument, the way PICK_OFF(slot) does, so that depth_40() and
depth_200() reuse it instead of repeating the sequence with different
constants?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============1185326115924076152==--
