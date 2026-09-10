Received: from mta0.migadu.com (out-19.mta0.migadu.com [91.218.175.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D187D485923
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 12:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042845; cv=none; b=P8J7k9o5AsK8U9Dzz3eLwNw0+TtmL3h8NF+xx6IAMQvrojo1mNDAnbzTz2jpDw7M782j9snVlPh5PXNLrVzaaJh6t8ahFd5Bs52FSguwZvnGALdfgDjszleNbZYXXaakCsbTq0JXZD9DsYME1V4s2IqlOr1R6Ac9x781Hvj3MMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042845; c=relaxed/simple;
	bh=t64T+HwsunjiOU4dNPon7aRJOGjom1a29RFgPwjvS2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bApUREfQTUTCyE89K77qVSAWXdgMaz7hxPVZ5b8r0qtATXAn+GltcrI8PACKAGsXOH/MzBEqT0a+uZX7UklcGa+2/eyezVjT2e1l05RvnD+M7rLH5pAyktT5sbIVzSWhzMlBL3Zd6lj+WyzzjyN/y0byzDrHquyT8qgIgdPGCCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mxz7wc7q; arc=none smtp.client-ip=91.218.175.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mxz7wc7q"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t64T+HwsunjiOU4dNPon7aRJOGjom1a29RFgPwjvS2Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789042841; v=1; x=1789647641;
 b=Mxz7wc7q4v77crWxqIxBU3SCZfl194G+lfbS8AWKcKlMmjgSJwq+UMhwuLDW933r7mKN5GM2
 p5yfPkpa7JuAMyKtmrXNhCFFe1MS+D7ZT9IMSNxwXN4Ifq//dOcCepLP60/DUZN6u8PvYiwcfQF
 eFp2RATkv1i2aUZyWo/haT2c=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e10979a4866a10ae;
	Thu, 10 Sep 2026 12:20:41 +0000
X-Mizu-Trace-ID: e10979a4866a10ae
X-Migadu-Flow: FLOW_OUT
Message-ID: <5cabb13b-1079-4e49-af6b-a6c2fc801657@linux.dev>
Date: Thu, 10 Sep 2026 20:20:29 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix out-of-bounds read of sk_protocol in
 bpf_sock_destroy()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: xmei5@asu.edu, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 john.fastabend@gmail.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, shuah@kernel.org, aditi.ghag@isovalent.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
References: <20260910112634.152195-1-jiayuan.chen@linux.dev>
 <0a661bac8b617cc979ba16eeaec5f7c64a0b74bb01be40347dca187cbd7c24e4@mail.kernel.org>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <0a661bac8b617cc979ba16eeaec5f7c64a0b74bb01be40347dca187cbd7c24e4@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/10/26 8:07 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 2a84f9d01131..cae43b999162 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -12913,8 +12913,9 @@ __bpf_kfunc_start_defs();
>>    * @sock: Pointer to socket to be destroyed
>>    *
>>    * Return:
>> - * On error, may return EPROTONOSUPPORT, EINVAL.
>> - * EPROTONOSUPPORT if protocol specific destroy handler is not supported.
>> + * On error, may return EOPNOTSUPP, or whatever the protocol specific
>> + * destroy handler returns.
>> + * EOPNOTSUPP if protocol specific destroy handler is not supported.
>>    * 0 otherwise
>>    */
>>   __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>> @@ -12926,8 +12927,12 @@ __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>>   	 * Supporting protocols will need to acquire sock lock in the BPF context
>>   	 * prior to invoking this kfunc.
>>   	 */
>> -	if (!sk->sk_prot->diag_destroy || (sk->sk_protocol != IPPROTO_TCP &&
>> -					   sk->sk_protocol != IPPROTO_UDP))
>> +	if (!sk->sk_prot->diag_destroy)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (sk_fullsock(sk) &&
>> +	    sk->sk_protocol != IPPROTO_TCP &&
>> +	    sk->sk_protocol != IPPROTO_UDP)
>>   		return -EOPNOTSUPP;
>>
>>   	return sk->sk_prot->diag_destroy(sk, ECONNABORTED);
> This isn't a bug, but would it help to keep the TCP/UDP rationale comment
> next to the protocol check, and add a short note that sk_protocol is only
> valid on full socks? The block comment explaining the locking semantics
> and TCP/UDP restriction now sits two statements away from the protocol
> test it documents, and the newly added sk_fullsock() guard doesn't have
> any nearby note explaining why it's there. The reason (sk_protocol is a
> struct sock member not present in sock_common) is only in the changelog.
>

Current commit message is enough.

That's why we encourage high quality commit message.

