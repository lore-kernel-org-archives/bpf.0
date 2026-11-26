Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706733;
	b=5Z3N5STCymNVlFGdKMw+oQi2HkZc0KT9n4SuOus6u3uJlitXVVEDnsRt8K8ybyjtT9+f
	 0IRdZV9pkCHSPmT/qQv8jMJLaKufiSkhMPRnjZ9nJc5URmI1zWmrpY5v0y/IF9yaMY9dy
	 fjSXP4MUpTMhbWx0J+MZcC/AUFe/o4Rbjqs3E8ri7ENYuIHAYFg6wsRBBaON+mdeg59dU
	 CGwQjNtZsb9SQH63sQpleqjtvEzY/aNWmUmvHB3aVhOGnLTenJB2+senm8FuzMtiy2QFX
	 jhMbbByIHXgMV+VsdP76xsrTpjTSdFxY/5VFyAwTlTh4EpYmiuI/g56+e3vwQRwzqgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706733;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BCdHGJp82IQM22hQ2Wqg/5L0lUHyT6/T/gJH8BjyT0o=;
	b=xUiGXORoy4OrIVz2B8iZVOiIzHoPmVR6lOdTDWCE9ptsS+Et+YpTIhb6giALs/Fqdab8
	 XKDSM8J3t/4DqfBgcnb88F8m/eEPhpLlFyGSB1FHe0lchMKA1F0glEkmVABQ4Qod94Tfx
	 +f55MNDh6bNtRgV9dBKZYaFHxvcTL8MMiWHsRXFcyWuGQT1+H/U/jmXzH+SOfVhkMYk3N
	 LrOXEfxnLe7UO5oQtiMsdnhuxd6DkEhc92KsBymS5AI1CpxYmKuAIvoTUN3xxIKQb3tII
	 0Wqa5ckSZkibzxFtKtaIU3LzTKg/cuOwsk6w+LIb6alOjaZvYXIvKeoAlVv+20xhEbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZhWvMs/7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF9606A327;
	Thu, 26 Nov 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhWvMs/7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DE61F000CA;
	Thu, 26 Nov 2026 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706732;
	bh=BCdHGJp82IQM22hQ2Wqg/5L0lUHyT6/T/gJH8BjyT0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZhWvMs/7JK6zkWUKM5XM4vSRCW44q9letrqUunmnuhC1f5wKSR6g8O5rrr4Q7JjfT
	 f/DaUYqBgTKBhzsVzSBHfEQ0NN2hmQkirtG6pVjZ/HScmBdNprHuqHhGIkQN7sBlli
	 W8FuRdw0w4cpu7UKrGRXvw/CW/s8C4m9x7a86Wqu1cz3xgTQydlliYBZ8Mzfq4R32V
	 hh9DVCn+WNA9YPjQeXtsxKhOpa8T4MdXAxYW1le/QQylf42UITE3V4jBEurDAuA5AM
	 MB5UNy0Y8ZJkmDxuq6c7UXI9dubhXj4Ed26ieEr8WP98kO+PlIiw7jMvUvG+128gAP
	 z4lYGCfH0qyrw==
Date: Thu, 26 Nov 2026 15:25:25 +0000
From: Simon Horman <horms@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: netdev-bot+sashiko@kernel.org, marco.crivellari@suse.com,
	kees+treewide@kernel.org, laixiangwu@cmss.chinamobile.com,
	philippe.schenker@impulsing.ch, haokexin@gmail.com,
	devnexen@gmail.com, jacob.e.keller@intel.com, sdf@fomichev.me,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, vigneshr@ti.com, danishanwar@ti.com
Subject: Re: [PATCH net-next 1/2] net: ti: icssg-prueth: Add multi-flow RX
 support with per-flow NAPI
Message-ID: <20261126152525.GD31322@horms.kernel.org>
References: <20261118184729.2302130-2-m-malladi@ti.com>
 <179537406410.3135.5804903978186343042@kernel.org>
 <20261125121153.GU31322@horms.kernel.org>
 <0eed48e6-c525-4274-afd9-c42d99d860d5@ti.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0eed48e6-c525-4274-afd9-c42d99d860d5@ti.com>

On Thu, Nov 26, 2026 at 11:29:43AM +0530, Meghana Malladi wrote:
> Hi Simon,
> 
> On 11/25/26 17:41, Simon Horman wrote:
> > On Sun, Nov 22, 2026 at 07:01:04PM +0000, netdev-bot+sashiko@kernel.org wrote:
> > > Thank you for your contribution! Sashiko AI review found 19 potential
> > > issue(s) to consider.
> > > 
> > > Critical: 2 · High: 1 · Medium: 12 · Low: 4
> > > 
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your reply
> > > (one such reply per series is enough).
> > > 
> > > - [Critical] SR1 data RX path is out of bounds.
> > > - [Critical] SR1 management-channel buffers get invalid DMA addresses.
> > > - [High] On a running interface, a failed XSK enable/disable leaves the
> > >    flow half torn down, and the next ndo_stop then hangs or the driver…
> > > - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
> > >    prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver…
> > > - [Medium] SR1 management-channel teardown is incomplete compared with
> > >    before the patch.
> > > - [Medium] Misplaced error label in SR1 emac_ndo_open().
> > > - [Medium] An AF_XDP pool bound while the interface is down silently
> > >    stops working after ndo_open.
> > > - [Medium] All flows share one desc_pool, and the XSK runtime refill
> > >    budget comes from the pool-wide free count, which other CPUs change…
> > > - [Medium] The SR1 data-flow page pool is never destroyed.
> > > - [Medium] SR1 now gets an RX coalescing hrtimer but never cancels it.
> > > - [Medium] prueth_xsk_pool_disable() can return an uninitialised value.
> > > - [Medium] On a running interface, XSK enable/disable now reconfigures a
> > >    single flow while the shared UDMA RX channel stays enabled.
> > > - [Medium] Racy irq_disabled handling in prueth_destroy_rxq() and the
> > >    prueth_create_rxq() error path.
> > > - [Medium] RX drop and error counters can lose updates now that RX runs
> > >    in several NAPIs at once.
> > > - [Medium] A coalesce setting is not applied to RX flows added later.
> > > - [Low] The ethtool channel range does not match what SR1 implements.
> > > - [Low] In the SR1 mgm flow setup in emac_ndo_open(), the IRQ check is
> > >    wrong for the signed field.
> > > - [Low] Leftover field and mixed-in cleanups.
> > > - [Low] net: ti: icssg: missing skb_record_rx_queue() in RX packet paths
> > 
> > This is quite a list of issues. And I would appreciate if you could
> > respond to them as requested above. For patch 1/2, the four that look most
> > likely to require a respin are:
> > 
> >    - [Critical] SR1 data RX path is out of bounds.
> >    - [Critical] SR1 management-channel buffers get invalid DMA addresses.
> >    - [High] On a running interface, a failed XSK enable/disable leaves the
> >      flow half torn down, and the next ndo_stop then hangs or the driver...
> >    - [Medium] Multi-flow RX does not work on AM65x SR2 ('ti,am654-icssg-
> >      prueth'), which uses NAVSS UDMA rather than PKTDMA, but the driver...
> > 
> > Patch 2/2 likely needs attention as well, but I have not reviewed it.
> > 
> 
> Yes, I am working on addressing the issues for both patches. There's been a
> gap in my upstreaming work and I've gotten a bit rusty, so I'm picking
> things back up slowly.
> 
> I am a bit confused about the bot reviews here. I receive reviews from two
> bots—sashiko-bot and netdev-bot_sashiko—and both provide a different set of
> comments. For every patch series I post, should I wait for reviews from both
> of them before posting the next version? Also, one expects a response while
> the other doesn't. Should I respond only to the one that asks, or to both?

I suggest focussing on the one that asks.

> Additionally, how do I ensure that any comments I skip (false positives) are
> not flagged by Sashiko again?

I think Sashiko is getting better there.
But I for one do try to examine mailing list history in this regard.
