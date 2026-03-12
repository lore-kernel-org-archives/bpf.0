Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947739B970
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773313586; cv=none; b=bmeCx/u9PPPiM0e/sjfOIR+to4SHIXjbEg0gDORxl/0aEfxEkV3NJ0D0Iy94uQqtwBc27xc1jPR7CMR6M2YtrlNH28Vy18me6eI20b0fDLHNG8WiuLOiKKZjVkZuZ91JMwvAJypxkrgd+GJTS8rW0f50BSNIPHqrujRGtN2FfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773313586; c=relaxed/simple;
	bh=/9J3tVGfkbfc2ZVBxryfqsIyn/sMRAL1gB1bZI9O198=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyHkIhW8D3EfXw9eH2UQq7XqhU81aW8M6d1mmBsnG2m8bEKkQQmT7wrRUqq305ndlolTHjNLNW0kxgPDvL35am6vsHo0QWVbl5295aojDOM95JjXFWcyGx95wDj17iA9IN//v/bgUMup4JHKW8P6oyYsgPrwFTz+g/+IPBLBYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=lo1fbn9I; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="lo1fbn9I"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so9311815e9.3
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1773313582; x=1773918382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=lo1fbn9IUDe5MIIH1gniUfknj20+xbZ8vY5+XQiNnxehi4LaS6doKTkpmlD7GG92oE
         ne8w9eOgJWzf9yXUKxgVbHk7dfp18IxPzx+fqsVOQWdNh/W3qIMW2Tt+mWW/QhzBvO+F
         hKjv59akDwk7lecfhignf3LR+JJEjNWZ0s+snVtIPWetzHU4RaWAIlPPDA5DGlz4rfaY
         SK5ECTrPjRv4dLQwWc1VlRGe/NvEkCLouTmZpaLGq40unimcx1te45kmCcUaZraVyYqa
         TRQApYBMjSZKLhjItpWk+wISDadaC9ZyCSg7NRrPftjWXUeD7fpT7lFJah2rA+q/LEpa
         StLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773313582; x=1773918382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi90ehS/6At/d9Hc+H9BmnTyiPTBQruO8CzKtDXyqkU=;
        b=YR5AHnjEW+B8mFjILKWVo2BeeeRLHQdRB8v2xZKWcD6tu0EUPHAV0Sdsp/bMLbhO3c
         PIAttcR6uYfQyBAKuHtjO+X6I4apusGsOlf9M4SKU6bzY6VTTrO2tEr7VGMtXEOkxJxK
         +MqLMBbNEugI2yO9XPdVAVI5t4sApS0o53d6tqSgg6NeJZbQm4vGQr+RA+i3s1aD5fFO
         mb9U744SaNZ/P7aGOQqk367+1uJ5Gjy2LaWewEQiYw7tgz9clxuYlO4VtAD3WMVI/nNZ
         Jd7q45jM3T1WcDD5xwKMPklkMreg5vN6MBR1FTdr3z0eGcGnUk8AUdrVV7TtA8FC6Tox
         jDpg==
X-Forwarded-Encrypted: i=1; AJvYcCUcIPMF37dIHIVoG0pWyRyrdiiNz04DQMaKjnVoDYdsoqcoOEIGaSrW6jk1tMYrQQtAHn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7/TXOcreHQEFxfmBfPzq0doygphMxJ0+hpH1LusREMCJGL6k
	J7P0H1giugvNmX7UrNmdNtYiWlSdu9DVAv6bAE6gQnKi+td/i6aQMI8aVDVDDJ9UgE0=
X-Gm-Gg: ATEYQzwDiWYbol4iP0V0cWx7gWncCX0UfF4BLhPNson6kanKvy5+qgaWN6WLWgHFMoW
	jgeW5Yit6pcvf7Jsjku/67cl4VeMdJ6iYrp+ZiZVm+d/AQAspJTkE0EBleeXaqolaNVmVHpdUcQ
	XkceatbsxCzc/BEI/+OfDyFLkSUuUFaCuYEkUsrK0sCAmBMISLJbp8RQZQHuKXSbjk9PwoQyJ4h
	VsYnamUWmQYS3XteEJixZ0f1q7YCs3ztgMYLUI64J3f0XJMD0bcIBgGtT6Xve00a5DI3wY3onOD
	DK7Qi1AJ1aluuR9Gu7WeWXT2eFQEwpeyOK6ItKAQBjainsADV+hmXdNW9sOpTLnH3Ysz8NZg/y7
	m+lRSilHcR7HV3/X5k3KdvG10vATB6wAlzjyVO+eCVJgZEtOfSCVDBVm119tyj32EMMr8uxsESH
	vs8SSMcJs8EnbYfZIa66myZoS7MtikfolbzwjEmOf6SxMtaEAgTnI2HJ1Qifq7/RGicmrq
X-Received: by 2002:a05:600c:4752:b0:485:3692:e906 with SMTP id 5b1f17b1804b1-4854b0c77f4mr96011415e9.13.1773313581497;
        Thu, 12 Mar 2026 04:06:21 -0700 (PDT)
Received: from localhost (176.111.184.239.kyiv.nat.volia.net. [176.111.184.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18ddedsm108978795e9.0.2026.03.12.04.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:06:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:06:19 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v5 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <abKeK-w7K7xLuWAH@penguin>
References: <20260309030702.128520-1-jiayuan.chen@linux.dev>
 <20260309030702.128520-2-jiayuan.chen@linux.dev>
 <abAFRbJNinhN3O5v@penguin>
 <CANn89i+5yOzdiBTWm4ekc0UvMxQp=mhXbz0rU5WnfxEu3NrAhg@mail.gmail.com>
 <CANn89iLOyWzWW7w262Vsy2MOMVDXA0+UZGpEbsdLwe6e75mhKQ@mail.gmail.com>
 <abARG4sHFdUNqcRV@penguin>
 <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d746046-eed9-4d82-a064-c20b6a131bdc@redhat.com>

On Thu, Mar 12, 2026 at 11:36:20AM +0100, Paolo Abeni wrote:
> On 3/10/26 1:39 PM, Nikolay Aleksandrov wrote:
> > On Tue, Mar 10, 2026 at 01:07:15PM +0100, Eric Dumazet wrote:
> >> On Tue, Mar 10, 2026 at 1:00 PM Eric Dumazet <edumazet@google.com> wrote:
> >>>
> >>> On Tue, Mar 10, 2026 at 12:49 PM Nikolay Aleksandrov
> >>> <razor@blackwall.org> wrote:
> >>>>
> >>>> On Mon, Mar 09, 2026 at 11:06:58AM +0800, Jiayuan Chen wrote:
> >>>>> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>>
> >>>>> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> >>>>> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> >>>>> when the bond mode is round-robin. If the bond device was never brought
> >>>>> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >>>>>
> >>>>> The XDP redirect path can reach this code even when the bond is not up:
> >>>>> bpf_master_redirect_enabled_key is a global static key, so when any bond
> >>>>> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >>>>> interception is enabled for all bond slaves system-wide. This allows the
> >>>>> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >>>>> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >>>>> reached on a bond that was never opened.
> >>>>>
> >>>>> Fix this by adding a NULL check with unlikely() in bond_rr_gen_slave_id()
> >>>>> before dereferencing rr_tx_counter. When rr_tx_counter is NULL (bond was
> >>>>> never opened), fall back to get_random_u32() for slave selection. The
> >>>>> allocation in bond_open() is kept, with WRITE_ONCE() added to safely
> >>>>> publish the pointer to the XDP read side. A plain read suffices for the
> >>>>> !bond->rr_tx_counter guard in bond_open() itself, as bond_open() runs
> >>>>> under RTNL lock and is the only writer of rr_tx_counter.
> >>>>>
> >>>>> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> >>>>> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> >>>>> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> >>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>>>> ---
> >>>>>  drivers/net/bonding/bond_main.c | 9 +++++++--
> >>>>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>>
> >>>>
> >>>> This is Jay's patch + the unlikely change, looks good to me.
> >>>> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> >>>
> >>> Orthogonal to this patch  :
> >>>
> >>>  get_random_u32() typical cost is around 10 to 20 ns, I really wonder
> >>> if this makes sense
> >>> for the packets_per_slave == 0 or 1 case to haves this kind of
> >>> randomness in the first place.
> >>>
> >>> Perhaps we could use a
> >>>
> >>> static DEFINE_PER_CPU(u32, rr_tx_counter)
> >>>
> >>> And :
> >>>  slave_id = this_cpu_inc_return(rr_tx_counter);
> >>
> >> I also have mixed feelings about this patch.
> >>
> >> We probably should detect that the device is not ready before hitting
> >> something deeper in the stack.
> >>
> >> Sure, a NULL deref is avoided, bu what happens next ?
> >>
> >> We send a packet while the device is not UP, I am pretty sure this
> >> violates at least some RCU rules in device dismantling.
> > 
> > IIRC when the redirect continues, the packet should get dropped if the device is
> > not up (checks at a few places), but that's outside of bond's jurisdiction and
> > after the slave id is needed in xdp master redirect's path unfortunately.
> > I'm not sure it can reach much further, it just has the master dev's slave id
> > generation in its path.
> > 
> > In any case we shouldn't crash in the slave id generation in the bonding,
> > that ndo's only job is to return a slave id.
> 
> I'm sorry for the back and forth, but I share Eric's concern. I think
> the approach suggested by Daniel:
> 
> https://lore.kernel.org/netdev/4d15be93-b497-4499-996d-9f3a67a2abc6@iogearbox.net/
> 

That will work, I like Daniel's patch as well. It will add a test for all redirects
for master devices, but I guess that is ok. For bonding it will work because the bond
has the problem only while it was never opened (before first up).

IMO this patch still has value, because currently the code implicitly relies on
a specific sequence of events, who knows tomorrow someone may find another way
and again call that ndo while the bond is down.

> or the initial patch form:
> 
> https://lore.kernel.org/netdev/20260224112545.37888-1-jiayuan.chen@linux.dev/T/#m7c67bb12f85bc88d583788fb6e41113c46208ae7
> 
> would be better. To respond to old concerns raised there: the check is
> IMHO bond-specific, as control moves from the lower interface to the
> upper bonding device, and the code is under an RCU critical section, the
> device can't go away before the xmit is completed.

This one I don't like, it is not about going away, it is more about adding 2 new
tests for everyone and potentially 1 more cache line.

> 
> /P
> 

Cheers,
 Nik

