Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2714D44A
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563630; cv=none; b=DjIGS4Svqonizg2OBhwZkoVQgFafMCcvdHCbiKU4y45SukYWexGFhWiTSJNsZQ2attf/asLrINrcJxnbh4T+CB7CI4KaP5CmztzujnCrpx6iBnj3meraO7KWqd713QTqiKQ1HojVu2OKpfFe1LtqK9T3W1FzylEW1rliYLBCPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563630; c=relaxed/simple;
	bh=Bi/3zFt26sn9vykZE0tYQa4+Y/qYMuhWMmRCJrxE9bQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nl0i1hoJ15cxjsUknQxcx9xUOTUgiprH+xRQIz1Aor5jF5OArcehRZfilEo4yuvHwSwEhZ09oJ15CHbmCTukvAAN5j2CIo6lwlCMz29DxuwUr28IoELJBMG+3z0VYFF+RtUyMZIKM2XI5MvRccuemIKr6xSSkpSGIYO7mHTIw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S07HU2sv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S07HU2sv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE232C43394;
	Wed, 27 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711563630;
	bh=Bi/3zFt26sn9vykZE0tYQa4+Y/qYMuhWMmRCJrxE9bQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S07HU2sv2nroJ9qhBaNrXY8aOu8HIg5b/t4AvsPBU7fmXtQiT4e/VZj7NrCrIlZ5r
	 b/1e3RAVeW8JUeURHOTKfXgzJOkYen2taIqoLMnOWMulsgcgn7lmS4ollIOk9phl5C
	 66IcaASKMzZQ6mjJy0Nx1uOxfWbRwclLzuRW2ayKXekK6AR+V7gz9Cqzq2tYwK73Qg
	 ia02DO/lFAY476HA/rBKYJkmNfDh638NTCe2c+sul/49BEDlhpXzPCjlruLJxL5nPb
	 dm2vZxp1aG5tzqGy9P200sHwpA/5TNzeeU6qv0iIwdyQ/A7nkUxQNMd22D3rgsE79r
	 rNts69zIfNimw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB121D2D0EE;
	Wed, 27 Mar 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: update BPF LSM designated reviewer list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171156362982.29579.496711554035061156.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 18:20:29 +0000
References: <ZgMhWF_egdYF8t4D@google.com>
In-Reply-To: <ZgMhWF_egdYF8t4D@google.com>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 kpsingh@kernel.org, revest@chromium.org, jackmanb@chromium.org,
 daniel@iogearbox.net

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 26 Mar 2024 19:50:19 +0000 you wrote:
> Adding myself in place of both Brendan and Florent as both have since
> moved on from working on the BPF LSM and will no longer be devoting
> their time to maintaining the BPF LSM.
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [bpf] bpf: update BPF LSM designated reviewer list
    https://git.kernel.org/bpf/bpf/c/4dd651076ef0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


