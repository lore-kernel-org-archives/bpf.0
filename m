Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19CD3BB13B;
	Mon, 17 Aug 2026 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958457; cv=none; b=SHXVUg7G1ab7huelq9Z29SYM9tY+QcT6gM3le3zUFEJjNcSe/AAdukuRjBt3VulIUsQwNfwA7uJU1JjPsY+WPtzPH6Nk+ElgFTupWtxCUeTpsBEle7OYLq9eZa7y6jIMpKgWZ1345Rq7iqZiW1ZimmVxnnNGqDY7mkYMQnK1FkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958457; c=relaxed/simple;
	bh=5mKhMm661IG5oGpElfPAETlsA/b/1/9S2rA+SHzDbZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ntt/mDMIaM9wfFBWok4KhN01jGSpm/o7YHEze8QawnrXkyugnOPW9ZxQx9flKx5kG1gjE4e42rmNMvVCTvGNWjxe9PajZcTycHKl1Ie3+JKzCETkzTvir1SNchdNyYy4B9s/1lZq0Qau4ueQbC84jH7zszuBHAAgwlws9XXdUsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpjUzHwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpjUzHwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1CB1F00A3A;
	Mon, 17 Aug 2026 09:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786958456;
	bh=8lDvhbhxSTFKOrFWwrkrCC9MErE5ZeGpeRi6tIY6Av0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BpjUzHwcRJv8SEy6iAMfxWuGbwFEb7G1r4vtorKX4hBQtHryD8kj8yAw7H+K2PK2T
	 xVyVJ5pmgdqxc/DYe4nN70OpWVQMadgQZbzzqP7tHfOa541GdkzIyC2r+WEbuNdOd9
	 XdORUY1VfVrq/WC9C6qz+QYjxQ0umWUvHOnfUf7vtg8t7DeisFZeg3UKqW+JOpBR6D
	 m4ijNF5V+u9GBGP06GOT/6+WgK4NOAMmWr12KjhLTXyK0aVEPGCvJEnuaEtXght3wM
	 qr/EwcvAP8EOXfLp5ajI6r75FvNpLuzhvWsx4Jw2AXqupJ11FJJPTrPjVBfxNEQKDy
	 qFRmAGTrsodkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198403924FE9;
	Mon, 17 Aug 2026 09:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Enable timed may_goto tests
 for
 LoongArch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178695840866.1036045.17681524436560512940.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 09:20:08 +0000
References: <20260813070906.5164-1-yangtiezhu@loongson.cn>
In-Reply-To: <20260813070906.5164-1-yangtiezhu@loongson.cn>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: chenhuacai@kernel.org, hengqi.chen@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 loongarch@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 13 Aug 2026 15:09:06 +0800 you wrote:
> Enable stream_cond_break, may_goto_interaction, and verifier_may_goto_1
> tests for LoongArch, aligning with recent architectural infrastructure
> support (timed may_goto and arch_bpf_stack_walk JIT).
> 
> With this patch, the following tests passed on LoongArch:
> 
>   sudo ./test_progs -a stream_success/stream_cond_break
>   sudo ./test_progs -a verifier_bpf_fastcall/may_goto_interaction
>   sudo ./test_progs -a verifier_may_goto_1
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Enable timed may_goto tests for LoongArch
    https://git.kernel.org/bpf/bpf-next/c/77877bf570ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


