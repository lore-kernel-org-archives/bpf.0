Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794358161;
	b=pfma6pRm+ubjcV1OyL/DQKFc88P8Svmu4f5v8TpvBke0j0Is3kqkfZYikkGnheS7ex/5
	 uc0FMWOTApJLJdiTPgAummTCkt7Rf2Khs1zhft1NESR0y7RMpr7EnqimR8WQfClkvC0tM
	 ENIdxsVxN/EJ2Nq8rcNUyn88e8O5by4xIoRlYf3p7NS0FTMzkUA6J5MB8TsmY3g6VZlFE
	 23WnAVBO/BIGuIFErO7x1xyH4tWGBDNc4nCszEPoys5qE3xr8XU8TIXQMufojuV0KYD1V
	 WSG9XicPnoM7eKPuSLHymAnTHmxHJsC5zmkmIV5H9ZcsuFzxK8rAJ5CA9EV8lRWnr3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794358161;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=swKhZ0AHP3ZQB6LltphbrMRzgm3FUELwdZ0uq2iP66Q=;
	b=sCpRCcOVnRVPnNmYvHrKuJNlRLHnTEDLPmyjk8StvjYewKmnl/jEWxiw23UWvO6AsHyc
	 kaCt/Hr/xakqkX6MlSJoJYtZe4NVwL0kkyu/M9ZfJomJ6xvtLqRFdxIV3mHNKlyhtE9jO
	 PYqQJKuWkH+CW+4D5HlPIZBOjEbqTcWqdf0Uy11QWJo46dqoAZHaphuGqgrQDBdhegfoE
	 VhfztBaNVHs2r2ohWmoKsWqcdaxygPD3JOk+pMcUKv6UH2M2bF6F+CImpbM9BBdWbpxT+
	 TTNYvLvT7IPuq3RrVG51lZSRzqUWNLpJS9qlfbA9WawWLo1F3htV659o9jI8JAFOgiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2lzT8vH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1560606A31C;
	Wed, 11 Nov 2026 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2lzT8vH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557431F0089F;
	Wed, 11 Nov 2026 00:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794358160;
	bh=swKhZ0AHP3ZQB6LltphbrMRzgm3FUELwdZ0uq2iP66Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R2lzT8vHM7QXhGg35dYZ8cAVaEsVYRDJ84/HnxRDCPDDEQAWvVRyn5RKUjZyP6CRD
	 PVIlAQOJOxhxEnT+9b+DWSiAqdFZJjdNIzevIww+7KWsvGlB+gaZ4ut3AIHFGO/LQg
	 hYThDs2g8SV1bLA3xymMCA/iz+zblTT/YdPH71OyVBtJHyjgVN7soWmmn39oHMCIOH
	 eAwMusKSqBAQhbAJ2IdmApkLhebs896gsJ9d7FoxA/ES5/4KIGefHP52Gb4dTqR/dd
	 9dmVd46meJj/8+zRwP6QcQmKbwjDAdKU13O7cHmMaSeQrcrmkwsQw6iYDDFR4Wc+5+
	 SHBn8q7B2M9sQ==
Message-ID: <sashiko-outbox-208036@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] samples/kprobes: Add batch probe example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261109195827.1091410-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109195827.1091410-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:49:19 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] samples/kprobes: missing ANNOTATE_NOCFI_SYM() on
  kprobe_many_call_function()
--

commit 0bb6f0bd88ba358a50c5bd0da72b9a9137c6b243
Author: Jiri Olsa <jolsa@kernel.org>

samples/kprobes: Add batch probe example

This commit adds 50,000 generated x86 functions and a sample module that
registers kprobes on them in a batch and calls each function to verify
the probes.

> diff --git a/samples/kprobes/kprobe_many_example.c b/samples/kprobes/kpro=
be_many_example.c
> new file mode 100644
> index 0000000000000..5a58908c840c7
> --- /dev/null
> +++ b/samples/kprobes/kprobe_many_example.c

[ ... ]

> +/* The generated assembly functions have no CFI type metadata. */
> +static noinline __nocfi void
> +kprobe_many_call_function(char *functions, unsigned int index)
> +{
> +	void (*function)(void);
> +
> +	function =3D (void (*)(void))(functions + index * KPROBE_MANY_FUNC_SIZE=
);
> +	function();
> +}

[Severity: Low]
Does kprobe_many_call_function() need
ANNOTATE_NOCFI_SYM(kprobe_many_call_function)?

Because __nocfi omits the kCFI ud2 sequence before the indirect call,
building with CONFIG_MITIGATION_RETPOLINE=3Dy, CONFIG_CALL_PADDING=3Dy and
CONFIG_CFI=3Dy causes objtool's validate_retpoline() to emit a "no-cfi
indirect call!" warning (breaking the build when CONFIG_OBJTOOL_WERROR=3Dy
is enabled) unless the function symbol is annotated with
ANNOTATE_NOCFI_SYM().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109194916.1089=
703-1-jolsa@kernel.org?part=3D13
