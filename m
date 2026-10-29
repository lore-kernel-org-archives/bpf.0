Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290206;
	b=cNmJOeDRWx0GwEITKGPPcc492zLf0LPH1r39deB64zNZhHJ5OmVXEU8IPsWzKPLfxtzr
	 sBSc0OajBOF4RZsCRAjMfT9eBGWqTbi8ZKAPQfw5nOewE4tgv5txuOpGv3iKcWSIeznPn
	 sOvyFgz/rW+15Qr0A8ujJc8H+9prtgWbpvL7wxWt0xSUpoozYJkhOPLwHYcUsC3sAlS0P
	 Jb4IdmANzdxIFUdgWZic7IenGawdvLUP4VX/ZJRtM3H1xq0BrtxAQ1UsXjO65ntPq9btp
	 7U5w6Y7jf7isYWrwUENO+tHC3Qz9vsgA+qzSV57gQR6EdsiT49EQPZZnJgLU7gSR76g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OO3D/egt4NZpkeHdJY9JsnhLRjGf8qdoldSc+pg7Aw4=;
	b=y8c4q17rFevzQOvtmV/B0P5CGa8HRmvnXqmKvYgIF/u00iFTbPUTlpN7ZiBR7lvlUOlX
	 9RirmDQpmss9bRs22AXuZuSu+lz3kpePvvTq57OcNYGopPFhRliuAhg1eCiwccEQaUCO2
	 UmZ9XanH55oTvIYjKMIeDzz9V2c/KdXyxEVBTu+dxEQPiSnK8K0I0RZCuSpKfYJkg0QOu
	 yBLqVUH2/egEUdlQglZ2jnoN7z1oAOBpJ3plUMeY/MWG34bx3PwPsjTfgIFG4NMudQ4L0
	 cE4GsRfGP18YnaZ40tJ7BdOeExyBjv4jeW9hPV1hORq/m00lG7eZlwFwTAwbikoONZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/FlXWwH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B57606A321;
	Thu, 29 Oct 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/FlXWwH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889341F01816;
	Thu, 29 Oct 2026 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290205;
	bh=OO3D/egt4NZpkeHdJY9JsnhLRjGf8qdoldSc+pg7Aw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R/FlXWwHYlS2DpAW+Isaulr1kkFAKrTElb3TCOI7SWaONY65Rhl5M0rIxPjWAGWoK
	 Q5nYBS2Mcx13cAS4LGPjyqF5ltzMLVfKGYZZ9oqkFRE9e83oC32kLGSZWCRwJrOduh
	 7fFbx0ZH4LaGCSsZ7pRvyNPUDrITR8gu3Ehv6vHwEbu41/J/PPR4pnt9NiK5FM6J8o
	 rWwN2zG1hG3r5ax4FqhrBFF6o08Cgk8YgZIOwXTPwaaxE8WM0Aj4k5OWSU8uOm4PFC
	 CIXKh5MCpQR+LAlumA7793PjKpdKHCkF9Ew/4GbP7mlrdESWoeL/yQHag9k6D8T3Ts
	 /GbJrFn8bLTTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D3EC3808221;
	Thu, 29 Oct 2026 16:10:05 +0000 (UTC)
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
Subject: Re: [PATCH bpf] libbpf: Reject excessive program counts in generated
 loaders
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329020430.546068.5250176039827130736.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:10:04 +0000
References: <20261028183947.9606-1-mahe.tardy@gmail.com>
In-Reply-To: <20261028183947.9606-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Oct 2026 18:39:47 +0000 you wrote:
> An object containing MAX_USED_PROGS+1 (33) programs successfully
> produces a light skeleton that laters fails at load time with -EACCES
> because saving the 33rd FD emits a store at r10 + 0:
> 
> 	*(u32 *)(r10 +0) = r7
> 	invalid write to stack R10 off=0 size=4
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: Reject excessive program counts in generated loaders
    https://git.kernel.org/bpf/bpf-next/c/aac5ba0a4d52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


