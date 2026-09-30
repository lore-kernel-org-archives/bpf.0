Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC23392C4B;
	Wed, 30 Sep 2026 04:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743095; cv=none; b=jHqkP02H0jC5H+7lssRphSeV/0lSN8Ovv3ADMIxdhvKrjWNwF5KnoBjHLb4bPzWoRGEv836+irAI7ajiL7+pgRpPhsDdGjGPi47zvsN4kg65dAE2kMLzA4Iwi0+EBUjlRUnHlv93uOs7MFgPY3qNAQaMBIdS0nlUnKyyraGZucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743095; c=relaxed/simple;
	bh=pS2Lwv3sjGA2h93qELR9xo673lblo68aNGcyqIZBSCE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/Z8ohYE/YcsYkl1xRhtnTreK83Nn/pbalEG/RY2+ftcqJge+dRd/Iwi7Fsg7ZHNmF0EDpO628JupqaZMRhokva4JT0XqTLlyKkk5VIi9yhX+JhC69GiGZE4ZgmzalbzmyjwgJOZJayUIP96pZniAwjGemMQSME78iJ71+zNt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnIWvg6f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnIWvg6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2283A1F00893;
	Wed, 30 Sep 2026 04:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790743093;
	bh=tCiLBu8tKB8oxxTNJP8XZQmVLRsH6xerg8lO9L07YNw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hnIWvg6f3uL3QK7kGXBrgAQIbUcLBLWL+ox3qM8BWaM2A6NAKcKTePXo8vDRyCFi5
	 NbENxrBuslyprl+eW6lQQOUoP87GuLmEw78Yn88YIFLSjjkEDW39wcw0vsUd6WfBVR
	 k/t+Nr8Wh0tTojukhYm0BByTuET0yfMcLHdVQ8B3jxXgeM8bFFsZHEL9hPiowXLv3Y
	 5sGz6jz/j1RkF9KYynS4K8/ocLpHd6XZHieOL0Rp4t4bxeHozRLNAR7yoxHrjSSNYe
	 Oi1FhYstlCiP0/2S38h3kAzPCmfiJPkBze+g0+Whl8IUOnz/RQ3qxOcJ7WndC8R8Hy
	 mcwOpAQgPGUFw==
Subject: Re: [PATCH net-next 2/5] netdevsim: add ndo_xdp_xmit
From: netdev-bot+sashiko@kernel.org
To: kuba@kernel.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, jv@jvosburgh.net,
 hawk@kernel.org, sdf@fomichev.me, emil@etsalapatis.com, liuhangbin@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, aleksander.lobakin@intel.com
Date: Wed, 30 Sep 2026 04:38:12 +0000
Message-ID: <179074309271.434549.17460235254095574984@kernel.org>
In-Reply-To: <20260928223648.2739371-3-kuba@kernel.org>
References: <20260928223648.2739371-3-kuba@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message overstates the testing gap.
- [Low] nsim_xdp_xmit() in drivers/net/netdevsim/netdev.c counts every
  frame as tx_dropped, frees it with xdp_return_frame(), and then…

--

netdevsim: add ndo_xdp_xmit

This commit adds a stub ndo_xdp_xmit callback to netdevsim. With it,
netdevsim can be enslaved to a bond that has an XDP program attached. The
stub counts every frame as tx_dropped and frees it with xdp_return_frame(),
and netdevsim still does not advertise NETDEV_XDP_ACT_NDO_XMIT.

> Bonding refuses a slave which has no ndo_xdp_xmit once the bond runs an
> XDP program, so netdevsim can't currently be enslaved into an XDP bond
> and the propagation of XDP down to lower devices has no test coverage
> at all.

[Severity: Low]
Is "no test coverage at all" accurate here?

tools/testing/selftests/bpf/prog_tests/xdp_bonding.c already enslaves veth
devices to bonds and exercises bond_xdp_set()->dev_xdp_propagate(). veth
implements both ndo_bpf and ndo_xdp_xmit. For example,
test_xdp_bonding_attach() checks that attaching to a slave fails once the
master has a program:

	link2 = bpf_program__attach_xdp(skeletons->xdp_dummy->progs.xdp_dummy_prog, veth);
	if (!ASSERT_ERR_PTR(link2, "attach program to slave when master has program"))

test_xdp_bonding_with_mode(), test_xdp_bonding_nested(),
test_xdp_bonding_features() and test_xdp_bonding_xmit_policy_compat() also
rely on propagation.

The actual gap looks narrower. The drv-net tests can't use their default
device, netdevsim, as an XDP bond slave. The follow-up xdp_bond_set_hds()
test in tools/testing/selftests/drivers/net/hds.py in this series depends
on that.

Could the commit message describe the gap more precisely?

> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index eebc02ccc4a92..3790b6eb4083b 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -185,6 +185,25 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +/* Do not advertise NETDEV_XDP_ACT_NDO_XMIT, no real datapath.
> + * This is a "stub" which allows netdevsim to be put under a bond with XDP.
> + */
> +static int nsim_xdp_xmit(struct net_device *dev, int n,
> +			 struct xdp_frame **frames, u32 flags)
> +{
> +	int i;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	for (i = 0; i < n; i++) {
> +		dev_dstats_tx_dropped(dev);
> +		xdp_return_frame(frames[i]);
> +	}
> +
> +	return n;

[Severity: Low]
Should nsim_xdp_xmit() return n here? The ndo_xdp_xmit kernel-doc in
include/linux/netdevice.h says:

 *	netdevice. Returns number of frames successfully transmitted, frames
 *	that got dropped are freed/returned via xdp_return_frame().
 *	Returns negative number, means general error invoking ndo, meaning
 *	no frames were xmit'ed and core-caller will free all frames.

Every frame is counted as tx_dropped, but returning n tells the caller that
all of them were sent. bq_xmit_all() in kernel/bpf/devmap.c would then
report sent == n and zero drops:

	trace_xdp_devmap_xmit(bq->dev_rx, dev, sent, cnt - sent, err);

bond_xdp_xmit() would also count each frame into nxmit as transmitted:

		err = slave_dev->netdev_ops->ndo_xdp_xmit(slave_dev, 1, frames1, flags);
		if (err < 1)
			break;

As a result, netdevsim's tx_dropped counter disagrees with the tracepoint
and the bond about the same frames. There is no double free, because
sent == n.

Normally the NETDEV_XDP_ACT_NDO_XMIT checks in __xdp_enqueue() and
is_valid_dst() block this path, and bond_xdp_set_features() clears the flag
when a slave lacks it. So it is only reachable in the "anything which does
anyway" case from the commit message. One example is frames already sitting
in a bond's devmap bulk queue while a netdevsim slave is being enslaved.

Would it be more consistent to count the drops and return 0 or a negative
errno such as -ENETDOWN, without freeing the frames, so the core frees and
accounts for them?

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928223648.2739371-1-kuba%40kernel.org
