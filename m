Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795157087;
	b=eKAkuE//mu9qOWFvHaCX4iHVXx9WbqoUBp4zL+9BtRYvKJa+lD086QSEMugphLa6j9RW
	 kXHKqwcol5aSmqtbtJVSBtlCpGzDsffmbsz0mR4APwHLFadCC4wxYTPN8JAArlzG7TxNR
	 7+I7Fh8RCZQcdcGKxeJMmUuQjux9oeWCrxuEHfpv612SLFBHwk5oGLp15qHUF6eYlUyJl
	 NR4EWEvO+p6HH4kcjoYzZYD8TWi0wttxIqJersCThfbdW5hpuGlUliRsCiFKcPJITCh3e
	 pT4bakCqf/xx/WyI8Pui0h3nkFOQOLcGWExwHvwrvOOcXwMB2loX1pBwEkxeZ2kguQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
	b=ncPmGbO28J0Q8wsppJWLu6Niw6bZwxUb379uphE8JOTBsiFCDh1W1AHVbnXnGMUltKPO
	 Wxf3FLgSW4eSaym5err5XjDgdhc/pfwvl9poyQvBg1ctuWSZXG3U2OgMmrRgNt4Ej5Aq+
	 ZsqKPGN1RWx0JG0vubySkdGIfE8zLuBmeKAE7oWAMvfUp/4cSkp9/+Z+YSkd6MVOFtIOe
	 uOLLbiLpA3aVoWXY/8pzUXtZpoqRd2hbT+nRXolW9z0dVFK80rWMIn8YrLuKIYZSwFDnS
	 vOAoNP19vCJzVQqcLKs6PyX8wmFHSc/0o0UUyzXC5Iy+wOnsWdgAExIO2XCzx7dXTwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teIuw1f4;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636C606A32C
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 06:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5636C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=teIuw1f4
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc147d86bebso324878a12.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 22:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795157086; x=1795761886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
        b=teIuw1f4IVp67pH42Le/2jtpiPPxeaI4Srr6xMfrsEcES6+WJldweFTh8LR2m3CVjn
         RPGfDm9CEng2MqezE14lmoXpP/rxKKUvGg1nwLJb4QMnWRzIufguA/U9nXJm2hIFF3qm
         q5C3xdncjohNpuS1kSAzmOkZx9vD1dj+uMAsQl8Ytindk9sJJzLQzqX37NjCgyWLITZA
         rVlApmz9IRKVvZ9yL8D7v2VBQOB0KqqwSFypjZKQyJ29gKyunS5q2wsGWSjT53/E9QX8
         L53ZNV8nj06rcYHDHmUPG7m5w0SqJrZnd+T2xlSmJUzt3kFI9fhKr8Y3Zzetvq+umnef
         JwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795157086; x=1795761886;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ibHuc2Ky7x6xbIQztLyKbwCm/OGk8fLoxdPIGUt/hMM=;
        b=aGqLfC6rNriqCfNJ5VX3cCdGG/IAUzMUr2cAto0d2oY0XO9XWzkhVH184QSNNJSI4y
         uBjSrCY5XZuZoSIccd39SOvEfVOaF3Dtt24gYHlSVdEKU5rrXLFugpn5SCqus1kgWCP6
         7rY2KrujudJ9IGL4Fb+PUmqWpMMA0yeIN7SEhHF7+9IPC4xa2K/RSJ714Q1Rby2JMASo
         eNntx7ZAxV/0u4XjPXbH4Sex6L6z1L4CMLfiKe9Ncr2Q0Pq376jZK3rLJx5CaJomgTTg
         mxN1soh5hfxLmndMiwx1rdVHxi3bdShaXXi2hd3U1iBrfGjIH3Rl6VN189nFrz2uD4Es
         qKsA==
X-Forwarded-Encrypted: i=1; AL+hErHuKL/2wakkXdA2swd+Q6It7R1yP/T8GXGqa8oChQ+DqutQjE2DH90qFUa6fQS8HNRDZY0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iU/Y3UVNtB1gJiO3Gl1GqqKPgT28WIfCmmgTGace6a5CqgiDl
	OpJXTwPoOjdOO/IJYsuZD14M2Y8Ty5DOuAEIja6xmRk9hQlHdbCCh0Aw
X-Gm-Gg: AZFdTZdq5UWGlVS+N0ZCsQNPIXwqz77zw1RrnkfYFHLuD8j/vkHyEUCI6FuMeRCeYUF
	zH28v9nvZma5NFVD3q9ckafQ0YPlaColb8lFiaDcxQxAO/uv8qMRigcuc3VeFbH9NJ4AHxAVlLP
	qlYfn3FZ6WCtjQh0cfMXazCz5/W6QRC7x6zME5iLupKHiX8rRAqPnbQxDWVpNOZ5TFPgvZVQkG0
	l/XWFJjvlBvjpz7kndZG+Bl9voBLUcg4Lb6P+B0bZKrzyGhMVxPHtvgnLjZr4M1FKOP+rwlWTaF
	MVoUPvwGsJDZm48b3F3yKermPAXf8+KupNu/kk5v1I9/VkimI1mQCru5J7dVIhJiIPl8s+6POsA
	g56/+NTYd4fKqTrimJKhl4805V6lro5VzWjwV7CLhXcCqAprf5VEUcXtGKq6+3+U+7hpJEXMRL1
	vDxBpT1Ydq5gDAActrGlHOUyTzA9OkrR544xBMlBGqIzfPYHafPMkTvYdNXhfZBlVmH+fwA5UqY
	EkwqLp6eDw9NoAHZ+Yj6oqjMMWi91QTtRjzNfaLd5bd/oQmwIffd/psrrpG2zj6n6UGXQaiqER5
	Zt0YlEwwDyUP+OJfH39j4YNdjqf3ArZMD/JDvWjpEgxhPiNexexU5Q==
X-Received: by 2002:a17:90b:5546:b0:3b0:a1c6:95ae with SMTP id 98e67ed59e1d1-3b41c941f9amr1058404a91.31.1795157085609;
        Thu, 19 Nov 2026 22:44:45 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4323bda5esm12916a91.3.2026.11.19.22.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:44:45 -0800 (PST)
Date: Fri, 20 Nov 2026 06:44:28 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	haoluo@google.com, brho@google.com, joshdon@google.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized dispatch_max_batch
Message-ID: <av_sTGpIbkzvsp05@srsys1>
References: <20261120054913.3795562-1-rhkrqnwk98@gmail.com>
 <av_oLZQzAtFe2vTr@gpd4>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <av_oLZQzAtFe2vTr@gpd4>

On Fri, Nov 20, 2026 at 07:26:53AM +0100, Andrea Righi wrote:
>Hi Sechang,
>
>On Fri, Nov 20, 2026 at 05:49:08AM +0000, Sechang Lim wrote:
>> bpf_scx_init_member() accepts dispatch_max_batch values up to INT_MAX.
>> The value determines the size of the per-CPU dispatch buffer, but
>> __alloc_percpu() rejects allocations larger than PCPU_MIN_UNIT_SIZE.
>> With BPF_F_LINK, an oversized value passes the struct_ops map update
>> and triggers an illegal-size warning during link creation before the
>> allocation fails with -ENOMEM.
>>
>> Calculate the buffer size using the effective batch count, including
>> the default used when dispatch_max_batch is zero. Reject values above
>> the per-CPU allocation limit with -E2BIG during the map update, before
>> the allocator is called.
>>
>> Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
>> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>> ---
>>  kernel/sched/ext/ext.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
>> index 10de6bd865e8..93128da6b126 100644
>> --- a/kernel/sched/ext/ext.c
>> +++ b/kernel/sched/ext/ext.c
>> @@ -9197,9 +9197,14 @@ static int bpf_scx_init_member(const struct btf_type *t,
>>
>>  	switch (moff) {
>>  	case offsetof(struct sched_ext_ops, dispatch_max_batch):
>> -		if (*(u32 *)(udata + moff) > INT_MAX)
>> +		u32 batch = *(u32 *)(udata + moff);
>> +		u32 nr = batch ?: SCX_DSP_DFL_MAX_BATCH;
>
>The fix makes sense, but with clang:
>
>In file included from kernel/sched/build_policy.c:71:
>kernel/sched/ext/ext.c:9214:3: error: label followed by a declaration is a C23 extension [-Werror,-Wc23-extensions]
> 9214 |                 u32 batch = *(u32 *)(udata + moff);
>      |                 ^
>1 error generated.
>
>(also reported by sashiko)
>
>Can you wrap that case in braces, matching the nearby cases?
>
>Thanks,
>-Andrea
>

Thanks for catching that. I'll wrap the case in braces and send v2
shortly.

Bests,
Sechang
>> +
>> +		if (struct_size_t(struct scx_sched_pcpu, dsp_ctx.buf, nr) >
>> +				PCPU_MIN_UNIT_SIZE)
>>  			return -E2BIG;
>> -		ops->dispatch_max_batch = *(u32 *)(udata + moff);
>> +
>> +		ops->dispatch_max_batch = batch;
>>  		return 1;
>>  	case offsetof(struct sched_ext_ops, flags):
>>  		if (*(u64 *)(udata + moff) & ~SCX_OPS_ALL_FLAGS)
>> --
>> 2.56.1
>>
