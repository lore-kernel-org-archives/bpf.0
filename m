Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792814412;
	b=WDyBCIIaHnb/f9DGjvjpEl4KPnP//yaHMu63uvaM5MvLxWpnHD8/XbHqsIpFnynUFcRH
	 xzKP6lsvvfGue/u51bfet9yHKNaG5enhqkoVpLGVIJuE/LBpPrhWEfZuf9EZTqpTBYBoW
	 TsIS8wkokaVk9KLy6a3Mj8xfE/yfg2yMMJFu7pHtjvX/mgUpDYYVuo9GBaqFrNKj8nK/T
	 OkWmwPnC9UoWN3R5+/lj0Q4LqiHLExo+BgOnsyDgm4/VhD1ia6MWcOQFniBmqwMkzbKQy
	 /G8SWxXep+eY4deZ1awAJ9dKHG10DmTYzWZdrAqV42EhDI8C3XP60nuxNlKtRR2jLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792814412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=es/YlM38wspgQTwCjjREb21vmNEDOk/aZYfVMA9sxiY=;
	b=MX29Yfvqvdw0IVAu7INO0A2V/3xdijsqoenoROqqsCbkKJqvFaLIRFlEOX3uZRUzEvXf
	 QoX+tSvoA/ZHAsQ7Z573C5t4Av5cOyWiU8Xw/X2LugkduN1Uz/2g3RjQWLE58caWt0QJj
	 TU7Tt9sc3KseBeI6Rp1dL+x9SjS7nfE7Uw+FQpNuySg/NWP8ZXDGLzEnIT4Rw7U9xVPx6
	 ZT632Rq/v6vo0TMK0PUz9RCGLPnbBxqZc/M9Kpcs/FlAu1WvGmfozMIOUPt3k609R3aau
	 J2fjnEIJlmYquzX7yV7UD5Uta3k6mjCdbMaFF9d9dYh2fL3cXHh5FUAeAxe4ik2adQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iu3NawHj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C6606A323
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iu3NawHj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106C41F01825;
	Sat, 24 Oct 2026 04:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792814412;
	bh=es/YlM38wspgQTwCjjREb21vmNEDOk/aZYfVMA9sxiY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iu3NawHj/D8GtIKB90BWsI6AKL8YF6P+MO1FzcvoiKeQy6FdmW8pGcEAeRhmpNZqH
	 tSd5wIojY+vk1UzJgIgHvIXpiG9zFuQyx031z5cH0xrsnfdKTkLavjXZBjrM8tZTPr
	 GxsjPrvtjaVaCvRhdLGeBNYve8MX52cU39nFQgBQk2Zh/U2cfMeHbnoPNWZk2cEIDw
	 HbOgR/bvrMkBKjs1VlSB9gKyfj6+5JD3oGq7mhHkRvuiSTGbw6DU1uL1f+EfNv9Xcj
	 UAMzkkZ3V6oHyrn+WwUEL0YbY7m6vPI5kVrCWK1Gm6FIlDiL1PcjLrUxZpC+Vqg7uf
	 M8I9+b9nyfMcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 07343391B17A;
	Sat, 24 Oct 2026 04:00:12 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next] bpf,
 x86: Use emit_rsb_call() to call bpf_unwind_target()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179281441063.1452471.14041672222960270908.git-patchwork-notify@kernel.org>
Date: Sat, 24 Oct 2026 04:00:10 +0000
References: <20261021220844.239400-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261021220844.239400-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, ast@kernel.org, nathan@kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 21 Oct 2026 22:08:44 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> clang inlines emit_unwind_ret_addr() and emit_patch() into do_jit() and
> folds 'bpf_unwind_target - X86_PATCH_SIZE' into one relocation. It points
> to a nop in the padding in front of the function, and objtool complains:
> 
>   vmlinux.o: warning: objtool: do_jit+0x1330: relocation to !ENDBR: .text+0xc7fab
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, x86: Use emit_rsb_call() to call bpf_unwind_target()
    https://git.kernel.org/bpf/bpf/c/02da62c2f896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


