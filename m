Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B63BB4A
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782423041; cv=none; b=TLwhR/NQNSxsNwTUoL3nSzbPV3e17Y2cqUBheKa7wsBHC8LeZBo2iy4CAhUbKLLd8ROlLS0kcGZ8+2bgd3ZMJe3OaB2BXYQlTQN4jcbKLZhnn0aDOnPeymfcAJd/lUKqzTaHkdrhhzl9rzOgXArMC5WmHeS1UEOGQEet7YSoOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782423041; c=relaxed/simple;
	bh=FAfGsS/vKMjiqWjBITTAkt5g8m2FD7Lkq/gg8IRItFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKnsEzVIfBVb1eJ2J7vvoKxBT0wolhcN4j4y9VpQOn5e0cpfS1/TON3vNW7/y3ANQxWtvGjHjmJb9ndpV6Ye5M3RptL7651pxPyXcyUJELQyG5/MWS9d1ZEHODcYKwmLNR8ZeBOVEGtwgKy6wJGjGNlm1drZlDuz/y9FaN8zABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OUbTVyQ7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OUbTVyQ7"
Message-ID: <eb9a74fe-bb22-4301-ba53-519463b4d117@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782423035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FAfGsS/vKMjiqWjBITTAkt5g8m2FD7Lkq/gg8IRItFc=;
	b=OUbTVyQ7WUf7GxwU7LhYcV1WsTM03Qc636p0aJn/vLvx5d4RJpXee9ZT0EqRdDt4usKmpv
	+pYwuGaK6qZjb4alX7YIWgj3r6uhxzMYPyEtXaNo0HCLOwKssQdttKLcb4vO6CeQcE1ic/
	zq9upf8gTjMB3Du+uHKWkLhyFHr/wE4=
Date: Thu, 25 Jun 2026 14:30:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Reject offset refcount acquire
 arguments
Content-Language: en-GB
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Shuah Khan <shuah@kernel.org>, Viktor Malik <vmalik@redhat.com>,
 Leon Hwang <leon.hwang@linux.dev>, Dave Marchevsky <davemarchevsky@fb.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
 <2f894647f56f71838fdddeb97a3e057ed35ea92e.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2f894647f56f71838fdddeb97a3e057ed35ea92e.1782192383.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/22/26 11:11 PM, Yiyang Chen wrote:
> bpf_refcount_acquire() increments the refcount at the caller-supplied
> pointer plus the refcount field offset, then returns the caller-supplied
> pointer unchanged.
>
> The verifier records the return value as a base pointer to the refcounted
> object.
>
> bpf_list_pop_front() and bpf_rbtree_remove() can return embedded
> graph-node pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equal
> to the node field offset. Passing such a pointer directly to
> bpf_refcount_acquire() currently passes the refcounted-kptr type check.
>
> That makes the runtime operation start from base + node_off while the
> verifier models the returned pointer as the object base.
>
> Require refcount-acquire arguments to have zero fixed offset by carrying
> the requirement through check_func_arg_reg_off() to __check_ptr_off_reg().
> Programs can still acquire a refcount from a graph-node-derived pointer
> after normalizing it with container_of().
>
> Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

