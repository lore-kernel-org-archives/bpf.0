Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71023D7C2
	for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077506; cv=none; b=NIFagvhg05XOteN1dyWJi2j9Wv4jD5yPTVRomCTXjiFo9WzQWbMfW/UpEvobROF3dh3nrGztDS4n4LT+T8+DginRAcOZNZICmhYbJewkpcgVdRbsAHllVT3SyOCyKWbOXCxR8MRlN8a6xHZnPbGXl7gOPHKOAQqPkg8aDkeZOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077506; c=relaxed/simple;
	bh=LhMnv4Mq04ily6We3/wdoXX2kTAPMCFY5jDOdhF23qU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jzOl1IFL6+bkt5t7bw46vWGsprjl3ZysjWHdyy7tkk2v0kupSQqm/CDE7qfZkZX9C3HoUCx40zXObx36nDeT0TSBGmq3dTnlmhYRCjvmjmoe0z7YyRbHrqfMTRWB44+8sZ0pBhftX8T07UaQgXB9J2+uN6K1J0afw6SFeTTi35s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKPfQl7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKPfQl7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC791F000E9;
	Sun, 21 Jun 2026 21:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782077505;
	bh=TbA1o9ir+dqSXGXfO6MojllTUNENNvryPJjIQqgTFWI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RKPfQl7sg4GPje7Xz07THBP7dbuk9ByNp7L7k8ta0cpfOLlaIa2JFU6b7l3+yvEYh
	 Zi9XS9txEmFH/3Oel68leDW0hVy/VNeK+hMo6j+vPYWjR9G9pFkvJPUkwaSNI7nwHt
	 GrbE50b952ORJXIic74F3kRfGH1ZmxVYq3OV6IUH9vE12CUxBYmDL9aohmGeYljsjw
	 x/GT2Hbzt+Vd7EVPxuyl2Rp4bPPSoZcBkC/I1jZ9WUqB9RouOVh6uTECu4HB5w595j
	 lvDhAjvALNiZNaXGvy8ptEUUEF9OhkMPpC0Ygvj66Y1LwULKsY8mw2/PDGDftztkhy
	 xMdFxYlL63yPA==
Content-Type: multipart/mixed; boundary="===============6368068181922707508=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb2607f92eea9b6470e906a22ad2148eda290f6f1389d6bebf155075566f5c33@mail.kernel.org>
In-Reply-To: <20260621204524.61067-3-jolsa@kernel.org>
References: <20260621204524.61067-3-jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: Add tracing_multi link info tests
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,qmo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 21 Jun 2026 21:31:45 +0000 (UTC)

--===============6368068181922707508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index f589eefbf9fb..969f04ee9ac6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c

[ ... ]

> @@ -396,6 +413,224 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
>  	bpf_link__destroy(link);
>  }
>
> +static void verify_tracing_multi_invalid_user_buffer(int fd, const struct tmulti_target *targets)
> +{
> +	__u32 ids[TRACING_MULTI_CNT] = {};
> +	struct bpf_link_info info;
> +	__u32 len = sizeof(info);
> +	int err, i;
> +
> +	/* Wrong info setup (ids != NULL and cnt == 0) -> EINVAL */
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.ids = ptr_to_u64(ids);
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -EINVAL, "tracing_multi.invalid_count");
> +
> +	/* Smaller than actuall count provided -> ENOSPC */

This isn't a bug, but "actuall" is misspelled here (should be "actual").

> +	memset(ids, 0, sizeof(ids));
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.ids = ptr_to_u64(ids);
> +	info.tracing_multi.count = TRACING_MULTI_CNT - 1;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_EQ(err, -ENOSPC, "tracing_multi.small_count");
> +	for (i = 0; i < TRACING_MULTI_CNT - 1; i++)
> +		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.partial_ids");
> +	/* check that the last entry is not populated */
> +	ASSERT_EQ(ids[i], 0, "tracing_multi.partial_ids");
> +
> +	/* Bigger than actuall count provided -> OK */

The same typo appears here.

> +	memset(ids, 0, sizeof(ids));
> +	memset(&info, 0, sizeof(info));
> +	info.tracing_multi.ids = ptr_to_u64(ids);
> +	info.tracing_multi.count = TRACING_MULTI_CNT + 1;
> +	err = bpf_link_get_info_by_fd(fd, &info, &len);
> +	ASSERT_OK(err, "tracing_multi.big_count");
> +	for (i = 0; i < TRACING_MULTI_CNT; i++)
> +		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.ids");

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27917285330
--===============6368068181922707508==--
