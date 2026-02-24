Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBB23EA83
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771899002; cv=none; b=jQGatL51V1wAmGeyD1AIe2+b3k6yNDTttFIAIWIHQo6mAioEurdCwcEwk656Z1szremvayP4qZp0tpzc7x1JH6DiEMw6PH1uc5lrzkHF7z89crIWx5os4Rkc+oyOq1BAiDRAKD63z/iwZzENcmK5C0jQp4RhZBh5N4EnlhtSg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771899002; c=relaxed/simple;
	bh=DUZDDHORRjWdSKDebl7yIIz658Z0RezmH+ubKQffhvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jnv0mHSHgC4ppNPGqnxny+SWygZSei08Q2x++q6RaYNbg6d2HqkQn7O5elr+GP7szlNsLQuuj0bJy4AlNoYEHMZRvB1wIYV4Oi/czu2nor3Eh1F6uc/7u4FCpriO+BT6VZhVCaxaDsLsVeustm4sGosefEWz1vb15n2nq+Gagck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmWQtWdU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmWQtWdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03441C19421;
	Tue, 24 Feb 2026 02:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771899002;
	bh=DUZDDHORRjWdSKDebl7yIIz658Z0RezmH+ubKQffhvQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hmWQtWdUuFd+QaBF1aeiF0cQa7srbblXxKARhmoQSYP1dcyLfdZAFD9aqsQLjQ520
	 WldJGyeJuSbBEtd/+YUF1wPAw+kJ7GiinL1KHwpCrl1qAiC2vCvar2EOTRgPapk0yt
	 uVrAtpZbrKMa+FLgoAsZKDePKo0NLmwbNUokmLLBzTq6hv7tkA/dp38fzMytDLyZAS
	 H2x8v3+hNJkoJbXqUOZpOZNHcVMsW6vVp6VfdiPYZc+DEJG4bu2MS/JRski05JOwWm
	 tgrooNXGzAsOgMHdOZJvapozeig0vkX/TU2XgfPwCrjsid1eK5tBiM8/OccoYnE5yJ
	 /Ahx7zjdEO/Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF863808200;
	Tue, 24 Feb 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/1] selftests/bpf: Change task local data
 library
 license
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177189900779.3277452.13571355088445266898.git-patchwork-notify@kernel.org>
Date: Tue, 24 Feb 2026 02:10:07 +0000
References: <20260219225849.2426421-1-ameryhung@gmail.com>
In-Reply-To: <20260219225849.2426421-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 19 Feb 2026 14:58:49 -0800 you wrote:
> Change the license of task local data library to LGPL-2.1 or
> BSD-2-Clause to allow it being in a wider range of projects.
> 
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/task_local_data.h | 2 +-
>  tools/testing/selftests/bpf/progs/task_local_data.bpf.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next,1/1] selftests/bpf: Change task local data library license
    https://git.kernel.org/bpf/bpf-next/c/055d8dd55302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


