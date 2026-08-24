Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA93909B3
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 21:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606042; cv=none; b=fptD2krlnjIUssyy5nNMMoPA5hC3iP64DLzEfu27Mn+du06P/B07geuNYHrXdnUTGJ0odLFc8fdtNwpcBnk+vGnOkytzlp+OVpJT72+Jt22kguUY9MK9oPZyLB3/R0wvZMEXpAo0CFsHoVhHyymeYWq07g6mKJtLc9NXX0iWj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606042; c=relaxed/simple;
	bh=7db1xRaT/rj1qxckAkXCYr4DFeQf6rnkNqMZmjDmKtI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WE1BvkJvVvqueIi7MLZ3dyiCgdoJLaWvealR3g7NY6C2ZmXlGMZpsgoPkb1O442mbq66o0RPva6lwoskiuHOIUkdZ+XGkCydE5mGo+dO7BzxpWv8jbGOno/E6x9ir5RsdTS50qeyjcJD5d1qVT+2dlZ22B3Z8boMolQUiz6pYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBvfW0li; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBvfW0li"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3D91F000E9;
	Mon, 24 Aug 2026 21:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787606041;
	bh=1n//JEjXo2+ru+UN0gIIRzH3woVLHVXbm4fQxfKSIIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IBvfW0liedjlW1xbE6i9loaxc/XXpWFVzcp4EuHWzdQirdBa/h/IVli2HDdKo4lCK
	 HWr76QGGsQhniqG807WH8fxpjVISNk+bS7d2OPz9hN5oTCpBQkUo/zTE2MkZZWnPW0
	 k+/cMOnbRTvWDXwrNKa/iMpTVr0qs/Y2+GfWkQjIOTsdUKrZRyXClEKOl+yPddf5Ih
	 FRN9lwz08M/Jh6nVfBDEFWgTORJe783zRlWpZxPrAdCGiY7vnYAZm91Xz5HhIMUf5c
	 KuTqLl2gZe5BylAZqDwjnu5eRJZsfshL9vDeRY4si2STz2z3VVh6ofjprnMleSgxry
	 HF3/JZ0w1dQ3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Enable some of the
 blocked cpuv4 instruction tests for bpf-gcc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vineet Gupta" <vineet.gupta@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824210142.3933580-4-vineet.gupta@linux.dev>
References: <20260824210142.3933580-1-vineet.gupta@linux.dev>
 <20260824210142.3933580-4-vineet.gupta@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 21:14:00 +0000
Message-Id: <20260824211401.3C3D91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added `#ifdef __BPF_FEATURE_ADDR_SPACE_CAST` guard uni=
ntentionally drops 5 arena tests from the default test_progs flavour for cl=
ang.
--

--- Patch [3]: [PATCH bpf-next v2 3/3] selftests/bpf: Enable some of the bl=
ocked cpuv4 instruction tests for bpf-gcc ---
commit ad6608dfd47ddd6a7068cdc6e0e6d467ec3558b8
Author: Vineet Gupta <vineet.gupta@linux.dev>

selftests/bpf: Enable some of the blocked cpuv4 instruction tests for bpf-g=
cc

This commit relaxes clang-only checks in BPF selftests by adding specific
feature checks like __BPF_FEATURE_LDSX to allow building under bpf-gcc.
It also wraps arena tests with __BPF_FEATURE_ADDR_SPACE_CAST to skip them
on bpf-gcc.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_ldsx.c b/tools/te=
sting/selftests/bpf/progs/verifier_ldsx.c
> index e58ea69e38549..75762e11b443f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ldsx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ldsx.c
[ ... ]
> @@ -263,6 +257,14 @@ __naked void ldsx_ctx_8(void)
>  	: __clobber_all);
>  }
> =20
> +#ifdef __BPF_FEATURE_ADDR_SPACE_CAST
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARENA);
> +	__uint(map_flags, BPF_F_MMAPABLE);
> +	__uint(max_entries, 1);
> +} arena SEC(".maps");
> +

[Severity: Medium]
Does this inner guard unintentionally drop the arena tests for clang under
the default test_progs flavour?

The commit message notes that clang only defines feature macros like this at
-mcpu=3Dv4, but successfully assembles the inline asm at -mcpu=3Dv3. Becaus=
e of
this, you kept the clang version checks on the file's main guard to avoid
removing tests where they run today.

However, since this inner guard lacks a || __clang_major__ >=3D 18 fallback,
clang at -mcpu=3Dv3 evaluates this as false, silently dropping the arena map
and the subsequent 5 arena tests from the default test flavour.

>  SEC("syscall")
>  __description("Arena LDSX Disasm")
>  __success
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824210142.3933=
580-1-vineet.gupta@linux.dev?part=3D3
