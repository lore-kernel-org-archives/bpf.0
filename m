Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DC3A5445
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886338; cv=none; b=Lfq6k863wfaQZLx+7xkzT0nTNfS5v5VDYuTn3djIoJBhVXM/P49wn4ZBt3e+moUEaR50W1wFO3GPMJarJHmTFJw6GiEJpaD89uCPoWw/TqjUTI5WMmxSJ/6ruDn0lKDVcPIm7KWmROWUSNdqqV9GYw0/tv2bmasqRlfGG2wZO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886338; c=relaxed/simple;
	bh=axtW8/E5odg42acXCN2N5ZM3efqfJKTm9KBxg/gxNJs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ivQcXDMH3VPZCYqCDvps7XF1vPKvja+B8VhjJdrTLK6GsKhGlnZwuldPxNC2o6ns/EdHBnQoOI/ATS368NETYAgGeDRM4t+D+xJCfJwSt8/VdbWPitAwYmkkvSrsCPGaODbhN95PruaYYel5Q/il7GrXLOuFeos93V3mouUgZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d52AzAj0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jDAyIqLz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d52AzAj0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDAyIqLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782886334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rGM5F4C5doc2XH3pGdlOSav5YBUMCKxwGFp3MSQfb3E=;
	b=d52AzAj06Acu9GElQR4Bbr5yLtcAYcMRjlmnC0E/mEjZfCEFhhrmn7GXZFXFzrY2Hizjzy
	4H562mRCMlReKEJVL/Ku/cOkS1tAc4Bd0fKuCDCVuWuYZsd3bx7lC6v3mu5c+LUPxNaD8V
	AyG7jeoIsnTgTxJ2tMO5z9CyyXNjvoI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-gexLxIG1OMyACCkWvW-Nvg-1; Wed, 01 Jul 2026 02:12:12 -0400
X-MC-Unique: gexLxIG1OMyACCkWvW-Nvg-1
X-Mimecast-MFC-AGG-ID: gexLxIG1OMyACCkWvW-Nvg_1782886332
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4767036f8faso146027f8f.3
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 23:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782886331; x=1783491131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rGM5F4C5doc2XH3pGdlOSav5YBUMCKxwGFp3MSQfb3E=;
        b=jDAyIqLzkQWksdcANYNYgFwi7WZ5R9s8wHKu4YvCiYl9FlNPSsrTslhVIWeWBiUAWP
         o7q61TBOdFMCNZHaMgHSYeKQbp7jEez+2BVXYXTSIPjvMFZJrOte8/OUKWdKPVQlVM/R
         7JfYT/zTX5jB1Bfowxduk1EpYLkcaHu8HOhuYdfpGd/ED2Zhhb0AwjXD9EWZS/fbJkza
         7eIf69kw5DPIqOtxJE9WI+CX2ES9FHCgPET/qlKOvE9+/f/NNXP1Q+vR2sRyRaVbOvvz
         Q0wuaUvau903I8LcFojY1FZm+0Ul/F1nIdnffZpU6fw7dbX815bp6Rp8ke+Sy/XPjqtG
         2e3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782886331; x=1783491131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGM5F4C5doc2XH3pGdlOSav5YBUMCKxwGFp3MSQfb3E=;
        b=Y/PeHRtLHnluiX96EZ3lXWOejJg2PYfzRCOfYKo3JjgIoc2VRfz2y4Uhyxs5OCVILH
         EZpSI07/T90Fa9ZX28LHjG1onuF1/SXvGxx9pKemDTzSDbRIY4nZ1w3uIoxAAzeWxm8b
         eBvthtiULvv/xoIIr177wCFVcojlDaVo5yWJN86xfVJj+pTbwQPFuB01OYX9qgJjtfDa
         zmuQ6/SCoof0vk0N9PzAwqER9FPx5uDyh3/VQddBGuY1TYFT1GR9ZbiWeNUdddfFU2a5
         1NK7DYPxnM6EIYO7SKNTOtikxTzGRzK2WwLu4WgRO0ZWWulNlIhoG9lyNtHgO03yH/JE
         4v7Q==
X-Forwarded-Encrypted: i=1; AHgh+RrK1SDXWcyhGSfe1ATDFfLudDRU6F6ocs3xqawsnq9M3tWFWdB5L4JPSpyQMQxBQsYaT2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMyJVRZYco9tw9EQiZkIyz+CIEUbT4LjBWTwBaN2ovBXi4hJb
	NaIArgnam/3P6qgEug+UJghiQlMn95gZbHn9m83g3TCoLOOHOwUcjLWyAqVo/3hQC5rIx6sAfRv
	haOUoA7aNGgyzLG4o7GuMGGgFE32ixuZUkXRn0jGFgfM3Smgob/9B
X-Gm-Gg: AfdE7ckz2HPE8fvwjOIleqI12gItvAPqorIFkGG1sZwlp8jhnI/RRz2Onz2eF56ptJZ
	6tM25wt+srn5n8LQ+v6iDg4vONJqWOGRqv6YfYWiQWTJayox9yigqCKlDkABhwesUs2wMsfwKz/
	8bV+R+3IVWtTtM2DcIZo+jvjq6VWnagGz3P0S2+8pMdmS8BJ/r2iCbquQkz6j8V2HtHoIf+Mu21
	vXJLKBfFa1jU99OTYBNPX2qWb3r6AFqufqZEntS9Mo4kz4y1apNK0nD5COYK+JwBzMi21Yr6ao/
	VYxm2qP1Yu6N5nnTyEAb5LW8Z97HBepXoU0txnr8QQWfUU9PWZYvmnzy11tsb3iaeyMeBoNbyg=
	=
X-Received: by 2002:a05:6000:604:b0:460:70ae:f1af with SMTP id ffacd0b85a97d-47757e57d4emr348553f8f.27.1782886331568;
        Tue, 30 Jun 2026 23:12:11 -0700 (PDT)
X-Received: by 2002:a05:6000:604:b0:460:70ae:f1af with SMTP id ffacd0b85a97d-47757e57d4emr348514f8f.27.1782886331211;
        Tue, 30 Jun 2026 23:12:11 -0700 (PDT)
Received: from [10.43.17.14] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475643cd85dsm13446118f8f.15.2026.06.30.23.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 23:12:10 -0700 (PDT)
Message-ID: <360bfd5c-b023-4952-9e24-53fcc26690d3@redhat.com>
Date: Wed, 1 Jul 2026 08:12:06 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Refactor augmented_raw_syscalls using
 bpf_loop
From: Viktor Malik <vmalik@redhat.com>
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
 <c1666061-c3e7-4eda-82ca-d03daf05f4f8@redhat.com>
Content-Language: en-US
In-Reply-To: <c1666061-c3e7-4eda-82ca-d03daf05f4f8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 07:42, Viktor Malik wrote:
> On 6/29/26 22:35, Namhyung Kim wrote:
>> On Thu, Jun 25, 2026 at 02:05:29PM +0200, Viktor Malik wrote:
>>> On 6/24/26 21:24, Namhyung Kim wrote:
>>>> On Wed, Jun 24, 2026 at 08:47:38AM +0200, Viktor Malik wrote:
>>>>> On 6/23/26 19:10, Namhyung Kim wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Tue, Jun 23, 2026 at 08:27:39AM -0700, Alexei Starovoitov wrote:
>>>>>>> On Tue Jun 23, 2026 at 4:25 AM PDT, Viktor Malik wrote:
>>>> [SNIP]
>>>>>>>> +	struct args_loop_ctx loop_ctx = {
>>>>>>>> +		.args = args,
>>>>>>>> +		.beauty_map = beauty_map,
>>>>>>>> +		.payload_offset = payload_offset,
>>>>>>>> +		.value_size = value_size,
>>>>>>>> +		.output = &output,
>>>>>>>> +		.do_output = &do_output
>>>>>>>> +	};
>>>>>>>> +	iters = bpf_loop(6, process_arg_cb, &loop_ctx, 0);
>>>>>>>
>>>>>>> bpf_loop() is old and generally not recommended.
>>>>>>> Please use bpf_for() then the diff will be one line change and
>>>>>>> can scale to any number of args. Not just 6.
>>>>>
>>>>> Thanks Alexei, I didn't know about this preference.
>>>>>
>>>>>> One thing we should take care is to support old kernels.  The oldest
>>>>>> LTS kernel in the kernel.org is 5.10 and bpf_loop() was introduced in
>>>>>> 5.17 and bpf_for (bpf_iter_num) was 6.4.
>>>>>
>>>>> The problematic loop was introduced in 6.12 by a68fd6a6cdd3 ("perf
>>>>> trace: Collect augmented data using BPF") so we should be good using
>>>>> bpf_for. Or is perf from 7.2 supposed to work on 5.10 LTS kernels?
>>>>
>>>> Yep, we'd like to support old kernels.
>>>
>>> How much strict are you on this requirement? IMHO, the very least we
>>> need to fix the verifier issue is bpf_loop, so that would still not work
>>> on 5.10 and 5.15 LTS kernels.
>>
>> I don't think it's an absolute requirement, but I think we don't want to
>> break any existing working setup (old kernel + old compiler).
>>
>>>
>>> We could probably keep the open-coded loop in case bpf_loop is not
>>> available but `perf trace` would still fail on kernels without bpf_loop
>>> for new perf built with Clang>=22. Also, the code would be a bit ugly
>>> and I'm not sure how well the feature check for helpers (bpf_loop) works
>>> on old kernels.
>>  
>> Any chance process_arg_cb() can be called directly in the regular for
>> loop on old kernels?
> 
> That's my thinking, too. Should be pretty straightforward, I'm going to
> give it a try in v2.

Btw, I just noticed that util/bpf_skel/lock_contention.bpf.c already
uses bpf_loop without any fallback so newer perf (at least `perf lock`)
won't be usable on kernels without bpf_loop anyways.

