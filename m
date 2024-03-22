Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998BE5C8F8
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125705; cv=none; b=EhVFETIWjCh+w0lYOXZBQ8QhjlbsBO8SuwprwPMGAeZ53bQsO84cetKg1bhbnHqoLMJAxKU7PDxZ2QoX/1HG0dK1nziE6apL/PHD39IyzSutzJttfkOonQ/ziaa5o2xKwG/kWa0znLOtL2RcEYyi1MVieoOECtkCaHaq4s31J94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125705; c=relaxed/simple;
	bh=5/2U7V1+CtlLFFvCfr4Q8rhMIvMI2aFcC9Avuk39RBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEojJBCYYHEdQjafaiFbNKe0l0OGxS8uqgDzVgfSAv6oOD8oCWJvZoV+xbjSqvn0VfxrKfRMU6HUqV82aZnQ3zHT+qjtuniCAfRwNKK0Q6QVl4cdsxrZGJ5wRHKjaQToc7d4xkD8rrhkKlnAtP26eIuUy/q+ITY81ocnGToov0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YXV7eC5u; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YXV7eC5u"
Message-ID: <b5d76a69-0ca3-4900-980f-2c9c32988f8e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711125701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auWXzbmmQMtSZG48fU+sSXqAm7tB5WV0Icb8HmAr4eI=;
	b=YXV7eC5uPU3afhdP/tx8PJBJJPkU+TAtqzPB8WYlg1wRrrUDuiH6UmCCGAX7BBCItcERYo
	Tl15m/EgykWGOnLnEP+wXgshmDVrd93e7bP0YdwZsW63C9VUjq/rMS8kSjoMM5S1pSozcF
	iblofE1yN8/CHi+KApLydCUoHGwoYiY=
Date: Fri, 22 Mar 2024 09:41:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/5] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240321200058.2218328-1-yonghong.song@linux.dev>
 <20240321200103.2218888-1-yonghong.song@linux.dev>
 <CAEf4BzZnaWjyUBonL=YBFS+9z7E_FBcJAwEaYuDGGrA-Z6zZ0Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzZnaWjyUBonL=YBFS+9z7E_FBcJAwEaYuDGGrA-Z6zZ0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/22/24 9:13 AM, Andrii Nakryiko wrote:
> On Thu, Mar 21, 2024 at 1:01 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>> I am going to modify ksyms test later so take this opportunity
>> to replace old CHECK macros with new ASSERT macros.
>> No functionality change.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/ksyms.c  | 30 ++++++-------------
>>   1 file changed, 9 insertions(+), 21 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> index b295969b263b..6a86d1f07800 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> @@ -5,8 +5,6 @@
>>   #include "test_ksyms.skel.h"
>>   #include <sys/stat.h>
>>
>> -static int duration;
>> -
>>   void test_ksyms(void)
>>   {
>>          const char *btf_path = "/sys/kernel/btf/vmlinux";
>> @@ -18,43 +16,33 @@ void test_ksyms(void)
>>          int err;
>>
>>          err = kallsyms_find("bpf_link_fops", &link_fops_addr);
>> -       if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
>> -               return;
>> -       if (CHECK(err == -ENOENT, "ksym_find", "symbol 'bpf_link_fops' not found\n"))
>> +       if (!ASSERT_TRUE(err != -EINVAL && err != -ENOENT, "bpf_link_fops"))
>>                  return;
> it's best to keep each individual equality test as ASSERT_EQ(), that
> way we get more specific and detailed error (with expected vs actual
> value), which here we'll just get "wanted true but got false", and
> then we'd have to debug some more which of the conditions it is. So
> please keep the original granularity of checks everywhere.

Do you mean

         if (ASSERT_EQ(err, -EINVAL, "..."))
                 return;
         if (ASSERT_EQ(err, -ENOENT, "..."))
                 return;

This does not really work, for example if err = 0, it will declare test 
failure.


>
>>          err = kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
>> -       if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
>> -               return;
>> -       if (CHECK(err == -ENOENT, "ksym_find", "symbol 'per_cpu_start' not found\n"))
>> +       if (!ASSERT_TRUE(err != -EINVAL && err != -ENOENT, "__per_cpu_start"))
>>                  return;
>>
>> -       if (CHECK(stat(btf_path, &st), "stat_btf", "err %d\n", errno))
>> +       if (!ASSERT_OK(stat(btf_path, &st), "stat_btf"))
>>                  return;
>>          btf_size = st.st_size;
>>
>>          skel = test_ksyms__open_and_load();
>> -       if (CHECK(!skel, "skel_open", "failed to open and load skeleton\n"))
>> +       if (!ASSERT_OK_PTR(skel, "test_ksyms__open_and_load"))
>>                  return;
>>
>>          err = test_ksyms__attach(skel);
>> -       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
>> +       if (!ASSERT_OK(err, "test_ksyms__attach"))
>>                  goto cleanup;
>>
>>          /* trigger tracepoint */
>>          usleep(1);
>>
>>          data = skel->data;
>> -       CHECK(data->out__bpf_link_fops != link_fops_addr, "bpf_link_fops",
>> -             "got 0x%llx, exp 0x%llx\n",
>> -             data->out__bpf_link_fops, link_fops_addr);
>> -       CHECK(data->out__bpf_link_fops1 != 0, "bpf_link_fops1",
>> -             "got %llu, exp %llu\n", data->out__bpf_link_fops1, (__u64)0);
>> -       CHECK(data->out__btf_size != btf_size, "btf_size",
>> -             "got %llu, exp %llu\n", data->out__btf_size, btf_size);
>> -       CHECK(data->out__per_cpu_start != per_cpu_start_addr, "__per_cpu_start",
>> -             "got %llu, exp %llu\n", data->out__per_cpu_start,
>> -             per_cpu_start_addr);
>> +       ASSERT_EQ(data->out__bpf_link_fops, link_fops_addr, "bpf_link_fops");
>> +       ASSERT_EQ(data->out__bpf_link_fops1, 0, "bpf_link_fops1");
>> +       ASSERT_EQ(data->out__btf_size, btf_size, "btf_size");
>> +       ASSERT_EQ(data->out__per_cpu_start, per_cpu_start_addr, "__per_cpu_start");
>>
>>   cleanup:
>>          test_ksyms__destroy(skel);
>> --
>> 2.43.0
>>
