Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793399423;
	b=iduF9IvbtexHagUKk3yP25CKlvnGNK/9QmcWiw+sG81IsnjtbzOCmJq8Ck9715SZjDvy
	 CBA9W9etSaU0lJy3jDc6LjKXLGWwWpPFPdRSFcUM6WjTimi3CMRwJ5B7yNsvb0Cv30Edm
	 WcVJfpw9HSmGEl2nCjF2Edul4ZoBsWiiOYCAqIigUoC8JJE/xsvJAXlf036IWlBszR14/
	 jYR7XwWy0FYswGos4Dz5iOUhjwBwJ6/Pwl4EYisKxaZcjLLgLwvdaIiye+4E/uPbz7Z6g
	 l3xI7kKYAIrQwG7jn8LpLs1CBQ8i4SAnQRP7VTEf4LsngsY9t/FDVLvoJYVxHZZqw3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793399423;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Mq7rbAOcCyVe77KD8lhj9IedLnTMNWl0tzlVjEbfdDo=;
	b=GD7ay0mI2zSddYe90juOh6r7++XaWFFtookEr1n5ESIeOGorFE/i7TqUVlDYiU6qKtYV
	 UVjF25GeESbr77N3ZZQfgcerEXlKSbbU8MG3MvTLfGjiN11iTUin9dwuDd4K0wcgZXJzf
	 yKvt8Ak5wvbZhsSnYJl/J24fshOq0AzHRjvXvKOTpUTjJ2+xGmSvYM2SdiKHc5TAm2SgT
	 O6cyqP4gFu1qTDU4L0V8iYm/j1NL2CbT9GlRRnevw/HZ2hJGdiG9+Ks8XRzSEsKK0/TsE
	 /ICxdJnkqeU1kt8+xNU768iaZamBI0+pGwKb2uY9gpkcxLl602JcD3GVzYC73utsJKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqk+tI2T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B108C606A31D;
	Fri, 30 Oct 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqk+tI2T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86EC11F000C1;
	Fri, 30 Oct 2026 22:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793399422;
	bh=Mq7rbAOcCyVe77KD8lhj9IedLnTMNWl0tzlVjEbfdDo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cqk+tI2To1HQJsBSC0tGNs+EkVfemOc7yAPNNfnW7Tj3V4xqe4dI9/YuzTjYhUktF
	 IeKZ99M0YRfsNFRalL9WCZ5oP4tr/LswR7zbybN0mpp94P2FfY5jLPZtjEMCwYvcrX
	 ++X134DYdnXuDBdfS+3vmenig2fGz/dYFaJvS1QveSBRE3CbQclIlsH8BIJtcF/OVM
	 JXzNtxP+VCEl0Z/H1nEAtIbxp1c8ehtclmAPf/sIKDoVpTMrN5g2F7FOrwVk2lfDo4
	 vXe5Uxk5ZBpb2oxNFBFVoxvldcrwWko4Xqtsw7SrMNeAhVyDIoQHvfjXbCLkvFH2Ok
	 oOiqC0jy6QFTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2293800478;
	Fri, 30 Oct 2026 22:30:22 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v3 0/7] bpf: Add UHMUL and SHMUL instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179339942108.1805657.18318494661899085326.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 22:30:21 +0000
References: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
In-Reply-To: <20261023-bpf-hmul-v3-0-b99e808cb28b@outlook.com>
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, void@manifault.com,
 bpf@ietf.org, john.fastabend@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, qmo@kernel.org,
 puranjay@kernel.org, xukuohai@huaweicloud.com, bjorn@kernel.org,
 pulehui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
 mark.rutland@arm.com, luke.r.nels@gmail.com, xi.wang@gmail.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, ziye@zju.edu.cn,
 tangyazhou518@outlook.com, shenghaoyuan0928@163.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 23 Oct 2026 00:14:36 +0800 you wrote:
> This patchset adds unsigned and signed high-half multiplication to the BPF
> ISA. UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product,
> while SHMUL does the same for a signed product.
> 
> Both operations are BPF_ALU64 BPF_MUL variants selected by insn->off.
> off == 0 remains the existing low-half multiplication, while off == 1
> and off == 2 select UHMUL and SHMUL, respectively. The immediate forms
> use the usual sign-extended 32-bit BPF immediate.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/7] bpf: Add UHMUL and SHMUL instructions
    https://git.kernel.org/bpf/bpf-next/c/f09c72811afa
  - [bpf-next,v3,2/7] bpf, x86: JIT UHMUL and SHMUL on x86-64
    https://git.kernel.org/bpf/bpf-next/c/eab118af696e
  - [bpf-next,v3,3/7] bpf, arm64: JIT UHMUL and SHMUL
    https://git.kernel.org/bpf/bpf-next/c/a07460d1665c
  - [bpf-next,v3,4/7] bpf, riscv: JIT UHMUL and SHMUL on RV64
    https://git.kernel.org/bpf/bpf-next/c/503b293a4fa5
  - [bpf-next,v3,5/7] bpf: Refactor ALU instruction variant validation
    https://git.kernel.org/bpf/bpf-next/c/997add3abaa3
  - [bpf-next,v3,6/7] bpf: Add verifier support for UHMUL and SHMUL
    https://git.kernel.org/bpf/bpf-next/c/c9ec5e4256c1
  - [bpf-next,v3,7/7] selftests/bpf: Add bytecode tests for UHMUL and SHMUL
    https://git.kernel.org/bpf/bpf-next/c/ddd86412ac01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


