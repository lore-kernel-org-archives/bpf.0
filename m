Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4932B123
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179842; cv=none; b=RfDK5gFLEJsjOG1KKKY2OcrpwXpA9G82W5ZXpo7F23eWFDkEURT0+wRcIatbhTouXst9oHrLlOYSqpRNo6fzM2UT4FpP0pd9uSLL0MbhyMRw5Ww9BK/wjjI7juhavtmDbfHOev23y/DyEtcrX+aD6gtF5iNOyOnr+lR5y0vaNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179842; c=relaxed/simple;
	bh=LGebdd9z/fA9SDCA1B9Kz7W25ywxZbvoQgf78Hz2AMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mlFKES4s1MNkTWZsmjlWa9Tftvg8bgfawIy+RndJ8S1K71jlQMB2+qKIWNgd8I2PI66OX5Of23vKkMgqcIcU7uReOcd45weAWyr9IZ9yZGWQLd051A8GZEHdOeW/fdNUWlMpxUTvL8aBzFJMrxEjRDxPTsEw9yrm5f+t0eB+zog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vrvNN0AP; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vrvNN0AP"
Message-ID: <226a94de-ec58-4c5f-9330-5bfd34550959@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784179838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvYUTTdRGAGLWf4t33xI2t1i0xdlTooL2KIG3cZg5dQ=;
	b=vrvNN0APRhDiXBQWsMc1spPSrU7wJxnOD1NhLKUJf7aOxzZ9lg1FFe9qgODPKCoe9Ih4Wz
	QGlvwO55SxQlHjTuLwBOyN3OvMZb+qFk+QcqeWUwcEJsjEdjcQWQMbsO95/wbSH5Ez+ii9
	FdlvyNnOfmm2IqQl5MHqxUqZrkcCzKo=
Date: Thu, 16 Jul 2026 13:30:17 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v10 6/9] selftests/bpf: Add tests to verify
 global percpu data
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, john.fastabend@gmail.com,
 qmo@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260715153254.92010-7-leon.hwang@linux.dev>
 <13cb81aa58ced1b75131c293972db0b78833c2e2ed4cf2427ac94afb39ee0112@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
Content-Language: en-US
In-Reply-To: <13cb81aa58ced1b75131c293972db0b78833c2e2ed4cf2427ac94afb39ee0112@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/7/26 00:11, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Add tests to verify global percpu data
>>
>> If the arch, like s390x, does not support percpu insn, these cases won't
>> test global percpu data by checking FEAT_PERCPU_DATA support.
>>
>> The following APIs have been tested for global percpu data:
>>
>> 1. bpf_map__set_initial_value()
>> 2. bpf_map__initial_value()
>> 3. generated percpu struct pointer pointing to internal map's mmaped data
>> 4. bpf_map__lookup_elem() for global percpu data map
>>
>> At the same time, the case is also tested with 'bpftool gen skeleton -L'.
>>
>> Add a test to verify that the live vars of subskel won't include the vars
>> for global percpu data.
>>
>> Assisted-by: Codex:gpt-5.5-xhigh
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> 
> This isn't a bug, but item 4 lists bpf_map__lookup_elem(), while the added
> test reads the map through the fd-based bpf_map_lookup_elem_flags():
> 
>     err = bpf_map_lookup_elem_flags(map_fd, &key, &data, flags);
> 
> Should the changelog name the API that is actually exercised?


Good catch.

Actually, there's no bpf_map__lookup_elem() callsite in this test.

Will update the test to exercise both bpf_map__lookup_elem() and
bpf_map_lookup_elem_flags(). And update the commit message meanwhile.

Thanks,
Leon

> [...]
