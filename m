Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB624BA9E5
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446115; cv=none; b=Mp336hMAix/fLd06WeODaR9Dn9ONUTskCrH6DEU9Itc1Izm3HXmc0Mgkn36LsmCfqSRwbMayjG+8z+vAdwl1NRpagUJMJTXwJfHW7aG8VlJF6NpWUAHaGJZCGi5f0QneCg/Fw8OCJrY0l3mrFlNrIQwu4mKD/ZHRiBpdilhOaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446115; c=relaxed/simple;
	bh=inqB9us+xXArfQYHAZH6ywgaZgA5rW0/tc6FU1d61cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gt9NoxF5afGA8ccyq7USH2ptNdvkHTVJ+1PfIMOKCMeMkr01RP7yWusYQrszf5pWGHAkaZUVh4Orjfn9C2OJdreWWlRIpcspyCtKj35BddnSwZJVGyHvm7eE1SIjQ8YTEO2n4WQ6Yj6CnJny8Be6O0Gf+VLA+kwyhbrXj49vQmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cJ1nqBmH; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cJ1nqBmH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=inqB9us+xXArfQYHAZH6ywgaZgA5rW0/tc6FU1d61cU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788446105; v=1; x=1789050905;
 b=cJ1nqBmHMNaSdYNzK3OXaVtBwR/Z1Xlxx8ZUiyBx+vhBuj2+R6fGQ65PopnSpUGA32Elc8/r
 eowR61BTYRSg3tugnePQ+DvrBmoTwnpZnDNu9OwKSy7gHwxHoP/Ek1dArI2vdPSpHBsyo2O4D6L
 BlLIIszt9ktaDidWPELObeoo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 98708903f2b4cbcc;
	Thu, 03 Sep 2026 14:35:03 +0000
X-Mizu-Trace-ID: 98708903f2b4cbcc
X-Migadu-Flow: FLOW_OUT
Message-ID: <dfc2ac40-a1d8-4ec1-a8b7-fcfd85408b75@linux.dev>
Date: Thu, 3 Sep 2026 22:34:53 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 1/2] bpf: Fix out-of-bounds read of sk_protocol in
 bpf_sock_destroy()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: xmei5@asu.edu, daniel@iogearbox.net, john.fastabend@gmail.com,
 sdf@fomichev.me, martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 aditi.ghag@isovalent.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, mason@kernel.org
References: <20260903125306.299943-1-jiayuan.chen@linux.dev>
 <88d25f82f5261c0a7f12d6e82988bda387f8180c656cd163eec959d327f48769@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <88d25f82f5261c0a7f12d6e82988bda387f8180c656cd163eec959d327f48769@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


on 9/3/26 10:01 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 61940e7535523..1bbb72138ac64 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -12912,8 +12912,8 @@ __bpf_kfunc_start_defs();
>>    * @sock: Pointer to socket to be destroyed
>>    *
>>    * Return:
>> - * On error, may return EPROTONOSUPPORT, EINVAL.
>> - * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
>> + * On error, may return EOPNOTSUPP, EINVAL.
>> + * EOPNOTSUPP if protocol specific destroy handler is not supported.
>>    * 0 otherwise
> The EPROTONOSUPPORT -> EOPNOTSUPP correction is right, but the rewritten
> error list is incomplete. tcp_abort() returns -ENOENT when the socket is
> already closed (net/ipv4/tcp.c, around the sk_state == TCP_CLOSE check):
>
>      /* Avoid closing the same socket twice. */
>      if (sk->sk_state == TCP_CLOSE) {
>          if (!has_current_bpf_ctx())
>              release_sock(sk);
>          return -ENOENT;
>      }
>
> That error propagates through sk->sk_prot->diag_destroy(sk, ECONNABORTED)
> and is reachable from a BPF iterator (destroying a sock the iterator
> already destroyed, or one closed concurrently). In contrast, EINVAL is only
> reachable through the narrower tcp_abort_override() path for MPTCP listener
> subflows.
>
> Should ENOENT be added to the list?


I'd like to describe it as "others" since diag_destroy may change it's 
return value.

