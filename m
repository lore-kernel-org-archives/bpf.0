Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2C627FC
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711146191; cv=none; b=lv17yKkTouxE1R0Uc02kKfpX04M394dvEku9zXNYUGyrRyNfAiNasZ2/xAH2aEc4Fbq3vSj4ZEvRwgA3jCdgQo9eW9R3n5/DGxNente8ZpB8udq/gjgady4SM79pqMKsXyGsmiC1Yt3lG0+7zaom1EUlHdkz2fNWRXLbV3pY+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711146191; c=relaxed/simple;
	bh=mBfTcR1k/5sbooD87fn9zMknyUdtHc+AwgSqjzNYlEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NukOQnz8b1dK5wW6SHpZZqeD4GQzB4Y+dUTb1xlx87Fhx4ibjHu4g7/x5fFlJauDSKV7ozBmiIku10TxQeoaMb/7C664UKHhz0fwitTqO+TOr0F2SAB1Se+hWrxkLk0UK/woijuQxDbY5tb1OF29qN0bp/GxFBerlsSX7Ht001A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rcpwMM6Z; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rcpwMM6Z"
Message-ID: <0dcd8c00-3b34-4eb8-b60d-1836b7bdce0c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711146187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zLEev0XiP/QmBS9ffYRxqYhRPOSQ600chcF++yPN4A=;
	b=rcpwMM6ZhFduwT85IJqrauMrXrhcHLwHojhV+tJT3HePjo+YwRh3SiCyv5Fjo6rB7QjHdc
	lHoojBwslaP1sazCQfPLJZDN9UKcWCYmLH/Jh3AyrffFVhDg1nRi3KbF+Bl8DyBTyuXSmA
	MN+djZRrK2B9gIkNDIjoqFvzZ40W4pM=
Date: Fri, 22 Mar 2024 15:23:01 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: Add a selftest with
 available_filter_functions_addrs
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200124.2220345-1-yonghong.song@linux.dev> <Zf147sHXbgMs1yDZ@krava>
 <0bb5c256-a564-417c-b252-166aec017870@linux.dev>
 <CAEf4BzboP30Qto0jtJ=-_dbxqA375qgKsY5J5VAt8DS3=sKE8w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzboP30Qto0jtJ=-_dbxqA375qgKsY5J5VAt8DS3=sKE8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 2:58 PM, Andrii Nakryiko wrote:
> On Fri, Mar 22, 2024 at 9:07 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> On 3/22/24 5:26 AM, Jiri Olsa wrote:
>>> On Thu, Mar 21, 2024 at 01:01:24PM -0700, Yonghong Song wrote:
>>>> The current kprobe_multi_bench_attach/kernel test
>>>> reads sym names from /sys/kernel/tracing/available_filter_functions.
>>>> Some names do not agree with the corresponding entries in /proc/kallsyms
>>>> since the corresponding /proc/kallsyms syms have suffix '.llvm.<hash>'.
>>>> Actually, if we pass symbol names in /proc/kallsyms,
>>>> kprobe_multi_attach will be okay.
>>>>
>>>> This patch added a new subtest where addresses are retrieved from
>>>> /sys/kernel/tracing/available_filter_functions_addrs, and use the
>>>> address to consule /proc/kallsyms to get the function name.
>>> hm, I don't understand the reason for this test.. AFAICS test_kprobe_multi_bench_attach
>>> is doing that already, just reading available_filter_functions file
>>>
>>> both available_filter_functions_addrs and available_filter_functions have the
>>> same functions, there's just extra addresses in available_filter_functions_addrs
>> The goal is to include those kernel functions filtered in patch 4.
>> But we cannot use the names from available_filter_functions[_addrs],
>> and we need to get names from /proc/kallsyms. Hence this patch.
>> This will test if we give names (<name>.llvm.<hash>) to kernel
>> for kprobe_multi_attach, things will be okay.
>>
> for patch #4 it would be good to not skip those *.llvm.* functions,
> but find the full name using kallsyms. While here we can use address

Okay, I will change patch #4 to lookup /proc/kallsyms to find the
full name. If we did that, then current patch #5 is not needed.

> based multi-attachment, while getting addresses from
> available_filter_functions_addrs? That way we'll have a test that
> benchmarks both symbol lookup paths in the kernel (where user provides
> symbol names as strings) and address-based lookup (where user provides
> raw addresses).

yes, we can use available_filter_functions_addrs
to have addrs available to kernel to do multi-attach.
will do. This will be yet another bench test.

>
>>>> +    *symsp = syms;
>>>> +    *cntp = cnt;
>>>> +
>>>> +error:
>>>> +    fclose(f);
>>>> +    hashmap__free(map);
>>>> +    if (err) {
>>>> +            for (i = 0; i < cnt; i++)
>>>> +                    free(syms[i]);
>>>> +            free(syms);
>>>> +    }
>>>> +    return err;
>>>> +}
>>>> +
> [...]
