Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9875466AE1
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 07:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545293; cv=none; b=C/DqO+MYSRfGO+/Ji6Z1oD3EsQYeMHx2Oh0tu3Q1Myc41oynOohzEpSRRhvD/d4mKlmZ+zYWQuLoI+b1SHeJGQe1Aew9NBWQ8Lkh6d7hHTKP4I0xCrV3lr5/AkVD3glPEVKVaAe0rA4rDaYwTEKyYQ3gLAQxRCQ4Yb3ns+ML4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545293; c=relaxed/simple;
	bh=ajCBlbHLvQlXRJQ6A/bhxjXTGsDlkdAUs6t9mPvItQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qo3JeiHiVOgUiRF3daF1+TboY40OoyMrpFt+PFPevlAhhXnPKsiQAM7pQmsbZSLb7Nz2GhYwkridQ2VZVvzYUcsHoyX4GNGj6sBB/eiyAcIR3VRbmMk7QOo1GOdHuPew8RPr8xt2CDj1NCl3zeClJw8FpFWn8TQS32N+6qNJQr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek6GyEAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek6GyEAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B2D1F000FF;
	Wed, 16 Sep 2026 07:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789545277;
	bh=9sa+/o01YXmGDPAutm0JyX/MHDla49pbmQEL4BNJvyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ek6GyEAQ8ujQN8zzzd5loPW+7ZJB0u9WkJh73XGRvRRZyMA1vvPbKJQlDf3VUzha4
	 tWNuSWly0q6m22uRxCNqDek5y6I71G3EbdZuM0RR5Ppf+kXeFm9weGeWw5nYr6xSLK
	 EBSq6X0t7ttSr/5eEUcXymxqXCAWriXxS/k3/Ils1+GIaQpdnnKEWU0b56DNHeQZPl
	 6DOtNJAMvZhWTXxnb4wC7k86DGIEj3cd9CD2lf2pxsnS59ArVSOnD3jK7LP2JpXtj7
	 RPmga7gA8xSTjeL8o/gVAb32OsvlGGc/9HwrUu8PwkDlF0X9C5j/CZj8drF3ZzvIIi
	 MwX+y65xbadtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 bpf-next 07/11] bpftool: Handle multi-split BTF by
 supporting multiple base BTFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260916074118.1007116-8-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
 <20260916074118.1007116-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 07:54:36 +0000
Message-Id: <20260916075437.09B2D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] bpf: evaluation of freed pointer in bpftool cleanup
- [Low] bpf: unbalanced braces in bpftool btf help string
--

commit 43f26ee1c8d2e52438682ffa46a3b61f16ff7512
Author: Alan Maguire <alan.maguire@oracle.com>

bpftool: Handle multi-split BTF by supporting multiple base BTFs

This commit updates bpftool to support multi-split BTF by allowing multiple
base BTF files to be specified via the -B argument. It updates the help text
and handles loading and freeing multiple nested BTF bases.

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bca0a3982f09b..bbe8f9ea144fa 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -1545,7 +1545,7 @@ static int do_help(int argc, char **argv)
>  		"       " HELP_SPEC_MAP "\n"
>  		"       " HELP_SPEC_PROGRAM "\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> -		"                    {-B|--base-btf} }\n"
> +		"                    {[{-B|--base-btf} FILE]... }\n"

[Severity: Low]
Does this leave the opening brace from the HELP_SPEC_OPTIONS block unclosed?

The HELP_SPEC_OPTIONS macro starts a brace-enclosed block, but replacing the
single closing brace with a balanced group {[...]} might leave the overarch=
ing
list unclosed when the help output is printed.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 5ababd8f7d0a0..cff76be7d2e86 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c

[ ... ]

> @@ -567,7 +572,18 @@ int main(int argc, char **argv)
>  	if (json_output)
>  		jsonw_destroy(&json_wtr);
> =20
> -	btf__free(base_btf);
> +	while (base_btf) {
> +		new_base_btf =3D (struct btf *)btf__base_btf(base_btf);
> +		btf__free(base_btf);
> +		/*
> +		 * Do not free base BTF that is an owned .BTF.base ; leads
> +		 * to a double-free, so only free as far as the root base
> +		 * we explicitly read with -B above.
> +		 */
> +		if (base_btf =3D=3D root_base_btf)
> +			break;

[Severity: Low]
Are we evaluating a freed pointer in this break condition?

Since btf__free(base_btf) is called just before this check, evaluating
base_btf against root_base_btf could invoke undefined behavior by reading t=
he
dangling pointer, even if it is just an address comparison in a teardown pa=
th.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916074118.1007=
116-1-alan.maguire@oracle.com?part=3D7
