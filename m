Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9484A383323
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507505; cv=none; b=TkQKhePNWSmEjY6+m75M6bE6olDKi63qlF0dHcYy61+S5Pa4AuogiJTbfqLmqnRjUo+RL9YXq1UzKE0y2wYX0pvSlUgnGZZvHMGU5h2HJ+tugQCHXqJol1qPYwlUmA8cmsHAQh5MyIpTNb2rsc1rSmuCw41O3kzUfmvhDwg814A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507505; c=relaxed/simple;
	bh=/YZeZwwFa5TpuUOSd/UoIZuT/s/ltTcBxeK9N3tzamw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUQOXk9HzSTzQzbqju3reYVMadI7ZeCY1HMPEOlL5dV36rcr6zRb2n6BRq9YX3UMI4VTza4S2gwTu5yRyl7C36wLrJN7j49ZiZVHF6JWvnkQ0fKxgI2y+O1X5gR4kyonmdubFv030Ed25KVeZYRsTZMCA+dh19URYNu85P72BlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X7QxQXIj; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X7QxQXIj"
Message-ID: <11079006-dc15-4474-bd35-a8386b42d34f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786507500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DcwB1fUEJ4620xXoPomLg/qv9ihwgzgXsYTlPEqa/8=;
	b=X7QxQXIj7DgxQVB/lhL7xRYIFBynStEzLeTq9JKpbKlfNHkhr/Rm/eCTNYVyCmuoD1L7o1
	6S4l+w5mj9I46Z2Um/DHfWuyLHI2FZ/kNyITdJgWLP7y8kc8h8HCvlRu0ceK4NZX5gdGp5
	fMQwzyVEk6u1hMEl6CegmrKCNr7gixQ=
Date: Wed, 12 Aug 2026 12:04:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 06/13] bpf: Add tracing_multi link fdinfo support
 for bpf progs
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 qmo@kernel.org, shuah@kernel.org, yatsenko@meta.com,
 avinash.duduskar@gmail.com, a.s.protopopov@gmail.com, ameryhung@gmail.com,
 jordan@jrife.io, rongtao@cestc.cn, eyal.birger@gmail.com,
 pulehui@huawei.com, tanjingguo@huawei.com, malin89@huawei.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260809150111.45000-7-leon.hwang@linux.dev>
 <f227b719d241d4cc87954725d9ddaab8377c9991c7b6b03aaef4aa5d098fcca7@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <f227b719d241d4cc87954725d9ddaab8377c9991c7b6b03aaef4aa5d098fcca7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/8/26 00:20, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index a805a5b73303f..80928401830c7 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -3759,26 +3759,46 @@ static int bpf_tracing_multi_link_fill_link_info(const struct bpf_link *link,
>>  }
>>
>>  #ifdef CONFIG_PROC_FS
>> +static const char *bpf_prog_func_name(struct bpf_prog *prog, u32 btf_id)
>> +{
>> +	const struct btf *btf = prog->aux->btf;
>> +	const struct btf_type *t;
>> +
>> +	t = btf_type_by_id(btf, btf_id);
>> +	if (!t || !btf_type_is_func(t))
>> +		return "";
>> +
>> +	return btf_name_by_offset(btf, t->name_off);
>> +}
>> +
>>  static void bpf_tracing_multi_show_fdinfo(const struct bpf_link *link,
>>  					  struct seq_file *seq)
>>  {
>>  	struct bpf_tracing_multi_link *tr_link =
>>  		container_of(link, struct bpf_tracing_multi_link, link);
>>  	bool has_cookies = !!tr_link->cookies;
>> +	bool has_progs = !!tr_link->progs;
>>
>>  	seq_printf(seq, "attach_type:\t%u\n", tr_link->link.attach_type);
>>  	seq_printf(seq, "cnt:\t%u\n", tr_link->nodes_cnt);
>>
>> -	seq_printf(seq, "%s\t %s\t %s\t %s\n", "obj-id", "btf-id", "cookie", "func");
>> +	seq_printf(seq, "%s\t %s\t %s\t %s\n", has_progs ? "prog-id" : "obj-id", "btf-id", "cookie",
>> +		   "func");
>>  	for (int i = 0; i < tr_link->nodes_cnt; i++) {
>>  		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
>> +		u64 cookie = has_cookies ? tr_link->cookies[i] : 0;
>>  		u32 btf_id, obj_id;
>>
>>  		bpf_trampoline_unpack_key(mnode->trampoline->key, &obj_id, &btf_id);
>> +		btf_id = has_progs ? (u32) mnode->trampoline->key : btf_id;
>                         ^^^^
> 
> This isn't a bug, but since bpf_trampoline_unpack_key() only masks off
> bit 31, which is never set for prog targets, does this re-assignment
> change anything, or could the unpacked value be used directly?
> 
> bpf_trampoline_unpack_key() already sets btf_id = key & 0x7FFFFFFF, and
> bit 31 is only set by the !tgt_prog branch of bpf_trampoline_compute_key()
> (the kernel-BTF case).
> 
> In the has_progs case the key was built as:
> 
>     ((u64)tgt_prog->aux->id << 32) | ids[i]
> 
> and ids[i] must be a valid BTF type id (<= BTF_MAX_TYPE, 0xfffff) or
> bpf_check_attach_target() would have rejected the attach, so (u32)key
> and the unpacked btf_id are always equal here.
> 

Good catch.

Will drop this line.

>> +		if (has_progs)
>> +			seq_printf(seq, "%u\t %u\t %llu\t %s\n",
>> +				   obj_id, btf_id, cookie,
>> +				   bpf_prog_func_name(tr_link->progs[i], btf_id));
>> +		else
>> +			seq_printf(seq, "%u\t %u\t %llu\t %pS\n",
>> +				   obj_id, btf_id, cookie,
>> +				   (void *) mnode->trampoline->ip);
>>
>>  		cond_resched();
>>  	}
> 
> The commit message shows the sample fdinfo output but doesn't say much
> about the implementation or why this change is needed. In particular:
> 
>> Show the target bpf prog info in the fdinfo.
>>
>> $ cat /proc/self/fdinfo/13
>> pos:    0
>> flags:  02000000
>> mnt_id: 18
>> ino:    1045
>> link_type:      tracing_multi
>> link_id:        9
>> prog_tag:       9a7f9e3ab6f138ab
>> prog_id:        25
>> attach_type:    61
>> cnt:    2
>> prog-id  btf-id  cookie  func
>> 21       4       16706819        target_1
>> 22       5       16706819        target_2
> 
> This isn't a bug, but could the changelog say why the trampoline ip is
> not usable as the func column for prog targets (tr->ip is 0 for JIT'd
> prog addresses), rather than mostly showing the resulting output? It
> also doesn't mention that the first column header changes from "obj-id"
> to "prog-id" for prog-target links.
> 

Hmm, will describe the change in the commit msg.

Thanks,
Leon

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31320427087

