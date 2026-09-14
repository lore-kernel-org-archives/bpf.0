Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40EC37B3FE;
	Mon, 14 Sep 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789362074; cv=none; b=JeDEjENCtpr5Kjh/Oe1Hjw6g0LNTWnxSkTB13BidkM7NkvV6QISMITY1zrjZ/dEICpACCkwvDTgkRkNwC8IDStUkytP07+DtdnKf1sPepfer3pQrVmgC+W3tJEqwdCG35m4J57zhuAnNR9+biP6Olqwff3AcBlYvbOVvc1/L/j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789362074; c=relaxed/simple;
	bh=ewZIE3ef2XnRz9+1nhTss0M1bLQ1L4PxJBQ+vmRBxE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kMoZ8q7jX+UMyfNXfGweuZiGJv1Hg5XD9G2X3Q0dr0lxPY+XH/0sHCPt6r5B/KNkyyrHrBcjGvDjdGPnIvAJKiEeysbw0TN2E6VJG4VeNavqkokVxFvaRUvyu0FFjTWSeATqkfUEek1dLyDXDl05U9zOpUAVfcIbCPXPZWizfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlToqecI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlToqecI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE92B1F000FF;
	Mon, 14 Sep 2026 05:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789362072;
	bh=ub9JoCNGO52ku7WWQ5b06moZ+72/o9Aisxb6nxgD9y8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UlToqecITGtto3XNZvWgs8wBYFTVAQgRhojo2B1KI57agIMJMchuFdvfvSnbzrVSB
	 vlVyKVGdt2RvaznUMbx+svn+u7d2djLQJE+X/tTH+T4PWxmSxHoVmcLGYcNZE1Cz6F
	 6EK1wznP13NZT8G8ph6qOJ3FNJzsrFhB5ZMKLsd1PC32ORz1qEiOpmN3HQgDNaqqOY
	 Pr9m6fOfFl+piSyQb4CJwkJZU6Xszq2unDuQ5jrqaYiztcHXyrJgA6xW/9iAwu4VqA
	 9ef50co/9vB0rghp6tCCHz7R4dKEX0oeAzLzfEk95CQJkT7Dr5OQYx9r2KkCBzyb6F
	 pP8ulNPORbrPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568F6380AA63;
	Mon, 14 Sep 2026 05:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] bpf,
 sockmap: Fix self-redirect copied_seq double-counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936200789.325205.10800114319681909179.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 05:00:07 +0000
References: 
 <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
In-Reply-To: 
 <1a8e797a1b26e2f695aaac22ac644c2862f63466.1788858299.git.tanggeliang@kylinos.cn>
To: Geliang Tang <geliang@kernel.org>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, daniel@iogearbox.net, tanggeliang@kylinos.cn,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  8 Sep 2026 17:08:32 +0800 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> When a BPF stream_verdict program redirects an skb back to the same
> socket (self-redirect with BPF_F_INGRESS), sk_psock_verdict_apply()
> calls tcp_eat_skb() which advances tcp_sk->copied_seq. However, the
> skb is then delivered to the socket's psock ingress queue and later
> read by tcp_bpf_recvmsg_parser(), which also advances copied_seq via
> the copied_from_self accounting path. This double-counting causes
> copied_seq to advance by 2x the actual data length, triggering:
> 
> [...]

Here is the summary with links:
  - [bpf,v3] bpf, sockmap: Fix self-redirect copied_seq double-counting
    https://git.kernel.org/bpf/bpf/c/490a83d6386e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


