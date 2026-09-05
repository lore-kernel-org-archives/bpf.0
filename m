Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7504CCDFE
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788580445; cv=none; b=cTt2nAXpDN3lZzCHBOZOYxtmhunczqCpZ91xY6jyvd82XZBXUKDdQ0G+Ls5JP4ayXP+nFhebDCeDT8SpJzaBY98Xm/NpnmIR9oOfNNOB+f5qDv6nDWSvoQDxIT3ZH+ELjj1lz67qn4scmuEgbQNKSyRGV+SwTCVAvISNwUKwmE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788580445; c=relaxed/simple;
	bh=cOF8ANyjbOwrDKo2Ht3GtDMaHTGlppbNMhBNtIemddo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MWbZ2DI6Yz+5VfVc/cHPn8hNc4qFgWLsrPIYJREdj65i+Q51e+xZZLDd5l8LJIpWFK0+LuG28fArvWmc5WUpcWrUS1xQQhr24wRU9tyvl53mGvNiD+abhPEdkXmZnR6PIYB5bhOjj5RwbjM73Im19WcFiKxdMwoquWYtLYqQfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLZdb1dG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLZdb1dG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8313E1F00A3D;
	Sat,  5 Sep 2026 03:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788580443;
	bh=9k6hcqKJ/aPUvV5Fr46MsjMPoBMiaW54wGLKaU2G0m4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WLZdb1dGMiABnin6xlEZ7hqBuRu7OPdjFqWEuRPyJP/haFHlD/MhQqcVTh+M77tVt
	 rcSm9fmFJ/nndocj5QAuIkcLUDqY2WSdF/9oyMhfJZlop9HZw7mTzCPXYaabY+XU14
	 kCCArUNzxy5fz8JYy9OJGzRhSn8uwCGbGBoZ5u009XiKM1thvWDCj5Tph9xsBkKp8v
	 o3oIzpWEvqTzXHyzvonHSnUCEaKBJujkRf3iJC41GIVuz/lrKJnRi1tI2A7K47fHmX
	 LfdkSvgPmCEq0G+ZoAzexMvtoXUapar8iSN3a0yJJjBOFfAhEVjPb/M+J3xhlEFC4A
	 G3NeK4X6OEkCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Verify global subprogs in each
 sleepability context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260905034018.2095649-2-memxor@gmail.com>
References: <20260905034018.2095649-1-memxor@gmail.com>
 <20260905034018.2095649-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 03:54:03 +0000
Message-Id: <20260905035403.8313E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] BPF subsystem multi-line comment style violation.
--

commit aea430d1f0450a56e5505b581236a015c8f1396b
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Verify global subprogs in each sleepability context

This commit updates the BPF verifier to independently verify global
subprograms across different sleepability contexts, rather than relying
on the sleepable state of the main program. It modifies do_check_subprogs
to track and iteratively verify contexts as they propagate through
asynchronous callbacks.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5b51e7ee1a3f9..4b9aa0f168bb5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -19749,45 +19756,54 @@ static int do_check_subprogs(struct bpf_verifie=
r_env *env)

[ ... ]

> -	/* We can't loop forever as we verify at least one global subprog on
> -	 * each pass.
> +	/* We can't loop forever as each pass verifies at least one new context,
> +	 * and there are only two contexts per global subprog.
>  	 */
>  	if (new_cnt)
>  		goto again;

[Severity: Low]
Does this new comment block violate the preferred multi-line comment style
for the BPF subsystem? The official style mandates that multi-line comments
should place the opening /* on its own line before the text begins.

Could it be reformatted to look like this instead?

/*
 * We can't loop forever as each pass verifies at least one new context,
 * and there are only two contexts per global subprog.
 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905034018.2095=
649-1-memxor@gmail.com?part=3D1
