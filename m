Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869C728642B
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189872; cv=none; b=hZ/yaI+j7WCEcG5Y/8PTyUXlkQsD1JjM8llq+ohyBIedUVjdiLx3hY+8fTPPRTPrrd+vYWBxfMlD8ZCRVu9ZxhLs2O9+4LGxmGI8i52OVIHKKwTSW8swO2fGwPFPaKH4sRU0zzoG2p7E8s87sajpcXDYVOHjxByTswf8KRJWpyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189872; c=relaxed/simple;
	bh=ru7St3GPLCSDrIPYQsh6BjQXE1pyTY/hDLrmHEZOZQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mYPeRxwyz8RJmdERlSDClGWqsGqcGH2TOfjnihHQPUVDGxPTWUEIZAOvg7c5dBhleqL6f24zKSuuaJuKJ9UvxOKBs88Z8KG5Q7kKyiuLx3EPLFwm2LhZ5s4ehJtBukonMrm25yfc4l/0SnQnzME5HJ4rgOV/qhm3k2bySJSNWYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Zp9Zuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Zp9Zuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22BA1F00893;
	Sun, 31 May 2026 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780189871;
	bh=ZbM24VlKTo2VMZ6oHDFvS1K5PiKv/L1UH1Tm63jGwMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X4Zp9Zukn/4vlSIUmGGcB8rZuVmBdSa3ihDW2o/P/86qsfnfBjzS8zIFP/NzjK+vn
	 7ICXmX2CZfWM8yCfVSdcssR8Jd8Nu56j3oSvRCv7qmmZnTMX1ADepi//isEOlrxUOr
	 XT+P60OQSUwXPwpKS/8woNk5COu8RzfKEQqEyOdL+Qht4QgMueUQgjppEQ8BoZF2Zi
	 jq45ijCEdBgis6cF2kr7KHzeoNadZBQBabLK42zujGd4pwqFHYJKQ3jWTRyllrchNp
	 wAe+/mnM0fwhVIq6QN0evIbRxN7vzNBj7v2kX+sKnLtyZX0l7Dt9dDHzGVtMvR2R+z
	 qTIcbuxbZOa/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add verification for
 BPF_PROG_QUERY attr size boundaries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuyang Huang" <yuyanghuang@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260531004748.3567875-3-yuyanghuang@google.com>
References: <20260531004748.3567875-3-yuyanghuang@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 01:11:10 +0000
Message-Id: <20260531011110.F22BA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The selftest validates and enshrines an ABI-breaking kernel be=
havior where BPF_PROG_QUERY rejects valid queries from older user-space bin=
aries with -EFAULT.
--

commit a51bd156081fb623564c01426a789df272b5e924
Author: Yuyang Huang <yuyanghuang@google.com>

selftests/bpf: add verification for BPF_PROG_QUERY attr size boundaries

This commit adds a selftest to verify that BPF_PROG_QUERY rejects queries
with a user-declared size below the size covering query.revision with
-EFAULT. It also ensures the query succeeds when given the full size.

> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> new file mode 100644
> index 0000000000000..4fbe56cb29d4a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Google LLC */
> +#include <linux/bpf.h>

[ ... ]

> +#define OLD_QUERY_SIZE		offsetofend(union bpf_attr, query.prog_cnt)
> +#define FULL_QUERY_SIZE		offsetofend(union bpf_attr, query.revision)
> +
> +static void test_query_size_boundaries(void)
> +{

[ ... ]

> +	memset(&attr, 0, sizeof(attr));
> +	attr.query.target_fd =3D cg_fd;
> +	attr.query.attach_type =3D BPF_CGROUP_INET_INGRESS;
> +
> +	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
> +	ASSERT_EQ(err, -1, "query_old_size_fails");
> +	ASSERT_EQ(errno, EFAULT, "query_old_size_efault");

[Severity: Critical]
Does this selftest validate an ABI-breaking kernel behavior where
BPF_PROG_QUERY rejects valid queries from older user-space binaries with
-EFAULT?

Older user-space applications (like an older bpftool) compiled with older
headers will supply a smaller bpf_attr size up to query.prog_cnt.
Previously, the kernel would accept this size, but this test now enforces
that the kernel rejects these historically valid queries unconditionally.

Should the kernel conditionally copy to query.revision only if the
user-provided size is large enough, rather than breaking backwards
compatibility for existing binaries?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531004748.3567=
875-1-yuyanghuang@google.com?part=3D2
