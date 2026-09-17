Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7E43806CD
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679803; cv=none; b=N/qfU1vyO2K3/bVDSi3JH+9R7wFM1iOIGXcSmjmEiAyv26Hqs/0+ms+losSO6fbN6obgWiIvbJTB/UfdYx2WrWoae2Oxn3pmRD1UsID5EzZiDfCP7nD2cXHGA5T4LEJw2JK4i2PTugk1Ay5fJ8gqKIUfRpv6kL1wsT/oQAaInIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679803; c=relaxed/simple;
	bh=yLK7BKDKzrOL8CYPGLfWjlkxp2jFpyz5pI4ix3s6vmY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fBhr3ImAH79rI098IARyl5W4qGLxswBge8vhXIhoz7uxWwi9xX2xpfYC+mOa3JC6zcrrUzlfPci9kdMW9oKahJJyGRPaa7Y9Md6F0c2u/dNJSZ52J/Uo07V1XoowXrTErTnGlOKzHtXWrFXGiUNUf6qyQtneSmle4CukfgV7rS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBDdkt0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBDdkt0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF6E1F000FF;
	Thu, 17 Sep 2026 21:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679800;
	bh=OEG7SSVcJIp5fFUk8kjlG5svShQz4n94/ukoEG2yhrw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SBDdkt0UWGpBRA7PrOzWRIJ0LgbPpwebFpDsnhwq8xBPJWypj+SSvNrCAp4+SkRA9
	 DNQtEMvir9NALOSmSsBPLkD2iQTg4ivxTUYm/lB+3aiZZBp0fEOjN8RTCs7oY+ktt5
	 rBW1iFN3OzhoyPWxe7gKkRXa66OziHet6syRGsXfSkOXWEJwzrcF/6Dr4qVgQDjJVT
	 FynLayjP7A4fFoAd6+bdIkHEbw9Gahqn4ySPbaBep/4uxphWeSrQ3ZVMk75fTReKJg
	 EI3oaFsrpTi9RrLRn1nxSOdYpLIFkYVYdxxX7Fgrptvn+OmLTHzjxn6Hw8o88niL+m
	 Qxk6YaShODNeg==
Content-Type: multipart/mixed; boundary="===============7920550590756333034=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <400498f8dea6bf347464d9320a7c21268b479489300c08a88e7059d92539913a@mail.kernel.org>
In-Reply-To: <20260917203040.3150212-5-andrey.grodzovsky@crowdstrike.com>
References: <20260917203040.3150212-5-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v3 4/6] libbpf: Reject gen_loader for objects with already-manual programs
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: ast@kernel.org,martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:16:40 +0000 (UTC)

--===============7920550590756333034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Reject gen_loader for objects with already-manual programs
>
> bpf_program__set_load_strategy()'s MANUAL case rejects setting MANUAL
> strategy while a gen_loader is already attached, but a program marked
> MANUAL declaratively (SEC("!...")) gets that strategy during
> bpf_object__open(), before bpf_object__gen_loader() can ever be
> called, so the existing guard can never observe it.
>
> Left unchecked, bpf_object_load_progs() skips such programs, so
> gen->nr_progs undercounts relative to the object's real program
> count. bpf_gen__finish() only rejects the opposite mismatch direction
> (nr_progs < gen->nr_progs), so this passes silently, and every
> generated skeleton program slot after the manual one ends up wired to
> the wrong prog_fd.

Since 17ddfa90 ("libbpf: Support declarative manual load via SEC("!...")
prefix") and 41c79ac0 ("libbpf: BPF programs manual loading and
attaching") are in this same series, would it read better to fold this
check into the commit that adds SEC("!...") rather than fixing it up two
patches later?

Also, this isn't a bug, but should the changelog say
bpf_object__load_progs() (two underscores)? The tree has
bpf_object__load_progs() at tools/lib/bpf/libbpf.c:8405.

> Catch it at the one point guaranteed to run after any MANUAL marking
> has already happened: reject in bpf_object__gen_loader() itself if any
> program already has load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL.
>
> Assisted-by: Claude:claude-sonnet-5
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

This looks like a bug fix for SEC("!...") declarative manual load support.
Should this include:

  Fixes: 17ddfa90d052 ("libbpf: Support declarative manual load via SEC("!...") prefix")

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c9a184d9626db..3ac7319ed0f40 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9752,11 +9752,29 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
>  int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
>  {
>  	struct bpf_gen *gen;
> +	size_t i;
>
>  	if (!opts)
>  		return libbpf_err(-EFAULT);
>  	if (!OPTS_VALID(opts, gen_loader_opts))
>  		return libbpf_err(-EINVAL);
> +
> +	/*
> +	 * Manually-loaded programs are not visible to gen_loader (see
> +	 * bpf_program__set_load_strategy()'s MANUAL case), and marking a
> +	 * program MANUAL happens during bpf_object__open(), before this
> +	 * function can ever run, so that guard can never catch it here.
> +	 * Reject any pre-existing MANUAL program now, since this is the
> +	 * earliest point where both are known.
> +	 */

This isn't a bug, but could this be trimmed to a line or two pointing at
bpf_program__set_load_strategy()? The 11-line comment already added in
bpf_program__set_load_strategy() explains the same gen_loader/MANUAL
incompatibility. Also, phrasing it to clarify only the declarative
SEC("!...") marking happens during open might be clearer, since the
imperative bpf_program__set_load_strategy(MANUAL) path marks programs
after open.

> +	for (i = 0; i < obj->nr_programs; i++) {
> +		if (obj->programs[i].load_strategy == BPF_PROG_LOAD_STRATEGY_MANUAL) {
> +			pr_warn("prog '%s': gen_loader does not support manually-loaded programs\n",
> +				obj->programs[i].name);
> +			return libbpf_err(-EOPNOTSUPP);
> +		}
> +	}

This isn't a bug, but would binding `struct bpf_program *prog =
&obj->programs[i];` at the top of the loop match the way the other
program loops in this file are written? bpf_object__load_progs() and
bpf_object_prepare_progs() both bind a local first rather than
indexing obj->programs[i] repeatedly.

> +
>  	gen = calloc(1, sizeof(*gen));
>  	if (!gen)
>  		return libbpf_err(-ENOMEM);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35272462686
--===============7920550590756333034==--
