Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154807;
	b=L8bOsG8iaFAoVzvYRZHNdboO/J/rCORpVVjZn1CuCsgrjQM2weeRN0LtqUDPa/zRZuMd
	 bXq6tTFiYqAmGApOA+NUtjRm7gawWrEfTI5IEX6+vKPfkZ4Y0Sznga/6FYeXkYuZ584DW
	 G8dPdPLnnGVypNq6eROD+/ZUdcCSs576Yuvjnn3VigCfsHGkuBI9K1cgqw6iQn1JzagaQ
	 2aM3fsfiDE6iXQsM5JhkilJG7sWgZRX/UrbJqASToaAiLkgxNyFM+h7yfgY0wfF0T5XGd
	 OeIFoY99JaGIi7x4HOCnc9SZswVcta5WODtzByghSbJAp4PN0IzdruZD79TyyiCayTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=NNmKBVSMBCA69Qx/qyRK50zvFoKU6NvJ4oAJzedkBus=;
	b=qwVl4T1VmPdP4WbIKQ3UI02KH0lsKGGL7a5FSSetzgId6/0H0vc189MHGGh86dYnSbgz
	 0blD2XZ01jMGEWnKifvtKrdigy967GzkTrZQfolDg+znWP6BjFOAggha/POtVdXzV9CgO
	 qCjl1Hq/NgUPZKqr2dxrX+wJnACcZaiRgXh1q3w8vYac56hkpg109MmfdQZjudySwsYcO
	 D0n1MLXLKkq8iiSsiOaA5jnQE2lNBc/ghcTP8MqjjtmD1KxplKX0lfw4vOLzy8RkGFfsC
	 Rv+6Kx8rQfcRGXbpRnbYcPbCNNFpd1iOojhQMXRza5bI5e+Bflcncu8HERQkRIOqMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dA8F8yy3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BC606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dA8F8yy3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A821F0089F;
	Sun,  8 Nov 2026 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794154806;
	bh=NNmKBVSMBCA69Qx/qyRK50zvFoKU6NvJ4oAJzedkBus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dA8F8yy3bly1cLgTrZEAG77BBrKls6v/IiT+mGsmR32J0A5gJe9SfgpvK9h+r8xhK
	 ZlG/fY09X9LtIHhW4LwglzSkUWkvPKLTDKWixPWVjEkoPJBBlOy8ZZ2XTQqj/9HANF
	 RoLTspiYCKprF84nyNXSm8N1SeZxtN/fjoxtnwtZ7uJ2wJFGWfbPg4IxrukqU5mmHj
	 h6kVmEYdN+Yz9goKG9imKbmuRcyVWTFJ8nzqrXLwiWjHWdUWET/PCExeUWcrAulY+l
	 CH72kqMZauI3VTptP1QT88H/F2xVW+ay8qqJ6yEdOp+pPjOoP0JmgEFkgMUgmYyL11
	 ULQ8MD34cUy7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B328380821F;
	Sun,  8 Nov 2026 16:20:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next 0/2] bpf: One basic block and the way to it in
 the
 level 1 log
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179415480542.1631906.10076400287489305984.git-patchwork-notify@kernel.org>
Date: Sun, 08 Nov 2026 16:20:05 +0000
References: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261108053937.4134138-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  8 Nov 2026 05:39:35 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> At log level 1 the verifier prints each insn when it verifies it. It used
> to follow one path at a time. push_stack() noted the end of the log when
> it put a branch aside, and pop_stack() moved the log back there when it
> took the branch. So the log was the path from the first insn to the
> current one: never larger than the longest path, and for a rejected prog
> the path to the error.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Take the end of the verifier log out and append it later
    https://git.kernel.org/bpf/bpf-next/c/ffb7ea52c7af
  - [bpf-next,2/2] bpf: Keep one basic block in the level 1 log and print the way to it
    https://git.kernel.org/bpf/bpf-next/c/35fca41d5746

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


