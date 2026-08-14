Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761A47FB10;
	Fri, 14 Aug 2026 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786731869; cv=none; b=pJnnITktuN2wHtDWFQSdaOKFOkpDhIYuZZ07XBwyVJGk3pJAnTdrhtw7IvmZbD1KaJQhn04T2qZSQtfGKV9CC5wfrrt4VZfUELMkD88i7IH7MCf4ME47obHgGaspZYYLozyHNfLGeOtpnhsxYtn/EZiN/2lrwOS6qwPpHWPbM+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786731869; c=relaxed/simple;
	bh=m3riP3/yeejGRSttuhUtbzwPO+o/kb45JLxtmnaNGgk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lRPZ/2BECh6YQqC+BHBIQuc3Q58FxpoSfHA4dPQ1M8ZPgbGm7ycDg6p5dESPLoG+zCN2XtXDb0LwYgmmsQXkTtg0eg8ShnyqilKyJ1tySDEkHz/CT0zVXr9Z0MWWpKhVGALQrZxvaGviElYmlnb/Idr9Tb0kRCv7ea6ClOQrKUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSw5YS9u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSw5YS9u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC71F000E9;
	Fri, 14 Aug 2026 18:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786731868;
	bh=4bhzNWki0BklTmUGcRCf3GO+bRynImjq/b0SzR7DwTI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eSw5YS9uFViYXjenA4uFUvzfDiouKjSYmS8wbJo9/TdMfIUBkStlzt9+nNzTpJ2q0
	 cJq80XTybCh5ObS9QSoprRn8bWTgOoBFWoXix2adSmXCKG9I8O5PMhQk9mEZ2TnW0P
	 a47NUJ7moSRcwCbIBkZPGJkPwcK0pTYdmxfujl+akJVgfkb8neBpS7l+bj40RdA0TJ
	 5o+++Dm3yrt1IsJkQF5tYy0n5OE772G5GpKujS86THqPBatb+6i3ROn4d+SiJHb4iU
	 x56BmdFzPmFbQGSwr2sf/kx+qKeiobFMaKEiEBJnW1O3BhyoW/W0dWx/U5qqMwyVxz
	 ike35ueBw0Fig==
Content-Type: multipart/mixed; boundary="===============0850578918293765097=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <49f1c39a9af6f07357e66657ca1020e57684036626ef1f180a803f148f8eefe4@mail.kernel.org>
In-Reply-To: <20260814173206.93082-5-leon.hwang@linux.dev>
References: <20260814173206.93082-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Avoid flaky resize value test for percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 18:24:27 +0000 (UTC)

--===============0850578918293765097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> index 7d6bda909295..2f0dbeb88934 100644
> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c

[ ... ]

> @@ -126,11 +123,11 @@ static void test_percpu_data_on_cpus(struct bpf_map *map, int map_fd, int prog_f
>  static void test_global_percpu_data_init(void)
>  {
>  	struct test_global_percpu_data__percpu init_value = {};
> +	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE) * 2;
>  	struct test_global_percpu_data__percpu *init_data;
> -	const __u32 desired_sz = sysconf(_SC_PAGE_SIZE);

Does multiplying by 2 here break the test on 64K page systems?

Per-CPU array value sizes are capped by the kernel:

  /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
  if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
          return -E2BIG;

in kernel/bpf/arraymap.c:array_map_alloc_check(), where PCPU_MIN_UNIT_SIZE
is defined as:

  #define PCPU_MIN_UNIT_SIZE  PFN_ALIGN(32 << 10)

which equals max(32768, PAGE_SIZE).

The old code was safe by construction: desired_sz == PAGE_SIZE <=
PFN_ALIGN(32768) == PCPU_MIN_UNIT_SIZE. Doubling it breaks that:

  PAGE_SIZE  4096 -> limit 32768, request   8192  OK
  PAGE_SIZE 16384 -> limit 32768, request  32768  OK (exactly at limit)
  PAGE_SIZE 65536 -> limit 65536, request 131072  -E2BIG

On kernels built with 64K pages (arm64 CONFIG_ARM64_64K_PAGES, ppc64)
bpf_map__set_value_size() still succeeds (it is purely userspace
bookkeeping), all four assertions that follow it pass, and then map
creation fails inside test_global_percpu_data__load():

>  	err = test_global_percpu_data__load(skel);
>  	if (!ASSERT_OK(err, "test_global_percpu_data__load"))
>  		goto out;

The "global_percpu_data/init" subtest fails, and test_percpu_data_on_cpus()
is never reached. That is a new failure introduced by this patch (with
desired_sz == PAGE_SIZE the same configuration created a 65536-byte per-CPU
value, which is exactly at the limit and accepted).

Note that the neighbouring resize test in global_map_resize.c deliberately
does not scale a per-CPU map by page size for this reason. At line 46 it
uses:

  new_sz = sizeof(skel->data_percpu_arr->percpu_arr[0]) *
           libbpf_num_possible_cpus();

A size that is independent of PAGE_SIZE would still force the mmap region
to move, which is what the new skel->percpu_arr reassignment and the
arr[0] == -1 check are there to exercise, without hitting the per-CPU
allocator bound.

>  	struct test_global_percpu_data *skel = NULL;
> +	struct bpf_map *map, *map_percpu_arr;
>  	size_t init_data_sz;
> -	struct bpf_map *map;
>  	int prog_fd, err;

[ ... ]

> @@ -177,33 +176,37 @@ static void test_global_percpu_data_init(void)
>
>  	ASSERT_EQ(init_data->data, init_value.data, "init_value data");
>  	ASSERT_EQ(init_data->set, init_value.set, "init_value set");
> +	ASSERT_EQ(init_data->nums[6], init_value.nums[6], "init_value nums[6]");

[ ... ]

> -	ASSERT_GT(desired_sz, sizeof(init_value), "desired_sz");
> -	err = bpf_map__set_value_size(map, desired_sz);
> +	skel->percpu_arr->arr[0] = -1;
> +	map_percpu_arr = skel->maps.percpu_arr;
> +	err = bpf_map__set_value_size(map_percpu_arr, desired_sz);
>  	if (!ASSERT_OK(err, "bpf_map__set_value_size"))
>  		goto out;

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> index 71ff8d1bf49e..12556590b647 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_percpu_data.c
> @@ -8,9 +8,11 @@ int loong SEC(".percpu.looooooooong");
>  int data3 SEC(".data.percpu");
>  int data2 SEC(".percpu.data");
>
> +/* Used for testing bpf_map__set_value_size(). */
> +int arr[1] SEC(".percpu.arr");
> +
>  int run;
> -/* cpu_id as array to verify map value resizing. */
> -int cpu_id[1] SEC(".percpu");
> +int cpu_id SEC(".percpu");
>  int data SEC(".percpu") = -1;
>  int nums[7] SEC(".percpu");
>  bool set SEC(".percpu") = false;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31826359148
--===============0850578918293765097==--
