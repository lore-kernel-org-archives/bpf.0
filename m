Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246142;
	b=nzc343ZVcY6tvGGeQmO6yo4FyFJdhaqP1YIJpqVsw7UY3LgqfqqIHlZFeS5E1mJCZ60F
	 SGSckH2qM4WfDgTZnKLZAwrX90kH8T/GwUaGqCi62GAgbXNmYr4rzx8ErqZBaReyoIG0w
	 UXEwg0f9iYQRnt0U1+iKP8G/IQuE4aVNX7bQH4xDIEDW8AnAYiDGeFo53YO+8ITDsaKbH
	 0izfllEn/Untulx/Jpi/ZzORqEuF62SUJxNRPVq/WVrIcDQT5yAG2LS385WrTGjfT1TWP
	 n2dNuHBzk9tTb/VY4pw++PKvSVtmlm2pPJ2Gs1/NYIGnLfhKmMgZUgAnC1d64t0kwbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246142;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=7ZaQpxVWiAiY8rKJg9D2aec+u+ReKo38L6WIEkkAFII=;
	b=Mofc+Hly1HMz1knT5Iwi1epk0552OjnIpSBVG1aG1V7WZ7dOuPrEuLNNL1LIHlOiiDuI
	 JoVI4mmwhIxoRHyU5cf3w6C+FkiX1JOIRcIgMkv7Qjwf6n+J7EQMRfvTDgZyY6r/a2ct2
	 p6uec/22iAcjRYSIkRPnq9M1KsCNJZjDWQBtb2/SOeK1nBwLdC0XA3D6+Z0j9FSPR/XZY
	 8yNrmC/LCk+84TJIMJ/7uQndfpiJp8DnVa21aTyQ+1hYs/CEmHkAo6YyN3BZo6dRAlDfs
	 22BhqEQQx3XwR/Vn0D/Kkt8mNlqxM1M39rP9IAdwrlLR8cLoEgSfkQ7ajsabl5Zpr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGMC6pU0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94031606A31C;
	Mon,  9 Nov 2026 17:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NGMC6pU0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC36F1F0089F;
	Mon,  9 Nov 2026 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246142;
	bh=7ZaQpxVWiAiY8rKJg9D2aec+u+ReKo38L6WIEkkAFII=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NGMC6pU05PAvkLw2pyRzp+Hx/D/Iq4Mj14fR808BAuMJ9UUsJ2uE8fw2x5B98X5sw
	 ibYd7sdBrDeJ6rrWVMZN1K430trfymPP97NuEkvzFMb8ccz6b8ZzBfFZHPX60W9g4W
	 QECfbDJgi28/k/n4wJHNC9tnOILrLm8PCyYxKqbtEj25KQmeUskCI0TPZzcrZ0Ot3C
	 Jj3rOADBmQfcZG7uyeOhvo9Djkk58hgFNuBcBCJ8zM6bnjHhf1MeHH5JOwjaAKLRiy
	 RQ9bAAdmC836Rwx09c2DGvrvi3lyIKbg3cnMXUHnnI6nKdr4NZeEBAHWyxxNpN1v7M
	 OJQ9rl6RWkFXA==
Content-Type: multipart/mixed; boundary="===============0755294377799794328=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8ab81e05089b4f5ec1ecb1bea9e6dc5cc2953a67f16e9369db005c2f3f3ee242@mail.kernel.org>
In-Reply-To: <20261109170550.141443-12-a.s.protopopov@gmail.com>
References: <20261109170550.141443-12-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 11/18] bpf: Follow PHIs in bpf_scan_ir
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 17:42:21 +0000 (UTC)

--===============0755294377799794328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Follow PHIs in bpf_scan_ir

TL;DR: Nits only: in bpf_scan_ir.cpp, isErrnoRange() duplicates
errnoConstant()'s errno check, so the range is defined twice; also a comment
style nit.

> diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
> --- a/scripts/llvm-plugins/bpf_scan_ir.cpp
> +++ b/scripts/llvm-plugins/bpf_scan_ir.cpp

[ ... ]

> @@ -34,9 +36,40 @@ namespace {
>  
>  static constexpr int MaxErrno = 4095;
>  
> +// is Range in [-4095, 0) ?
> +static bool isErrnoRange(const ConstantRange &Range)
> +{
> +	unsigned Width = Range.getBitWidth();
> +
> +	if (Width != 32 && Width != 64)
> +		return false;
> +
> +	auto L = APInt(Width, 0) - APInt(Width, MaxErrno);
> +	auto R = APInt(Width, 0);
> +	return !Range.isEmptySet() && ConstantRange(L, R).contains(Range);
> +}
> +

this isn't a bug, but could singleErrno() and errnoConstant() share one
check?

isErrnoRange() has a single caller, singleErrno(), which only passes it a
range that getSingleElement() already showed to hold exactly one value.
For that input the width check, the isEmptySet() test and the wrapped
ConstantRange containment do the same thing as errnoConstant() below
(width of 32 or 64, then N >= -MaxErrno && N < 0), so the errno range is
now defined in two places, and the !Range.isEmptySet() test can never
fail.

For example, errnoConstant() could call
singleErrno(ConstantRange(C->getValue()), N), or singleErrno() could test
the sign-extended element against MaxErrno directly.

Also, the "// is Range in [-4095, 0) ?" comment is the only function-level
comment in the file using // rather than /* */, and it hardcodes -4095
where the code uses MaxErrno.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42662799554
--===============0755294377799794328==--
