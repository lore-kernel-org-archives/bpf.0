Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC794A33EF
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005378; cv=none; b=KkmMZqhIFjhuqZe+CrhKQojb+vlSkCfd12XGDX1rQxB5pCfZJBZSrry/IblU57DXuaAs7ZrFlfLE3WqeDUy2ZYRqcysKZQaKpSQS09Cdt8OS++25CazdpcPq5UIk4fOTYtwFmbXRKgjsEg+QOWFfadzToYo69chCf9uMrl3zpiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005378; c=relaxed/simple;
	bh=xPH/If+OFinBv07mVtOGGht63BeYpkpy/XN20mfGt4o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fmfp2M9QjBaiZJF88N5Up4gS9cXqbo9R2dpRpfY/xdMUu0vVehgOAtK7tGwf2ECcMkMaA9XTpdbqBiEGBQ28KLWrpsGzMVqRfrBSWr6u20ZFufUkGXClJ5pOLW5sTXI0Q0ROTqgYsDtV8pVDRnxMq+l2gA6WUdAlwbawBq06+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBZKdg3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBZKdg3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E035C2BCF7;
	Tue,  5 May 2026 18:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778005378;
	bh=xPH/If+OFinBv07mVtOGGht63BeYpkpy/XN20mfGt4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eBZKdg3Q3ed1iGAdzcMp/ry9RdRv+naVrDxciwED6MO4CNie8osUcIiyokRn7wdld
	 fTQcWS+MAQrMHWXg/0Pn7Dl18rYIO9Z98z6xFZFRrtD77NALLow3rVomWfDNcr9JKq
	 KynnyRkZe1obJOPEdI2rJaOcj13sONV9HJ5IfReGwLTAMLerKi2PEuW6Wae5E+R4US
	 eXnttZeQYqDVUM5loCjVwNgVxn5s46hvyagHXZIlndeMK5tU/q+cRMLaeYUM72Zqei
	 d3yXZRS47nM5K/xt2EYfPx0j8ryPMuQtkErKLsIFcY3LlgI7gs/WyJ/ntgMFEAA30q
	 J7TLkrSADA8Kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 08/13] net: lan966x: add shutdown callback
 to stop FDMA on reboot
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504-lan966x-pci-fdma-v3-8-a56f5740d870@microchip.com>
References: <20260504-lan966x-pci-fdma-v3-8-a56f5740d870@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 18:22:57 +0000
Message-Id: <20260505182258.1E035C2BCF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling `napi_disable()` on an uninitialized NAPI context during s=
hutdown causes a kernel panic if the switch is probed without active ports.
- [High] Network queues are not stopped and locks are not acquired during s=
hutdown, allowing a concurrent `ndo_start_xmit` to reactivate the TX hardwa=
re channel.
- [Medium] Incorrect teardown ordering in `lan966x_shutdown()` allows concu=
rrent NAPI polling to race with hardware channel disablement.
--

commit cad51ac4b346e31972387c9d5600ef4d31ee8c03
Author: Daniel Machon <daniel.machon@microchip.com>
net: lan966x: add shutdown callback to stop FDMA on reboot

This commit adds a shutdown callback to mask FDMA interrupts and disable
the RX and TX channels so that the PCIe INTx does not assert before the
driver has re-probed after a reboot.

Note: The format of this review has been altered to use a free-form summary
rather than inline patch quoting due to recitation restrictions.

Does the new shutdown routine properly handle devices probed with no active
ports?

The shutdown callback checks if the fdma flag is set and then proceeds to
call napi_disable() unconditionally. However, if the device tree specifies
no active ports, the NAPI structure might not be initialized since
lan966x_fdma_netdev_init() runs inside a port iteration loop, even though
the fdma flag is set to true early in the probe sequence.

Calling napi_disable() on an uninitialized NAPI context will cause it to
dereference a NULL dev pointer to acquire the netdev lock, leading to a
panic on shutdown. Should the code verify NAPI initialization, perhaps by
checking lan966x->fdma_ndev, before attempting to disable NAPI?

Could a concurrent transmission reactivate the TX hardware channel during
shutdown?

The shutdown routine calls lan966x_fdma_tx_disable(), which stops the
channel and sets tx->activated to false. This happens without stopping the
network transmit queues or acquiring the transmit lock.

If a concurrent transmission occurs, the network stack could invoke
lan966x_fdma_xmit(), acquire the lock, and call lan966x_fdma_tx_start().
Because tx->activated was just set to false, the transmit start routine
might write to the hardware to restart the channel. This would leave the
DMA channel active across the reset, defeating the purpose of the shutdown
callback.

Would it be safer to detach the device (e.g., using netif_device_detach)
or acquire the appropriate locks before disabling the TX channel?

Is the teardown ordering in the shutdown callback susceptible to a race
condition with the NAPI polling thread?

Currently, the hardware channels are disabled before NAPI is disabled and
the hardware interrupts are masked. Because interrupts and NAPI are still
active, a hardware interrupt could fire while the RX channel is being
disabled, scheduling NAPI.

This would cause the NAPI poll routine to execute concurrently with the
teardown process, potentially accessing descriptors or writing to reload
registers while the channel is discarding databases and stopping.

Should the shutdown callback mask hardware interrupts and call
napi_disable() to cleanly stop the software polling thread before writing
to the hardware to stop the DMA channels?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504-lan966x-pc=
i-fdma-v3-0-a56f5740d870@microchip.com?part=3D8
