Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D56716CD33
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696016; cv=none; b=mfyFkiSLta36exTI0pd9yzZ95Bpm923Sj3BeH95ItbSkc4X104EUVyKEPytVsjqrrpm81tLK1U51Rz7zpQ5lxw/NKjuisubeDacovvFrfogSgr7d4Z+UJkCoRwDsNRJRItqmYJlSozOWB4lg2KOkbpMANevVZ531erbU4JGKkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696016; c=relaxed/simple;
	bh=BUrjoea7Rv6GiGuVlLWrZCw6oX/ECFhpYT5m/85dFwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DFVqC+8y039g1HZm4ITvruLxNs+cVR/70+69vQIiGhWD274hKFKOR4obRjzTIShulTK45zx86IE1/1b94pWJvUQ3QSu3FehEJPmiCGGyG7xb6UGilHI7dfFA65tNgmZJqGQngSLcC7b6nZIEsscvUFKwqpdQZTOCVihFE8ep9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLPQIboR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLPQIboR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED81BC19424;
	Mon, 16 Mar 2026 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773696016;
	bh=BUrjoea7Rv6GiGuVlLWrZCw6oX/ECFhpYT5m/85dFwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nLPQIboR18MKT/7CX5sfEb/DeZXr7VDu1VzNtqvY9Oto6iYtgu16N2fjNisiELF+c
	 pEaKv3/XVHeje3YsBo/pTFGUIlJWs8wIN7g7D/xRbpopaKwHdiXaIxVykhMnakEy1g
	 fvxc+UP4Eko9iY9eNcSGg1U7oEASu690zxu9TgDIAFw1IfnYg112gu5hSPhwqGtfUo
	 oE8lU71xGdxV4ikLLeGZMBxrQ4Ar/5i4s3Q9F2P79LQNAndtqMZEBNH7atAo39a5Eq
	 rl3aFhL4Zmj9rCw4fI3H64m//JFkue3uniBkldAJjMHS2m27Oxq0mUsyWc0E7S0fCg
	 V9oyKbb6cQu5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D283808200;
	Mon, 16 Mar 2026 21:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm, libbfd
 and libcrypto dependencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177369600879.3315352.11073285024699021876.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 21:20:08 +0000
References: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
In-Reply-To: <20260312-b4-bpftool_build-v2-1-4c9d57133644@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 12 Mar 2026 17:03:27 -0700 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Introduce SKIP_LLVM, SKIP_LIBBFD, and SKIP_CRYPTO build flags that let
> users build bpftool without these optional dependencies.
> 
> SKIP_LLVM=1 skips LLVM even when detected. SKIP_LIBBFD=1 prevents the
> libbfd JIT disassembly fallback when LLVM is absent. Together, they
> produce a bpftool with no disassembly support.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: Allow explicitly skip llvm, libbfd and libcrypto dependencies
    https://git.kernel.org/bpf/bpf-next/c/c73a24436698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


