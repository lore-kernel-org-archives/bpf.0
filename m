Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9443331EB3;
	Mon, 24 Aug 2026 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578317; cv=none; b=T83jdhN/Uveks89sGqMWKMFpEque37iSzX/xEiKXjCGTUPYYz2I2gzk4pgR33/BViUgUTW+/vvLpMO4djni3bUhcN+Ef8ZVqLEhGNAtSZ8q+k1fbaBJwGTCf1V36GqJ7cMpbd8vxQshzKZZ6nYD3cSr/6gCwlxxfGiK3+5mZC64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578317; c=relaxed/simple;
	bh=7Hatc2zV5FfAKhnfWttJ+BsGXbNICswh6VWNXJat5xo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Omc3hv+rz0Cz/e2ZSZERZMPPoyyo5QR1MWkusnNk6rSmBeGbFNhYtboEPE/yYj4LIjj/CGxKqH5GeIKv63h8+GEyGFarTV6aihVtjPA1Hx5OtqRVJTai6Dr8uun0AKaUQfgfsFPU2VaPFc829/wPioAAyz+2dQbSQgdNKWXlsr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARvNyLAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARvNyLAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBCF1F000E9;
	Mon, 24 Aug 2026 13:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578310;
	bh=xBktXjr4+luzNS0VOioTLx4w43eI72HBqtwkdE/5h9M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ARvNyLAQbtNOaRamIgI7F3Z35jmaDyWK8of4qhhDK10K/pRUEfy87P7S4BZv08CC3
	 lRHjECpNZcRw+E1LQf3jCbkz9zgA8pzpI2C4yAxkmv2t+ev/KwRDyEdOzlwZBf1EIf
	 uaP/8rNdRPuHenQJlevCu0lXGjqY46ulZgytJBq9SS3WtfJqGMaeQageTjEkJzb1VE
	 MV/JXrOeajLz0uehQxeEZD+PJEkZiSaSH5Zd0OKiRpTx8kml7aYee3R4tAZRFu7E+/
	 ncItnjRoyw066fdaZAGQK38jSbzWbxglymKBh0MHI/Kce8oQuSYTgkI9WT1KJZW0Ur
	 pgZMpRWacfe8w==
Content-Type: multipart/mixed; boundary="===============5108074018797379411=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc7224531e66a752eba5ac70daaab3a6401526d3003271c956ace42a0b04585d@mail.kernel.org>
In-Reply-To: <20260824125310.1384-3-zhaofuyu@vivo.com>
References: <20260824125310.1384-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org,eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,yatsenko@meta.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 13:31:50 +0000 (UTC)

--===============5108074018797379411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_names.c b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> new file mode 100644
> index 000000000000..d5674cad0017
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_names.c
> @@ -0,0 +1,93 @@
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
> +
> +	skel = btf_module_names__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
> +		goto out;
> +
> +	ret = btf_module_names__load(skel);
> +	ASSERT_OK(ret, "btf_module_names__load");

The three subtests (btf_module_names_load, btf_module_names_skip, and
btf_module_names_empty) leave the input-validation paths from the
preceding commit completely unexercised.

That commit adds checks in bpf_object_init_btf_module_names() that are
documented in libbpf.h as part of the API contract, particularly:
"The list must not contain duplicate entries; otherwise -EINVAL is
returned."

Uncovered paths in bpf_object_init_btf_module_names():
- Empty or NULL entry detection (if (!names[i] || !names[i][0]))
- Duplicate name detection (the for loop with strcmp checking all
  previous entries)
- Error cleanup path (err_out:) that calls
  bpf_object_free_btf_module_names() after partial strdup() walk

Would it make sense to add subtests covering these validation paths? A
single extra __open_opts() call checked with ASSERT_ERR_PTR() or
ASSERT_NULL() would exercise each. The duplicate-detection loop is
non-trivial enough to deserve one.

Also, nothing in the series asserts the default btf_module_names == NULL
case (load everything, unchanged behaviour), so a regression that makes
the option mandatory would pass undetected.

> +out:
> +	btf_module_names__destroy(skel);
> +}
> +
> +/*
> + * Verify that an unrequested module BTF is skipped. The BPF program
> + * requires the BTF of bpf_testmod, but bpf_testmod is not specified in
> + * btf_module_names, so its BTF is skipped and the BPF program fails to load.
> + */
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
> +
> +	skel = btf_module_names__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "btf_module_names__open_opts"))
> +		goto out;
> +
> +	ret = btf_module_names__load(skel);
> +	ASSERT_ERR(ret, "btf_module_names__load");

A subsystem pattern flags this as potentially concerning: both negative
subtests assert only that the load failed, not the specific reason why.
ASSERT_ERR expands to check ___res < 0, so btf_module_names_skip() and
btf_module_names_empty() pass for any negative return from
btf_module_names__load().

The intended error is specific: with bpf_testmod's BTF filtered out,
find_kernel_btf_id() walks obj->btf_modules and falls through to return
-ESRCH, which bpf_object_load() propagates to __load(). Asserting that
value (for example, ASSERT_EQ(ret, -ESRCH, ...)) would pin the
behaviour.

As written, several unrelated conditions make both subtests report
success while proving nothing about the new filter:

- CONFIG_DEBUG_INFO_BTF_MODULES=n: bpf_testmod loads (so env.has_testmod
  is true and the test is not skipped) but has no BTF at all.
  Attach-target resolution then fails regardless of btf_module_names, so
  both negative subtests pass vacuously.

- Unprivileged/EPERM: load_module_btfs() returns 0 early without loading
  any module BTF (pr_debug skipping message), again yielding -ESRCH from
  an unrelated cause.

- Any future validation of the new opts that rejects the list at load
  time rather than at open time.

Would pinning the expected -ESRCH value make these subtests more robust?

> +
> +out:
> +	btf_module_names__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32730521630
--===============5108074018797379411==--
