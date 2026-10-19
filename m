Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C21A5B9E
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792380007; cv=none; b=WirBMJai9/xwgzyGq+91EqopZDnMU9TAUmVeS+QwkfYPXbS/vqeZKy7efHmnAwxBHDMA97U+4PC6KHT5h2I7cJ8zer4opXMxi8WO3q2eID6UbFpxzRXWHsRBkAV8HsidPvHUQvQ5oLqUza7SHuPPh+Suax4adT0AKgwrX5N0yIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792380007; c=relaxed/simple;
	bh=IFVfxjQxKtprexMLryFM4c5uw9/z+FyriwaFY1t1FNE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cRTnJE8St4eIt4OuYhk7IkfXixEhQJNQ8505zKtgqn/1J6zYJMH633vntAAm0hoXx0F+G5NL4RT4uGk66NXP7G5gP6HHKmo0yLVZT0ZEB5E829t4MlW+bjMdIU2NIC1DPPYnt92mPEDCRacAGnFlCqmf1qQFhgn3ONPQGvKnNyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTg3IXNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTg3IXNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBFB1F000C4;
	Mon, 19 Oct 2026 03:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792380006;
	bh=4hNbSkfwTjE76ERCizLwz+fwXI+YvoxUtm5aJzkFdjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XTg3IXNdCwLNfw7IHw3DCYdnTBgYFeQ3lRoPmbNYtY9obQ/MIqKSOMaVTGXV9p1Vj
	 Tregd06J1e5u8BAc1zHsftmbYafhrIyTnQyJCP+s5o0z+gsrAkTs8Q7pwsVk3wKwOL
	 gYxg+cdPFJTreW2lSDzJhBA2QMddX4PhZNV7TXTPMATBZ4EjJRECvrsFrhaquF46HM
	 tPJrtQ6tj0OuEWI4OXr5mITLwCSo/evc0yuxDnfZVUXns6ws5XP/80kEfEGh0jZ9Kl
	 paSvweR4mRy3zGLlIULmT409TIPl6uytqxwcMflcUXuYr8SL6zjTlXNDbtj9SdWAZN
	 iGiZvwjYL5RRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7735338119C5;
	Mon, 19 Oct 2026 03:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Refuse the prologue for an extension if
 callers keep packet pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179238000530.2381645.9304275221355856446.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 03:20:05 +0000
References: <20261019011328.1843764-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261019011328.1843764-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 19 Oct 2026 01:13:27 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> An extension that writes to the packet of a tc, lwt_xmit or sk_skb program
> starts with bpf_unclone_prologue().  If the skb is cloned, that gives it
> a new head.
> 
> It does not count as changing packet data.  changes_pkt_data goes by the
> helpers and kfuncs that a program calls, and whether it gets a prologue
> is known only after it has been compared with its target.  So the extension
> can replace a global function that leaves the packet alone, and the callers
> of that function keep their packet pointers across the call.  These point
> into the old head, which is left to the other clone.  Once that is freed,
> by the reader of a packet socket for example:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Refuse the prologue for an extension if callers keep packet pointers
    https://git.kernel.org/bpf/bpf-next/c/4f842631f178

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


