Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E15E3F7ABE
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669158; cv=none; b=qeZGw178T1Lq6sy/nncHZoubSeLl0LB2ReUpJtDNK44R6+yyHyg+XEA+cnmMxVfRdTqiIAcbpoqQICyziDnx0Zu0sy5dsTYGoHiwPzV/oZSMW4wmVjLjI7gFmqWI4+fZ/PIUyHMVWV8I6g2ftMHkx3UulqB66ZzK7kdBEojYeGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669158; c=relaxed/simple;
	bh=vJMaQAKhWt2IHR0zyYCI4h8U1T/fJieG9BdbySH7Szc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0ay3OVXbbGxG471BY8qctwOCpIi3Cz2UxGQpttF0bZbEj7GhhrGvHATejmPJImHYSYVC86VQWFpkAJX4mjxAawjsxe3OdLVuCXHcTxLMSpH+pc9zu8ZIAiN9DH83XZvqyNbFy+WiaZF4+SwcfTVpcgIEgQgUHPhGL5QZp4pA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnUhzysc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnUhzysc"
Message-ID: <3c9b4ff0-7a62-4053-83c7-23151905c742@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778669145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3OUBgLcGIWLl2rOMcr+4WnW+aK5rNC4EH7u5rXEsvo8=;
	b=SnUhzyscOJX5vDycjsbEeM5Tqb8fenhozw+xdAVexBkt4s0/3jueHUlud08qGjkep9Q15A
	UL3ZGNWW+hrlEnQFEWcs+EhCyBis4z4MgwFQKTIxaETkGBHZrXaFev7n6gMs8iDNtvh2QW
	Ljy0IWboWJighFahJePFGygPR+BceVw=
Date: Wed, 13 May 2026 18:45:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 6/8] bpf: Add syscall common attributes
 support for map_create
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260511152817.89191-7-leon.hwang@linux.dev>
 <20260512233658.CEED7C2BCB0@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260512233658.CEED7C2BCB0@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/5/26 07:36, sashiko-bot@kernel.org wrote:
[...]
>> +
>> +	err = __map_create(attr, uattr, log);
>> +
>> +	ret = bpf_log_attr_finalize(&attr_log, log);
>> +	if (ret) {
>> +		if (err >= 0)
>> +			close_fd(err);
> 
> Is it safe to call close_fd() here? Since __map_create() uses
> bpf_map_new_fd() to allocate and publish the file descriptor via
> fd_install(), the file descriptor is already visible to userspace.
> 

I think it is acceptable to close_fd() here, that the duration between
fd_install() and close_fd() is short.

> Could this introduce a regression where a concurrent thread closes this
> file descriptor and opens a new, unrelated file that receives the exact
> same fd number? If that happens, it seems this close_fd() might
> inadvertently close the unrelated file.
> 

This regression is valid.

However, since the new fd hasn't been returned to user space, user space
thread seems unable to get the exact fd number to close it.

> Additionally, since the map is published globally via its ID before fd
> installation in bpf_map_alloc_id(), could another thread acquire a
> reference to the map before this error path? It looks like the map might
> remain alive and accessible even though the syscall returns a failure.
> 
I think this is not an issue, as the map is valid for other threads. The
map's lifecycle is maintained by its own refcnt. close_fd() will dec the
refcnt instead of destroying the map.

Thanks,
Leon

>> +		err = ret;
>> +	}
>> +
>> +free:
>> +	kfree(log);
>> +	return err;
>> +}
> 

