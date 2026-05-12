Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF372F12AD
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628777; cv=none; b=dCh1ifq22y6Z4qiojhBWabG2kyeOCVIZNWjPIwvPyOiMKD/bk+IPEgLXnrZJ9Aj3823DwEdADNQH0NZftaVK9GsPMIW9Z8wfRD0p3rep7JJ11TGsBoUt3g0MKLHrbfCVdPrSejHlD4GAbbP8cBA6mlXN9477nvA5X/oueeu4kHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628777; c=relaxed/simple;
	bh=UCaiIf5zxhMaH5Tysgpm+dB9Itbqzrff5fhLDOcoY7w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABIR4ZZF72vFj5jjilHtFMAPTwO7TJbcVkHjKwP5Ei+n8BEDLOiyl3pnUTT78n2iPxXCAzu40/Csrio2hjk/iGbw+bciISpSNGzyV7TGDrJa/QvBsusjV9/Ld+YPdhY0ks+sZ0eya/iycozrvLc6VBS69NHYidwuG15R2bFEkBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfX2XGOU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfX2XGOU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A82C2BCB0;
	Tue, 12 May 2026 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778628776;
	bh=UCaiIf5zxhMaH5Tysgpm+dB9Itbqzrff5fhLDOcoY7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gfX2XGOUVmOefAWoVXAPam3UBvMEB4/IF98M75USd3uVRtFNoZ691FwS7PMNyZ8B0
	 7orj1nf6vdDIVAKA1WRZibMkquEsUUF+p9PKwksT2/fhNKfWsn4ifB2bFwwfRMrKzu
	 9RWgW6ZAZ1FxJhmN+BEP9KE9UOOQYnEUmRX0rXV/8MRQHG8AAhSSqz7InQJbALiuWp
	 LpEzm6y0EcqGliAY3HRjFHZNyWWmDIcHOf6ln4QiovgEEXSYxO3vCvU7Pr0LvNoZtK
	 kApjH/Ijbh6js+apbrOqv7V97Mf8r8zn/+NwJ85i61oYBLt3GOjvnlpwsSLERlnP0V
	 s9fHbEpWOaGtw==
Date: Tue, 12 May 2026 16:32:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "Mahe Tardy" <mahe.tardy@gmail.com>, <bpf@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <andrii@kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <eddyz87@gmail.com>,
 <edumazet@google.com>, <john.fastabend@gmail.com>, <martin.lau@linux.dev>,
 <pabeni@redhat.com>, <song@kernel.org>, <liamwisehart@meta.com>
Subject: Re: [PATCH v1 1/4] bpf: Add netpoll kfuncs for sending UDP packets
Message-ID: <20260512163255.34162f1a@kernel.org>
In-Reply-To: <DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
References: <20260511085344.3302-1-mahe.tardy@gmail.com>
	<20260511085344.3302-2-mahe.tardy@gmail.com>
	<20260511182019.69ebc7c6@kernel.org>
	<DIGBS3WKQN94.1YYMZM0K6CETY@gmail.com>
	<20260511193603.3ef00cee@kernel.org>
	<DIGD21MXE0XM.3CLUL6BVK74PK@gmail.com>
	<20260512065335.50647ee9@kernel.org>
	<DIGZA9DICBXO.2QQ1V7T186JW2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 13:25:04 -0700 Alexei Starovoitov wrote:
> On Tue May 12, 2026 at 6:53 AM PDT, Jakub Kicinski wrote:
> >> No. Nothing to do with 'user space prog'.  
> >
> > I'm sorry, are you saying that the motivation in the cover letter is
> > not the motivation? It'd be great if someone could reveal the real
> > motivation then.  
> 
> AI makes commit logs sound very convincing, so I don't read them anymore
> to avoid bias. Only looking at the code.
> And what I see in this set is a facility for emergency notifications
> that is safe to use in any context.

True, but I hope a real use case does exist for this given it's posted?

> If people bolt crypto on top and make a toy prototype out of it
> it doesn't take away from usefulness of sending UDP packets out.
> 
> I want to use it out of bpf core to notify of things like divide by zero,
> arena fault, etc. Currently they are sent via bpf_stream, but
> user space has to be there to pick up from the stream.
> We cannot use printk, since it's not safe.

printk is unsafe but netconsole is safe?

> So netcons is the only option available today for 'bad things happen'
> notifications.
> Theoretically con->write_atomic() can be wrapped in such helper/kfunc
> that both bpf core and bpf progs can call.
> progs also need emergency notifications.
> Like sched-ext might detect something bad and notify.
> But at the end netconsole_write() is netpoll_send_udp(),
> so more natural and simpler to just use that.

This sounds very scary. I mean it sounds exacting and technically
challenging, but I really don't want this to hinge on netpoll.
netpoll is not a good solution to synchronization problems.

> > In kernel sockets are used broadly. I accept that it's more work
> > for you but it's also the correct way to go about this if you want 
> > to send traffic from BPF.  
> 
> proper sockets and full TCP/UDP back and forth is a different use case.
> Maybe it will work for Mahe/Liam. I don't know.
> I'm arguing that emergency UDP is necessary too.
> We can skip netpoll_send_udp() and let bpf core prepare skb
> earlier in a good context, then at div-by-0 time populate it
> with a message and call netpoll_send_skb().
> Looks like netcons, bridge, vlan are using it, so why not let
> bpf core use it too?

Those drivers are not really using it, they are just trying to pass thru
the skb to the lower dev. And I'd be surprised if most of that stuff
even works, don't think it has any users. Most people try to pipe
netcons to eth0.

> __netpoll_send_skb() is the main value here because
> it's all trylock based at every step.
> The div-by-0 notification using normal sockets would have to be
> done async and that's the main downside.
> We'd need to irq_work, then schedule_work and then send it via socket.
> Way too many steps to do in emergency. If sched-ext messed it up
> kthread may or may not wakeup.

I think you may be overly optimistic on the dependability of netpoll.
Rik has added support for serial scraping at Meta because netconsole 
misses a lot of crucial alerts. And I can confirm there's a bunch of
errors that appear in that dataset that are missed by netcons.

Then there are little nuggets like some generations of bnxt NICs
having to discard all Rx frames when netcons is trying to send
and Tx is full (bnxt_force_rx_discard()). netpoll is really meant
for very narrow use cases, please trust me, opening it up for broader
use is not going to end well.
