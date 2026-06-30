Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659873E315F
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798187; cv=none; b=Iovc1kfJ32huV6oEzwTAzr1X9C1383SLqSbEZu/Q91TKQUmypcnxhdBnApYaNIJopd2wIywaKWHTIp82upG4qLlIi0rW5f4jHAc3iar/Wl0gayXvdRAU7pL1E1rKCxYnPyd8C3f+KyB556fXZc84Np1ly0RZKFS6k4XsKzuKAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798187; c=relaxed/simple;
	bh=9rXZUBsGBmtMoEa+jKKzLo71wF5tmz2Z8X2eRMgLKC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qgVWSA3SfUBzVHToYntuKEj1iJN5ov2GVPkMThCpqG6FTwFLjeH4ewfrnBdBjXks8J6qE7KErw5bp7pm4OGWxyVhjtddd77e0FjP0gm2u9/zTcB3SZJdEkXnQ0xCMpVR9DK5ntBKo3u8D/IXegNtcWqNxnfmDdegREBjYlh6zQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJao5Dj5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lZkDQkxM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJao5Dj5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lZkDQkxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782798185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
	b=YJao5Dj5+vF3yFc5Dgiib86uqmbUAPNgS1y7oGf6VueY2YDUUJsbHTnghaTo9P8VPyiN5m
	FA7FTZcgGjMb4W2beyWEExiMBLbLaMjloThid98hWMVs9UEGehKIvMA5UboZYNZMblj+kl
	2drvfawX8roOLaWk6GMs0Z7O+Eh7OJ4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-kOsEZ8UNMVestZBFLAPbyg-1; Tue, 30 Jun 2026 01:43:03 -0400
X-MC-Unique: kOsEZ8UNMVestZBFLAPbyg-1
X-Mimecast-MFC-AGG-ID: kOsEZ8UNMVestZBFLAPbyg_1782798182
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492714d002cso14659715e9.0
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782798182; x=1783402982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
        b=lZkDQkxMyIJQG+HdGrnGBqvHOFcYRDKCI+h7u8ijSTNYla4xfsh9La1RKXx+ip0pyB
         6yONDkQNFffPxXQ/JbtDgeR5YNOaj1h3V21OVG8uGwA1sN/WA+2Q69NVBKtn+wQ94qpb
         LmoV8hYf34dhi5s2dYVWm5JLIf4ehqTH1hoMPmsD6el/wcc8JG0OyriC4nySSRhL0Osw
         Meivv/Km8HutWPZ5G5NnUWz8yTzcYdtrwoPNHBHmWNzmyR07m1dTXTNOzN5i+BA1feeX
         tao/A5L2jG8+6/MPLP57kJoLvl8ezkwBYeDnWiRnzghcevhyrK0rSeyTNjZtKgNFmaYF
         UPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798182; x=1783402982;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/eDjU5MiOjexozee7SNJIrZyMlG/yERHTdQ3gey+uU=;
        b=mahRrAHvb2p0b/3t/0wZ5AAPkhdM3BKFM/m2exLlfEM35CoW7xN8B67hfJkQ6S0QY2
         UoOQ8TZZnMtDq8kgIvhnW7XvGPUXWoiyhtFfoci9M/RXqqSUlouzVhabOi8rxm/rc56x
         8M3p7NOx93XuXkZ5dmU7JzuBkdz0JnSoDDYKCLlKkDuQI2vEqQqB2Ev68k+A7FnX7H0z
         Z7gM191NjjEjm0BQNKlc2LBu/dlEq5eFf/rZgX36iQPcvKJpqEmgLyqwbUcO3tXr37/q
         /ITgUNLZV9ANlHj5zLVjbFtuDaWHMwCq27X+anZM8wz6w457AaegJvsmWQ5MKqZXm3r8
         /dug==
X-Forwarded-Encrypted: i=1; AFNElJ+2dXyrr0qneP0RdTkXZLqaJdw912K9ncz1MX2/EdHYBJ9dMCOA/Zx6ijM3v/tRKKFUSn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvy7mCXLTswee6CsbBs2APdwENrdZ7ND/NfORNBQ4w6uz/Yaob
	bPrOV9yFuY0rBHSU4YfudJ9ovbi6dBtE15237j+wwoznLNGev551DGgvHLRQStABNQP6mMSbnuL
	uVt09uZc4TyjjASWyIAXYbTShui9ii8qaf/Rf5bwhrp9gAT2/S3Qc
X-Gm-Gg: AfdE7cme1Kdfz1ZLQ6u+cs1a8+NHB9o/G3jJm+RL9a1SNU1oJSe4frvgx6CedxC6AWm
	wOyekTIYtFL/Cm5roaoBiApcs8g6eQpTTzsGp8lw2NIQTaDly7d709div3DNTNgm/H77KeTsKH7
	mHHWVY1YNuTqnR2FJiVmuVsDU0aBMu4UPpJL2JcMRsfPvGQtMM5QcZZ7reGid2d40iJTWnO7ZCA
	sh1lDEc/KUffvlWr2YQAi2o8oqdNRKgU+cc5oUuxwT5kqml6Yu9EL2NvF8NeGRWKVtL5CzlGxpm
	p/r/Y77vsZ58ARKhMgdlMuQxp/t7Kc5A5qvNn17rmE/tfzrwRUQdhWBCU97o0rYt/neUVyBFd7f
	aFkDapwExN6i437IcDjwlMdCYgwnt9Gb6VVFr1WAa3WJJhQ==
X-Received: by 2002:a05:600c:848e:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-493b82b0f53mr33437945e9.22.1782798182361;
        Mon, 29 Jun 2026 22:43:02 -0700 (PDT)
X-Received: by 2002:a05:600c:848e:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-493b82b0f53mr33437635e9.22.1782798182012;
        Mon, 29 Jun 2026 22:43:02 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8cb62f1sm70244105e9.15.2026.06.29.22.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 22:43:01 -0700 (PDT)
Message-ID: <c1666061-c3e7-4eda-82ca-d03daf05f4f8@redhat.com>
Date: Tue, 30 Jun 2026 07:42:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
To: Namhyung Kim <namhyung@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <20260623112533.1151502-1-vmalik@redhat.com>
 <DJGJ9F6WQZV9.2W4WBIHYLJQ97@gmail.com> <ajq98dm4gAwEzkMb@google.com>
 <c2f4e45e-d5c9-42e9-a46b-25fb0cacb267@redhat.com>
 <ajwu7xR6V6MAQOFw@google.com>
 <3c221e35-d642-4036-88fd-d25df7f8807e@redhat.com>
 <akLXCFpnum0WgXGf@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akLXCFpnum0WgXGf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 22:35, Namhyung Kim wrote:
> On Thu, Jun 25, 2026 at 02:05:29PM +0200, Viktor Malik wrote:
>> On 6/24/26 21:24, Namhyung Kim wrote:
>>> On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
>>>> On 6/23/26 19:10, Namhyung Kim wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>> [SNIP]
>>>>>>> +	struct args_loop_ctx loop_ctx = {
>>>>>>> +		.args = args,
>>>>>>> +		.beauty_map = beauty_map,
>>>>>>> +		.payload_offset = payload_offset,
>>>>>>> +		.value_size = value_size,
>>>>>>> +		.output = &output,
>>>>>>> +		.do_output = &do_output
>>>>>>> +	};
>>>>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>>>
>>>>>> bpf_loop() is old and generally not recommended.
>>>>>> Please use bpf_for() then the diff will be one line change and
>>>>>> can scale to any number of args. Not just 6.
>>>>
>>>> Thanks Alexei, I didn't know about this preference.
>>>>
>>>>> One thing we should take care is to support old kernels.  The oldest
>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>>>
>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>>>> trace: Collect augmented data using BPF") so we should be good using
>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
>>>
>>> Yep, we'd like to support old kernels.
>>
>> How much strict are you on this requirement? IMHO, the very least we
>> need to fix the verifier issue is bpf_loop, so that would still not work
>> on 5.10 and 5.15 LTS kernels.
> 
> I don't think it's an absolute requirement, but I think we don't want to
> break any existing working setup (old kernel + old compiler).
> 
>>
>> We could probably keep the open-coded loop in case bpf_loop is not
>> available but `perf trace` would still fail on kernels without bpf_loop
>> for new perf built with Clang>=22. Also, the code would be a bit ugly
>> and I'm not sure how well the feature check for helpers (bpf_loop) works
>> on old kernels.
>  
> Any chance process_arg_cb() can be called directly in the regular for
> loop on old kernels?

That's my thinking, too. Should be pretty straightforward, I'm going to
give it a try in v2.

Viktor

