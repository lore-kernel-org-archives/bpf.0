Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914530;
	b=eYQbBOeS9c1CV0vKROu9wwD/EIKTFjlHno1U3+vsTw96H0Wsy7h/ktw40EYWcTXnvcIy
	 mjA+3kSJIAhlaSqlJ/G3gEGqiz0QDEIrWgDO4sxVNmazOfx+bb+wToeDe0LXdUDO3y+Ac
	 U2vf1Ab0oUaarwNvAmEIaOI53lWjT/T2ShYEXF2Ene0gNWeJxxSvxJm59AdQhpyunM7EU
	 PVcnIKoouRKtNWs3C1D/PH+JtoGiRr/Y0BI6SEwmuIn8cdWhTpb+LDIWYcDutYHwQWbZE
	 XrNMzqYvo7IQzBKo4pupoanUSpViTdouKKI4i0frbt++I3A8lEty2UF53WNcMO52VBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914530;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=U4c00xK7uKdWC1KRUFcC0JBh046obanEPWNQ6hmTMmE=;
	b=0hTxIy5+g7OUp0BKay8Yunw7XmuA4q+gonWBcC7LacRC0h1lzNU40o8SB5KFty54aBH9
	 aVoTLkeLjhzvmjjtSlazKiIV3xkasB5fNOGBQ+tvP6xS2jPvziLN/izFfd7Xp3BCvIIVE
	 LZcSnN9/XIZt3pi5IAjvGd8zvKonvlvEM4XoQvzFCs93Z7uYoTTi1p0gPxYMXJ4PkEkBy
	 PyHqNtTKdrd0vMif7YvKZmj+98ndXqejYOB29fnJjOd8q/6jVBrcm/k8or2ag/T7Y/Oip
	 zBi7P7Y3wEL2Rx0Ys+YKjBt2GP3LatTHLXKyztfHJoGM++40Hg70SaMuBH80SlXoZFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBCzevZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FE606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JBCzevZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01D1F0089F;
	Thu,  5 Nov 2026 21:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914529;
	bh=U4c00xK7uKdWC1KRUFcC0JBh046obanEPWNQ6hmTMmE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JBCzevZIf0jWwObsF9MRFXT+ANi2RzzpDinrAHXcT5Eq/2b7Qj/qVVHkBTa0wMqmK
	 /CEQOmAeIrsw0+XceGIXKCFhSBzJq4i5KENao3ENmbNG8wXwtpKsKyx4ucjcStUBCS
	 rmIYxSznQ//tIvfg1X5OPAAp/05ck8DH2t59/Nfnj86khWmN1y2imPB6wIyYPfAEC/
	 hiXKmdSsqhBbH3BG00bHlu1/xGZLKgtetrWnBX+jTQS1QysoPq7z9josOvUpC6jz5h
	 BT+qbYbFZqZZ7N5Zcc0M4QlqUqSOrT8eNWecHMJM1QPKTHwQIm4uDzeINxEvU4MEe+
	 OmucA55LPkGnQ==
Content-Type: multipart/mixed; boundary="===============6794004796620136273=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <bec12a456aa6a4500012b299ec64909013b1338810f92555d361168a5b4059f6@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-35-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-35-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 34/35] selftests/bpf: Test progs that run out of budget
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:29 +0000 (UTC)

--===============6794004796620136273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test progs that run out of budget

TL;DR: Nit in the new verifier_budget.c selftest: the comment on counts() says
it returns 0 when v is NULL, but the asm returns the loop counter i. No
current caller uses it.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_budget.c b/tools/testing/selftests/bpf/progs/verifier_budget.c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_budget.c

[ ... ]

> +/* i = 0; do { i++; } while (i < n); return v ? v[((10 - i) & 1) * 2] : 0; */
> +__naked __noinline __used
> +static unsigned long counts(unsigned long n, long *v)
> +{
> +	asm volatile (
> +		"r0 = 0;"
> +	"1:"
> +		"r0 += 1;"
> +		"if r0 < r1 goto 1b;"
> +		"if r2 == 0 goto 2f;"
> +		"r3 = 10;"
> +		"r3 -= r0;"
> +		"r3 &= 1;"
> +		"r3 <<= 4;"
> +		"r2 += r3;"
> +		"r0 = *(u64 *)(r2 + 0);"
> +	"2:"
> +		"exit;"
> +		::: __clobber_all
> +	);
> +}

this isn't a bug, but the comment above counts() says the subprog returns 0
when v is NULL.  When r2 (v) is 0 the asm does "goto 2f", and label 2 is a
bare "exit" with r0 still holding the loop counter i.  So the code behaves
like:

    return v ? v[((10 - i) & 1) * 2] : i;

No current caller looks at r0 after "call counts", but should the comment
say ": i", or should "r0 = 0;" be added before "if r2 == 0 goto 2f;"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============6794004796620136273==--
