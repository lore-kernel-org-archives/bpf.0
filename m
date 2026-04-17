Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0D30FC1F
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776424935; cv=none; b=phu/8Os9qteK0yshZgcO9SlkKV3oJpI1yqhsadvB3ns30DEuQY2ksnmwmEgY0JYiLO5KQ7gw9C41zQfpTPETd1CoJk8o88bhFYNzsImQX+gpkIAK+Rdxqe0mOz7lS3JgNrD33skR4jn1i6dLOjuOgPkK5H04fXp3C/9RMc6mw0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776424935; c=relaxed/simple;
	bh=Bw2x21Toxiyp7btnQq/1/FbIpXIzFyNc9UzvwDfx4u8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0Oxf5ksvbu0gxIx504whQtdnfor0updRzCBEugTMMC7MqnaLvqOb8OhQ9VnLS5F5ZoSDcFqkbio/MtxQkkn95UYSSxGT+IT37A7qQzz2rBlh3uDuVwMvDu9Hsg64DWd+QHDC771rTuoIcZktIIh0JL3jpqMj9TaBcwkQYbUuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qnLFjkwS; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qnLFjkwS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5rJ8QjCz8tAOoHk7zoU38Y9W/nUxy5PN6rGyzWZqcRg=; b=qnLFjkwSjBnsUbR+wn5PJJanst
	phPMyK1vqVlKoy9cZ2TNGVK2mgobhM9XJ6727Y7HaP/GmTU46QqD6jkvSOYx0F8mlD2pPSjE4Yz/S
	N65756DUcABYvVe9uI4XyPUTO2Zr9zqA0oPMUIFj/Kpw6GVqEodjTUkrSirtEx1yHwJYG/6WU+Rfo
	VXnGCxeqs8EfwuVG6ICD7UrjClVT+rv55GCVuzuXiTizddbG9LvC8R3OiguwyK2h9/2Q0rMpEQevy
	yYa/58tir/lDBiU7DL0cgdgJFE/KsVG8LIIcTCk8BygHZ0dh/jKe9w/zZFjx5WFbK/SgYSpjmZhvw
	ZAqKZddA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDhGn-000Opx-1M;
	Fri, 17 Apr 2026 13:21:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wDhGn-0002md-0E;
	Fri, 17 Apr 2026 13:21:56 +0200
Message-ID: <b64a9ba4-2af7-45d5-8f68-6a64cc498364@iogearbox.net>
Date: Fri, 17 Apr 2026 13:21:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf, arm32: Reject BPF_PSEUDO_CALL in the JIT
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Jonas Rebmann <jre@pengutronix.de>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Russell King <linux@armlinux.org.uk>, kernel@pengutronix.de
References: <20260417103004.3552500-1-puranjay@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260417103004.3552500-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27974/Fri Apr 17 08:24:08 2026)

On 4/17/26 12:30 PM, Puranjay Mohan wrote:
> The ARM32 BPF JIT does not support BPF-to-BPF function calls
> (subprogram calls). When insn->src_reg == BPF_PSEUDO_CALL, the
> imm field contains a pc-relative offset to another BPF function,
> not a helper function index.
> 
> When a program containing BPF-to-BPF calls is loaded, the verifier
> invokes bpf_jit_subprogs() which calls bpf_int_jit_compile() for each
> subprogram. Since ARM32 does not reject BPF_PSEUDO_CALL, the JIT
> silently emits code for the call using the wrong address computation:
> 
>      func = __bpf_call_base + imm
> 
> where imm is actually a pc-relative subprogram offset, producing
> a bogus function pointer. Because build_body() reports success,
> bpf_jit_binary_alloc() is reached and a JIT image is allocated.
> 
> ARM32 also lacks the jit_data/extra_pass mechanism needed for
> the second JIT pass in bpf_jit_subprogs(). On the second pass,
> bpf_int_jit_compile() performs a full fresh compilation,
> allocating a new JIT binary and overwriting prog->bpf_func. The
> first allocation is never freed. bpf_jit_subprogs() then detects
> the function pointer changed and aborts with -ENOTSUPP, but the
> original JIT binary has already been leaked. Each program
> load/unload cycle leaks one JIT binary allocation, as reported
> by kmemleak:
> 
>      unreferenced object 0xbf0a1000 (size 4096):
>        backtrace:
>          bpf_jit_binary_alloc+0x64/0xfc
>          bpf_int_jit_compile+0x14c/0x348
>          bpf_jit_subprogs+0x4fc/0xa60
> 
> Fix this by rejecting BPF_PSEUDO_CALL early in build_insn(),
> falling through to the existing 'notyet' path. This causes
> build_body() to fail before any JIT binary is allocated, so
> bpf_int_jit_compile() returns the original program unjitted.
> bpf_jit_subprogs() then sees !prog->jited and cleanly falls
> back to the interpreter.
> 
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function programs")
> Reported-by: Jonas Rebmann <jre@pengutronix.de>
> Closes: https://lore.kernel.org/bpf/b63e9174-7a3d-4e22-8294-16df07a4af89@pengutronix.de
> Tested-by: Jonas Rebmann <jre@pengutronix.de>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
