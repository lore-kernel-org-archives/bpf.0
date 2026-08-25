Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CECC23EA94
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 05:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635045; cv=none; b=ADqbejiq3Zxh8bv9Z2IcOJvCcUngzY9dIiHDVDrSTU/bOC3qpVV3AKHudpFnGR5hTDiIchQWJDlD/qwANQPQJz5K6BY5qbBf64flSf1an6KcMIsRFIXr4yTiH+kQtGHx0xDAGbQlXVtefiugm+Hz0iGqTEjLXM3W1PTemi+5g18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635045; c=relaxed/simple;
	bh=9PxiUEhNs0QEoZNWcrStmTbnn5tMM7qCOJzneWfUU0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQUWlJ5XCi+KaqTqcQMV+wOf3i9LxT7K0SwR/o71d0R+n08tXpWKHVt79G+7Qsn+EUfoUti1hm9hkKFZPNA4usNDM6eC+eC2RjiIeBoO7JuZGP09s4yruWRcpVLu5lNn0WGr5+rzoXSXRkWf8hHg63E5rtl8B6Hu7vJsfFg6pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KEkwVraW; arc=none smtp.client-ip=95.215.58.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KEkwVraW"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9PxiUEhNs0QEoZNWcrStmTbnn5tMM7qCOJzneWfUU0s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787635042; v=1; x=1788239842;
 b=KEkwVraWIlw1eXqCriqluIhQUgA4vaYiM27sMCMWPsYFa2KRcdwYvqFG9K67p8mPrlj3LN1V
 wrv4wp3fzTGQ13E4LYJcO2dO0CRouMzQ4cnCRYeXlSw/FuykwJCI5s6SXlZwIJlf1MPRn7fnnb1
 J+MXPBKYapPJsOMSzs4SzRNM=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.22.64.46] (122.11.166.8)
	by smtp.migadu.com with ESMTPS id f51d73458007ef9f;
	Tue, 25 Aug 2026 05:17:22 +0000
X-Mizu-Trace-ID: f51d73458007ef9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <b8f1e71d-0fe6-47b5-bf59-0e077e5806ad@linux.dev>
Date: Tue, 25 Aug 2026 13:17:10 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Avoid flaky resize value test
 for percpu data
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com
References: <20260818153202.90714-1-leon.hwang@linux.dev>
 <948e7ff41f942519880f9789faf6ca8ed9d0e2cf42eab5b9e1567ead5367b830@mail.kernel.org>
 <a1b1c6ee-ad7d-4972-a15b-f567e7787a6c@linux.dev>
 <CAEf4Bza6X9SZmnyqdZDFKJG5nWchuaEuFyC-MbuzQCuZ+dwq+w@mail.gmail.com>
 <90bbc900-21cd-4dfb-a058-13930378052f@linux.dev>
 <CAEf4BzZY-C3WtoRkdi+U7XFAMv59JeJ2R0yMi8+FGM4sLTsnQQ@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZY-C3WtoRkdi+U7XFAMv59JeJ2R0yMi8+FGM4sLTsnQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/8/26 04:04, Andrii Nakryiko wrote:
> On Sun, Aug 23, 2026 at 10:02 PM Leon Hwang <leon.hwang@linux.dev> wrote:
[...]
>>>
>> It is to verify the mmap change in libbpf's bpf_map_mmap_resize() for
>> percpu data map, like those subtests in global_map_resize.c.
>>
> 
> this didn't explain much, but I think what you are trying to say is
> that this won't work for PERCPU arrays with PAGE_SIZE=64KB, because
> PERCPU value is limited to 32KB today, is that right?
> 

Right. Limiting PAGE_SIZE=4KB is to avoid the
test_global_percpu_data__load() failure due to PERCPU value 32KB limit
when PAGE_SIZE is 64KB.

> 
> so maybe actually model that in the test itself, expect -E2BIG if
> PAGE_SIZE > 32KB or something, and otherwise check the resize?
> 
How about skipping test_percpu_data_on_cpus() when
test_global_percpu_data__load() returns -E2BIG? Because
bpf_map__set_value_size() has already been verified before calling
test_global_percpu_data__load(). Afterward, it's unnecessary to check
PAGE_SIZE value.

Thanks,
Leon

