Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6267B3AB482
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436655; cv=none; b=Qt2BisjW/kzUelXdLIikzX6elmQ7B+5Ag/GvTgslfHuFfsF4SCxDF6zd98wj8s6NNR27W7nPf/aAE3dIRs7Gj+xnw2ZA9IMmSnt5p/F1F4BqhvoBqTMkPut2bRKtKSBY0D2gKdVLpb3faSd1DnAoer+m5eEJm+l3IMfxaFoWrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436655; c=relaxed/simple;
	bh=8EAzEvxJzKAKjBUQ+AzKJmhtS2g4miLRBbiBEaGNqzw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bFCov6RuGm5wbI1jGrQ+ljSExdvNJeU9dYj47tnUTyHRNmksz0kazCyxIwRS8tV8YeetaoWVRz/3aeKPe0WoEzTOlifqP6avjbTDKoWV2H7Q1RSBly+LZzb3v4UP6GRW0Tswd5+by2GxODnpsl5wkTqV6m+flK+V4AaKgdsKCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DanQXswe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DanQXswe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C34C1F00893;
	Tue,  2 Jun 2026 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780436654;
	bh=/Fl9/IE0kcc+SdtR4lr/VjNe12PvlcRWksUthtLmeUk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DanQXswei93Yh1zE4ejItrZAtEXZDd70sLbGIiTEuC8J0sY2Vxu5j1RWc9HqKaSad
	 LlPXgJzIwS22Qj0T/e+U6b9QIQFKoDIPQ6Lr5L5kYmYlD1uLnIXXM7SvnDZdO3rx4P
	 /Y8n0X5//YUsC3qWxB3D64RdaX0ld/tzyhGxgtG/WYnnlDo5vvbW+MvVXGBITqg1Hg
	 oI6ilWAeuOdJx2e3/1ZmqJReUEW47mdikFW225GAC9Nzsej0OchCqAHKxiYXJGiigj
	 P1IUov9SGV/++akihIqpJoVkwZvyjRe6lcc/VG+hIa7Y9LO39Y7/cRKihpSiS5ClI4
	 uYxrBm+J6wILQ==
Content-Type: multipart/mixed; boundary="===============3064337340957179930=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1f351c08cad802bf21152876d40fd41d71f08aecb0e21a37ec2e7be0e88364c0@mail.kernel.org>
In-Reply-To: <20260602-rhash-v6-4-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-4-1bfd35a4184f@meta.com>
Subject: Re: [PATCH bpf-next v6 04/11] bpf: Implement iteration ops for resizable hashtab
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com,eddyz87@gmail.com,memxor@gmail.com,herbert@gondor.apana.org.au
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 21:44:14 +0000 (UTC)

--===============3064337340957179930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c

[ ... ]

> @@ -3020,10 +3020,81 @@ static void rhtab_map_free_internal_structs(struct bpf_map *map)
>  static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
> +	__must_hold_shared(RCU)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	struct rhtab_elem *elem;
> +
> +	elem = rhashtable_next_key(&rhtab->ht, key, rhtab_params);
> +
> +	/* if not found, return the first key */
> +	if (PTR_ERR(elem) == -ENOENT)
> +		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
> +
> +	if (IS_ERR(elem))
> +		return PTR_ERR(elem);
> +	if (!elem)
> +		return -ENOENT;
> +
> +	memcpy(next_key, elem->data, map->key_size);
> +	return 0;
> +}
> +
> +static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
>  {
> -	return -EOPNOTSUPP;
> +	void *value;
> +
> +	/* Guarantee that hashtab value is not freed */
> +	guard(rcu)();
> +
> +	value = rhtab_map_lookup_elem(map, key);
> +	if (!value)
> +		return;
> +
> +	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
> +	seq_puts(m, ": ");
> +	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
> +	seq_putc(m, '\n');
>  }
>
> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
> +				void *callback_ctx, u64 flags)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	void *prev_key = NULL;
> +	struct rhtab_elem *elem;
> +	int num_elems = 0;
> +	u64 ret = 0;
> +
> +	cant_migrate();
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	/*
> +	 * Best-effort iteration: if rhashtable is concurrently resized or
> +	 * elements are deleted/inserted, there may be missed or duplicate
> +	 * elements visited.
> +	 */
> +	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params))) {
> +		if (IS_ERR(elem))
> +			break;

sashiko-bot@kernel.org raised a concern about this in v6:

The rhashtable_next_key documentation notes that a full iteration is not
guaranteed to terminate under adversarial or sustained rehashing. Since this
loop lacks an external bound and runs under rcu_read_lock with migration
disabled, can continuous concurrent resizes cause an infinite loop, resulting
in a soft lockup or RCU stall?

Reference: https://lore.kernel.org/bpf/20260602210416.2E0631F000893@smtp.kernel.org/

sashiko-bot@kernel.org raised a concern about this in v6:

If prev_key is deleted concurrently or by the callback itself,
rhashtable_next_key returns ERR_PTR(-ENOENT). Does breaking the loop here
cause the iteration to immediately abort and skip the rest of the map?

Reference: https://lore.kernel.org/bpf/20260602210416.2E0631F000893@smtp.kernel.org/

> +		num_elems++;
> +		ret = callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);
> +		if (ret)
> +			break;
> +
> +		prev_key = elem->data;	/* valid while RCU held */
> +	}
> +	rcu_read_unlock();
> +
> +	return num_elems;
> +}

[ ... ]

> @@ -3034,6 +3105,275 @@ static u64 rhtab_map_mem_usage(const struct bpf_map *map)
> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{
> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
> +	void __user *uvalues = u64_to_user_ptr(attr->batch.values);
> +	void __user *ukeys = u64_to_user_ptr(attr->batch.keys);
> +	void __user *ubatch = u64_to_user_ptr(attr->batch.in_batch);
> +	void *cursor = NULL, *keys = NULL, *values = NULL, *dst_key, *dst_val;
> +	struct rhtab_elem **del_elems = NULL;
> +	u32 max_count, total, key_size, value_size, i;
> +	bool has_next_cursor = false;
> +	struct rhtab_elem *elem;
> +	u64 elem_map_flags, map_flags;
> +	int ret = 0;
> +
> +	elem_map_flags = attr->batch.elem_flags;
> +	ret = bpf_map_check_op_flags(map, elem_map_flags, BPF_F_LOCK);
> +	if (ret)
> +		return ret;
> +
> +	map_flags = attr->batch.flags;
> +	if (map_flags)
> +		return -EINVAL;
> +
> +	max_count = attr->batch.count;
> +	if (!max_count)
> +		return 0;
> +
> +	if (put_user(0, &uattr->batch.count))
> +		return -EFAULT;
> +
> +	key_size = map->key_size;
> +	value_size = map->value_size;
> +
> +	keys = kvmalloc_array(max_count, key_size, GFP_USER | __GFP_NOWARN);
> +	values = kvmalloc_array(max_count, value_size, GFP_USER | __GFP_NOWARN);
> +	if (do_delete)
> +		del_elems = kvmalloc_array(max_count, sizeof(void *),
> +					   GFP_USER | __GFP_NOWARN);
> +	cursor = kmalloc(key_size, GFP_USER | __GFP_NOWARN);
> +
> +	if (!keys || !values || !cursor || (do_delete && !del_elems)) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	if (ubatch && copy_from_user(cursor, ubatch, key_size)) {
> +		ret = -EFAULT;
> +		goto free;
> +	}
> +
> +	dst_key = keys;
> +	dst_val = values;
> +	total = 0;
> +
> +	rcu_read_lock();
> +
> +	/*
> +	 * Cursor stores the key of the next-to-process element (stashed by
> +	 * the previous batch). Look it up directly so the element is included
> +	 * here rather than skipped by next_key(). If the cursor was deleted
> +	 * concurrently (or by the previous do_delete batch), return -EAGAIN
> +	 * so userspace can distinguish a lost cursor from end-of-iteration
> +	 * (-ENOENT) and restart from a NULL cursor.
> +	 */
> +	if (ubatch) {
> +		elem = rhtab_lookup_elem(map, cursor);
> +		if (!elem) {
> +			rcu_read_unlock();
> +			ret = -EAGAIN;
> +			goto free;
> +		}
> +	} else {
> +		elem = rhashtable_next_key(&rhtab->ht, NULL, rhtab_params);
> +	}
> +
> +	while (elem && !IS_ERR(elem) && total < max_count) {

sashiko-bot@kernel.org raised a concern about this in v6:

Similar to the callback iteration, if a concurrent deletion occurs and elem
receives -ENOENT, this loop breaks. If total is greater than 0 when this
happens, doesn't this falsely signal to userspace that the map is fully
iterated, leading to missed elements?

Reference: https://lore.kernel.org/bpf/20260602210416.2E0631F000893@smtp.kernel.org/

> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);
> +
> +		if (do_delete)
> +			del_elems[total] = elem;
> +
> +		elem = rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
> +		dst_key += key_size;
> +		dst_val += value_size;
> +		total++;
> +
> +		/* Bail to userspace to avoid stalls. */
> +		if (need_resched())
> +			break;
> +	}
> +
> +	if (elem && !IS_ERR(elem)) {
> +		/* Stash next-to-process key as cursor for the next batch. */
> +		memcpy(cursor, elem->data, key_size);
> +		has_next_cursor = true;
> +	}
> +
> +	if (do_delete) {
> +		for (i = 0; i < total; i++)
> +			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +	}
> +
> +	rcu_read_unlock();
> +
> +	if (total == 0) {
> +		ret = -ENOENT;
> +		goto free;
> +	}
> +
> +	/* No more elements after this batch. */
> +	if (!has_next_cursor)
> +		ret = -ENOENT;
> +
> +	if (copy_to_user(ukeys, keys, total * key_size) ||
> +	    copy_to_user(uvalues, values, total * value_size) ||

sashiko-bot@kernel.org raised a concern about this in v6:

Both total and value_size are u32 variables. If a large batch size is used
(for example, 1,048,576 elements multiplied by 4096 bytes), does the 32-bit
multiplication overflow before being cast to unsigned long for copy_to_user?
Could this lead to copying a truncated amount of data while passing the full
total count back to userspace, causing userspace to process uninitialized
memory in its buffer as valid kernel data?

Reference: https://lore.kernel.org/bpf/20260602210416.2E0631F000893@smtp.kernel.org/

> +	    put_user(total, &uattr->batch.count) ||
> +	    (has_next_cursor &&
> +	     copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
> +			  cursor, key_size))) {
> +		ret = -EFAULT;
> +		goto free;
> +	}
> +
> +free:
> +	kfree(cursor);
> +	kvfree(keys);
> +	kvfree(values);
> +	kvfree(del_elems);
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26848361040
--===============3064337340957179930==--
