Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01777395AE2
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187489; cv=none; b=MlcXa6Q6ur/nd2Vjd8QV08iJVVp2W6t0tJpuYLFpqGNPz+lFxb7IGD0Df96lVfHOi962qxlclJYNVIUEO3Q41fCyJbb9ny1MjB6FE7SFWXabFC/kQcdoFdxF9ggIb7aBV4F1lCFyNLg6fso7RrppO6mToaI2GOxxhwLq9yxHX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187489; c=relaxed/simple;
	bh=CEvGN1h+aapRWo1fpD0XxW5yHcdeF0dhXGk4pVHLUTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpYlbGo9m5jj8p/DqdW8ikVnuJfu5tUKpQejkDd42uKQcZUN6sHSkJusRBiLry7SQYdGeIouiE08X6+UgL2O/Y026WcRVCKMeICuoydPWykPNXjao5kLwTJFLtl6tIqvTCfpw2UBMoaEv6GXt5bGGZXeuexQy0HYBEycGcxkAXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xP5oOlSH; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xP5oOlSH"
Message-ID: <0b8d2ab5-187e-450b-b70d-ea82bd1deb48@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782187486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kkr+IxAPGh1U/xlJXXXKTkcMDslOFkWf62etZCGBbKc=;
	b=xP5oOlSHvhQBU3FmzcFgK/hlEo8Km3ZHnLm+YiybQciYqM4h6YJq4auxb1qBNHFZNM0VEN
	A8AoYoiC4cwRIAdjK+vKsuZGCaz44HH3O2/KOE4d+jigVt1Guv1VGYyXFA1e2+SEbwJDrl
	NOhW8N9Hga65vVTxMo6PqUyfs566e/k=
Date: Tue, 23 Jun 2026 12:04:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 11/11] selftests/bpf: Add test to verify
 bpf_iter for global percpu data
Content-Language: en-US
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260622143557.22955-12-leon.hwang@linux.dev>
 <187545ebc349810d6458e4ea87a391e0e2f4fa6032363fe3416852db9c08f67b@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <187545ebc349810d6458e4ea87a391e0e2f4fa6032363fe3416852db9c08f67b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/6/26 23:24, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> index e4c290492ff8..32734e1dbfb0 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
>> @@ -279,6 +279,56 @@ static void test_global_percpu_data_verifier_log(void)
> 
> [ ... ]
> 
>> +	fd = bpf_iter_create(bpf_link__fd(link));
>> +	if (!ASSERT_GE(fd, 0, "bpf_iter_create"))
>> +		goto out;
>> +
>> +	while ((len = read(fd, buf, sizeof(buf))) > 0)
>> +		do { } while (0);
>> +	ASSERT_EQ(len, 0, "read iter");
> 
> This isn't a bug, but could the empty drain body here be a bare ';'
> rather than 'do { } while (0);'?  The other bpf_iter tests in this
> directory (prog_tests/bpf_iter.c) drain the iterator fd with a bare ';',
> so a plain ';' would read more like the neighbouring code.
> 
> 
I think 'do { } while (0);' is more readable than a dangling ';', and
avoids -Wempty-body warning btw.

Thanks,
Leon

