Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7673E1718
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594017; cv=none; b=AedI1YVubW/4WIaB6g6VOozD2uJgAmfXapYpGR08Fjx6fX7UVYtrd7GwAgjuYCu9oa5WZz7okY6mvuy4grRSR/TB+XzFerI/WPoztDZtsqaeEjK6caKWf3gFA5hFH9GY3uvbrCp7l0Ik3n4ZRfRvib+Muf5bIPU2CYY6bn3yyjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594017; c=relaxed/simple;
	bh=WVQVqOHx45Hb+fkOrD8x3d6A8JYikal+oe0C1T07wVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLjqnscG3NurLCJ9BU6hJ4/Zig8WPwvudAcI31uMEfQNZ7IRVl+hhMbxatLgLIPTtQWXWH2eoxKVkT9aU604qMzPGZuYtrr4q1E5zsNI6tsXBmqAl5wxoqYZ7uviAiVpMHOp5xWS05cxInYLJPp/SSQFdcirY4jdPvIgiC3bsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq4cQJyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq4cQJyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D5EC2BCF5;
	Tue, 12 May 2026 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778594017;
	bh=WVQVqOHx45Hb+fkOrD8x3d6A8JYikal+oe0C1T07wVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Uq4cQJyPgu57RNQpTP4yOYEFqeAD4ZnkxgbpLnsUfrIIJhBTCUJz/5gSflsP6Twj5
	 wpsHMk3Kg8HxiQvPJ10e13X7n/62DjFcq6Z/bTVpWdXNKjHPtRagD9xxEahBCTM8he
	 ZasJMG5bUUFFuFx9Ev8doo54uK32wQKqnppwkODekEmabHl/rGQZT8X4wYBeU5ZHP5
	 gWgacYs/uD01kctD7KQvG3/mwB0Ah+NNzZnH/mSwxE/E08uie4l+nJ9+HYJRZhWsHI
	 MyDEgG2sdUCJFfMXO3OormM9tdQmhK3jDiI0/sotNUn06zAKPynUsaYF0g7LSiN0Fw
	 zSUcRotlSjGQg==
Date: Tue, 12 May 2026 06:53:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <20260512065335.50647ee9@kernel.org>
In-Reply-To: <DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
	<20260511085344.3302-2-mahe.tardy@gmail.com>
	<20260511182019.69ebc7c6@kernel.org>
	<DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
	<20260511193603.3ef00cee@kernel.org>
	<DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 19:59:55 -0700 Alexei Starovoitov wrote:
> On Mon May 11, 2026 at 7:36 PM PDT, Jakub Kicinski wrote:
> > On Mon, 11 May 2026 18:59:56 -0700 Alexei Starovoitov wrote:  
> >> unusable toys? What are you talking about?  
> >
> > Please refer to the comments on the RFC. netpoll bypasses most of 
> > the networking stack. And there either has to be some user space 
> > to negotiate crypto or this is unusable for anyone serious.  
> 
> encryption inside UDP packet is orthogonal.
> netpoll as-is is usable and useful to send plain text
> best effort messages.
> 
> >> netpoll is already called from everywhere.  
> >
> > You mean all contexts because it's used by console?  
> 
> yes
> 
> >> bpf_netpoll_send_udp() won't add any more bugs.  
> >
> > Same as TLS + sockmap didn't? I spend enough time mopping up after
> > people.  
> 
> huh? comparing this to sockmap is apples and oranges.

There's code which has a lot of users and barely any bugs.
And then there's code which has more bugs than users.
IMO this will be firmly in the later group.

> >> I like this netpoll approach way more then creating and keeping proper socket
> >> within bpf and all head aches of keeping it around and doing send from
> >> good context. With netpoll all of these issues are gone.
> >> Just bpf_netpoll_send_udp() from anywhere and it works just like it does
> >> for dmesg.  
> >
> > No, netpoll is high risk / brittle and tightly integrated with NAPI.
> >
> > "I don't want to run a tiny user space program" is nowhere near strong
> > enough justification to expose this API. SMH.  
> 
> No. Nothing to do with 'user space prog'.

I'm sorry, are you saying that the motivation in the cover letter is
not the motivation? It'd be great if someone could reveal the real
motivation then.

> What's brittle in netpoll? It works today in any context and
> that's the main point. All the gotchas were resolved over the years
> by heavy netconsole usage. Sure, it only works in mainstream
> drivers like mlx, brcm and likely broken in niche drivers.
> That's not obstacle at all.
> netpoll_send_udp() is a perfect building block for best effort
> try_to_sendmsg.

It's not a generic building block for random subsystems to use.
netconsole is very important so we suffer its needs.

> I don't see the reason to reinvent the whole thing.
> Because alternatives are much worse.
> bpf progs would need to create UDP socket, split udp_sendmsg
> into who knows what. Lots of design questions, code reviews, etc.

In kernel sockets are used broadly. I accept that it's more work
for you but it's also the correct way to go about this if you want 
to send traffic from BPF.

> Way more headaches for everyone involved.
> Doing full networking with dst,fib,nh from kernel context is complicated.

Why would you have to worry about any of the low level details with
sockets?

> Works for NFS, but it's an uncharted territory for bpf.
> While netpoll_send_udp() is available, easy to use and proven to work.

It's not "available", the only reason it's exported is because
netconsole is a module.
