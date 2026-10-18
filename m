Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE91B4F0A
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792284611; cv=none; b=RJVmMt5PG6fh8RqDrw9YBrXUNgodgE+/I+xy8Di8oVY7OoPHb5hJaUbBQbuXnHJ4f3/G9L7VxZvY76bohDzEYyTnAIDl/92SG6cPilCWrROCtzVUXgglyYrzqIY8dmX/L3t/E6xPRmEKQ2arftuTZt6nFoctVttG12pozkMwfE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792284611; c=relaxed/simple;
	bh=Ht4uaiChaaYbTjhPXq5xebMeZYENXGXd7FBnZkM9g40=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Sukd/ASNX335D4eIaT5vSFkDypx6EyfyMLK6Rke6Q5tx+L3dk/sUK3U5Lv+xZ/FNGS8xyJQxju1d/Jac4BL6KVvciDw2ZU+tPUzpgR6LdyHmrp5unehMj6Xq9gCPeZajE60NnbUFWA7q5jypbDdjCOiK85qzamBrRQuuXMxFdJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU7FbR1s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU7FbR1s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F37B1F000C4;
	Sun, 18 Oct 2026 00:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792284610;
	bh=0g9AuSft/FTp3Fo3xDSRwDQuRfaH6mIe08prceQ38IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FU7FbR1sQtW93s9RWSHMh3WYiblSAL3Wf1PJvPFutJXOmcFdeVqFVVvQeEzV8Pshc
	 Z8y3MQtuGVjn1B3yiESMCbEkKkqKI++fX+NFqoomDTNKwvH1L/C4WQGk4slF1yag/1
	 g9cLWgmKszAc7jYah2AKGVEi9DpmqG7A24fkPwSmeCJZInzmMOsjyFEtT8Een9bgJv
	 ipBGRzPFL7YbCDsat8TVZLeuf5Ddk6Lc0N+S/tU21Rv+smtrDWn/SJTOvDUxxGh1JH
	 fm3FmH8f0xFYv1d+RgaxWCKrIoPcELkfwHbcdGUYTuutEiZWkVDEFxj39CyXnX3kA9
	 Td+2IDknz4AYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7798F380CECF;
	Sun, 18 Oct 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 00/16] bpf: Memory safety,
 lifetime and locking fixes (followups)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179228460928.1496838.4730449210164481287.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 00:50:09 +0000
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, josef@toxicpanda.com, mason@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 17 Oct 2026 23:09:34 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> The first 30 patches of v2 are applied. This is the rest of the series,
> with what the reviews of v2 have found, and two fixes on top of patches
> that are applied already. Most of the patches are from Josef.
> 
> Every bug was reproduced in a VM on top of bpf-next, on the kernel right
> before and right after the patch that fixes it. The splats are in the
> commit logs. That goes for what the reviews have found as well.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,01/16] bpf: Don't take a program with a target program for an iterator
    https://git.kernel.org/bpf/bpf-next/c/b83bacf2161d
  - [bpf-next,v3,02/16] bpf: Don't let an extension reach further into the context than its target
    https://git.kernel.org/bpf/bpf-next/c/fcbfa99aa657
  - [bpf-next,v3,03/16] bpf: Keep values of a dead owner for sleepable programs
    https://git.kernel.org/bpf/bpf-next/c/f693030a187b
  - [bpf-next,v3,04/16] bpf: Don't take an extension for a function that runs sleepable
    https://git.kernel.org/bpf/bpf-next/c/b6458abbafe4
  - [bpf-next,v3,05/16] bpf: Keep the symbols of a program until it has ended
    https://git.kernel.org/bpf/bpf-next/c/4eaf4d71b91a
  - [bpf-next,v3,06/16] bpf: Use the socket of a sk_lookup test run under RCU
    https://git.kernel.org/bpf/bpf-next/c/6aff0129f327
  - [bpf-next,v3,07/16] bpf, cpumap: Hold the device of frames in the queue
    https://git.kernel.org/bpf/bpf-next/c/f99351272933
  - [bpf-next,v3,08/16] bpf: Drop packet pointers behind kfuncs writing an skb
    https://git.kernel.org/bpf/bpf-next/c/19e6ca6b4a22
  - [bpf-next,v3,09/16] bpf: Let bpf_dynptr_write() mark a global function
    https://git.kernel.org/bpf/bpf-next/c/589998616e0f
  - [bpf-next,v3,10/16] bpf: Don't take a dynptr argument for a local dynptr
    https://git.kernel.org/bpf/bpf-next/c/b7f97db88948
  - [bpf-next,v3,11/16] bpf: Refuse the prologue for an extension that cannot take it
    https://git.kernel.org/bpf/bpf-next/c/aa486cff4964
  - [bpf-next,v3,12/16] bpf: Unclone the skb for kfuncs that write through a dynptr
    https://git.kernel.org/bpf/bpf-next/c/bb72c2866831
  - [bpf-next,v3,13/16] bpf: Follow the head if an skb is written from a slice
    https://git.kernel.org/bpf/bpf-next/c/1c19f2b3b2f3
  - [bpf-next,v3,14/16] bpf: Use memmove() to store bytes in an skb
    https://git.kernel.org/bpf/bpf-next/c/1db084f42884
  - [bpf-next,v3,15/16] bpf: Use memmove() to store bytes in an xdp_buff
    https://git.kernel.org/bpf/bpf-next/c/ab08863c58b1
  - [bpf-next,v3,16/16] bpf: Refuse packet slices for packet-changing helpers
    https://git.kernel.org/bpf/bpf-next/c/a6f8a67c13dd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


