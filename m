Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB357246781
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492110; cv=none; b=ZlnoJ5NY2Cux0pMIwyjVLoPta6o4AofBYz55Mkwd2MV4U/I8WDeqfDSYy10Id7NRJj9OSRH6iWzxs8kO0hfovQZX7blOmodw00juJ6dWgIZhFpfywPgoju1HfkQa764EACZcIeWinufKVYy4sjpcCSW7ztgz9XBCxZiDQjzFMYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492110; c=relaxed/simple;
	bh=V4T+b6QRGRJD3P/yEGOYjip3igbBbYD9zjfqu8gsf6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K2edAsncrJKmswIKmEZQPSJgdkRhMhSwP+gPHXDofitkYg1X5hBRCLNTBAKKF+eaHDvl9rB6WnCMpQIesMZdt3mAZ+gzsbCQIHh3x7QFQr7ca1IqMTsxX9r5MWAMLXbbdm0RMIVFaSEV++KBvFBEaIKrX9XvThhkqBbs7UgbCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRT8LIEi; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRT8LIEi"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2978958f8f.1
        for <bpf@vger.kernel.org>; Wed, 03 Jun 2026 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780492107; x=1781096907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO5E6r23kFzytuDhEfb8Ud9n4cTHgKfguz8KRfM0E5Q=;
        b=JRT8LIEiHJx0TpovgIVLO9QD2qV2bXBc7tlLQw+AYhcWnObCZJ7FZe7tbiAg4sIFKe
         S+cL1ZtsLlI7cy4Jt2s5/kqcoQSYd3FSHhIZCgSX8P4Hv1KuNG+E/dj91gHw7rFJNjZO
         j60TkK9/sdDoVniUlVtwUGEnWxxqEZ3Q9gSkkBFnAJsSFfHL7fTN6XMbTAi8SrUnjK1T
         vEYtni18D0ufhz70exqCcenZ+7yRuQSYCg4tqD7iOPN9n/jh4zbnW8OdVrY8Seiu+DNa
         IEdqI22MtKNEcrw6YVfbd+XLwgRIBA3oevB3per+izjc8Y9hNgJloFq14sPTnrrcEQ1K
         sLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492107; x=1781096907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BO5E6r23kFzytuDhEfb8Ud9n4cTHgKfguz8KRfM0E5Q=;
        b=oMA4zY2Oy67MPDtLwZo40iEObkrxoVx8AZz78as3BkE1B3E6+lqap7INuAv7oC2yjj
         05RQJWJtEu7kygA7WR5Y4rApXWm4RdM6XoRT6QVVstIhI+wmymvfYXb1BpGSzGKDpNiE
         2CbNY3/ddctEIfxk4HZx4J9L5rGsSWTSQIVlDcnvXvbQT8lONCkR6dXhHk0QLdMT3Gu7
         q3Yn3gmb3B52amjqsBNnZXfQjosTJoh+29YxW8COiDaEfU/sfKO+TLAmP3oG2VDbmYIL
         4d9aisVXPtgoCItMNEOP1F2h6BJysoecWyIQzHHONPt4OFP2LU48dJUbuExc3Fv5S+Cv
         BPVQ==
X-Forwarded-Encrypted: i=1; AFNElJ9JIwkLd7o6kgmHcXgnpr8bJ9SZY3D5/F7FjtY4CUmxvVxA2dJTPWKNt/rKAnq5uMZ8LNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy06VGjO/wNZmsRjY56oHO3td7hw9HrAol738urloBqvWG5M7kB
	+KqkHfTmT2qb6snn+r2Vqz9Prn/mn+5Jl8tux5LeyPjBsqfcihdITtEQ
X-Gm-Gg: Acq92OE1yFkqXq0sWFslESfdjxQ/tVQlAFWWzCLVh16l9stZjc6ZltuGv9poyjsXtX4
	/A2xLLzaSBK/06+1aokpc/Jm5BpHSWYBMjV7mp1G7ZO3YAWSS79aSKFhpoFeAttSI/iCAjujiT4
	bf0UstUUnWXLCpiw985jczxhzVc++Vel4ZrzDW5tfbLlz6IDuE95VAf+qh4b+cVRCDJ8YA6JKIj
	Tc+HoKUMsOB/NUBhUro4nKZ6yQ1X7BWv9VxEdq0V/XQxSU7NWniiu1otuUny4+3g4egflmz069X
	9mu6waDe/gZktpobw2wlOr3VSOmR3IqgoMUDr3Dg3wPsYz7BSlX4ZIB5V7VMMLuBVzhBRfKLGpH
	m3Lf6+Y03J4giR4XjaudCQ6nf+KRMeck05X0ICWuWVHGTkFIEfJwzBqIcqi26IFCZZmFnR6dbkP
	E4YLPWlgbVnzlT3zGvmuaWJztpNM+qF2EwNZuWV6pUN15m2I4x4fd6gZRjTz9nMCDUiLB8KIu0d
	zPRM3Ik24Pph9mAtJjQHA==
X-Received: by 2002:a05:600c:470e:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-490b5e83527mr53120225e9.5.1780492106862;
        Wed, 03 Jun 2026 06:08:26 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63fbcb7sm53378825e9.15.2026.06.03.06.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 06:08:25 -0700 (PDT)
Message-ID: <3960ffc3-78f3-46da-baaf-ce72b6495698@gmail.com>
Date: Wed, 3 Jun 2026 14:08:25 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 03/11] bpf: Implement resizable hashmap basic
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, martin.lau@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
References: <20260602-rhash-v6-3-1bfd35a4184f@meta.com>
 <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <4d811506109736528d816b6a1f613becd9460079ee7bfc67c509e67e7d2f44af@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/2/26 10:44 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4..10f3a058747b 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> @@ -2739,3 +2740,313 @@ const struct bpf_map_ops htab_of_maps_map_ops = {
>>  	.map_btf_id = &htab_map_btf_ids[0],
>>  };
>> +
>> +struct rhtab_elem {
>> +	struct rhash_head node;
>> +	/* key bytes, then value bytes follow */
>> +	u8 data[] __aligned(8);
>> +};
>> +
>> +struct bpf_rhtab {
>> +	struct bpf_map map;
>> +	struct rhashtable ht;
>> +	struct bpf_mem_alloc ma;
>> +	u32 elem_size;
>> +};
>> +
>> +static const struct rhashtable_params rhtab_params = {
>> +	.head_offset = offsetof(struct rhtab_elem, node),
>> +	.key_offset  = offsetof(struct rhtab_elem, data),
>> +};
> 
> [ ... ]
> 
>> +static struct bpf_map *rhtab_map_alloc(union bpf_attr *attr)
>> +{
>> +	struct rhashtable_params params;
>> +	struct bpf_rhtab *rhtab;
>> +	int err = 0;
>> +
>> +	rhtab = bpf_map_area_alloc(sizeof(*rhtab), NUMA_NO_NODE);
>> +	if (!rhtab)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	bpf_map_init_from_attr(&rhtab->map, attr);
>> +
>> +	if (rhtab->map.max_entries > 1UL << 31) {
>> +		err = -E2BIG;
>> +		goto free_rhtab;
>> +	}
>> +
>> +	rhtab->elem_size = sizeof(struct rhtab_elem) + round_up(rhtab->map.key_size, 8) +
>> +			   round_up(rhtab->map.value_size, 8);
>> +
>> +	params = rhtab_params;
>> +	params.key_len = rhtab->map.key_size;
>> +	params.nelem_hint = (u32)attr->map_extra;
>> +	params.automatic_shrinking = true;
> 
> Setting automatic_shrinking = true causes rhashtable to invoke
> schedule_work() when the table crosses certain occupancy thresholds
> (30% during deletions, 75% during insertions).

For v7 I'm dropping automatic_shrinking, because it adds a risk of
calling schedule_work() on element deletion path (__rhashtable_remove_fast_one())
when hashtable size drops below 30% of the capacity.

> 
> If a BPF program runs in NMI context (for example, from a perf event or
> raw tracepoint), and triggers a map operation that crosses these thresholds,
> won't schedule_work() be called from NMI context?
> 
> Looking at the workqueue code:
> 
> kernel/workqueue.c:__queue_work() {
>     ...
>     if (WARN_ON_ONCE(in_nmi()))
>         return;
>     ...
> }
> 
> This would trigger the warning and prevent the work from being queued,
> potentially breaking the map's resizing mechanism. The deadlock concern is
> even more serious - workqueue pool locks taken from NMI context could
> deadlock against the same locks taken in process context.
> 
> The bpf_disable_instrumentation() calls protect against instrumentation-
> based recursion but don't prevent the automatic shrinking work scheduling.
> Raw tracepoints can execute in NMI context and bypass the bpf_prog_active
> recursion checks.
> 
> Could this be addressed by either:
> 1) Setting automatic_shrinking = false
> 2) Adding an in_nmi() check before map operations that would error out with
>    -EBUSY, or
> 3) Using a custom shrinking callback that checks context before scheduling?
> 
> This concern was raised in a previous review iteration (v6, June 2):
> 
> https://lore.kernel.org/bpf/20260602210718.AED5C1F00893@smtp.kernel.org/
> 
>> +
>> +	err = rhashtable_init(&rhtab->ht, &params);
>> +	if (err)
>> +		goto free_rhtab;
>> +
>> +	/* Set max_elems after rhashtable_init() since init zeroes the struct */
>> +	rhtab->ht.max_elems = rhtab->map.max_entries;
>> +
>> +	err = bpf_mem_alloc_init(&rhtab->ma, rhtab->elem_size, false);
>> +	if (err)
>> +		goto destroy_rhtab;
>> +
>> +	return &rhtab->map;
>> +
>> +destroy_rhtab:
>> +	rhashtable_destroy(&rhtab->ht);
>> +free_rhtab:
>> +	bpf_map_area_free(rhtab);
>> +	return ERR_PTR(err);
>> +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26848361040

