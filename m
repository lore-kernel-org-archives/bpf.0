Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39FC3DCD96;
	Fri,  2 Oct 2026 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972413; cv=none; b=USxQQnOKa7tFTVr4SJPbaLdMU6N9qVCQbDt/D0LWy/yBK34NKuEQmMyHmXQwjfBMKbKSFkJrqHsJW6QWTXAtUk+RQDfUWEBp9tB79A9drMapD8MNnuQmtpabUHbm/dfO8ZMzewfxokxA5yZz9ZqpHgKX9sORLdH4XLRzv59ekz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972413; c=relaxed/simple;
	bh=I8shtDam7DT9yJWs3mI+dEQiwN7fV7an4VXs36EI+jA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IP74mNHFLE9tm21z3oDDwEt/W40ZAPKGuOOia6gnzSC4uqk0KO9Zt9pxtvNJQmhIqaYr0XbAViTASFnZ9jeebP1f8Y9bTlpN/scRpWup8kagROsC8hJTe0LMFK0JXK76V4dGwRsjOPSJgPUeFho7d+HRl5NPDlbqQRgDSTZ7adU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDu9VcR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDu9VcR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C361F000FF;
	Fri,  2 Oct 2026 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790972411;
	bh=IE4LsdhNU5SfiDmJkZ9zOXEwMWjWebrgy9SOZRKi4+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PDu9VcR41G9L0rhokPRNyVmGcmPd0vzXeiJCulTtzuiGUx2cc3sO8Y+Nr4zy9Rn+w
	 ShmTvCulR8dFx0vsqLCFquaONxm0OxYGGSdrwpzR007qoqEUrGe70PlI0eeL+F2LK5
	 X2QqW+n7TgDLWxdKs2zieGKAztRUZEGftBVthjf/BML+zl13wPctKnkr1QvXT0jKhG
	 98Q8WRic6c/q6fonVa8n2t30Uq04dy36RXnU3E+Vy7Rdttp4juWVdg15crSZLB3z2Z
	 ImBKD3z42cXPY8kytws8H4iP4jCWGKgUmI1+8+YnU+ATbKiu8k9T0QJcbEOV7Kz3So
	 udcb+OZruFtqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7747F3811A72;
	Fri,  2 Oct 2026 20:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 00/15] net: lan966x: add support for PCIe FDMA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179097241009.3571263.7855609924848232097.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 20:20:10 +0000
References: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
In-Reply-To: <20260928-lan966x-pci-fdma-v9-0-a17caf60f89a@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horatiu.vultur@microchip.com,
 steen.hegelund@microchip.com, UNGLinuxDriver@microchip.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, herve.codina@bootlin.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, mohsin.bashr@gmail.com, horms@kernel.org,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 21:32:48 +0200 you wrote:
> When lan966x operates as a PCIe endpoint, the driver currently uses
> register-based I/O for frame injection and extraction. This approach is
> functional but slow, topping out at around 33 Mbps on an Intel x86 host
> with a lan966x PCIe card.
> 
> This series adds FDMA (Frame DMA) support for the PCIe path. When
> operating as a PCIe endpoint, the internal FDMA engine on lan966x cannot
> directly access host memory, so DMA buffers are allocated as contiguous
> coherent memory and mapped through the PCIe Address Translation Unit
> (ATU). The ATU provides outbound windows that translate internal FDMA
> addresses to PCIe bus addresses, allowing the FDMA engine to read and
> write host memory. Because the ATU requires contiguous address regions,
> page_pool and normal per-page DMA mappings cannot be used. Instead,
> frames are transferred using memcpy between the ATU-mapped buffers and
> the network stack. With this, throughput increases from ~33 Mbps to
> ~620 Mbps for default MTU.
> 
> [...]

Here is the summary with links:
  - [net-next,v9,01/15] MAINTAINERS: add FDMA library to Sparx5 SoC entry
    https://git.kernel.org/netdev/net-next/c/91ad754f3c14
  - [net-next,v9,02/15] net: microchip: fdma: rename contiguous dataptr helpers
    https://git.kernel.org/netdev/net-next/c/27470b22eca3
  - [net-next,v9,03/15] net: microchip: fdma: add PCIe ATU support
    https://git.kernel.org/netdev/net-next/c/3318a794bb15
  - [net-next,v9,04/15] net: microchip: fdma: use little-endian types for descriptor fields
    https://git.kernel.org/netdev/net-next/c/9786c387b299
  - [net-next,v9,05/15] net: lan966x: add FDMA LLP register write helper
    https://git.kernel.org/netdev/net-next/c/2e52284420bd
  - [net-next,v9,06/15] net: lan966x: export FDMA helpers for reuse
    https://git.kernel.org/netdev/net-next/c/eac4b8882a03
  - [net-next,v9,07/15] net: lan966x: use a dedicated device for DMA operations
    https://git.kernel.org/netdev/net-next/c/f83ac2d94a2a
  - [net-next,v9,08/15] net: lan966x: add FDMA ops dispatch for PCIe support
    https://git.kernel.org/netdev/net-next/c/5a97c2c00b8e
  - [net-next,v9,09/15] net: lan966x: clear FDMA interrupt stickies after switch reset
    https://git.kernel.org/netdev/net-next/c/58e73ef6a1e5
  - [net-next,v9,10/15] net: lan966x: add shutdown callback to stop the FDMA on reboot
    https://git.kernel.org/netdev/net-next/c/ab6268b958f0
  - [net-next,v9,11/15] net: lan966x: add PCIe FDMA support
    https://git.kernel.org/netdev/net-next/c/e013b82ed3b2
  - [net-next,v9,12/15] net: lan966x: add PCIe FDMA MTU change support
    https://git.kernel.org/netdev/net-next/c/1709aa382db7
  - [net-next,v9,13/15] net: lan966x: add PCIe FDMA XDP support
    https://git.kernel.org/netdev/net-next/c/fbb46fde6965
  - [net-next,v9,14/15] misc: lan966x-pci: dts: extend cpu reg to cover PCIE DBI space
    https://git.kernel.org/netdev/net-next/c/100eead96ed6
  - [net-next,v9,15/15] misc: lan966x-pci: dts: add fdma interrupt to overlay
    https://git.kernel.org/netdev/net-next/c/14b9ac2f189d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


