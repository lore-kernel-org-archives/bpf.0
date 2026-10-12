Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E63AF65C
	for <bpf@vger.kernel.org>; Mon, 12 Oct 2026 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783007; cv=none; b=dSL9Sso9P7wCT3SGpuL+DtB1GQaqgJNxI52B7TdKvgtn3fS93idzWnC9oNQfWubP79TW5i9OHYit54H2h/7P2Rgezxd5AL30PFW88hNp2VaCpvuTgiMV466qBHYk1nMmMqZcdRswlMt4o7S/xXOWaedWTtemPg7PXqXCpKg/+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783007; c=relaxed/simple;
	bh=04dr063dhu+m6FuiNw6R9qwcl+2oXXD4K4pY29NPyc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hQ9aUa49AG/syQxO3BWweumTcsy7w6T/zTEEOdQKvQbPIjCLF8s0NJTE0x4xvl57IfADMhpGrCB8IxlUQR2DhDChwXApIdcpmC57MewEx2PYfaqqG9YG/qhOJId8kyHNhAQAHRox2ZW/g3CONtBsgMxPNFz1LZ+Xi8wJ/7SmHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwrO7RZZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwrO7RZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434BF1F0089B;
	Mon, 12 Oct 2026 05:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783006;
	bh=mgbbXn22xqqnD/FzAHjQW1qxElaIoO1/d3JerYTuuDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YwrO7RZZdxtg3P1RhmHIRoyU7nHxNB/Wxwc/kr4My7ksdR3byJXcc4nmCAYrxIwqE
	 j1J6ZIqek0q+kOQJrafI6BQg/cycRbh4s0LvBmFSUOD4qOYWFs5+5lwsHO2J3DnF7A
	 3NWqeMGtaHRyhpRtXByhhe9VT1XwTZX4OqDt/II1KeIXuCF2TFey92U8q0eNVe8wTi
	 AE0v75ZeVDYneWLj+HQuodnhE0x7VVUBfPdmm+a3BWO/cMuvaGbMwBqFDL2sr75UDd
	 PdxfAoDedtx3mbRi5EQSZoDg0F1PnriAIoCFa6n9kyWei9jgO08aaIjxd/6zZ6wIPD
	 2Sjw9zFdNgpOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3CC38119E5;
	Mon, 12 Oct 2026 05:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: Reject BTF ids with the same address in
 tracing_multi link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179178300502.3203934.18259867735111186075.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 05:30:05 +0000
References: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261011164836.2233874-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 11 Oct 2026 16:48:34 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> tracing_multi link accepts different BTF ids that resolve to the same
> address. The attach succeeds, the detach fails in ftrace and the kernel
> crashes in freed trampoline images.
> 'test_progs -t tracing_multi' hits it when the kernel is built with
> CONFIG_DEBUG_INFO_BTF_INLINE. Without it the ids of aliased functions do
> the same.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Reject BTF ids with the same address in tracing_multi link
    https://git.kernel.org/bpf/bpf-next/c/7211c18d7ee5
  - [bpf-next,2/2] selftests/bpf: Test tracing_multi link with BTF ids of the same address
    https://git.kernel.org/bpf/bpf-next/c/60e84b9127f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


