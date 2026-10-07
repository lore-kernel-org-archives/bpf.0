Received: from mta1.migadu.com (out-163.mta1.migadu.com [95.215.58.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB23F164C
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355344; cv=none; b=TScTo9T8LkZmMUSFlc4gkrlj5vBjRPufu8Zxa3RBw67VlmKp8LYWrtj81UGPGbxo9BFu6GPMdqyUJ5Hmmr6X4jLT5ujCDRh1xFPSyQiHovioaGOoNxOigxo9FZXgdMGdi4jcPydd1VYYalPpLe8udlhZlXe+k8bgbiGrUOlNKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355344; c=relaxed/simple;
	bh=FNOwhxhy21rGd8xm1mrvZjK3geKp4eF+wz8DpJrLzwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnHR719A2IEhsUetcd/qRIj2EwhABW7PrbifegHnA1AZp4nc0BI0RRbSOgAzPEBk0uV14npG0MIdmZPoGK/itPkIOjBXhODdhVEquO9CLYV91+K0fNrxGGW7RKI+LQDSnobsJ/djt3WqF2e3BZeKNhBfs7QNDHjLmGvrhTjbaz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UkzDH+KI; arc=none smtp.client-ip=95.215.58.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UkzDH+KI"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FNOwhxhy21rGd8xm1mrvZjK3geKp4eF+wz8DpJrLzwY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791355339; v=1; x=1791960139;
 b=UkzDH+KID33rRICLsSBIVVWvIKXJ01POTOXJsspl5Y3Lw5dWMwK5MgxuofvHoO5+Z/h/o/s9
 vXJuph6eZma0CNPR3F6tzLrQT1+JK/nF8ltOVUmZso3SZUVZLoSUoHiUh4qpsmF4RuNLLkRUnO+
 wzsgLLSriSZDIDmyF8yJrYoc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7b09d3159e205a4;
	Wed, 07 Oct 2026 02:44:08 +0000
X-Mizu-Trace-ID: e7b09d3159e205a4
X-Migadu-Flow: FLOW_OUT
Message-ID: <5eb6e22c-7466-438a-a827-d62aa4f46cc2@linux.dev>
Date: Wed, 7 Oct 2026 10:44:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 3/3] selftests/bpf: add tests for percpu map flags
 combination
To: Masoud Aghasi <maghasi@disroot.org>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev
References: <20261006084604.780456-1-maghasi@disroot.org>
 <20261006084604.780456-4-maghasi@disroot.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20261006084604.780456-4-maghasi@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 16:46, Masoud Aghasi wrote:
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
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 249 ++++++++++++++++++
>  1 file changed, 249 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 7b4a1e24363b..22d5e7330254 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -449,6 +449,90 @@ static void test_lru_percpu_hash_cpu_flag_create(void)
>  	test_percpu_map_cpu_flag_create(BPF_MAP_TYPE_LRU_PERCPU_HASH, 0);
>  }
>  
> +static bool verify_u32_map_value_all_cpus(int map_fd, void *key, u32 *values,
> +					  u32 expected_value, int nr_cpus)

NIT: 'u32' seems unnecessary in the function name.

> +{
> +	int i, err;
> +
> +	err = bpf_map_lookup_elem(map_fd, key, values);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem all_cpus"))
> +		return false;
> +
> +	for (i = 0 ; i < nr_cpus ; i++) {
> +		if (!ASSERT_EQ(values[i * 2], expected_value, "bpf_map_lookup_elem value all_cpus"))

'i * 2' looks hard to understand.

Should pass 'void *values, size_t elem_sz', then get value by '*(u32
*)(value + elem_sz * i)'

> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool verify_u32_map_value_first_cpu(int map_fd, void *key, u32 *values,
> +					   u32 expected_value, int nr_cpus)

Ditto.

> +{
> +	int i, err;
> +
> +	err = bpf_map_lookup_elem(map_fd, key, values);
> +	if (!ASSERT_OK(err, "bpf_map_lookup_elem cpu"))
> +		return false;

Can ASSERT_EQ() the first slot here instead of the last? Just for
readability.

> +
> +	for (i = 1 ; i < nr_cpus ; i++) {
> +		if (!ASSERT_NEQ(values[i * 2], expected_value, "bpf_map_lookup_elem value cpu"))

Ditto.

> +			return false;
> +	}
> +
> +	return ASSERT_EQ(values[0], expected_value, "bpf_map_lookup_elem value cpu");
> +}
> +

[...]

> +
> +	if (map_type != BPF_MAP_TYPE_LRU_PERCPU_HASH)
> +		goto out;
> +
> +	/* Percpu LRU hash map should not delete old entries unnecessarily */
> +	flags = BPF_F_ALL_CPUS | BPF_NOEXIST;
> +	key = 2;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))

NIT: unnecessary_deletion  ->  lru_percpu_hash all_cpus|noexist

> +		goto out;
> +
> +	flags = BPF_F_ALL_CPUS | BPF_EXIST;
> +	err = bpf_map_update_elem(map_fd, &key, values, flags);
> +	if (!ASSERT_OK(err, "bpf_map_update_elem unnecessary_deletion"))

NIT: unnecessary_deletion  ->  lru_percpu_hash all_cpus|exist

Thanks,
Leon

> +		goto out;
> [...]


