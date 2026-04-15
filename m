Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA136CE06
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251726; cv=none; b=TshV3/d9qA+b6SWeRtOd4pD9k59ZTJIHw9P2hMxbw6CIdxGLVgSGM4H8Zi/OxfzyK2DZ83dkseETdyfVSs4IwG4mMc1GO4fHWEJF/25WTZ/c6/RkUF4ZroGPt6oM4893pyB5P3M6JtWtoBmj32mnlhx9iiAVOB8kBPWSvra3OP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251726; c=relaxed/simple;
	bh=QRW4cFrbMQspnR5bFc+E5SlCvH1Q4q2xLEWb48Z62h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/0k6rFpP9idQXt6PjKd73YKxmosE0UsYGSsjlHX8QMTl/wjlaZsCib7ciwglYXk/nh28VscdgPzTbd7WKrlqt6leWyfMYhczEj12rG8b2faGPNPr52Fhybjtq3j+bwA50HBExyCBqa/NywWeQw5R7KQ9J51H9566yAkpWVOJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rjLbmHSs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjLbmHSs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d734223e4so2266457f8f.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 04:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251723; x=1776856523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0qX3fctM8OielX4qujxT2g876ufFYUQ7wZPzGv2NyI=;
        b=rjLbmHSsAQETibOQAFN73CDvB6+n9Iuvgwnbxyg+36+J8yAtMaa1n48J48QojDULE1
         HcZZ2g3nswi4Z58aAwovinzhpaKibAcEpY/UvWPCQ4Hgfp+Do409unZRoXgDsC8dQkmF
         w66yloIYJiPbc13JPOyGDlSOY0bzypYFSjXolcvZsJ3tUCeVJFJ5Iu/z0Bo3UH/nvHVC
         KUTiiFlLYvTo7m0EOIo8FV5mXI7SYYPOlmV6VempSbfFsWgDpB/nH5o03bCVP+HrKkMI
         8rUv2dG/aY4rH/BFHYZaH1VBGpbFucKJHr/k84jo4EI5L5jKnH5A+EsjLIBTxVVkrnvt
         deJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251723; x=1776856523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0qX3fctM8OielX4qujxT2g876ufFYUQ7wZPzGv2NyI=;
        b=WGkhKGRo+LyeI3FNsyOvkSMbqhkQgJym5Wx6q364GSNK8YJS12Q6026ayVUoxr77hL
         9OXA8s7OLkmxsvwK0JGntqDniPyFeZMw0a/oNcKGWPkzkGZieIz+tji3HR25ingFdHGX
         aByQbjGnvq1btO+RbqbVXzmbvpCBRLl68Rwal0S83wiKen+71mEUptc1TkC9ny88fGqx
         c/nfDCWH1OVTBj+S8Hs8FUTxOj7d75yhGKphtmPVG4IUbepTEOOKHJ13q1btEGuqKiLm
         AUKHc4OqpMWsvlgPlVY8zbGrbEny4sexVx2dPPZvg+ExQgLcmL4NKlI3c5+vznbxRdkF
         I1og==
X-Forwarded-Encrypted: i=1; AFNElJ8ZsSR4sFn2+aDbd99NyJIXDWqS1I/MJHpcP0t/jzTHTcfbh5zsOULmVcXDulApIVmEbRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywalyl3cNFO/h2CUGtiCCWZ1WA9vOofxQ9sYjMdP5kTF6XmNeHh
	wmk3HmwJTDXUviUX5EQC9z5z2BnlsQu7alX4N+NFZhbpNf8dLjTU2OCs
X-Gm-Gg: AeBDiev//y2P8uq36kJQ7dq8gKDXfPMZsINSpd4S9HbuRL1+D/B+/MJVM/nVjjML3hW
	7YT0fjxPdzvgx0BsLy4iXmYduC9DR9WlNj4IlpkmsFIAOL0CaAP7MDodb8EPRyygqUzvZT2gIqA
	/VzGz2SgdcUT2RaaIjt7sQDgLekimMAdnOizS+xWpAMu0gEESK6sT+ZMVd11krcVStiWy480GxY
	W8xiu/h78xGxtDIS3i8yrgzPojBvHAapTQK+LceoMI/PRSLP2rs6pbiRSyLH6vP50dzT1iOp4ZE
	jgclAgB+GbjmL6hU5n/2DngXRBFVRrvM+nswMg2qyyGBGkuqYOuwV4eWsb3RVGb/vZGM71Lp5+4
	a+sQSNbl7eAr77NEA6nCscKpXySIcHXPqzatczFvAOIZq5xgx5LLheN+Ip4kEt/oAZyU+kNjZUS
	r2S1+iHjn4vUTxyGN4PoERQxeNiCgIudctcOvU+RQccIoQkm5q3tkMxCK0dYos
X-Received: by 2002:a05:6000:2804:b0:43b:9d69:43a with SMTP id ffacd0b85a97d-43d5957372dmr24763925f8f.8.1776251722833;
        Wed, 15 Apr 2026 04:15:22 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:cbe8:6434:118f:886d? ([2620:10d:c092:500::5:3ecd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3fd3b7sm4842013f8f.35.2026.04.15.04.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 04:15:22 -0700 (PDT)
Message-ID: <c817ff57-c555-4057-9824-6980a1029fc0@gmail.com>
Date: Wed, 15 Apr 2026 12:15:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next v2 08/18] bpf: Implement iterator APIs for
 resizable hashtab
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, eddyz87@gmail.com, memxor@gmail.com,
 herbert@gondor.apana.org.au
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20260408-rhash-v2-0-3b3675da1f6e@meta.com>
 <20260408-rhash-v2-8-3b3675da1f6e@meta.com>
 <DHT2G66ICGQ6.QY3NGX24ZE12@etsalapatis.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <DHT2G66ICGQ6.QY3NGX24ZE12@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/14/26 6:49 PM, Emil Tsalapatis wrote:
> On Wed Apr 8, 2026 at 11:10 AM EDT, Mykyta Yatsenko wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Wire up seq_file BPF iterator for BPF_MAP_TYPE_RHASH so that
>> bpf_iter and bpftool map dump work with resizable hash maps.
>>
>> Use rhashtable_walk_enter_from() with a saved last_key to resume
>> iteration across read() calls without linear skip from the
>> beginning on each seq_start.
>>
>> Also implement rhtab_map_seq_show_elem() for bpftool map dump
>> in non-iterator mode.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> 
>> ---
>>   kernel/bpf/hashtab.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 94 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
>> index a79d434dc626..492c6a9154b6 100644
>> --- a/kernel/bpf/hashtab.c
>> +++ b/kernel/bpf/hashtab.c
>> @@ -3008,6 +3008,19 @@ static int rhtab_map_get_next_key(struct bpf_map *map, void *key, void *next_key
>>   
>>   static void rhtab_map_seq_show_elem(struct bpf_map *map, void *key, struct seq_file *m)
>>   {
>> +	void *value;
>> +
>> +	/* Guarantee that hashtab value is not freed */
>> +	guard(rcu)();
>> +
>> +	value = rhtab_map_lookup_elem(map, key);
>> +	if (!value)
>> +		return;
>> +
>> +	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
>> +	seq_puts(m, ": ");
>> +	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
>> +	seq_putc(m, '\n');
>>   }
>>   
>>   static long bpf_each_rhash_elem(struct bpf_map *map, bpf_callback_t callback_fn,
>> @@ -3201,36 +3214,113 @@ struct bpf_iter_seq_rhash_map_info {
>>   	struct bpf_map *map;
>>   	struct bpf_rhtab *rhtab;
>>   	struct rhashtable_iter iter;
>> -	u32 skip_elems;
>> +	void *last_key;
> 
> Nit: Could we avoid adding skip_elems to this in the first place since
> it's never used?
> 

Definitely yes, thanks for noticing.

>>   	bool iter_active;
>>   };
>>   
> 
> Question: Would it make sense/be worth annotating the seq functions with
> __acquires/__releases(RCU)?
> 

I guess it won't hurt.

>>   static void *bpf_rhash_map_seq_start(struct seq_file *seq, loff_t *pos)
>>   {
>> -	return NULL;
>> +	struct bpf_iter_seq_rhash_map_info *info = seq->private;
>> +	struct rhtab_elem *elem;
>> +	void *key = *pos > 0 ? info->last_key : NULL;
>> +
>> +	scoped_guard(rcu) {
>> +		rhashtable_walk_enter_from(&info->rhtab->ht, &info->iter,
>> +					   key, info->rhtab->params);
>> +		rhashtable_walk_start(&info->iter);
>> +	}
>> +	info->iter_active = true;
>> +
>> +	elem = rhtab_iter_next(&info->iter);
>> +	if (!elem)
>> +		return NULL;
>> +	/*
>> +	 * if *pos is not 0, previously iteration failed on this elem,
>> +	 * so we are restarting it. That's why no need to increment *pos.
>> +	 */
>> +	if (*pos == 0)
>> +		++*pos;
>> +	return elem;
>>   }
>>   
>>   static void *bpf_rhash_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
>>   {
>> -	return NULL;
>> +	struct bpf_iter_seq_rhash_map_info *info = seq->private;
>> +	struct rhtab_elem *elem = v;
>> +
>> +	/* Save current key for O(1) resume in next seq_start */
>> +	memcpy(info->last_key, elem->data, info->map->key_size);
>> +
>> +	++*pos;
>> +
>> +	return rhtab_iter_next(&info->iter);
>> +}
>> +
>> +static int __bpf_rhash_map_seq_show(struct seq_file *seq,
>> +				    struct rhtab_elem *elem)
>> +{
>> +	struct bpf_iter_seq_rhash_map_info *info = seq->private;
>> +	struct bpf_iter__bpf_map_elem ctx = {};
>> +	struct bpf_iter_meta meta;
>> +	struct bpf_prog *prog;
>> +	int ret = 0;
>> +
>> +	meta.seq = seq;
>> +	prog = bpf_iter_get_info(&meta, elem == NULL);
>> +	if (prog) {
>> +		ctx.meta = &meta;
>> +		ctx.map = info->map;
>> +		if (elem) {
>> +			ctx.key = elem->data;
>> +			ctx.value = rhtab_elem_value(elem, info->map->key_size);
>> +		}
>> +		ret = bpf_iter_run_prog(prog, &ctx);
>> +	}
>> +
>> +	return ret;
>>   }
>>   
>>   static int bpf_rhash_map_seq_show(struct seq_file *seq, void *v)
>>   {
>> -	return 0;
>> +	return __bpf_rhash_map_seq_show(seq, v);
>>   }
>>   
>>   static void bpf_rhash_map_seq_stop(struct seq_file *seq, void *v)
>>   {
>> +	struct bpf_iter_seq_rhash_map_info *info = seq->private;
>> +
>> +	if (!v)
>> +		(void)__bpf_rhash_map_seq_show(seq, NULL);
>> +
>> +	if (info->iter_active) {
>> +		rhashtable_walk_stop(&info->iter);
>> +		rhashtable_walk_exit(&info->iter);
>> +		info->iter_active = false;
>> +	}
>>   }
>>   
>>   static int bpf_iter_init_rhash_map(void *priv_data, struct bpf_iter_aux_info *aux)
>>   {
>> +	struct bpf_iter_seq_rhash_map_info *info = priv_data;
>> +	struct bpf_map *map = aux->map;
>> +
>> +	info->last_key = kmalloc(map->key_size, GFP_USER);
>> +	if (!info->last_key)
>> +		return -ENOMEM;
>> +
>> +	bpf_map_inc_with_uref(map);
>> +	info->map = map;
>> +	info->rhtab = container_of(map, struct bpf_rhtab, map);
>> +	info->iter_active = false;
>>   	return 0;
>>   }
>>   
>>   static void bpf_iter_fini_rhash_map(void *priv_data)
>>   {
>> +	struct bpf_iter_seq_rhash_map_info *info = priv_data;
>> +
>> +	kfree(info->last_key);
>> +	bpf_map_put_with_uref(info->map);
>>   }
>>   
>>   static const struct seq_operations bpf_rhash_map_seq_ops = {
> 

