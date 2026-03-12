Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF49391E7E
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345513; cv=none; b=OWAHDGn7YMpzlvKLB6u71DEtqqY4CKwrPTgEl3t67w1HI6UEldyqYPdftyjjXyDw2No1C3blIv7FyjBzV9vy76ACAugrB2rMb5gqgpiWiE2WFlUfOacR7nvXv/r90/Jviq4iQJNHe48Za0RWB947JmNhr/dlrcvjcEa05ZMLwYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345513; c=relaxed/simple;
	bh=/yYPw0dvbUv39ykhSPOAxt2agV3jmM8Y7XjA4uncK1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYjafmsU7snn9bQt3NJ7r48NwUFf5h7YvCfTxJE3cIvRWXfowkXbC2HlabEOTiA7086wwLx2sZ6yfNz9d26lwrQ6zxsg8GfzJ9kLChiO/prFp2oFZmEHjvheQx+JBB3dkSKAZOj6YM5OruC/GpzC4fH6HRxH1ux2s00hWT53nYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qS4ZSPKt; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qS4ZSPKt"
Message-ID: <43e6b566-0260-4552-9590-cc729dab8c2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773345508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Bq8mNi9LQSnVBCQlZTiXU1rhiShxss5ezhoRQfYomY=;
	b=qS4ZSPKtHURow/OsHGN7hpj+NnwsHVucCh0pMq2DVcVWP329FYfuY9MkiAoYp2KAUyvPeI
	NK1D323od+6lzrPxckB3FkbXxzbS6Zs9C4w6Fv1XSnC6eArMV9zjDyIfz7IVLpF8SLDgk2
	ezY+PF27+OmTmxyu//HW/k++ldCdZYo=
Date: Thu, 12 Mar 2026 12:58:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Content-Language: en-GB
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: xulang <xulang@uniontech.com>, bpf@vger.kernel.org, martin.lau@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, kaiyanm@hust.edu.cn,
 huyinhao@hust.edu.cn, dzm91@hust.edu.cn, kernel@uniontech.com,
 linux-kernel@vger.kernel.org
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
 <abKo0HZ3R_oY1BUa@mail.gmail.com>
 <a9e91c79-70f6-4f7e-a98a-12f2ef834c3a@linux.dev>
 <abL_mMQcDyh8pLDL@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <abL_mMQcDyh8pLDL@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 3/12/26 11:02 AM, Paul Chaignon wrote:
> On Thu, Mar 12, 2026 at 09:41:40AM -0700, Yonghong Song wrote:
>>
>> On 3/12/26 4:51 AM, Paul Chaignon wrote:
>>> On Thu, Mar 12, 2026 at 01:25:25PM +0800, xulang wrote:
>>>> From: Lang Xu <xulang@uniontech.com>
>>>>
>>>> An out-of-bounds read occurs when copying element from a
>>>> BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
>>>> value_size that is not 8-byte aligned.
>>>>
>>>> The issue happens when:
>>>> 1. A CGROUP_STORAGE map is created with value_size not aligned to
>>>>      8 bytes (e.g., 4 bytes)
>>>> 2. A HASH map is created with the same value_size (e.g., 4 bytes)
>>>> 3. Update element in 2 with data in 1
>>>>
>>>> In the kernel, map elements are typically aligned to 8 bytes. However,
>>>> bpf_cgroup_storage_calculate_size() allocates storage based on the exact
>>>> value_size without alignment. When copy_map_value_long() is called, it
>>>> assumes all map values are 8-byte aligned and rounds up the copy size,
>>>> leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
>>>>
>>>> This patch fixes the issue by ensuring cgroup storage allocates 8-byte
>>>> aligned buffers, matching the assumptions in copy_map_value_long().
>>> I don't think this bug is specific to the CGROUP_STORAGE maps. Wouldn't
>>> it affect any copy from a non-percpu map into a percpu hashmap? The
>>> reproducer in [1] copies from a BPF_MAP_TYPE_CGROUP_STORAGE map to a
>>> BPF_MAP_TYPE_LRU_PERCPU_HASH map, but I suspect you'd hit the same bug
>>> if copying from BPF_MAP_TYPE_HASH into BPF_MAP_TYPE_PERCPU_HASH because
>>> for BPF_MAP_TYPE_HASH the value size is also not rounded up to a
>>> multiple of 8.
>> The BPF_MAP_TYPE_HASH table have value size rounds up to 8. See:
>>
>>          if (percpu)
>>                  htab->elem_size += sizeof(void *);
>>          else
>>                  htab->elem_size += round_up(htab->map.value_size, 8);
>>
>> The same for array size.
> My bad, I looked at the _alloc_check and assumed any round_up would be
> reflected there :/ Given that:
>
> Acked-by: Paul Chaignon <paul.chaignon@gmail.com>
>
> I also had a look at other map types and they all seem to round up to 8
> or to not be susceptible to the oob copy (ex., queue & stack). The one
> for which I'm unsure is BPF_MAP_TYPE_*_CGROUP_STORAGE. It doesn't seem
> to round up to 8, but I'm unsure it could be used to reproduce the copy.

For cgroup local storage, I think we should be okay.

struct bpf_local_storage_elem {
         struct hlist_node map_node;     /* Linked to bpf_local_storage_map */
         struct hlist_node snode;        /* Linked to bpf_local_storage */
         struct bpf_local_storage __rcu *local_storage;
         union {
                 struct rcu_head rcu;
                 struct hlist_node free_node;    /* used to postpone
                                                  * bpf_selem_free
                                                  * after raw_spin_unlock
                                                  */
         };
         atomic_t state;
         bool use_kmalloc_nolock;
         /* 3 bytes hole */
         /* The data is stored in another cacheline to minimize
          * the number of cachelines access during a cache hit.
          */
         struct bpf_local_storage_data sdata ____cacheline_aligned;
};

struct bpf_local_storage_data {
         /* smap is used as the searching key when looking up
          * from the object's bpf_local_storage.
          *
          * Put it in the same cacheline as the data to minimize
          * the number of cachelines accessed during the cache hit case.
          */
         struct bpf_local_storage_map __rcu *smap;
         u8 data[] __aligned(8);
};

$ pahole -C bpf_local_storage_elem ../../linux-bld/vmlinux
struct bpf_local_storage_elem {
         struct hlist_node          map_node;             /*     0    16 */
         struct hlist_node          snode;                /*    16    16 */
         struct bpf_local_storage * local_storage;        /*    32     8 */
         union {
                 struct callback_head rcu __attribute__((__aligned__(8))); /*    40    16 */
                 struct hlist_node  free_node;            /*    40    16 */
         };                                               /*    40    16 */
         union {
                 struct callback_head       rcu __attribute__((__aligned__(8))); /*     0    16 */
                 struct hlist_node          free_node;            /*     0    16 */
         };

         atomic_t                   state;                /*    56     4 */
         bool                       use_kmalloc_nolock;   /*    60     1 */

         /* XXX 3 bytes hole, try to pack */

         /* --- cacheline 1 boundary (64 bytes) --- */
         struct bpf_local_storage_data sdata __attribute__((__aligned__(64))); /*    64     8 */

         /* XXX last struct has a flexible array */

         /* Force padding: */
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;
         struct bpf_local_storage_data :64;

         /* size: 128, cachelines: 2, members: 7 */
         /* sum members: 69, holes: 1, sum holes: 3 */
         /* padding: 56 */
         /* forced alignments: 1, forced holes: 1, sum forced holes: 3 */
         /* flexible array members: end: 1 */
};


So th minimum size will be 72 (with elem size 0). If the elem size is 4,
the allocation size will be 76.

The allocation is using kmalloc so the size will be promoted to next
slub bucket which should be round of 8.

>
> On a related note, this is the sort of reproducer that would be good to
> add in https://github.com/google/syzkaller/tree/master/sys/linux/test
> because syzbot can easily learn from it and reach potentially similar
> bugs.
>
>>> 1 - https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
>>>
>>>> Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
>>>> Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
>>>> Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
>>>> Signed-off-by: Lang Xu <xulang@uniontech.com>
>>>> ---
>>>>    kernel/bpf/local_storage.c | 7 +++----
>>>>    1 file changed, 3 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
>>>> index 8fca0c64f7b1..54b32ba19194 100644
>>>> --- a/kernel/bpf/local_storage.c
>>>> +++ b/kernel/bpf/local_storage.c
>>>> @@ -487,14 +487,13 @@ static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
>>>>    {
>>>>    	size_t size;
>>>> +	size = round_up(map->value_size, 8);
>>>>    	if (cgroup_storage_type(map) == BPF_CGROUP_STORAGE_SHARED) {
>>>> -		size = sizeof(struct bpf_storage_buffer) + map->value_size;
>>>> +		size += sizeof(struct bpf_storage_buffer);
>>>>    		*pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
>>>>    				  PAGE_SIZE) >> PAGE_SHIFT;
>>>>    	} else {
>>>> -		size = map->value_size;
>>>> -		*pages = round_up(round_up(size, 8) * num_possible_cpus(),
>>>> -				  PAGE_SIZE) >> PAGE_SHIFT;
>>>> +		*pages = round_up(size * num_possible_cpus(), PAGE_SIZE) >> PAGE_SHIFT;
>>>>    	}
>>>>    	return size;
>>>> -- 
>>>> 2.51.0
>>>>
>>>>

