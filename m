Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D632D8DB0
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187166; cv=none; b=sk8MrpUw3/+WxrRMr4OOPMy89qtP0lpqBty7YNmjL8HR+ttNLlm3ulzmh4uPUaGw/zoMttVSk3m+TH8z2gdQzUd/j4GUm+dWTLT3vb2kEl7t4nk3sqSujYRKG2MHWOmvEnol+K4RBJOppxQHlm7naQol4LFqDbui2ZrMmo3nOvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187166; c=relaxed/simple;
	bh=podR4pzaAzcDb+GKwYY8v8JRh+vX6rU2JggSnBIxc7g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RAtDzvwEEOy6GhwinLwx7a7AGF647id+N3WxvpEcN7zt7/meyzjSkD+PHv+O0zPLsNr6TCz19+lJZsNKOyrgl3n+XrerD31XoB/ATv7WQVyqeQyzNzWcvQ+7rajMVDAKCY5FX1mgqsMWaxqF7qwqmNk80jaVcCFVhBx2OJesq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=G2/GY7mB; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="G2/GY7mB"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOm-00FEM2-Bb; Fri, 23 Jan 2026 17:52:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Dfuf1H7CdP7qwJBc1Q0ySDLiVxcnJtTh4PIozvwSnhw=; b=G2/GY7mBhEuuwUTV5TL5n++sG9
	fCjxhEGQrdP34358fLm9qY3JDDZ2y8Lxpd771JTW05TWmuNS+LFpAY7waA+hWSXiFDleWo6akJ6pp
	DSGKKIn5AELI3NDgjUJE1HJIi2yj1zvt1VSs/yNZwmACWM1fbw78hJ0WxhClRr5qBbprDUd2oKE7X
	m4KVFNKS0tJbU1hokLbqblFQ0UQD47HrwsyTA/Au9oUPrn93ncBa4kkNo0nypCXikW7KGncAcNzjc
	BzUGdGklqyCqOhjxWuqj0bJWre+zy96isozJb7ejYTz/BSX5LAj7Vg+hUSqeTCpFdSON00uvwWNZw
	+LPkr03Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vjKOl-0005hb-PG; Fri, 23 Jan 2026 17:52:39 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vjKOg-003ttE-TX; Fri, 23 Jan 2026 17:52:35 +0100
Message-ID: <6850ad0c-68e5-4d8c-b80e-7c6adee80fdf@rbox.co>
Date: Fri, 23 Jan 2026 17:52:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
To: John Fastabend <john.fastabend@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, leonardi@redhat.com
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
 <20250311155601.eui5j2lta3q46i6u@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250311155601.eui5j2lta3q46i6u@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 16:56, John Fastabend wrote:
> On 2025-03-07 17:01:11, Michal Luczaj wrote:
>> On 3/7/25 15:35, Stefano Garzarella wrote:
>>> On Fri, Mar 07, 2025 at 10:58:55AM +0100, Michal Luczaj wrote:
>>>>> Signal delivered during connect() may result in a disconnect of an already
>>>>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>>>>> been placed in a sockmap before the connection was closed. We end up with a
>>>>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>>>>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>>>>> contract. As manifested by WARN_ON_ONCE.
>>>>
>>>> Note that Luigi is currently working on a (vsock test suit) test[1] for a
>>>> related bug, which could be neatly adapted to test this bug as well.
>>>> [1]: https://lore.kernel.org/netdev/20250306-test_vsock-v1-0-0320b5accf92@redhat.com/
>>>
>>> Can you work with Luigi to include the changes in that series?
>>
>> I was just going to wait for Luigi to finish his work (no rush, really) and
>> then try to parametrize it.
>>
>> That is unless BPF/sockmap maintainers decide this thread's thing is a
>> sockmap thing and should be in tools/testing/selftests/bpf.
> 
> I think it makes sense to pull into selftests/bpf then it would get run
> from BPF CI so we can ensure BPF changes will keep this working
> correctly.

All right, a bit late (sorry), but here's an attempt:
https://lore.kernel.org/bpf/20260123-selftest-signal-on-connect-v1-0-b0256e7025b6@rbox.co/

> I guess the trick would be to see how long to run racer to get the
> warning but also not hang the CI. If you run it for 5 seconds or so
> does it trip? Or are you running this for minutes?
>
> If it takes too long to run it could be put into test_sockmap which
> has longer running things already. We also have some longer TCP
> compliance tests that would be good to start running in public somehow
> so might think a bit more how the infra for testing is going in
> sockmap side.

5 seconds is enough for the af_vsock case. I've added a af_unix test as
well, that one takes longer sometimes. But 5 seconds per protocol do add
up, the whole run takes some time.

[...]

