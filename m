Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC7F385524
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805709; cv=none; b=CKrWd6gZo32B/wr4fDhtOfi/bOk7nH0wCh+LanMaXQJbhqbb9YjFAmZ9dyda5tcVuuxcuQhfrSZbyTe7tndd3BTl7sbLgQUnaFuSkWeYVCkNgC/0Lf4LpOIVT7MQaCQgwYuMJhxRe3ovCXiMqU+2hGl3BbDqIshaz+OtS++BLfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805709; c=relaxed/simple;
	bh=VftBf24PBfWIrHxnwDr0dFfIXqIx/etTeJIBb2TakN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDEXRxq0GX3/WnF2Z+Xao8hUdcPiqlJh0sZ2iwZO2XYAQk2yCnjqFmQaNHoYKhW5aHFXL3WuM8O0pbqeHtHSPI9WqICpx8/aA5X2J3mWBJz9ZtLPReDcGpW15xVX0Bu17WuPol1aHjy9jwb4FR39mKlodoJnpYpkBZb9Yr50hWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H6rQ4XTb; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H6rQ4XTb"
Message-ID: <4e8460e6-94f6-4741-8f6c-4526684e3e72@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775805696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soK4u9YPNKIB2aySBIAtKAE6J1ghvqjCGkOqIr/83O8=;
	b=H6rQ4XTb6pSzuAzd1bWguAhgbg+7AafAwsosWB1bHWZ4OfN7xJ5VEMDOu9VqmoEMzAWlbA
	/bJXuxJYdxowvnyuB8XHiukRJdGUoMSgYEWCOJhQ5vDsKY1SGZDXJfhr3xCLyvoi1q6KfJ
	RutaSJfhFQ7DUv4He9jL2qFTBTJ/n3s=
Date: Fri, 10 Apr 2026 15:21:26 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix Null-Pointer Dereference in
 kernel_clone() via BPF fmod_ret on security_task_alloc
Content-Language: en-US
To: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
 mattbobrowski@google.com, jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260410061037.149532-1-yangfeng59949@163.com>
 <20260410061037.149532-2-yangfeng59949@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260410061037.149532-2-yangfeng59949@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/4/26 14:10, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 

[...]

> +
> +static int check_attach_sleepable(u32 btf_id, unsigned long addr, const char *func_name)
> +{
> +	/* fentry/fexit/fmod_ret progs can be sleepable if they are
> +	 * attached to ALLOW_ERROR_INJECTION and are not in denylist.
> +	 */
> +	if (!check_non_sleepable_error_inject(btf_id) &&
> +	    within_error_injection_list(addr))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +static int check_attach_modify_return(unsigned long addr, const char *func_name)
> +{
> +	if (within_error_injection_list(addr) ||
> +	    !strncmp(SECURITY_PREFIX, func_name, sizeof(SECURITY_PREFIX) - 1))
> +		return 0;
> +
> +	return -EINVAL;
> +}

Why did you move them here? Seems that you didn't use them.

> +
> +static int modify_return_get_retval_range(const struct bpf_prog *prog,
> +					  struct bpf_retval_range *retval_range)

NIT: code format issue here.

Thanks,
Leon

> +{
[...]

