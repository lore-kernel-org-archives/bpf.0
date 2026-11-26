Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726206;
	b=trZRscUBr5emEr1UHAKFsnN0q8BjYIlp6ZT3hFNkSqq7sXcoliMMNwHa0IBX0vPab2H5
	 QXGxZ7X8i7mNCbdnpcicRk+W94Yose5nm/CZB1GFxwYMscY5IbDKKpmVBwUwbQRVpCpZB
	 5PBXVGye7O360e6RByYieJ9iDAgVX/kq5pFkUpsBeCqLkD8KrYt5SoV2lcAvTFiyd0o8r
	 jnGg4oLJgTrlww/LZpp3ovvO3z8fN8/yQfG94kHA+Es69OxxjTuND7Ejn3TVJzVxrpAay
	 bZaU075Zm5G9VVSaq6laaOWi1xp/b1qw+wI8NBMjAsydz9EgBdE90CLMxwkZPksiQIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=qxIKxJeSr/ezkKmeWXoCQPXbtP04fBvfKWJ1qcMY4HI=;
	b=RzzVrW3wdEUG5YFMlVCDvXjJehEc9wXlGWvW9I+JIztarFAH8Nf6BqPUbzvYaKnD7CYG
	 u2JGudqUA/NMkvaC+QqZU4nA2d8srN5yS71EqAEOt+EjybmnXpTOBnEV27YCLNWah24o1
	 FcT7fdqh5tARWuQ3s5yqwAXn4c6sL45ncXcyVP4jiLmZg0FcPAYzUyvMzpGkLg0b319VA
	 rplIO4tD4RjfTkaAFx7T64foXTntKNKORGBXkXvp0y0JuHgC91l/+2jyM3tbd5ougeVmR
	 dJRjz2L3loY0/cX54+E+RBZiqrcL2nDU6jlGtFRUPrNmkiH8PjclcmU1DnSEddaEbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odcHQASm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74C606A31C;
	Thu, 26 Nov 2026 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odcHQASm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4981F000C1;
	Thu, 26 Nov 2026 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795726206;
	bh=qxIKxJeSr/ezkKmeWXoCQPXbtP04fBvfKWJ1qcMY4HI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=odcHQASmlzVrLm6YR58ye8QzP3H2P3No9360GgEY2hsW238Mpa66511PrXD+ZWAzj
	 6zuB/pWbcgEO3+4N0oK64MkkbQ5HeoWUajLkhUewD2F5q5iSumH4Oq+wSc6btgeZ6D
	 k7huTygBm4HqKA137tGELQMtS9lWyX0UibVXaV0mN/n+Y/2srNMtpktbmg8syQzQDo
	 HeHrbdDH0yoREDsgzfDEuwTpdFhngfqMsXBtoyhGUypwf8k38PAeQaak0jbgCu5ptf
	 Fa1laBf4QFV+JEYLJaI5NSJx371YwksuWEHl6OvFedFZdYTfLv/y3fnJ7NFHWqwQeS
	 gNIpNG0GeAKTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 348BE3803326;
	Thu, 26 Nov 2026 20:50:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf] bpf,
 sockmap: Clear the redirect target after the stream parser runs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572620493.612301.18286329775788575434.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 20:50:04 +0000
References: <20261126101950.1682160-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20261126101950.1682160-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, john.fastabend@gmail.com,
 jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, cwang@multikernel.io

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 10:19:41 +0000 you wrote:
> A stream parser can call bpf_sk_redirect_{map,hash}(), which store the
> target socket in skb->_sk_redir. sk_psock_strp_parse() never clears it,
> and it shares storage with skb->_skb_refdst, so skb_dst_drop() later
> passes the socket to dst_release():
> 
>   KASAN: null-ptr-deref in range [0x0000000000000128-0x000000000000012f]
>   RIP: 0010:percpu_counter_add_batch+0x24/0x220
>   Call Trace:
>    dst_release.part.0+0xc9/0x180
>    skb_release_head_state+0x1cc/0x2f0
>    sk_skb_reason_drop+0xbc/0x420
>    strp_done+0xcf/0x150
>    sk_psock_destroy+0x85e/0xb10
> 
> [...]

Here is the summary with links:
  - [bpf] bpf, sockmap: Clear the redirect target after the stream parser runs
    https://git.kernel.org/bpf/bpf/c/14f6b10422d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


