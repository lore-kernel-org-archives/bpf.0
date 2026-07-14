Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD444370ACC
	for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783993902; cv=none; b=HT3jXVSBkjExWBaX5EN3HGdkNFs8OAonuyz1ZXf3XPdzWMhaUbMteoFhGSqVFYxSDgvwKcmEa6XT2CVpI7q3ueixQruAZx0DoVS0EkSd4i+b6UqHRya0yIsADCxcD1vJcz1xcMaZi7JEtGgvDceWDPtyVlBhK6RxNvnv1C1Xtdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783993902; c=relaxed/simple;
	bh=gBNL3au5TOQYPRIGDO8uZOBZnMmF2Ye+YsxwU7eZcmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1DzyDgU5LOyQARNLx673p3skpBttN/P6vDImMynTvOLB+ML45JBBpOEzqNRGP8cQgRh81Eq/ODqYW5Cw4Ax4bqkT2kSOjlbY93QHpQKZ0wWdb6NcSX4S49w4SSz7oYX2wfMjxqh4S4H9hV8ZNIxGqIC0De5hY2Tqbo8yzLKseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EYcIepDD; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYcIepDD"
Message-ID: <7db42bd1-7b00-4448-8c7e-0ca118758e28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783993898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+lvI/LvLHjzVrT12/yRsfDlgLKwWx8a0rQWKvSAdH0c=;
	b=EYcIepDDJ2Fgq8dUxAbLuMk+BgI56qNXHrFlWlLh+U6s1QlEB6ygdygZQcINTykbB6rbAf
	AD7eiLAaA33bIJg1ZbUxCRnodrbHGkvY6EURJQbVQzjgMO0lEHPi7E6pj2E8+0P8MT/Gsv
	aAXtbQPdMMZdp69wbeXUNO22lspa9PQ=
Date: Tue, 14 Jul 2026 09:51:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 6/9] selftests/bpf: Add tests to verify global
 percpu data
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260713154024.30851-1-leon.hwang@linux.dev>
 <20260713154024.30851-7-leon.hwang@linux.dev>
 <20260713171334.6A5A71F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <20260713171334.6A5A71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 14/7/26 01:13, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The test `test_global_percpu_data_subskel` unconditionally asserts that `var_cnt > 0`, but the compiled BPF object contains no non-percpu global variables, meaning `var_cnt` will always be exactly 0 and the test will reliably fail.
> --
> 
> --- Patch [6]: [PATCH bpf-next v9 6/9] selftests/bpf: Add tests to verify global percpu data ---
> commit 3e1db5f1fcec57a130c30e415035e1b1944b5e17
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> selftests/bpf: Add tests to verify global percpu data
> 
> This commit introduces tests for BPF global percpu data, verifying APIs like
> bpf_map__set_initial_value() and bpf_map__initial_value(). It also adds a
> subskeleton test to ensure that the live variables of a subskeleton do not
> include those for global percpu data.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
>> new file mode 100644
>> index 0000000000000..8aebd533d86b5
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_percpu_subskel.c
> [ ... ]
>> +	if (!ASSERT_OK_PTR(subskel->subskel, "subskel"))
>> +		goto out;
>> +	if (!ASSERT_OK_PTR(subskel->maps.percpu, "maps.percpu"))
>> +		goto out;
>> +	ASSERT_EQ(bpf_map__type(subskel->maps.percpu), BPF_MAP_TYPE_PERCPU_ARRAY,
>> +		  "percpu_map_type");
>> +	ASSERT_GT(subskel->subskel->var_cnt, 0, "var_cnt");
> 
> [Severity: Medium]
> Will this test unconditionally fail here?
> 
> Since all global variables in test_global_percpu_data.c are placed in .percpu
> sections:
> 
> int unused SEC(".percpu.looooooooong");
> int data2 SEC(".percpu.data");
> int data SEC(".percpu") = -1;
> 
> bpftool generates a subskeleton with a variable count of 0, because maps of type
> BPF_MAP_TYPE_PERCPU_ARRAY are skipped during subskeleton generation.
> 
> Thus, subskel->subskel->var_cnt should be exactly 0, which would cause this
> assertion to fail.
> 

Cite my reply in v7 [1]:

Looking at test_global_percpu_data.c, there are 5 non-percpu global
variables, which were added in the last patch.

volatile const __u32 num_cpus = 0;
volatile const int offsetof_num;
volatile const int elem_sz;
__u32 percpu_data_sum = 0;
bool run_iter = false;

So, subskel->subskel->var_cnt will be 5.

In the generated test_global_percpu_data.subskel.h:
        /* vars */
        s->var_cnt = 5;

hmm, if the next revision is needed, will add a global data variable to
mute this Sashiko review.

[1]
https://lore.kernel.org/bpf/6c0bc7ef-90b9-450d-969d-b7e0bc5932f8@linux.dev/

Thanks,
Leon

