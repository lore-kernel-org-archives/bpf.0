Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE51AF4E9
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044940; cv=none; b=koDrbC/rw66CuJpXs1wuuvV03Ql8a/LUfXqyfNYDyj0w+c0FnwXPyPZLdksh2wNx7s+82foY7wZ+HzBQFINAssHiXBPJGSG00RSo1SWdfmDeagUcGKfCA/kDGFigSduhOZRdL1uRYoxPljIiDwWikZIqyPFEbO8XIUlTQXK0f6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044940; c=relaxed/simple;
	bh=zLCfidKiv765v34Kp/uv5ZV0BUgBLbdJH30F/8vv2L4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WIUKgWue9sKZUUl6/ivTLapHsUocCb0+NVr06QmQSLY0nfTndZXsOb5XQaMnDpbvxw/D+jPDWuAWSNe68FdMLNC3lUHxftXLKN2fNMkRYMyTSqFnLPilR6ILKRKtOnGmpk8fFfm0ZDCS4If7LjsNLrjW4JJQO/808AeZ5497jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PNYlmo/n; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PNYlmo/n"
Message-ID: <e6ec128e-1acf-4dc7-8884-e4d7ed14d25b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783044936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1LIO1geOHjGag3em8urAK6X+DgR3tKG3cCGCJiSPhQ=;
	b=PNYlmo/nyrMMuYK99CpjpomAfc/gV1JIPBNrF6ti2sqRB1fJbY5Z5YyzQ9qZXOeUKHFvvB
	ZWeVSPIh2/+ofFyRnrOHiY4Lv8Y6zyvO5jfxjmpO2MA1oytaaP6iCOV2CIXeaLhRK2VfvY
	uvaypwJWPnepbsUCp40yPYJGnROGrtI=
Date: Fri, 3 Jul 2026 10:15:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: reject mini-sockets in bpf_sock_destroy()
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260702224519.800135-1-xmei5@asu.edu>
 <20260702230504.0E65E1F000E9@smtp.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260702230504.0E65E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/3/26 7:05 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [High] The patch causes a functional regression by completely disabling bpf_sock_destroy() for TCP mini-sockets (TIME_WAIT and NEW_SYN_RECV).
>
> Pre-existing issues:
> - [High] The helpers bpf_tcp_check_syncookie and bpf_tcp_gen_syncookie suffer from the same type confusion and out-of-bounds read as bpf_sock_destroy, but remain unfixed.
> --
>
> commit cf46da8728e7f1fca4584ccdb089c82b7fd3061f
> Author: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
> bpf: reject mini-sockets in bpf_sock_destroy()
>
> The patch tries to fix a KASAN slab-out-of-bounds read in
> bpf_sock_destroy() by checking sk_fullsock(sk) before accessing
> sk->sk_protocol. It casts sock_common to sock and early exits if it is
> a mini-socket.
>
> Fixes: 4ddbcb886268 ("bpf: Add bpf_sock_destroy kfunc")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index b446aa8be5c37..3e70c8ab5aab1 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -12665,6 +12665,9 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>>   {
>>   	struct sock *sk = (struct sock *)sock;
>>   
>> +	if (!sk_fullsock(sk))
>> +		return -EOPNOTSUPP;
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [Severity: High]
> Does this unconditionally reject mini-sockets?
>
> The commit message states that mini-sockets have no diag_destroy() handler,
> but as documented in the original commit 4ddbcb886268, request sockets are
> explicitly supported because their protocol diag_destroy handler
> (tcp_abort) correctly handles TCP_TIME_WAIT and TCP_NEW_SYN_RECV states.
>
> If we unconditionally reject non-full sockets, wouldn't this break BPF
> programs that rely on bpf_sock_destroy() to forcefully terminate pending
> connections or TIME_WAIT sockets?

It's true. Please also include a selftest to reproduce the issue and, 
another one to cover the non-full socket.


>
> [Severity: High]
> This is a pre-existing issue, but does this same type confusion exist
> in bpf_tcp_check_syncookie() and bpf_tcp_gen_syncookie()?
>
> Both of those helpers take ARG_PTR_TO_BTF_ID_SOCK_COMMON and cast it to
> a full struct sock *. They then immediately dereference sk->sk_protocol
> without an sk_fullsock() check:
>
> net/core/filter.c:bpf_tcp_check_syncookie() {
>      ...
> 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
> 		return -EINVAL;
>      ...
> }
>
> If an XDP or TC BPF program passes a tw_sock or req_sock from
> bpf_skc_lookup_tcp(), won't this result in the same KASAN
> slab-out-of-bounds read since sk_protocol resides outside the bounds
> of struct sock_common?
>
>> +
>>   	/* The locking semantics that allow for synchronous execution of the
>>   	 * destroy handlers are only supported for TCP and UDP.
>>   	 * Supporting protocols will need to acquire sock lock in the BPF context
