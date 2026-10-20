Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792495807;
	b=AUyvzTPjl8V9xorKvM3MagQ5OyhO7R3RuXzFW1jxA+Gfiyh0NM4fxyzV04K4JM8p4yNi
	 G+Zk9RQ8fOAq/9huHHjtTT8sCu8a3GGLKpJz9Yndh6Je6gdQcmke2t8X+0NVctvCqNBS3
	 CkbVzUnzx2MV2/9gt+Zu1gm0rca9nv3lA1jyNzhORN66iYQuBWj7jXG5Khwj335JkoARx
	 SlADIB1QEwgdbZOOfkRjawI11NRy9fJo5ABQoO2rxbCBnrV+/mEgUGkzPkpbFJajqXvji
	 /R0js+m3pTDW6dvkGXxNrJW2xIWIFOG3lka8rNR6tbd2ufrGmhvXuPCtW8uRS2lrzMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792495807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=chpsJ+WunfMoCNCdHMpICMde6icVZzAU4K99m99QHIU=;
	b=SFDQa73ZCV341FCnNVVRMOcqeXbqwlpO0GnDSVlvIn0YFrLYBPWq7RtIvzAD71PNBy1X
	 kwLpsA0ofyt31mnWjsYbUnuRy/JmacrbsAv7rsxoXpHM7IoxZn68rn7vJPHvnm13+SLMp
	 xwAh7/C2q3RtIAeKFH2eq1VnPQOg6nA3nO8B1L3snB7eWikTRMTQ6EMEPjIqb5MXAVUNE
	 E9dl6+gDLySFfwG8oyhY0RL4n7GCJl1mS5Rj+k6jKiJQ1/hiWScgGBDlZ9vdO39NeQcjo
	 WXal8Oq/maR30IQ51acUmURjB3DbJBBdU0PfSE1hx2ofhEV5fCWDoLMcezccc9VTFCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TxySHH/P";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931C606A31D;
	Tue, 20 Oct 2026 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxySHH/P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA31F000C4;
	Tue, 20 Oct 2026 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792495806;
	bh=chpsJ+WunfMoCNCdHMpICMde6icVZzAU4K99m99QHIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TxySHH/P+EFAx+kobAWlIG0jhCOaOs2Ky/eqklYA3tFQKUY3eWgGaXzIAzdxtAqqe
	 iRyKrW6+GfNR7WrSz2Y5wCFHWilRzqhnIkjKotm72mQ1pqtKO4odhsCH/R2neAW3JL
	 VELObHGBYtrpOGrl6FVsFDIRPud0p4x/x5uaBSpTK5gA7h62Zd9t7UQCkJOj9YTYu9
	 xJosa8fdymvHBjlte4rPa3Bl+AGxoinoQLCbdEcIbFm9YwHMOnEpqFxZ5srws9BeS0
	 iGXhgSrQDS/E38zTwF5EvZ9bD60Y1qXWPIwUy6r7l7OYD8h1A7bHD2MqoeCIGkmIt4
	 3dh8MD20JOzAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774773808209;
	Tue, 20 Oct 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] tools/bpf: Remove legacy BPF tools
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179249580529.3679022.13768908000492966638.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 11:30:05 +0000
References: <20261020095124.928021-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261020095124.928021-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, yana06070@163.com,
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 20 Oct 2026 17:51:24 +0800 you wrote:
> Remove bpf_asm, bpf_dbg and bpf_jit_disasm, along with the assembler's
> lexer and parser, as suggested by Daniel.
> 
> Drop their build and install rules, feature checks and ignore entries.
> Remove the tool-specific documentation and update the PTP classifier and
> packet socket test comments. Keep the classic BPF instruction descriptions
> and assembly examples.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] tools/bpf: Remove legacy BPF tools
    https://git.kernel.org/bpf/bpf-next/c/b71326388a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


