Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671863AA507;
	Tue, 28 Jul 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246045; cv=none; b=NEyt4w0FH5hG/W5JCfeYm1iCzBxnlATcgXFVGzEqaxMMMkdeJhulWGqjxlXcuYJxx582vwmHZroUQRlWFwHALn/16KHczSBH3+J72N9nrueZInLewEnGlq9Po6Ke8NBKRgVsRzv9mswgZzhpNmk5Qlr0NX8vZLIcFhUtldSJm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246045; c=relaxed/simple;
	bh=IsGDfwRBulAR9qotrG5Vf4d8u50Ui+66Ni3KSCVs0K0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MZrcGuffShwfNatdcADMKYnSvThm7dmiuYc7gCe1oJ4z/gxv/YIGlIeEQdzykGJCkMOiDzbk8pLWUE22V7wWrBs+41DODZ3ymiJkll36ukSYeuiF2DYUHHhl6kOJDkboa+eGjKVH65ThCnmFG3CeG4XN6XrAn5uBcD+0pab2350=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhKjPSeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhKjPSeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F42171F000E9;
	Tue, 28 Jul 2026 13:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785246044;
	bh=vOOA4bOpleOp7twfypjugdtV7HCW0d5c8RCs1tu6pKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fhKjPSeLzdCi+5ypi1kBW2yvHXH7ovaBl9TSqZwPGyTIMVceNuqz3K68rwIiHFiq2
	 T/Rd46oU9JcSS4ZftudQKeTBKoWU6d35PEtzaJigRjT1WsY7ZW+dhBThvyJ3zAnWZW
	 z5C7wa6cQ36UrcQU2Ze3w5cWtw7X6hYn+rsQTjKlmEinuK1QLKum9Y577UdO15qam8
	 5/28JXm7tD5Pu8WOdt4iMwl8NX8Hn3aFfDD7ewHhHeeOPMM/ZM6yH8JgZbN+woMXiw
	 R62KS/ifQnK6BBEbL8aRq9RHD+vIuiddpN4jjsF0t5pbN5w4if4UWMyKMMBhjz1+6m
	 xybNdPQgsZ/fg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990F380DBDB;
	Tue, 28 Jul 2026 13:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] XDP metadata support for DQ RDA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178524600877.1734420.2380713505253103942.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 13:40:08 +0000
References: <20260722221634.186886-1-joshwash@google.com>
In-Reply-To: <20260722221634.186886-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, hramamurthy@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, jordanrhee@google.com,
 thostet@google.com, nktgrg@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 22 Jul 2026 15:16:32 -0700 you wrote:
> This small series enables XDP metadata support in DQ RDA mode. While
> space is reserved in the headroom for metadata and the DQ queue format
> supports the xmo_rx_timestamp metadata operation, support for adjusting
> the metadata and passing metadata along to SKBs was not actually
> implemented.
> 
> v3:
>   - Make use of xdp_build_skb methods to implicitly pass on metadata
>     when constructing SKBs from XDP buffs.
>   - v2: https://lore.kernel.org/netdev/20260318192450.3400774-1-joshwash@google.com/
> v2:
>   - Fix referenced commit hash
>   - v1: https://lore.kernel.org/netdev/20260316230434.1398828-1-joshwash@google.com/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] gve: use xdp_build_skb methods for XDP_PASS case
    https://git.kernel.org/netdev/net-next/c/114928723411
  - [net-next,v3,2/2] gve: add XDP metadata support for DQ RDA
    https://git.kernel.org/netdev/net-next/c/871657dc6996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


