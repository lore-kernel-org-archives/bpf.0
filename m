Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B984A1A5B8C
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785817177; cv=none; b=sXy1I43otnX+LJSCr/W6BEeOVfKGRkRkCP/OS7VtMDBT4KNhdw6/3e7u/gdNMbnGPZe73QLtJ20NM62BXlh2eLudDn0Kod0+t/QRSDCp+JBg/ZpMZmk0bjNkRAj3vce4fitZVDX+DrHZyesW9Gek71ZgLoeFZf0QUTh6eu3KYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785817177; c=relaxed/simple;
	bh=L8e/d9P+5FB+W/r26Kj6nFJ+Mx6duqV0JpcWtXzqfjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcNuFn4fqHvQFKdzE4tapSJRT41otsEoz0NE2xTeIQANh7A7SAkAWOHzn5ZgEB4ryPky0IzFTjn/z1Z5f29HIkZhQ9qnM9erSvjb9ySwK7ZoT1KSXEzdFvG+V1lZUa35gt6W0XtB6KgxsaZfhXWCOeKPHuFIlBw1WXCqjpg57BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ODu/2UIg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ODu/2UIg"
Message-ID: <50756798-7ecc-4be4-a2fa-2a570445732a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785782199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rE/VXtpMafifLcH7QPNrwMbKcFIjyrtyiUCvpMBSKI8=;
	b=ODu/2UIgdzUktw2Ha6Xw9eLwXhCAaELm9ucJlK1Z43/9otyA96Kk9fNDfuMbJSXBsVheH2
	+fc68YCj9rnZ7MN5iAzLfM1M6coyWTS58hEijtWy5744/DhUkYXCxzAlUhSkerqZl0teZ2
	eO+uV1xmz9GBzWSmlprFVY0l/RKkgh0=
Date: Mon, 3 Aug 2026 11:36:34 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bpf-next 3/4] selftests/bpf: report failed subtest count in
 test_progs summary
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 eddyz87@gmail.com, andrii@kernel.org, ihor.solodrai@linux.dev
Cc: linux-kernel@vger.kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260803170251.1898102-4-vineet.gupta@linux.dev>
 <f910f39ef8d23c65d047c7a42cd13962e882364c72e38d4aaac836d37f698f21@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <f910f39ef8d23c65d047c7a42cd13962e882364c72e38d4aaac836d37f698f21@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 11:31 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>> --- a/tools/testing/selftests/bpf/test_progs.c
>> +++ b/tools/testing/selftests/bpf/test_progs.c
> [ ... ]
>
>> @@ -1726,12 +1731,12 @@
>>   	fclose(env->json);
>>
>>   if (env->not_built_cnt)
>> -	printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d FAILED\n",
>> +	printf("Summary: %d/%d PASSED, %d SKIPPED (%d not built), %d/%d FAILED\n",
>>   	       succ_cnt, sub_succ_cnt, skip_cnt, env->not_built_cnt,
>> -	       fail_cnt);
>> +	       fail_cnt, sub_fail_cnt);
>>   else
>> -	printf("Summary: %d/%d PASSED, %d SKIPPED, %d FAILED\n",
>> -	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt);
>> +	printf("Summary: %d/%d PASSED, %d SKIPPED, %d/%d FAILED\n",
>> +	       succ_cnt, sub_succ_cnt, skip_cnt, fail_cnt, sub_fail_cnt);
> A subsystem pattern flags this as potentially concerning: the BPF selftests
> guide asks that test binaries emit TAP-compliant output via kselftest.h
> (ksft_set_plan()/ksft_finished()) rather than hand-formatting their own
> summary lines with printf(), so that kselftest runners and CI can parse the
> results uniformly.
>
> test_progs.c has always had its own reporting framework and does not use
> kselftest.h; this predates the patch by many years and converting it is far
> outside the scope of this change. The patch only widens one existing field on
> an already ad hoc line.
>
> The changelog acknowledges that the field-format change means "anything
> scraping 'N FAILED' out of it needs updating." A search over .github/workflows,
> .github/scripts, ci/, tools/testing/selftests/bpf/*.sh and Documentation/
> turned up no in-tree parser of the test_progs summary line.
>
> Does this output format remain compatible with the consumers you're aware of?

As the Changelog mentions, I don't know of any existing in-tree 
consumers/parser of the existing info.

Thx,
-Vineet

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30836252778

