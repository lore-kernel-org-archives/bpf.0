Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636D4071CA;
	Sat,  6 Jun 2026 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716317; cv=none; b=l3w24jsXFpfKI1iGZlrex1KVRuovEhnxcFxKpW3mAQtnyAKPJ5/cn5Z3alCjPG4AhWo8R1625QUDxSwVuHN0o3kpOgfXMYeFs3JTy/ZgFPhF0sh24AT4GHJfFTGR3Wnu8Vg2+/eCpgWMtUaAWlZ3DfzM2B+vzzaWH9BJHGqmhD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716317; c=relaxed/simple;
	bh=REwosWePZitxsxbuN8WB58U1mHRggIZ3WTSyt3gWUe0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lYh7HBntqz9utTRUXHxoF8VeFP2aNQSKwURmNONquFf9w8Nml5pIodBR4Q64NVXVnwfePaEM4DELCiwLpHNeNWmhuWMQk2PsqfYOA8yy6TTDpU6ZGEsdMKSRox8SXmQzqnJ6QT31OGH5cjv8hZGjDwkRT2rW2qRvwroy0n35Jio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpTWan06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpTWan06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B021F00893;
	Sat,  6 Jun 2026 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780716316;
	bh=bpxecmUe5DqvCSXqCdOYJuPDw0K3bF/wr+qpjw5WibE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=NpTWan06Q3Lkv+vVD9eaiTpIJddTFIfnOsBi2DwYaJcCSqf3sUgUTkYAi6m6u07Wl
	 DIXoj7VYJGriyVaKM7MQmX2WHkx+qW22QREMLQa9WfdSzLZltas2vc1dmdbhpagzT2
	 CrX0FoMovlq346Dgt7pk2Y/XsCYCo0MgTIar172RRo9x5SrCksE7XwzoglH7uZ/ZED
	 /9Y4EDF5xlVL6HR5t54zXMbPBLV1KPrRx8KyVZXM7CKizWjpf69+qnJKlAM7U0UdPN
	 j+OU6WBzLKDf2PrGPFZJiETwpO8wyQHw5BZ8/AHAMv11disRkxUW9ofhCFaWRhUStX
	 lVfy18zno18XQ==
Content-Type: multipart/mixed; boundary="===============2097590671051744798=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14403a09e016ddd66fef54399fddaa5a57654e1430033e96f3e634f45c69ae7c@mail.kernel.org>
In-Reply-To: <20260606022827.3553277-1-luogengkun2@huawei.com>
References: <20260606022827.3553277-1-luogengkun2@huawei.com>
Subject: Re: [PATCH] bpf: defer freeing htab internal structs to workqueue to fix sleep-in-atomic
From: bot+bpf-ci@kernel.org
To: luogengkun2@huawei.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat,  6 Jun 2026 03:25:15 +0000 (UTC)

--===============2097590671051744798==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 4a978d38236129198e483dfd5c4754ffbca03ddd
> Author: Luo Gengkun <luogengkun2@huawei.com>
> Date:   Sat Jun 6 02:28:27 2026 +0000
>
>     bpf: defer freeing htab internal structs to workqueue to fix sleep-in-atomic
>
>     This fix resolves a conflict between two patches:
>     1. commit 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
>     2. commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
>     htab with internal structs")
>
>     The problem is that commit 4f375ade6aa9 breaks commit 1da6c4d9140c 's UAF
>     fix, because we need the RCU grace period to keep symlink lookups safe. But
>     keeping the RCU delay means `htab_map_free_internal_structs` runs inside
>     RCU_SOFTIRQ, where calling `cond_resched()` and triggers the "sleeping
>     function called from invalid context" BUG.
>
>     To solve both issues, we keep the VFS RCU protection intact (by reverting
>     commit 4f375ade6aa9), and defer the actual freeing to workqueue to avoid
>     sleep-in-atomic.
>
>     Fixes: 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
>     Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
>     Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>

The first Fixes tag points to commit 1da6c4d9140c, but this commit did
not introduce the bug being fixed. Commit 1da6c4d9140c was a UAF fix that
the current patch is trying to preserve, not fix. The sleep-in-atomic bug
was introduced by commit 4f375ade6aa9, which is correctly listed as the
second Fixes tag.

Should the first Fixes tag be removed, leaving only:
  Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index 3dd9b4924ae4..6d6f1faeec67 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -102,6 +102,7 @@ struct bpf_htab {
>  	u32 n_buckets;	/* number of hash buckets */
>  	u32 elem_size;	/* size of each element in bytes */
>  	u32 hashrnd;
> +	struct work_struct work;
>  };
>
>  /* each htab element is struct htab_elem + key + value */
> @@ -539,6 +540,8 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btb,
>  		return htab_set_dtor(htab, htab_mem_dtor);
>  }
>
> +static void htab_map_free_internal_structs_deferred(struct work_struct *work);
> +
>  static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  {
>  	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> @@ -557,6 +560,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>  	if (!htab)
>  		return ERR_PTR(-ENOMEM);
>
> +	INIT_WORK(&htab->work, htab_map_free_internal_structs_deferred);
>  	bpf_map_init_from_attr(&htab->map, attr);
>
>  	if (percpu_lru) {

[ ... ]

> @@ -1606,18 +1610,27 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>  	rcu_read_unlock();
>  }

Is it safe to use hlist_nulls_for_each_entry() inside the RCU read lock?

While the map's usercnt is zero, attached BPF programs can still execute
in parallel and modify the map. Since hlist_nulls_for_each_entry() does
not use rcu_dereference(), couldn't concurrent modifications cause torn
pointers and lead to data races or infinite loops?

Should htab_free_malloced_internal_structs() use
hlist_nulls_for_each_entry_rcu() instead?

>
> -static void htab_map_free_internal_structs(struct bpf_map *map)
> +static void htab_map_free_internal_structs_deferred(struct work_struct *work)
>  {
> +	struct bpf_map *map = container_of(work, struct bpf_map, work);
>  	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);

Is the container_of macro calculating the correct map pointer here?

The work item was initialized using &htab->work:

    htab_map_alloc() {
        INIT_WORK(&htab->work, htab_map_free_internal_structs_deferred);
    }

but here it is cast via container_of(work, struct bpf_map, work).

Since 'work' is a member of struct bpf_htab (line 105) and not struct
bpf_map, doesn't this shift the map pointer into the middle of the struct
instead of its start?

The work pointer delivered to the callback is &htab->work (offset =
offsetof(struct bpf_htab, work), which is far past sizeof(struct bpf_map)).

But the callback recovers the map using the DIFFERENT 'work' field that
lives inside struct bpf_map (include/linux/bpf.h, in the union with
rcu_head), at offset offsetof(struct bpf_map, work).

Since &htab->work is NOT &htab->map.work, container_of(work, struct
bpf_map, work) computes:

    map = (char *)&htab->work - offsetof(struct bpf_map, work)

which points well past &htab->map (offset 0), into the middle of the htab
object rather than at the real struct bpf_map.

Could this lead to memory corruption when bpf_map_put(map) is subsequently
called with the invalid pointer?

Should this be calculated as:

    htab = container_of(work, struct bpf_htab, work);
    map = &htab->map;

>
> -	/* We only free internal structs on uref dropping to zero */
> -	if (!bpf_map_has_internal_structs(map))
> -		return;
> -
>  	if (htab_is_prealloc(htab))
>  		htab_free_prealloced_internal_structs(htab);
>  	else
>  		htab_free_malloced_internal_structs(htab);
> +	bpf_map_put(map);
> +}
> +
> +static void htab_map_free_internal_structs(struct bpf_map *map)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	/* We only free internal structs on uref dropping to zero */
> +	if (!bpf_map_has_internal_structs(map))
> +		return;
> +
> +	bpf_map_inc(map);
> +	schedule_work(&htab->work);
>  }

What happens if schedule_work() returns false?

A userspace program could repeatedly fetch the map via BPF_MAP_GET_FD_BY_ID
and close the file descriptor. Each closure drops usercnt to 0, triggering
this function.

Since bpf_map_inc() is called unconditionally, but schedule_work() returns
false if the work is already pending, won't this result in unbalanced
reference counts and permanently leak the BPF map?

Does deferring this operation to a workqueue introduce a race condition?

When usercnt reaches zero, we queue the internal structs (like timers and
kptrs) for deletion. Because map->refcnt can still be positive, can't
userspace immediately resurrect the map via BPF_MAP_GET_FD_BY_ID, bumping
usercnt back above zero?

If new timers or kptrs are then inserted, won't the deferred work
eventually run and indiscriminately destroy the internal structs of a
now-active map?

>
>  /* Called when map->refcnt goes to zero, either from workqueue or from syscall */

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27050223198
--===============2097590671051744798==--
