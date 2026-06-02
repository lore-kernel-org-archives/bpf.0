Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C06221DB6
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 21:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434257; cv=none; b=BupqaA5MgcBnWgadPNA+DzuAV8WhikP0lzLgj8EEOZLRZG3MWhwjlprR/JJ5FWiIvyWdVE61Bxrff2GfNayvqQhNk1lgf4+wCmLBqtiCsVdsYe8aRMdtWLp2SNPm+Ji2cbZjDhUuaUL2PoILa6TwfN4JqU1O+3jiGT0D2BgapEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434257; c=relaxed/simple;
	bh=6wkHlErnbpo14ySbNyDNLq4hSqh1yxoIWNLVcoUKRDI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0Rd7xE3nRGgHH9EfYI1nPObnzhz+nRIudM2SxJgjyN2jlSgYyqgnpmR1UZ1VNR0ig/lSrdiedc3duYMOCqK5ot1TjcTp1LL+uRhFj+j59wIdMwIBbAzll0FBwtVbIch9NoXbi/GAEvJDWMGPj5wlG6fQWYZXmdwOltTboHjOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKeYXq0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKeYXq0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0631F00893;
	Tue,  2 Jun 2026 21:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780434256;
	bh=7mBVMSHXJsFKQgOiF8ETSGnwgqoFTm734z24KNcoP4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EKeYXq0A74x/SdL/PW6ymxqYz42GN1C74szz7urkpzWdQSA8OIFZzjU7wcZuDNB6x
	 a8qwtRxetVrx3F42kte83fMebR/kdE5fIDh5n74ToD2PXHyUyAYg3MxysujcuhZige
	 ALoWJ6F9YP9FvZUpJ0XMqA6Fz9Az+4/0yPvsNs1CO1MMIMBxQGcaWyDJW30aVHs6qh
	 DJBOL8C9N33Y7AdXiqMl/xDp/i5yTFyZmTTq9lWNqG9q3gX8W9Se4Fqznbz2Gb0yDP
	 oxXOrYRqge/0VXTWUAtAwFSN6jdKYoQtp2aDxgOd3j0kKaJa/EpXqfD8u6wPZ8oKhQ
	 /iDQTCQnCzTUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 04/11] bpf: Implement iteration ops for
 resizable hashtab
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mykyta Yatsenko" <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260602-rhash-v6-4-1bfd35a4184f@meta.com>
References: <20260602-rhash-v6-4-1bfd35a4184f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 21:04:15 +0000
Message-Id: <20260602210416.2E0631F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Batch operations and for_each iteration prematurely abort when the=
 iteration cursor is lost due to element deletion.
- [High] `__rhtab_map_lookup_and_delete_batch` allows concurrent operations=
 to duplicate elements, breaking exactly-once semantics.
- [High] Unbounded loop in `bpf_each_rhash_elem` allows RCU stalls and soft=
 lockups.
- [High] Integer overflow in `copy_to_user` length calculation causes trunc=
ated writes and exposes uninitialized memory.
--

commit eb56d8be7793a104d2c90482e4577a63fef630ae
Author: Mykyta Yatsenko <yatsenko@meta.com>

bpf: Implement iteration ops for resizable hashtab
   =20
This commit implements get_next_key, batch lookup/lookup-and-delete,
for_each_map_elem callback, and the seq_file BPF iterator for
BPF_MAP_TYPE_RHASH.

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 10f3a058747b3..997f420d67e35 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
[ ... ]
@@ -3034,6 +3105,275 @@ static u64 rhtab_map_mem_usage(const struct bpf_map=
 *map)
> +static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t call=
back_fn,
> +				void *callback_ctx, u64 flags)
> +{
[ ... ]
> +	rcu_read_lock();
> +	/*
> +	 * Best-effort iteration: if rhashtable is concurrently resized or
> +	 * elements are deleted/inserted, there may be missed or duplicate
> +	 * elements visited.
> +	 */
> +	while ((elem =3D rhashtable_next_key(&rhtab->ht, prev_key, rhtab_params=
))) {

[Severity: High]
The rhashtable_next_key documentation notes that a full iteration is not
guaranteed to terminate under adversarial or sustained rehashing. Since this
loop lacks an external bound and runs under rcu_read_lock with migration
disabled, can continuous concurrent resizes cause an infinite loop, resulti=
ng
in a soft lockup or RCU stall?

> +		if (IS_ERR(elem))
> +			break;

[Severity: High]
If prev_key is deleted concurrently or by the callback itself,
rhashtable_next_key returns ERR_PTR(-ENOENT). Does breaking the loop here
cause the iteration to immediately abort and skip the rest of the map?

> +		num_elems++;
> +		ret =3D callback_fn((u64)(long)map,
> +				  (u64)(long)elem->data,
> +				  (u64)(long)rhtab_elem_value(elem, map->key_size),
> +				  (u64)(long)callback_ctx, 0);
[ ... ]
> +static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
> +					       const union bpf_attr *attr,
> +					       union bpf_attr __user *uattr,
> +					       bool do_delete)
> +{
[ ... ]
> +	while (elem && !IS_ERR(elem) && total < max_count) {

[Severity: High]
Similar to the callback iteration, if a concurrent deletion occurs and elem
receives -ENOENT, this loop breaks. If total is greater than 0 when this
happens, doesn't this falsely signal to userspace that the map is fully
iterated, leading to missed elements?

> +		memcpy(dst_key, elem->data, key_size);
> +		rhtab_read_elem_value(map, dst_val, elem, elem_map_flags);
> +		check_and_init_map_value(map, dst_val);
> +
> +		if (do_delete)
> +			del_elems[total] =3D elem;
> +
> +		elem =3D rhashtable_next_key(&rhtab->ht, dst_key, rhtab_params);
> +		dst_key +=3D key_size;
> +		dst_val +=3D value_size;
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
> +		has_next_cursor =3D true;
> +	}
> +
> +	if (do_delete) {
> +		for (i =3D 0; i < total; i++)
> +			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
> +	}

[Severity: High]
Deferring the deletion until after the iteration leaves elements visible in
the hash table while they are being copied into user buffers. Does this cre=
ate
a race window where concurrent batch operations can traverse, copy, and yie=
ld
the same elements to userspace, breaking the exactly-once consumption
semantics expected for work queues?

> +
> +	rcu_read_unlock();
> +
> +	if (total =3D=3D 0) {
> +		ret =3D -ENOENT;
> +		goto free;
> +	}
> +
> +	/* No more elements after this batch. */
> +	if (!has_next_cursor)
> +		ret =3D -ENOENT;
> +
> +	if (copy_to_user(ukeys, keys, total * key_size) ||
> +	    copy_to_user(uvalues, values, total * value_size) ||

[Severity: High]
Both total and value_size are u32 variables. If a large batch size is used
(for example, 1,048,576 elements multiplied by 4096 bytes), does the 32-bit
multiplication overflow before being cast to unsigned long for copy_to_user?

Could this lead to copying a truncated amount of data while passing the full
total count back to userspace, causing userspace to process uninitialized
memory in its buffer as valid kernel data?

> +	    put_user(total, &uattr->batch.count) ||
> +	    (has_next_cursor &&
> +	     copy_to_user(u64_to_user_ptr(attr->batch.out_batch),
> +			  cursor, key_size))) {
> +		ret =3D -EFAULT;
> +		goto free;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602-rhash-v6-0=
-1bfd35a4184f@meta.com?part=3D4
