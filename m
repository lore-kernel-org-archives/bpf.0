Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA03AE6F2
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117906; cv=none; b=bCRtuOrdTCWMXypUuEsHhioMmnQOXXFQBVMhUcA0xxnE0Cdl6u11+QkpneoQwiE2BrM3rnN3GcYiMCxH+gOzF4a4YHYIlpTKU74n0SxYHJORLkyLDg8r3NNh2lcWoGwrYyQ0vMoIaxWzWMiq9LwWGnJ62Yps4zpN9FmYRg5C9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117906; c=relaxed/simple;
	bh=LKPXZmWKedR2yKcisDKiiFlcLJ53y6k+q8cPc/EOEZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qa+8ICY9V7tH8vxrmKx2wjFFi3pmZoDrE3wRzV80LNnfJ7TYt4t9uO3r8l6XVD4VM2R7NH6E3763b5/UOBqDkrGi8eJJMTuBOUiN6deTIXgxDujYsnfjJ0/viBM/9z6FhXHROAQo1bO6wDSKoDBE/ZnXWCH+bs7VfQO/6vmk3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JgP1gOqe; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JgP1gOqe"
Message-ID: <d30fce68-01d9-44ef-bb28-28b6d2bdb13d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769117893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9iFa7uVaH8PDNRcnceCrllLmgClSyzjBzvOeVYf1LM=;
	b=JgP1gOqeDVFUSDtRG3jsTcjExyfBZezxGOyjDmfIF2ROu3dRJwvLb5NkI05ci6XZgGcptm
	YUKVSE2HnsNsVAeUeybT8MF4r2cLzPmF8ArbXfmI/4grbPNWJc/eGyNnITX9KHPSxxecrb
	W5HnLuYOBw+UFmlkkwRZ5YK1Mx+HOVo=
Date: Thu, 22 Jan 2026 13:38:07 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
Content-Language: en-GB
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>
References: <20260122162616.3578898-1-yonghong.song@linux.dev>
 <20260122162621.3579387-1-yonghong.song@linux.dev>
 <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAMB2axP_AaoiZB9BSQ3Mz_M0e0t1S-y3u8KnBx1FY1nCq3qN6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 1/22/26 1:18 PM, Amery Hung wrote:
> On Thu, Jan 22, 2026 at 8:56 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
>> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
>> will close to the page size. On arm64 systems with 64K pages,
>> the pull_len size will be close to 64K. But the existing buffer
>> will be close to 9000 which is not enough to pull.
>>
>> For those failed run_tests(), make buff size to
>>    2 * pg_sz + (pg_sz / 2)
>> This way, there will be enough buffer space to pull
>> regardless of page size.
>>
>> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>> Cc: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   .../testing/selftests/bpf/prog_tests/xdp_pull_data.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> Changelog:
>>   v1 -> v2:
>>     - v1: https://lore.kernel.org/bpf/20260120210930.2544950-1-yonghong.song@linux.dev/
>>     - Use pg_sz to simplify buff_len calculation.
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> index efa350d04ec5..35f0eb5b43f3 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> @@ -114,12 +114,14 @@ static void test_xdp_pull_data_basic(void)
>>   {
>>          u32 pg_sz, max_meta_len, max_data_len;
>>          struct test_xdp_pull_data *skel;
>> +       int buff_len;
>>
>>          skel = test_xdp_pull_data__open_and_load();
>>          if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>>                  return;
>>
>>          pg_sz = sysconf(_SC_PAGE_SIZE);
>> +       buff_len = 2 * pg_sz + pg_sz / 2;
> Thanks for fixing the test. Just curious if there is an issue with 1.5
> pg_sz as suggested by Alan?

Although existing 'buff_len = 2 * pg_sz + pg_sz / 2' works fine for the test,
but let us use the Alan's suggestion (buff_len = pg_sz + pg_sz / 2)
since the buffer size is tighter and potentially better for test.

>
>>          if (find_xdp_sizes(skel, pg_sz))
>>                  goto out;

[...]

