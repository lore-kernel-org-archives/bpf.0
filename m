Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515035E926;
	Mon, 29 Jun 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748169; cv=none; b=gIbeBdV8Huj+HcNzoapIUT19LRgntrbRAb3/eZ/nEYwX2AZND3vF9HCD8xTBkxEDvQryiHpPd46MbR0wWPyWa9w7v8zWNFu7KHAiauO9sOB+xVSnPqFRfKWaDjD4XdLZLZMeNl/RIBk3+UHb3GiLYUMiBMcP4Qb2+la0riIho4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748169; c=relaxed/simple;
	bh=a7gjJjimoCo2/e9mYDjktdyqawDyzH083Zsq1hR6j+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHlbxeO9yT1n9WRshFxGPrXt7OGmr85aiQeH9giO7dmXWZylipIkyuvFWqxQCLdQsIox+z51bdyxXQCXNa1DkJke8rXV9M6HXVTGmjWNO+kr3TslooCngqBJukNl0K+nfkT0Ss/p4sD4c4bsYDZMYZTvQzw/YO1Kn4KcF2o9jNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5VDrsyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5VDrsyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB581F000E9;
	Mon, 29 Jun 2026 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782748168;
	bh=hXl4dJbP3FOa6+eSSAvZZMi6VNC2jfLpdmSwqcoEoNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m5VDrsytbDBfEN1nGXcsOCcU+kmYtf7Ai+/MPDbMTAT0mG4iwc+/f0L0F9tS+Wu5/
	 e+1db566e+YEuCJxdMmTArGz6ciB7Yyu/2I0lQmGmHCcwm+WToCFod1K6V9lnwudQw
	 iodPcQJVkIw2mqAIqoBF6AiSc2tFAFPT+aoB7Br2A2LBouymE0Ns7I3wT9+0/vHcxK
	 nBKxOD7cgKLbQUkZDGAu84qI3XuDVD7ghhaB49beoRPZ+O7zgPmoevw5artZjRr3Lo
	 Ifx2ddFGDPYJfgJtulX70MQdmfwzE3LNMph7q5n2Of5xFQ6IF3npcNCHP8JZavflH6
	 M9jv8OCZaTk4A==
Message-ID: <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org>
Date: Mon, 29 Jun 2026 09:49:26 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Avinash Duduskar <avinash.duduskar@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <87se65bd04.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/29/26 9:08 AM, Toke Høiland-Jørgensen wrote:
> David Ahern <dsahern@kernel.org> writes:
> 
>> On 6/23/26 9:05 PM, Avinash Duduskar wrote:
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 89b36de5fdbb..e00f0392e728 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -3532,6 +3532,29 @@ union bpf_attr {
>>>   *			Use the mark present in *params*->mark for the fib lookup.
>>>   *			This option should not be used with BPF_FIB_LOOKUP_DIRECT,
>>>   *			as it only has meaning for full lookups.
>>> + *		**BPF_FIB_LOOKUP_VLAN**
>>
>> This flag should not be needed. Patches for vlan support were never
>> submitted (I have them in some old branch). Since the vlan params are
>> initialized to 0, no new flag should be needed. Besides, these are
>> output parameters.
> 
> There's no enforcement from the kernel side of the parameters being
> zero, though? So we do need the flag for feature detection; unless we
> expect applications to do that out of band? But then we'd need a
> mechanism to do that which could be... the presence of the flag in the
> ENUM (and thus in BTF)? :)
> 

This is output direction - return from the fib lookup. It does not make
sense to require a flag to get lookup output. vlan proto of 0 is not
valid, so it is a clear indication that the vlan output parameters were
not set during the lookup.

