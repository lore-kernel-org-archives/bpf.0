Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EECD24E4A1
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972013; cv=none; b=dmMGhQhYn0kVXitKKx/vTQ4GFhsQCvg35DYT9w8pxUeaV9yU7hR9+k37y9phXHB1ggL18tQ1sSPQXVJmqJ3wV4fPwQZpfJ6LPQgtNj6cmKwKEgBQtz8s8tY/sZhnPKr30aHlMU8Vyw73N0hV1CWUQnVx6ktz8FucYEuwl5mPteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972013; c=relaxed/simple;
	bh=eT6xaelN5XO32ix1yQPvuSaJ0SdWh2+PvKzWtojBfcg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XfZiR733dMwvpniCbUj4+OPJ7kbBtJGDW3iI6p5s5VLpRvvL2JzYQC6u7Sq0UgYgtgkOrvVYKm+i/ld7m7U7rCZLygccvjbtu06db7j7NWp7DuEE67+jZBu9gYR+bp8PRvnuTQ1FaEWCxMQqca4JhC3k1Ubva/iqGXS0J+HUYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JO0uZ6ht; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JO0uZ6ht"
Message-ID: <45cd6493-843c-470d-b686-fea770f7b60f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773971996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cVGgvU+uzgYrpXevlS0BtmWDh9gxIX20gmyPvk1S/xo=;
	b=JO0uZ6htQfMj/h02yqJ2CpX8ju1gn5Dk4H/Zu067H04ey9LS7bgZ2aW5YmyFE60xLIxAvp
	ZwGXrmvaDVJmvSTL/Tfd+avGsHpgllmzXVP6okuXAT1OZmknfKroQQLTQpeYsJuri8RQOw
	O974JbVoAsV0SrXrLiu40vG1CXS2KCE=
Date: Thu, 19 Mar 2026 18:59:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: use RCU-safe iteration in dev_map_redirect_multi()
 SKB path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: David Carlier <devnexen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
References: <20260318162420.7684-1-devnexen@gmail.com>
 <27a6be7f-8263-41ef-a9b6-3925ee59061c@linux.dev>
Content-Language: en-US
In-Reply-To: <27a6be7f-8263-41ef-a9b6-3925ee59061c@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/19/26 6:37 PM, Martin KaFai Lau wrote:
> 
> 
> On 3/18/26 9:24 AM, David Carlier wrote:
>> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
>> hlist_for_each_entry_safe() to iterate hash buckets, but this function
>> runs under RCU protection (called from xdp_do_generic_redirect_map()
>> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
>> dev_map_hash_delete_elem) modify the list using RCU primitives
>> (hlist_add_head_rcu, hlist_del_rcu).
>>
>> hlist_for_each_entry_safe() performs plain pointer dereferences without
>> rcu_dereference(), missing the acquire barrier needed to pair with
>> writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
>> POWER), a reader can observe a partially-constructed node. It also
>> defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
>> detection.
>>
>> Replace with hlist_for_each_entry_rcu(), matching the XDP-frame path
>> (dev_map_enqueue_multi) which already uses the correct macro for the
>> same hash iteration.
> 
>>
>> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast 
>> support")
>> Signed-off-by: David Carlier <devnexen@gmail.com>
>> ---
>>   kernel/bpf/devmap.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
>> index 3d619d01088e..c8d256405c29 100644
>> --- a/kernel/bpf/devmap.c
>> +++ b/kernel/bpf/devmap.c
>> @@ -747,7 +747,6 @@ int dev_map_redirect_multi(struct net_device *dev, 
>> struct sk_buff *skb,
>>       struct bpf_dtab_netdev *dst, *last_dst = NULL;
>>       int excluded_devices[1+MAX_NEST_DEV];
>>       struct hlist_head *head;
>> -    struct hlist_node *next;
>>       int num_excluded = 0;
>>       unsigned int i;
>>       int err;
>> @@ -787,7 +786,7 @@ int dev_map_redirect_multi(struct net_device *dev, 
>> struct sk_buff *skb,
>>       } else { /* BPF_MAP_TYPE_DEVMAP_HASH */
>>           for (i = 0; i < dtab->n_buckets; i++) {
>>               head = dev_map_index_hash(dtab, i);
>> -            hlist_for_each_entry_safe(dst, next, head, index_hlist) {
>> +            hlist_for_each_entry_rcu(dst, head, index_hlist, 
>> lockdep_is_held(&dtab->index_lock)) {he 
> 
> Where is the dtab->index_lock acquired? dev_map_enqueue_multi() has been 
> incorrect also. Take a look at the rcu_read_lock_bh_held() usage in the 
> rcu_dereference_check() a few lines above.
> 
> pw-bot: cr
> 
> Please cc the bpf list and tag the target tree in the subject. imo, bpf- 
> next instead of bpf should be fine for this.

cc bpf list.

> 
>>                   if (is_ifindex_excluded(excluded_devices, num_excluded,
>>                               dst->dev->ifindex))
>>                       continue;
> 
> 

