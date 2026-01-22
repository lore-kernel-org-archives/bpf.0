Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61F392B88
	for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095930; cv=none; b=XRBAbIbTnm7F+ael4EYwqnxo60XAfjQFqG9CBisuf5avpIVVLXxEsqRxLZQXPRcQHOltyy9JoMueOF9wzHdrhKAmw+BycfYcoZn3FCBQAfVbex89lpBFeYnI+5c9ixJq9inIIPkFNpp1rC4titiyLgCZEk/bmJgeTnoi5MpsSm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095930; c=relaxed/simple;
	bh=MY43wR6LCaRe9Ftu7MHZk32lhl0/K4sJgBk+Rj4r8xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdnnYLrsk+QBtCAvvz8yo23iWkazBQSp54MBsO/0Vn2Gv2UAg/hI+qthlWm3H0DMh3H59EUKgxuC6d22yLN7vDFc4oOUqiKS1Q2u1oc+FxOKBTrls0AOSLmyNDJaG+EzGV2b7kJ0dB2cfNiKdpSmE+HxrBTDqq/bfql66ywYmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TFxwO3Xy; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TFxwO3Xy"
Message-ID: <342128a1-30e5-403e-abbe-0d49f76765db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769095925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ipGZtZSc/go6xfLTyhfOREhS72TisUuT8hbzWM9rrk=;
	b=TFxwO3Xy5xh7H2y59HEUJuq2JJzAFa0NyLlh5iMXYfu7UtNdKb/FG5bHQYwHpndedguESm
	s5nXEVMvIbEGFUBRYVnQnyOmv84oat786Udu+m18OOV0tKHPeW0HdQDezfEWdu6pJR3ZD5
	pyTkOoPgHtxng3SQXUsOHCToNAHUcGM=
Date: Thu, 22 Jan 2026 07:31:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix xdp_pull_data failure
 with 64K page
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>, Amery Hung <ameryhung@gmail.com>
References: <20260120210925.2544657-1-yonghong.song@linux.dev>
 <20260120210930.2544950-1-yonghong.song@linux.dev>
 <45c5425c-351c-4db4-b069-9ba0a03a7021@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <45c5425c-351c-4db4-b069-9ba0a03a7021@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/22/26 3:02 AM, Alan Maguire wrote:
> On 20/01/2026 21:09, Yonghong Song wrote:
>> If the argument 'pull_len' of run_test() is 'PULL_MAX' or
>> 'PULL_MAX | PULL_PLUS_ONE', the eventual pull_len size
>> will close to the page size. On arm64 systems with 64K pages,
>> the pull_len size will be close to 64K. But the existing buffer
>> will be close to 9000 which is not enough to pull.
>>
>> So for 64K page size and selective run_tests(), increase
>> buff size from 9000 to 90000 to ensure enough buffer space
>> to pull.
>>
>> Cc: Amery Hung <ameryhung@gmail.com>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
>
> one optional suggestion below..
>
>
>> ---
>>   .../selftests/bpf/prog_tests/xdp_pull_data.c     | 16 +++++++++++-----
>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> index efa350d04ec5..32ac99406d28 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_pull_data.c
>> @@ -8,6 +8,7 @@
>>   #define PULL_PLUS_ONE	(1 << 30)
>>   
>>   #define XDP_PACKET_HEADROOM 256
>> +#define PAGE_SIZE_64K 65536
>>   
>>   /* Find headroom and tailroom occupied by struct xdp_frame and struct
>>    * skb_shared_info so that we can calculate the maximum pull lengths for
>> @@ -114,12 +115,17 @@ static void test_xdp_pull_data_basic(void)
>>   {
>>   	u32 pg_sz, max_meta_len, max_data_len;
>>   	struct test_xdp_pull_data *skel;
>> +	int buff_len;
>>   
>>   	skel = test_xdp_pull_data__open_and_load();
>>   	if (!ASSERT_OK_PTR(skel, "test_xdp_pull_data__open_and_load"))
>>   		return;
>>   
>>   	pg_sz = sysconf(_SC_PAGE_SIZE);
>> +	if (pg_sz == PAGE_SIZE_64K)
>> +		buff_len = 90000;
>> +	else
>> +		buff_len = 9000;
>>   
> nit: should we generalize here and just use 1.5 * pg_sz; i.e.
>
> 	buff_len = pg_sz + (pg_sz/2);
>
> that would eliminate the need for the 64k page size #define.

Thanks for suggestion! This indeed simpler. Will make the change in v2.

>
>>   	if (find_xdp_sizes(skel, pg_sz))
>>   		goto out;
>> @@ -140,13 +146,13 @@ static void test_xdp_pull_data_basic(void)
>>   	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 1025, 1025);
>>   
>>   	/* multi-buf pkt, empty linear data area, pull requires memmove */
>> -	run_test(skel, XDP_PASS, pg_sz, 9000, 0, 0, PULL_MAX);
>> +	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, 0, PULL_MAX);
>>   
>>   	/* multi-buf pkt, no headroom */
>> -	run_test(skel, XDP_PASS, pg_sz, 9000, max_meta_len, 1024, PULL_MAX);
>> +	run_test(skel, XDP_PASS, pg_sz, buff_len, max_meta_len, 1024, PULL_MAX);
>>   
>>   	/* multi-buf pkt, no tailroom, pull requires memmove */
>> -	run_test(skel, XDP_PASS, pg_sz, 9000, 0, max_data_len, PULL_MAX);
>> +	run_test(skel, XDP_PASS, pg_sz, buff_len, 0, max_data_len, PULL_MAX);
>>   
>>   	/* Test cases with invalid pull length */
>>   
>> @@ -154,7 +160,7 @@ static void test_xdp_pull_data_basic(void)
>>   	run_test(skel, XDP_DROP, pg_sz, 2048, 0, 2048, 2049);
>>   
>>   	/* multi-buf pkt with no space left in linear data area */
>> -	run_test(skel, XDP_DROP, pg_sz, 9000, max_meta_len, max_data_len,
>> +	run_test(skel, XDP_DROP, pg_sz, buff_len, max_meta_len, max_data_len,
>>   		 PULL_MAX | PULL_PLUS_ONE);
>>   
>>   	/* multi-buf pkt, empty linear data area */
>> @@ -165,7 +171,7 @@ static void test_xdp_pull_data_basic(void)
>>   		 PULL_MAX | PULL_PLUS_ONE);
>>   
>>   	/* multi-buf pkt, no tailroom */
>> -	run_test(skel, XDP_DROP, pg_sz, 9000, 0, max_data_len,
>> +	run_test(skel, XDP_DROP, pg_sz, buff_len, 0, max_data_len,
>>   		 PULL_MAX | PULL_PLUS_ONE);
>>   
>>   out:

