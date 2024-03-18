Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E44CE00
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780067; cv=none; b=jcQ1/eBjE4/BoGA9m3RPOmMfoK4a2EBocpiPx6h22Yx4eC0u9qIrp1pMvqbJE+hz4OgTSCLj02Y+h+BRXAo/Wy/0ixkQn/m1aQt3ODUZ4eEgM5EbiExw1j9+8MUx0vjqOo12I+Vj/QHS8M+c8IIxm3piBawmck0hyWWbZIPVj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780067; c=relaxed/simple;
	bh=triuaMZ60mtOXtQdBmPgdMTgeI33466Ra/AjR0ugP3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvVL6sL0cll+tA1RFI4QLRnkKYEqmXoGgUheOHtG/hEekjjWsB89xYZl7XHhboV0bN89NUYdCgyPRvOznHwb8anyxIUGyAKnvl8L80bZK0RAaUjupYwOGljvVQs4yJF8EexZi4S5afYjxCPwSnrwCSCrPROUjeRJ7P9jaMlGVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dO0nzjNL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dO0nzjNL"
Message-ID: <6f3325fe-4417-4024-9830-039f9c505ae0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710780061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2rselbzwsQnPA00CQBF0qMKVN2/dIzTSHPqKAMR72o=;
	b=dO0nzjNLnqo+Lm+A0JNSdop9KbLwsRrbuRecuUgsptPPgGPv9WjFZEvRuUxpQA7fPC4BZz
	XxJPjIYJk2msHj0aghZh3oGCwolkIe2gzEqfXmk2eYSU7MxNO82GWLoRcMVJk8W06D+Xvw
	LVyH+N7A1ItaJ0GAuyEHDKExumzwUM0=
Date: Mon, 18 Mar 2024 09:40:55 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PF_PACKET RPS like using bpf
Content-Language: en-GB
To: Stanislav Fomichev <sdf@google.com>, Alexandre Cassen <acassen@gmail.com>
Cc: bpf@vger.kernel.org
References: <12a4fa23-fd37-4cc9-9744-09ae056fc872@gmail.com>
 <ZfSF6aNQ419Dx9yS@google.com>
 <dc02f7f4-6996-4a1e-a45d-09784c164939@gmail.com>
 <ZfSTq3tBoHoiUNMv@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZfSTq3tBoHoiUNMv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 3/15/24 11:30 AM, Stanislav Fomichev wrote:
> On 03/15, Alexandre Cassen wrote:
>>
>> On 15/03/2024 18:31, Stanislav Fomichev wrote:
>>> On 03/14, Alexandre Cassen wrote:
>>>> Hello,
>>>>
>>>> While implementing a large scale L2 processing soft, there is a need for
>>>> high perf ingress handling.
>>>>
>>>> In short: using BPF socket_filter prog with a hash func over ethernet
>>>> address to distribute load across multiple PF_PACKET sockets: mainly
>>>> filtering out non related hkey packets. It simplify userland app by using
>>>> multiple PF_PACKET sockets in dedicated pthread.
>>>>
>>>> Longer discussion + quick source code illustration here:
>>>>
>>>> https://github.com/acassen/bpf-pfpacket-rps
>>>>
>>>>
>>>> My question would be related to sockmap. I tried to figure out how to
>>>> perform the same policing design using sockmap. And cant find my way around
>>>> it :/ If bpf verdict prog can get socket fd from __sk_buff then it could
>>>> drives the same hash/policing decision.
>>>>
>>>> Is it possible to get socket fd from __sk_buff from sockmap verdict prog ?
>>> Don't have an answer about sockmap, but I'd suggest you look at AF_XDP
>>> if you want the best perf out there with raw frames.
>>> IIRC, it just recently got a mode where you can redirect into multiple
>>> sockets (== consumer threads):
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2863d665ea41
>> thanks for replying, __sk_buff bpf mirror doesnt export struct sock as
>> present into kernel skbuff, so no options but extending.
>> AF_XDP is an option. Will extend test code with it later on.
> We do export bpf_sock in __sk_buff:
>
> 	__bpf_md_ptr(struct bpf_sock *, sk);
>
> But it has a very minimal set of 'struct sock' fields exported.

You could use bpf_core_cast() in bpf_core_read.h to cast 'struct bpf_sock' to kernel 'struct sock'.

>
