Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217887;
	b=GaO6veW7E3vQcr4WSTEHvjPDmX9tOaEvU0VcD/HfwfmoT3sHHPQLXBjvPChHEfIZx2a7
	 +bJHxO05Ec5SS+a/1DRu/FXr41I61RV7m7q2/fon8DECOahxF12r01eHVcIzsteLSEVWw
	 X5IzSHddYY/Dhj97+w3CDm9iUgFXfybRw0DcMFR3q00fK+DlH7E6oL1ZH58+aNJ8wRkuv
	 JOIteE0sGqREisvYsyTV8SD9FbwQeNwJe8xgosidQIUN/bsaL6dqDeJednW0d07XSOLkj
	 3Xqot0nAolaswkL6GOvxJGCpXLoBCNsTEHsxcx8ljKKgHK7Z4HmMRYO5i/4hCiJsRpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217887;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=zlX3acpLcA5navxGLDN3OlFGBz6oqKmH9hTN6VlUDQ0=;
	b=DVfjA3hgi8DXMa1MdxQMVGpMGm7BOVv8jXDPnXTe2GqbTfJb8rje05ybZpCTC/VZIttp
	 mCXh5F2ACvrAqQ+JS2lhSb7LKwBrGloPHXYr3zSjlmsNRuTaFdAOhtjRVZclxPYDlI2lk
	 A02xSkxNBM7jMyur1wWeJbbany5InObPL4kivcJFxp0gY/nrWzKp5tYgc4rwJ+QvRGn/g
	 vaN65H4+hAh8+7evuJLkd7GgVyW7a35eps9wBlrniNgCJgAONhe6K780plBy/yZpLYRbn
	 qv7ON7UO7BZhzoTXZvSQ8HvQNpeg/ARMEtEwgyYSynlq/s/AasI63wGSy+7HokT4Lbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cXSH5vys;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40A606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 09:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E40A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cXSH5vys
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=zlX3acpLcA5navxGLDN3OlFGBz6oqKmH9hTN6VlUDQ0=;
	b=cXSH5vys6SG8IMV97XnyeyDBNb9UyN0zi/55AI/fth8RGoFYgeS4ipWsITf+3j
	stwTqqNT2QpYIvpkWRTz8mpkPbH4KtEtsA1katkzdtSz+35MPG+ZW2iCh2pPjxWd
	I9983qQbRuCvkr0tnw9aE+vqmI0xoDDJjGNhqGgebxSVc=
Message-ID: <e2e0d955-5e4e-4196-a7a6-bd9d6acd8700@163.com>
Date: Mon, 9 Nov 2026 17:50:30 +0800
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
Subject: Re: [PATCH bpf-next v2 0/8] bpf: Fix async callback use-after-free on
 map deletion
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev
Cc: yatsenko@meta.com, bpf@vger.kernel.org
References: <20261106095747.471718-1-luyun_611@163.com>
 <DMOAQI1S0JBS.3N3WETHD2L6KQ@gmail.com>
Content-Language: en-US
From: luyun <luyun_611@163.com>
In-Reply-To: <DMOAQI1S0JBS.3N3WETHD2L6KQ@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgAXYHFml_FqsdNtEQ--.30346S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4ktFW7XFy3Ar1UGr4xXrb_yoWrGFyxpF
	WSqa42kr4DXFW2qw4Iva15CFyrJwnaqr47Grn5Ja4rAF98urn7trn5uFyFyFZ8ZrykCF4Y
	vr1jgay3Xw4UGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5sqAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AcW5Grxl2fMAAAA3+

Hi Alexei,
Thanks for the review and the example. Sorry for overcomplicating the fix
and adding so many repetitive tests.

I'll rework the next version based on your example: leave __bpf_async_init()
unchanged and check membership only in the shared setter. I'll also reuse
the existing selftests and reduce the added test code.

---

Thanks,

Yun Lu

在 2026/11/7 01:16, Alexei Starovoitov 写道:
> On Fri, Nov 06, 2026 at 01:57 AM Yun Lu <luyun_611@163.com> wrote:
>> Following Alexei's suggestion [2], check whether the map lookup still
>> returns the value after publishing the context. For wq and timers, check
>> both init and the setter, since another CPU can configure the published
>> cb before init finishes its checks.
> can we do the check once, in __bpf_async_set_callback() ?
> Only the setter installs cb->prog and cb->callback_fn.
> bpf_timer_start() and bpf_wq_start() return -EINVAL when cb->prog is NULL.
> Nothing runs on a deleted element when the setter rejects it.
> The three options for the place of the check:
>
>    check in         result
>    ---------------  ----------------------------------------------------
>    init             another cpu sets callback_fn before the check
>    init and setter  2 lookups, bpf_async_cancel_cb() for the failed init
>    setter           1 lookup, an idle cb stays in the deleted element
>
> The idle cb is like the idle ctx of task work in patch 2.
> It stays until the element is reused or freed. That's the case today too.
> __bpf_async_init() doesn't change.
> rhash_timer keeps its check of the reused element.
>
> The diff replaces patches 5 and 7 and most of patch 4.
> bpf_map_value_is_linked() is the one from patch 2 without guard(rcu).
> The diff doesn't have the reorder of cb->map = NULL and the detach.
> It also lacks the -ENOENT line in the uapi doc and the rhash_timer update.
>
> Something like this (not even compile tested):
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1151,6 +1151,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
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
> @@ -1544,11 +1552,25 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
>   				    struct bpf_prog *prog)
>   {
>   	struct bpf_async_cb *cb;
> +	struct bpf_map *map;
>   
>   	cb = READ_ONCE(async->cb);
>   	if (!cb)
>   		return -EINVAL;
>   
> +	/*
> +	 * The prog can still hold a value of an element that was deleted from the map.
> +	 * bpf_async_cancel_and_free() is done with it and nothing stops a new callback
> +	 * when the element is freed. cb is published at this point: either the lookup
> +	 * doesn't find the element or bpf_async_cancel_and_free() finds cb.
> +	 * Nothing runs without callback_fn. An idle cb stays in the element until the
> +	 * element is reused or freed.
> +	 */
> +	smp_mb();
> +	map = READ_ONCE(cb->map);
> +	if (!map || !bpf_map_value_is_linked(map, cb->value))
> +		return -ENOENT;
> +
>   	return bpf_async_update_prog_callback(cb, prog, callback_fn);
>   }
>   
> @@ -1739,9 +1761,7 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
>   {
>   	struct bpf_async_cb *cb;
>   
> -	if (!READ_ONCE(async->cb))
> -		return;
> -
> +	/* xchg() orders the unlink of the element before the read of async->cb. */
>   	cb = xchg(&async->cb, NULL);
>   	if (!cb)
>   		return;
>
> [...]
>
>>   11 files changed, 1476 insertions(+), 117 deletions(-)
> Way too much for selftest.
> Shrink it 10x.
>
> pw-bot: cr

