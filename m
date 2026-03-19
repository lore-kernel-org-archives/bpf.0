Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B2E3CF67A
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 17:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941277; cv=none; b=dQRvzDlaKp2NjArlfClq1QQpbMBhpr9vqybgfryvNObl9ugyb6bHCss7InVXZt0ovsEkkE3WsHWpf9LNSI7gO1YLxvIBcX4piTkDgfLr1VU87XVpzW55D3iQtvbxUlUnFdWEFmsX+k5Zeah/pzZ6d5vSuBQ+vC8jMnJGU2uvQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941277; c=relaxed/simple;
	bh=p7RCR7vOn6YNBq6N5xnO6UDE2e8KWYL3tUjB20fWW68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebGdbTNzJ8tP7ZplX4FA5awZ2V+cAhoqqR3n7UcTX0AHVGF9zgjRL1z28kpoj7E979uTr+qSDCT2kUMFodRhuQMGfxSCtZmy9ia4lqQrrZGCRDeHY2kgXZB4hkA+x6plJtHAAwxkeaeEgkZSj1fDbo4OWyAzi7zNpGLWXmINepU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9XK7cUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9XK7cUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9A6C19425;
	Thu, 19 Mar 2026 17:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941277;
	bh=p7RCR7vOn6YNBq6N5xnO6UDE2e8KWYL3tUjB20fWW68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9XK7cUJK0JL2czsOGZqI1GaoE7VqxqIDs1p+ADHJ9+KRkqVm6piKDRXl8WMtEcZn
	 Clu09PXywb7r577AjzWNUi0qLCaeM5LDbzmexoDsrsycMVRWngSa8KWo6fYpeLRdAp
	 sK91SGm9gAq3UoM4WOaTJ/TWb278jNfUmF9awGrg434yUZJU2gF75c3BSK+CdkJJfJ
	 5S4TJ1Yw84rJWprlEjWafsaIbsUticHwS5NzAJINqOHcDABqbU2Qr/PFh8Um9zW1kd
	 H6b9vGEW74AEDJ7JGM3rWLLRWKEk8MZldzO4EhkC9fKRXUuzJNFTd8fh+8NbS5StJg
	 ejy3G5W9KrP2Q==
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id EDFB2F4006C;
	Thu, 19 Mar 2026 13:27:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 19 Mar 2026 13:27:55 -0400
X-ME-Sender: <xms:GzK8aVGxOK8gz6M6TzCpNTaBO8xpA1ujQoGhRZ2qM3Gf6psY6boGSw>
    <xme:GzK8aUtaU8asbLcu4jnafgHu6PrKOIXlgm9OUV7LWq19wtGQ16qkPX560Hcv9Fjn7
    fMjEtSLNJOecV1QBYMSvsNytdTbp9ZDi5e6NL8dKq1-qEV2_8mBL40>
X-ME-Received: <xmr:GzK8adRzh0jpmlOtt4uL1hLwSiX76FwNxA6VAOklMc7oMRlLy9FpYFxX5c2OnTZbWGGcJVCGYvmo3kukqiax1mzr2qfiYB-0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgv
    mhigohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghighgvrghshieslhhinhhuth
    hrohhnihigrdguvgdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgt
    ohhmpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epfhhrvgguvghrihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvggvrhgrjhdr
    ihhithhruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GzK8aWPtk04HE-5TonvUhMnyQ07Xp3wPz6bUoua9ZpSH9uTUoj33nA>
    <xmx:GzK8aT4KsqEO1_SjeglPyePHZwsjqQCMf3WslgN8TvhbppFXckZqNw>
    <xmx:GzK8aZWD1Darms_1nnD_Xc4Py1VEd_IrbqZ3MCusPYI_rugMpYxYUA>
    <xmx:GzK8aaNU8yrCt6DMkQAgH0cR1pLmW1RKQFEc7AsA7FBm1r66nnQCOQ>
    <xmx:GzK8aQhLe55JJvTo3p_5I0QaEUnyJEzu_2XxZMldaQi9CGDSMAytYYGP>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:27:55 -0400 (EDT)
Date: Thu, 19 Mar 2026 10:27:54 -0700
From: Boqun Feng <boqun@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Joel Fernandes <joelagnelf@nvidia.com>, paulmck@kernel.org,
	frederic@kernel.org, neeraj.iitr10@gmail.com, urezki@gmail.com,
	boqun.feng@gmail.com, rcu@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: Next-level bug in SRCU implementation of RCU Tasks Trace +
 PREEMPT_RT
Message-ID: <abwyGtG7hDpd8vBN@tardis.local>
References: <absfZGD3en9TUA1U@tardis.local>
 <absj6rZbyLZY8PPz@tardis.local>
 <da4313b1-9ff5-46e9-b3b7-206dbcb72602@nvidia.com>
 <abs026TUV9oAg_Xy@tardis.local>
 <abtMhd_LVp3uL_pA@tardis.local>
 <20260319090315.Ec_eXAg4@linutronix.de>
 <abwkD0mOdAbD9ENJ@tardis.local>
 <20260319163350.c7WuYOM9@linutronix.de>
 <abwo0I_mu94t5Ews@tardis.local>
 <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75J4EXu8MFD2WEQ71Ou-bapqS=_wXFFQJ6Ed62X28HO2A@mail.gmail.com>

On Thu, Mar 19, 2026 at 05:59:40PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 19 Mar 2026 at 17:48, Boqun Feng <boqun@kernel.org> wrote:
> >
> > On Thu, Mar 19, 2026 at 05:33:50PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-03-19 09:27:59 [-0700], Boqun Feng wrote:
> > > > On Thu, Mar 19, 2026 at 10:03:15AM +0100, Sebastian Andrzej Siewior wrote:
> > > > > Please just use the queue_delayed_work() with a delay >0.
> > > > >
> > > >
> > > > That doesn't work since queue_delayed_work() with a positive delay will
> > > > still acquire timer base lock, and we can have BPF instrument with timer
> > > > base lock held i.e. calling call_srcu() with timer base lock.
> > > >
> > > > irq_work on the other hand doesn't use any locking.
> > >
> > > Could we please restrict BPF somehow so it does roam free? It is
> > > absolutely awful to have irq_work() in call_srcu() just because it
> > > might acquire locks.
> > >
> >
> > I agree it's not RCU's fault ;-)
> >
> > I guess it'll be difficult to restrict BPF, however maybe BPF can call
> > call_srcu() in irq_work instead? Or a more systematic defer mechanism
> > that allows BPF to defer any lock holding functions to a different
> > context. (We have a similar issue that BPF cannot call kfree_rcu() in
> > some cases IIRC).
> >
> > But we need to fix this in v7.0, so this short-term fix is still needed.
> >
> 
> I don't think this is an option, even longer term. We already do it
> when it's incorrect to invoke call_rcu() or any other API in a
> specific context (e.g., NMI, where we punt it using irq_work).
> However, the case reported in this thread is different. It was an
> existing user which worked fine before but got broken now. We were
> using call_rcu_tasks_trace() just fine in scx callbacks where rq->lock
> is held before, so the conversion underneath to call_srcu() should
> continue to remain transparent in this respect.
> 

I'm not sure that's a real argument here, kernel doesn't have a stable
internal API, which allows developers to refactor the code into a saner
way. There are currently multiple issues that suggest we may need a
defer mechanism for BPF core, and if it makes the code more easier to
reason about then why not? Think about it like a process that we learn
about all the defer patterns that BPF currently needs and wrap them in a
nice and maintainable way.

Regards,
Boqun

> > Regars,
> > Boqun
> >
> > > > Regards,
> > > > Boqun
> > > >
> > > Sebastian
