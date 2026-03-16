Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEBD3DCD83
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 18:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685815; cv=none; b=IhB+iYaV8U71xYvcpLJmbbcHYtqZkDFFP8JnP8SRSipoGO6uSOkf+V/M1/DDZGu5ww9YidK4Dz4r8eUym7YdaEo7OcRBh7DLVq9a17QRUrpgxS1o5ckPrT7GB/Ex9SSuIO0BUSlkQUusPWiX+Udua1Mk1XL6lVIv9SZgYt5ojGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685815; c=relaxed/simple;
	bh=x72/I4yVz7koxY0XYMrC9Mzd7NIIzX1OsQCYn/Obr0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ojMsjI6uXjgCfImfLOxZF8DQDDCJ0V4bpAjYifaWL06LG/uiTSmhy2OPxQRsfzzHi9X9zo2KpFiQNtTGQEfMDp6ljnLij3DyFBszqdXml6P6y2gi95Tad2/kb2fHuVCCMMHio5p9z/Iq3JgHx5MY5mi3u4DSY3URpbBygMzBByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFREEFpq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFREEFpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A88BC19421;
	Mon, 16 Mar 2026 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773685815;
	bh=x72/I4yVz7koxY0XYMrC9Mzd7NIIzX1OsQCYn/Obr0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFREEFpqA4A8vpmVMOzjoTMdVrdl8d5N7famZ4WRAu7Y8NOyF5nERSFlI4yDJQ4z4
	 ICjKN99Wv+geTu7bWxrdo1nFqJ7rTP2OKwGk+S0zfh0ckFbyahr9EDlfqgsBzRt+lX
	 5455nfzANgdNEnd7bgpvK5wDYQ6WMpxGlovuxJDKLOYQeDqPZLKo7mmuOhSsQsOlBN
	 OZV0BFFlqNhjHDD86ie8pAM/As/rFDItacckLjH05sjAStkJu26X85XZZQsyLeMr4D
	 RiLUHSUUD9Wp+sXKpIpRQWXC/rqaUC1qRrJS+g04FqQRVJbZv1aQpgXrR7UZWL2EXn
	 KjjjxQ3Lz7cWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA63808200;
	Mon, 16 Mar 2026 18:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 0/2] bpf: Relax 8 frame limitation for global
 subprogs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177368580804.2824501.12875860174900759758.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 18:30:08 +0000
References: <20260316161225.128011-1-emil@etsalapatis.com>
In-Reply-To: <20260316161225.128011-1-emil@etsalapatis.com>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, martin.lau@kernel.org,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 16 Mar 2026 12:12:23 -0400 you wrote:
> The BPF verifier currently limits the maximum runtime call stack to
> 8 frames. Larger BPF programs like sched-ext schedulers routinely
> fail verification because they exceed this limit, even as they use
> very little actual stack space for each frame.
> 
> Relax the verifier to permit call stacks > 8 frames deep when the
> call stacks include global subprogs. The old 8 stack frame limit now
> only applies to call stacks composed entirely of static function calls.
> This works because global functions are each verified in isolation, so
> the verifier does not need to cross-reference verification state across
> the function call boundary, which has been the reason for limiting the
> call stack size in the first place.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/2] bpf: Only enforce 8 frame call stack limit for all-static stacks
    https://git.kernel.org/bpf/bpf-next/c/ad95d3c758d8
  - [bpf-next,v6,2/2] selftests/bpf: Add deep call stack selftests
    https://git.kernel.org/bpf/bpf-next/c/01d5d2f7d93d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


