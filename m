Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742271FCFFC
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 01:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782695931; cv=none; b=H91KnDxjzi50uu8R+GzDcO/AgnU6JVBaSfasiND9WCjHYtedoQB081Igy0RSmQNvflTXLGld20Gi3gqNeHM/0zV+c2bUEh7/ah4gcE3lK+uaQw0Coi269Y6ArJRYoWtkd4WA+77euXSuxzGANL9r8rCfBiWqQoakA11xH+Q8e/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782695931; c=relaxed/simple;
	bh=JJPvMl3C5EwiyNDQZfdSCn+pGhz8kCdu5r0Z2+2OqBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVzNCMeWgslCCXcYjVbbMo64uIX7lo2BhxzAlvfOHQfbIG9X00WR6pXd7Chtk2Hnhli4ikqG9OnBb/A7EeCpiJBlQ1U2/MwhImkjXmQn3kTIHpHZTRfB7iUdN8fZF/Yk60HOjavAW9hBKByl9VzhktM0OIl0IGgNYIPjnJmun9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLNt3yQb; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLNt3yQb"
Message-ID: <b1ed59ef-9d00-446c-bc92-131ccb3d20e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782695918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92MI5kENEF5zQ2yYEaLwm6Sik2fV4GEydFbExF+S0wk=;
	b=uLNt3yQbcl+GpCAxTenm6oZ8MecAQCxbpGIjarrFZkALrW31IXszZNsfL0VsL2RqgIp5H/
	dIb9vunYRthU05oTL4xw+tXsJRbGogeMHnsaDs7XK+TLGdzRrW72UD62BBbr+ya5YchMko
	U9j7DJ00T+T0OEsOmfDMPVmDdArJdYI=
Date: Mon, 29 Jun 2026 09:18:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Amery Hung <ameryhung@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 kernel-team <kernel-team@cloudflare.com>
References: <87v7b9ysep.fsf@cloudflare.com>
 <CAAVpQUBARp1qCEomgzWXVe35WatdaswujVLku+RESm_LW0dE7Q@mail.gmail.com>
 <CAADnVQL2pfQ0BoN-vWcuCpbOBBKq_rM7Bp7P4XdLMFER5LGSDg@mail.gmail.com>
 <87mrwlyqg4.fsf@cloudflare.com>
 <CAMB2axMVhJJpP5HZtDFyQLLbKoRxhW08rj1zGRtWtgDkfYaVNA@mail.gmail.com>
 <878q85yoy5.fsf@cloudflare.com>
 <CAADnVQKr1XisnigNsBw7CsXxY3Xn5KOGtX_YDdXmNMZyJy4_Cw@mail.gmail.com>
 <a50cef70-d8fe-4f42-a89b-2c63c33a72ef@linux.dev>
 <DJHKW8E1F6PI.P3WUIG9DZE1K@gmail.com> <87cxxey09d.fsf@cloudflare.com>
 <aj6-Ga_sIrMixgKN@john-p8>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aj6-Ga_sIrMixgKN@john-p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/27/26 2:04 AM, John Fastabend wrote:
> On Thu, Jun 25, 2026 at 07:53:50PM +0200, Jakub Sitnicki wrote:
>> On Wed, Jun 24, 2026 at 01:57 PM -07, Alexei Starovoitov wrote:
>>> On Tue Jun 23, 2026 at 6:32 PM PDT, Jiayuan Chen wrote:
>>>>
>>>> Hi Alexei and Jakub,
>>>>
>>>> skmsg is actually still pretty useful for gateways.
>>>> I started with bpf by integrating skmsg into nginx as a module and 
>>>> envoy
>>>> has something similar.
>>>> The usual setup is cgroup/sk for L4 bypass (reject SYN), and skmsg for
>>>> L7, redirecting
>>>> between local apps by looking at the payload. So there are real users.
>
> Interesting.
>
>>>
>>> ...
>>>
>>>> Agree, just like we remove skmsg from KTLS which is rarely used.
>>>
>>> ...
>>>
>>>> Hope not have skmsg disabled by default.
>>>
>>> I wasn't suggesting to delete the whole skmsg,
>>> but to disable combinations that are causing issues.
>>> Like what was done for skmsg and ktls.
>>> I'd allow plain tcp and udp sockets only.
>>> Allowing unix sockets was fishy. I think we should reject it too.
>>
>> For unix & vsock we know Bytedance built a proxy using it.
>> We've been showcasing it as one of sockmap use cases [1].
>> That said, I don't know if it's still being used or not.
>>
>> If we don't want to go through the config-knob-then-deprecate process,
>> then I guess the only option is to kill it and see if anyone complains.
>>
>> [1] Slide 117, 
>> https://github.com/sockmap-project/sockmap-project/blob/810d259af6e7a5793922af3991c9dc7ff502fe19/talks/2024-09%20-%20NDC%20TechTown%20-%20Splicing%20Sockets%20with%20SOCKMAP.pdf
>
> Most the bugs I'm seeing are combinations of push/pop/pull/tail/head
> calls over sk_msg scatter gather list no one ever considered. Or at
> least I never considered. Add in additional socket combinations that
> came later and we get bugs.


IMO, the helper has issues, but it's simple. We can test every edge case,

so problems will be resolved over time.


>
> Do the nginx/envoy offloads manipulate the scatter gather list as
> well?
>
We use a helper to insert an HTTP header to mark that the packet has 
been processed by BPF, which helps with debugging and tracing.


> Do we need all these helpers? At some point I thought I was going to
> build a real kernel proxy with this, but never did it. Another option
> would be better test framework.
>
> .John
