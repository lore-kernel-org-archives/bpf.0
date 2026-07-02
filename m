Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1E38734E
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973435; cv=none; b=KOrWtoZmw/k5X9XNY0glpORcl1i1gd/cu5xQ4aXv9NhJ6QxxkCmaZTfhS08XEuHH9J5V8FPQZOZcCegs9/lqMxzhzAnjVSc0p+nSI73SwP3+9M+SMMIdDYGo8tl5dyB1FyS2yC0IzKmyvLjwbPJLuCtVQqZ15Plx1TurHw1tmI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973435; c=relaxed/simple;
	bh=AkWldYk6Yo8xJRbGmZRz3dlsYoYsoawN+0pDW5TrbYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CTjnd7dP4NAJjB1Ce9DxtZR4/82XgJ29CmxpJ2PBIZvzXUoScl2p4WUJhA3IG+HFcEVnbLX/o/T7UgTc44vmGmOzQpcUsKtg9xAz+IfWNwzpPrbn5WH0FdeLUWq82THbRGowVW4UrMojOeCwlKAt3G5Nh8MlCmg5vcBNnkLXyQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n7Uc/T+Y; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n7Uc/T+Y"
Message-ID: <6ac505f6-818d-4abb-bdca-6b96f1ce30f2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782973421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Igqs9OSLyw+8Ulfrs4et+zHMEYP27SGxn/Lxph0feD0=;
	b=n7Uc/T+YQ5OvgRxEs/gTfoFc0ziRzeX0N47aQNY5oYd7lL7VFaJ+dxe64hO041kzvCdu02
	vxCpoLKemhRnFxhs3VuwJThYPLPAy1scQpse2Sk6Y43uEwrDqjvYp5tMPwQD1fZncnvb44
	JdNMroJYzBF3EIDzrHRjpR8atB+4tcQ=
Date: Thu, 2 Jul 2026 14:23:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v8 4/9] libbpf: Add support for global percpu
 data
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-5-leon.hwang@linux.dev>
 <20260629154055.6DD941F00A3A@smtp.kernel.org>
 <96cbecfc-bae6-46ff-90a7-5f4703e1c44c@linux.dev>
 <CAEf4BzbBpDQOG-xUArBzZa_qZ08q=QViH-bbFmqwLNesGvJLUA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzbBpDQOG-xUArBzZa_qZ08q=QViH-bbFmqwLNesGvJLUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/7/26 03:31, Andrii Nakryiko wrote:
> On Mon, Jun 29, 2026 at 10:55 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> On 29/6/26 23:40, sashiko-bot@kernel.org wrote:
>> [...]
>>>> @@ -1983,7 +1989,7 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>>>>      }
>>>>
>>>>      def = &map->def;
>>>> -    def->type = BPF_MAP_TYPE_ARRAY;
>>>> +    def->type = is_percpu ? BPF_MAP_TYPE_PERCPU_ARRAY : BPF_MAP_TYPE_ARRAY;
>>>>      def->key_size = sizeof(int);
>>>>      def->value_size = data_sz;
>>>
>>> [Severity: High]
>>> This is a pre-existing issue, but could this integer truncation lead to a
>>> buffer overflow?
>>>
>>> If a user supplies a crafted ELF file with a section (like .data, .rodata,
>>> or .percpu) larger than 4GB, the 64-bit data_sz is implicitly truncated when
>>> assigned to the 32-bit def->value_size.
>>>
>>> This results in a smaller mmap allocation based on the truncated value. Later
>>> in bpf_object__init_internal_map(), memcpy uses the original 64-bit data_sz:
>>>
>>>       if (data)
>>>               memcpy(map->mmaped, data, data_sz);
>>>
>>> Can this overflow the allocated buffer when parsing unverified BPF objects?
>>>
>>
>> Sounds reasonable.
>>
>> The data_sz value comes from the ELF file and therefore cannot be
>> trusted, as the section size can be malformed.
>>
>> For example, readelf -a shows the following for a normal ELF:
>>
>>   [ 3] .data             PROGBITS         0000000000000000  00000040
>>        0000000000000004  0000000000000000  WA       0     0     4
>>
>> The section size can be modified to:
>>
>>   [ 3] .data             PROGBITS         0000000000000000  00000040
>>        0000000100000001  0000000000000000  WA       0     0     4
>>
>> In this case, data_sz would be truncated to 1.
>>
>> However, in practice, there won't be larger than 4GB section in bpf ELF
>> file. And, it is meaningless to hack libbpf to corrupt user space memory.
>>
>> Of course, will post a separate patch for further discussion.
> 
> No, don't. All this hardening of libbpf is nonsensical. libbpf is not
> meant to protect against corrupted ELF. If you don't trust the source
> of ELF, you should definitely not attempt to open BPF object and load
> it into kernel to run with root-like capabilities.
> 
Got it.

I didn't post the separate patch.

Thanks,
Leon

