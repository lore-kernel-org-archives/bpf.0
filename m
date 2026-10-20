Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480395;
	b=lIfbxHUc24EeF/gEmFMWwncvGv9igMX44ok8cxTfsTbi4DeyjfKxOyubZYzTMVoUssVV
	 mqQ+/fTZKavvunEcgjsMlEcfZbTgFn61GpP0N8qpdLM7mk4jcwT4ZAKPpM5oQpeVSCr5A
	 cWpaQbeWjW0/gnl1fo5ByjlnMOXCE2aQhb8XsVwTFcJpfXcER3DJMo3vcaIpqIHhUfVbU
	 ZyjvHLOv2+w4T1ybxcfbEcKdb3NuRwNwOLeW45qk1Li1KlXqAIhdp/iMgMK9YE+rm/hS7
	 LoRBvyMepW8y6h7yPykJHJ1yQUmci7+I6bYTaS+FPcFGkaUFq/LiWy08ExfNxolxFRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480395;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wd6KFeSMn8LrlLVLM0frHHtnQQM2/rOQcFaVZTGLUB0=;
	b=y573lmAa+3su55CDIKwhIvsiSCJcixyqiEkYzEQuznaLMtQ9Q9eIsk4Vr1dSsbnER0CF
	 fiDPFDzNNiNd1rSDdXmaP/a/PIWnZ3tNWJrH85Hp8+IUZh5QHAJZsrw3n6RqoRc2EVCKw
	 wj6F4ITB6tlxm7Rql/HwVMHhkxC9UCM9RcfKxv9oeie5rCEZ4Q7tohzUwMLSyjh1y1ZS7
	 aq1uC0pPtRcqXoZfvtMy9kD6d1uQ2TDc0paDsumSsj2cOAdxU3wdlwXEJCuX9ZtQGiqtv
	 za68w8PsubW/3gIRFJrRpIuxvDvFkQkfKP05YYGlch94ft6+d5Zh4+l52kjkx5nRMUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlXWjNmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A8606A31B;
	Tue, 20 Oct 2026 07:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlXWjNmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B0B1F000C4;
	Tue, 20 Oct 2026 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792480394;
	bh=wd6KFeSMn8LrlLVLM0frHHtnQQM2/rOQcFaVZTGLUB0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LlXWjNmNppfE6C+Lc8V9evRgShMxAi3FLMPztGxZeOvweJWk/cYQrUOybgaL/zXwp
	 bW195FzrjcPdxZhut65E1UbmOv2Z396gKGdm+pPo0gq7gZoEipTz9a5EX7cZaHBCMi
	 MH2E6g1k4nx1XAsVH+4nMVNMfBZDNro4ydxCdeDL8QDLYS9X2MU9PucLvO5JtHrAjs
	 xGyciLIvLrx8oQnhLb+nDCx0zZx51FtCfb9KAXfbJOhWpEjb/Heyto5ZhyV+pEfRhm
	 PDd6SSmoqbappo9h0lJhQ2U+l7fET1FeUsb8ZCHBiD3fTjcCX2uUDFTbDbpF32S8GK
	 jaRqgCaMW7NEg==
Content-Type: multipart/mixed; boundary="===============7625777895205599761=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f07f9053cf89280975ba16d372db721dbd51d2b7d6462b2f4161f79aebd21b0a@mail.kernel.org>
In-Reply-To: <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
References: <96a6b5dcf721e49c049662cc269d8ac8c389b6af.1792217106.git.zhilinz@nebusec.ai>
Subject: Re: [PATCH bpf v2 1/1] bpf: reject raw iteration over managed map fields
From: bot+bpf-ci@kernel.org
To: zhilinz@nebusec.ai,ameryhung@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,llvm@lists.linux.dev
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,davem@davemloft.net,edumazet@kernel.org,pabeni@redhat.com,horms@kernel.org,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,zhilinz@nebusec.ai,menglong8.dong@gmail.com,bestswngs@gmail.com,mattbobrowski@google.com,vega@nebusec.ai,sashiko-bot@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 07:13:14 +0000 (UTC)

--===============7625777895205599761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: reject raw iteration over managed map fields

TL;DR:
- Possible kernel fault: map->record may be an ERR_PTR, dereferenced when
  attaching map iterators
- Per-CPU map iterators may be wrongly rejected
- Fixes: tag may be incomplete

>     bpf: reject raw iteration over managed map fields
>     
>     BPF map iterators expose values as writable PTR_TO_BUF memory. Attach-time
>     validation bounds maximum access by value_size, but does not account for
>     BTF-managed fields in map values. Direct buffer accesses can therefore read
>     or overwrite fields such as __kptr without the verifier's ownership checks.
>     
>     For bpf_map_elem and bpf_sk_storage_map iterators, limit value access to
>     the prefix before the first managed field. Since max_rdwr_access is an
>     exclusive end offset and record fields are sorted, accesses ending at the
>     first managed field remain available while accesses reaching it are denied.
>     
>     Revalidate the replacement program against the map associated with an
>     iterator link before bpf_link_update() swaps programs. Add selftests for
>     allowed prefix access, rejected managed-field reads and writes, and link
>     updates that introduce managed-field access.
>     
>     Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
>     Cc: stable@vger.kernel.org
>     Reported-by: Vega <vega@nebusec.ai>
>     Link: https://lore.kernel.org/all/1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai/

[ ... ]

>     Suggested-by: Amery Hung <ameryhung@gmail.com>
>     Assisted-by: LLM
>     Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>

The only Fixes: tag points at 9db44fdd8105 ("bpf: Support kptrs in local
storage maps"), which only enabled kptrs in sk/inode/task/cgrp storage maps.
That tag covers the bpf_sk_storage_map iterator, but this patch also changes
the bpf_map_elem iterator in kernel/bpf/map_iter.c for hash, LRU hash and
array maps.

Is that tag complete?  The bpf_map_elem iterators (a5cbe05a6673 ("bpf:
Implement bpf iterator for map elements")) have handed out the raw hash/array
value as a writable PTR_TO_BUF, bounded only by value_size, ever since special
fields appeared in those maps.  That includes bpf_timer (b00628b1c7d5 ("bpf:
Introduce bpf timers.")) and kptrs (61df10c7799e ("bpf: Allow storing
unreferenced kptr in map"), v5.19).

At 61df10c7799e, bpf_iter_attach_map() only bounded max_rdwr_access by
value_size, and the bpf_map_elem iterator value was a writable PTR_TO_BUF, so
a program could read or overwrite a __kptr slot with raw accesses.  Percpu
hash and percpu array exposure came later (65334e64a493, 6df4ea1ff0ff), so
61df10c7799e looks like the oldest introducing commit.

With only 9db44fdd8105 listed, stable trees that have 61df10c7799e (or
timers) but not 9db44fdd8105, for example 6.1, would not be picked for the
map_iter.c part of the fix.

Should this carry an additional tag:

  Fixes: 61df10c7799e ("bpf: Allow storing unreferenced kptr in map")

and optionally keep the 9db44fdd8105 tag as a second Fixes: line for the
sk_storage iterator?

> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index c19b360bad9e..04cf255587aa 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -97,25 +97,15 @@ static struct bpf_iter_reg bpf_map_reg_info = {
> +static int bpf_iter_map_elem_check_prog(struct bpf_prog *prog,
> +					struct bpf_map *map)

[ ... ]

> @@ -135,10 +125,39 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  	else
>  		value_size = round_up(map->value_size, 8) * num_possible_cpus();
>  
> -	if (key_acc_size > key_size || value_acc_size > value_size) {
> -		err = -EACCES;
> +	if (key_acc_size > key_size || value_acc_size > value_size)
> +		return -EACCES;
> +
> +	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
> +	if (map->record && value_acc_size > map->record->fields[0].offset)
> +		return -EACCES;

Can map->record be an ERR_PTR here, so that the map->record test passes and
map->record->fields[0].offset is then loaded through an invalid pointer?

In map_check_btf() (kernel/bpf/syscall.c), the result of btf_parse_fields()
is stored without being cleared on error:

    map->record = btf_parse_fields(btf, value_type, ...);
    if (!IS_ERR_OR_NULL(map->record)) {
        ...
    }
    ret = btf_check_and_fixup_fields(btf, map->record);

btf_check_and_fixup_fields() returns 0 when IS_ERR_OR_NULL(rec), and
htab_map_check_btf(), array_map_check_btf() and
bpf_local_storage_map_check_btf() never look at the record.  The ERR_PTR
stays in map->record and map creation succeeds.

This does not look like a corner case.  btf_find_field() returns -EINVAL for
any value type that is not a struct, union or datasec:

    if (__btf_type_is_struct(t))
        return btf_find_struct_field(...);
    else if (btf_type_is_datasec(t))
        return btf_find_datasec_var(...);
    return -EINVAL;

That means every libbpf map declared with __type(value, __u64),
__type(value, int), an array value and so on has map->record ==
ERR_PTR(-EINVAL).  Allocation failures and the -E2BIG/-EEXIST parse errors
also leave an ERR_PTR behind.  Every other reader guards with
IS_ERR_OR_NULL(map->record): check_map_access(), bpf_obj_memcpy(),
btf_record_has_field(), bpf_map_mmap(), map_freeze(), array_map_free() and
bpf_ma_set_dtor().

With this patch, BPF_LINK_CREATE for a bpf_map_elem iterator on such a map
goes:

    link_create()
      bpf_iter_link_attach()
        bpf_iter_attach_map()
          bpf_iter_map_elem_check_prog()

Once the key and value size checks pass, it evaluates
map->record->fields[0].offset, which is a load from (void *)-22 +
offsetof(struct btf_record, fields), i.e. address 0xa.  BPF_LINK_UPDATE
reaches the same code through bpf_iter_link_replace() ->
bpf_iter_map_elem_validate_prog().

The existing selftests appear to hit this.  test_bpf_hash_map attaches
dump_bpf_hash_map and sleepable_dummy_dump to hashmap1 (__type(value, __u64)),
and test_bpf_array_map and test_bpf_percpu_* attach to maps with __u64/__u32
values.  Before this patch these iterators worked because map->record was
never dereferenced.

Should this be !IS_ERR_OR_NULL(map->record), matching the other map->record
readers?

Separately, does this check also apply to per-CPU maps where map->record is
valid, even though the iterator never exposes map memory directly there?

map_check_btf() allows BPF_KPTR_* fields in PERCPU_HASH, LRU_PERCPU_HASH and
PERCPU_ARRAY.  For those map types __bpf_hash_map_seq_show() and
__bpf_array_map_seq_show() fill a temporary percpu_value_buf instead:

    copy_map_value_long(map, info->percpu_value_buf + off, per_cpu_ptr(pptr, cpu));
    check_and_init_map_value(map, info->percpu_value_buf + off);

The copy skips special fields and then zeroes them, and writes never reach
the map, so reading or overwriting a __kptr through this buffer does not seem
possible.

The new bound is fields[0].offset, an offset within a single CPU's value, but
value_acc_size is compared here against a buffer of
round_up(map->value_size, 8) * num_possible_cpus() bytes.  Any access to the
slot of CPU 1 or higher, or to CPU 0 data after the first kptr, now fails with
-EACCES.

For example, take a PERCPU_HASH value of the form:

    struct { u64 cnt; struct foo __kptr *p; }

An iterator that sums cnt across CPUs attached fine before this change, and it
is now rejected.  There is no way to adjust the program to work around it.

Since this is tagged for stable, should per-CPU maps skip the managed-field
check, given their iterator buffer is already sanitized?

[ ... ]

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 1d295a8769fa..ffbcfab9a71c 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -846,12 +846,35 @@ static void bpf_iter_fini_sk_storage_map(void *priv_data)
> +static int bpf_iter_sk_storage_map_check_prog(struct bpf_prog *prog,
> +					      struct bpf_map *map)
> +{
> +	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
> +		return -EINVAL;
> +
> +	if (prog->aux->max_rdwr_access > map->value_size)
> +		return -EACCES;
> +
> +	/* Fields are sorted by offset; max_rdwr_access is an exclusive end. */
> +	if (map->record &&
> +	    prog->aux->max_rdwr_access > map->record->fields[0].offset)
> +		return -EACCES;

This looks like the same ERR_PTR dereference as in
bpf_iter_map_elem_check_prog(), and it is reached even more easily.
bpf_local_storage_map_alloc_check() requires BTF for every SK_STORAGE map:

    /* Enforce BTF for userspace sk dumping */
    !attr->btf_key_type_id || !attr->btf_value_type_id)
        return -EINVAL;

So every sk_storage map whose value type is a scalar goes through
map_check_btf() -> btf_parse_fields() -> btf_find_field() == -EINVAL and keeps
map->record == ERR_PTR(-EINVAL).  That includes sk_stg_map in
progs/bpf_iter_bpf_sk_storage_map.c and bpf_iter_bpf_sk_storage_helpers.c,
both declared with __type(value, int).

The map->record test passes for the ERR_PTR, and map->record->fields[0].offset
then faults at a near-NULL address.  This happens during BPF_LINK_CREATE
(bpf_iter_attach_map()) and BPF_LINK_UPDATE
(bpf_iter_sk_storage_map_validate_prog()) for any bpf_sk_storage_map iterator
whose max_rdwr_access fits value_size.  Before this patch that was a working
configuration.

Could this use IS_ERR_OR_NULL(map->record) as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39382306212
--===============7625777895205599761==--
