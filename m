Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EA618B0F
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025233; cv=none; b=Gj/q+mVO9M8esZIiMnnt1Fr8HRHXQ82kmymIbYKq5H3srQgIdcQCXQW76eTyHNJU2w4FqZ2UmaCFsfhoQWdjMi4SpkB2v+/hbXOfHg1LOFC9uZsdzKAnMgCxlZRP+IR9qApDt6FSg0fjuVNBbhKeHPz4PxON1yDeRRvr6zAzwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025233; c=relaxed/simple;
	bh=6lhWUJBXQiOzmnZG9cv8z3Txb/nz9RHR1lWjDrpqHg0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Agn1Vso39ym/J3+4ncUr76rO947IUJ/fvlU2+/zBxpFyKCJEI/9Z9UFL2WPC4BSPyfuo0eT5iMDXXjWp7zTkc49PufqjCfUc6IIbY43/TxkIJjcSD5tL1a5q/KUaj+bruevlxPMPRJ7aR3qIPyLk71tEBh0Lu3z4ZFbL9xgLrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjEZ4B7z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjEZ4B7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FEAC19424;
	Sun, 12 Apr 2026 20:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025233;
	bh=6lhWUJBXQiOzmnZG9cv8z3Txb/nz9RHR1lWjDrpqHg0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cjEZ4B7zInlYXjrJEzgzQDlVOxQ6mHhdZlPjiGqoZ75f2X7v1Qz+dQ+ltUpHhU+QV
	 kGQ+YHShmKG8HQJnFj+3IRjo5W4aBwgu/Hgm1yQXUolE0yY8ojzPGL8WPBZdleR/RQ
	 bOv9O1Fat1ylKBoz81i8Va1F6J1n9ctLkaqmaaRA/MyauvP5fU0LOLka4yuwBbNUl7
	 Bri8txAvhG8a+vpCkY6dcKexn9v4TLvKHWlPZSM4hnwFdBQYKExss2h4ls7h2DtHus
	 NL/S+dGTAVUOPofvNPwxvMqIDURy4VLmx9L8KB3KKwSa7b/mGBdogzMrNwFOrDK2HF
	 CsZ08v7lny8qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E093809A8C;
	Sun, 12 Apr 2026 20:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix reg_bounds to match new
 tnum-based refinement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602520557.3398432.2946329303990502452.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 20:20:05 +0000
References: <ada9UuSQi2SE2IfB@mail.gmail.com>
In-Reply-To: <ada9UuSQi2SE2IfB@mail.gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 harishankar.vishwanathan@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 8 Apr 2026 22:40:50 +0200 you wrote:
> Commit efc11a667878 ("bpf: Improve bounds when tnum has a single
> possible value") improved the bounds refinement to detect when the tnum
> and u64 range overlap in a single value (and the bounds can thus be set
> to that value).
> 
> Eduard then noticed that it broke the slow-mode reg_bounds selftests
> because they don't have an equivalent logic and are therefore unable to
> refine the bounds as much as the verifier. The following test case
> illustrates this.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix reg_bounds to match new tnum-based refinement
    https://git.kernel.org/bpf/bpf-next/c/2fefa9c81a25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


