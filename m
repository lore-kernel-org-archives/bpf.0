Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794538308;
	b=XmNn8dO1xzW6kCdGpVo0MDf/i8yxKH3KPq4dOxxiOLNIaIwWH/VtRZFcUskg0gL3e8kY
	 iFOh2wTVTQ302LpKkTsMtXvMqeysxFOhP41vKdk+VpmwmEXZRfS26BnQTni5EtHVDRyp1
	 h+hNvD/TofhS29qgE5kEIpqfgtOpFRxpgqaZE0Hls2ns28+uyh9rH9lkUtbPLuM/JtjDJ
	 1Th6Rm6PQHvYfuPFMBwR1NxcdkGtmuh8lJJ9Oy0frWo3iQlxMLxvixfOmQpy/yF6+RzfU
	 GzjNbHwE95/bEZRkAdCug5b03RVYDU/t03dZuGGruw71fURWY/H0r5/xttl0BwE1/1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YSDKhuAyA203Yf37PQcYYDMK03F6qG5lQsZSKy/tw5g=;
	b=vZ55K67uVMKo1a7mUrVr3E/L9FtzorByM5iOs9aChywMXzrKdqIwT2O8BG9gkAJSKqVY
	 dHD3yfkI9yQc5gjBKhUtxDbaRFacznFEzqPcqobOoZpVfv6WsfhFWpGtGHsREPGW3A1BQ
	 rRe5sRxKB99bLVEj/7vPtXAgfSeKv/RWx2DT4n/iLYpGgaiQZvUWJhwfg3xbnB+/tLgZX
	 Mfhl68yw2BCUNeB7g0SmVgWWv98h+VUzgz+3Oh+T5+wbk32Eu5PiEjfgfPBTrQqH4xxm7
	 tC8/v8qNA+0OHtriw9kv5dzD/z6EE7qxNCJd+dwHsvxRkhIgoXBUIKs1utcQFpWdrHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsJe5KLx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC653606A8B5
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CsJe5KLx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD8A1F000C4;
	Fri, 13 Nov 2026 02:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794538308;
	bh=YSDKhuAyA203Yf37PQcYYDMK03F6qG5lQsZSKy/tw5g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CsJe5KLxXV5wRjj0iD48ClTrdy4CQn7Tdxreax14DwAyYWSBvn/NO4kEPyLX/YMpu
	 MHdkwSQ89wDwvaACzm06JX8w9OtdkGRgM2vnW+kJSo3jlv13oTbcSxdd5I0cSNCcss
	 Ut6Dc43cZ8I+ylBJJWN0EoVw9wBFbtsQALR/3XIjMuh8eW5BGm+X4ltwUnZo7cTvmR
	 LSX5WN2fEsnQb4MGei1qL5Cq/zMBYP9HEBoL0LCKHJ1mpqZbrs7QA3HEUrOmIssi9i
	 CrN94FUT/qh2M6pkhZ4xILXi4I/C3wL9Qj8fCUAY3fMW9reueBcStfcqWFdIslwgtQ
	 iRyGOiEdknVYQ==
Message-ID: <sashiko-outbox-212098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test that a drained css
 iterator keeps returning NULL
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kang Chen" <k.chen@smail.nju.edu.cn>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261113024453.922726-2-k.chen@smail.nju.edu.cn>
References: <20261110125110.2935707-1-k.chen@smail.nju.edu.cn>
 <20261113024453.922726-1-k.chen@smail.nju.edu.cn>
 <20261113024453.922726-2-k.chen@smail.nju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 02:51:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/bpf: standalone css_iter files duplicate existing
  iters_css tests
--

commit 2e186e543b0b323cd0fe5abfcf3d4268a7d8d9cd
Author: Kang Chen <k.chen@smail.nju.edu.cn>

selftests/bpf: Test that a drained css iterator keeps returning NULL

This commit adds a BPF selftest verifying that calling bpf_iter_css_next()
on an already drained css iterator continues to return NULL.

> diff --git a/tools/testing/selftests/bpf/prog_tests/css_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/css_iter.c
> new file mode 100644
> index 0000000000000..9bf8f056d3cd0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/css_iter.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include "css_iter.skel.h"

[ ... ]

> +void test_css_iter(void)
> +{
> +	if (test__start_subtest("next_after_drain"))
> +		test_css_iter_next_after_drain();
> +}

[Severity: Low]
This isn't a bug, but could this test case be added to the existing css
iterator test suite in tools/testing/selftests/bpf/prog_tests/iters.c
(subtest_css_iters()) and tools/testing/selftests/bpf/progs/iters_css.c
instead of introducing new standalone files?  iters_css.c already exercises
bpf_iter_css_new(), bpf_iter_css_next(), and bpf_iter_css_destroy() with
the same ksym declarations and cgroup/RCU setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113024453.9227=
26-1-k.chen@smail.nju.edu.cn?part=3D2
