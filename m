Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7BD330662
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479228; cv=none; b=GClW3pH0nT35VgEYppcaE9OxcOX6h/T0R4YT5ROUGK/ruNGmxDvbgxqnY9iOgBi/uncmNRWyh3XJKzRdzHkXDHjU+HEJpXt9q9xsvMVXwv27eVTGq4hkXrDDYdrRe2etaUZt9sbhbYX2C3aADVm9apTee2JUXTkgHq8RObQqnko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479228; c=relaxed/simple;
	bh=8jybUVo50EFQof3PpqeBLAA8N9t/sh9QhIBLDTIHusM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=oSjAcT2qrwopRMYYYW3MarwLZJXfeaX5uxDTorUuxQhDujWI3+Nyh3DaUamEjILwLKEipj5Ii0k6DjRHue+4OgPI0bVVQFkpvadraTVu3gsWJy8Xt9Ivbfarbn5uP1+UEmBSsuuNmHVqUHMaFmqn464ZnvXB6wrQFBwafDdCFs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iXnUvGxZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iXnUvGxZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97F71F000FF;
	Tue, 15 Sep 2026 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789479227;
	bh=/h1aGF3NB7QEkWueiTruoa7ge/+xfkpq1orQ6+xBCLo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=iXnUvGxZxHM99Jw5HFh6FBxtFfkZtSRsRwPvXQ4NRkAdVvjVyuB7fCUf1IX11cel5
	 d2SRuKqnVEqIXaFwHKg+ALqlsLlqYJU2fxUj7lW5JgohAlAxN+Xk+IQXQcaT8QLQXl
	 5hDQF84Vc+3V4InTbqHwOcFx/Vr7C4tLknh5N2wWfEqmtAQUqv2qEgoYWWCo2W1Qy5
	 tJfMxUdAf/UQ+pb54IBhH0u/INAW3YEm1fr7D6oYZ708QikD9Bb7kty0yBLipI3j2h
	 O6739ceHO+BgR+B0EWHNdNGN/77rMeR2TvDV9/J2D1kUNT+4CNyzdl0A7z/HZRZawR
	 1S/cWVUlEeLGw==
Content-Type: multipart/mixed; boundary="===============0224972729011567103=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0e82bdc7f21285fb259ec989c8d0a43a2fd8af80c200f67b200ac2421a085477@mail.kernel.org>
In-Reply-To: <20260915124104.77287-3-zhaofuyu@vivo.com>
References: <20260915124104.77287-3-zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v9 2/2] selftests/bpf: add tests for selective module BTF loading
From: bot+bpf-ci@kernel.org
To: zhaofuyu@vivo.com,bpf@vger.kernel.org
Cc: eddyz87@gmail.com,andrii.nakryiko@gmail.com,alan.maguire@oracle.com,olsajiri@gmail.com,zhaofuyu@vivo.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 13:33:46 +0000 (UTC)

--===============0224972729011567103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> new file mode 100644
> index 000000000000..3189133ee58b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +#include "btf_module_allowlist.skel.h"

[ ... ]

> +static void test_invalid_input(const char **list, size_t count,
> +			       const char *test_name)
> +{
> +	struct btf_module_allowlist *skel;
> +	char assert_name[64];
> +	int err;
> +	LIBBPF_OPTS(bpf_object_open_opts, opts,
> +		.btf_module_allowlist = list,
> +		.btf_module_allowlist_cnt = count,
> +	);
> +
> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts", test_name);
> +	skel = btf_module_allowlist__open_opts(&opts);
> +	err = errno;
> +	if (!ASSERT_NULL(skel, assert_name)) {
> +		btf_module_allowlist__destroy(skel);
> +		return;
> +	}
> +	snprintf(assert_name, sizeof(assert_name), "%s: open_opts err", test_name);
> +	ASSERT_EQ(err, EINVAL, assert_name);
> +}
> +
> +static void btf_module_allowlist_invalidinput(void)
> +{
> +	const char *names[] = { NULL };
> +	const char *empty_names[] = { "" };
> +	const char *duplicate_names[] = { "bpf_testmod", "bpf_testmod" };
> +
> +	test_invalid_input(NULL, 1, "null_list");
> +	test_invalid_input(names, 1, "null_name");
> +	test_invalid_input(empty_names, 1, "empty_name");
> +	test_invalid_input(duplicate_names, 2, "duplicate_name");
> +	test_invalid_input(names, (size_t)SSIZE_MAX + 1, "large_count");
                                                               ^^^^^^^
Does this test actually verify the count-overflow guard? The "large_count"
case reuses names[] = { NULL } as the allowlist, but the validation in
bpf_object_open() (from patch 1, tools/lib/bpf/libbpf.c) has two
independent paths to -EINVAL for that input:

    if (mod_allow_cnt > SSIZE_MAX || (!mod_allow && mod_allow_cnt > 0))
            return ERR_PTR(-EINVAL);

    for (i = 0; i < mod_allow_cnt; i++) {
            if (!mod_allow[i] || !mod_allow[i][0])
                    return ERR_PTR(-EINVAL);

If the mod_allow_cnt > SSIZE_MAX guard were dropped, the loop would still
return -EINVAL on i == 0 because names[0] is NULL, so the assertion passes
and the count-overflow check goes untested. The overflow guard is the only
thing keeping obj->btf_module_allowlist_cnt (ssize_t) from being assigned a
negative value from a size_t count, which is_btf_mod_allowed() interprets
as "allowlist unspecified, allow everything."

The other four cases each pin exactly one check (null_list tests !mod_allow,
null_name tests !mod_allow[i], empty_name tests !mod_allow[i][0],
duplicate_name tests the strcmp loop). Would passing a list of valid
non-empty names like duplicate_names[0] (i.e., { "bpf_testmod" }) with the
oversized count discriminate the count check from the unrelated precondition
check?

> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34972296720
--===============0224972729011567103==--
