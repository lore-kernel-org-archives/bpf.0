Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F40D4F0534
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453814; cv=none; b=S9mh51jCblTLgHD/HoOf/jCSTPgH0Zm2FObmBl1Wifq7DFzheZQ+cxE67OYA+dkazUkASmw1hS18DOv2MvH/KFvM8VhIIMHWVjyOkTybInK56gIcqtqb7LP9jw8/lFyX4w34ZIvkeJq2APQnN2G0kmgIfvsHGWc5p/tRHinzjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453814; c=relaxed/simple;
	bh=+r9hLk2SPOmyAvshuN0IagagVfA7a/hC3JMXKL35W1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxBzAHw3JJu2gNcJPTzy9CH9b5T7kWcwJkZU90Kr4T7EIkaRreUhBci67cGBqX3MHAdNFDtstVSJ5p/uHBBt0WFD4EpWh0I71lMkQfbPk2mo2aiXo0lmLbBhBaB2RtFaphwShjh419CtbQb7BaiwNe529K66UUYu7/yausODHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCUjCDtf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCUjCDtf"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c250f28f1cdso716266b.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788453810; x=1789058610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wjfdopz1N1hWehGtY1xAg4wK0Ims0sicB7CXr04O9bM=;
        b=fCUjCDtf3DUvCktyOi7f0h40JphcHQHqXKbM5MD1pLWM2Z/b2QCKxqouFFHEi1fSDn
         0n4kqEDMRqS9TxXP/KG0uhS2D4ewr0k7dJ6N+N4cMeO8NPDAALn36bGQGNWrM8jN1P1h
         4QkwBnnPOiMVLN4hIU2a6pYeuD3imrIIV3JkQWKssdj7i5PSmkuWgfEmyzNuCl5juYJ2
         ZodPFcGYrbTsa2XJIDecYjnC3hpMvqCZ0vplkqbCfu7t4+fhqE6i6hjKmt/BLuvfa/2q
         4Exb5gaTWUQa9NJrxlH2ehvOfWrsm/rJ5v5nE3wSMBzWMRpJ76wEeOXkmJibbG+SBoLC
         Xaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453810; x=1789058610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wjfdopz1N1hWehGtY1xAg4wK0Ims0sicB7CXr04O9bM=;
        b=QOJ5yVMOOFBC8Gyior4frCGlpAT1hAOEKb3VoeFKAXVfrq+Ekhnubhi6bmahVyt8gM
         5g8JMjw6ryhFfVGG+qcotsjW4mh3uUM5XUYLmRJDgUp3cN1h3KIxygcGOjv3WHvHSj2n
         V01hsgGXQ95jWPMF/yBer7Y7c8UKX9Ss5kuqdoDyYyAWPxsm5dowsW0pQYYBtBxy8ZBi
         7vYGfnrGknHqbf386/pCdXHvhXlnHCWjofNBzdAQketTlQDxc2VxpKJ6TMobw16mKevL
         WE3dx6gocFnMyJY8pe9f75ewOFdTDp3NHSaqRyyD30Oiqei9BEJZcdKaHjUg5dnNsM/r
         ff5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwNpBfb7RHrG+WdQsayMNKciKBKiRRqsAWTdIAuX5TVYpVRKkjnL4qu8n39kpHP7VqOpXQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ljSe83NkSqKZF7OvIiKxF5BZxvOmIuvz5aPme3SXW+myoBPkNS
	qeFxctMhHKirO3Y4MTD6w6DZgmpSNEmQCEUrYuZYAIB0oI+TikFU4k2G
X-Gm-Gg: AYBFou1bcAuwvbaHrfG021eof6mdHknQyJjnvljJKesppK2LmJit+EPXCCVbeP6GM08
	u/6lYHhfRVF69yAAFt4fUDwtyCdxjwrliRGjHbsJVIIqLDk2PED4btSWv9POzm1rf6/5+zgvD2o
	bCX53SLpJPF83OVxssyDxsc34nAH7EpvSAk4T5OrAUFvoa/ngzGm07DE7UyvLuwZQrXIUd9vT5F
	BxtSj72lkldDSQSD1/mjXY95YhBEO6dIemqD2AOAyxAbMDvHcdML0n423CzuS9JNt3b35QxS6+r
	p2HfnNERrs14apzG/ukBD4iK0FtFclMvPXMA0S0Cj4ijZgIhdbehqz8sTMzXBIJr+Gok+2yZiQ1
	hOkKCr49e27qSWaUnacYORkOvjKoogWAkOw9WNhtUaf41MZsE6fxvHa1AKcw9XcfvLcNFPb3256
	FC+p95cmoVy+k8M6ZMOb+OJzDUMKRfZMBlcPvC6cObTn7PWcOi0fkzYwg9QrcQ8l5d3xGI42Gs3
	kh5d2785POz3nhNRtKHZn1tKwHAZKiUBf2tuPMjePR4ciQ=
X-Received: by 2002:a17:907:7290:b0:c25:89fa:5a8e with SMTP id a640c23a62f3a-c260c7ac978mr1632566b.10.1788453810166;
        Thu, 03 Sep 2026 09:43:30 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:c0df:8063:3b00:b779? ([2a02:8109:a307:d900:c0df:8063:3b00:b779])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4244e45sm127018266b.60.2026.09.03.09.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 09:43:29 -0700 (PDT)
Message-ID: <7c741628-c259-4ae6-8d67-d92910183526@gmail.com>
Date: Thu, 3 Sep 2026 17:43:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf: bound resizable hash map iteration
To: Hui Su <sh_def@163.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260831140132.117755-1-sh_def@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260831140132.117755-1-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 3:01 PM, Hui Su wrote:
> rhashtable_next_key() provides a best-effort walk that may revisit
> entries and is not guaranteed to terminate under sustained rehashing.
> Callers performing a full iteration are expected to bound the walk
> externally.
> 
> bpf_each_rhash_elem() currently loops until rhashtable_next_key()
> returns NULL, leaving callback execution without a finite bound. Sample
> rhashtable's current element count and use it as the iteration budget.
> This keeps the bound proportional to current occupancy instead of the
> potentially much larger map capacity.
> 
> Duplicate visits may consume the budget and cause the walk to stop before
> all keys are observed, but RHASH iteration already permits missed
> elements under concurrent mutation.
> 
> This is reproducible with concurrent updates and deletes triggering
> rehash. With max_entries=4096, one walk invoked the callback 5239 times
> on an unpatched kernel. With the bound in place, callback invocations did
> not exceed 4096 in the same stress test.
> 
> Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
> Changes in v2:
> - Bound the walk by the sampled rhashtable element count instead of
>   map->max_entries, keeping the budget proportional to occupancy.
> 
> Link: https://lore.kernel.org/bpf/20260828183326.3330530-1-sh_def@163.com/
> ---

Thanks for sending the patch. I'm not sure if this change fixes anything,
the main issue of walking concurrently modified rhashtable is not changed: you
still may miss elements or visit same elements multiple times. In some scenarios
this can make things worse: imagine you start iterating with small map 
(visit_budget = 10), then 1000000 elements are inserted concurrently with walk,
so you'll miss at least 1000000 - 10. To me this is a trade off/taste 
thing, rather than bug fix.
The change is compact, though, I'm not against it.

>  kernel/bpf/hashtab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d40cb5dd446c..2cad67c90154 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -3198,7 +3198,8 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>  	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>  	void *prev_key = NULL;
>  	struct rhtab_elem *elem;
> -	int num_elems = 0;
> +	u32 visit_budget;
> +	u32 num_elems = 0;
>  	u64 ret = 0;
>  
>  	cant_migrate();
> @@ -3212,7 +3213,9 @@ static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>  	 * elements are deleted/inserted, there may be missed or duplicate
>  	 * elements visited.
>  	 */
> -	while ((elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
> +	visit_budget = atomic_read(&rhtab->ht.nelems);
> +	while (num_elems < visit_budget &&
> +	       (elem = rhashtable_next_key(&rhtab->ht, prev_key))) {
>  		if (IS_ERR(elem))
>  			break;
>  		num_elems++;
> 
> base-commit: c20313e98b04ce543936431b6122dd639d3a8346

