Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF26376A17;
	Mon, 22 Jun 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141898; cv=none; b=ilqS789Ii2NMdEls2HUPP6d8NsSI2YdC28p2I1MzBDEEgzfXUvQaWKX2nlpSVE3PJCzeNvLoQUEn9loMEdwP1sX8Q+4qBrrmsHCfShb67FIKJ//n5fK8gljUv8EU7n1hleiKu8ghw5VFW4r9iW4lRw3cwr0QoAPaN/9rSdrgIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141898; c=relaxed/simple;
	bh=nVM6qzbE62kPfLswNwG8q7n+q0r5BPC9J997F0e/g9E=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mw2GOivelBSWLwcbN+tdClKF8POLHUmLxaNcRx5SIr06H+PZa99Tj70eZXg5KXXTqXbRx3r0NDmd/t4iKjOs6TjIr02gEXm9DSTSFAljiBNwZBnqtiPUBexM4Gv5xrSAQqHycIyFbbQnscZ+s+wy43KfOw/ukJT+Bxshcjv3ueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOxBsX6C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOxBsX6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41A71F000E9;
	Mon, 22 Jun 2026 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141897;
	bh=cbeKfu17tBiAS0FDXgOQSoAVTFsigHMYz55m1zksYr0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NOxBsX6CTw0k5xBumeoITowE9mDZYoqtdNuAXPAyGHxwYsxiYhRWyiERknps4/GXD
	 6bB4LZDkpgkld5R2gey5zv78JhnE7twtlVa+BQvryg/plFJ+vLK+4+qAUMvp5tNR0b
	 EsM32M96B71Nm1jOICxQRdnWm3uzVHRwRw7ZqFxe18vsw9rD19AG6JHHrzBMmGkx3s
	 gEkfhCM5BXtFo1Asd9+RYkkH90QeUpdGSzI2UUDdt1yXeY4K4W3Q3ryjgFPoHF+ZHm
	 tUBz1XTckTvkSp/g+5zsLFQmuoPoi46RThyrI6/VhAziivEZ7K30SLXuJGmVAWxs3x
	 SmBOALVXvIMgQ==
Content-Type: multipart/mixed; boundary="===============4537162876206891078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eebc3e5edf723fd9c43307225efa00263590db7b56f385d384ff9b3f0220dd78@mail.kernel.org>
In-Reply-To: <20260622143557.22955-9-leon.hwang@linux.dev>
References: <20260622143557.22955-9-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v7 08/11] selftests/bpf: Add tests to verify global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 15:24:56 +0000 (UTC)

--===============4537162876206891078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406..ea7e4e3d91cf 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -60,3 +63,184 @@ void test_global_data_init(void)
> +
> +static void test_global_percpu_data_init(void)
> +{
> +	struct test_global_percpu_data__percpu init_value = {};
> +	struct test_global_percpu_data__percpu *init_data;
> +	int key, prog_fd, err, num_cpus, num_online, i;
> +	struct test_global_percpu_data *skel = NULL;
> +	__u64 args[2] = {0x1234ULL, 0x5678ULL};
> +	size_t init_data_sz;
> +	struct bpf_map *map;
> +	bool *online;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .ctx_in = args,
> +		    .ctx_size_in = sizeof(args),
> +		    .flags = BPF_F_TEST_RUN_ON_CPU,
> +	);
> +
> +	num_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(num_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	err = parse_cpu_mask_file("/sys/devices/system/cpu/online", &online, &num_online);
> +	if (!ASSERT_OK(err, "parse_cpu_mask_file"))
> +		return;

This isn't a bug, but num_cpus is only read by the ASSERT_GT guard and is
never used afterwards; the per-CPU loop is driven entirely by num_online
from parse_cpu_mask_file().  Is the libbpf_num_possible_cpus() check needed
here, or is num_online sufficient?  The same pattern appears in
test_global_percpu_data_lskel().

[ ... ]

> +static void test_global_percpu_data_lskel(void)
> +{

[ ... ]

> +		flags = ((__u64) i << 32) | BPF_F_CPU;
> +		err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
> +		if (!ASSERT_OK(err, "bpf_map_lookup_elem_flags"))
> +			goto out;
> +
> +		ASSERT_EQ(data.data, 1, "data.data");
> +		ASSERT_TRUE(data.run, "data.run");
> +		ASSERT_EQ(data.nums[6], 0xc0de, "data.nums[6]");
> +		ASSERT_EQ(data.struct_data.i, 1, "struct_data.i");
> +		ASSERT_TRUE(data.struct_data.set, "struct_data.set");
> +		ASSERT_EQ(data.struct_data.nums[6], 0xc0de, "struct_data.nums[6]");
> +	}

This isn't a bug, but this post-run assertion block duplicates the one in
test_global_percpu_data_init() almost verbatim; the two loops share the same
online-CPU iteration, the same bpf_prog_test_run_opts setup, and the same six
data.* checks, differing only in the lookup call (bpf_map_lookup_elem_flags()
vs bpf_map__lookup_elem()).  Could the six data.* checks be factored into a
shared helper taking the looked-up value?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27961789929
--===============4537162876206891078==--
