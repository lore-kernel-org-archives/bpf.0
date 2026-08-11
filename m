Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FA03BF665
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786428782; cv=none; b=Uq8YCRj8jbWQDZJ1pWkDV3iGGxJJmlq75evFvl2j6MgnZrhNQQymxB5pE+WK7khWKYzFstzh2Uaw78MRON2fHPrE6LzgUl+zHzG9Bw7uAm/CE9AQn8Umy91f0fbe1ikVPr74jlb9fJ+2btwys5xfy5iShwgvZmdMazGIrIHk9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786428782; c=relaxed/simple;
	bh=lkiMx7uA/A5/aSn1bsWFGNt11TcSrA6IVEQGhDwO9+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdAsVaTZNdpHvQv20awBdPt0VHu2tnABGl8ZkwIjFU1m6adsYdbpj0M2t5AoUunXaAoz7cAhYY+Y79r0EGjm8Fbnj5iiWF4nlzGbmNU9flD8OIzHCya5tJ+gwIUqYJtGeHf7ku888FuhW0YQ6KCUclHl3wUMLqxPqooH4Ch3eZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gh5bmr7a; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gh5bmr7a"
Message-ID: <0a2fc4c0-db9e-4b53-8232-aeb0dda112b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786428767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogf+73rRak/6Js/7MzR2OgNYsxkzJu6wOHRliPqhoyU=;
	b=gh5bmr7aHa3c+DIMKyoVCuJ/lCW6Gomgq7WERSM2AdMXYoKnziX2JRdRGRwYTHP7Gt1gJ3
	/8mvD0SUFuI0QkU6Vv6j6rLjIcsBzUfzhaM4W6wSt6T2SqQqMkvlCxqiqfFk3KImDN+rNs
	bS+igK7ntBtS1upZv8vmma7ZSM6WuOA=
Date: Tue, 11 Aug 2026 14:12:31 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/13] bpf: Add tracing_multi link support for
 bpf progs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin Monnet <qmo@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
 Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
 Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
 Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-5-leon.hwang@linux.dev> <annOhedRtHBce3px@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <annOhedRtHBce3px@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/26 21:13, Jiri Olsa wrote:
> On Sun, Aug 09, 2026 at 11:01:02PM +0800, Leon Hwang wrote:
> 
> SNIP
> 
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> index eddd259d3776..fc51ea2428be 100644
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
>> @@ -1572,12 +1572,23 @@ static int update_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags,
>>  			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
>>  			       struct bpf_tracing_multi_data *data)
>>  {
>> -	unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
>> +	if (tr->func.ftrace_managed) {
>> +		unsigned long addr = (unsigned long)(im ? im->image : tr->cur_image->image);
>>  
>> -	if (bpf_trampoline_use_jmp(tr->flags))
>> -		addr = ftrace_jmp_set(addr);
>> +		if (bpf_trampoline_use_jmp(tr->flags))
>> +			addr = ftrace_jmp_set(addr);
>> +
>> +		ftrace_hash_add(hash, data->entry, tr->ip, addr);
>> +	} else {
>> +		void *old_addr = tr->cur_image ? tr->cur_image->image : NULL;
>> +		void *new_addr = im ? im->image : NULL;
>> +		int ret;
>> +
>> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, new_addr);
>> +		if (ret)
>> +			return ret;
>> +	}
> 
> hum, so IIUC this sequentially attaches to target bpf program as it
> would with current API, so there's no attachent speedup, right?


Correct.

> 
>>  
>> -	ftrace_hash_add(hash, data->entry, tr->ip, addr);
>>  	tr->cur_image = im;
>>  	return 0;
>>  }
>> @@ -1627,6 +1638,18 @@ static void bpf_trampoline_multi_attach_free(struct bpf_trampoline *tr)
>>  
>>  static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
>>  {
>> +	if (!tr->func.ftrace_managed) {
>> +		void *failed_addr = tr->cur_image ? tr->cur_image->image : NULL;
>> +		void *old_addr = tr->multi_attach.old_image ?
>> +				 tr->multi_attach.old_image->image : NULL;
>> +		u32 orig_flags = tr->flags;
>> +		int ret;
>> +
>> +		tr->flags = tr->multi_attach.old_flags;
>> +		ret = bpf_trampoline_update_fentry(tr, orig_flags, failed_addr, old_addr);
>> +		WARN_ONCE(ret, "bpf_trampoline_update_fentry failed: %d\n", ret);
>> +	}
>> +
>>  	if (tr->cur_image)
>>  		bpf_tramp_image_put(tr->cur_image);
>>  	tr->cur_image = tr->multi_attach.old_image;
>> @@ -1643,6 +1666,7 @@ static void bpf_trampoline_multi_attach_rollback(struct bpf_trampoline *tr)
>>  	for_each_mnode_cnt(mnode, link, link->nodes_cnt)
>>  
>>  int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>> +				u64 *keys, struct bpf_prog **progs,
>>  				struct bpf_tracing_multi_link *link)
>>  {
>>  	struct bpf_tracing_multi_data *data = &link->data;
>> @@ -1651,18 +1675,18 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>>  	struct bpf_tracing_multi_node *mnode;
>>  	struct bpf_trampoline *tr;
>>  	int i, err, rollback_cnt;
>> -	u64 key;
>>  
>>  	for_each_mnode(mnode, link) {
>>  		rollback_cnt = i;
>>  
>> -		err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
>> +		if (progs)
>> +			err = bpf_check_attach_target(NULL, prog, progs[i], ids[i], &tgt_info);
>> +		else
>> +			err = bpf_check_attach_btf_id_multi(btf, prog, ids[i], &tgt_info);
>>  		if (err)
>>  			goto rollback_put;
>>  
>> -		key = bpf_trampoline_compute_key(NULL, btf, ids[i]);
>> -
>> -		tr = bpf_trampoline_get(key, &tgt_info);
>> +		tr = bpf_trampoline_get(keys[i], &tgt_info);
>>  		if (!tr) {
>>  			err = -ENOMEM;
>>  			goto rollback_put;
>> @@ -1691,6 +1715,9 @@ int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
>>  	for_each_mnode(mnode, link) {
>>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
>>  
>> +		if (progs && progs[i]->aux->tail_call_reachable)
>> +			mnode->trampoline->flags |= BPF_TRAMP_F_TAIL_CALL_CTX;
>> +
>>  		data->entry = &mnode->entry;
>>  		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
>>  						 &trampoline_multi_ops, data);
> 
> IIUC for bpf_program targets the actuall attachment is happening in
> here, right?


Right.

> 
> the rest of the function logic won't execute, because there won't
> be any data in the reg/noreg/mod hashes..?
> 
> you seem to use the tracing_multi API to ease up attachment to multiple
> bpf programs and end up with just single link fd for all attachments
> 
> I think it'd be cleaner to have separate api or code paths for that
> 


Makes sense.

I'd like to use the same UAPI, and re-implement it with another code
path, mainly in trampoline.c. And, the re-implementation will get rid of
HAVE_SINGLE_FTRACE_DIRECT_OPS for targeting bpf progs at the same time.

Then, I think I can speed up the attachment using text-poke in batch on
x86_64.

Thanks,
Leon

