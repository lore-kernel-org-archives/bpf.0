Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C802DBF75
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240478; cv=none; b=dbDFq81Z1V8Iu9TIGKbGEdC/5ljrsTfxLF05IA4UVjh1Y5MDKtnlrh8IAu2CNCphWfg9DizmpO2TvTtVQ5bueJ63zNxFy+Xj88vguLj9jjP2zQ0dIkBEZYpWmGK4tThPLShOmniZ+LMEyhsicpkMJo85MYHjIxhBBEdl4ZmvpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240478; c=relaxed/simple;
	bh=Qn06SbGq1wk0BUZ8tPp+Nrbahb5lK0o7Qxh6xLSd1YQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c+G8iJkOYrLT0oT5IzC+eIHknITMLJAVPQiIEV/y3cIfWYRs7x6Y76uhWf8nnV8IH2nyFnasfaCR3UbNu+08XdIn8m913GIUOcX3vLT0duKSfz4DGRFuDQyfae8zmEOrTAXhxmWAOubpBoza8HYbF/Fov8h7J0mcoFAif9ibXQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DguFdPdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DguFdPdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAB51F00893;
	Thu, 24 Sep 2026 09:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240476;
	bh=bd8q52IwU3xQbJKU70uQWkutE2xFBF8w7w1DqZapinc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DguFdPdC+wz/0ejCTUTzz/LryfjBr+KxZWqOEVzr42fHY3lVmwycDdAwVobJnKgdn
	 ghsDgPqntfToRBWmtOdTWCGIW5zRL4COmZkwWtzetIzX1EFKvcSwpjZadb37qcABu/
	 dP+BGLJsO8PDAkW29E80BRa0N2BszbglElpjzCxnV70QRIQV32o2Wy/sMKKJNsGPzm
	 3jPbgaZoKGbCbd0yTYQFYXOsEDd9WMjGnkrBzs6M2iQD7w+3RTu6FAXHlAIb3VD2KA
	 ZMrGDhnAvZ+ieHho2ft4SJte421wkPeX53WCtNjq7R2ZKryTYDIYIHBIFH8qp1CqEz
	 K11//xesBrzjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6639EAFD2;
	Thu, 24 Sep 2026 09:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Keep target extended until its last
 freplace link detaches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024040591.1417542.4109230911556395227.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 09:00:05 +0000
References: <20260924023737.1140521-1-chenyuan_fl@163.com>
In-Reply-To: <20260924023737.1140521-1-chenyuan_fl@163.com>
To: chenyuan <chenyuan_fl@163.com>
Cc: alexei.starovoitov@gmail.com, ast@kernel.org, leon.hwang@linux.dev,
 bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 yonghong.song@linux.dev, john.fastabend@gmail.com, song@kernel.org,
 ihor.solodrai@linux.dev, chenyuan@kylinos.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 24 Sep 2026 10:37:35 +0800 you wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> is_extended is a plain boolean, but one target prog can carry several
> freplace links at the same time, one on its entry and one on a global
> subprogram.  __bpf_trampoline_unlink_prog() cleared it whenever *any*
> of them detached, so with two links on one target, detaching one of
> them re-armed the unbounded tail call loop closed by commit
> d6083f040d5d ("bpf: Prevent tailcall infinite loop caused by freplace"):
> a single BPF_PROG_TEST_RUN on the tail-called target then panics the
> kernel, reproduced on both bpf-next and master.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Keep target extended until its last freplace link detaches
    https://git.kernel.org/bpf/bpf-next/c/c43c348a8446
  - [bpf-next,v2,2/2] selftests/bpf: Verify is_extended with multiple freplace links
    https://git.kernel.org/bpf/bpf-next/c/01d37848bf5b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


