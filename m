Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDE374A11;
	Thu, 13 Aug 2026 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638421; cv=none; b=YZTUXfw9NktZvY9xVzcnQLT3c6S2CtdZkNP2dXQL37C8eEECcnfZE6N11kssvA2H2tCExNw8RtEc3hUtg7ZIZiA3kPQn/pjhopTIgqjDBJRDLZm9LihWAr+NbudgfzA3i9Ded88ceW+K02DTItVD7qyYM0kLpVT33JFKSVAHgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638421; c=relaxed/simple;
	bh=+5iiwb/IqfhB0c5XVuKMEg8R6UG2DurfE0mqD/r2BlY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fLXhxoQSimzJnqgc/A1rZ+9Smhd02G4sVx0rgcVkcOJq1zcJfgIeOVlnEY2IkLTqP5G9uuAkve6RDOFo8xDOP1qvu6JiJ+ko8WplkXWq17iNkzQx8vfRmvZVocoPvlGI9TeLdC1B7nFdVHzU0JeyljzIu8WipjqsjFbSh/6CcLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnfgSPHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnfgSPHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AF91F000E9;
	Thu, 13 Aug 2026 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786638420;
	bh=FDwPBMmTjt/n1XIHuKyA87/9hlxKHgTWN8Vn9wykej4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dnfgSPHE9LMP1JGthnqGt4uSLV52B3mtSKr7UFPxEs1vFI18b3LGkw+pge+UZg52z
	 vKqTjvC9d/o3KtIMpC2YaqscCTbbL2VsK+v++XJFomq8YgFIf22rJfO4rmOuJlcdd1
	 qKHQPw9tOoxIhq2dqxddBTRmJuyi6+yh+qdo2shvBCETJ6I7Mv1sDt4hDfhlOXRKSj
	 AQqh8VwzzqDDvQV1ooaZFuR9vk96nytFbpP7Tv4Djqy3nxBMq+yUFoXNCPRwZI6mvJ
	 vfHvwtIFf8k8sLuxgEV/wcr7yv8d3VtbNqb4CFaP0kllxkyxdoZQMa6MsfpEoSQ33K
	 aZFWJNtfjz7DA==
Content-Type: multipart/mixed; boundary="===============3118981536321115134=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ffc09de1b26ea2a7bf3015a63307a134259c376347b778b71706b9830dcd185@mail.kernel.org>
In-Reply-To: <20260813152324.97937-8-leon.hwang@linux.dev>
References: <20260813152324.97937-8-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v12 07/10] selftests/bpf: Add tests to verify global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 16:26:59 +0000 (UTC)

--===============3118981536321115134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 8466332d7406f..06d163a022dcc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -60,3 +63,188 @@ void test_global_data_init(void)
>  	free(newval);
>  	bpf_object__close(obj);
>  }
> +
> +static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_fd, int *runp)
> +{
> +	struct test_global_percpu_data__percpu *data = NULL;
> +	int i, err, key = 0, num_online, run = 0;
> +	__u64 args[2] = {0x1234ULL, 0x5678ULL};
> +	size_t data_sz;
> +	bool *online;
> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
> +		    .ctx_in = args,
> +		    .ctx_size_in = sizeof(args),
> +		    .flags = BPF_F_TEST_RUN_ON_CPU,
> +	);

This isn't a bug, but does the raw_tp ctx need to be passed here, given
the program ignores it?

[ ... ]

> +static void test_global_percpu_data_init(void)
> +{
> +	struct test_global_percpu_data__percpu init_value = {};
> +	struct test_global_percpu_data__percpu *init_data;
> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);
> +	struct test_global_percpu_data *skel = NULL;
> +	size_t init_data_sz;
> +	struct bpf_map *map;
> +	int prog_fd, err;

[ ... ]

> +	map = skel->maps.percpu;
> +	if (!ASSERT_EQ(bpf_map__type(map), BPF_MAP_TYPE_PERCPU_ARRAY, "bpf_map__type"))
> +		goto out;
> +
> +	init_value.data = 2;
> +	init_value.nums[6] = -1;
> +	init_value.struct_data.i = 2;
> +	init_value.struct_data.nums[6] = -1;
> +	err = bpf_map__set_initial_value(map, &init_value, sizeof(init_value));
> +	if (!ASSERT_OK(err, "bpf_map__set_initial_value"))
> +		goto out;
> +
> +	init_data = bpf_map__initial_value(map, &init_data_sz);
> +	if (!ASSERT_OK_PTR(init_data, "bpf_map__initial_value"))
> +		goto out;
> +
> +	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
> +	ASSERT_EQ(init_data->set, init_value.set, "init_value set");
> +	ASSERT_EQ(init_data->struct_data.i, init_value.struct_data.i, "init_value struct_data.i");
> +	ASSERT_EQ(init_data->struct_data.nums[6], init_value.struct_data.nums[6],
> +		  "init_value struct_data.nums[6]");

This isn't a bug, but should init_value.set be given a non-zero value,
and nums[6] checked, so these assertions can actually distinguish a broken
copy?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31716447858
--===============3118981536321115134==--
