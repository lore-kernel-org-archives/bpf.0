Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F283B634E;
	Tue, 11 Aug 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447256; cv=none; b=cpYSm0WXigiySYKpqJtFQcoNZ7hnybBr0sVNRusUGK1D5Cx6or+K1PmoQlU8SSCT9raFgnRCl7SbVnM8MFaNvQNMHnncRM4+hm9+xTh4O1smUCO1q71iTkqbIJE36m9JPCtZcSGWHvOw4m5/QkExxN0cic4RN4MfAvHFF6+HqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447256; c=relaxed/simple;
	bh=1Kg1d6fNqSFhaTMT+bvi6bsO2TwTBiroRMlRbUMVnGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o3x6nHh0eKcEUI9W78yjTHe43gNGYK6WCf0oPTyEgjtLkOVF3CVzgXzSFTtcep/m3JKm9gi5+qsEerEyHck1Xs07+sIc3AXrra+6d5tR/8JjCc8gLw2RLthXxk+PF+zZT1CD+wincwhRdVP74NpcKLitcIqw0NQxSIzmHht05us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiXnXUjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiXnXUjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70721F000E9;
	Tue, 11 Aug 2026 11:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447252;
	bh=MLeApmPDuOk4qDiAyZ7sIV0FygkayI3kDbsIAylZjfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OiXnXUjQ2iCMCBtdwRAfymTyVctblEDgX/sv2y/ar4YDirYGT30EX6bigEFCzigan
	 DI5kgvGwip4q7j5T3Xe2tAZZSbvFcfBALR3tYqjNrQnWJjnpLdG5KjQQvf47wAITfC
	 ODKeD6Oy9q8BGu5Yy0zC8ehOwBkX+AMHvgXLo1OZAkZW7jI6pRU4y3AZ/KKZ8S11D6
	 uNA3ziuAaYZzw3eJa/qjGdmoDhQ/x+aCQbtHIRWDQYXrgr4IK+14CbBTtDhFCn1H0J
	 loJ5ZxPvHkGMEvFuQ1ogHjD8IkCyl2odWdZnc4zoe80aYUAA92TIo46hydG2RdhMrj
	 c/IPlnz8sdE5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1992A39263B4;
	Tue, 11 Aug 2026 11:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] Fix wrong transport_header when sending
 VLAN-tagged frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644720889.478070.2169903080976589065.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 11:20:08 +0000
References: <20260807063405.688780-1-wei.fang@oss.nxp.com>
In-Reply-To: <20260807063405.688780-1-wei.fang@oss.nxp.com>
To: Wei Fang (OSS) <wei.fang@oss.nxp.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, liuhangbin@gmail.com,
 mst@redhat.com, jasowangio@gmail.com, andrew+netdev@lunn.ch, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, wei.fang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  7 Aug 2026 14:34:03 +0800 you wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> When sending a VLAN-tagged frame via AF_PACKET or tap, calling
> skb_set_network_header() before skb_probe_transport_header() causes
> the flow dissector to misinterpret the inner protocol header as a
> VLAN header. As a result, transport_header is never set and remains
> at its uninitialized sentinel value (~0U).
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: packet: fix wrong transport_header when sending VLAN-tagged frame
    https://git.kernel.org/netdev/net/c/01fdecc0480d
  - [v2,net,2/2] net: tap: fix wrong transport_header when sending VLAN-tagged frame
    https://git.kernel.org/netdev/net/c/cbb35cbe8db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


