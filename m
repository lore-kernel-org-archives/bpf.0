Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411236;
	b=rG6ggcVJoN12UUR4mVzNNiWs5hSvW06KwgWLo0juSQfZ5rnghhRlRSNbrBUgJbVYAujT
	 Pt+bwiSmxSLncvOltau14f+P6vWU2IHkBDeBxCxm70ngyCOP5jijXboCHTZavMLEJApAn
	 sokw0V8XPQuzMwHO9j/GM8RRz4Cv5bCTFUVkSulTHrl6WoLYnlzYc0fuI6H/EZmuWtgnj
	 2yncb/fLkSys3cPcsRqBh3v1JVRQj0F6rcz+yfQ5nULc+uR9yqoEUuawEplz2PDUXvmke
	 hVlHfncWi+qc9dnA4lJYjtWsGsBZO7B7Khg5ruwRoC8jWS011AzaxL3d2FVaLO1jwKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411236;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/QzRHwbFkfbNnZOUmwpP9Tp3Pl7GSNdM2Tkd/OqZeso=;
	b=4gei2idA2asyz2vboi8y6z2yx0im4uEYhINN7NmVw6GrrCC2Zo7nIjPlkkMEBb6ZXM7n
	 jFt7xcifhsYyvEL9gtbzJIIUIkKtOEV0ob7iKtcn19skDDDRmRP2DKTOINKrKrrqBYM4X
	 Fx9whz7T1nGbq0D/rQwefWFFz/YKUO2Xfp+tjGEYHzSkytpr89Z1t9aM83v0ZyK642gBL
	 G95oqcfVKgUhqjOCWSvY1YxUpa98pokCZSGg4l8R+G0+MCP0DYg1tEiokkm7R1g6muIXa
	 0jupkRg+22RMNTzKn6GED7Ll4/El58TvpbL+8UbyaJd1D4MKPIEpwxwgAdYeDHj7p5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rUubxQ7f;
	arc=none smtp.remote-ip=91.218.175.69
Received: from mta0.migadu.com (out-69.mta0.migadu.com [91.218.175.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BF606A338
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76BF606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rUubxQ7f
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p8HknJLppCkWqal251xel/ZGyV7bFk2X8EESci1r2ec=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411233; v=1; x=1795016033;
 b=rUubxQ7fbkePxaLZ/tPw5HelOCQ35HVbgzV44leadVflYhVaEVjTSKrLXG6gsHEcmFEaIz+X
 kbJygjfpztvKDVgbNHu3I8WjxNev6K6rjGoVj5GV6nwBoyRT7MZ1PFAYhz9wMbEBVcruVD17HjO
 VQkhgtLUiTj0IuaAMyj5fA2s=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 31b42524a28fd5cd;
	Wed, 11 Nov 2026 15:33:53 +0000
X-Mizu-Trace-ID: 31b42524a28fd5cd
X-Migadu-Flow: FLOW_OUT
Message-ID: <4f3cc2e8-0c38-4350-9f3e-d652655c7b79@linux.dev>
Date: Wed, 11 Nov 2026 23:33:49 +0800
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
Subject: Re: [PATCH bpf-next 5/9] libbpf: Add log_opts support for
 BPF_TRACE_ITER
To: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
References: <20261109140816.5196-1-leon.hwang@linux.dev>
 <20261109140816.5196-6-leon.hwang@linux.dev>
 <sashiko-outbox-205120@kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <sashiko-outbox-205120@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issues to consider:
> - [Low] libbpf: missing OPTS_ZEROED() check for BPF_TRACE_ITER in
>   bpf_link_create()
> - [Low] libbpf: unreachable iter.len check in bpf_link_create()
> - [Low] libbpf: deprecated iter_info fields used in
>   bpf_program__attach_iter()
> --
> 
> commit 254d03820df80f0d29b270cec3be5cafe9178fe6
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> libbpf: Add log_opts support for BPF_TRACE_ITER
> 
> This commit adds iter.info and iter.len to struct bpf_link_create_opts so
> that BPF_TRACE_ITER link creation can pass iterator parameters alongside
> log_opts, while keeping the legacy iter_info and iter_info_len fields for
> callers that do not use log_opts.
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 38dcb31e8c0ed..174a8bfaf6638 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -808,11 +808,6 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  	if (iter_info_len && attach_type != BPF_TRACE_ITER)
>>  		return libbpf_err(-EINVAL);
>>  
>> -	if (iter_info_len)
>> -		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> -	else
>> -		log_opts = OPTS_GET(opts, log_opts, (void *)0);
>> -
>>  	/* validate we don't have unexpected combinations of non-zero fields */
>>  	if (iter_info_len || target_btf_id) {
>>  		if (iter_info_len && target_btf_id)
>> @@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  			return libbpf_err(-EINVAL);
>>  	}
>>  
>> +	if (iter_info_len) {
>> +		if (OPTS_GET(opts, iter.len, 0))
>> +			return libbpf_err(-EINVAL);
> 
> [Severity: Low]
> Can OPTS_GET(opts, iter.len, 0) ever be non-zero here?  When iter_info_len
> is set, the preceding if (iter_info_len || target_btf_id) block has already
> verified OPTS_ZEROED(opts, target_btf_id), which rejects any non-zero bytes
> in the union following target_btf_id, including opts->iter.
Agreed.

Will drop this iter.len check.

> 
>> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> +	} else {
>> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
>> +		iter_info = OPTS_GET(opts, iter.info, (void *)0);
>> +		iter_info_len = OPTS_GET(opts, iter.len, 0);
>> +	}
> 
> [Severity: Low]
> Should bpf_program__attach_iter() also be updated to populate
> link_create_opts.iter.info and link_create_opts.iter.len instead of the
> deprecated iter_info and iter_info_len fields?
> 
> tools/lib/bpf/libbpf.c:bpf_program__attach_iter() {
>     ...
> 	link_create_opts.iter_info = OPTS_GET(opts, link_info, (void *)0);
> 	link_create_opts.iter_info_len = OPTS_GET(opts, link_info_len, 0);
>     ...
> }
> 
> Because iter_info shares a union with log_opts, calling
> bpf_program__attach_iter() with link_info != NULL and link_info_len == 0
> causes bpf_link_create() to take the else branch above and dereference the
> union bpf_iter_link_info pointer as struct bpf_log_opts *log_opts in
> __sys_bpf_fd().
> 

Will update bpf_program__attach_iter() to use iter.info and iter.len in
the next revision. And, will add log_opts for bpf_program__attach_iter()
btw.

> [ ... ]
> 
>> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
>> index fe3b7fd8512bd..2ac143fd1102e 100644
>> --- a/tools/lib/bpf/bpf.h
>> +++ b/tools/lib/bpf/bpf.h
> 
> [ ... ]
> 
>> @@ -478,6 +482,10 @@ struct bpf_link_create_opts {
>>  			const __u64 *cookies;
>>  			__u32 cnt;
>>  		} tracing_multi;
>> +		struct {
>> +			union bpf_iter_link_info *info;
>> +			__u32 len;
>> +		} iter;
>>  	};
>>  	size_t :0;
>>  };
> 
> [Severity: Low]
> Does case BPF_TRACE_ITER in bpf_link_create() miss an OPTS_ZEROED(opts,
> iter) check?

Will add OPTS_ZEROED(opts, iter) check.

Thanks,
Leon

> 
> tools/lib/bpf/bpf.c:bpf_link_create() {
>     ...
> 	switch (attach_type) {
> 	case BPF_TRACE_ITER:
> 		attr.link_create.iter_info = ptr_to_u64(iter_info);
> 		attr.link_create.iter_info_len = iter_info_len;
> 		break;
>     ...
> }
> 
> When opts->iter is used (so iter_info_len and target_btf_id are 0),
> trailing bytes in the anonymous union after opts->iter overlapping larger
> members such as uprobe_multi are not checked for zero, unlike all other
> union members in the switch statement.  Also, opts->iter.info and
> opts->iter.len are read in the !iter_info_len branch even when attach_type
> is not BPF_TRACE_ITER.
> 

