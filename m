Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491009;
	b=4YABMKXb/TvGnp2P91MFku2czO96JZOIX/JdW+N0f/YjlRqzj9dNJCarVzakHZCgkL14
	 dXawkE1AujrjcfzO9ezziauI+YoLaDOsqvI/5vRbzs9AGVEvJDdPJiBf08thEIdJ/FIA2
	 YIL2AevLqMXJ1G3JIvZMCHAc/BlaEs+kCQCQer+U1k63oE0R7BqdcOm3ZItPHFkJhNtgC
	 SmSIt6H5mzuzUPgJIJZc9jgS2HMmNstsTWi5GZVP9LIjL8LTQ9Ha61lRYzSIwD/lj3N/p
	 8/zMjBTKd8CkZsuepkL4k2OROP4Shcq2kc//fe0sFfjV/7+L6abJPnfxsAifwjkDp5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491009;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ppeMvnM7iphv0dyG+8k2gMRO8bZqWsT19t+Kx9LEsyM=;
	b=FPBkw4HylRPBXxjku4JSThVrL5p8POw4iRUFbe+58ouWWNLB7uPe1OTHkLPHRVXNwRcx
	 RfUt/2oadmx1awfT2/ThoIwy00Xz8vTeB4MiFBB+j0FhICf/3yheQD7ugaSQRjwkQ1d5A
	 hKsRz/nEczLDLN32aDkptVIH43tep5v00Yq80g2pJiAVfnehFo/ZN9lcxloUrtuCcirRW
	 v1cNxkUqY/Y9PTfZ2d9uY+hNhGQTprvuqs1ZpXZK3Uer88bzVK+xqBiGNITXFVkryTU8e
	 k8KLOS5SK1PZ7ecZehrXw7fk7W6JsOauJF/tFJglaohsPripTjC/fViAW2iSl1jYrPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzqNROVQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5B606A322;
	Tue, 24 Nov 2026 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KzqNROVQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441D41F000E0;
	Tue, 24 Nov 2026 03:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795491009;
	bh=ppeMvnM7iphv0dyG+8k2gMRO8bZqWsT19t+Kx9LEsyM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KzqNROVQhEf5pGyYP/EuST3zXDSFPq125OosIMKUZSgHI9BJJ/O5Yx8E+qway6VfQ
	 be+o4KsoHQjcY6kp/nTTpajzrWeWMtOfKy9acY7Nv3vgbJycw5DwJCqC4oBkQrTovB
	 0gbEnw28Y71yPZTFh+y1/YJbrl0tnZmQC4ibQDtOUfHdqTwVqol4yxhEyx2km0PVAL
	 kV3a4tcC/F70UuvAeiBLLjsYLnN8yzdb5eeX7pqD2Ilc1PJWu874H8ikpZK4msJs1+
	 Z5QuVHmIMbcVj3+FFLfocaPjlXGE0n4NfpqD65u0cBZgMDVyr/ZrwDoJK4HX9QP7Sx
	 L2JqUaeTMs2YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2AA39302D7;
	Tue, 24 Nov 2026 03:30:09 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/2] Documentation/bpf: Fix stale references
 in
 map docs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179549100776.3259463.7305380478503758837.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 03:30:07 +0000
References: <20261123155200.16676-1-supersonix03@gmail.com>
In-Reply-To: <20261123155200.16676-1-supersonix03@gmail.com>
To: Ahmad Wicaksono <supersonix03@gmail.com>
Cc: bpf@vger.kernel.org, jakub@cloudflare.com, mhal@rbox.co, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 23 Nov 2026 22:51:58 +0700 you wrote:
> Two documentation fixes for the BPF map pages.
> 
> Patch 1 records which program types may still mutate a sockmap or
> sockhash: tracing programs attached to the sockmap iterator, sock_ops
> (delete only), sk_reuseport and sk_lookup. Anything else is rejected
> with "cannot update sockmap in this context". The kernel-side sections
> of map_sockmap.rst did not mention this. It also drops the reference to
> progs/test_sockmap_update.c, removed by
> commit 5de7a6eaed89 ("selftests/bpf: Drop
> tc/xdp/flow_dissector/socket_filter sockmap mutation tests").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] Documentation/bpf: Update sockmap docs for mutation restrictions
    https://git.kernel.org/bpf/bpf-next/c/7cc87577394a
  - [bpf-next,v2,2/2] Documentation/bpf: Fix stale selftests file references
    https://git.kernel.org/bpf/bpf-next/c/2d602d0e4296

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


