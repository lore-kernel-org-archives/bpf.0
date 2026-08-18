Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4B46985C;
	Tue, 18 Aug 2026 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069709; cv=none; b=WfR1jMNPealUzEGQSSq0G9sHpza8+3g7u25FyXG+yHkXY1l7ykQxdqkA35e6vGD/Lh9e0suQHNHuRQRLlBT67h7nFVhviD4m7MmQ894DKD8Y2EfSwo2ckDXbWjH9f8WVqslxG2eXFx/1MD+3vWk5+pYQ+olQ643HMmn9lsJw+VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069709; c=relaxed/simple;
	bh=75Rve+GoGOnr4CgPlvfbfzdSBbFcKHOV18VQDZ+ZPm0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TNpaI7A9P2nyXVMXIZk6EXlbRiHJtYUloo9wO87qz1cNHEKfB6Gt2Y9ws29JpeEVFiMFSVPv2unn64sUrh2t92XIP+UgXw8d4LHOqhmZjKxSk3rNv/s6MPI2iJJVfCxzC42zs5NI4AiE23JrzGplpMEEiHbFiXbid3w4OzjBTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVdz+ZaR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVdz+ZaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739E91F000E9;
	Tue, 18 Aug 2026 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069707;
	bh=cLn5pPKmF+xvtehXhmEaSh/ZPFybb4A6pWHoR26dyo4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OVdz+ZaRUoEtyTJKVb/DpUAOBsQnV93IWIxJhFAgUFr/1ghtDruvRVOd3CjWbe5ZG
	 IZJxoumHHmUveIwgnJ1WuSo6fZQNsLOaIJ01snkZoSywDhQJGcIMaKNAfom7Y1Itys
	 U0Kk9yYmFDsyIeKtHEJm+QhIZnlWjyfTXQSFRkLeFStmP1RwXzIMBPR1NnG9VXA3WH
	 ijfPV7HqreAQnFq5vUzfx70iCo+Tuo2pHJx91SWkgCeWooGEfNcUf8rJNKLIzxuxQJ
	 5jTJ5qmDa1G/F418HVRJPhbLh6sbap3TdqtfD2YJLr/3tpH9Ohx87mFgyoylt7tn/3
	 mqszAIy7HWcZw==
Content-Type: multipart/mixed; boundary="===============8419694916487994497=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
In-Reply-To: <20260818153202.90714-1-leon.hwang@linux.dev>
References: <20260818153202.90714-1-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test for percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,leon.hwang@linux.dev,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 16:15:07 +0000 (UTC)

--===============8419694916487994497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 5671c31085cd..2b69290bcc3e 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -236,6 +223,57 @@ static void test_global_percpu_data_lskel(void)
>  	test_global_percpu_data_lskel__destroy(lskel);
>  }
>
> +#define PAGE_SIZE 4096
> +
> +static void test_global_percpu_data_map_resize(void)
> +{
> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
> +	struct test_global_percpu_data *skel;
> +	const int arr_value = -1;
> +	struct bpf_map *map;
> +	int err, prog_fd;
> +	size_t data_sz;
> +
> +	if (sysconf(_SC_PAGE_SIZE) != PAGE_SIZE) {
> +		test__skip();
> +		return;
> +	}
> +
> +	skel = test_global_percpu_data__open();
> +	if (!ASSERT_OK_PTR(skel, "test_global_percpu_data__open"))
> +		return;
> +
> +	map = skel->maps.percpu_arr;
> +	skel->percpu_arr->arr[0] = arr_value;
> +	err = bpf_map__set_value_size(map, desired_sz);

This isn't a bug, but since the guard above already pins the page size to
4096, would `const __u32 desired_sz = PAGE_SIZE * 2;` read more directly
here - and is the unguarded `#define PAGE_SIZE 4096` preferable to the
`#ifndef PAGE_SIZE` form used in sockopt.c?

> +	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> +		goto out;
> +	if (!ASSERT_EQ(bpf_map__value_size(map), desired_sz, "bpf_map__value_size"))
> +		goto out;
> +	if (!ASSERT_NEQ(bpf_map__btf_value_type_id(map), 0, "bpf_map__btf_value_type_id"))
> +		goto out;
> +
> +	skel->percpu_arr = bpf_map__initial_value(map, &data_sz);
> +	if (!ASSERT_EQ(data_sz, desired_sz, "data_sz"))
> +		goto out;
> +	if (!ASSERT_OK_PTR(skel->percpu_arr, "skel->percpu_arr"))
> +		goto out;

This isn't a bug, but would it read more consistently with
test_global_percpu_data_init() to check ASSERT_OK_PTR(skel->percpu_arr)
before ASSERT_EQ(data_sz, desired_sz)? The block this replaces checked
pointer-then-size, and the surviving test_global_percpu_data_init() at the
same file still does pointer-then-size.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32156312094
--===============8419694916487994497==--
