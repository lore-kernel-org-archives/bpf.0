Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3A346E43
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769122743; cv=none; b=PcT4wtF7UJxFZQDEVi4pH3JSTQIfGZgR2gas58UNu1EGFKAncLxXP8Ft94BmKNYHc4EO9X3wVg9Jq2YRb+b8e2Yjnnyu1+F10243bMefs4lDGe3pmoNMrnK47YDFFnz42zPrLxHqtH3aYH8NE8qZg6GPdOfdDQZGPz+YLGUzy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769122743; c=relaxed/simple;
	bh=K+m1a+DWTuIm77nOsJ/RceoAEEij+o/Sw6Lrk/TF0fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4iRlT56Sf6P3hEzLkKKCZ1Tr0fSdweVgujep4ebzTg4AC5TuyuurROxJSdPLkkuOyrVGnKxtU6TRnbjlyihXTuvTxfGOYmKDa45izTxO+FDjk2gpMDcG+AasyB71KQl1ktuXmKtKswewV07h6SSSEGFVQR7qXEch/jNSH7UN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvAMJkNP; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvAMJkNP"
Message-ID: <3e2fbe5f-d28a-447c-9733-32091f461454@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769122725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wualuPseHubDO8BPuWYgZi1vSQvDIr2Zr6WlSi6n1DY=;
	b=EvAMJkNPYPHvxWgaNM+N4IU+R+qGjZTDWQvlT/SA6E7JR2mWMov6gWzGTEUo2vXofBcn8R
	2BOFsWT8zvQHNp3NzWVLlNZC0mSpXqg1b9jDDYso/s8oaEv3cVOWwZtr2P6whDWD5aVfBI
	UkzO2lSNENoFWk0cQRNhQGZmOQ7wiw0=
Date: Thu, 22 Jan 2026 14:58:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Fix task_local_data
 failure with 64K page
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <CAMB2axPhNZXj86cby+4mgBFsVCzk4TnX=aC7PROkTd6Shh_sxA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axPhNZXj86cby+4mgBFsVCzk4TnX=aC7PROkTd6Shh_sxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/22/26 1:49 PM, Amery Hung wrote:
> On Thu, Jan 22, 2026 at 8:54 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> On arm64 systems with 64K pages, the selftest task_local_data has the following
>> failures:
>>    ...
>>    test_task_local_data_basic:PASS:tld_create_key 0 nsec
>>    test_task_local_data_basic:FAIL:tld_create_key unexpected tld_create_key: actual 0 != expected -28
>>    ...
>>    test_task_local_data_basic_thread:PASS:run task_main 0 nsec
>>    test_task_local_data_basic_thread:FAIL:task_main retval unexpected error: 2 (errno 0)
>>    test_task_local_data_basic_thread:FAIL:tld_get_data value0 unexpected tld_get_data value0: actual 0 != expected 6268
>>    ...
>>    #447/1   task_local_data/task_local_data_basic:FAIL
>>    ...
>>    #447/2   task_local_data/task_local_data_race:FAIL
>>    #447     task_local_data:FAIL
>>
>> When TLD_DYN_DATA_SIZE is 64K page size, for
>>    struct tld_meta_u {
>>         _Atomic __u8 cnt;
>>         __u16 size;
>>          struct tld_metadata metadata[];
>>    };
>> fields 'cnt' and 'size' would overflow. For example,
>> for 4K page, 'cnt' will be 4096/64 = 64. But for 64K page,
>> 'cnt' will be 65536/64 = 1024 and 'cnt' is not enough for 1024.
>> For field 'size', it is okay for value 4K, but it is not enough
>> for 64K as maximum 'size' value is '64K - 1'.
>>
>> To accommodate 64K page, '_Atomic __u8 cnt' becomes '_Atomic __u16 cnt'
>> and '__u16 size' becomes '__u32 size'. A few other places are adjusted
>> accordingly.
>>
>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> Cc: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/task_local_data.h    | 6 +++---
>>   .../testing/selftests/bpf/prog_tests/test_task_local_data.c | 2 +-
>>   tools/testing/selftests/bpf/progs/task_local_data.bpf.h     | 4 ++--
>>   3 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
>> index 2de38776a2d4..4c38f9a7bc90 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
>> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
>> @@ -94,8 +94,8 @@ struct tld_metadata {
>>   };
>>
>>   struct tld_meta_u {
>> -       _Atomic __u8 cnt;
>> -       __u16 size;
>> +       _Atomic __u16 cnt;
>> +       __u32 size;
> Agree cnt should be __u16.
>
> size can remain to be __u16 as maximum data size is page_size - 8
> byte. The 8 byte is tld_data_u->start recording thread-specific offset
> of data in a page.

In test_task_local_data.c, I made the change like below
    #define TLD_DYN_DATA_SIZE getpagesize()
so TLD_DYN_DATA_SIZE will be 64K for 64K page.

In function __tld_init_meta_p(), we have
   meta->size = TLD_DYN_DATA_SIZE;

So size needs to be 32 bit in order to hold the value 0x10000.

Are you saying
     #define TLD_DYN_DATA_SIZE getpagesize()
is not correct?
The previous one is
     #define TLD_DYN_DATA_SIZE 4096
for 4K page system. For 64K, I naturally tried
to replace the above 4096 with getpagesize().
Did I miss anything?

>
>>          struct tld_metadata metadata[];
>>   };
>>
>> @@ -217,7 +217,7 @@ static int __tld_init_data_p(int map_fd)
>>   static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
>>   {
>>          int err, i, sz, off = 0;
>> -       __u8 cnt;
>> +       __u16 cnt;
>>
>>          if (!TLD_READ_ONCE(tld_meta_p)) {
>>                  err = __tld_init_meta_p();
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
>> index 9fd6306b455c..cc4d49222d9d 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_task_local_data.c
>> @@ -4,7 +4,7 @@
>>   #include <test_progs.h>
>>
>>   #define TLD_FREE_DATA_ON_THREAD_EXIT
>> -#define TLD_DYN_DATA_SIZE 4096
>> +#define TLD_DYN_DATA_SIZE getpagesize()
>>   #include "task_local_data.h"
>>
>>   struct test_tld_struct {
>> diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
>> index 432fff2af844..e13f239b46b0 100644
>> --- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
>> +++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
>> @@ -80,8 +80,8 @@ struct tld_metadata {
>>   };
>>
>>   struct tld_meta_u {
>> -       __u8 cnt;
>> -       __u16 size;
>> +       __u16 cnt;
>> +       __u32 size;
> Same here. We can keep __u16 size.
>
>>          struct tld_metadata metadata[TLD_MAX_DATA_CNT];
>>   };
>>
>> --
>> 2.47.3
>>
>>

