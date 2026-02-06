Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4939E1A9F82
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 23:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420326; cv=none; b=bDvFPg3VWGwRhTmEAoYvCqml6inl0Uuz+UhcOE6633FkqsqlDPEd8iFmlYJuKW0rjLokFNQF+zpCM0NIDU37wCi1kVjXTOxNPQgyWDX0VUVXX123sqolVTouhJ01vp8FfMInfj4wnINmx61appnXEKVYYuYHEmvYJpP5Gh/x7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420326; c=relaxed/simple;
	bh=oLKYSJ2oOaZgh9XG4peYTfHwxJmGKtIzFjjOk4fTcYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7Xdr+rIGHZpdqHy5WxuHvSM8nZNhcGWTv1bEAzo8hyRwHUzXhgr0Rn/k6DBNJLSZKnY69B3hC6+bc3kl1vs+zneWqWc8qGETuZ0Guwd9fU0TBeVY5MXMEohqbQHL6sLYYQo7EhSPCRD+T6gGdjxtqhG4TxqUxhfgb1id8fGpl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zta5ai80; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zta5ai80"
Message-ID: <b51ca47f-46e2-457e-a152-2f7fbdeee1e2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770420314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/mql9Wf+rKSETAXdAbbRRwRbZwWvQI+TtWOfK6+wz2s=;
	b=Zta5ai80eZTdBqO+UWUWnmQBH1ScN/wlAMxXQcWHFbjPWiQ9etpCU+wmeJLDwF7KbYUnoZ
	IthBCo2stQmsYBkc6jJZHGynIX0rlUvAbP/duJmrLGcD1BoPrpKFNRRo5M6OIPQzCv8drE
	wtAlGTQyFOv/qLP7NMgHiikVuF6eXaM=
Date: Fri, 6 Feb 2026 15:25:06 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 10/17] bpf: Support lockless unlink when
 freeing map or local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
References: <20260205222916.1788211-1-ameryhung@gmail.com>
 <20260205222916.1788211-11-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260205222916.1788211-11-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/5/26 2:29 PM, Amery Hung wrote:
> +/*
> + * Unlink an selem from map and local storage with lockless fallback if callers
> + * are racing or rqspinlock returns error. It should only be called by
> + * bpf_local_storage_destroy() or bpf_local_storage_map_free().
> + */
> +static void bpf_selem_unlink_nofail(struct bpf_local_storage_elem *selem,
> +				    struct bpf_local_storage_map_bucket *b)
> +{
> +	bool in_map_free = !!b, free_storage = false;
> +	struct bpf_local_storage *local_storage;
> +	struct bpf_local_storage_map *smap;
> +	unsigned long flags;
> +	int err, unlink = 0;
> +
> +	local_storage = rcu_dereference_check(selem->local_storage, bpf_rcu_lock_held());
> +	smap = rcu_dereference_check(SDATA(selem)->smap, bpf_rcu_lock_held());
> +
> +	if (smap) {
> +		b = b ? : select_bucket(smap, local_storage);
> +		err = raw_res_spin_lock_irqsave(&b->lock, flags);
> +		if (!err) {
> +			/*
> +			 * Call bpf_obj_free_fields() under b->lock to make sure it is done
> +			 * exactly once for an selem. Safe to free special fields immediately
> +			 * as no BPF program should be referencing the selem.
> +			 */
> +			if (likely(selem_linked_to_map(selem))) {
> +				hlist_del_init_rcu(&selem->map_node);
> +				bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
> +				unlink++;
> +			}
> +			raw_res_spin_unlock_irqrestore(&b->lock, flags);
> +		}
> +		/*
> +		 * Highly unlikely scenario: resource leak
> +		 *
> +		 * When map_free(selem1), destroy(selem1) and destroy(selem2) are racing
> +		 * and both selem belong to the same bucket, if destroy(selem2) acquired
> +		 * b->lock and block for too long, neither map_free(selem1) and
> +		 * destroy(selem1) will be able to free the special field associated
> +		 * with selem1 as raw_res_spin_lock_irqsave() returns -ETIMEDOUT.
> +		 */
> +		WARN_ON_ONCE(err && in_map_free);
> +		if (!err || in_map_free)
> +			RCU_INIT_POINTER(SDATA(selem)->smap, NULL);
> +	}
> +
> +	if (local_storage) {
> +		err = raw_res_spin_lock_irqsave(&local_storage->lock, flags);
> +		if (!err) {
> +			if (likely(selem_linked_to_storage(selem))) {
> +				free_storage = hlist_is_singular_node(&selem->snode,
> +								      &local_storage->list);
> +				 /*
> +				  * Okay to skip clearing owner_storage and storage->owner in
> +				  * destroy() since the owner is going away. No user or bpf
> +				  * programs should be able to reference it.
> +				  */
> +				if (smap && in_map_free)
> +					bpf_selem_unlink_storage_nolock_misc(
> +						selem, smap, local_storage,
> +						free_storage, true);
> +				hlist_del_init_rcu(&selem->snode);
> +				unlink++;
> +			}
> +			raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
> +		}
> +		if (!err || !in_map_free)
> +			RCU_INIT_POINTER(selem->local_storage, NULL);
> +	}
> +
> +	if (unlink != 2)
> +		atomic_or(in_map_free ? SELEM_MAP_UNLINKED : SELEM_STORAGE_UNLINKED, &selem->state);
> +
> +	/*
> +	 * Normally, an selem can be unlinked under local_storage->lock and b->lock, and
> +	 * then freed after an RCU grace period. However, if destroy() and map_free() are
> +	 * racing or rqspinlock returns errors in unlikely situations (unlink != 2), free
> +	 * the selem only after both map_free() and destroy() see the selem.
> +	 */
> +	if (unlink == 2 ||
> +	    atomic_cmpxchg(&selem->state, SELEM_UNLINKED, SELEM_TOFREE) == SELEM_UNLINKED)
> +		bpf_selem_free(selem, true);
> +
> +	if (free_storage)
> +		bpf_local_storage_free(local_storage, true);

I think there is a chance that selem->state reached SELEM_UNLINKED but 
free_storage is false, and then local_storage is leaked.

afaik, it can happen when destroy() cannot hold its own 
local_storage->lock, but it should be very unlikely. There is a similar 
WARN_ON_ONCE in this function. If addressing this unlikely case is not 
worth the complexity, maybe it deserves a WARN_ON_ONCE here also. This 
can be followed up.

Thanks for working on this. It is a huge effort. The set is applied.

> +}

