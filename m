Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A14C637
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623278; cv=none; b=f+9GDgaZHyxUJg/FtVsJVAKHAY9dYzHntQdWnbEIbmwQCBzwMlXJUesTXeSSaaML6Kt7cHIGm4ban+aLklt0JFd6EHIcX2dDQm8EdgujTO6iMcjezC89HYNGbVve/7GZrib0bkE/QqS+MxxE3wuDyhsynC4xWeEZTaaaqcKYW/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623278; c=relaxed/simple;
	bh=SSx3l/6Zza77LO3fBTsery6Qzd6aF+c+Z90G38CZQsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4hklCtmYNgIl9McuaM9jygMCaVhyrR9Qy0eKKndqZevEmI9lcN7YoHyyy+5m2alkhdyVjUh2Hs8iAZOnetR2Ob2WtA6MFqnx5zGS9AKbPY5EFZfZGwITnsCDACbpCzeNvoz+A235/h7EHHE/U1OZxQt+pKNqqkYzKq5qmTQNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikX3Q3xC; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikX3Q3xC"
Message-ID: <5474994c-4c9e-4633-a189-b3dfe98906e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709623274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yMlyPjpYziSwc7HR2lHvxyMqB+l+M4MNRfN6i+ZFje0=;
	b=ikX3Q3xC6rLCyHTx63TTWOgLXSZwoBIWq6jjTkNBusjMF7wJb3YnU3d2TL7SxjubecEVmi
	25X0udFeoBgHeIBkOOnej0xkIMB7X0Mov2TCes4cDQmF46Yy2phJq/XJvqfaWkQscsxcaK
	fVZAqjia61BUe97rD6A8whV2TVfa6I0=
Date: Mon, 4 Mar 2024 23:21:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: Replace CHECK with ASSERT
 macros for ksyms test
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240302165017.1627295-1-yonghong.song@linux.dev>
 <20240302165022.1627562-1-yonghong.song@linux.dev>
 <CAEf4Bzad8b4ZxNjx_sK=pxGrEdz_M1-2VJAj6bsg7ZLA+5s_fg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4Bzad8b4ZxNjx_sK=pxGrEdz_M1-2VJAj6bsg7ZLA+5s_fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/4/24 4:17 PM, Andrii Nakryiko wrote:
> On Sat, Mar 2, 2024 at 8:50 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> I am going to modify ksyms test later so take this opportunity
>> to replace old CHECK macros with new ASSERT macros.
>> No functionality change.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/ksyms.c  | 38 +++++++++----------
>>   1 file changed, 19 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms.c b/tools/testing/selftests/bpf/prog_tests/ksyms.c
>> index b295969b263b..e081f8bf3f17 100644
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
>> @@ -18,43 +16,45 @@ void test_ksyms(void)
>>          int err;
>>
>>          err = kallsyms_find("bpf_link_fops", &link_fops_addr);
>> -       if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
>> +       if (err == -EINVAL) {
>> +               ASSERT_TRUE(false, "kallsyms_fopen for bpf_link_fops");
> should this (and few other cases below) be ASSERT_EQ()/ASSERT_NEQ()
> (whichever makes sense, I can't reason about CHECK() conditions).

The below 'err == -ENOENT' case will later be modified in Patch 3 where I cannot
do ASSERT_EQ(err, -ENOENT) which is why I do 'err == -EINVAL' here. But you have
a good point that ASSERT_EQ/NEQ is easier to understand. Will fix it in the next
revision.

>
> ASSERT_TRUE(false) is a last resort way, we have more meaningful checks.
>
>>                  return;
>> -       if (CHECK(err == -ENOENT, "ksym_find", "symbol 'bpf_link_fops' not found\n"))
>> +       }
>> +       if (err == -ENOENT) {
>> +               ASSERT_TRUE(false, "ksym_find for bpf_link_fops");
>>                  return;
>> +       }
>>
>>          err = kallsyms_find("__per_cpu_start", &per_cpu_start_addr);
>> -       if (CHECK(err == -EINVAL, "kallsyms_fopen", "failed to open: %d\n", errno))
>> +       if (err == -EINVAL) {
>> +               ASSERT_TRUE(false, "kallsyms_fopen for __per_cpu_start");
>>                  return;
>> -       if (CHECK(err == -ENOENT, "ksym_find", "symbol 'per_cpu_start' not found\n"))
>> +       }
>> +       if (err == -ENOENT) {
>> +               ASSERT_TRUE(false, "ksym_find for __per_cpu_start");
>>                  return;
>> +       }
[...]

