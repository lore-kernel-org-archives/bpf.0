Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877AD38D3E4
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778875682; cv=none; b=LMH6Qqr7QnT8fvdjR7XbJjNdoubm70RcIJjkd7tE9Tzec/J+wbal9mCyWqmZzifMSHwom5LJZpJdxa3SXhlF2eTMv9hTV+119RUIrgQoHgGXcFYtdM+68fQdL3wA8hVE0zw3HNHLwoIkpcHPg1aWqDgluzf8VwH+BgNT1ExL4h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778875682; c=relaxed/simple;
	bh=ospAIioE7rmqG9WA6onadolG8rSmlDE7uicGcVokeJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+4lczUOUJal8+dk3GQ8vKwU7xG7sUYV31OsIRIhmDVTd1skah5LKIxAwEh6losf+EPmgGzqPrDYscyMiQs2/ROYUzN51IMCwlcigciGPZFMhS662DtlI5pwe071DOAmpaI9PB7x1Q+F6lRrPWKgWKgh+Za5E4u4psZP8WKLzJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftEOUJ5Q; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftEOUJ5Q"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so1304645e9.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778875679; x=1779480479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIZB8xy3e5qz6ZXY2tL/cM3w8cODzrDOELxI3VYTlZ0=;
        b=ftEOUJ5QKHaxKZShxTEe4UEpL/BHeUwKPUqZ3qkEGvGXlWG2oJt8xJzJmrGtmgyoKJ
         aZ0OpH1h/0w4p3jjLc+8o21Bfjrf6oxSKZvQ9IA4GM3iWzVgirFpr/LKWa8JnLkBLvPs
         lYktcDUJFsJr+ubEFvLgvxZlSAgnkGDJ3b6GFxxHS3SUGtFllXdps/M4N4rGsi8VfH/+
         Z0FZBTVxuqY61Lhrz8zkY6B/9qk2j70jTWvHHS8E1BkpdDwPNUI/OAWb+wY6BAsZzmLA
         dYwRoouKu35/3Iu71aPOIeu2IJ2AOGMEE5ytNBO/6wH3nVSo8xqbfjs2/6dNKRVbwJRY
         rvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778875679; x=1779480479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QIZB8xy3e5qz6ZXY2tL/cM3w8cODzrDOELxI3VYTlZ0=;
        b=UNLJkaGdGTD4qw9wy0MxFQoObqfX3jtw6fSf6+23ZwnrIeRP3/uAueu3f1m2ZHLpVf
         Xiiv1sOS+7mLzJsuIauGf8eL0hcyHQCmJlZwpazGZr09z+HUhcBl8W7dSZ3a0PiPy+5h
         CY71xpBKi0OahDmE/uKIBVRIHjMjN9qegXgh52amTdKNa9HthQUHutJplZO0uWu0NUCx
         fhC1GWze8Yo+qml7Jqe55kUyEUO+9NgJUscaTJlswhP7RKJI51d7dhSfRSz/yd6Hs84l
         hOZvYeXOm8tMRcbcrJs/wvEtoz1PiYcSSp83D7Rf80y3dV/uSpy7G7i6mLhn5xOwwmo0
         IbIQ==
X-Gm-Message-State: AOJu0Ywn+MnLQFRphunXy4EPKoJjmAo0Nyl2caj62k5OWQQgKM8D/7oZ
	+AVynkFhOwc58tEpEkDKL8ndOoaIRvjytCnI8LZ33dAq5hjU3hBf+H9o
X-Gm-Gg: Acq92OFVkIVAERJtfKXjHhq6extYFrY3YsHC8LVdqzYFgtswUy273+j7Bxi7prGoXT1
	MXbHILL/ZmZxkUOVpTKL0omJ4k4OyrbN09KG/nr43eEd8+Gcdp+fNx8FElO/vfr1au50sJ2+ArC
	WQ3g/1p7jEDi6OU1LerEX1+DgMU6VL2Bk0/HtfHBN8gm9L0gOuA7O28b9k4JXofp+JUqgVeemDV
	1o6U3KJQE23LgyxX4uUc9H2K4c+Ao2KlY+BFTScwPMvYLGJQN21SNpFC5ANVwOyn8vYe07Wi7yp
	EL4JV4b3J4s53GTXp/blsimaZTww460PT5UOksbWbH8pIBy6q2Zmj+k5nE/QctXJUeEgtuTZeYp
	diBO0aTSmx/DoVdbPvN7HNSJTp5DJY4njFDgIiSBdjtCBwL7zuq7xVDkEDMQsexFedJd8/04wiY
	Q8cbPZBT918eaOu1zAlLOaRovcO7whiXVm6Hy1Y8IT4VrmU1qDoa4rdyBvJQqyUc+hsUQBGQ/5I
	wD5PaDnxEGLsKPx6p06pw==
X-Received: by 2002:a05:600d:2:b0:48d:112c:f582 with SMTP id 5b1f17b1804b1-48fe60ecd1amr56133525e9.11.1778875678729;
        Fri, 15 May 2026 13:07:58 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c8d39esm81851315e9.7.2026.05.15.13.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 13:07:58 -0700 (PDT)
Message-ID: <24e10e8f-56b3-46fc-8537-fa677b2d2ddf@gmail.com>
Date: Fri, 15 May 2026 21:07:57 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] tracing: Expose tracepoint BTF ids via
 tracefs
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260515-generic_tracepoint-v1-2-aa619fa94132@meta.com>
 <20260515182509.A08E7C2BCC7@smtp.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260515182509.A08E7C2BCC7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 7:25 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The global `event_mutex` is held across a `copy_to_user()` operation, creating a denial-of-service vulnerability and latency spikes.
> --
> 
> commit 5bcf593e0ef00b79b0e87af32e5fdb4e5481d768
> Author: Mykyta Yatsenko <yatsenko@meta.com>
> 
> tracing: Expose tracepoint BTF ids via tracefs
> 
> This commit introduces a new tracefs file btf_ids for each event. It exposes
> the BTF object ID and tracepoint/raw BTF IDs populated by resolve_btfids at
> link time to allow raw_tp and tp_btf BPF programs to properly attach.
> 
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index c46e623e7e0de..d463fb44c790a 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
> 
> [ ... ]
> 
>> @@ -2200,6 +2201,62 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_BPF_EVENTS
>> +static ssize_t
>> +event_btf_ids_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
>> +{
>> +	struct trace_event_file *file;
>> +	struct trace_event_call *call;
>> +	const struct btf_type *t;
>> +	struct module *mod = NULL;
>> +	u32 raw_id, tp_id;
>> +	const u32 *ids;
>> +	struct btf *btf;
>> +	char buf[128];
>> +	int len;
>> +
>> +	/* Module unload could free call->class and ids[] mid-read. */
>> +	guard(mutex)(&event_mutex);
>> +
>> +	file = event_file_file(filp);
>> +	if (!file)
>> +		return -ENODEV;
> 
> [ ... ]
> 
>> +	len = scnprintf(buf, sizeof(buf),
>> +			"btf_obj_id: %u\nraw_btf_id: %u\ntp_btf_id: %u\n",
>> +			btf_obj_id(btf), raw_id, tp_id);
>> +	btf_put(btf);
>> +
>> +	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
> 
> Does this hold the global event_mutex during copy_to_user()?
> 

Right, I don't need to hold mutext for that long, should drop it before
scnprintf() call

> Because guard(mutex)(&event_mutex) holds the lock until the function returns,
> the mutex remains locked during simple_read_from_buffer(), which internally
> calls copy_to_user().
> 
> Could this allow a user to intentionally stall the global tracing subsystem?
> 
> If the user-space buffer is backed by userfaultfd or a slow FUSE mount, the
> page fault could block indefinitely while holding event_mutex, which protects
> system-wide tracing operations (including module loading and unloading).
> 
> Looking at event_filter_read() nearby, it explicitly releases event_mutex
> before calling simple_read_from_buffer(). Would it be safer to use a similar
> pattern here by dropping the lock once the buffer string is populated?
> 
>> +}
>> +#endif
> 

