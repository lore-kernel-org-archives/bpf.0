Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73973A9861
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786535; cv=none; b=OZZ5kUvvutX0t2w843bzZk+iAD1PYphrwVTtgNr545P+FJN2wr7Kxxi9T/YnQz+OSMMZ8r+2Jt18wDPkC+ts1vaYy8ICfAv36gtmfqG7bvIlBsvuyegPCkop/U/ANr+QmIc74NhiMPbL7jhDLksBH4VbgcJ2MURl45uSpQd4HHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786535; c=relaxed/simple;
	bh=MtrOz9e1XaQQI9fz0YpsBcbmXW3bvacusp8dfGi6s3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+Q7OoPR3ZBVUaLfsnGhO2XoHu2tzbDT6A5pOl0Jfc5f6gMdbBr423qiq+i8aE/SdfCl6d0hVCAPiCnTkcMHmBZb13Nm7EIwAmmCuovTPVUNAfXFPzp3NrzE1eE8Ro7bOQNZ2VKv0ufLPembDTJKP2LthUSbJN6iIfDQ8Nvyk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p3Mf2r5J; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p3Mf2r5J"
Message-ID: <2af4a79b-8b97-47d7-9589-53ba9b2b9d2c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785786521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pE0xBbCk1DUJFkU84tTR7Yk/pEsr/WpnPdo7d6grOuw=;
	b=p3Mf2r5Jkj53TzSjT5oq15UdVfRCDlLLBVu9a6Nos0ictHPRDO9AJ8h4/F0JN8zLgeEbZs
	A/ZVjXymGP9abxuNMjUoOI5UoW2SvZ9aW9x4TJx3uT2D896MnuULqMIiJaqGeh88RTwUm/
	kQTkZUv6r1AyEbu5uw6kDhKGXAaLKi0=
Date: Mon, 3 Aug 2026 12:48:13 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 2/4] selftests/bpf: add --no-error-summary to skip
 end-of-run error log dump
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, andrii@kernel.org, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260803170251.1898102-3-vineet.gupta@linux.dev>
 <a3942d6763816245bb6610aa892f1251aa5ba08a9a698a6646e3ebdb097df33b@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <a3942d6763816245bb6610aa892f1251aa5ba08a9a698a6646e3ebdb097df33b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 11:15 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> index aa06bab309665..8ee46745e2e85 100644
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
> [ ... ]
>
>> @@ -1686,9 +1696,12 @@ static void calculate_summary_and_print_errors(struct test_env *env)
>>   	 * We only print error logs summary when there are failed tests and
>>   	 * verbose mode is not enabled. Otherwise, results may be inconsistent.
>>   	 *
>> +	 * --no-error-summary only elides the human readable dump: the walk
>> +	 * still happens so the JSON report keeps its per-test results.
>>   	 */
>> -	if (!verbose() && fail_cnt) {
>> -		printf("\nAll error logs:\n");
>> +	if (!verbose() && fail_cnt && (env->error_summary || w)) {
>> +		if (env->error_summary)
>> +			printf("\nAll error logs:\n");
> Does the comment match what the code does?  The comment says "the walk
> still happens", but the guard now requires either env->error_summary or w
> to be non-NULL.
>
> When --no-error-summary is passed without --json-summary, both
> env->error_summary and w are false/NULL, so the entire for loop at the
> bottom of this function gets skipped, not just the human readable output.
>
> The walk does happen with --no-error-summary --json-summary FILE (where
> w != NULL), but not in the no-JSON case. Could the comment be more
> specific, maybe "the walk still happens when a JSON report was requested,
> so the JSON report keeps its per-test results"?

Good catch indeed the comment overstate it. Will reword in v2.

Thx,
-Vineet

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778

