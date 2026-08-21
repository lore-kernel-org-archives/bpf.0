Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9038F64D
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351964; cv=none; b=jBuSHDUB6/0EMOkfT07Zs/v2dirhNaurxcsWEyAAiiCFnb+rCF0MbyfAc6Xv33izTKbHJVwlytRduxn0tG9G+JcVBa2cTU6mp0oaOupcNJEE/ZM4j4RlccFFR5geQduWS9xLlKxygTSJvReAw/zi6zBe8k+V+X1+NDT+8Mm4gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351964; c=relaxed/simple;
	bh=onQz27EGJRMlPzIm+OziRN4iSnv3Zgz/k3LNOwAUhuE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UVPsQkR38y4Kyaqx7vO4dbSZrHtlGIHoqK8dyt41rA/abQ+j9wQbmfVBOOOCyuonnw64Btl8VbMCINj5za4dwBuvjUzV0U5r5JT5YG2BrGd+DaH+oErix6xPAX3g1tGxayEwn4i7Q4f9gX6FyA63dIcp+QMvwnYFUm7vw4h42GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz4yIFFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz4yIFFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85B01F00A3A;
	Fri, 21 Aug 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787351962;
	bh=T144VmKssK4j8lMmwZUYVlwvsNUwhrNSrd2JaietAfk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Iz4yIFFPEnsPlDjQjBqOyoaweoU46GtQzd9kmm8/1bORtAArPkVYbRIulPS8kSvvq
	 Wm5t/A20B9X+DBXqklLMC210+H+YIOzxityT49fmC8ZyWIkqQh2xfCod45cumyfvnp
	 jBbflcYVzyPcVRz1uJkifAvwgChV3scQ0rAKujdASKqU+TJNfH8eVokUguAoL3oGEm
	 RgWVmi80uCLw0GYAtSy2gD/ycZg/2h5KwGR0MUNgXhLF5y0+jNj72Gq1/17D2ky0ri
	 XiK4F3GV3K+hOSgO+B2AaMYAOfljAXf2KCOT9UVmR8fud/0Cq/XvQcUnIhZYZIlGFL
	 wC6Be7gtJIJVQ==
Content-Type: multipart/mixed; boundary="===============5323726533192274622=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c1d036da04097511772e02c7e2a16744853c79a407c623ae6842cd55901c4af@mail.kernel.org>
In-Reply-To: <20260821214111.1120748-5-daniel@iogearbox.net>
References: <20260821214111.1120748-5-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 04/11] bpftool: Support ML-DSA program signing
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 22:39:22 +0000 (UTC)

--===============5323726533192274622==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Support ML-DSA program signing
>
> Add bpftool support for ML-DSA program signing and drop the flag for
> ML-DSA keys on affected OpenSSL versions, the same way as commit
> 0ad9a71933e7 ("modsign: Enable ML-DSA module signing").

This isn't a bug, but the changelog describes the change as dropping
CMS_NOATTR "the same way as commit 0ad9a71933e7", though the diff does two
further things a reviewer cannot infer from it.

First, MAX_SIG_SIZE grows 4x (4096 to 16384):

> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -57,7 +57,7 @@ #define REQ_ARGS(cnt)							\
>  	})
>
>  #define ERR_MAX_LEN	1024
> -#define MAX_SIG_SIZE	4096
> +#define MAX_SIG_SIZE	16384

which resizes the on-stack sig_buf[] in both gen_trace() and try_loader().
The number is also unrelated to the BPF_PROG_MAX_SIGNATURE_SIZE of 64 KiB
introduced two patches earlier in the same series, so the choice of 16384 is
unexplained.

Second, the ML-DSA branch also pins the CMS digest to SHA-512:

> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
> --- a/tools/bpf/bpftool/sign.c
> +++ b/tools/bpf/bpftool/sign.c
> @@ -130,6 +130,9 @@ __u32 register_session_key(const char *key_der_path)
>
>  int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
>  {
> +	unsigned int signer_flags = CMS_NOCERTS | CMS_BINARY | CMS_NOSMIMECAP |
> +				    CMS_USE_KEYID | CMS_NOATTR;
> +	const EVP_MD *cms_digest = EVP_sha256();

[ ... ]

> @@ -167,6 +170,21 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
>  		goto cleanup;
>  	}
>
> +#if OPENSSL_VERSION_NUMBER >= 0x30000000L && OPENSSL_VERSION_NUMBER < 0x40000000L
> +	if (EVP_PKEY_is_a(private_key, "ML-DSA-44") ||
> +	    EVP_PKEY_is_a(private_key, "ML-DSA-65") ||
> +	    EVP_PKEY_is_a(private_key, "ML-DSA-87")) {
> +		/*
> +		 * ML-DSA + CMS_NOATTR is not supported in openssl-3.5 and
> +		 * before, so fall back to signedAttrs. ML-DSA does its own
> +		 * hashing and ignores the CMS digest, except when signedAttrs
> +		 * are used, where only SHA-512 is permitted.
> +		 */
> +		signer_flags &= ~CMS_NOATTR;
> +		cms_digest = EVP_sha512();
> +	}
> +#endif

which the referenced modsign commit does not do. The referenced
scripts/sign-file.c keeps taking its digest from the -d argument and only
clears CMS_NOATTR. The reasoning for the SHA-512 pin is in the code comment
but not in the changelog.

Would it be worth a sentence on why MAX_SIG_SIZE lands on 16384 (rather
than matching the 64 KiB kernel bound added earlier in the series), and
noting that unlike sign-file.c this also pins the CMS digest to SHA-512?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32530917987
--===============5323726533192274622==--
