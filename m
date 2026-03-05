Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F43644CC;
	Thu,  5 Mar 2026 23:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752213; cv=none; b=b5ytHjr29K0gCzge5jPSK8Y1EHtc4IdahevTMwlLMYfq3HQuwscMslLYOiQBu/kFDmyFOn1rfbcT4omLISmnObfsB+y1vvZ2xCj3+6oVsU69J0MoM3by9BqEyNhEbvf2fDHvais5MKtGk0E/juL7Rd4d4Pcue07zI2uIZv/vW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752213; c=relaxed/simple;
	bh=cEXj3dXqNdLUGwTGZr+XZ9pYElzRBfut9mTqqoCk/U0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O99NHkQ6LGTAx/W6pnCxwgQH7wPObivL87lHV3A4N8XVED6gLWyunrQbBM5inTrC5fbUwT+dmwdcWKqXcA2I2WFOVunbwmuN6g5P4a5Cuj1qlgdKEP2qDwOTJ4sjA7STuVgU7sAmKDBsrcXK1YOiU0/PLRZPzw6dvUxsCK6mOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAgfh7Nv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAgfh7Nv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06CCC116C6;
	Thu,  5 Mar 2026 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772752212;
	bh=cEXj3dXqNdLUGwTGZr+XZ9pYElzRBfut9mTqqoCk/U0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aAgfh7NvQvhgBoof3B89cQ6XYAN1oSsh2KIXDIZTW27ct8byw0PgB75y5TVeuacsU
	 BfYrZpmBxqWXCmfwD6S4IuNTcBYtAtOaYyL+LdO4bJSADZX2gDLHzgpwWI/XPvhkRo
	 SoJ4JCdCNQwyGEgav9mmg8sFbh+9yffW+e1OAcHaCEMg8nF2IavdsPZalAO3y0avQp
	 QqfR7qJodDrWF0wPgP0RJH4ig0hUCp7UekBJiV6FxQNVlOR0+Oz0depyf1PaOVIOX8
	 O4GnPG/SyK3uSBZk2v3uVTWNm3V0c4iAm7enr0Xbrpr5c2xmqjlwPIfYouLXSRq7uZ
	 meXQcGtA523ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F1F3808200;
	Thu,  5 Mar 2026 23:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] selftests/bpf: fix bpf_cookie failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177275221255.3320727.6349301821232758944.git-patchwork-notify@kernel.org>
Date: Thu, 05 Mar 2026 23:10:12 +0000
References: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
In-Reply-To: <20260228074555.122950-1-sun.jian.kdev@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: andrii@kernel.org, shuah@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sat, 28 Feb 2026 15:45:53 +0800 you wrote:
> Fix bpf_cookie failures due to missing bpf_testmod and flaky perf_event
> triggering.
> 
> Tested:
>   ./test_progs -t bpf_cookie/perf_event -vv (30 runs): 0 failures
>   ./test_progs -t bpf_cookie -vv
> 
> [...]

Here is the summary with links:
  - [v2,1/2] selftests/bpf: bpf_cookie: skip kprobe_multi tests without bpf_testmod
    https://git.kernel.org/bpf/bpf-next/c/74d3305e620b
  - [v2,2/2] selftests/bpf: bpf_cookie: make perf_event subtest trigger reliably
    https://git.kernel.org/bpf/bpf-next/c/7f20d371fd87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


