Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C73A7F6E
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780750677; cv=none; b=Na1CqlbAOOF1uDgZrNxAOtovP0Cve67OWc5AgOsb2S5isIPRADIsJXZ+z90L80PkE7ccHgSuYL/l5gyFgM+gFfPq72wJnCWA+UyJH0pzY0jpIYsCba3C5Gjh6m57Ms9fzAVH2UPAbpoIA4fO7lx2H2qnthU1r8ewrGJFlmNX9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780750677; c=relaxed/simple;
	bh=yLdlxn6wnXWvE70fdE6r10MFvEYbWAWQsm/plhLqsUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNUE5QSdVXf26rp9afErp6+BNF0NdSYei+P/UTeAz6Oj5UCBzmkHLUGB78T0pp3GaeaFZYsBxH8d5BF6nFSVDo5u4UyigRorj5Tf9aGrMXBg01vSPwiFDYWr96RirS5tFYrPoM3sLAyB6029cIyb3WR60/h+DYwjOxUlb+s9OnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0JK8tXF; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0JK8tXF"
Message-ID: <cf8cef69-85c6-4d6f-b3f3-eb79fb2e075d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780750664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RlEFEF1O4G2UXEfB1iSkIV3C6hrJc1jLqx1ZQFCYkCU=;
	b=V0JK8tXFL9oJI8kIYQqKY8br1OUd8l+KnJNNpsTOnQMOCetjMJxHQbNiGpvOK+RamSXMwW
	zZaWfDF2TNrxG1H53as/CD+HiZhsIj0GiTjbIVKvGSPXOO7G1RB5kVuZZxCimOAlG461U/
	hMw8aExQ77jF0P7MMSzVaHEm4WMSsII=
Date: Sat, 6 Jun 2026 20:57:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] bpf: fix NULL pointer dereference in
 bpf_task_from_vpid()
To: Sechang Lim <rhkrqnwk98@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Juntong Deng <juntong.deng@outlook.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260606091941.1803115-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2026/6/6 17:19, Sechang Lim wrote:
[...]
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b5314c9fed3c..226c31ccb5d6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2912,7 +2912,14 @@ __bpf_kfunc struct task_struct *bpf_task_from_vpid(s32 vpid)
>  {
>  	struct task_struct *p;
>  
> +	if (in_interrupt())
> +		return NULL;
> +
>  	rcu_read_lock();

Better to use guard(rcu)() here, and drop the rcu_read_unlock().

Thanks,
Leon

> +	if (!task_active_pid_ns(current)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
>  	p = find_task_by_vpid(vpid);
>  	if (p)
>  		p = bpf_task_acquire(p);

