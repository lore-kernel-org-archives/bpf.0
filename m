Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA593223DE9
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774927143; cv=none; b=oK3aFeP8v7f1sx1T8oXxiB9HSZud6q+r+BkKJ+QvQ8lKBx1Yb7yYbKByM/Q5AI1WZvEeb9YFxdNYtIuJQ5Lr9zMQc8jM5FiXk7nWAxXDmXC7XoZM7a1ZlXeV/c+LxVmV+iLEkQXXbbY4CLyB/VMKr0MGk8uqU+4EktO99XQvMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774927143; c=relaxed/simple;
	bh=Z7lW49Bjo8TiedKHPp1+w/stGzyGL2KI5EW5Cqvh/LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvA+pNKuEJuOp5Ql4/RwvNo/Ls7Qq2Hujv493vHYiJhFjRoZVQHlCQhWX4K0h7yuVruw0kP8b1z5kLYwe7urPVlZeG3CObt0rl9YLYEVc5wWR+xOOiMdOoDrzwsiuTsGecvMjp1BiIWWagJPpKKqV8Ix3tHMxWXPxiPbnrgThK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QUtmu283; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QUtmu283"
Message-ID: <79805496-9996-40b6-8cbf-0beaf7dd5473@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774927129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F51B4RKJm1crpeWlG2F4ZvuF8sUulbOmrWGId7sfBqo=;
	b=QUtmu283nK3yW4rIZldw9qbVYQ2MPdfxU7l1FlPCoxhAji0KPxiOtbh68BwutO2DPtRNmU
	4KsJMcz6Lszbfr8i+rWBpsGZn5x51L9Tj+zJ51w9c+eEVzLJTyX9Lcnj/bIVB8KPXA/F7O
	AXynNVz/094JlHs6fv9uyR52AlHFgME=
Date: Mon, 30 Mar 2026 20:18:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] bpf: tcp: Reject non-TCP skb in
 bpf_sk_assign_tcp_reqsk()
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, martin.lau@kernel.org,
 ihor.solodrai@linux.dev
References: <20260330080746.319680-2-jiayuan.chen@linux.dev>
 <6ee24770a2b014219d86839b2243e1b7bad4dc4f520457269d5e8ca2b21c2cb8@mail.kernel.org>
 <d1a739d2-c4ea-4fae-aeaf-f49e75dac0f3@linux.dev>
 <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAAVpQUD1n7L6LkP32H_Ct71RLNpJ2RQWFc8w08+c8h=U_tDjpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 3/30/26 6:35 PM, Kuniyuki Iwashima wrote:
> On Mon, Mar 30, 2026 at 2:26 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>>
>> On 3/30/26 5:00 PM, bot+bpf-ci@kernel.org wrote:
>>>> #if IS_BUILTIN(CONFIG_IPV6)
>>>>       case htons(ETH_P_IPV6):
>>>> +            if (ipv6_hdr(skb)->nexthdr != IPPROTO_TCP)
>>>> +                    return -EINVAL;
>>>> +
>>>>               ops = &tcp6_request_sock_ops;
>>> For IPv6, ipv6_hdr(skb)->nexthdr gives the type of the header
>>> immediately following the base IPv6 header. If extension headers
>>> are present (hop-by-hop options, routing, etc.), nexthdr would be
>>> the extension header type rather than IPPROTO_TCP, even when the
>>> packet is a valid TCP segment.
>>>
>>> Would it be worth using ipv6_find_hdr() here, similar to
>>> bpf_update_srh_state() in the same file, to walk past any extension
>>> headers? The IPv4 check above is fine since ip_hdr(skb)->protocol
>>> always identifies the transport protocol directly.
>>>
>>> In practice this is very unlikely to matter since TCP SYN packets
>>> with IPv6 extension headers are essentially non-existent, but the
>>> check as written would reject them.
>>>
>>>
>>> ---
>>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>>> See:https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>>
>>> CI run summary:https://github.com/kernel-patches/bpf/actions/runs/23735111188
>>
>>
>> Thanks for the analysis.
>>
>> There are many places in the kernel that check nexthdr directly without
>> walking extension headers.
>>
>> I'd prefer to keep it simple for now and leave ipv6_find_hdr() as a
>> potential future improvement if needed.
> 
> +1.
> 
> Given this feature is to create a reqsk to process on this running
> host, it does not make sense to support such ext options.

While at header reading, does it need a pskb_may_pull() before reading?
