Received: from mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FE30E821
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787671485; cv=none; b=KPc5Ic8EidtVRmTSOwmxO5zNcXdDjsMZWMUItWciYGXXAORMLIsXpvtv3LpOTqi46TpnAIDa7pb61hUEksYQmEc0S7iUVFY4MtHJ4Ulo9XxNuJtKt2+GrnimIZb21nHEvYI00fp8JJnfqLgvaoeUsw6PUmZOlVytF9iEtAhtH34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787671485; c=relaxed/simple;
	bh=BlQgacaKCXuF6uhvqy6ozhI7v2wSV9sOQFmkulfc+Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVbxmy5Rothlub8FvcHRMwdZPOQvAygvMZI3RxJKddlAZYMRtTpKnefCMs11/H57LGP+zk8NE5BDLiARO0ixYi0zi/7RyYNfkWbsN1l0vg3eF8UdcllEzsCJ7C5aEri/p0lIjx6VY9dOeCYPbIx5V56Z+kPIuUmR3Y9VQ9TeSDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rqzb3zwZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rqzb3zwZ"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=BlQgacaKCXuF6uhvqy6ozhI7v2wSV9sOQFmkulfc+Bk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787671481; v=1; x=1788276281;
 b=Rqzb3zwZokBMw5i4NI6rrtb0qv1swZBHp6DshqjVkTDfWWYikkauO1g4st2v+LFmiyPlNKYm
 Axh9NhTwSl7JILn4pkZxOZyvG5QyBRPSgL6Rvo5DpnWp3Ubbi/imjPgE+y7T4Dxc3MHvybrYfza
 j2B1T+mH0q6lvXTzZRRReoX4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [10.54.27.89] (210.22.144.162)
	by smtp.migadu.com with ESMTPS id 87de6394280db31c;
	Tue, 25 Aug 2026 15:24:41 +0000
X-Mizu-Trace-ID: 87de6394280db31c
X-Migadu-Flow: FLOW_OUT
Message-ID: <99716abe-9b40-42ac-88a5-e26324a97397@linux.dev>
Date: Tue, 25 Aug 2026 23:24:37 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add test for usdt probe with
 page-crossing nop10
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260825150444.31603-1-jiayuan.chen@linux.dev>
 <20260825150444.31603-2-jiayuan.chen@linux.dev>
 <20260825151342.F3A601F000E9@smtp.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260825151342.F3A601F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/25/26 11:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The search loop limit `2 * page_sz` for locating the USDT probe can cause the test to falsely fail if the compiler generates a prologue of 11 bytes or larger.
> --
>
> --- Patch [2]: [PATCH bpf v2 2/2] selftests/bpf: Add test for usdt probe with page-crossing nop10 ---
> commit 3ab03ec0febc59ef7c61c7f1449047ef827d5e7b
> Author: Jiayuan Chen <jiayuan.chen@linux.dev>
>
> selftests/bpf: Add test for usdt probe with page-crossing nop10
>
> This commit adds a USDT probe layout where the nop10 crosses a page boundary.
> It verifies that attaching to it succeeds and the probe fires without the
> uprobe being shifted onto the nop10 incorrectly.
>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
>> index 8004c9568ffa5..eff1e57ab13c0 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/usdt.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> [ ... ]
>> @@ -342,6 +343,57 @@ static void subtest_optimized_attach(void)
>>   	test_usdt__destroy(skel);
>>   }
>>   
>> +/*
>> + * Test attachment to a USDT probe whose nop10 crosses a page boundary.
>> + * The kernel can't optimize such nop10, so libbpf keeps the uprobe on
>> + * the preceding 1-byte nop. Do not assume any particular placement
>> + * here, though: however the probe ends up attached, the attachment
>> + * must succeed and the probe must fire.
>> + */
>> +static void subtest_optimized_attach_cross_page(void)
>> +{
>> +	long page_sz = sysconf(_SC_PAGESIZE);
>> +	struct test_usdt *skel;
>> +	__u8 *addr = NULL;
>> +	long i;
>> +
>> +	/* combo is placed up to a page of padding after the function start */
>> +	for (i = 0; i < 2 * page_sz; i++) {
> [Severity: Medium]
> Will this loop bound of 2 * page_sz (8192) cause the test to falsely fail on
> builds with larger compiler prologues (like ASAN builds or those with frame
> pointers enabled)?
>
> If the compiler generates a prologue of size P, the offset to the probe is
> P + align_padding (up to 4095) + skip_padding (4086) = P + 8181.
>
> If P is 11 bytes or larger, the offset reaches 8192, which would exceed
> this i < 2 * page_sz search bound and cause a spurious ASSERT_OK_PTR
> failure.

I got such review locally, but I want to say that if such a compiler 
existed, the existing tests would break before

this one: find_instr() in subtest_optimized_attach() only scans 10 bytes 
past the function start.

>> +		if (!memcmp((void *)usdt_2_cross_page + i, nop1_nop10_combo, 11)) {
>> +			addr = (void *)usdt_2_cross_page + i;
>> +			break;
>> +		}
>> +	}
>> +	if (!ASSERT_OK_PTR(addr, "find_nop1_nop10_combo"))
>> +		return;
