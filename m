Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121F935975
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791169965; cv=none; b=gsxIV2qjIunT/3xaR+s0rmwfAKkzZoIlzStz0vU87VIfmWJ/YpBhjM/JMgjbsTywLbBJjdD76+G4nuhT7gvf0o9a5bzFMrQA15b4NaHzY10gvzcmglDyJp3we4QQVHYet0j1WK+6cj55GPM4ZLli1CzY1gcZht7lbSU/FUhKOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791169965; c=relaxed/simple;
	bh=anucf5dMHHyoPYKyKW7qj0tEAgBZK6zfgcizdrV5O9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hkw7QLdTFpUkQZ5iOo3TTsejjBhz5M2PX28oQF8VLJvDkQKjrscqHGt9bjcBa3xTuWl73iCr9tDCPg3ms0nB8vkXfTAg4j3tlY7LhgxEoCuzGIn3W9xDFJP/lBPQaJlKRlsfsBH05VuwYM7D7/GPCB7G0ZXCYRg+92Jz0R/O/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qQMK37YK; arc=none smtp.client-ip=95.215.58.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qQMK37YK"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=anucf5dMHHyoPYKyKW7qj0tEAgBZK6zfgcizdrV5O9c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791169961; v=1; x=1791774761;
 b=qQMK37YKTP5tXCqAOShD7L+a7sUt0NPziFskjtgNSdgaSvUxD0wgTBqYFPy6TyyLtkRQStkS
 PjEKDo0PoU8LGH6q9hq+XptjcjevWi+dVo7T6Fan3xFfnN/nQs3admkKBHMOBZhCsi8W/vkBS0U
 WXf9EQdNYe1zsgLZP+rOLecs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3d9ce56d56f170bc;
	Mon, 05 Oct 2026 03:12:41 +0000
X-Mizu-Trace-ID: 3d9ce56d56f170bc
X-Migadu-Flow: FLOW_OUT
Message-ID: <935fb19c-e8e2-46a3-b933-9d8e9d1cf746@linux.dev>
Date: Mon, 5 Oct 2026 11:12:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261004111007.3216186-1-maghasi@disroot.org>
 <20261004111007.3216186-4-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261004111007.3216186-4-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/26 19:10, Masoud Aghasi wrote:
> All possible combinations of (BPF_EXIST, BPF_NOEXIST) and
> (BPF_F_ALL_CPUS, BPF_F_CPU) flags are covered for all percpu map types.
> 
> As BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE does not support BPF_NOEXIST and
> also in order to reduce the amount of code duplicates, I added its
> new test scenarios to the existing cpu_flag_percpu_cgroup_storage test.
> 
> But for other percpu map types, I added new tests to be able to
> exercise all flag combinations and the edge cases such as percpu LRU
> unnecessary deletion issue.
> 
> Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
> ---
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 200 ++++++++++++++++++
>  1 file changed, 200 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 7b4a1e24363b..1f33ea20d845 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -449,6 +449,48 @@ static void test_lru_percpu_hash_cpu_flag_create(void)
>  	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
>  }
>  
> +static void test_percpu_cgroup_storage_flags_combination(struct bpf_map *map, int nr_cpus,
> +							  struct bpf_cgroup_storage_key *key)
> +{
> +	int err;
> +	u64 flags = 0;
> +	size_t value_sz = sizeof(u32);
> +	size_t elem_sz = roundup(value_sz, 8);
> +	u32 *values = NULL;

Pls keep these lines in inverted Christmas tree style.

> +
> +	values = calloc(nr_cpus, elem_sz);
> +	if (!ASSERT_OK_PTR(values, "calloc values"))
> +		return;
> +
> +	flags = BPF_NOEXIST | BPF_EXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, elem_sz * nr_cpus, flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem noexist|exist"))
> +		goto out;
> +
> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem all_cpus|noexist"))
> +		goto out;
> +
> +	flags = BPF_F_CPU | BPF_NOEXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem cpu|noexist"))
> +		goto out;
> +
> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
> +	if (!ASSERT_OK(err, "bpf_map__update_elem all_cpus|exist"))
> +		goto out;
> +
> +	flags = BPF_F_CPU | BPF_EXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
> +	if (!ASSERT_OK(err, "bpf_map__update_elem cpu|exist"))
> +		goto out;

This 'goto out' is unnecessary.

For these two bpf_map__update_elem() calls, better to set values before
updating, then to verify the values after updating.

> +
> +out:
> +	free(values);
> +}
> +
>  static void test_percpu_cgroup_storage_cpu_flag(void)
>  {
>  	struct percpu_alloc_array *skel = NULL;
> @@ -489,6 +531,7 @@ static void test_percpu_cgroup_storage_cpu_flag(void)
>  		goto out;
>  
>  	test_percpu_map_op_cpu_flag(map, &key, sizeof(key), 1, nr_cpus, false);
> +	test_percpu_cgroup_storage_flags_combination(map, nr_cpus, &key);
>  out:
>  	bpf_prog_detach2(-1, cgroup, BPF_CGROUP_INET_EGRESS);
>  	close(cgroup);
> @@ -537,6 +580,157 @@ static void test_hash_cpu_flag(void)
>  	test_map_op_cpu_flag(BPF_MAP_TYPE_HASH);
>  }
>  
> +static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
> +{
> +	size_t value_sz = 8;
> +	void *values = NULL;
> +	u32 max_entries = 3, key = 0;
> +	u64 flags = 0;
> +	int err, map_fd, nr_cpus;
> +	bool is_hash_map = (map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> +			    map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH);

Ditto the style.

We can pass 'bool is_hash_map' via parameter.

> +
> +	nr_cpus = libbpf_num_possible_cpus();
> +	if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +		return;
> +
> +	values = calloc(nr_cpus, value_sz);
> +	if (!ASSERT_OK_PTR(values, "calloc values"))
> +		return;
> +
> +	map_fd = bpf_map_create(map_type, "test_flags_combination_map",
> +				sizeof(u32), value_sz, max_entries, NULL);
> +	if (!ASSERT_GE(map_fd, 0, "bpf_map_create")) {
> +		free(values);
> +		return;
> +	}
> +
> +	flags = BPF_NOEXIST | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map_update_elem noexist|exist"))
> +		goto out;
> +
> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
> +	key = 0;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (is_hash_map) {
> +		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|noexist"))
> +			goto out;
> +
> +		err = bpf_map_update_elem(map_fd, &key, values, flags);
> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
> +			goto out;
> +	} else {
> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem all_cpus|noexist"))
> +			goto out;
> +	}

The 'if (!ASSERT_EQ(err, ...))' can be moved after 'if (is_hash_map)'.

if (is_hash_map) {
	if (!ASSERT_EQ(err, ...))
		goto out;

	err = bpf_map_update_elem(...);
}
if (!ASSERT_EQ(err, ...))
	goto out;

> +
> +	flags = BPF_F_CPU | BPF_NOEXIST;
> +	key = 1;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (is_hash_map) {
> +		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|noexist"))
> +			goto out;
> +
> +		err = bpf_map_update_elem(map_fd, &key, values, flags);
> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem cpu|noexist"))
> +			goto out;
> +	} else {
> +		if (!ASSERT_EQ(err, -EEXIST, "bpf_map_update_elem cpu|noexist"))
> +			goto out;
> +	}
> +
> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
> +	key = 2;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (is_hash_map) {
> +		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem all_cpus|exist"))
> +			goto out;
> +	} else {
> +		if (!ASSERT_OK(err, "bpf_map_update_elem all_cpus|exist"))
> +			goto out;
> +	}
> +
> +	flags = BPF_F_CPU | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (is_hash_map) {
> +		if (!ASSERT_EQ(err, -ENOENT, "bpf_map_update_elem cpu|exist"))
> +			goto out;
> +	} else {
> +		if (!ASSERT_OK(err, "bpf_map_update_elem cpu|exist"))
> +			goto out;
> +	}
> +
> +	if (map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
> +		goto out;
> +
> +	/* Percpu LRU hash map should not delete old entries unnecessarily */
> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
> +	key = 2;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))
> +		goto out;
> +
> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))
> +		goto out;
> +
> +	key = 0;
> +	err = bpf_map_lookup_elem(map_fd, &key, values);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem unnecessary_deletion"))
> +		goto out;

This 'goto' is unnecessary.

> +
> +out:
> +	close(map_fd);
> +	free(values);
> +}

After reading test_percpu_map_flags_combination(), two helpers are
needed to verify the updated values. One for updating with BPF_F_CPU,
another one for updating with BPF_F_ALL_CPUS.

Thanks,
Leon

> [...]
