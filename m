Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79926ED3C;
	Mon,  5 Oct 2026 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791178285; cv=none; b=dzi4qEngy0fu5YV4edobQGKWYNxr6ODjVHl+ksDZQLXXRTgvBx5OphbX2wo0iPxGzhicRttgWKeq8FKWO4uqcosQKzWS1MRJI0rTE5M9ROMoHqtwZCBLVQL9mFajc8ladMGmWjiwHEI1reNzDQ4NSklz+MVfYPEuZe6q1XOTLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791178285; c=relaxed/simple;
	bh=UrDPmVbL5jhp0wWomsAHSOwAkMLW2b7PAdgJQ0AtHbo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxZPCPtWqRXduHPMIQkMjJ5iDFi055EBEyIH6zIMrNHtv3gGFgsovGHOZKEdu3USSjCSSai1UxiqtVAponhlCwrI5vOq+G955GFEkTer0HvQewqMcCacPujxAVDahVp/c3i229Pv5krKLChg5ZaD5EuUkP61B53woy5OpUgn9a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVVOmTF1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVVOmTF1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFCE1F00893;
	Mon,  5 Oct 2026 05:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791178283;
	bh=AZEgy0bGABGsZy2Uv/VEreaEIDQ6n/6e79/9aCsLZbU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZVVOmTF1wFCvy+DwgflZ1WKk66QSFUZ19Gpo3F3e2yvm9e023uM77mCyU5r4aF3Ah
	 9Ld0PS9piwjFlgMUr3s8mUTkoy/u/CPs99NzMGTQx+agXlGcSSPgVKwUoSnccBYjH1
	 Ray04Ays6xYadCn8UHnajfmQ9L8GEhLXa6wk+yzjo2OguGkiEAS4TUY8DQQLu1PBC2
	 61v0AaWdY9FWUjal7QqbpLdo/tTAC+Mn7DfBBocBHTpNFnrmyzN8h82nmVLyXk6Vku
	 gi29dzp2DmPn4a+OIMDh2MfSuvkmRw5ly/jECznwTJaK3gYFIJbnsjzImwJzda0qgU
	 EfmS41vJemOOg==
Subject: Re: [PATCH net] xsk: freeze deferred pool teardown without blocking
 unregister
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, edumazet@kernel.org, davem@davemloft.net,
 bjorn@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 05:31:22 +0000
Message-ID: <179117828200.434549.5174779969634122541@kernel.org>
In-Reply-To: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com>
References: <20260930-xsk-suspend-teardown-v1-1-a6cac8c030be@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds one global list, xsk_dev_pools
  (net/xdp/xsk_buff_pool.c), that holds every assigned XSK buffer pool…

--

xsk: freeze deferred pool teardown without blocking unregister

This moves deferred XSK buffer pool destruction from system_wq to
system_freezable_wq, so ndo_bpf() is not called on a suspended device. It
also adds a global list of assigned pools. NETDEV_UNREGISTER uses that
list to detach pools whose sockets have already left net->xdp.list.

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 33475b180ea6f..a2ae0e10d8933 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -2145,6 +2145,10 @@ static int xsk_notifier(struct notifier_block *this,
>  			mutex_unlock(&xs->mutex);
>  		}
>  		mutex_unlock(&net->xdp.lock);
> +		/* A released socket is no longer on xdp.list. Its pool can still
> +		 * hold a device reference on the frozen release workqueue.
> +		 */
> +		xp_clear_dev_all(dev);
>  		break;
>  	}
>  	return NOTIFY_DONE;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 9d2d94f1fb759..b5fd0850db5bb 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -12,6 +12,11 @@
>  
>  #define ETH_PAD_LEN (ETH_HLEN + 2 * VLAN_HLEN  + ETH_FCS_LEN)
>  
> +/* Socket removal precedes the final pool put. Keep assigned pools visible to
> + * NETDEV_UNREGISTER even while their release work is waiting for process thaw.
> + */
> +static LIST_HEAD(xsk_dev_pools);
> +

[ ... ]

> +void xp_clear_dev_all(struct net_device *dev)
> +{
> +	struct xsk_buff_pool *pool, *next;
> +
> +	ASSERT_RTNL();
> +	list_for_each_entry_safe(pool, next, &xsk_dev_pools, dev_list)
> +		if (pool->netdev == dev)
> +			xp_clear_dev(pool);
> +}

[Severity: Medium]
Should xsk_dev_pools be scoped per netns or per netdev, rather than being
one global list?

As written, xsk_dev_pools holds every assigned pool from every network
namespace. xsk_notifier()->xp_clear_dev_all() walks the whole list under
RTNL on every NETDEV_UNREGISTER, in any namespace.

Before this patch, the notifier only walked net->xdp.list of the namespace
that owns the device. With this change, each unregister costs O(total pools
in the system). A batched unregister, such as netns teardown, costs
O(devices x global pools), all while RTNL is held.

xsk_create() only checks ns_capable(net->user_ns, CAP_NET_RAW). A user
inside a user namespace can therefore create many pools, for example with
copy-mode binds to veth or dummy queues, or with XDP_SHARED_UMEM backing
many pools from one umem. That would lengthen RTNL hold times during device
and netns teardown in unrelated namespaces.

Would tracking the pools per netdev or per netns limit the walk to pools
that can actually match dev?

>  static void xp_release_deferred(struct work_struct *work)
>  {
>  	struct xsk_buff_pool *pool = container_of(work, struct xsk_buff_pool,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930-xsk-suspend-teardown-v1-1-a6cac8c030be%40gmail.com
