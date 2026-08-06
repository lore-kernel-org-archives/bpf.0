Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B13D9DC0
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052256; cv=none; b=j2yj1gYLDn2Ef+0UFqaamRJFAHuRzqkfVuQTi95VLDHuB+BO6fw2JD7KMi0u9dpbWjicnelNeTLLk+YgjHFpIlcUUkSxUfrfJHktyOwMXx/g/no5I1eox/kgXBPqcsqWb7RmeYWjfUfFXQossA+yHdOh/KeXfYSGH2sVPVgaqHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052256; c=relaxed/simple;
	bh=g+MYuyE+Q8vw2ImqEfUjXtSZ9+46HJWkhb+ZnDSCGVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrjJvQSjeKasTRKpWUhAflyZvhtxf5X5iqUSy8kSSX4HIy8Nk8NbcwxWgc62oyq4VEs2tYyyyTbn032p2no1ul0bhL6WQnDvFb7hbgl5lMPH+CgYAFy8B7vhlxkfDtdHdm6O9CQ7Tlq9ybJm8Q0e4yeyXj0pwUyCOFRNpI137L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V9ndoVJY; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V9ndoVJY"
Message-ID: <fcfe4ed2-5c04-45df-a4b0-27d1bfddf986@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786052242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pMuEKaIIwPAxmrDYZKFD/slOpZQYCRZFJuabogJ5e2E=;
	b=V9ndoVJYvYO1Qrb/aQbq1dOnn2VYNTS2eiWFThHmlejqb9LZ6M+UYn2188V24O5h+KcfAc
	Tjywl2OYmZgob+kTbj69jgSpW4pN13JfnfR7dKxqYg/Nxc1WeUnOUN/YUUIrnxPS62i6Wc
	wZvK1wa/Fv14m9aqoq425cF6zSYATJw=
Date: Thu, 6 Aug 2026 14:37:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log file
 names
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260806211105.3307932-1-vineet.gupta@linux.dev>
 <20260806211740.E9F851F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260806211740.E9F851F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/6/26 2:17 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The backslash character `\` is missing from the sanitization string, leaving artifact names vulnerable to rejection by GitHub Actions.
> - [Low] The newly introduced multi-line comment violates the BPF subsystem's strict comment style guidelines.
> --
>
> --- Patch [1]: [PATCH bpf-next] selftests/bpf: Sanitize traffic monitor log file names ---
> commit 4eb40c6024aab5f28e7a52af3fba116cbdeff427
> Author: Vineet Gupta <vineet.gupta@linux.dev>
>
> selftests/bpf: Sanitize traffic monitor log file names
>
> The traffic monitor names its capture logs after the test and subtest
> being run, replacing '/' and ' ' so the result is usable as a file name.
> This patch replaces the whole set of awkward characters in one pass to
> fix artifact upload failures in CI systems like GitHub Actions.
>
> Link: https://github.com/kernel-patches/vmtest/actions/runs/30710914503/job/91399011388 [1]
>
>> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
>> index db935a9d9fc1a..3818cec354a0d 100644
>> --- a/tools/testing/selftests/bpf/network_helpers.c
>> +++ b/tools/testing/selftests/bpf/network_helpers.c
>> @@ -1142,10 +1142,13 @@ static void encode_test_name(char *buf, size_t len, const char *test_name, const
>>   		snprintf(buf, len, "%s__%s", test_name, subtest_name);
>>   	else
>>   		snprintf(buf, len, "%s", test_name);
>> -	while ((p = strchr(buf, '/')))
>> -		*p = '_';
>> -	while ((p = strchr(buf, ' ')))
>> -		*p = '_';
>> +	/* Test names are free form, so replace anything that is awkward in a
>> +	 * file name. Besides the path separator, this covers the characters
>> +	 * rejected by CI systems collecting these logs as artifacts.
>> +	 */
> [Severity: Low]
> This isn't a bug, but does this multi-line comment in encode_test_name()
> conflict with the BPF subsystem's comment style guidelines? The opening /*
> is typically expected to be placed on its own line.

It follows the pre-existing convention in this file and for netdev in 
general.
I can fix if maintainers prefer that.

>> +	for (p = buf; *p; p++)
>> +		if (strchr("/ \":<>|*?\r\n", *p))
> [Severity: Medium]
> Since this is meant to cover characters rejected by CI systems like GitHub
> Actions, should the backslash character '\\' also be included in this
> sanitization string?
>
> If a test or subtest name contains a backslash, it appears the artifact
> upload could still fail.

The original intention was parity with libbpf-ci: 
run-vmtest/normalize-paths-for-github.sh but agree adding the backslash 
makes it more robust.

Thx,
-Vineet
