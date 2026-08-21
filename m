Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146F40756E;
	Fri, 21 Aug 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787340062; cv=none; b=RJ/fxtmceu9FRkz0mvM2yLsYpRw/wut7YKeyXr89C7fuquKH3MOLqwR7FjEeJLZ/jte2zL3oQSf+99vIdvPQE/DzUplmOezlgiBG0HtOigtTv0RORTnAbGnIxF+yJz31p3hf3Cgsisops3SkOwfHpSu6IaMFvyLT8Z2+KorOXnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787340062; c=relaxed/simple;
	bh=lffdFixketbHOpLXDDhckbcG8Psyd8M0taCpnN+N5LA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ftZodXBV6BQBsefM0ZSNm8pxgJivwttVMqE1rxthKUOU2s+NYwdUX2ncQ9bkdlqzkME1eL3e8QhkEhwA4qEjV9M0Ka5txF9RqB7XLVz+08bUP5Lj93YiHk952rltm/GMlmTVaEDXkRj9cF4Ikp6EM3t1RTRpbjErZQR+0L/F59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QipQ5Qc6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QipQ5Qc6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F451F000E9;
	Fri, 21 Aug 2026 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787340061;
	bh=hoIKqY8QEm2dgJa6UzGuLGj/wMCd5D7LA6A3vEO1g2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QipQ5Qc60GNTgSzkZq2xFHaqmDafQAv4uJyERYYy1FnOe5n7NR8WKR08mORSp/GMI
	 AG1kmSQj+v6aesbn2rQFMK8AC8/zPfId402qHtHxlQwKBdRmBFH8Fnsuh2gvFVgrUK
	 sUgLOK+ZVFE8eW75REGBW3PfJozO4LQdPTqjHo9azvbkhn+rNz6drgQgbpy43FqbCN
	 ay/DTXQJE1JPXxTLRk/0ljgh98E/YCDMyF8ZtV5l+AcO7bPxozJZqHYz0TiOgFECpv
	 vZAVoorZ7Z/PfgBH4xF3EyjZ/cikFxSot5PKPiWmhlf/jGEqS3anfMLAe5eJioFncf
	 vRBiPQ6zKbaDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D096A380CEC2;
	Fri, 21 Aug 2026 19:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v7] selftests/bpf: allocate a larger timeout for
 connection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178734001048.1447337.676425481174448454.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 19:20:10 +0000
References: <20260818-tc_tunnel_flaky-v7-1-aec161e74ef2@bootlin.com>
In-Reply-To: <20260818-tc_tunnel_flaky-v7-1-aec161e74ef2@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29_=3Calexis=2Elothore=40bo?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	=?utf-8?q?otlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, bastien.curutchet@bootlin.com,
 thomas.petazzoni@bootlin.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 18 Aug 2026 20:43:00 +0200 you wrote:
> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
> following logs:
> 
>   (network_helpers.c:309: errno: Operation now in progress) \
>     Failed to connect to server
>   send_and_test_data:FAIL:connect to server unexpected error: -115
> 
> [...]

Here is the summary with links:
  - [bpf,v7] selftests/bpf: allocate a larger timeout for connection
    https://git.kernel.org/bpf/bpf-next/c/669e4fa76600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


