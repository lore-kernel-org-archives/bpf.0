Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792455616;
	b=taBuoG0BPj/cM3daaqHpWX9XNw1FcEVKMMeJrJT2+tfBJt4md8IiybL6iqi/aofAui6D
	 TTgMY4omO1reagX4hjKdsvD+WAaokzmI9IIqy0h9qW0/r67C3R77sj1B7jZoT5zP7EVsi
	 HGgBfBKTUW3LiDK61YSOVTNCX1yiwnLxmDrPq0WVVsYNwsaeTN0w4CO61DiGfo5G7tcGO
	 hilsYoCREejDrH1/wnqQnjkthKQISDM/yFeoyUKd7HAcer3kxnM+UD8D8hmikpNC3kyyH
	 UDnUwYvYFyoy+FheKtVyy9wKlJZRX5ZdJ0dAS2M7mFeoB2AJ1ewq8ixgAm9jv+wR6eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792455616;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kJoXi2idtZUnH8BVwgNnHF4TuxgDGOx3OfLfSSnPtWI=;
	b=nr6WcfIYS5/P9wtCretz2xl98eV3aUICpUO7Z0cj73F+Uy2beQ01n8DzMczNgKeC73w8
	 8sICXWyM1wT6dGKRC7eTOVZymGDxGC3vngxGy80MfswvQnnxqYyFPif7PJoYJo8CczI3w
	 fRSpiRppp40ndcwmrv0aqr+XLQKar73Ci95Y9+lI9F9894kNdmKWQrgTnQGo7omKUCnyO
	 b6WGkLcb8YBMxRF4PGWOIxV/US4FAyxbOivBAsmYZNQGMDTKqbLl7WF/xqy2Ib4W1UWvT
	 DkcR5OuBoOjqxf4n87X6/q/p/dWAKfCLGFYfSfGcykkoqin9xy4bOcsSGOqQZM7jZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzFmSJmf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F60606A329
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 00:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AzFmSJmf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1CD1F000C5;
	Tue, 20 Oct 2026 00:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792455615;
	bh=kJoXi2idtZUnH8BVwgNnHF4TuxgDGOx3OfLfSSnPtWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AzFmSJmfQzvWx9Y/emyvxX3XWnHaMK08dGJFHf2ZtOai+abMI076JFe4ucaTXMaW6
	 Vm46azJREesdl7jRQVr5mqpjNqtygz/Bgmt/CLE1pvoYJZT+7e0YGhDARPHXoxcBow
	 FQA7LwWNUCBay862Da+uZCZUmiDRB2t1xiTZt7o7y7kx0M/vic12p3IZPZ02VRzALb
	 lMgn+E9JfftOW+ZAXDaaAOvhu9NngiKLtQo31LH/WKAhF/1aHN8s1/nIaEX4KHFpgf
	 mH7tggEfTrwrHj5DHIbcm4gyTyhT002C9hFIqHAGsyPHlLb1D31qXQexy8Q7vX33za
	 MidvEAx5pFE+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B43BA3924A6F;
	Tue, 20 Oct 2026 00:20:15 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v6 0/3] bpf: Fix arena memory incoherence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179245561427.3398635.10831719970762270833.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 00:20:14 +0000
References: <20261019201108.4552-1-emil@etsalapatis.com>
In-Reply-To: <20261019201108.4552-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, daniel@iogearbox.net, puranjay@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 19 Oct 2026 20:11:05 +0000 you wrote:
> Arena memory is tracked in two places: the range tree, which records
> which addresses are allocated, and the kernel and user page tables. The
> two are updated under different locks, and that leaves two races:
> 
> - Since b8467290edab ("bpf: arena: make arena kfuncs any context safe"),
>   a free releases its range before the kernel TLB flush and the user zap
>   complete. A concurrent allocation can then write through stale
>   translations into pages that are about to be freed.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/3] bpf: Revalidate faulted arena pages before installing user mappings
    https://git.kernel.org/bpf/bpf-next/c/05bee0638bac
  - [bpf-next,v6,2/3] bpf: Fix arena race between page free and alloc leading to incoherency
    https://git.kernel.org/bpf/bpf-next/c/7244a2e58d21
  - [bpf-next,v6,3/3] selftests/bpf: Add arena allocation race tests
    https://git.kernel.org/bpf/bpf-next/c/6c372031078c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


