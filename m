Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1B42BB13
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957193; cv=none; b=RIHtRZKkvwofH+7Lpojre7XM47rJZIhK1iFM9x059kmLcEWfMYkiOdZqFtUDm/WNy/eEWhPeq7306jd0hRQbjbvViErtlNbBujBYmQD1XzqpEaNue+InK8zBietfcNviR+4Z3hXERjvxq/pvHAe46ktFhcfrud2owC6CreDEq2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957193; c=relaxed/simple;
	bh=sMIedgk/FzUvYT0CH3daqkNLkRYjCT/GhaTZmYcEEEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ln2/XtA3eCi/sgKDQvvVj8OUSNy9I1qFgZ/IO0A05fSujtS5QhNCGmHRg2oWEBQMmhio4lIej43mBZ/7c1qZLzS4uAoY/4RFXJ9w0wScqRih1CG+GcTcOQjf3pAlyZrU1Qd4zOA5yyehKXABv4ekkW0s3cwdX35myje/y4ZfVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8K1W+y4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8K1W+y4"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso51235585e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 04:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774957190; x=1775561990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ilImfmulv6UpxfczUunMbR5HPcvZ4W/6BooHfnpH6E=;
        b=T8K1W+y4PvZno0odquMsAzwvPvZwCiie76XB3kF/zakcoBROK0pNZa6Ll8Cr711kiR
         yKG7xc3DjzFKqmfdYHeHx2th6QzzuQywFCSWcU4OkKPiOvE5YPEKjiKCA58qq1BHRnVp
         VDeqsEuzxz7MItAU2nu1LgwT8NVczbUt6zD/ZrKbvqh1okxJG45X+mqfnQeSe6zSjDzK
         aWoQrPGKXSuN8f483s96b0viPpb2Ahk/HhLhCkEdDsWPyCjuPgwMeMNQoxsVCHtzkXQ9
         kE+/0JbjR5SD9sc9yCptvtgIYxJ2VcbnQUTu8qdxAeBetnBtIe24SIphRegePGSfjM3y
         3Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774957190; x=1775561990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ilImfmulv6UpxfczUunMbR5HPcvZ4W/6BooHfnpH6E=;
        b=T431KDiXTErGJWvVEs+Yg7zuGEDwfb1VgML13WWs8ltjBZhV8QwH9etTrt+c+crfuC
         0WKMlFNw1T3Ky1ABeDPcHPouYxQC2ugWbxMDRF7hfXa3bbkvqz6JUadYSSxxa7xm45xG
         G37IdCY9aDN15saOUFsEnk0Ebo0N1sV9XdVDQUsTt4p/hMqHXcP0nuwAwrDSwKXnltdR
         qDyY+MchTfOJcv3B3agnMaq2p/RVNgEXK3S7+I1r0mAZ8kD2XG99TUkJQikFa1JxFigv
         Gu8QJlH/yhgthMue4fxDjUmUJioe6CtIoJ9iPZ9/FrfMryz+4cuisgx+UHtmxhZdgy3B
         6luQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTu1IIMLNo+cE+ZxxbuLKGuw37J97hwhdtYUsKCSDqr7hDpr1GEIqb92ffoIWptwyFThE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgkBbgBY7MP4DSyepjTAtvs83Czf8NXsGOWhBOL+FppqGMGPN
	+YJmVh4X11B1DuMrxTShs4UeFAXSK6kLZWYJ9Jwn1anWDlwnwFOe+1aB
X-Gm-Gg: ATEYQzwwJSWPofGmgfZz3hRLO1OzATZeXzBwicSX4Yb9ma1+uCggbpgmVeRy4gmI7qP
	dvSTOviagaZ9wEZfNMV+0vOkUDH7VWBmWZB+GzUraCBJjpWDxb33/Jh+3y4JXkh9Kip/4N+T+aR
	uN9d3E5GoYFL752UK6AxAwoZMkWABEOslBT2r+Fk1j2gWUw1G80KdQXaifmlLpXRaDuaIe3WlOY
	NnAC4JiJDQkjAN4e2b2kg5vfhXVmSInuBvkJHvzKyItmTM9sRb8koiFuF1znnAHvW5Rown1oly1
	saWIZobZLfkgjdDvwCy5XHDYMLdFekfZvWu2cSXoTXrHvQhFF8o37vwUsUAAdOCXqyaxkW6vIhY
	vhDqtDwBATCcds6ELVZUkqda7r4JBjPAOPtFINiTFnyMx2JqBdFmYstBhOnq92ZCNpL0b2OxpjW
	tw6ZfBCWauJAx+eeMuSgGfsT1B+5honeoRYMfBVBcPdq8LCFsKhWfWGJA7Wab6dCSVJ/xS+tdNM
	H+BsdHqswU=
X-Received: by 2002:a05:600c:3d87:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-48727d5a2bamr266540335e9.4.1774957189701;
        Tue, 31 Mar 2026 04:39:49 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ebae9e5sm9457865e9.23.2026.03.31.04.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 04:39:49 -0700 (PDT)
Message-ID: <4f53d7bc-d0a9-409c-81c9-3fe255f08b98@gmail.com>
Date: Tue, 31 Mar 2026 12:39:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpf: use-after-free in hashtab BPF_F_LOCK in-place update
 path
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, Puranjay Mohan <puranjay12@gmail.com>,
 bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
References: <CADucPGRvSRpkneb94dPP08YkOHgNgBnskTK6myUag_Mkjimihg@mail.gmail.com>
 <m2se9mg16x.fsf@kernel.org> <87qzp6ipc7.fsf@gmail.com>
 <CANk7y0jkEKYviXGG2je80Q26MK4nfE4p=wfb_ukDuHGKSy2Qiw@mail.gmail.com>
 <87o6kaioju.fsf@gmail.com> <87ldfeiodk.fsf@gmail.com>
 <CANk7y0iXJ1sTn5eMrUosvbwnLrSwGtxyirgTpFwdDVWN0tHb5Q@mail.gmail.com>
 <CADucPGTNHas6gJu=ybWyZ5X2s6bOO_ar2eg9PFv6TRv-=NA-Zw@mail.gmail.com>
 <CAP01T7712ZmLy2YaViHtZ=2RqtF4i_F49Vyb_UC8NgQcYX8j5g@mail.gmail.com>
 <87a4vti79o.fsf@gmail.com>
 <CAP01T75bZRbgNXJa_rq_MX6AKm0XBTpOO6V-RSy35b+TFA_Hiw@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T75bZRbgNXJa_rq_MX6AKm0XBTpOO6V-RSy35b+TFA_Hiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/31/26 1:55 AM, Kumar Kartikeya Dwivedi wrote:
> On Fri, 27 Mar 2026 at 17:09, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>>
>>> On Fri, 27 Mar 2026 at 03:54, Aaron Esau <aaron1esau@gmail.com> wrote:
>>>>
>>>> Puranjay Mohan <puranjay12@gmail.com> writes:
>>>>
>>>>> Yes, if all the users have BPF_F_LOCK then it will work because the
>>>>> re-used element will have the same lock and everything is serialized.
>>>>> But this reproducer is trying to show that the elements are being
>>>>> re-used, which they are.
>>>>
>>>> Updated reproducer attached. All operations now use BPF_F_LOCK (updates,
>>>> re-add after delete, and lookups), so value access is serialized via the
>>>> element's embedded spin_lock. The value size is ~4000 bytes. Torn writes
>>>> are still observed (3 in 2.7M).
>>>>
>>>> With full spin_lock coverage, the only remaining unlocked write path is
>>>> alloc_htab_elem() -> copy_map_value(), which copies into a newly
>>>> allocated element prior to insertion. For this to race with a locked
>>>> reader or writer, the reader must be dereferencing a stale pointer to
>>>> memory that has been freed and reallocated -- a use-after-free.
>>>>
>>>> The root cause is bpf_mem_cache_free() in htab_elem_free(), which
>>>> immediately returns memory to the per-CPU freelist rather than deferring
>>>> via RCU. This allows reuse while the syscall path is still within an RCU
>>>> read-side critical section. Preallocated maps do not have this problem
>>>> because freed elements remain within a pool of valid htab_elems.
>>>>
>>>> Switching to bpf_mem_cache_free_rcu(), as Puranjay showed earlier in this
>>>> thread, eliminates the corruption.
>>>
>>> As I said, the reuse is intended behavior. We won't be switching to
>>> bpf_mem_cache_free_rcu().
>>> This is mostly for performance reasons, in case you're perplexed as to why.
>>> That said, we could do copy_map_value_locked() if map_flags &
>>> BPF_F_LOCK to fix this particular case.
>>> Such that if the value is being reused we will still have serialization.
>> I think we should do copy_map_value_locked() on the reuse path.
> 
> Do you want to follow up on this? Otherwise I will get to it
> eventually, either way is fine.
> Thanks

I'll send a patch.
