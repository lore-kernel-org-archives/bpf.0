Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC171FC0EA
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 11:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780486141; cv=none; b=niUOebHIfe6FRAf+bwns/ER1jL4eYgSoI2WnaFNEonv3w+LBT58DV9+Mx9t55j8WfEgZGod1+jGy/nJ4zht2qC41QsT448oMj5CKXQqCQaE0Pp5von4Od6QuFsjGHAdM9usRgtg1dE0gUhdyvbXbIQrBvs4Q7yPR3gsC4kgfRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780486141; c=relaxed/simple;
	bh=dArocPWmRnc/4RlP9OWuNBTr+PkhoYmnGWAjrU74Kzg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlI1nd87frQzyWAstqf0uG4vEFzxtaDKvlhtyMhPVNBCJzR/fEp3tpgCpod5bM6lUUzI3/qqM8ChzzfCCwo8pYuelV8uZ/wF3jvdrsXq7ROiMBqria27zIDC9saAWC0XXprZmojCQuRahhfItg88aQBmYwObvowv+JYQJ0o7lkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH3tmSRz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH3tmSRz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 318991F00893;
	Wed,  3 Jun 2026 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780486140;
	bh=iS0tWUvW9rHIvgH4KR+pENP7UZ2bqUr3sTOZRB3aAwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XH3tmSRzbgPMW/DohyhQoxQ2GTQGdsJ9QOuIAkqeO/MBQOIKQ5TYKzdsyjHIqXDIk
	 HldgNEblfH6oqeYhfFX9ksDJlrM3lAYw6V5YPQjatnkeXkHXhwHECT1byh9c92DVSi
	 tpftn+oMvejO41Y842foE+EYowx4awFJBVdLSCajCUg17xaxVJY0GbWIYrNQu0u+0k
	 zmHL5jJ8CENlAjSDikVVnp8J7n1rekyWHCQ1PSooA4aNt/3iy/rAeU3hQYqZJyWBqT
	 p/P/69Axbnlly2bvM6tO14bJQWXdnM7apn7fyd/Ul4xZQTkRxxv5PaGSeMCX+s2KZI
	 vWpXRQwn2GK2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv7 bpf-next 04/29] bpf: Use mutex lock pool for bpf
 trampolines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260603110554.29590-5-jolsa@kernel.org>
References: <20260603110554.29590-5-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 03 Jun 2026 11:28:59 +0000
Message-Id: <20260603112900.318991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments modified by the patch do not follow the mandato=
ry BPF subsystem comment style.
--

commit 107ed36e35d617129f1228fd0db67188b4ce4a98
Author: Jiri Olsa <jolsa@kernel.org>

bpf: Use mutex lock pool for bpf trampolines

This commit replaces the per-trampoline mutex with a mutex pool to
prevent lockdep warnings when attaching multiple trampolines during
tracing_multi link. Trampolines are hashed to one of 32 pool locks,
keeping the maximum simultaneous locks below the 48 lock limit.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index a4298a25d4bae..c0b4732627bef 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
[ ... ]
> @@ -99,12 +128,12 @@ static int bpf_tramp_ftrace_ops_func(struct ftrace_o=
ps *ops, unsigned long ip,
[ ... ]
> -	if (!mutex_trylock(&tr->mutex)) {
> -		/* sleep 1 ms to make sure whatever holding tr->mutex makes
> -		 * some progress.
> +	if (!mutex_trylock(select_trampoline_lock(tr))) {
> +		/* sleep 1 ms to make sure whatever holding select_trampoline_lock(tr)
> +		 * makes some progress.
>  		 */

[Severity: Low]
This isn't a bug, but since this multi-line comment in
bpf_tramp_ftrace_ops_func() is being modified, should it be updated to
follow the BPF subsystem comment style, with the opening /* on its own line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603110554.2959=
0-5-jolsa@kernel.org?part=3D1
