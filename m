Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986782;
	b=eJkCwb57p6ao6KvzCARIvp8fI7E7CMAbSEzovDDhSFeH6Dy/L0KHrJQB9P1R/PvzSXVW
	 9uUF9a5Ltl4g7Ap8QO6wxDWRHvWcBB+8RxeoGX2F+KzEHoj5woglGmS0nu1CN7AVCTC0r
	 12fDLFMR3PG2pen+QdGUhHE+z0xj6KM8uxj8lEhDY09KNgv8TMy11q/cXDr+ypfmBi7w2
	 lg4BqluR53mVpn3vP2WVozSBieIt+qhFdvjcpwMWDenGHvRMkxNUq8iIuyknR2Y+YBQpt
	 6LfZ4gmFdPKmsgxVGN7pduHpAFubHdC15agt/4n1HTM/QxjGrDTKumbqhJiB4CcKAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986782;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=AOiATwVohqgOFoWVyQ2hkzT5hjr92lg6UBSpA9Q5GeE=;
	b=aLJCzA9jSxsqTKU8Mlauuq6vRuLEpqesER7/YCxEIWpwqi8sRXtfmM7/jZkF/qP9LT8X
	 U2ZO9xaceND2UH0k2Yll0viw4cFFOAa0SsEzD0BXv2+jngRHPd9ka2ZC3oQ4dAVgY7fZb
	 RJ3POI8sD6gxJXqdnObFcAf849UnQEWGH8RK4baGx25t/1HApP85R5UhSqR6Spv6/H2qZ
	 gDCx9xyiSmrAtDuUR2mzIUOGsqimjJ6iGOYCf32r/I+fdUDWXbOBHfw+ROuFJgt/xiNgs
	 gZrBFFw1JtaHBOgprB795rY/8Fj1jiCVugtiQzVkNpa49r+yYlEgLM6Kv3/qgCQdSOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8rUcPtj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EC9606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8rUcPtj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACEE1F01825;
	Mon, 26 Oct 2026 03:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986781;
	bh=AOiATwVohqgOFoWVyQ2hkzT5hjr92lg6UBSpA9Q5GeE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=J8rUcPtjKZtYXjKTrlPijKcaXfGeswrEEQviHbO09DH5Q+b0tfZ4OInuwdhNXPt+D
	 5+Eq6cYZaJL907Ad+gWzA+QUxQkxbKpt6ucg/iEU0cgEo8rjHi813ArEN3+v8Fu9Pv
	 TvwTXFFIvjFPEZMH5o2BxRc7eMClqDxdx3BIaLpXOAb0VKg1MvPmhKwff4m567NwGy
	 8C8cxJodMlByHUXu/l6Mh2u2FYvNEFiVn3P/bDeJkzMR13gBXKwEN6LfQa1o24f0qt
	 Bgh3fyodSvIjcaEOTtvHBDtVG5RzEF4D+XdGmYZ/Mq9qyiHndbCCgP6ioQACLQ4rxB
	 O1W3cnHweyGjA==
Content-Type: multipart/mixed; boundary="===============7504560591906069633=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7ec1a386396febaae23012c7214321d6340f4e9339b40a9c0ef38eeb46537976@mail.kernel.org>
In-Reply-To: <20261026025943.404450-65-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-65-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 64/81] bpf: Remove bpf_compute_scc()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:01 +0000 (UTC)

--===============7504560591906069633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove bpf_compute_scc()

TL;DR: Nit only: removing bpf_compute_scc() leaves a stray blank line at the
end of kernel/bpf/cfg.c, which git diff --check flags; it should be dropped.

> diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
> index 64eccc28703a..8973ec413b8c 100644
> --- a/kernel/bpf/cfg.c
> +++ b/kernel/bpf/cfg.c
> @@ -784,193 +784,3 @@ int bpf_compute_postorder(struct bpf_verifier_env *env)
>  	return 0;
>  }
>
> -/*
> - * Compute strongly connected components (SCCs) on the CFG.
[ ... ]
> -	return err;
> -}

bpf_compute_scc() was the last function in kernel/bpf/cfg.c.  The hunk
removes it but keeps the blank line that used to separate it from
bpf_compute_postorder(), so the file now ends with:

}

(blank line)

Is this trailing blank line intended?  git diff --check on this commit
reports:

    kernel/bpf/cfg.c: new blank line at EOF.

The blank line is still present at the end of the series (51224d16c11b).
Could the context line before the removed "/*" be dropped, so that the file
ends right after the closing brace of bpf_compute_postorder()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============7504560591906069633==--
