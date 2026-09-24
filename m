Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428993F929B
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268078; cv=none; b=E/qN6pUtX3gSxqOjoiFaaPUEYHbUCd1dB/QfHz1oWNcLB5zjhnNop9I8jI9gsZ+4EGcJr9d5RgwY9xVYcWDTc3GrGZq/xrdrPD0xdp4sAJqdUvYX8zbuO89qHVAaffcI04Mdswzwwh7tHch7c3YsNA/kFaHklLgH7RBTnIIqJDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268078; c=relaxed/simple;
	bh=uW3H0d+BJCXrwWkKnw5Fb0qN84qgHPbqMpgTWLgH2o4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QRkhd8u/DoVzLQpBfj6XXlEZcZ6jUk9dmUjq7VHbyNIs0lK9N5AnBZRvVwfNFHM+SZgQKwepPpF1eT7lmXhPvlTkV/CRfswBRzfCgW+BnOfoInaaKXn9a91XF2Jzj4ZP5jLnBoTQ8YMdTR5Qvw8vLz0JyDzPibk8nYQMnlPy9iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJH3pDjv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJH3pDjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2BA1F000FF;
	Thu, 24 Sep 2026 16:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268076;
	bh=QOno6iiVlcNbLJpqOucVyjIfMaHGWKY4vhUV+P8Di8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LJH3pDjvwhcwMMWcKAqVBZWEVOlizI0utpv2sQJrXIUjE/HEnk7MXz0HfF8Ac9t4V
	 ct5/ZTjWyNZUxBL6jOHBZYJoskHQaty3mjuU6hO1Tg+moBU5bE+M+nOWyR/KNr2a1b
	 QbbbjhGejwAPJYUVAw4Y3/y04WOZ4F4NdvZH0ESsOR2Np/X94pg+3lS4jct6Pe9LUq
	 SEAbFPBgwSGjLVmV+WfKHGJ9wQkWOS/8EBb+K0xcNIWYOiKSayHCpUKEs7gmYi7N/4
	 bVikZB0/H0YJB56ydh8XZjFLWvdPDd/ufXz7kuqCfj0kup9bhWj6FPxsEhWenuG/n8
	 qnpHTQJJZauwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198213A566CE;
	Thu, 24 Sep 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Fix fastcall rewrite with indirect stack
 accesses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179026800589.1646186.10786089414631608993.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 16:40:05 +0000
References: <20260924075352.2343553-1-memxor@gmail.com>
In-Reply-To: <20260924075352.2343553-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 24 Sep 2026 09:53:48 +0200 you wrote:
> When a bpf_fastcall call is inlined, the verifier removes the spill/fill
> pairs around it and shrinks the stack frame to exclude their slots. Two
> kinds of stack access skip the check that must disable this rewrite, so
> the program can then access kernel stack outside its frame: stack
> buffers passed to helpers and kfuncs, which BPF CI reported after commit
> 5da4a9f26fca ("bpf: Preserve stack initialization for generic output
> buffers"), and a callee's load from its caller's stack, which checked
> the callee's frame instead of the caller's.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Check fastcall stack contract once for all stack accesses
    https://git.kernel.org/bpf/bpf-next/c/ec3a69e7c021
  - [bpf-next,v2,2/2] selftests/bpf: Test fastcall rewrite with indirect stack accesses
    https://git.kernel.org/bpf/bpf-next/c/ba28c18f3439

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


