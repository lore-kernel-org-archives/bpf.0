Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BCD2EFD95;
	Mon,  8 Jun 2026 01:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780881967; cv=none; b=MK7MMWWXi5nWKzv19P7pQzgWGW8yKPAxu2/0xiszk56ziaGNv8zPPSTg26xLd0FkmY9Nm839IHCU8ZBuRer9mtT+QdZGlaGJ/z7225T42c/CmENZMhcfY5HzwCx/wkK9fChmxRCv3MznQKyhkrQZA8omzIrQkI0Sl2knr8aTxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780881967; c=relaxed/simple;
	bh=O6LnjWpQVuZKAb7rXeRcoSETnjCslaiSvTT9nAWNsz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cugy9nc0FdW9PXNPFHvNLlcoOrbfaiSjquoRjtSTPtMmigK2GecRqL97pNfU0573SK9be/9e3BVlHkVnJW7nGk344ytkL3g3PSrtXrd6BgPQOW+mNLmNsmVxmI26tr5b72ml48JwzJAq7ZBFJh5CxVank6InxmYn5rpY9tSyj28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=F4VIVb3l; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="F4VIVb3l"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jhoiipB4mOqgAqIh6O+bM57FM9mx18SrPqzsSx1NfvA=;
	b=F4VIVb3lWioCsCjGAzKqK+0NSY9dylqiBHtluD7Xk+23Ufp98tQF27hfyMDLDgiFnYRikkl3j
	KLmCYiT5PXr7BE6xEJEsW0WP++9/kDqSi6AizKU5IPTzGIJEI5RNHkRJOiNH6Fv8myALdnE2037
	4Z5Jz1hXAEAZyLG5Z3az+T0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYZ0l199nzKmTm;
	Mon,  8 Jun 2026 09:17:59 +0800 (CST)
Received: from kwepemj100017.china.huawei.com (unknown [7.202.194.11])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C4D2402AB;
	Mon,  8 Jun 2026 09:25:54 +0800 (CST)
Received: from [10.67.108.244] (10.67.108.244) by
 kwepemj100017.china.huawei.com (7.202.194.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 8 Jun 2026 09:25:53 +0800
Message-ID: <f99d0d59-d12b-417d-b02a-2ae73077056d@huawei.com>
Date: Mon, 8 Jun 2026 09:25:52 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: defer freeing htab internal structs to workqueue to
 fix sleep-in-atomic
Content-Language: en-US
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>
CC: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260606022827.3553277-1-luogengkun2@huawei.com>
 <ba77f59c-f932-4792-9d57-69ebe8806857@gmail.com>
From: Luo Gengkun <luogengkun2@huawei.com>
In-Reply-To: <ba77f59c-f932-4792-9d57-69ebe8806857@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100017.china.huawei.com (7.202.194.11)



On 2026/6/8 3:03, Mykyta Yatsenko wrote:
> 
> 
> On 6/6/26 3:28 AM, Luo Gengkun wrote:
>> This fix resolves a conflict between two patches:
>> 1. commit 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
>> 2. commit 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning
>> htab with internal structs")
>>
>> The problem is that commit 4f375ade6aa9 breaks commit 1da6c4d9140c 's UAF
>> fix, because we need the RCU grace period to keep symlink lookups safe. But
>> keeping the RCU delay means `htab_map_free_internal_structs` runs inside
>> RCU_SOFTIRQ, where calling `cond_resched()` and triggers the "sleeping
>> function called from invalid context" BUG.
>>
>> To solve both issues, we keep the VFS RCU protection intact (by reverting
>> commit 4f375ade6aa9), and defer the actual freeing to workqueue to avoid
>> sleep-in-atomic.
>>
>> Fixes: 1da6c4d9140c ("bpf: fix use after free in bpf_evict_inode")
>> Fixes: 4f375ade6aa9 ("bpf: Avoid RCU context warning when unpinning htab with internal structs")
>> Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
>> ---
> 
> It looks like the problem has been fixed by:
> b93c55b4932d ("bpf: fix UAF by restoring RCU-delayed inode freeing in bpffs")

Thanks, I will test it on my machine.
> 
>>   kernel/bpf/hashtab.c | 23 ++++++++++++++++++-----
>>   kernel/bpf/inode.c   |  4 ++--
>>   2 files changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4..6d6f1faeec67 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -102,6 +102,7 @@ struct bpf_htab {
>>   	u32 n_buckets;	/* number of hash buckets */
>>   	u32 elem_size;	/* size of each element in bytes */
>>   	u32 hashrnd;
>> +	struct work_struct work;
>>   };
>>   
>>   /* each htab element is struct htab_elem + key + value */
>> @@ -539,6 +540,8 @@ static int htab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>>   		return htab_set_dtor(htab, htab_mem_dtor);
>>   }
>>   
>> +static void htab_map_free_internal_structs_deferred(struct work_struct *work);
>> +
>>   static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>   {
>>   	bool percpu = (attr->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
>> @@ -557,6 +560,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr *attr)
>>   	if (!htab)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> +	INIT_WORK(&htab->work, htab_map_free_internal_structs_deferred);
>>   	bpf_map_init_from_attr(&htab->map, attr);
>>   
>>   	if (percpu_lru) {
>> @@ -1606,18 +1610,27 @@ static void htab_free_malloced_internal_structs(struct bpf_htab *htab)
>>   	rcu_read_unlock();
>>   }
>>   
>> -static void htab_map_free_internal_structs(struct bpf_map *map)
>> +static void htab_map_free_internal_structs_deferred(struct work_struct *work)
>>   {
>> +	struct bpf_map *map = container_of(work, struct bpf_map, work);
>>   	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>>   
>> -	/* We only free internal structs on uref dropping to zero */
>> -	if (!bpf_map_has_internal_structs(map))
>> -		return;
>> -
>>   	if (htab_is_prealloc(htab))
>>   		htab_free_prealloced_internal_structs(htab);
>>   	else
>>   		htab_free_malloced_internal_structs(htab);
>> +	bpf_map_put(map);
>> +}
>> +
>> +static void htab_map_free_internal_structs(struct bpf_map *map)
>> +{
>> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
>> +	/* We only free internal structs on uref dropping to zero */
>> +	if (!bpf_map_has_internal_structs(map))
>> +		return;
>> +
>> +	bpf_map_inc(map);
>> +	schedule_work(&htab->work);
>>   }
>>   
>>   /* Called when map->refcnt goes to zero, either from workqueue or from syscall */
>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>> index 25c06a011825..b6f295732f6f 100644
>> --- a/kernel/bpf/inode.c
>> +++ b/kernel/bpf/inode.c
>> @@ -762,7 +762,7 @@ static int bpf_show_options(struct seq_file *m, struct dentry *root)
>>   	return 0;
>>   }
>>   
>> -static void bpf_destroy_inode(struct inode *inode)
>> +static void bpf_free_inode(struct inode *inode)
>>   {
>>   	enum bpf_type type;
>>   
>> @@ -777,7 +777,7 @@ const struct super_operations bpf_super_ops = {
>>   	.statfs		= simple_statfs,
>>   	.drop_inode	= inode_just_drop,
>>   	.show_options	= bpf_show_options,
>> -	.destroy_inode	= bpf_destroy_inode,
>> +	.free_inode	= bpf_free_inode,
>>   };
>>   
>>   enum {
> 
