Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD13C3BE4
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645566; cv=none; b=FVr+A8+i31ZTcax3rTiah2qg2wBRnKHMPEcYDcDrL1h6Y1Q+eXEdVqSAhbSnR/BKr9EtFvG9pq3dhRhnXVyYMKnLj0GkAlLs1DxSculDQjPX251KTY9ycE2CjnVzt33R9DuSxYd46OF2bxeN7Vwnk0v+nhorJVCwihrX5t4h95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645566; c=relaxed/simple;
	bh=N47v7eONnQY3buJuOKooWDUtMXrII78TS3KNla41Zlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHnPGNqfdisjxWPzNWjIm1hKq6rMHAyG1n1UrPONq7jyZW9nh69ZcMRhIIZijjNzbubB9276RBvzYhnEmvZA0x76Ev02XYHUzITsuwshF4IzZpMsqKv8KdVOQOS1/OoiFGDObYJSkzgrbcNevhqc0Palvuh3rSq7NLSsPSdf7Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=l5TuBfJD; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="l5TuBfJD"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso76570485e9.0
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 09:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1772645563; x=1773250363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CvZHzwfBez6SktFHis/UP+MVLhoMj8/M/nCRuUvbuQA=;
        b=l5TuBfJD0yd2e4QSZwFscYrag7RycsKhSf56F281OerWnHQqhIgrHn7ForIkVMUDXA
         bQHB/DJYaz2Q4cCBiMuhnzdcwEipcFHIqSifLRP30foC4RlbU8UwuYpFKjFUTtiVN4We
         XfdWNgJOrlxfsQAL0o8LLUZE3HaKe/w+LKZK8Q3dvqo6sgNJJ5s0+VDZEJJq6he7/NBP
         SkkbBGPUX2qsrJ6tjouPbR4/z1LtB0OhRKLsxcw6p9FnOdxwhz9oudT+n0v8wZgpKBy5
         iJ3frWlYD4L5Ljxn+XfFKUhBzZzHnLZGZuF987Gv44POrCz+/u57joN8VXm0n2hbdVRt
         dkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645563; x=1773250363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvZHzwfBez6SktFHis/UP+MVLhoMj8/M/nCRuUvbuQA=;
        b=JlHr+xOPKB/G8F2suyDwBVJi4ZtQUUQFVi0EjCnKNZRFx30hFVWM0rDID84Sh96CCB
         sIpzEh/cxcU5GC1Hz3k+aI2FMfezd3Gqs8aRimKupQu7mCacRAlL0iTiwW0zk8gUKp/o
         k10JYQZ/jHkt/Y+QLTCDn6YMpqxiUBBHw2FyyF7ZEKEX5r7zVZ1+BaVd/6AQRz4hQd25
         KboeocWRG2pBLwSSpbHY+saAZm+2JBsMrHl2urO820dYbn+48rbCiPKNv3NVyDzBQLU/
         UjVzZC7XVAFiyHdRH60A7ZQtMYNxGvL6AsxywC5pXvq2tYUxl//UUPWXpND1uIrP+C60
         5kNA==
X-Forwarded-Encrypted: i=1; AJvYcCVlTsj/r4lDfDXcl2/iH2kcha50Wk9amrRMnBOD2Jo059x5v5l37RDKERYMOzFDlEWRrRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqkO5x7igjF22pwvhEdbWfgmoD9cVUHcRgZewrRXeNMI5qoy0M
	ZQweHPTFQ4bt49/11E1UTHslrdQYOO3WnXZhHg0Rj1mE37bXLJeuVVHaX3Ftkzv+gjM=
X-Gm-Gg: ATEYQzzLizwXABt6wtQQydeU5PwZtal8J8Wp3e0j6QBRpK8Zjy5E+0Og3IAW/8l6ZVM
	CwhH11q5EF1kmHZGRcxGefLruc6XRevayl7GgOkUPW+w+nP7ROAsesVivKTiBlxAMlXSmelVtvx
	BEcRk6exbd2HaP9lnKpHu2exW7bRugQvmojTNYBl+wa9LqCmz+deMhL5W4BdahBqV2z95GFIRQI
	11wLaVARRNrEVFJfK2FMcpOhy8tZ0Z6aKbZJ34BKmb/4eyATnixdk8I3Ntnfb8NVHsXpZWGN1zK
	Mdda3B8UR/qztXKRgfaKKwPqUJ4kIZJEr/9QY4VjCBUWaBZvtFkKuryXXyOwmJLTF4mD9uh87ZX
	6I3mM6bsR6ZpH0RugXm06SIJfVTsyIWXUcVvNYov6mKqvODdFmehrkqj1ON9igtbdVaYfWRxna8
	k73GmAqHKJXIK07KoZpNkJnQY6mLomvKwhV1wOuRzdGKfPmVTF5wR9qtEvVI1zbe5V6pdv
X-Received: by 2002:a05:600c:34d6:b0:477:58af:a91d with SMTP id 5b1f17b1804b1-4851983936cmr53536205e9.5.1772645562765;
        Wed, 04 Mar 2026 09:32:42 -0800 (PST)
Received: from localhost (176.111.182.151.kyiv.nat.volia.net. [176.111.182.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48518839ae7sm56386405e9.1.2026.03.04.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:32:42 -0800 (PST)
Date: Wed, 4 Mar 2026 19:32:40 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	jiayuan.chen@shopee.com,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jussi Maki <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net v4 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
Message-ID: <aahsuPt7cY8LxETN@penguin>
References: <20260304074301.35482-1-jiayuan.chen@linux.dev>
 <20260304074301.35482-2-jiayuan.chen@linux.dev>
 <aahWymAi_CtRG0gJ@penguin>
 <1293120.1772645248@famine>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1293120.1772645248@famine>

On Wed, Mar 04, 2026 at 09:27:28AM -0800, Jay Vosburgh wrote:
> Nikolay Aleksandrov <razor@blackwall.org> wrote:
> 
> >On Wed, Mar 04, 2026 at 03:42:57PM +0800, Jiayuan Chen wrote:
> >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >> 
> >> bond_rr_gen_slave_id() dereferences bond->rr_tx_counter without a NULL
> >> check. rr_tx_counter is a per-CPU counter only allocated in bond_open()
> >> when the bond mode is round-robin. If the bond device was never brought
> >> up, rr_tx_counter remains NULL, causing a null-ptr-deref.
> >> 
> >> The XDP redirect path can reach this code even when the bond is not up:
> >> bpf_master_redirect_enabled_key is a global static key, so when any bond
> >> device has native XDP attached, the XDP_TX -> xdp_master_redirect()
> >> interception is enabled for all bond slaves system-wide. This allows the
> >> path xdp_master_redirect() -> bond_xdp_get_xmit_slave() ->
> >> bond_xdp_xmit_roundrobin_slave_get() -> bond_rr_gen_slave_id() to be
> >> reached on a bond that was never opened.
> >> 
> >> Fix this by allocating rr_tx_counter unconditionally in bond_init()
> >> (ndo_init), which is called by register_netdevice() and covers both
> >> device creation paths (bond_create() and bond_newlink()). This also
> >> handles the case where bond mode is changed to round-robin after device
> >> creation. The conditional allocation in bond_open() is removed. Since
> >> bond_destructor() already unconditionally calls
> >> free_percpu(bond->rr_tx_counter), the lifecycle is clean: allocate at
> >> ndo_init, free at destructor.
> >> 
> >> Note: rr_tx_counter is only used by round-robin mode, so this
> >> deliberately allocates a per-cpu u32 that goes unused for other modes.
> >> Conditional allocation (e.g., in bond_option_mode_set) was considered
> >> but rejected: the XDP path can race with mode changes on a downed bond,
> >> and adding memory barriers to the XDP hot path is not justified for
> >> saving 4 bytes per CPU.
> >> 
> >> Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
> >> Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
> >> Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
> >> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> >> ---
> >>  drivers/net/bonding/bond_main.c | 19 +++++++++++++------
> >>  1 file changed, 13 insertions(+), 6 deletions(-)
> >> 
> >
> >IMO it's not worth it to waste memory in all modes, for an unpopular mode.
> >I think it'd be better to add a null check in bond_rr_gen_slave_id(),
> >READ/WRITE_ONCE() should be enough since it is allocated only once, and
> >freed when the xmit code cannot be reachable anymore (otherwise we'd have
> >more bugs now). The branch will be successfully predicted practically always,
> >and you can also mark the ptr being null as unlikely. That way only RR takes
> >a very minimal hit, if any.
> 
> 	Is what you're suggesting different from Jiayuan's proposal[0],
> in the sense of needing barriers in the XDP hot path to insure ordering?
> 
> 	If I understand correctly, your suggestion is something like
> (totally untested):
> 

Basically yes, that is what I'm proposing + an unlikely() around that
null check since it is really unlikely and will be always predicted
correctly, this way it's only for RR mode.

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index eb27cacc26d7..ac2a4fc0aad0 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -4273,13 +4273,17 @@ void bond_work_cancel_all(struct bonding *bond)
>  static int bond_open(struct net_device *bond_dev)
>  {
>  	struct bonding *bond = netdev_priv(bond_dev);
> +	u32 __percpu *rr_tx_tmp;
>  	struct list_head *iter;
>  	struct slave *slave;
>  
> -	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN && !bond->rr_tx_counter) {
> -		bond->rr_tx_counter = alloc_percpu(u32);
> -		if (!bond->rr_tx_counter)
> +	if (BOND_MODE(bond) == BOND_MODE_ROUNDROBIN &&
> +	    !READ_ONCE(bond->rr_tx_counter)) {
> +		rr_tx_tmp = alloc_percpu(u32);
> +		if (!rr_tx_tmp)
>  			return -ENOMEM;
> +		WRITE_ONCE(bond->rr_tx_counter, rr_tx_tmp);
> +
>  	}
>  
>  	/* reset slave->backup and slave->inactive */
> @@ -4866,6 +4870,9 @@ static u32 bond_rr_gen_slave_id(struct bonding *bond)
>  	struct reciprocal_value reciprocal_packets_per_slave;
>  	int packets_per_slave = bond->params.packets_per_slave;
>  
> +	if (!READ_ONCE(bond->rr_tx_counter))
> +		packets_per_slave = 0;
> +
>  	switch (packets_per_slave) {
>  	case 0:
>  		slave_id = get_random_u32();
> 
> 	-J
> 
> 
> [0] https://lore.kernel.org/netdev/e4a2a652784ec206728eb3a929a9892238c61f06@linux.dev/
> 
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
