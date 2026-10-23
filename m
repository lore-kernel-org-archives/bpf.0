Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792771519;
	b=MQGfrIBhvbXxj12xg1yJOPoHCxwp/x91gMYDZw2rfzLqqWbReDOGh50aORmmUw0T7WaA
	 4X0bAdhZwnQNXh/LQX+azY1gKfY2HCpNmIEjloZS2ftxiyffxGOyNGqJ1Wk6vRa+5ocdT
	 5RPst1iEY1iV/OqKz9FFGrKu73DAEl/jkhbq3fFXvJ6bwq417Rux1OeUgoWKpkDfcSY3D
	 N3JLKpfXIEdma6zMcU1oP0UNRDE6EpyssuqbSbDr0yIaSHFUfA9VZ9uSxPbYbT1C5txAD
	 b4DA56iTlB6oWVUlYhhM+I1hRBL162xX1lkNMBXQeNwctw1AxmLvW3ueDcrForogjlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792771519;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UocDU7ImLSN8bUn3qE+8ros6Ps+AObI529MubY0oH/4=;
	b=SCktZS6IfcJtK/qt3V4mAut/sVcKob7xwsyioJe/8qngW8lwJ6Gu3ViECdmTAH/NePoE
	 9lDww3BtYzRxQKoRVuZ/r4cMcQMmvcUpurM8tmR9dUKksW412jPMUjRfuAW2kJ4vwf6ky
	 g7mo+ZugFnXQACByQ2+gGHhHeX3Uow26ANJVTXW7JfI5Tyw86sfKAvv8SBpsnvxUBg4IO
	 kQZo00lDY7wG9sTYm+ruPoXp2xsqbsGY0zLtecdEB1lzeD4NDF+VDI9vucm7tARA5kNTg
	 AZnAT79KQYi58votDdBM7gKPxo8pFBz/YWlsvPN1bAeei0lITLbFb4frtFWBGAvBLyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHzppK64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC6D606A326;
	Fri, 23 Oct 2026 16:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CHzppK64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD6B1F01825;
	Fri, 23 Oct 2026 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792771518;
	bh=UocDU7ImLSN8bUn3qE+8ros6Ps+AObI529MubY0oH/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CHzppK641dtPEq3WhYoFez5r9mHJ+3OBQKq4TIHeNzjw38VFpwUEiF3RYFs9B3iua
	 T85cXDpCsvvYQFzcXZjNlA5VpGfMv8kC7mjzqNFtQlEBCBzsNIQpL6SvLUg6AAmKVQ
	 hzZOaEL+qqGjfnYwCbAZNLmDMU3MHmNqUTDldMWvcZ9TxRH1KHLR/ERa1VUdiTWsAc
	 zMsfB4zdUqK46YYgfdifXHG6UtmADc4uub/3BdOP1sWPmZADl+OMSbrQg3PCqGHJTM
	 XFQUfZ2roPk4Htm0v2LLF8bdsxUDS7pBFGoNmRf/KD3bniFMoebjqu+i6nvId9nuNF
	 PH92+H5cd+9vw==
Message-ID: <b28db1fb-ea02-4f83-be99-c8d4b180dc6b@kernel.org>
Date: Fri, 23 Oct 2026 17:05:10 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_ksock_bind() kfunc
To: Mahe Tardy <mahe.tardy@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, willemb@google.com,
 eddyz87@gmail.com, edumazet@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, horms@kernel.org, liamwisehart@meta.com,
 martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org,
 netdev@vger.kernel.org, sdf.kernel@gmail.com, yonghong.song@linux.dev,
 jolsa@kernel.org, kuniyu@google.com, memxor@gmail.com, emil@etsalapatis.com,
 martin.lau@kernel.org, mason@kernel.org, ihor.solodrai@linux.dev
References: <20261022181620.247201-1-mahe.tardy@gmail.com>
 <e31194dd72efd3c182707e870b7e7a6d67b78be23cea06aded0275678373c64c@mail.kernel.org>
 <atseCFvfx9FbTXP3@gmail.com>
Content-Language: en-GB
From: Alan Maguire <almagui@kernel.org>
In-Reply-To: <atseCFvfx9FbTXP3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/26 9:42 AM, Mahe Tardy wrote:
> On Thu, Oct 22, 2026 at 06:45:34PM +0000, bot+bpf-ci@kernel.org wrote:
>>> bpf: Add bpf_ksock_bind() kfunc
>>
>> TL;DR: bpf_ksock_bind() called from a bpf_wq callback runs with kworker's full
>> capabilities, so a CAP_BPF-only SYSCALL program may bypass the privileged-port
>> (CAP_NET_BIND_SERVICE) check; the review asks whether to block it.
> 
> Honestly don't know if it makes sense to prevent it given you are
> creating this kernel socket from a BPF context, if anyone with more
> experience on this can help?
> 
> If the answer is yes, I imagine preventing bind() to run from a
> workqueue is the easy answer so that all creds are respected as usual
> and it's not a huge limitation (we mostly care about being able to
> send()/sendto() from a wq).
> 

I suppose one way out of this would be to forbid bind()ing to the privileged
port range; that would sidestep the issue I think. Hard to know how restrictive
that would be in terms of real use cases, what do you think?
>>
>>> diff --git a/net/core/bpf_ksock.c b/net/core/bpf_ksock.c
>>> index 37168f43c16c..c7b487d90cd0 100644
>>> --- a/net/core/bpf_ksock.c
>>> +++ b/net/core/bpf_ksock.c
>>
>> [ ... ]
>>
>>> @@ -178,6 +178,33 @@ bpf_ksock_create(const struct bpf_ksock_create_opts *opts, u32 opts__sz,
>>>  	return NULL;
>>>  }
>>>
>>> +/**
>>> + * bpf_ksock_bind() - Bind a BPF kernel socket to a local address.
>>
>> [ ... ]
>>
>>> +__bpf_kfunc int bpf_ksock_bind(struct bpf_ksock *ks,
>>> +			       const union bpf_ksock_addr *addr, u32 addr__sz)
>>> +{
>>> +	struct sockaddr_storage sa;
>>> +	int addrlen;
>>> +
>>> +	addrlen = bpf_ksock_addr_to_sockaddr(addr, addr__sz, &sa);
>>> +	if (addrlen < 0)
>>> +		return addrlen;
>>> +
>>> +	return __sys_bind_socket(ks->sock, &sa, addrlen);
>>> +}
>>> +
>>
>> Can the CAP_NET_BIND_SERVICE check for privileged ports be bypassed when
>> this runs from a bpf_wq callback?
>>
>> bpf_ksock_bind() is added to ksock_init_kfunc_btf_ids, the same set as
>> bpf_ksock_connect().  Commit 60bbe76a3f9e ("bpf: Allow ksock connect/send
>> calls from wq") made the kfuncs in this set callable from bpf_wq callbacks
>> of SYSCALL programs, and tools/testing/selftests/bpf/progs/ksock_wq.c
>> already calls bpf_ksock_connect() from such a callback.
>>
>> bpf_wq_work() runs that callback in a kworker, where current->cred is
>> init_cred with cap_effective set to CAP_FULL_SET (see init/init_task.c).
>>
>> The bind path is:
>>
>>   bpf_ksock_bind()
>>     __sys_bind_socket()
>>       security_socket_bind()
>>       inet_bind() -> inet_bind_sk() -> __inet_bind()
>>
>> and __inet_bind() then does:
>>
>>     snum = ntohs(addr->sin_port);
>>     err = -EACCES;
>>     if (!(flags & BIND_NO_CAP_NET_BIND_SERVICE) &&
>>         snum && inet_port_requires_bind_service(net, snum) &&
>>         !ns_capable(net->user_ns, CAP_NET_BIND_SERVICE))
>>             goto out;
>>
>> __inet6_bind() has the same check.  With init_cred, cap_capable_helper()
>> walks up to init_user_ns and finds the capability raised, so the check
>> passes for any netns.
>>
>> For example, a task holding only CAP_BPF can load a SYSCALL program, since
>> is_net_admin_prog_type() does not ask for CAP_NET_ADMIN for that type.
>> Such a program could bind its ksock to UDP port 53, 123 or 514 from a wq
>> callback, while the same call made synchronously from the SYSCALL program
>> returns -EACCES.  A bpf_task_work callback looks like it has the same
>> problem in a different form, since the check would be evaluated against
>> whichever task the work was scheduled on.
>>
>> Commit 60bbe76a3f9e only argued about LSM checks ("bypassing LSM checks for
>> BPF-created sockets could be acceptable"), and connect and send on a UDP
>> ksock have no capability gate.  bind appears to be the first ksock
>> operation that does, and the commit message does not address the wq
>> context.
>>
>> Should bpf_ksock_bind() refuse to run from kthread context, the way
>> bpf_ksock_create() does with its PF_KTHREAD check?  Alternatively, should
>> it be kept out of the set that is reachable from wq callbacks, or should
>> the commit message state that bypassing the privileged-port check is
>> intended?
>>
>> No fix for this was found in the provided range; 76406b1f799f
>> ("selftests/bpf: Test bpf_ksock_bind() kfunc") only adds tests.
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39831790314
> 

