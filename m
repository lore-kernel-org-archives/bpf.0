Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658783E9F9E;
	Wed, 26 Aug 2026 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787753626; cv=none; b=qclUdLsGCfMfdWq6XmI3T28VA1qpaMBJm3pxYBEF0L0eiDcF84fpqhc0rdUp+deKYlUy/Ei5SxUUYvWHmcV7114lT2zUwK77z/XxC4J7bey1NdR/nr4ZCYF3nAxDhdp/O71gLs63Y6b587uya7JAmF+UqCEsKq/haHQGSLRE7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787753626; c=relaxed/simple;
	bh=oR2XQ2UoOFk5H8Yd4dJxwaQrLwoiRJ8Kwqunx+5knP0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ibjg1mc3yT/1+oJzNSJ2SHKyxeBnYigveQVATNNOG51PRkFMjN/ce1JQxAT+Xxc3jQzp95Dx+xSmRF7V1rk9qVGaqX8Zeh2UH7I8Anke5Uj2JWJQJajzZLUOi+uWYJvFuBe2pBuXOloX9CZ7TgQ9SNf08p8rpk9pSUccTY+Hc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HNvn+GyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HNvn+GyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C321F000E9;
	Wed, 26 Aug 2026 14:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787753625;
	bh=t1v/NmSZfegcHs5zTqksVLX342Uqc6/DhPp5QSCS/CI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HNvn+GyDTHNYEXQSavRzVwex0DWq28T66M6FGrKaXIXOlO70rC/8nnKKBi4JtA21T
	 iaFwgLFWpGPrxx+rEotYIseAF3he1exPRp67yoKcgexNdzzsOKpjHzv71Lhr6PdObn
	 acdEDSIo/eIBFeJnyFxyEb1E9f/hTgxx6DylHPKMdYN3a2AUqNFbUcIgJuXLZeAUIH
	 ryI1c9fKHos8efj2aplybfA0CeMUN4AYZLZAxITZFHlJymlJRjuUStMnomanpss0S/
	 DicYkIHcdlmwZrpPEQM4OKj8DQT/g2Px7ZLGw6FKl1dmtG3mvtiKroC3q8T+LUvbCw
	 LLkdTRLTzvb3g==
Content-Type: multipart/mixed; boundary="===============2285862129936831872=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e95579f6ec8d261f3a4303a5ca9e7111bde07ef2ee3fa48e487c1d33cbe3c3d6@mail.kernel.org>
In-Reply-To: <20260826131428.302-3-zhaofuyu@vivo.com>
References: <20260826131428.302-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 14:13:44 +0000 (UTC)

--===============2285862129936831872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> new file mode 100644
> index 0000000000000..3dc72bef014c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "btf_module_names.skel.h"
> +
> +static void btf_module_names_load(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	int ret;
> +	static const char *mod_names[] = { "bpf_testmod" };
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_names = mod_names,
> +		.nr_btf_module_names = 1,
> +	);

[ ... ]

> +static void btf_module_names_skip(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	int ret;
> +	static const char *mod_names[] = { "module_nonexist" };
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_names = mod_names,
> +		.nr_btf_module_names = 1,
> +	);

[ ... ]

> +static void btf_module_names_empty(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	int ret;
> +	static const char *mod_names[] = { "" };
> +
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_names = mod_names,
> +	);

[ ... ]

> +static void btf_module_names_invalid(void)
> +{
> +	struct btf_module_names *skel = NULL;
> +	const char *names[] = { NULL };
> +	const char *empty_names[] = { "" };
> +	const char *duplicate_names[] = {
> +		"bpf_testmod", "bpf_testmod",
> +	};
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_names = names,
> +		.nr_btf_module_names = 1,
> +	);

This isn't a bug, but could the three static const char *mod_names[]
declarations in btf_module_names_load(), btf_module_names_skip(), and
btf_module_names_empty() just be automatic arrays, matching the non-static
declarations in btf_module_names_invalid()? Since libbpf strdup()s the
entries, the static storage doesn't add anything beyond inconsistency within
this new file.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32974547426
--===============2285862129936831872==--
