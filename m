Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5D37D10F
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468205; cv=none; b=aBeErpyJViWg+dA7Rpq9huK66omNVH+XVwSuHpw8YU5VG/sXnCJ3su1+ZknQACgy+ui0evbZNIuKe4GfU6NM366pgTiYUyGJozsXZrUCNNtjEO7PSLR6Rs1qYr9JDjhazdxshPm+Bksp+Ui5SjZCaB666y4Nucack3FCtDmUd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468205; c=relaxed/simple;
	bh=f8ma7flPZd2Glt4+7OJkMY/bVF2eAspg9o9Gu3iZiDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lnmwizktGdaKWo8U3x63uKvkfNJHfHzMnj0XRB491/UKMs/rtH5p6+5xGOl5rrdmWV4tucomP7csQeZdnkFsYSRuyoaxhYDwhP9Zrr79bz1y4iz0u+unxjy+56YOXTqmwqSDt5etQ4VhQWeonkI8JA/oXm78i83noVSBR+7cb2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/R3cwGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/R3cwGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A671AC2BCB8;
	Wed, 29 Apr 2026 13:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468204;
	bh=f8ma7flPZd2Glt4+7OJkMY/bVF2eAspg9o9Gu3iZiDo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=C/R3cwGBhAkOngixke7rAIvlBToW7jZBiUwDEKDI1hWsw6sNpP+hgx0o553VbZLYc
	 o2m/q/yj/J7dVOxtu+tu1dXgooZF6V8M9O9iiowq8II15m5z7xFEYZ/5sZDMKnqAKN
	 6+04vrq9vGA3a/iF/52V2eUj1wHcWXyGnrRX958vXo7Q/CrV7OLNudojMqV3ZdBAzb
	 ksBOitwVzwyuZJIq9rId59e6zs4BVaOtiAd25rxhy1v8HKpDOk0tTF8CODjsH3V1ar
	 /XIKaiuELfXDc16sh938DS6rbUFdaXK0/qSj6yrCHoM1gzzSJYvAsuK/TPS0VluPZM
	 fwkhASent3NSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 08/13] net: lan966x: add shutdown callback
 to stop FDMA on reboot
Reply-To: sashiko@lists.linux.dev
To: "Daniel Machon" <daniel.machon@microchip.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260428-lan966x-pci-fdma-v2-8-d3ec66e06202@microchip.com>
References: <20260428-lan966x-pci-fdma-v2-8-d3ec66e06202@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 13:10:04 +0000
Message-Id: <20260429131004.A671AC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `lan966x_shutdown()` callback fails to detach the network stac=
k and NAPI, allowing concurrent network activity to completely undo the shu=
tdown sequence.
- [High] Use-After-Free in `lan966x_remove()` if packets are transmitted du=
ring driver teardown.
--

Note: The format of this review has been altered and inline code quoting
omitted due to recitation restrictions.

commit a6cbd3c8269201ecd4eb49e03692cba4eced4799
Author: Daniel Machon <daniel.machon@microchip.com>

net: lan966x: add shutdown callback to stop FDMA on reboot

This commit adds a shutdown callback to the lan966x driver to mask FDMA
interrupts and disable RX and TX channels, preventing shared PCIe INTx
assertion during reboot.

In the newly added lan966x_shutdown() function, the network stack and
NAPI are not detached or disabled before shutting down the hardware.

Because network interfaces can remain active during system shutdown, could
concurrent packet transmissions invoke ndo_start_xmit and subsequently
lan966x_fdma_xmit()?

If lan966x_fdma_xmit() evaluates tx->activated as false after the shutdown
routine clears it, it appears it will unconditionally call
lan966x_fdma_tx_activate(). Will this directly write to hardware registers
to re-enable the TX DMA channel and unmask interrupts, effectively undoing
the shutdown sequence?

Similarly, could a concurrent NAPI poll finish and call napi_complete_done(=
),
rewriting 0xff to FDMA_INTR_DB_ENA and re-arming the doorbell interrupts?
Should the shutdown sequence call netif_device_detach() and napi_disable()
to ensure the device is fully quiesced?

While reviewing the device teardown paths, a pre-existing issue in
lan966x_remove() was noticed.

The driver calls ops->fdma_deinit() before unregistering the network
devices via lan966x_cleanup_ports(). Since fdma_deinit frees the TX
ring buffers, is it possible for the network stack to still invoke
ndo_start_xmit while the devices are registered?

Would this cause a use-after-free if lan966x_fdma_xmit() dereferences
and writes to the freed tx->dcbs_buf array? Should the network devices
be fully unregistered before their backing queue memory is destroyed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428-lan966x-pc=
i-fdma-v2-0-d3ec66e06202@microchip.com?part=3D8
