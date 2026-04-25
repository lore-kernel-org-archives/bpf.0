Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998912FDC28
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777150263; cv=none; b=AdW9TVSxcOEOCgcnqOA5Mc2IFGdwwy+UMiv2W9a7kn0LarRcp3VKLnbYTrNg8dXMvCZ/hGUr/DF2bWdwyG4rIDJKxeqnDgIOISRZcNNCavXKFXLjDQptChu+4ocY+1khKGIes07m2c6gJ8p8t3al5XBpqpvcT9+rLh4OCkasHdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777150263; c=relaxed/simple;
	bh=hO+ENV1TXOC9rvyyuqbjLWCjhKEWpxKUtAR57alCKJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIkVH45AEB9ss2DbW4ex19CiLEVnhOCNXZ63p1c35glV5W4K3Mi628+kB61YP/gHj7h6kDrNQYoUtuB1w1/c4kR8t2/rds9Enec0et9zA4fSAONds4s+qJA8HnYHBSfJwMKyXHD8EYJtagQ0oBzyYWRk02lpq8h+oyfTudOHM5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmDdXN58; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmDdXN58"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44261378651so366513f8f.0
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 13:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777150260; x=1777755060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/etTuQSLtnbJM4mInU0f/qWMYQlNqhNFLduxwI+Bf0Y=;
        b=bmDdXN58ZvG4vAPHb5E90YoR/ko2IvibUAtRktexLUo+Ko6OQPKjT/7VMCFitk8MJu
         odTB0Z/cVI5jktF8YRwkcwJcA1thTgSfkpw+cB1k3b2Td0MCCEOz03VZ8rnPKEnpzR/B
         bb5oaFS6vCmxltM1Ten5yctBTasVayRkLxdHMRNuTXKZ2sBk6hetxMurnkEa+Rb5HBGv
         wwVzYteXFk7XA6TiGkkU8G6Awzpy5ryrQSHcdPypBVkn0w7x665I8EaLuiI11Zc0g7zb
         FL9k3vrMXVqGUDHBe8BS6UHMqPkwbmPPaY+aQkWw26/e1jH97PaogG78f/zmSA9Ny3v9
         lVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777150260; x=1777755060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/etTuQSLtnbJM4mInU0f/qWMYQlNqhNFLduxwI+Bf0Y=;
        b=DndiDh2rS4z5I/99mGXM1yU4yXB9laef+P5YsNLyRqZoER29qaHrvs1lWryIZd0vbK
         ZFpO0wALxVSZck4+zZf+z7QB9A99Uz5EFavB69v2Q+He31+3BBIA1aosKOVjAXiM045+
         XXf8mTWZwuNQ8jddH3uLRTrY/Jfc1NM08Qaiqk5FAjeTtECfkSJjkz7+BMXRde0vqfzp
         j+8keK/Jpb7cxyn5LUgzXsXFVYgkO50dzCxdG5aI6OgnJ9CbwJxtJvPARHIcGOVpPtNH
         DzS0bJ9daRRInZdxH2qddVcQo65skZaElrYeThOI63ZjNNLnhwgjMKTP0HrU14tDtLzi
         zFNg==
X-Forwarded-Encrypted: i=1; AFNElJ83unFRpNoHXNcfgLO/CYD+5J6i7Rcw0NviV9c+B+E52LUneet0HflKQHZBRpLD5G3AEkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7mlXtP3fUSHfgGskVVCkOvoFTrq+9QUCPkZ7E5Qy46RwtWEVP
	IewhjeUDi6t7iJwz39YI3YjOUDJ2TD3w391k0PSsGg90DkWfDpn5zeNR
X-Gm-Gg: AeBDievAxhAcHoaMqI6GnZXFw7zkVo089neTA0xSYA/lqJDYLtaLfMFrfW+aj5Y1hR/
	xVWLDEF6PguFSPcjFVL4I81FNQJyxFIxfn3IN9YeIDJQZlr5eeOyPnOwpn7dtX9+fu6dwtFVoIa
	BhauqElSxDlF+XKlXKDnhnmQmb+vuJzBkKXckvB6Y7QrOIhwQzmBn/OURUFheRGdzw9yrk/TTIZ
	KVDCrNRl1v8S8LtfemWv3XtO2Nibh5qeoOJDx0H7hzPWqY6fXBLB21aJNO/trHwHpfgoyslWQqp
	ZcVVjHvhtwfXaKarxLqljBc4+tovSgad2RCWQlxjR5VumTXYPvXKIgIqF8DX9Kkx/ZWxFpb/DG7
	I87q199EJo1GY/58bRn4qKesKZ9UncBRpaObNhoOSPgAPFdboiRYtVA2mxr+mSXcIYtJzKly1Hv
	5rQabWLjPfh3vwX+Ov36/e4Q9Na6gsSX5hRgVpS+ScRnjVmDjKfgD1TvrnIBViGlD0yg+OwJGqx
	i9Zic/o/d4uL2hEn09C1w==
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id 5b1f17b1804b1-4891d7a463emr375839205e9.3.1777150259767;
        Sat, 25 Apr 2026 13:50:59 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm742194615e9.6.2026.04.25.13.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 13:50:59 -0700 (PDT)
Message-ID: <ec9b0035-f2a2-40b3-b29e-362f76c80e91@gmail.com>
Date: Sat, 25 Apr 2026 21:50:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Implement resizable hashmap basic
 functions
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: yatsenko@meta.com, emil@etsalapatis.com, martin.lau@kernel.org,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424-rhash-v3-1-d0fa0ce4379b@meta.com>
 <8168a9eb342bfdbe138aa31e7c07ea811e9ad4c413e15f5575a4874d2f4dca9e@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <8168a9eb342bfdbe138aa31e7c07ea811e9ad4c413e15f5575a4874d2f4dca9e@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 9:45 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index 3dd9b4924ae4..a37bd2a7b30f 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
> 
> [ ... ]
> 
>> +static int rhtab_map_check_btf(struct bpf_map *map, const struct btf *btf,
>> +			       const struct btf_type *key_type,
>> +			       const struct btf_type *value_type)
>> +{
>> +	struct bpf_rhtab *rhtab = container_of(map, struct bpf_rhtab, map);
>> +
>> +	return bpf_ma_set_dtor(map, &rhtab->ma, rhtab_mem_dtor);
>> +}
> 
> Does bpf_ma_set_dtor() exist at this commit?
> 
> A git-wide search shows no definition or declaration of bpf_ma_set_dtor().
> The kernel provides bpf_mem_alloc_set_dtor() with a 4-argument signature
> (ma, dtor, dtor_ctx_free, ctx) in include/linux/bpf_mem_alloc.h:
> 
>     int bpf_mem_alloc_set_dtor(struct bpf_mem_alloc *ma, dtor_fn dtor,
>                                dtor_ctx_fn dtor_ctx_free, void *ctx);
> 
> The existing htab_set_dtor() in kernel/bpf/hashtab.c builds a struct
> htab_btf_record context and calls bpf_mem_alloc_set_dtor() with all four
> arguments.
> 
> The new rhtab_map_check_btf() attempts to call a not-yet-existing helper
> with a 3-argument signature. This breaks compilation with 'implicit
> declaration of function "bpf_ma_set_dtor"' (fatal with kernel's
> -Werror=implicit-function-declaration) or link failure with 'undefined
> reference to bpf_ma_set_dtor'.
> 
> Looking at the later commit b3eef0fdafe1 ("bpf: Allow timers, workqueues
> and task_work in resizable hashtab"), it renames htab_set_dtor() to
> bpf_ma_set_dtor() and changes its signature to (map, ma, dtor), providing
> the missing symbol. That commit also wires up .map_check_btf =
> rhtab_map_check_btf in rhtab_map_ops.
> 
> Can this commit be reordered or squashed to avoid the forward reference
> and maintain bisectability?

this is right, this function should be added later, at the point of this
commit special fields are not supported, so this is not needed anyway.

> 
>> +static void rhtab_free_elem(void *ptr, void *arg)
>> +{
>> +	struct bpf_rhtab *rhtab = arg;
>> +	struct rhtab_elem *elem = ptr;
>> +
>> +	bpf_map_free_internal_structs(&rhtab->map, rhtab_elem_value(elem, rhtab->map.key_size));
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +}
> 
> [ ... ]
> 
>> +static int rhtab_delete_elem(struct bpf_rhtab *rhtab, struct rhtab_elem *elem)
>> +{
>> +	int err;
>> +
>> +	err = rhashtable_remove_fast(&rhtab->ht, &elem->node, rhtab->params);
>> +	if (err)
>> +		return err;
>> +
>> +	bpf_mem_cache_free_rcu(&rhtab->ma, elem);
>> +	return 0;
>> +}
> 
> Does rhtab_delete_elem() handle special fields properly?
> 
> Looking at the v2 review thread
> (https://lore.kernel.org/bpf/DHSBDLRKCAQO.1IPJTSEMPESV7@etsalapatis.com/),
> Emil Tsalapatis and sashiko raised concerns that special fields are not
> handled properly during in-place updates. The v3 changelog claims this was
> addressed, but rhtab_delete_elem() does not call
> bpf_map_free_internal_structs() before freeing the element.
> 
> This is inconsistent with rhtab_free_elem() which properly calls
> bpf_map_free_internal_structs(). Could this lead to resource leaks for
> maps with timers, workqueues, or other internal structures when elements
> are deleted via rhtab_map_delete_elem()?
> 
At this point special fields are not supported, the corresponding changes
are introduced in commit 5.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24909591959

