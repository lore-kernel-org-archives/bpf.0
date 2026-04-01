Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE53624CC
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057635; cv=none; b=MAN7epF2IfapT+GZcU6khQo4FvTReoNF8NorGoibf+o4xwgIXhp0CquXbQp/pvOpJRv5G5oi9mHB5Ypbr2ZRpogMi9gdAE+s68jU6msS67I8wLTT9T89++PXXjXR/fW8cKCmMZoQiuw4tdEUD4oRFrMr9U47VWy3m0QXmSbrmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057635; c=relaxed/simple;
	bh=3AGdk1MmLcXqGw1z1d8VNmDeFUZn4+0DD6ocOjwwmWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGf3F9fbqMMMuwu9fHnoeN7Qi7yN8a6Qyx7A+PXI23XU/pQMT86JB8GaVW+MnAmb5EU52x+kdiTtSr31o2gLLCI1acyMutBQ/tEdaagSAOn5pmfKbh0XBM3a3jE9U8MXMx8ZyxYUpcWtgdwJFuUEESFSs1qjb1XAw6kcImV0awY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6SvPSmk; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6SvPSmk"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488879b2e6aso5996755e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775057633; x=1775662433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YLMAP5HGdIpg1Q5i4T3+XML8Ji4OfdrUmx5OOPfEMXU=;
        b=R6SvPSmkDKgI1aVVP0uxmVHAgk4/dKwNMyTcnYFtUcs0v8I1tBd+GXEHkG2aqBR+09
         ZU7fvpPFttZATnvs3z+s9U/t241oakUEoYuAG9L95sc5WmDGBsRagTJclldNoEkaSXfu
         /rnhgZWdGwNdARMJFLD91IRyZ+hEacSbFrB7gINJiSqEvRHo07PVgSl3uMLXyvn44JBQ
         sAwi8W3iABJtJnJNUYW2oz6v0t1NGR28+5MSf7xMLvu4+qznAtug2ZfMx8NDGRiPbkyj
         846MD+16gX6B4xbRwACsZI52xMh/54A/ULcuUt752ZlmCcFhYh/JI+KWb2TCofAOjnvs
         Yyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775057633; x=1775662433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLMAP5HGdIpg1Q5i4T3+XML8Ji4OfdrUmx5OOPfEMXU=;
        b=Bx/9bbYqaH0sg/TRtf3IMU/BHJQEq497fF3g+RotaSzjMl+f5Q+v9RXOaCEdXMFGl7
         oPW/JHhW7WtbquhiQMVidhQxFhyJIuT0azJKz3XmOXH32X1VvoniY9L5VBnKZs6k4rWY
         eQcKZZPB0xcUMYRAQCg2lsUoR5JJWPfka9Cpdb0NtSHTyoltzQPIH09I1T3S0p0OIn+Z
         h5toEj7CBCokZUfz1dCTAEup8PAeMPRjemnmFeyMMAE8LWtACLkvAh56ydK+T7vY4qR+
         YEH7jTTxgMJThaBjO6QpF3f50Kt6udlnRgNF3QV4dE5Iv0xHyOqp+gpaK/c4gGuzh6sQ
         GHQg==
X-Gm-Message-State: AOJu0Yyi1Zf9R6tn6PWJzIpTnolRWm8GSsnaiBbh3fEERQ2x2/OUc17/
	JEX3xXbAO2nMeAyKx9g3Gr5AbGZvAqYQJpUU5r4kd1FqYO83TAxfdkYx
X-Gm-Gg: ATEYQzwHm46vvEdPO7jHRWxxPECjycP0HMe6TIrfVBFCkwM8V2JmMSsKOxGMSHJvqC8
	CVx9ZMg3K8guc7Kw2TRrDyZBH9o0S2R5NDyh0kntmm/bd+WtlBwMqKwc3VvQPeAWsv2UYwZu2xb
	jXCF7+HMOedZVJsM7fbLRjfRfTdkOuJ/+Wl9zw5lDzT8lNRu+b3z1z5x7gNKQ2ebDimx/aTopqw
	yl+8pkzm4BxyGXRsYtLeP2MYxn+7IxPmOno48YJTYfQIOCTMfV4KGgvY4V+nelOkSniuKrantmp
	OjKO3+MnV9EsacSnL8446P+Ku9N/9wyhP3neesH8vIl63sRrnz4P5SRlzqnAeYqheWi8Yzi02iR
	wsfepFdWcTVUKkW9czwKHemCb943bc3uMSn93YCJWT5V1viwqwuUj1ZabcYeyvjlKtUK/um5scP
	6dOtiqw6QrgCoOyU3EYpaWrB5Di+2/JaDy/ko9i5VZpL9WTvvm8M0Oj1cYuEi6
X-Received: by 2002:a05:600c:4707:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-48883595dfcmr70246115e9.25.1775057632729;
        Wed, 01 Apr 2026 08:33:52 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:ff4a:fb29:5217:3697? ([2620:10d:c092:500::7:b4a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887a648f3dsm86883035e9.0.2026.04.01.08.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 08:33:52 -0700 (PDT)
Message-ID: <c83b9eac-f739-4743-af84-4bc54c311d53@gmail.com>
Date: Wed, 1 Apr 2026 16:33:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] bpf: Fix torn writes in non-prealloc htab with
 BPF_F_LOCK
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Aaron Esau <aaron1esau@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
 <CAP01T74g_=jSJTNzS41VzK81n3kwkM8EOY=Xv=t0yM5b1-+Z4w@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T74g_=jSJTNzS41VzK81n3kwkM8EOY=Xv=t0yM5b1-+Z4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/26 4:21 PM, Kumar Kartikeya Dwivedi wrote:
> On Wed, 1 Apr 2026 at 15:51, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>>
>> A torn write issue was reported in htab_map_update_elem() with
>> BPF_F_LOCK on hash maps. The BPF_F_LOCK fast path performs
>> a lockless lookup and copies the value under the element's embedded
>> spin_lock. A concurrent delete can free the element via
>> bpf_mem_cache_free(), which allows immediate reuse. When
>> alloc_htab_elem() recycles the same memory, it writes the value with
>> plain copy_map_value() without taking the spin_lock, racing with the
>> stale lock holder and producing torn writes.
>>
>> Patch 1 fixes alloc_htab_elem() to use copy_map_value_locked() when
>> BPF_F_LOCK is set.
>>
>> Patch 2 adds a selftest that reliably detects the torn writes on an
>> unpatched kernel.
>>
>> Reported-by: Aaron Esau <aaron1esau@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> 
> The fix looks correct, but I think the test needs more work.
> 
> After reverting the test, it continues to pass for me the majority of
> the times, so it's not deterministic. If a fix is made in the kernel,
> it is essentially best-effort, so we cannot be confident whether
> trials that didn't produce a fault were due to our inability to
> reproduce the race or because the fix was correct.
> 
> To be fair, I am not sure we can construct a deterministic test
> without controlling thread schedules, so it might not be worth it and
> we can continue with the best-effort test you have. It definitely has
> some value, since I don't observe any failures on repeated runs but
> can observe some without the fix.
> 
> One way I considered strengthening the current test is to pin threads
> to two CPUs. One thread will constantly lookup and verify that all
> bytes are the same. This will use BPF_F_LOCK, ensuring serialization.
> On the other CPU we constantly do delete + update with BPF_F_LOCK, and
> keep changing the byte sequence we update. So aaaa -> bbbb -> cccc,
> etc. Set max_entries = 1 so that we ensure the same element keeps
> getting recycled constantly. I didn't try this but it might improve
> the chances of success, esp. if the map value is big, such that the
> window of reading and writing on either side can be long. We might
> also want to do repeat = 1000 or more and then handle this sequence
> copy in a tight loop inside the kernel in the program itself. This
> ensures that precious time on either side is not lost bouncing back
> and forth from user space to the kernel due to bpf_prog_test_run().
> 
> Thoughts?
> 

Yes, the test does not fail 100% of time on the baseline, but this 
particular implementation fails most of the time for me (like 9-8 out of 
10). It passes consistently with the fix.

Yes, probably pinning threads and making map value bigger may increase 
failure rate on the baseline. Thanks for checking the test on your setup 
and suggestions, I'm happy to implement them for the next version.

>> [...]
>>

