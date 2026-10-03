Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1C491588
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791045704; cv=none; b=rM9OUztb5zBG2IKlV20emA0dHXwnBSkgNABkZgEEQOLL//eDz/B1LLzQFu5smTJ9CAW7lFqLbCVqje4TG7TH8EcqQu25MCiCh4vLcAeT9TnsqbGpHBbcSP2cyAtA0x/5mua9egmeAej77e+DW+kCVzs/koIX40bvkwm9obIY2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791045704; c=relaxed/simple;
	bh=hF6oPNi3qOR5Mw2TB/XEPfxGw0fgB23xkLmc0VnBIeQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DNz/zROOQd2JUDHVR+HpJEyQKeD6mDq3gsgwvgaLEUWzjxjYi5o6KLuo9dtO/7HId02DBBubiAmUxmFUj+HKuES0q9febdcdRfU4TgejiBkCu/x69SuaU5+16cP4bPqbWzWMA0VazzymXLQxVyC65+GoBhhDQuVj2740pvseP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGqYsWKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGqYsWKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D851F0089C;
	Sat,  3 Oct 2026 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791045702;
	bh=8pEr98H+7lwmMuVXDGk5vxj+FYCfkh6cfCdCKWFi0U0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SGqYsWKjSIotM2U2Emfk0UI8MY86SvtyKZNCuZj+RN1pycbZK9mcfwQYzZR0LvZPh
	 85Bn49+XLVftKL67dKuEOWVvX1uUzIeA9LikPMLstbfatB7MUZ9rwNngTeZdxA1axC
	 c67KT/uQoDdIQ/jR+IImIAWVe4hRu2gQxZYAzi0c5/+leWXgaHoqM1593KLTe3xrrC
	 LDbdlh0iPZfpg6joBmHJDyyYJnWcgt62z7ruGrmgbNKqAqQFZPtdaRF51LOxxNvFl5
	 n5vwUhsOHvpv84EYFH0/RivnHgOOhXpaVEWfD6zZjg1/kUsQpypQ8GLU48ThB0CgMk
	 O+B1jhd9NfHKg==
Content-Type: multipart/mixed; boundary="===============1161886692342266545=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <359820a180e21176e79085577fd416f2b0daa37fcd43a527f779a2fed42233e4@mail.kernel.org>
In-Reply-To: <20261003160213.2641506-4-maghasi@disroot.org>
References: <20261003160213.2641506-4-maghasi@disroot.org>
Subject: Re: [PATCH bpf v3 3/3] selftests/bpf: add tests for percpu map flags combination
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,leon.hwang@linux.dev,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  3 Oct 2026 16:41:40 +0000 (UTC)

--===============1161886692342266545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: add tests for percpu map flags combination

TL;DR:
- Cgroup storage NOEXIST|EXIST test likely never reaches the kernel: libbpf
  rejects the undersized value buffer, so it passes trivially
- LRU percpu hash test may fail spuriously if the thread migrates CPUs; pin it
  to one CPU

> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 7b4a1e24363b..f50f51c91164 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c

[ ... ]

> @@ -449,6 +449,37 @@ static void test_lru_percpu_hash_cpu_flag_create(void)

[ ... ]

> +static void test_percpu_cgroup_storage_flags_combination(struct bpf_map *map, int nr_cpus,
> +							  struct bpf_cgroup_storage_key *key)
> +{
> +	int err;
> +	u64 flags = 0;
> +	size_t value_sz = sizeof(u32);
> +	u32 *values = NULL;
> +
> +	values = calloc(nr_cpus, value_sz);
> +	if (!ASSERT_OK_PTR(values, "calloc values"))
> +		return;
> +
> +	flags = BPF_NOEXIST | BPF_EXIST;
> +	err = bpf_map__update_elem(map, key, sizeof(*key), values, value_sz, flags);
> +	if (!ASSERT_EQ(err, -EINVAL, "bpf_map__update_elem noexist|exist"))
> +		goto out;

Does this BPF_NOEXIST | BPF_EXIST check ever reach the kernel?

bpf_map__update_elem() calls validate_map_op() first, and for a per-CPU map
without BPF_F_CPU or BPF_F_ALL_CPUS that function requires:

    if (value_sz != num_cpu * elem_sz) {
        pr_warn("... unexpected value size ...");
        return -EINVAL;
    }

Here value_sz is sizeof(u32) and elem_sz is roundup(value_size, 8) = 8, so
4 != 8 * nr_cpus always holds.  libbpf returns -EINVAL and the bpf() syscall
is never made, so ASSERT_EQ(err, -EINVAL, ...) passes regardless of what
bpf_percpu_cgroup_storage_update() does with BPF_NOEXIST | BPF_EXIST.

Would a value of roundup(value_size, 8) * nr_cpus bytes be needed here,
either passed as value_sz to bpf_map__update_elem() or used with
bpf_map_update_elem() on bpf_map__fd(map)?  The current
calloc(nr_cpus, sizeof(u32)) buffer is only half that size.

The commit message says all flag combinations are covered for all percpu map
types.  For cgroup storage, the NOEXIST | EXIST case ends up being checked
only by libbpf, and NOEXIST combined with BPF_F_CPU or BPF_F_ALL_CPUS is not
tested.

[ ... ]

> @@ -537,6 +569,127 @@ static void test_hash_cpu_flag(void)

[ ... ]

> +static void test_percpu_map_flags_combination(enum bpf_map_type map_type)
> +{
> +	size_t value_sz = 8;
> +	void *values = NULL;
> +	u32 max_entries = 3, key = 0;

[ ... ]

> +	map_fd = bpf_map_create(map_type, "test_flags_combination_map",
> +				sizeof(u32), value_sz, max_entries, NULL);
> +	if (!ASSERT_GE(map_fd, 0, "bpf_map_create")) {
> +		free(values);
> +		return;
> +	}

[ ... ]

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

Can this LRU check fail on a correct kernel if the test thread migrates to
another CPU partway through?

The map is created with max_entries = 3 and no BPF_F_NO_COMMON_LRU, so it
uses the common LRU with per-CPU local free lists.
bpf_common_lru_populate() sets lru->target_free to
clamp((3 / num_possible_cpus()) / 2, 1, LOCAL_FREE_TARGET) = 1, and the test
needs all three nodes (keys 0, 1 and 2), so there is no spare node.

A node popped by a BPF_NOEXIST update that fails with -EEXIST is returned to
the free list of the CPU that popped it (bpf_common_lru_push_free() uses
node->cpu).  If a later update runs on a different CPU,
bpf_lru_list_pop_free_to_local() finds the global free list empty and calls
__bpf_lru_list_shrink(), which evicts the oldest unreferenced entry through
htab_lru_map_delete_node() instead of using the node left on the other CPU.

With the percpu hash flags fix applied (326efbe72929), one possible
sequence is:

  ALL_CPUS | NOEXIST on key 0, on CPU A:
    A pulls node X1 from the global free list; key 0 = X1

  second ALL_CPUS | NOEXIST on key 0, on CPU A:
    X1 is flushed to inactive and A pulls X2; the update returns -EEXIST
    and X2 goes back to A's local free list

  the thread migrates to CPU B

  CPU | NOEXIST on key 1, on CPU B:
    B pulls X3, which empties the global free list; key 1 = X3

  second CPU | NOEXIST on key 1, on CPU B:
    B's local free list and the global free list are both empty, so
    __bpf_lru_list_shrink_inactive() evicts the inactive tail X1 (key 0);
    the update correctly returns -EEXIST

  key 2 is inserted and the following BPF_EXIST update pops no node

The final bpf_map_lookup_elem() for key 0 then returns -ENOENT, and
ASSERT_OK(err, "bpf_map_lookup_elem unnecessary_deletion") fails.  Other
placements, for example the key 2 insert back on CPU A, also evict key 0.

test_progs calls reset_affinity() before every subtest, so this subtest runs
unpinned, and on a multi-CPU runner the result depends on scheduler
placement.  A failure here would look like the unnecessary deletion kernel
bug the test is meant to catch.

Existing LRU selftests pin the thread to one CPU (sched_next_online() in
test_lru_map.c, pthread_setaffinity_np() in prog_tests/htab_update.c).
Should this subtest pin itself to a single CPU as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37135877031
--===============1161886692342266545==--
