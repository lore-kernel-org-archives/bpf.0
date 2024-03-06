Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C15AD272;
	Wed,  6 Mar 2024 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687426; cv=none; b=rmfXflazpdDMfjkXCPeQNRxkIb8JJTUprdo2vhKUc4hx4gK+TKH95J6KlTWGSelgOLtUv7Sr0nOxtqoELhp9k08t6xb2C3Ppu1HIQ6xB+W9LO+w0zTWB8syhVtarge9j//mvvzeFZSxEKQK/bHaCBpSD11xZkm2KrTX9CpvConM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687426; c=relaxed/simple;
	bh=0KtoHv+kkk9F3XbjTpMLTijc+MmW70A0nMOOCxqIce4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NIHg0YghqR9zyNxlyLJcKf2u2FQdIzBuq2tFZvJmEAqHtRqnrTN+DOc4VZgVK2WCyV/uUkDIXuofKEsFcAgfVYXs2ZQl4X76PKmeVKibi5jPsu/xXjO5HXA8rI9ry1o9ujM1ztgvL3hFv4HpS3N/Xd3+E1Np1zRSdS7wNLd2Pjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyT7yAA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyT7yAA2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98492C43390;
	Wed,  6 Mar 2024 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709687425;
	bh=0KtoHv+kkk9F3XbjTpMLTijc+MmW70A0nMOOCxqIce4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hyT7yAA2Xc8YklfQPATzHwGKbsjUThCcX5FGEU+E6t5fmOUuQDXQnjOZN5WIetUZn
	 1tgi9WvdodsHiCYkYXXUteKab3fa9ZaMZwUvuYmsk6LZkJ6W5npNImhduXhc1h1dQX
	 hqSlrevaCC9buVdEgCPDWLEdDiH61A/DHRHvl0W1zIX3hSQKW6y2l0JIhwDLjaZJeX
	 THNVdE3h5udGYOZvreN1z/f+RPQ63sdf+eg+Ot98HFPUb8Et4i9z0JcCnApgSrkGKI
	 hZF6WhaDC9eA6mzffCwQxXGwjyRg3tZhPrrCDLhRyljevDZVIAimPVBG67Y7yjYK0j
	 F/7c/lODksx4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A60CC04D3F;
	Wed,  6 Mar 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] cpumap: Zero-initialise xdp_rxq_info struct before
 running XDP program
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170968742549.25766.9821841549274494051.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 01:10:25 +0000
References: <20240305213132.11955-1-toke@redhat.com>
In-Reply-To: <20240305213132.11955-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@ci.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, lorenzo@kernel.org, tobias@aibor.de,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  5 Mar 2024 22:31:32 +0100 you wrote:
> When running an XDP program that is attached to a cpumap entry, we don't
> initialise the xdp_rxq_info data structure being used in the xdp_buff
> that backs the XDP program invocation. Tobias noticed that this leads to
> random values being returned as the xdp_md->rx_queue_index value for XDP
> programs running in a cpumap.
> 
> This means we're basically returning the contents of the uninitialised
> memory, which is bad. Fix this by zero-initialising the rxq data
> structure before running the XDP program.
> 
> [...]

Here is the summary with links:
  - [bpf] cpumap: Zero-initialise xdp_rxq_info struct before running XDP program
    https://git.kernel.org/bpf/bpf/c/2487007aa3b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


