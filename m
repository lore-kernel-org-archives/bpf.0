Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C2336BCDE
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600801; cv=none; b=UxDAJ0uhsQw/ihMWkLcwvDHq90MCPITMzyeIn3q5288CVdmEN6VBzGFxzpKzooiPK1xa3hPR50qx+3Ql3M9bCS8bzrEYtjXBQ4q1vhgZ/HUg+jibZhJJXZ+U3wIRZe9kz1qKQryjbJVJOa2MhuNi7IOV7eFt4hbg6UdZ3j06X2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600801; c=relaxed/simple;
	bh=aGdDMOfEB3tY2uuMgSx4NwFUI8B3nOglrfzQV9enUOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOLrw7Hw8lEYv0bn1h2iztELhxcRhbcPInFAmY1yhGigtoDL0BjS0vlDdR1lzXo26p/NGp1JVeW8Lr9cBw2KDeWHl+pmn0l9SlIRMLEztomNj+19Q69OB2Sf9lb5KM7eb4BnQYOJLWqPV6j2/+5Tdo3tbDKIta11js+jfwsjEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRZeilyE; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRZeilyE"
Message-ID: <c7d73755-cc38-4dc0-9d8a-058fc6243d2e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780600797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ojXthnYVqyvhhgqjzgmVTve1qVqzxJtwsyyQseDi44=;
	b=FRZeilyEYNpWqbT5Tu5NQZW1L4RbGFL2WxRGMnRcNjQPCt9zm3s2SkFi4fiRRPuZFQEP/Q
	E2eIBI8n7W6fpiumALoPEgiQfAmBbmQK3/b8HtSD1HmDUCTodcfGKJm1/pteQGuFp/EeRC
	fKF315PqgQZ0sFxRxm7+LtnCmTXWnrU=
Date: Thu, 4 Jun 2026 12:19:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 2/3] bpf: Add validation for bpf_set_retval
 argument
Content-Language: en-GB
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, YiFei Zhu <zhuyifei@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Quan Sun <2022090917019@std.uestc.edu.cn>
References: <20260604130458.617765-1-xukuohai@huaweicloud.com>
 <20260604130458.617765-3-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260604130458.617765-3-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/4/26 6:04 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> The bpf_set_retval() helper is used by cgroup BPF programs to set the
> return value of the target hook. The argument type for this helper is
> ARG_ANYTHING. This allows setting a positive value, which no cgroup
> hook expects and can cause issues, such as:
>
> - BPF_LSM_CGROUP: a positive value from bpf_lsm_socket_create bypasses
>    the err < 0 check in __sock_create(), leaving the socket object
>    unallocated. The positive return value is then propagated to the
>    syscall entry __sys_socket(), which also bypasses the IS_ERR() guard
>    and ultimately causes a NULL pointer dereference.
>
> - BPF_CGROUP_DEVICE: a positive value can be returned through cgroup
>    device bpf prog -> devcgroup_check_permission() -> bdev_permission()
>    -> bdev_file_open_by_dev(), where ERR_PTR(positive) produces a pointer
>    that IS_ERR() does not catch, leading to a wild pointer dereference.
>
> - BPF_CGROUP_SOCK: a positive value can be returned through cgroup sock
>    bpf prog -> __cgroup_bpf_run_filter_sk() -> inet_create() ->
>    __sock_create(), where inet_create() frees the newly allocated sk
>    via sk_common_release() and sets sock->sk = NULL on the non-zero
>    return, but __sock_create() only checks err < 0 for cleanup, so a
>    positive retval bypasses cleanup and returns a socket with NULL sk
>    to userspace, triggering a NULL pointer dereference on subsequent
>    socket operations.
>
> - BPF_CGROUP_SYSCTL: a positive value can be returned through the cgroup
>    bpf prog -> __cgroup_bpf_run_filter_sysctl() -> proc_sys_call_handler(),
>    where a non-zero return bypasses the normal sysctl proc_handler and is
>    returned directly to userspace as return value of read() or write()
>    syscall.

FYI, the following patch:
     https://lore.kernel.org/bpf/20260603105317.944304-4-dawei.feng@seu.edu.cn/
will change return value for BPF_CGROUP_SYSCTL from 1 to 0.

>
> So add validation for the argument of the bpf_set_retval() helper.
>
> For BPF_LSM_CGROUP, enforce the LSM hook specific range returned by
> bpf_lsm_get_retval_range().
>
> For all other cgroup program types, restrict the argument to
> [-MAX_ERRNO, 0], which matches the kernel convention of 0 for success
> and negative errno for error.
>
> BPF_CGROUP_GETSOCKOPT is an exception, since valid getsockopt
> implementations may return positive values, as allowed by commit
> c4dcfdd406aa ("bpf: Move getsockopt retval to struct bpf_cg_run_ctx").
>
> Also refine the return value range of bpf_get_retval() so that
> values returned by bpf_get_retval() can be passed directly to
> bpf_set_retval() without extra manual bounds checking.
>
> Fixes: b44123b4a3dc ("bpf: Add cgroup helpers bpf_{get,set}_retval to get/set syscall return value")
> Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Closes: https://lore.kernel.org/all/567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>   kernel/bpf/verifier.c | 54 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
[...]

