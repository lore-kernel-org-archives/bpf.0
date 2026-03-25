Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB94390215
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 21:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474637; cv=none; b=pduH9I4lHe/akFslcfmX4c10wkhvt/wlxvPDeZ5T/dUb76sAYAp+zgaTrUDV5s00ouHPsRXGEMhXdj+rPbF+D5prctpq9bXPCQPQjn+Qo7b9GAFTJygR6fK/7h/ruDEB6N0qn/j2iLExjpY/s9YYtghv04OGpXDBra8/gODFgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474637; c=relaxed/simple;
	bh=OFVLEXhp5PXnU9A8gBRB7BZuYWxqRHBjgOIczfMd1HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9p31U6Prk/OXOV8Bexm/QtB4qYBHETraZc5kzcDvafj1dkDG/0HKPqQ8PRApNT8N8s80Pt0J3YoUNJSRmXXRpGQne/pUnZgJpUbesrpg+0GBdRMp0FRsfwC0cL4tPRaeWdcDzxZU9QafykCBFj4UEQyzehuhcVMiVlVZ5u/h4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jaOYrq1S; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jaOYrq1S"
Message-ID: <44bc646b-9889-4dc0-9068-b07b6bb7193b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774474624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vU6ZrVdNBtcOZ1Y/s0Q07CZAHWnjdN91JHaS+MDCaME=;
	b=jaOYrq1SzjxlyMmSNFxrBww9T4UCBgkYZM1fVmE0efSE6BawU7F743APErBnBHmqKxAobb
	yzPVEqnD5PhtO7L9KWxBC4KaESZwmsnS2diechib58cGIMZ9LZTczAHNNBvDRQSElxOY2u
	9n5WpEBKGHdCu+4JgMoDatDwWIG9TKI=
Date: Wed, 25 Mar 2026 14:36:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
 <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
 <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/25/26 1:29 PM, Fernando Fernandez Mancera wrote:
> On 3/25/26 8:11 PM, Martin KaFai Lau wrote:
>> On 3/25/26 5:08 AM, Fernando Fernandez Mancera wrote:
>>> As IPv6 is built-in only, the ipv6_bpf_stub can be removed completely.
>>>
>>> Convert all ipv6_bpf_stub usage to direct function calls instead. The
>>> fallback functions introduced previously will prevent linkage errors
>>> when CONFIG_IPV6 is disabled.
>>
>> Thanks for working on this.
>>
>>> @@ -6221,8 +6215,8 @@ static int bpf_ipv4_fib_lookup(struct net *net, 
>>> struct bpf_fib_lookup *params,
>>>       if (likely(nhc->nhc_gw_family != AF_INET6))
>>>           neigh = __ipv4_neigh_lookup_noref(dev,
>>>                             (__force u32)params->ipv4_dst);
>>> -    else
>>> -        neigh = __ipv6_neigh_lookup_noref_stub(dev, params->ipv6_dst);
>>> +    else if (IS_ENABLED(CONFIG_IPV6))
>>> +        neigh = __ipv6_neigh_lookup_noref(dev, params->ipv6_dst);
>>
>> Should it be ipv6_mod_enabled() instead of IS_ENABLED(CONFIG_IPV6)?
>> Is nd_tbl always initialized?
>>
> 
> Hi Martin,
> 
> I don't think so. The IS_ENABLED(CONFIG_IPV6) check here is just to 
> prevent an undefined reference when compiling with CONFIG_IPV6=n. Note 
> that this code isn't reachable when ipv6.disable=1 is set during 
> booting, as it would have crashed even before this change because 
> ipv6_stub->nd_tbl is NULL if the IPV6 is disabled since booting.
> 
> We addressed the vulnerable paths already during this series:
> 
> https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0- 
> e2677e85628c@suse.com/#
> 
>>>       if (!neigh || !(READ_ONCE(neigh->nud_state) & NUD_VALID))
>>>           return BPF_FIB_LKUP_RET_NO_NEIGH;
>>> @@ -6290,12 +6284,11 @@ static int bpf_ipv6_fib_lookup(struct net 
>>> *net, struct bpf_fib_lookup *params,
>>>               params->tbid = 0;
>>>           }
>>> -        tb = ipv6_stub->fib6_get_table(net, tbid);
>>> +        tb = fib6_get_table(net, tbid);
>>>           if (unlikely(!tb))
>>>               return BPF_FIB_LKUP_RET_NOT_FWDED;
>>> -        err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
>>> -                           strict);
>>> +        err = fib6_table_lookup(net, tb, oif, &fl6, &res, strict);
>>
>> A similar question here and other changes in the patch.
>>
>> I think bpf_ipv6_fib_lookup() is fine because the earlier
>> "!idev" check should fail when ipv6 is disabled at boot time?
> 
> Yes, the !idev check prevents us to reach this path so it is safe to 
> call fib6_table_lookup().
> 
> While working on the series I have been trying to exploit these paths 
> (this one and other changes in the series), so far I didn't find anything.

Thanks for the explanation.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

