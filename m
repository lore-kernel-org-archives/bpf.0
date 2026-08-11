Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90D139F174
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474617; cv=none; b=M06V1zef868z5MJV/HN/HedLHeG+EsIlLrACeKTLZOsODc717eG266cR9SJ1xES6+d7hLGMYHeL8JTqT9Te25XdDGydDJZnJZFDUB4ASSfxCTZWocnLZ8d1HqwvB955mA9rj83QKRgrrFenjCvpJsldgnoOvGecA/64qJ88PE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474617; c=relaxed/simple;
	bh=xplcU9pLLcsf9VFzcq8LINeP/Rh7R0/216vKBR4VtCI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UryzkS9cSxncTOw1VbaGVP2PkrfpUOPTUJMkm6U/zLIoTyO0wMAfTwq1VPNF9tQCiYZZZYnJz9fUMh4Uq7XXeaCkjEvSCdJDfuCXWhAzkwig68WeVeFaYhyxnDRG+UpZXiHeDCIU7WerouN9HmE5DMuyH2dwSHbNCfn1zpglzj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/NveLxL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/NveLxL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4711F000E9;
	Tue, 11 Aug 2026 18:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474615;
	bh=VYTquF4fgLFTmGoKrcZb0NPjywc+hkoGBCtqLOcfQq4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=G/NveLxL2wEQwZmLF9V+URJdiqUEqPGPT0CPLu3P7KSkTg1r7LxQNLPKFVL4BHP/D
	 3VJ4mWq9/mPHjOveNptinQG065h/ImaFwx3lFhvPux/8Vsj7m9zcC6gr+kE2Erl/6L
	 g3jo3B8Wyd4Qd9iJ7PaaG7rPf/bzcjWL31ftZ1/iWmtAHWbZ0ClfbYdK1uDU/NBTn9
	 o3tOZNw2LVlOq/X01gaRegehUk9vd5QvkBVMQDu1u3rE5hXcjMKloou18ricVn78eA
	 kms/AGBFi//bnNi/rWxt7hzlfGMf8RaUqOtGnpAZsN2Av1Tg9ah+w0+hnQfJVrmBJE
	 TaBTUAF1M6NGw==
Content-Type: multipart/mixed; boundary="===============1546216123881772698=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f600f7fa9410958a73e65c5d9ab1c069b404368473adfa99d38f08cca8bf955a@mail.kernel.org>
In-Reply-To: <20260811-veristat-filter-fix-v1-2-b5b43c431550@gmail.com>
References: <20260811-veristat-filter-fix-v1-2-b5b43c431550@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: exercise veristat filtering logic in a selftest
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 11 Aug 2026 18:56:54 +0000 (UTC)

--===============1546216123881772698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Test cases for veristat file/prog name filtering logic.
> Check various formulations for any (*foo*), file (*foo*/),
> prog (/*bar*) and file/prog (*foo*/bar) filters, alongside
> errorneous filters and mixed allow/deny filter expressions.

This isn't a bug, but there's a typo: "errorneous" should be "erroneous".
Also, is the prog filter form meant to be "/bar" rather than "/*bar*" to
match the cases in the table?

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> index 9aff08ac55c0..e1eda4ae755e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
> @@ -37,6 +37,13 @@ static struct fixture *init_fixture(void)
>  	return fix;
>  }
>
> +static void read_output(struct fixture *fix)
> +{
> +	ssize_t len = pread(fix->fd, fix->output, fix->sz - 1, 0);
> +
> +	fix->output[len < 0 ? 0 : len] = 0;
> +}
> +

This isn't a bug, but since read_output() also terminates the buffer, would
it make sense to switch the existing read()/pread() call sites in this file
over to it as well? The new helper is safer than the bare reads used in the
other subtests.

> +/*
> + * Name filter tests below run veristat on veristat_foo.bpf.o and
> + * veristat_bar.bpf.o, both defining programs 'foo', 'bar' and 'buz'.
> + * Every entry describes a single (filters, file, prog) combination and
> + * tells whether that program is expected in the veristat output:
> + * 'true' if it is, 'false' if it is not and -1 if veristat is expected
> + * to reject the filter.
> + */
> +#define FILTER_OBJS "veristat_foo.bpf.o veristat_bar.bpf.o"
> +
> +static const struct name_filter_case {
> +	const char *filters;
> +	const char *file;
> +	const char *prog;
> +	int included;
> +} name_filter_cases[] = {
> +	/* no filters, every program is processed */
> +	{ "",			"foo", "foo", true  },
> +	{ "",			"foo", "bar", true  },
> +	{ "",			"foo", "buz", true  },
> +	{ "",			"bar", "foo", true  },
> +	{ "",			"bar", "bar", true  },
> +	{ "",			"bar", "buz", true  },
> +	/* deny filters */
> +	{ "-f '!*foo*'",	"foo", "bar", false },
> +	{ "-f '!*foo*'",	"bar", "foo", false },

A subsystem pattern flags this as potentially concerning: the table rows for
'-f !*foo*' both assert 'false' (row should be absent), but there is no row
that asserts 'true' (row should be present) for the same filter. Every other
filter with 'false' rows also has a 'true' row for the same filter string.

For example:
  '!*foo*/bar' has (foo,buz)/(bar,bar) true
  '!*foo*/' has (bar,bar) true
  '!/bar' has (foo,foo) true
  '*foo*/bar' has (foo,bar) true

Adding one positive row for '-f !*foo*', such as { "-f '!*foo*'", "bar",
"bar", true }, would make this filter's coverage consistent with the rest
of the table. A regression that made the any-glob deny form reject everything
would still satisfy both existing rows plus ASSERT_OK(err), because absence
of a row is all that is checked.

The expectations themselves are correct (they match veristat's implementation
and the changelog table of the preceding fix commit), so this is a
test-completeness observation rather than a functional bug.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/veristat_bar.c b/tools/testing/selftests/bpf/progs/veristat_bar.c
> new file mode 100644
> index 000000000000..83d2a2a1dfc9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/veristat_bar.c
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Meta Platforms, Inc. and affiliates. */
> +#include "veristat_foo.c"

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31521742364
--===============1546216123881772698==--
