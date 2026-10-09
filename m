Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB5220ED
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514607; cv=none; b=P6kzYQw//lCsgdA50AthVE2IBQZCf4hDGOPgXRIHHNc9GQBkh64nyVeIzLkqDDgutPtVk6F0YYcOipnMmk7MxsWJZ35JZbskWpDqncat6YzP1Q6QSvZIjIO6uU6V+lWu7R8WNmIEZaVhaUdGEJzau9zW7txkAt4IqYDNxW68CHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514607; c=relaxed/simple;
	bh=BgpHcmFlo30/Lwv9uNNycEaC7c7DBwAsQqiQTs6IQqQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=VJvs8dlfKSdvwhgWJPwA94Ly+htUNeBmZ1jJ7cQeMQFvPKJhXpCypYKQVYsY3YcrZart6S59kSQpQxjVsSbuxe4AQ8ijqhjIC4HBpbH09Zcn9OehRhSSZ/I6FmRoKy3TA9CWjZ/fz7I5Qwho40kvuOmvbNyjNaAcmbRM6d6vNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkscCtfQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkscCtfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8644E1F000FF;
	Fri,  9 Oct 2026 02:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791514605;
	bh=QVqYhpAruLgPAJ2lQBOm81DBQa+kQPUUIAixzO1e6mU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkscCtfQiojp4vZ75J4IS6gPpQS7NQm+97ZI1NADNdSAqUCxUCCVyt+1Np1E6VfgM
	 AzPjLhILWsEGHfPeQZXwRfHxBqymQ/IYA+5Rj0fbPxg+7X79816Gboo+fg6Z8/+lCL
	 qhG+SO+uxmwH115Mz9su1WC1rASD3sgXA7Ublm5qpIeR3S9U8qghKY4wYIjzLyECeK
	 zAhZ6ePzhj33+JGx6vtWop1qPArQ5IuGb+VZqT/pD1I0ILu0nWZZg6CgGKsgf5csgg
	 IeEWVe1R1lNGCe1ENuL9oN/wsqiMRkACCCeSmK5jQjCfpXMWoL/4ljce+sDy/7vao1
	 xHnsaubcvLNnQ==
Message-ID: <sashiko-outbox-164736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 3/3] selftests/bpf: Test PROBE_MEM loads
 from invalid addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009024925.3169077-4-memxor@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 02:56:45 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/bpf: shift-count overflow and skeleton layout mismatch=
 on 32-bit hosts
--

commit 96530723e8030fb7a1b5acdb7814f68def3240b2
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Test PROBE_MEM loads from invalid addresses

This commit adds a BPF selftest that verifies whether PROBE_MEM loads from
various invalid addresses properly yield zero and prevent the kernel from
crashing. It does this by testing loads of three sizes through a pointer
value chosen by userspace.

> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c b/t=
ools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
> new file mode 100644
> index 0000000000000..57a313e35eb62
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_mem_fault.c
> @@ -0,0 +1,69 @@

[ ... ]

> +/*
> + * Addresses a PROBE_MEM load has to survive. Either the JIT's address c=
heck
> + * or the fault handler must turn each load into a zero result.
> + */
> +static const struct {
> +	const char *name;
> +	unsigned long addr;

[Severity: Medium]
On 32-bit architectures, unsigned long is 32 bits wide. Could this truncate
64-bit addresses and cause a misalignment of the BSS structure on those
platforms?

> +} bad_addrs[] =3D {
> +	{ "null", 0 },
> +	{ "low_user", 4096 },
> +	{ "last_user_page", (1UL << 47) - 4096 },

[Severity: Medium]
Will shifting a 32-bit 1UL by 47 bits trigger a -Wshift-count-overflow
compiler warning on 32-bit architectures? Under -Werror, this would cause
a build failure.

Could the ULL suffix be used here instead?

> +	{ "non_canonical", 1UL << 63 },

[Severity: Medium]
Does the same shift-count overflow issue occur here on 32-bit platforms when
shifting 1UL by 63 bits?

> +#if defined(__x86_64__)
> +	{ "vsyscall", VSYSCALL_ADDR },

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/probe_mem_fault.c b/tools/=
testing/selftests/bpf/progs/probe_mem_fault.c
> new file mode 100644
> index 0000000000000..748be45418f5a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/probe_mem_fault.c
> @@ -0,0 +1,41 @@

[ ... ]

> +int target_pid;
> +bool use_current_task;
> +unsigned long addr;

[Severity: Medium]
If this 8-byte BPF variable is declared as unsigned long, does bpftool emit=
 a
4-byte struct field when building on 32-bit hosts?

If so, this appears to misalign the skeleton bss layout and could cause
subsequent fields like val_dw to be corrupted during runtime reads. Would
__u64 be a safer type here?

> +int runs;
> +__u64 val_dw;
> +__u32 val_w;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009024925.3169=
077-1-memxor@gmail.com?part=3D3
