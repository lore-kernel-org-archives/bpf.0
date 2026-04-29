Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D953A7F66
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498171; cv=none; b=gSNn6MYFuE73NMjA7jBwC8mlNnhirgLo21bDbHHlhQwbuo/SmxMylNsWr3wUHt1oKvFixhZa88yurGu8xSdAm5BLrUwaks0lcenc1eQn9OonuzLqSu2zT+oIeGyCGxCxl87bQ6CtWU374RKHQGKzdXPL2JpLzwtZUq8mT06w5Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498171; c=relaxed/simple;
	bh=Hph1RsYxqQ9N4uCfoGd9vUdXSdHiGTIxZSubqlVGeaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gG2r3N+4n0I4P27FrlL2DKKLZT0wZwp+Ni0xhuioRp1fJh2dEGZBc5a2OksXLs+sWPArvHtwmuWJqHNtZW6qDLDRq1Lj9ZDNb032nl+LJU9TsXvVyegwDp798HpfIo7WDl5BDqWAOC2z0Q81A5x3aOZjIw6wj0YUvNbg5Ra2zUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sw16/FvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sw16/FvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DD4C19425;
	Wed, 29 Apr 2026 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498171;
	bh=Hph1RsYxqQ9N4uCfoGd9vUdXSdHiGTIxZSubqlVGeaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Sw16/FvJ4XWNqq1YPl78bY8XWVH7i7vSI0vRCMB0oUC/f9fsvZqrMum58c/MMaZtJ
	 IQb+gYDi7Ql6pmZa17pH3zQ5mI9nUavGyliEpzF7TB2uPW7tdodImmPAHT7cxaXHDx
	 C9PaGDI8v/xt34IzpMHiG5llNwwGAmMO4Oj1lWVk8OhMJm9BKZ+oDhiVIfR3ZWlAmM
	 MVcK59CpsFWHxggMzPVFY8+zpbWmFetM4Z00eXKF1Zl4QoOJ+NzChHk7+HA32zBoSN
	 HO/Xavki1lAkIrCNeUxAIPbNw0yOw7ExwnGF/KfV4SSa4FruPoNTOOGZnu2uA22Ej0
	 iiZt3MYIKpyhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v9 10/11] selftests/bpf: Provide weak
 definitions for cross-test functions
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-10-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-10-c311f06b4791@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 21:29:29 +0000
Message-Id: <20260429212931.44DD4C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Test flakiness and deterministic failure due to Identical Code F=
olding (ICF) of weak stubs.
- [Low] Missing `<alloca.h>` include for `alloca()` in `testing_helpers.c`.
--

commit 45cfa2851c72a65543e44de19ed32088ef920e33
Author: Ricardo B. Marli=C3=A8re <rbm@suse.com>

selftests/bpf: Provide weak definitions for cross-test functions

This commit replaces forward declarations of uprobe_multi_func_{1,2,3}() wi=
th
weak no-op stubs to allow the linker to resolve them when skeletons are
missing. It also moves stack_mprotect() to testing_helpers.c to make it
universally available and resolve an issue where the previous weak stub
returned 0.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/=
testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 35adc3f6d443..5a864cd8ad1b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c

[ ... ]

> -/* defined in prog_tests/uprobe_multi_test.c */
> -void uprobe_multi_func_1(void);
> -void uprobe_multi_func_2(void);
> -void uprobe_multi_func_3(void);
> +/*
> + * Weak uprobe target stubs. noinline is required because
> + * uprobe_multi_test_run() takes their addresses to configure the BPF
> + * program's attachment points; an inlined function has no stable
> + * address in the binary to probe. The strong definitions in
> + * uprobe_multi_test.c take precedence when that translation unit is
> + * linked.
> + */
> +noinline __weak void uprobe_multi_func_1(void) {}
> +noinline __weak void uprobe_multi_func_2(void) {}
> +noinline __weak void uprobe_multi_func_3(void) {}

Because these three weak stubs are structurally identical empty functions,
can compiler and linker optimization passes like Identical Code Folding
(ICF) merge them into a single memory address?

If they are folded into a single address, bpf_program__attach_uprobe_multi()
will attach three separate uprobes to the exact same offset, each with a
different cookie.

Calling any of the functions would then execute the shared address,
triggering all three uprobes simultaneously. This would increment the BPF
program counters multiple times per call, causing assertions like:

    ASSERT_EQ(skel->bss->uprobe_multi_func_1_result, 1, ...);

to fail deterministically, as the result would be 3 instead of 1.

Would it make sense to make these stubs structurally unique, perhaps by
adding unique inline assembly to each?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
> index 6fbe1e995660..3f7ae76c209b 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c

[ ... ]

> +int stack_mprotect(void)
> +{
> +	void *buf;
> +	long sz;
> +	int ret;
> +
> +	sz =3D sysconf(_SC_PAGESIZE);
> +	if (sz < 0)
> +		return sz;
> +
> +	buf =3D alloca(sz * 3);

Does this code rely on a glibc-specific extension to provide alloca() via
<stdlib.h>?

The original implementation in test_lsm.c included <malloc.h>, but the new
location in testing_helpers.c includes neither <malloc.h> nor <alloca.h>.

On systems with strict POSIX-compliant C libraries, such as musl, omitting
<alloca.h> can result in an implicit function declaration error and lead
to build failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429-selftests-=
bpf_misconfig-v9-0-c311f06b4791@suse.com?part=3D10
