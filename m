Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29A3C063C
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820730; cv=none; b=bqdrPwy5UaJ9xi6lHjmV3cQ9vJAJN4O+Ko3Pc1Va+Aq5TdWF0F31ujyY0uxxCY1WssnrYPRqNZsEsiPKxoxWc465c0zGSvva2JiKpqrpR2D9AfvF0uZ3aG9bsvkXlTTrjlZWOVgvLIbylsmeIWgown3GzwsoOYSa5NZq5F1MMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820730; c=relaxed/simple;
	bh=SrwGtgqWvrAAPSQoIYBWX4nRFYyj7/qwtIn15/WvaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAKgEB0bb4J+72J5XEXmG7aadrpuKWQ0TyK/S8ZvQvZJ9EnTkcF/K+19O+uyv+AzpJIYgD88M3VLkI7R6oAHqzsQtvNmbSSfmAFoNoMuiLhsLbKUsNTSksTsTsJkWqFaEwBvTEm7kwSrnYqjWSnPI2MHsKZVyTUqaLQ9QIrUeEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QCqFikF8; arc=none smtp.client-ip=95.215.58.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QCqFikF8"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SrwGtgqWvrAAPSQoIYBWX4nRFYyj7/qwtIn15/WvaP8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787820726; v=1; x=1788425526;
 b=QCqFikF8VDmGpAzbkTXWYt3OMp7hiYJqyDRILYTWi/qSpuLTo53lUb5//A9elXd9oZYgFDnw
 0Feawz9GTmmv6M4UDDZG+FI/JDON77BkdU0+F7iurey7cBYM+VAtP5moCxcl0t/2KmRslE1JyCf
 th0lMDPsAeDZSsE7lP+sNxhQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 418bfbac2f478833;
	Thu, 27 Aug 2026 08:52:05 +0000
X-Mizu-Trace-ID: 418bfbac2f478833
X-Migadu-Flow: FLOW_OUT
Message-ID: <63ae0f06-e5a8-4a21-90cd-03e0ef100fda@linux.dev>
Date: Thu, 27 Aug 2026 16:51:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] bpf: Fix UAF due to concurrent consumption of
 waiting_for_gp_ttrace
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Pu Lehui <pulehui@huawei.com>
References: <20260827084013.1062816-1-pulehui@huaweicloud.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260827084013.1062816-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/8/26 16:40, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
[...]
>  kernel/bpf/memalloc.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index e9662db7198f..58296e92a4fe 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -119,6 +119,7 @@ struct bpf_mem_cache {
>  	struct llist_head waiting_for_gp_ttrace;
>  	struct rcu_head rcu_ttrace;
>  	atomic_t call_rcu_ttrace_in_progress;
> +	raw_spinlock_t lock;
>  };
>  
>  struct bpf_mem_caches {
> @@ -207,6 +208,7 @@ static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
>  static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  {
>  	struct mem_cgroup *memcg = NULL, *old_memcg;
> +	unsigned long flags;
>  	gfp_t gfp;
>  	void *obj;
>  	int i;
> @@ -228,12 +230,14 @@ static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node, bool atomic)
>  	if (i >= cnt)
>  		return;
>  
> +	raw_spin_lock_irqsave(&c->lock, flags);
>  	for (; i < cnt; i++) {
> -		obj = llist_del_first(&c->waiting_for_gp_ttrace);
> +		obj = __llist_del_first(&c->waiting_for_gp_ttrace);
>  		if (!obj)
>  			break;
>  		add_obj_to_free_list(c, obj);
>  	}
> +	raw_spin_unlock_irqrestore(&c->lock, flags);

Looks like scoped_guard() could get rid of the 'flags':

scoped_guard(raw_spinlock_irqsave, &c->lock) {
	...
}

>  	if (i >= cnt)
>  		return;
>  
> @@ -279,8 +283,14 @@ static int free_all(struct bpf_mem_cache *c, struct llist_node *llnode, bool per
>  static void __free_rcu(struct rcu_head *head)
>  {
>  	struct bpf_mem_cache *c = container_of(head, struct bpf_mem_cache, rcu_ttrace);
> +	struct llist_node *llnode;
> +	unsigned long flags;
>  
> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), !!c->percpu_size);
> +	raw_spin_lock_irqsave(&c->lock, flags);
> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
> +	raw_spin_unlock_irqrestore(&c->lock, flags);

Ditto
> +
> +	free_all(c, llnode, !!c->percpu_size);
>  	atomic_set(&c->call_rcu_ttrace_in_progress, 0);
>  }
>  
> @@ -297,6 +307,7 @@ static void enque_to_free(struct bpf_mem_cache *c, void *obj)
>  static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  {
>  	struct llist_node *llnode, *t;
> +	unsigned long flags;
>  
>  	if (atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)) {
>  		if (unlikely(READ_ONCE(c->draining))) {
> @@ -307,8 +318,10 @@ static void do_call_rcu_ttrace(struct bpf_mem_cache *c)
>  	}
>  
>  	WARN_ON_ONCE(!llist_empty(&c->waiting_for_gp_ttrace));
> +	raw_spin_lock_irqsave(&c->lock, flags);
>  	llist_for_each_safe(llnode, t, llist_del_all(&c->free_by_rcu_ttrace))
> -		llist_add(llnode, &c->waiting_for_gp_ttrace);
> +		__llist_add(llnode, &c->waiting_for_gp_ttrace);
> +	raw_spin_unlock_irqrestore(&c->lock, flags);

Ditto

>  
>  	if (unlikely(READ_ONCE(c->draining))) {
>  		__free_rcu(&c->rcu_ttrace);
> @@ -535,6 +548,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c->objcg = objcg;
>  			c->percpu_size = percpu_size;
>  			c->tgt = c;
> +			raw_spin_lock_init(&c->lock);
>  			init_refill_work(c);
>  			prefill_mem_cache(c, cpu);
>  		}
> @@ -557,7 +571,7 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
>  			c->objcg = objcg;
>  			c->percpu_size = percpu_size;
>  			c->tgt = c;
> -
> +			raw_spin_lock_init(&c->lock);
>  			init_refill_work(c);
>  			prefill_mem_cache(c, cpu);
>  		}
> @@ -609,7 +623,7 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>  		c->objcg = objcg;
>  		c->percpu_size = percpu_size;
>  		c->tgt = c;
> -
> +		raw_spin_lock_init(&c->lock);
>  		init_refill_work(c);
>  		prefill_mem_cache(c, cpu);
>  	}
> @@ -620,6 +634,8 @@ int bpf_mem_alloc_percpu_unit_init(struct bpf_mem_alloc *ma, int size)
>  static void drain_mem_cache(struct bpf_mem_cache *c)
>  {
>  	bool percpu = !!c->percpu_size;
> +	struct llist_node *llnode;
> +	unsigned long flags;
>  
>  	/* No progs are using this bpf_mem_cache, but htab_map_free() called
>  	 * bpf_mem_cache_free() for all remaining elements and they can be in
> @@ -629,7 +645,10 @@ static void drain_mem_cache(struct bpf_mem_cache *c)
>  	 * on these lists, so it is safe to use __llist_del_all().
>  	 */
>  	free_all(c, llist_del_all(&c->free_by_rcu_ttrace), percpu);
> -	free_all(c, llist_del_all(&c->waiting_for_gp_ttrace), percpu);
> +	raw_spin_lock_irqsave(&c->lock, flags);
> +	llnode = __llist_del_all(&c->waiting_for_gp_ttrace);
> +	raw_spin_unlock_irqrestore(&c->lock, flags);

Ditto

Thanks,
Leon

> +	free_all(c, llnode, percpu);
>  	free_all(c, __llist_del_all(&c->free_llist), percpu);
>  	free_all(c, __llist_del_all(&c->free_llist_extra), percpu);
>  	free_all(c, __llist_del_all(&c->free_by_rcu), percpu);

