Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305A41C2FA;
	Wed, 21 Jan 2026 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028746; cv=none; b=EMhcQTOs3qH/BTsiyD0EEBGLIcpHGvrc+FENBSZWJovgvrZSCCEuxWbD5+o+JoE/iYBi3lb73OcxBcxWmbPgrZcvjqtnhxp2vW/wK+s7+5MbcYcBkS17ew5SU6nRvJr+r4jCJTVkUcJFN//pLX6/G1iK73DnD/6+3y5Ke6sFMVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028746; c=relaxed/simple;
	bh=upuusnwx6Y0iGqm3vOF5a0dPMw0WMlCfnjSOJODQI5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLAP2M98bfg/7nFfQJKtLXhSt28OGIE2TVQlubahr/rnGNF8/MN69NigXfOzqdjz14FWkWhDAeOBP7rEfGji+auvUnecJ3VIXg3sk+nnbxMKFopx46qehXmICJ3UrODwiRxsMALU9ZqyJi/xS47NtObsMkoDyvbbtbbm9gXs434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNMk9bRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNMk9bRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0064C16AAE;
	Wed, 21 Jan 2026 20:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769028745;
	bh=upuusnwx6Y0iGqm3vOF5a0dPMw0WMlCfnjSOJODQI5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pNMk9bRcJy2TvdgrB30y8gLy10jvjos6C79X9UOOeOFvHtgURTk4hvvc4Eydo2AFC
	 8lmJla8Np4R9rUV7YE0YPnmxUFWfcHJ+nQ4m6Ty6BKbRlYPQZTzCUAuZHzdHfokaOd
	 vS8gmWhGb9MZH0dsigSd1SxrfYv4BOAPPvFW1EbOVcWOclZZOWU6TFC46oy9erwTWY
	 N3jCUlpR0S22k3zkFN/ecMjHh3XI95eAID3dKL56fv1cHeb5lkTxifIREnl7F1z+Z9
	 BXXnOS+whebW9iCc03xORzziOROCMBJNnsai6ubvovr1awElnqde2dTC2B1QnWP+WP
	 Ph5KhpJRqwPGQ==
Date: Wed, 21 Jan 2026 12:52:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, frank.li@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH v3 net-next 00/15] net: fec: improve XDP copy mode and
 add AF_XDP zero-copy support
Message-ID: <20260121125223.5f1d6361@kernel.org>
In-Reply-To: <20260121033357.3261464-1-wei.fang@nxp.com>
References: <20260121033357.3261464-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 11:33:42 +0800 Wei Fang wrote:
> This patch set optimizes the XDP copy mode logic as follows.
> 
> 1. Separate the processing of RX XDP frames from fec_enet_rx_queue(),
> and adds a separate function fec_enet_rx_queue_xdp() for handling XDP
> frames.
> 
> 2. For TX XDP packets, using the batch sending method to avoid frequent
> MMIO writes.
> 
> 3. Use the switch statement to check the tx_buf type instead of the
> if...else... statement, making the cleanup logic of TX BD ring cleared
> and more efficient.
> 
> We compared the performance of XDP copy mode before and after applying
> this patch set, and the results show that the performance has improved.

Somewhere in this series:
drivers/net/ethernet/freescale/fec_main.c:1043:4-5: Unneeded semicolon
-- 
pw-bot: cr
