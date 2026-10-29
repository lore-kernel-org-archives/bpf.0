Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284808;
	b=LxTjXKpvDyzaP2E5ZJRD5D7o3U2VpN1mfh8OKFKkQzEmXBgkSpQZ3xPCqerc7qzKXdiA
	 DTQIh3gsvObjxG6lI1DbtqZokAX+FPBxjer9ZuHTjQP+01ce2P7nYF4zVyQicSpTO2m+i
	 +AqB2Z8H0vO4o4SKfjy/AY/MjHFb4kKw50dQMQIGpRKaGTsZ3J0Y3L0m4xpBuro7h/OTp
	 qZ6VB7MvsTFqAeZBXoQhgcbZG6NokGpinVxRMSBOB4ORitk64brfQQ6tvG7HMK/zflhV+
	 3LR/yQcnlJUHgVqgt3qMBG/5mp2m4xhH0cOaWEvVpz+41wbTrbtWFXuWSuwqrjYTrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3CRl88bTJmQgduOvxN9CZbKqQ7aP6JRqMXHjPcTRYYk=;
	b=xsdmk15Ep7wY0Knzb6bGFiPlMtQBWtaBN25i9sG21D4/gKTFmNEN4d16hY96gKvGUhXf
	 Vnf24BcK3A6kW0t89BgVzRM+XHzfRNPDFR6RrvhnbJl8VpcAgM+ZfbrUl3/L+4U2ELT9L
	 g856KTZnIZui0Dw6QBLb+1sfHKYmVYkA9Em2mDyBU3U2zQBgma/QfCdHwg4suoFlvKyKD
	 YmGoeTCaYRmzLkM/DU/6utBwdbEGCtccBsQL16gBg+xH4EoCV4oCv3aEKG5D6zeq7uYVA
	 xOSbuk2OtKWOXssfxfJS9Q4lp1+SB+mhoZ1zsMOVtQPjlXdjH4rwDhmQ7FQz0E4JJwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRdnlKnc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0C606A320;
	Thu, 29 Oct 2026 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRdnlKnc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C421F01825;
	Thu, 29 Oct 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793284807;
	bh=3CRl88bTJmQgduOvxN9CZbKqQ7aP6JRqMXHjPcTRYYk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JRdnlKncV9NpTh2juO7SyPref4piGIyC6fnqrXlAwFuOI8nOCfT/86Rh0XJj6QF5S
	 RHSnhrp+uP1j/ps9f4ALLxBGWGejlRQCWk2s4uZqyqYGlSRqRYUvKCQ5gCj2/ix0Ut
	 aM2xJFFU7aoWACd1scD5h6EH5QjS0Kj4QoHtDW6En/Kg17xNp/AX7swL3uWTYzFPl6
	 RrXk0S8rXHJ0M9YQ5pFxKwYW5E14Zgp7tlx1IQmAkabTOE6KjqaU3G09aQ79IidyaK
	 k+ZnWII++2rIOb0SB2C9DEbM5GDz2u+tjEnlIzj0l8Vt6BcZNBjEiLyn4KIO5OxwAD
	 GDmOcFNVkBuGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1BF380821F;
	Thu, 29 Oct 2026 14:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net v2 1/1] tcp: check congestion control restriction
 first
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179328480605.499212.7041046412594690100.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 14:40:06 +0000
References: 
 <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
In-Reply-To: 
 <71c142b2d45af6a2fe7fc6cd4a5ca52c53afbe23.1793075984.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: edumazet@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
 pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com,
 vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 27 Oct 2026 12:46:49 +0800 you wrote:
> tcp_set_default_congestion_control() takes a reference to an algorithm
> before checking whether a non-init network namespace may select it. A
> rejected request returns -EPERM without dropping the reference.
> 
> This affects module-backed algorithms too; BPF is not required. For
> example, after root loads tcp_bbr, a user with CAP_NET_ADMIN in a
> non-init network namespace can repeatedly request it as the default
> although it is not in tcp_allowed_congestion_control. Each rejected
> write leaks a module reference. Since module->refcnt is an atomic_t,
> 2^31 such writes can make it negative; later module_put() calls warn,
> and rmmod can hit the BUG_ON() in try_release_module_ref().
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] tcp: check congestion control restriction first
    https://git.kernel.org/netdev/net/c/dda51b737216

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


