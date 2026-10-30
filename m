Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349819;
	b=ki0aKWiSkKxf2l2oMfcq2u85Pgo2T5BnTqrA7J/dtXYBymkA3BM0SOL5ofJg3yu3jIhq
	 97ySq9jqTtF8gXx8T0vKGOuTisOBds7s1DGNwXfBArvWbcw0QFa8P73ni2tgbJgRk7vLg
	 9yVq5uE4+jMdAxuTDIlvZZD4iIRGN9emlDtaGvG3SCsIBIcCTb5eo7MTRY5oybn2Pu08U
	 FY98zc/NNia0tN7lscWxvjC168ADhSGV1SMqqWG2GX3BgP+m57RjoOCmjQiQXWRiByEu9
	 w+33mr3HTs8Coosc2x39ZWfzf38QC0Vv7wpM6FC+6xmSdVhwYCnQ0uy6pieCpjuCAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349819;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=aOJY1TVcA8c8VZRDhmaCuv4+pieyekjBeLYUwH6dOsY=;
	b=HRAHcIyNGg6bxf8EDRxUWW9VJ4SvvD63p9pZHrKeGWG8WniHKkku4wk4nJ0gE1dx/zXT
	 Lh8Daj/zi1+Qd7GSIBbfAL7JSyTX/JhC11D9LZ7z9CZM3e1dP3o2ruSE8uRry+4dQ+OfN
	 tCIjUzLSa40tN22s7WHNmd9ECvKrLmfR74h9Svqotj4DH4uzstjWnaKVrtc0Xy68xsDQy
	 2fhgRmt4lYvMq1OSAyax9r5V+M5sQp3KFXXYidRGsXHGTTuUw7VLCM+bmXXmPD80r+HRJ
	 oP4TPOVzPnokLDYkkamcxEzWpc78GFpWFdfdrhjfo5c2jUmim30MZvyvzoMV8d2q2TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aG9PnAR7;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE1606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 08:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BECE1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aG9PnAR7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aOJY1TVcA8c8VZRDhmaCuv4+pieyekjBeLYUwH6dOsY=;
	b=aG9PnAR7xhaRmj4/O7rSeUUWkpq8yxlfQAsXCG3Kl4URzKV0BSyMcDVrfY6ARF
	XONsbqYHoUSTDNBxDKK4tZzBunFLkOEURhU4O5p5iXpw4XOEpnl+aEqQ5nZAQHGH
	lHWg61/lp6FkDR3h2uuMOfZM30aWcQ/N9BBkLvBHd6/Qk=
Message-ID: <09113d83-4517-4d8f-92c0-92475dab16ed@163.com>
Date: Fri, 30 Oct 2026 16:42:44 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Retire task work before reclaiming hash
 elements
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org
References: <20261028073525.1035605-1-luyun_611@163.com>
 <20261028073525.1035605-2-luyun_611@163.com>
 <DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DMGN8VM2BAOR.28NRNN51MCI8I@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5yOEWORqZL6ODw--.13249S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW3Ww4DGF4fJr1furW3Wrg_yoWrZF4UpF
	Z5Kry7CrWDZa9Fvry0vw48CryrGwsaq345CF98Jry5Ar98WF92qr10yFy2qFWfCr1kJF4Y
	yr4j9FZxC3y5uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AYL2WrkWIbpMwAA3y

Hi Alexei and Mykyta,

Thanks for the review and suggestions.

I've reworked and validated the task_work fixes following Alexei's approach.
The revised fixes check that a map lookup returns the same value before
queueing work, and mark the context FREED before detaching it, without
adding special-field poisoning or allocator hooks.

Now working on the corresponding fixes and validation for bpf_wq and
bpf_timer. I'll send the complete patch series once validation is complete.

---

Thanks,

Yun Lu

在 2026/10/29 01:22, Alexei Starovoitov 写道:
> On Wed, Oct 28, 2026 at 12:35 AM Yun Lu <luyun_611@163.com> wrote:
>> Leave ERR_PTR(-ENOENT) in task-work slots before returning non-preallocated
>> HASH and RHASH elements to the allocator. The existing fetch/acquire error
>> path rejects the retired slot. Reopen it only when the allocator acquires
>> the storage again. Also retire a reinitialized RHASH candidate abandoned
>> after insertion finds an existing element or fails: a reader of a previous
>> incarnation can still hold its value pointer and install a context there.
> This is overkill.
> It adds a 3rd value of twk->ctx and two new functions that hashtab.c
> calls in 6 places.
> The kfuncs start to work differently for prealloc and non-prealloc maps.
>
> The map knows whether the element is deleted. Look it up.
> In bpf_task_work_acquire_ctx() the prog owns the ctx in PENDING state.
> The irq_work is not queued yet.
>
>    prog                                   delete
>    cmpxchg(&twk->ctx, NULL, ctx)          unlink the element
>    cmpxchg(&ctx->state, .., PENDING)      xchg(&twk->ctx, NULL)
>    lookup
>
> Either the lookup doesn't find the element or the xchg() finds the ctx.
> It's the same scheme as the usercnt check in __bpf_async_init().
>
> hashtab.c doesn't change. A deleted element gets -ENOENT in all map types.
> The cost is one lookup per bpf_task_work_schedule_*().
>
> The diff doesn't have the reorder of FREED and detach in
> bpf_task_work_cancel_and_free().
> That's a fix for a different race. It doesn't need a new ctx in a deleted
> element. Pls send it as a separate patch with its own steps.
>
> Something like this (compile tested only):
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 648abe1..acd62ef 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1148,6 +1148,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
>   	return (void *)value - round_up(map->key_size, 8);
>   }
>
> +/* Is the element that holds this value still in the map? */
> +static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
> +{
> +	u32 idx;
> +
> +	return map->ops->map_lookup_elem(map, map_key_from_value(map, value, &idx)) == value;
> +}
> +
>   enum bpf_async_type {
>   	BPF_ASYNC_TYPE_TIMER = 0,
>   	BPF_ASYNC_TYPE_WQ,
> @@ -4741,6 +4749,19 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
>   		return ERR_PTR(-EBUSY);
>   	}
>
> +	/*
> +	 * The prog can still hold a value of an element that was deleted from the map.
> +	 * bpf_task_work_cancel_and_free() is done with it and nothing stops a new callback
> +	 * when the element is freed. The ctx is published and PENDING at this point: either
> +	 * the lookup doesn't find the element or bpf_task_work_cancel_and_free() finds the ctx.
> +	 * An idle ctx stays in the element until the element is reused or freed.
> +	 */
> +	if (!bpf_map_value_is_linked(map, (void *)tw - map->record->task_work_off)) {
> +		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
> +		bpf_task_work_ctx_put(ctx);
> +		return ERR_PTR(-ENOENT);
> +	}
> +
>   	/*
>   	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
>   	 * scheduled. This does not address any race or correctness issue, but rather is a policy
>
> [...]
>
>> +	bpf_task_work_free(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>>   	bpf_obj_cancel_fields(&rhtab->map,
>>   			      rhtab_elem_value(elem, rhtab->map.key_size));
>>   	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
> bpf_wq and bpf_timer have the same problem.
> bpf_wq_init() on a deleted element installs a new cb. cb->value points to
> the element. htab_mem_dtor() ends in cancel_work(). It doesn't wait for
> bpf_wq_work(). The callback still runs when the element is freed.
> Pls fix all three.
>
> Also trim the commit log. The 5 steps and the splat are enough.
>
> pw-bot: cr

