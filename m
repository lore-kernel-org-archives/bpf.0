Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A91A6826
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772673152; cv=none; b=X2w2zaESZNV3exsNcyA1Ve77mbXG+FRs0a1f45bkBCcwzJHahIZJWHST4kvZwb5WdjzFSYGW90kE5vbjjQqcl+jB1i/rT69nIDTkwgJSYU+OkGUtsc1wGG3WXZlFYIHQlN4qctA5Eh/RqSyyP0bnI/ezjOlzRAB+8LHU0hwTxIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772673152; c=relaxed/simple;
	bh=+fczjmJjwIzzNfnJro34b5Z2j36ZovU7gO1WprJ6x3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1rOk9DAfD4T9ezlZvpqtSsh26hndRzDfBR0+Eg/O+PsHvLLVitf5euQdhLl3Jh/gYCMiMSF55jkwT4SMRZCMIpKA+oA+DdQWN63TJLqoaTimF9b8m41KLsBUdBFrgU4modqQFNh/nwhDFKTP37ib7I6oXXAkvD8z+CpRpTl+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xAbxzMTO; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xAbxzMTO"
Message-ID: <ce000648-6f4b-405a-9403-0e4570e7b6bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772673149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y5M/ymf0LUsYVhVKhDKK6AT0g7a7OiAXZVmWIxfOlCc=;
	b=xAbxzMTO+uCh61IKAh2Z0dnEzpydpF2Sv/D19r+445Ch18x5nzLuI7+r8nJu5w7x1Ye53E
	gj0FTF7Zi00+pXneP0ozSWPwdEX/tBmbqV4pLD3WeOc/uxaQNtRWEk8yYdYuOUjQLLFLEP
	urUIkT0VGFzMBISNYCq2J2uqNfPtCFw=
Date: Wed, 4 Mar 2026 17:12:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v10 bpf-next 1/2] bpf: test_run: Fix the null pointer
 dereference issue in bpf_lwt_xmit_push_encap
To: Leon Hwang <leon.hwang@linux.dev>, Feng Yang <yangfeng59949@163.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, posk@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260304094429.168521-1-yangfeng59949@163.com>
 <20260304094429.168521-2-yangfeng59949@163.com>
 <cc7b7d2a-9f7e-41ba-9010-dfbf592a0bbd@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cc7b7d2a-9f7e-41ba-9010-dfbf592a0bbd@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/26 2:33 AM, Leon Hwang wrote:
>> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
>> index 178c4738e63b..565fe8cbcdc9 100644
>> --- a/net/bpf/test_run.c
>> +++ b/net/bpf/test_run.c
>> @@ -1156,6 +1156,20 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>>   		skb->ip_summed = CHECKSUM_COMPLETE;
>>   	}
>>   
>> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
>> +		if (ipv6_bpf_stub) {
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +			dst_hold(&net->ipv6.ip6_null_entry->dst);
>> +			skb_dst_set(skb, &net->ipv6.ip6_null_entry->dst);
>> +#endif
>> +		} else {
>> +			/* For CONFIG_IPV6=n, ipv6_bpf_stub is NULL */
>> +			pr_warn_once("Please test this program with the IPv6 module enabled\n");
>> +			ret = -EOPNOTSUPP;
>> +			goto out;
>> +		}
>> +	}
>> +
> NIT: it would be more readable to handle the error path first.
> 
> if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> 	if (!ipv6_bpf_stub) {
> 		pr_warn_once("...");
> 		ret = -EOPNOTSUPP;
> 		goto out;
> 	}
> #if IS_ENABLED(CONFIG_IPV6)
> 	dst_hold();
> 	skb_dst_set();
> #endif

I have adapted this change and applied. Thanks.

