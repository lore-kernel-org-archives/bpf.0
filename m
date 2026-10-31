Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793481606;
	b=nfYlBIkYALNSz7+yXxVLRgXJKR6OjzBCPVvYrw9FQcZ3/dVCvoyP3jTqVLGVYMq9RYFi
	 BS4pJ2Pe6SkDTtDnebCtrV8wPT6T2Pwkt2zgAqusUB6kF4tMcdngvdn04LZ+SQVU7gMmv
	 bBGEZbgJI0hf7mc4KeVVpbwaJ1PbVjNfY9oitoLIq0bKkzkg1XBKsY5bnwKQ0Xu6JKtEU
	 7EXk/MC1RpcFKurehs5VmDLxM5cnt9IXrttRW6w1a1Ni5cAElcbOMiYP8ToUZ/jamtG+H
	 4sr2TBnkhDaKBpVZMf5DXuSaOuEaAgWlkechmmzN0Y89m7uPMwCNb9r9tGU5C0TpYtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2ckMhSoD3eHz4/9Vj5UCtcG0oh+evdbg5VipzP4zvAY=;
	b=SwgVFlJmf08fD5/ShR75/qyUlmD//TjF6/gPVR12C5FCrm+iZZYSVYDR8I36vsRcJWe7
	 ZC6OTrsEEXidd5hGJVVMVaLoVVEOX3LwGNwn9pG7ZUKtuBAqHXGhWq87rIHh7aSTdVBOZ
	 G/wqKqgjLwC7DT/QmCpMdvcFiTIQG8FPmpI15RozhfGdG4/s0M2XtNpYgAicWTWOAmOry
	 b5+Gg2oTqK7JBVGmIPIOkBzO7spNfMdzbDXbcOvqPr8N//CIaqPe32AMN7w0CruhZpkWg
	 pIdikvkd7XRvACHMZ8A0G3RZHKkL+iLnl+wTwr0eKWAXIACSaLUGqf9MHs6EA9Il81A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMJZNRcy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08968606A31D;
	Sat, 31 Oct 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RMJZNRcy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898721F000C1;
	Sat, 31 Oct 2026 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793481605;
	bh=2ckMhSoD3eHz4/9Vj5UCtcG0oh+evdbg5VipzP4zvAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RMJZNRcygvbKARk0etuVAm3V3BDiIX2aPgLyYnIUfyd3APdVJx1hk2740e70wNspx
	 DqMfIJtWnX6pkfmiyxh76EqYBF5ZcXBN9PpcYuyoEPu6DGOm1bQlmkSYeurdhwsx0w
	 B/qf/kIoRCUs8/HYs21Pi0PENjWjll0uFeN+n9PHd9LWCxcgTgY1QvsWuoRUDD2Tfs
	 DFXf/IbtRRxpaA7qcsNg4HVO41aarokCVbxzQcD8qhLK7Qds7MmuCboNM4qiOwUPPE
	 LTsZoxfOOrQn6+OLJXtvjYnMvwtWL5SXr2OXYCvQJj+SEQ0uLUvRLfOo4/UFfj+y9e
	 b5NWgLCQNYO6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2C53809A3C;
	Sat, 31 Oct 2026 21:20:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/2] Fix psock update-side data races on
 sk->sk_prot and progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179348160430.2237852.4848010976171902619.git-patchwork-notify@kernel.org>
Date: Sat, 31 Oct 2026 21:20:04 +0000
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, edumazet@kernel.org,
 kuniyu@google.com, pabeni@redhat.com, willemb@google.com,
 john.fastabend@gmail.com, jiayuan.chen@linux.dev, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 30 Oct 2026 13:01:52 +0100 you wrote:
> Follow up to the thread at [1]. See individual patches for details.
> 
> [1] https://lore.kernel.org/bpf/20261022054811.35008-1-phx0fer@gmail.com/
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> Jakub Sitnicki (2):
>       selftests/bpf: Cover concurrent sockmap update and delete
>       bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: Cover concurrent sockmap update and delete
    (no matching commit)
  - [bpf-next,2/2] bpf, sockmap: Fix psock update-side data races on sk->sk_prot and progs
    https://git.kernel.org/bpf/bpf/c/bcd07fd1673b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


