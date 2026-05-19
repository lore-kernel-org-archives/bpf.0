Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C801A6802
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779158866; cv=none; b=XQNIKQLW97dHdX+Yr61agcLMCthaTHPpkXAsEMaZa3hI/esK4EQaWq99GPI5+TVljmZhnynTEYaK3g5JVPD8LnDWviT7otUihZz9MONmBawoTQQy1V21AHJc/q4+500Z7f9e0CIk3359fLZHj2DhuUCZjxr+IJ1qHxCowPDX6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779158866; c=relaxed/simple;
	bh=JhQp+rr0ImE0WXvaRqeyzAMijJFMQKh8sezpGFGWxXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QqmWRhznyuGBnWogD9JGFeGDAa0i8HH4GGenuTw0PQZl/YEBuYo3/18LKpcW8lLCWUAsRkX/MURRLA9hPN/Q9eJ5TRE8trG9JqgZGv2ZJCQko+KJVyroMZvdnolaRrKcNgOMozypEQW+B+bjn4vP1OgI5kcZpSrvtpnlMM6FwVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I06V2754; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I06V2754"
Message-ID: <5660e657-f2a5-4866-9881-c705bff0c970@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779158862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfv99txHEGY13UQrWTfqR7zNzUFkAOhzsUrGSe3Xnu0=;
	b=I06V2754u2ee6pApPIiETny6INHQ6MQjTS8DZfPA56morL3Vt3kMSytmmbNoxSZGP2rJFL
	OQQutxBNY+t0wn6AuunPlFaDeuaXiR95WChN1BXK5Pvt7rAhag4eFfyn7TPgo90Jxogtn+
	ftmM9jMm080Fj3X3rVO03Bmc3wsehEw=
Date: Tue, 19 May 2026 10:47:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/5] bpf: Fix concurrent regression in
 map_create()
Content-Language: en-US
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260518145446.6794-1-leon.hwang@linux.dev>
 <20260518145446.6794-3-leon.hwang@linux.dev>
 <261a47f4-a92b-4a61-86ca-c1de362be105@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <261a47f4-a92b-4a61-86ca-c1de362be105@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/5/26 00:43, Mykyta Yatsenko wrote:
> 
> 
> On 5/18/26 3:54 PM, Leon Hwang wrote:
[...]
>>  	/* preserve original error even if log finalization is successful */
>>  	ret = bpf_log_attr_finalize(&attr_log, log);
>> -	if (ret) {
>> -		if (err >= 0)
>> -			close_fd(err);
>> +	if (ret && err < 0)
>> +		/*
>> +		 * Failed to finalize the log.
>> +		 * Should not close_fd(err) here. Since the bpf_map_new_fd()
> 
> nit: you can't close_fd(err) here, because err < 0? The comment overall appears to
> explain why we are making this change right now, rather than why this works this way.
> 

Will update the comment to

		/*
		 * Failed to finalize the log.
		 *
		 * Should not close_fd(err) here by
		 *
		 *  if (ret) {
		 *      if (err >= 0)
		 *              close_fd(err);
		 *      err = ret;
		 *  }
		 *
		 * Since the bpf_map_new_fd() has published the map fd,
		 * if a concurrent thread closes the fd, then opens new,
		 * unrelated file that receives the exact same fd
		 * number, close_fd(err) might inadvertently close the
		 * unrelated file.
		 *
		 * As a trade-off, override the err only when failed to
		 * finalize the log and failed to create map.
		 */

The comment is to explain the reason for overriding err.

> If map_crate() failed with error code and then log finalization failed, do we really
> want to override error code? It sounds like map_create error is more important.
> 

In that case, there are two error codes that should be returned to user
space. How to achieve it?

Since we should not ignore any error code of them, can we report the
error code of __map_create() failure by adding an error attr to struct
bpf_common_attr? Hmm, seems not a good idea.

Any idea?

Thanks,
Leon

>> +		 * has published the map fd, if a concurrent thread closes the
>> +		 * fd, then opens new, unrelated file that receives the exact
>> +		 * same fd number, close_fd(err) might inadvertently close the
>> +		 * unrelated file.
>> +		 * As a trade-off, override the err only when failed to finalize
>> +		 * the log and failed to create map.
>> +		 */
>>  		err = ret;
>> -	}
>>  
>>  	kfree(log);
>>  	return err;
> 

