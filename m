Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027305;
	b=maxUVe7FBKj8c8Kkk3RWs8DdkqQ71WWGb62+x9Gg8fL5CR3EalLSuqvgRR5PyM1NBvhd
	 85C4we0bVsnaxMV25yEpt8FE+fRkhDx2knJ0Qh/kAMsZ4wQxG/Ch1NL/B5mauffBTYI7Q
	 GPedd3Vp782arda0Qf6D/Dkhd4K+aKMGej6BAdoOus3StL4A9yUJWiNJcfNSTlJZy4oQt
	 nxsPtD6Fr/Vs4Qc2Z1FCZPt3VsKewhVrw2/y0Ck0EWgmpsqX2XkF2SUUUYyfnpPhtpigY
	 L8kw74X+om+q7Z04HhsijohKCVoUm0Lx0XcaW07otOHFZf837BHixHVK5Cp4MpcgBEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027305;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=HNreiUYcspl7YugOb0Db/eH9LRraTeCQh01ZdY4GdHw=;
	b=R0tkTbU5i13cOykq1ynCYFr5hZlRAC+egS5pELwhHE4W6WsH7nrG9VxEJAUOsfMcILsi
	 wZNojTFJC5BV2IVuxa10KCNZO4ys2e2J+Ra2yYuhROty9gKOUBv/hqmBaJQiVknM01uHa
	 rnnBgD3WrUjwY3fI1pZB8LU4mqUcH+cDSTjncuaE0+ZLNuRaWhH3s2i97lv3V1TIWhyyd
	 pJQ8hhvDpmhjJbSo6LNF1I3mi4h6WZ81FiLfrLdczzrcPVjAqKa0zEzdFC7cPckgZq7sf
	 7iP+0WU1tPbdGqIEegpc4gP9vYg0vbkuqZfcsmwEjIom397byZqwSjV3+FtqbjPL/7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mqgv+uND;
	arc=none smtp.remote-ip=95.215.58.31
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAE8606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EAE8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mqgv+uND
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9VzmVr+0UwIq+fSbTHVnNUIENIph+6m5EvRUd51Uhks=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793027302; v=1; x=1793632102;
 b=mqgv+uNDhDa7VLpcXMSKlCm5ju3tRUe+ULuZcHq2nGPh7G7+lPN79R8yhXrHVAW/Hfb5NMS1
 a0htzUy+yvsp7EbYPeNDOVl65tdvcAGykzypYmWOzAVM8JG9HmcSeOsR2BjgRUd029UBPxg8fxz
 pK085biBLSbOY7QO0nhdSzos=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id d747c137ff7b1668;
	Mon, 26 Oct 2026 15:08:22 +0000
X-Mizu-Trace-ID: d747c137ff7b1668
X-Migadu-Flow: FLOW_OUT
Message-ID: <8b2c8f88-d03b-4146-9bf7-95c4981ecacc@linux.dev>
Date: Mon, 26 Oct 2026 23:08:11 +0800
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
Subject: Re: [PATCH bpf-next v4 5/6] libbpf: Add log_opts support for
 bpf_link_create
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, shuah@kernel.org, kuniyu@google.com,
 liuhangbin@gmail.com, mkarsten@uwaterloo.ca, masashi.honma@gmail.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261024153608.58569-6-leon.hwang@linux.dev>
 <c6da6df95673d3a5ab5c4e757500658821e9e9e8d0652f737eca82690765a9a8@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c6da6df95673d3a5ab5c4e757500658821e9e9e8d0652f737eca82690765a9a8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/25 00:13, bot+bpf-ci@kernel.org wrote:
>> libbpf: Add log_opts support for bpf_link_create
> 
> TL;DR: In bpf_link_create(), the shared iter_info/log_opts slot is keyed only
> on iter_info_len, so an iter_info pointer with len 0 may be misread as
> log_opts, possibly causing out-of-bounds reads/writes in libbpf.
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index 9a2107d4f6d8..00efa90a6ed9 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> 
> [ ... ]
> 
>> @@ -803,6 +805,14 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  	iter_info_len = OPTS_GET(opts, iter_info_len, 0);
>>  	target_btf_id = OPTS_GET(opts, target_btf_id, 0);
>>  
>> +	if (iter_info_len && attach_type != BPF_TRACE_ITER)
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (iter_info_len)
>> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> +	else
>> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
>> +
>>  	/* validate we don't have unexpected combinations of non-zero fields */
>>  	if (iter_info_len || target_btf_id) {
>>  		if (iter_info_len && target_btf_id)
> 
> For BPF_TRACE_ITER, iter_info_len is now the only thing that decides whether
> the shared iter_info/log_opts slot holds a union bpf_iter_link_info pointer
> or a struct bpf_log_opts pointer.
> 
> Can a caller that sets opts->iter_info but leaves opts->iter_info_len at 0
> end up with its union bpf_iter_link_info being read as a struct
> bpf_log_opts here?

Users should not do like this. By convention, iter_info_len==0 means no
iter_info.

> 
> bpf_program__attach_iter() copies opts->link_info into
> link_create_opts.iter_info and opts->link_info_len into iter_info_len
> without checking that they agree, and nothing in bpf.h or libbpf.h says
> log_opts is only used when iter_info_len == 0, or that iter_info needs
> iter_info_len.
> 
> Before this patch the pointer went to the kernel, and bpf_iter_link_attach()
> rejected the mismatch cleanly:
> 
>     if (bpfptr_is_null(ulinfo) ^ !linfo_len)
>         return -EINVAL;
> 
> With this patch, __sys_bpf_fd() runs OPTS_VALID(log_opts, bpf_log_opts) on
> the 16-byte union bpf_iter_link_info.  The first 8 bytes of that union
> (map.map_fd, or task.tid/pid, or cgroup.order/cgroup_fd) become
> log_opts->sz:
> 
> - If map_fd or tid is in the range 8..27, sz passes validation, and size and
>   level are read from bytes 16..24, which lie past the end of the 16-byte
>   object.
> 
> - If sz is 28 to 31, OPTS_HAS(log_opts, true_size) is true, so
>   OPTS_SET(log_opts, true_size, ...) writes 4 bytes at offset 24, which is 8
>   bytes past the end of the caller's object.  Can this corrupt the caller's
>   stack or heap?
> 
> - If sz is larger (a typical tid, or a cgroup fd shifted into the high 32
>   bits), libbpf_is_mem_zeroed() scans caller memory from offset 28 up to sz.
>   It usually stops with a "bpf_log_opts has non-zero extra bytes" warning,
>   but it reads out of bounds first.
> 
> In addition, attr.link_create.iter_info is now NULL with iter_info_len of 0,
> which the kernel accepts.  If validation does pass, could a task iterator
> attach to all tasks instead of the requested tid, and a map iterator fail
> with -EBADF instead of -EINVAL?
> 
> The commit message says log_opts support for iter links is future work.
> Would it be better to treat the slot as iter_info whenever
> attach_type == BPF_TRACE_ITER, and read log_opts only for other attach
> types, instead of keying only on iter_info_len?  That would keep the old
> behaviour for iter links exactly.

Not exactly. iter_info and iter_info_len must be set at the same time
for iter links. If iter_info_len is 0, iter_info must be NULL or zeroed
memory. Users must not misuse them by iter_info_len==0 but iter_info is
not zeroed memory.

Thanks,
Leon

