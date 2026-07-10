Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5334CDD
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696551; cv=none; b=S7MlJ2ceazWE4yRV3nO3Rmg6Dvmo2mC4zXaAj1Lf1Z8QzXeR1pmIT/x6Cwsir4xByzUTF5woSC80x+c4mjB+HV2vMRmzZ7UAGVDlZkOQtetfBPKuE7dCN32cTc09emEufTz3uS9cYVbP28zsjadrD0unJkIo3QMtyBwrGqqDv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696551; c=relaxed/simple;
	bh=1Rd4oIKqX9SKQQHvtsM8kGWsJqTTLH5ZyMXq7FyonDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lY9yzwVY0lk18v/K9T/e7oKn+xH7BGlBW/wu6FRh4lPuxp6G+cmvnx6nlOLbWAJJqWzjykOjjmvaoRKnYYWrPz/mBEW9y8qkcGympoZGdpDkEuTbA+0T4E5Xc7H2beKXMIeycZMmMYiER4hFM1CUUxZT6bmxzzjitpaeGguyIkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wga810wc; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wga810wc"
Message-ID: <49cc5acf-24d4-4e1a-86a0-d05e29a75d42@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783696531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aF7FpZSUJmToTSbrChBipcg4Sj4NSH21xfjUv2dgBgk=;
	b=Wga810wcfj/NgzEW21KmkjBt0Z820hc8+vICWet+GqpHsLO+oBHTdNYJvy3TtcqzQEfxnj
	HhOp7aTi8Y4Y5GHQ1Jrzc5zdvypGyxhi8G+iLlvhOYxaz/muEpAN4D0btWI8Oad7ISk9/j
	JDvX8w0yomy58BeoP5nXFl0K9lJB6ow=
Date: Fri, 10 Jul 2026 23:14:55 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test fentry link after
 tracing_multi link
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260710144734.78203-1-leon.hwang@linux.dev>
 <20260710144734.78203-3-leon.hwang@linux.dev>
 <20260710150412.5E8981F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260710150412.5E8981F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/7/10 23:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Test Flakiness due to Missing PID Filtering in BPF `fentry` Program
> --
> 
> --- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Test fentry link after tracing_multi link ---
> commit 7dc95a7a3d3a0ca96e45e5ad2ebebe5157ae17ed
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Test fentry link after tracing_multi link
> 
> This commit adds a selftest to verify that an fentry link can be attached
> safely after a tracing_multi link. It introduces a new fentry BPF program
> and a corresponding user-space test case.
> 
>> diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
>> index cd5be0bb6ffdd..5ebbe3b602a4f 100644
>> --- a/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
>> +++ b/tools/testing/selftests/bpf/progs/tracing_multi_intersect_attach.c
> 
> [ ... ]
> 
>> @@ -11,6 +11,14 @@ __u64 test_result_fentry_1 = 0;
>>  __u64 test_result_fentry_2 = 0;
>>  __u64 test_result_fexit_1 = 0;
>>  __u64 test_result_fexit_2 = 0;
>> +__u64 test_result_fentry = 0;
>> +
>> +SEC("fentry/bpf_fentry_test1")
>> +int BPF_PROG(fentry, int a)
>> +{
>> +	test_result_fentry += a == 1;
> 
> [Severity: Medium]
> Can this cause test flakiness during parallel selftest runs?
> 
> Because bpf_fentry_test1 is a global kernel function widely used across
> various BPF selftests, parallel test executions might trigger this program.
> Since the counter is incremented blindly without filtering by the executing
> process PID, could parallel executions increase test_result_fentry above 1
> and cause the userland assertion ASSERT_EQ(skel->bss->test_result_fentry, 1)
> to sporadically fail?
> 


Correct.

I should use tracing_multi_arg_check() here, which would filter the PID.

Thanks,
Leon

>> +	return 0;
>> +}
>>  
>>  SEC("fentry.multi")
>>  int BPF_PROG(fentry_1)
> 

