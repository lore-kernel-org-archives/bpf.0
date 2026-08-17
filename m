Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85D943A7F3
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 21:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001173; cv=none; b=llIRknAf14rNaGELCntGsRirh/m6+v3RRC8JiHI5OBDpxLv46QC47MMAaRTfsU4nl4RFXjteAy50HEOJ+GbYZz/f9G/h1HA5pGUK+JivFzK3t5G6KORzqOnzTamIZtw2yCTx3JN44HRGpkIBZ4pRZVRG38Z9ud7iyC3yWGetgYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001173; c=relaxed/simple;
	bh=KVC6xJCtb9J2TNDqmGLKqNn673BQ9b44k25nXSfjcec=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9QtPq3B83vmBwzDAojVeNuPHO7YPv2Fwbd+tVqA5nHiPTTUqXz+7ULezzUa6tEjvJZmz81udQQpmhh8APRcsQkZFc2GQ7V6PiIFa/Ix5kQX47N0U5XukKWoj743/Sd/xvbtq4HhcVewASnWAkvgx8lBvDIQ4qBPQlmB4akCGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0J16X96; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0J16X96"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E51F000E9;
	Mon, 17 Aug 2026 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787001171;
	bh=PB/Ju7pQiZbCa2uJ09RHX+Z7fddzGlvUk9ZDGc/K0xY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A0J16X96xZxkXT0uFBhRU35ZLHcuSfktjeXD1c/3msSUx1TsGlQPJnfnsFs7YauSB
	 Xe4408+TcgTzn1PBIiej7PGwArac7z6l1ydeea05cGWqtDf4wldZw12zMGW7YtE6Lk
	 iDfFfSW9s/SrtxRWBSlMcMV7iYiVbTe8V/QrHXUsnn2M/1hia7uIdoPlA/BkrCQXtP
	 XKKqcI9gXx5afbxYGzB++H83cp+wJyH2br1oRjh9E+TnPN/zlcIMTmt/iSVEHhqLJv
	 WtiKxgUXoeh6JoJSckNnXPKfmFhpfqJZZ4vboToEpj0InwgYP9FwU6wRKEPJlyABb+
	 gB0EU7m+tJfuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] selftests/bpf: add callback stack-argument
 rejection test
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260817204812.1637171-3-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260817204812.1637171-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260817204812.1637171-3-Jeremy.Jean@oss.cyber.gouv.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 21:12:50 +0000
Message-Id: <20260817211251.6A5E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added selftest lacks a `__msg(...)` annotation and the=
 verifier silently rejects the program, rendering the test ineffective at p=
reventing regressions of the vulnerability.
--

--- Patch [2]: [PATCH v2 2/2] selftests/bpf: add callback stack-argument re=
jection test ---
commit 3ed3bf88f0e2a4dcd1bfa96fc2ece2b85d98465e
Author: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>

selftests/bpf: add callback stack-argument rejection test

This commit adds verifier coverage for callback subprograms that declare
incoming stack arguments. It passes a nine-argument callback to bpf_loop()
and expects the verifier to reject it.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/too=
ls/testing/selftests/bpf/progs/verifier_stack_arg.c
> index 7e0ce5db28a0d..50b276fc2c3f2 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
[ ... ]
> @@ -79,6 +86,31 @@ __naked void stack_arg_two_subprogs(void)
>  	);
>  }
> =20
> +SEC("tc")
> +__description("stack_arg: callback with incoming stack args")
> +__failure

[Severity: Medium]
Should this test include a __msg(...) annotation to verify the exact reject=
ion
reason?

Because the test manually prepares outgoing stack slots (*(u64 *)(r11 - 32)=
 =3D 0;
etc.), it might fall back to failing in bpf_fixup_call_args() if the primary
callback check in push_callback_call() regresses. This would cause the test=
 to
falsely report success even if the intended security check is bypassed.

Additionally, push_callback_call() in the verifier currently rejects the
callback by silently returning -EINVAL without emitting a verbose() error
message. Does the verifier need to be updated to emit a log message so that
this selftest can properly assert against it?

> +__naked void stack_arg_callback_many_args(void)
> +{
> +	asm volatile (
> +		"r6 =3D 0;"
> +		"*(u64 *)(r11 - 32) =3D 0;"
> +		"*(u64 *)(r11 - 24) =3D 0;"
> +		"*(u64 *)(r11 - 16) =3D 0;"
> +		"*(u64 *)(r11 - 8) =3D 0;"
> +		"r1 =3D 1;"
> +		"r2 =3D %[callback_9args];"
> +		"r3 =3D 0;"
> +		"r4 =3D 0;"
> +		"call %[bpf_loop];"
> +		"r0 =3D 0;"
> +		"exit;"
> +		:
> +		: __imm_ptr(callback_9args),
> +		  __imm(bpf_loop)
> +		: __clobber_common, "r6"
> +	);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817204812.1637=
171-1-Jeremy.Jean@oss.cyber.gouv.fr?part=3D2
