Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411185;
	b=ogGvGpAAqJVb4pSEEfYIydaKHfvOLFxFpYmSGFHvoYGwJ27c6vJs7/nRVlDNkeeJnP2k
	 WF06CJ98eTe7ab/dCHH6l4WVc1eJC65wRoHLF1hnV0suV6JN2DAYagHGKMZP8sG/AG2zV
	 MUz6/sb1/5AqzTjZmGJ8EFrj6iiDvk1Cb2RP9AkaoMqEURXN5qbBav9BoSDmzgcju9jJA
	 odzEw0/vzy2Rvd+YfYQROmgJEaL/Sg6tkI7+FaA4ySiHKAxmx19OekoaDjklndLNfAVQB
	 cIUSke/zQnuNGxWJIyVJiEp2vlIbirqo9PmMIQT6cUsmC1bdukVPiW33Vo2uYOLaoeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411185;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EGBcdLyH+qWtPFF9G1WLyu068WqshojAGB+pBC2wncc=;
	b=SrczqYJgAaSRmd3HkpO6R6U6ZMtF3/GSbtYYl4bZzR56qHo5cFjj0p/wM3/Y1bqI0w7q
	 WSsk3zISCidToJwuABvmXNQ3d1yi4Fr6t1YqUrPCzNB0TTFarMKFlJVBiO+ZyKd9AkOsd
	 zaDsyQAn8Dvvtx2QZfxvLUGllSZDjQmOeiP7PUI2jhGCrvM4Kiw3fXC9/JmYF4AK2U/71
	 oaIqM33KZQZ+PyCY5wwkZFbRx+VviHYaeTaRW5GJAQJCtnlXZ+xNO2pjyIB/j/u7ijqYw
	 NCH00a93ZMmz1Ri9Emy/yd7oThA7N2W94Is1AfBJ9hDFbL0Ub6zDVwDddW3EkNwALgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r6lIrVDX;
	arc=none smtp.remote-ip=91.218.175.36
Received: from mta0.migadu.com (out-36.mta0.migadu.com [91.218.175.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697C606A321
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C697C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=r6lIrVDX
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FYJ5fe5bszWYbPmBUf7pMhzfw1+piK655vw2zkho3KU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411182; v=1; x=1795015982;
 b=r6lIrVDXEIUZJTnUNuZTPE7lGAWD2MIPP3OW59q/JwEaQWADpn8lVr8bZ9pwTV0xillFj7i8
 HCvMH0w1q/anKLrXgcpdvD8hzpDR0KSSPSrticAHTg5XHqbkZPNBWO7wJfz10mHaBcBITf7V9Ym
 nJa39wKvGNWH9Zr9IeC0/nwM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e7ccb356486f714d;
	Wed, 11 Nov 2026 15:33:02 +0000
X-Mizu-Trace-ID: e7ccb356486f714d
X-Migadu-Flow: FLOW_OUT
Message-ID: <ab4e5c29-b835-4ea8-853b-57ae7ad2eafe@linux.dev>
Date: Wed, 11 Nov 2026 23:32:50 +0800
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
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 kpsingh@kernel.org, matt@bobrowski.net, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20261109140816.5196-6-leon.hwang@linux.dev>
 <8b9e5217cbe9c192e678ce5c8d59f573c80a659d72211f5b91c905ed00ebb799@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <8b9e5217cbe9c192e678ce5c8d59f573c80a659d72211f5b91c905ed00ebb799@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/9 22:47, bot+bpf-ci@kernel.org wrote:
>> libbpf: Add log_opts support for BPF_TRACE_ITER
> 
> TL;DR:
> - libbpf BPF_TRACE_ITER case may not reject stray bytes after iter.len
>   (missing OPTS_ZEROED check), so unknown fields could be silently ignored
> - Nit: iter.len test in the legacy branch looks like dead code
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
> 
> [ ... ]
> 
>> @@ -821,6 +816,16 @@ int bpf_link_create(int prog_fd, int target_fd,
>>  			return libbpf_err(-EINVAL);
>>  	}
>>  
>> +	if (iter_info_len) {
>> +		if (OPTS_GET(opts, iter.len, 0))
>> +			return libbpf_err(-EINVAL);
>> +		iter_info = OPTS_GET(opts, iter_info, (void *)0);
>> +	} else {
>> +		log_opts = OPTS_GET(opts, log_opts, (void *)0);
>> +		iter_info = OPTS_GET(opts, iter.info, (void *)0);
>> +		iter_info_len = OPTS_GET(opts, iter.len, 0);
>> +	}
>> +
> 
> When the legacy iter_info_len is non-zero, the check above already requires
> OPTS_ZEROED(opts, target_btf_id), which covers every byte from that offset
> up to sz, including iter.info and iter.len.  Can this OPTS_GET(opts,
> iter.len, 0) test ever be true?  It looks like dead code.
> 

Will drop the iter.len check.

> [ ... ]
> 
>>  	switch (attach_type) {
>>  	case BPF_TRACE_ITER:
>>  		attr.link_create.iter_info = ptr_to_u64(iter_info);
>>  		attr.link_create.iter_info_len = iter_info_len;
>>  		break;
> 
> Every other union member's case ends with a check such as:
> 
>     if (!OPTS_ZEROED(opts, tracing_multi))
>             return libbpf_err(-EINVAL);
> 
> Should the BPF_TRACE_ITER case do the same with OPTS_ZEROED(opts, iter)?

Will add OPTS_ZEROED(opts, iter) check.

Thanks,
Leon

> 
> On the new iter.info/iter.len path, nothing checks the bytes after iter.len.
> A caller that sets opts.iter.info, opts.iter.len and opts.tracing_multi.cnt
> gets the stray field silently ignored instead of -EINVAL.  Likewise, a
> later field added to the iter struct after len, built against newer
> headers, would be silently dropped by this libbpf because sz still equals
> sizeof() and OPTS_VALID() cannot see it.
> 
> Legacy callers would be unaffected, since their union is already zero, and
> the iter.len test in the legacy branch could then be dropped.  The later
> commits in this series only touch selftests and do not address this.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42633880300

