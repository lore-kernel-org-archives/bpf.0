Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027262;
	b=TJNUBJMi5htgQORUS+WH0jh9MerjxJJxs6DD5JeAE07AWntJmwczVm18SoNkaHJBNtWU
	 K37uc3oLRboTiQYiIAZeUY6qCwdiovLVKqFECQpS+5D/YIrOHDEjOZ2QgtlvGDt1nY9Qv
	 HAOUesLOO2DdyKRJmEzAwNTMKcisIL9V5KbunuUYsecG5EAhTXtuQ/BkRUlWcIe751uKo
	 B83AayCn5838ZvnAp0Bf3nmqR425kjX5FaaZ9WKsFnyqgrkHgGCEq92XiiG9Zl76KQn+2
	 6vzfErnWnL8GGEK8aCXPuLLOkrKQvKqRY9/cEtTS3VI4w8g/t2kPs/bvAdWjSC5Ok0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027262;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wnhw2bwataB6NDJxxOJekLvhPHu4AY/2Eqvomh/enxc=;
	b=nFTSSB0NUoHsLFn6uB0vt2l8r93ovSrUfjr4sxcL6DCie0E+kyTSz1SGr94KAHd/GtOh
	 5EU+lE8o0axR9l+0RmCeqkyFO1nmji+THPcWU/P3URjg7MsGRvUTnzDe6gbCkDuR76X9z
	 k2GJLeb4R41zg/IZT1ymHkzV305302WEG0+LqPG54ddoMVEtTUf1A3fS1AFkRgSmisqfW
	 hmtUOD20/KH8uduMUo9n3T0GViyc0IbuXMxdRXmq/SZswarR21ZOJtrvG0KasUpMGxO2K
	 E3IFeBL465rEhLzjT4i1wNBLj4YjcnKZIGSsI8voyCK5unmvnNOXBflpEGlruMUzT0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FYUbSmh1;
	arc=none smtp.remote-ip=91.218.175.111
Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DAC606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01DAC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FYUbSmh1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uFNLB3HiqIo+JkFlJtk4vr4134/LdgXjZ5iBc9vByl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793027259; v=1; x=1793632059;
 b=FYUbSmh1HZNpzOVb/j9jQiGPtlRSf+EmWoeTZKP6NNptf1MfXjXvgCBUBYfxKPCUsnqQzOry
 B6c9VkeyrvG9AnJqnmN12juYRb6EnLcyUeeA298swzv8xWG0IXGxLWeSVGWblQCUZh45xKBcx1e
 4HiG58XT29EpLBntuaMgTpEg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e3fb3f0e5d8099b8;
	Mon, 26 Oct 2026 15:07:39 +0000
X-Mizu-Trace-ID: e3fb3f0e5d8099b8
X-Migadu-Flow: FLOW_OUT
Message-ID: <3d70768f-8d0a-496a-ac3a-9ee3438b2091@linux.dev>
Date: Mon, 26 Oct 2026 23:07:28 +0800
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
Subject: Re: [PATCH bpf-next v4 4/6] libbpf: Factor out __sys_bpf_fd helper
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
References: <20261024153608.58569-5-leon.hwang@linux.dev>
 <5d94730579f232c7be1c83bc7287e91af9a858bcea83765e58bdd2fc3956a229@mail.kernel.org>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <5d94730579f232c7be1c83bc7287e91af9a858bcea83765e58bdd2fc3956a229@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/25 00:13, bot+bpf-ci@kernel.org wrote:
>> libbpf: Factor out __sys_bpf_fd helper
> 
> TL;DR: Nit only, not a bug: the new libbpf helper __sys_bpf_fd() has a
> misleading name and a different argument order (cmd not first) than
> sys_bpf_fd(); a name like sys_bpf_fd_log() is suggested.
> 
>> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
>> index b49822d212ae..9a2107d4f6d8 100644
>> --- a/tools/lib/bpf/bpf.c
>> +++ b/tools/lib/bpf/bpf.c
>> @@ -203,6 +203,30 @@ int bump_rlimit_memlock(void)
>>  	return 0;
>>  }
>>
>> +static int __sys_bpf_fd(union bpf_attr *attr, const size_t attr_sz, enum bpf_cmd cmd,
>> +			struct bpf_log_opts *log_opts)
>> +{
>> +	const size_t attr_common_sz = sizeof(struct bpf_common_attr);
>> +	struct bpf_common_attr attr_common;
>> +	int fd;
>> +
>> +	if (!OPTS_VALID(log_opts, bpf_log_opts))
>> +		return libbpf_err(-EINVAL);
>> +
>> +	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
>> +		memset(&attr_common, 0, attr_common_sz);
>> +		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
>> +		attr_common.log_size = OPTS_GET(log_opts, size, 0);
>> +		attr_common.log_level = OPTS_GET(log_opts, level, 0);
>> +		fd = sys_bpf_ext_fd(cmd, attr, attr_sz, &attr_common, attr_common_sz);
>> +		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
>> +	} else {
>> +		fd = sys_bpf_fd(cmd, attr, attr_sz);
>> +		OPTS_SET(log_opts, true_size, 0);
>> +	}
>> +	return fd;
>> +}
>> +
> 
> [ ... ]
> 
>> @@ -248,20 +270,7 @@ int bpf_map_create(enum bpf_map_type map_type,
>>  	attr.excl_prog_hash_size = OPTS_GET(opts, excl_prog_hash_size, 0);
>>
>>  	log_opts = OPTS_GET(opts, log_opts, NULL);
>> -	if (!OPTS_VALID(log_opts, bpf_log_opts))
>> -		return libbpf_err(-EINVAL);
>> -
>> -	if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTRS)) {
>> -		memset(&attr_common, 0, attr_common_sz);
>> -		attr_common.log_buf = ptr_to_u64(OPTS_GET(log_opts, buf, NULL));
>> -		attr_common.log_size = OPTS_GET(log_opts, size, 0);
>> -		attr_common.log_level = OPTS_GET(log_opts, level, 0);
>> -		fd = sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &attr_common, attr_common_sz);
>> -		OPTS_SET(log_opts, true_size, attr_common.log_true_size);
>> -	} else {
>> -		fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
>> -		OPTS_SET(log_opts, true_size, 0);
>> -	}
>> +	fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
>>  	return libbpf_err_errno(fd);
>>  }
> 
> This isn't a bug, but __sys_bpf_fd() is a higher-level wrapper that
> dispatches to sys_bpf_fd() or sys_bpf_ext_fd() after validating log_opts and
> probing FEAT_BPF_SYSCALL_COMMON_ATTRS, while a leading double underscore
> usually marks the lower-level variant of a function.
> 
> The helper also takes (attr, attr_sz, cmd, log_opts), whereas sys_bpf(),
> sys_bpf_fd(), sys_bpf_ext() and sys_bpf_ext_fd() all take cmd first, so the
> new call reads differently from the nearby calls:
> 
>     fd = __sys_bpf_fd(&attr, attr_sz, BPF_MAP_CREATE, log_opts);
> 
> Would a name that describes what the helper adds (for example something like
> sys_bpf_fd_log()), with cmd as the first argument like the other sys_bpf*()
> wrappers, read more naturally next to sys_bpf_fd() and sys_bpf_ext_fd()?
> 
I'd like to move cmd as the first argument, and keep name __sys_bpf_fd()
for the helper.

Thanks,
Leon

