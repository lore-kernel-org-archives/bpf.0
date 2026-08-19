Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FFA447808;
	Wed, 19 Aug 2026 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133031; cv=none; b=pyouwbh14W8hBOnaTjE1C+GwVmXNw0ZemlnYZE5Dy9EiXPng5x9y8zKoVUTD/DJ7yZQ+6IhgQy9o9QRzx3tp4JS3aN7zNYrV28ll7hkCfweUfZOuVMfy2r42u7nwV1WdqQwfTTVcvugEO18EOPYBpt5HIALJ43rcV7NpxSpkxYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133031; c=relaxed/simple;
	bh=bGshx65tPJzLHPyfAQSqN48bIF4BY9JjYycA2gortgc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h40SUjLtC13bpb7+heerNfhizdIUTZ8jV7JvtmYE7ka5BwYkXRqzJsE7pXgH73uYg23ISDEZ3vK+EK7qcE0Lh8DO8F2ZskXMt1OG69ghnA+e5at3EdJ2usfrgPJyh6nnU2YrS0nAGCmja3Dy8qy9koQ1KPAkRN39LIXeTY/h22Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfn2IXga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfn2IXga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C341F000E9;
	Wed, 19 Aug 2026 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133029;
	bh=VkUvoNUSZVGmsaJ7+eTyVxY0QCTsro/X+xC5EU1cIwQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kfn2IXgaXo3C7pQM+PAwTYHhhqcEcN5p4PLR52S6t8bL+VOQhv8q575hbvTFIuGC7
	 Ad/qitFR7BF7mwvl9Xz9NJgqO+XAGUzNrE5ZPtzZ+wq19I/YbQK3YKIITfrYNhRaLA
	 4CZpjUDIdlgU/9DoRY1hbHAQqqKShLdFmVr7OLOYfTpJSZhT0hTEj3I1j6X3aSzyo/
	 pJVUaik/bi1N2l34FXNrn12zTFqSLiRJTFDUXCZHZPyUurfBVxcWjRXGxfWp6rmW4m
	 1xeueyK49FgK6oJHXIZZppYMf3xAZEOSivs2UG6K36TXNs+T3tyOYIBbH8z+GPsCez
	 LCdvInKxfkNUA==
Content-Type: multipart/mixed; boundary="===============3293360164673853915=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5cec664e8218aab8a7304ab755e65410dfa07ff5ef4f19a48ee3ce1baed80aff@mail.kernel.org>
In-Reply-To: <20260819090426.267-3-zhaofuyu@vivo.com>
References: <20260819090426.267-3-zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for selective kmod BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 19 Aug 2026 09:50:29 +0000 (UTC)

--===============3293360164673853915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> new file mode 100644
> index 000000000000..61d2845a731f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "kmod_btfs.skel.h"
> +
> +static bool btf_skipped;
> +static bool dup_ignored;
> +
> +static const char btf_skip_fmt[] =
> +	"libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
> +static const char dup_ignore_fmt[] =
> +	"libbpf: duplicate kmod BTF name '%s' ignored\n";
> +
> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
> +			   va_list args)
> +{
> +	if (!strcmp(fmt, btf_skip_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
> +			btf_skipped = true;
> +	} else if (!strcmp(fmt, dup_ignore_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
> +			dup_ignored = true;
> +	}
> +
> +	return 0;
> +}
> +
> +static void kmod_btfs_pass(void)
> +{
> +	struct kmod_btfs *skel = NULL;
> +	int ret;
> +	static const char *kmods[] = { "bpf_testmod" };
> +
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.kmod_btf_names = kmods,
> +		.kmod_btf_names_cnt = 1,
> +	);

This isn't a bug, but would LIBBPF_OPTS() read better here than
DECLARE_LIBBPF_OPTS()? The same pattern appears in all five subtests
(kmod_btfs_pass, kmod_btfs_nonexist, kmod_btfs_dup, kmod_btfs_skip,
kmod_btfs_no_cnt). DECLARE_LIBBPF_OPTS is defined in libbpf_legacy.h as a
backwards-compatibility alias, and most of prog_tests/ uses LIBBPF_OPTS()
directly.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32236360082
--===============3293360164673853915==--
