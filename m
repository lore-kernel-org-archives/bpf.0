Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330130E0EE
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135160; cv=none; b=sDAwFHe81QPBg+ltwWB/wDKNZ3I+Cvgrz/8Z9U99hSS6xFh/VA+Oh4+RYY5NZ6glF2Pj2YC6VDPRbshgM3fwajDHgGlkmZcDixN1X66DYByP/aXu1LiBWbNjDaGtmp/wRuIeuxHGcMQWHYBa4+1x4qdHjHh6j7iW0c+u/eEBMUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135160; c=relaxed/simple;
	bh=sC+yfGIpBwk1Bv3jBFU30O2m27bI3h14Cf5kEFKOAcc=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=qVVqdzxp/SZ+oEcnHwK8ainJWN8NUCEgrszDMXaGXNyHTz4S/bh0KrtOYW2tY8gAsRW20CchWCm+rlBRZOs2gWo8a1PFm9Hy33vnXWvC6IZlCW9M7y/owGgYQtHdJschK/hG2eEBNgnfJEqujQ+7UvZQwe7AgrmEt2POMNN1QLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfYlGxLS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfYlGxLS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B501F000C5;
	Fri, 16 Oct 2026 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792135158;
	bh=JhddQceQR7wcUmvObH6Jc6nWl4zT+e/6YRGf2t7S4kg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QfYlGxLSXWoTMOM58NyDDSI4XIOMF6UgnPxUg1997EbjIrA/TjEOCUHpUbUsz8Ags
	 a0VSFE6YXFeaxgpiLz+ncBfnTUl8FDTaZDh141Cb9FWF7VckYl/pdZfof5y7WdC8Se
	 kkUAQiZ0nDJNwMtBNYILIt+6xQ/mxrXNr7Lmvp7voz+VyFAqO8rir+Zo2RzDHR8lor
	 2la/CjdBgFa6xdstUi4PYEvSKHzgBbABNc4I6Zsotfaj82QLHzHIaDgESqXHtOagNq
	 y+uxR9l4W/0pIV18olMWkqLgFB0ek8pRM4Sp2zPhowJIPCZ62SGzWfvWLYJHPX8FJh
	 Kd84YzxlkD9mg==
Message-ID: <sashiko-outbox-173914@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 15/16] barrier: timeout validity checks for
 smp_cond_load_relaxed_timeout()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ankur Arora" <ankur.a.arora@oracle.com>, bpf@vger.kernel.org
In-Reply-To: <20261016070837.440748-16-ankur.a.arora@oracle.com>
References: <20261016070837.440748-1-ankur.a.arora@oracle.com>
 <20261016070837.440748-16-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 07:19:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kselftest: barrier: incorrectly skips invalid timeout tests on ARM64
--

commit bda3f35055835da4a210dfc722306737806214d9
Author: Ankur Arora <ankur.a.arora@oracle.com>

barrier: timeout validity checks for smp_cond_load_relaxed_timeout()

This commit adds timeout tests for smp_cond_load_relaxed_timeout() to verify
that the implementation returns early on invalid timeout values and handles
edge cases sanely.

> diff --git a/lib/tests/barrier-timeout-test.c b/lib/tests/barrier-timeout=
-test.c
> index 9c12cd36e7d29..88b374ceb78b4 100644
> --- a/lib/tests/barrier-timeout-test.c
> +++ b/lib/tests/barrier-timeout-test.c
[ ... ]
> +static char *expiry_skip_test(const struct smp_cond_expiry_params *p)
> +{
> +#ifdef CONFIG_ARM64
> +
> +	/*
> +	 * WFXT waits for the full p->timeout_ns so limit it to a reasonable
> +	 * duration.
> +	 */
> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT) &&
> +	    p->timeout_ns >=3D NSEC_PER_SEC) {

[Severity: Low]
Does this skip the invalid timeout test cases on ARM64 by mistake?

The expiry_params_list includes intentional negative values (like -1LL or
~0ULL) to verify error handling, but p->timeout_ns is defined as a u64.
When these invalid inputs are compared as unsigned, they evaluate to numbers
larger than NSEC_PER_SEC, causing them to be skipped with the reason
"runtime duration too long".

Because the smp_cond_load_relaxed_timeout() macro casts timeouts to s64 and
returns instantly for negative values, these cases never actually execute a
WFXT sleep. Skipping them deprives ARM64 of test coverage for the
early-return fast path.

Could this regression be resolved by checking if
(s64)p->timeout_ns >=3D NSEC_PER_SEC, or by avoiding the skip when
p->maxiters =3D=3D 0?

> +
> +		return "runtime duration too long";
> +	}
> +#endif
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016070837.4407=
48-1-ankur.a.arora@oracle.com?part=3D15
