Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE2305968
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958055; cv=none; b=VJ4u3ceei2m+8NVlqpOffzdA0Lro9NzM39TnvpQAc5qfu5/+Tles5cQo9LjzGXtIFbzUWqGGP91d0xMr1rouMm0aH16l8Do8CR82XYwk7tVHyyNG++kMOwRcQq5NhX9Go0Un7A+c/skPMWGTAPoOomSJpSjSVw8GP7nZe5vyCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958055; c=relaxed/simple;
	bh=ddKf8ndAEeBabQs46azWueIkzxoT5KFgXRksnCL2ee4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HEi/NbLENIGdn2x4pUgbleBDZosibAAAdkgwRQ2v3Dyz7i+3h3lQ6LytvTjJP//JABTXzQnDvAH9/J5G9cq0G8PBPu9P47wdaVZJDyLkpmRzyTDi4GRpgfcwsTDJorKw2pcdYfbcnf8Q8oJQ21aXmrSBrLN5AM8HwWh8tTOBY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ineGNvx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ineGNvx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1672C1F000E9;
	Mon, 13 Jul 2026 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958054;
	bh=NolQ1GJUP/99/QcDDOW/72jcu5n7XTlaCqyCiISQDXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ineGNvx7cmphbHqs2j1sPZXYL4z+ge0oJZj0L7Boodq+qUInLGLXVbmpyrGelUgYf
	 tX18X9gEMz8K3MdANG37h5J9f6CM1dE1KQu6NNvoxK8VZZr0uik8qtpdu0cSyS7Xkh
	 3SBqaLi+4eHqJ/KvbjsyWvKM4Cs0iox4QoLEgtKiM8WcgzHw2j1nPhsuwkKvKPYjPs
	 hyYq1bCqJCeij/v2HrlNL9ozg5TiwxdzNCF0RWtLIsTlEFrbeMi3CVmC7oHUO6b7HM
	 dW1FWPJt9/2ygmjn2A1jU3DzDq5/52vXee6EeKVpTewmP33ZBjJJ9dyms6U+/J9BZ/
	 qeK8L4fbPEoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event
 log
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260713153910.2556007-4-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
 <20260713153910.2556007-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:54:13 +0000
Message-Id: <20260713155414.1672C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unbounded growth of diagnostic event log causes `-ENOMEM` verifica=
tion failures for valid BPF programs due to memory fragmentation.
- [Low] Unused static function `diag_print_history` causes build failure wi=
th `-Werror`.
--

--- Patch [3]: [PATCH bpf-next v3 03/17] bpf: Add verifier diagnostic event=
 log ---
commit 84f2d0d4f3731edb22773c28c7395e2076557ddb
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add verifier diagnostic event log

This commit adds an environment-owned diagnostic history for verifier repor=
ts
to track branch events. The event array grows as entries are appended, savi=
ng
positions for future truncation when the verifier backtracks.

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 49106115621db..ed19220aca9a9 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> +	cap =3D log->cap ? log->cap * 2 : 64;
> +	if (cap < log->cap) {
> +		log->error =3D -EOVERFLOW;
> +		return log->error;
> +	}
> +
> +	events =3D krealloc_array(log->events, cap, sizeof(*events), GFP_KERNEL=
_ACCOUNT);

[Severity: High]
The bpf_diag_record_branch function is called for every evaluated condition=
al
jump without corresponding truncation during verifier backtracking, which
records all explored paths instead of just the active causal path.

For complex programs approaching the one million instruction limit, the log
can grow to several megabytes.

Since krealloc_array requires physically contiguous memory, these large
allocations are highly likely to fail due to memory fragmentation.

Could this unbounded reallocation cause memory allocation failures for valid
BPF programs?

> +	if (!events) {
> +		log->error =3D -ENOMEM;
> +		return log->error;
> +	}

[ ... ]

> +static void diag_print_history(struct bpf_verifier_env *env)
> +{

[Severity: Low]
It appears this is defined but never called in this patch.

This triggers a compiler warning for an unused function and breaks the build
when the kernel is compiled with warnings as errors.

Is this static function currently used anywhere in the file?

> +	const struct bpf_diag_history_event *event;
> +	const struct bpf_diag_log *log;
> +	bool printed =3D false;
> +	u32 i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713153910.2556=
007-1-memxor@gmail.com?part=3D3
