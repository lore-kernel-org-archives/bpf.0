Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B745181334;
	Fri,  2 Oct 2026 01:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790904171; cv=none; b=LvJotj2gzu6Mz4j8L6nfb2oExEmiLpwDMYfJMxExmjzepufQTa82ioo/oLku1gOSn8QN7dyTYj+bQeLM8WlMlHNKzT8KXyWAj8ofzSlb8AEs+OaV1/BdNEe9WKhozCJiAaoCK03QMBe/vi7nR6tZaOOYQgM6xmAYpwipEcKcHGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790904171; c=relaxed/simple;
	bh=0gHTxE2cSucyDzQx+Zie4lRCgH8T8uixsbBnV39EB34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Twx8IkAsaUha4Ups413DoFfSwjmQmMxfumgUYdsP50lHc3vR5rzWTcQ15YDyZuIdfGEnKxKmoiXuxfCdrjPYz2YgPvNIM7o6DZtRlWu6jrbfAa3/3YHIgYJgfuW8fiKLuNYCrG+QI4T5w99btXzGJBSWzpNIQPBY0+QY6T+UcA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIVp93CJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIVp93CJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EFA1F000FF;
	Fri,  2 Oct 2026 01:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790904169;
	bh=Op7Esq91JGw2XJZDWgaeP/RwiCdoA55+nD0mVTlhrac=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZIVp93CJ8QYUZerjIhFSBBQFA5kwbBRZxFzMOVFgMlWwVb+GB+gmKZ9s1NL4LbKEK
	 nKRqEIJoaEnp7qBpcZYS9HBn7ZcWLN3WJ2I602jtEiE5gYBLqJO7/cqVr+AfRoqlRN
	 thx6CzydI983midMU//y+Hd6kByeIAgftfgeg1PVfzdPcgKHuyu8wJrKvtygh/YGdi
	 5PsM8pdiWTjvPEgA6xGG0UGXAZzOUZSeUyNYfEJ7ZQH059IlMWPXX/c36K5v6nlACT
	 zojpEJfyKOiNvusAgQQ4/RQEIlX0CaTblEDZ9uKBX2g4c0jvPPHwvPUrDg7vqrEEP9
	 S+D4mW21mFwug==
Date: Thu, 1 Oct 2026 18:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
 <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v18 net-next 0/2] octeontx2: mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <20261001182248.376c1b01@kernel.org>
In-Reply-To: <20260929022915.2704627-1-rkannoth@marvell.com>
References: <20260929022915.2704627-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 07:59:13 +0530 Ratheesh Kannoth wrote:
> This series adds hardware offload for channel-mode mqprio with
> TC_MQPRIO_SHAPER_BW_RATE on Marvell octeontx2/cn10k PF and VF RVU
> netdevices. Each non-QoS transmit queue is shaped by programming MDQ CIR/PIR
> on the NIX TX scheduler. When bandwidth offload is active, the driver
> allocates one SMQ per queue, parents every MDQ under TL4[0], and maps each
> traffic class min/max rate to the queue(s) in that class.
> 
> The NIX TX scheduler hierarchy cannot be reprogrammed live today, so
> mqprio add, replace, delete, and failed-replace rollback rebuild it by
> bouncing the netdev through ndo_stop()/ndo_open(). That intentionally
> drops in-flight traffic on each change. otx2_mqprio_restart_netdev() clears
> __LINK_STATE_START before ndo_stop() and does not call
> dev_deactivate()/dev_activate(); carrier and TX queues are restored after
> ndo_open() via the normal link-event path when the link is up. Cache the
> active rates and restore MDQ shapers from otx2_mqprio_up() during ndo_open();
> fail closed if restoration fails, leaving ndo_open() unsuccessful and the
> interface administratively down.
> 
> Track mqprio configuration in mq_offload_snap snapshots (TC layout and
> rates). On tc qdisc replace, stage the new configuration while keeping
> the previous snapshot for rollback: failed setup restores the old
> snapshot via netdev restart when the interface is running, successful
> graft is recorded through TC_ROOT_GRAFT, and teardown of the replaced
> qdisc instance commits the staged snapshot without tearing down the live
> offload.
> 
> Patch 1 converts PF/VF and representor flag access to atomic bitops.
> Patch 2 depends on it for safe OTX2_FLAG_INTF_DOWN and OTX2_FLAG_PORT_UP
> updates on asynchronous mbox paths and during the mqprio netdev bounce.
> 
> The driver rejects offload unless the interface is running and the device
> advertises CIR+PIR support. PF and VF RVU netdevices share the same TC
> offload path via ndo_setup_tc / otx2_open(); SDP representors are not
> supported. Per-TC rates are rejected when a traffic class spans more than
> one queue. Concurrent PFC, XDP, SDP rep, or HTB use is blocked, and ethtool
> channel count changes are blocked while mqprio bandwidth offload is active.

coccicheck

drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c:2182:7-74: WARNING avoid newline at end of message in NL_SET_ERR_MSG_MOD

Obviously please still wait for the AI feedback before sending v19
-- 
pw-bot: cr
