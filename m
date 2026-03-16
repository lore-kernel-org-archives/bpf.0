Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B01D7995
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 21:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696017; cv=none; b=rPXjmsQsLz0BmhTwBvu2nGU8/ZZUmU00+6B2222mAuNGfwap3vXtJjfqyH2aIVJun99Gjstsr18ycsWKik0NlZO01fhySDq7JzBE2GbmS0l6NvxL7LYqqkGhb9qsiWVpq8RLdqdFiHKmLq+yUXZFHw3Ff/2EHlDgxUzyLwsrTGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696017; c=relaxed/simple;
	bh=MVB2q5db/HZ0jnG2YuIciDScJ5uFKBhKxkJtvGBreFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jNc9Ag6Sb5SCpKMdWPKBJQBMlRwuUwLd6vxqksYNfnJKpnen9hUwqVaDYUoeJjlW1ZPFqX+j8Dm4+58N+ewKfMuYHrAAAiXqlHYQsKJYayUd8sC7THaPz4cbPSNH2avPRAg0O05wqE1pGep7sTOntIbpOitmqQZSqKlSdmvx2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHC3ktts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHC3ktts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6870AC19421;
	Mon, 16 Mar 2026 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773696017;
	bh=MVB2q5db/HZ0jnG2YuIciDScJ5uFKBhKxkJtvGBreFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jHC3kttsph096NS6CbowvgyYZ8e6aYGMMfnKDgpb/8IiP/5AKawuJFxDigCxlUacm
	 iQBcSHMuNZ5GHtya55wCDrgPyiq13nzCgDcouGR8MYKNIeXPCKk+e6Iu/CXSK2FBaI
	 QJRoaK/C0dZMa+SyyNptKxqAhEbGuSKHn5uWxeiEgGHPrNaS2+Dq6LqugaCmlfDA62
	 +zzrU7kg+fGTjEU+2wLyQAYZ7f1Ac9mP0EV7NRaeMtAdvaqzu1niSaN+hC7h/xZaBw
	 L+pKF4gCx45kdXavwfOIKQ5LV6IKls8OGGrjg6d8i2ScDtWukygBr0wL3CxGQD8mC2
	 t6M7PhTqg6oAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEFF3808200;
	Mon, 16 Mar 2026 21:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] selftests/bpf: Bump path and command buffer sizes
 in
 bpftool_helpers.c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177369601003.3315352.3113482136998561197.git-patchwork-notify@kernel.org>
Date: Mon, 16 Mar 2026 21:20:10 +0000
References: <20260312234820.439720-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260312234820.439720-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, alexis.lothore@bootlin.com, bpf@vger.kernel.org,
 kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 12 Mar 2026 16:48:20 -0700 you wrote:
> The path length of 64 is way too low in some envirnoments, which leads
> to subtle failures due to truncation [1].
> 
> Replace BPFTOOL_PATH_MAX_LEN with PATH_MAX, and set
> BPFTOOL_FULL_CMD_MAX_LEN to double of PATH_MAX.
> 
> [1] https://github.com/libbpf/libbpf/actions/runs/22980753016/job/66719800527
> 
> [...]

Here is the summary with links:
  - [bpf,v2] selftests/bpf: Bump path and command buffer sizes in bpftool_helpers.c
    https://git.kernel.org/bpf/bpf-next/c/7e2f40ef0a75

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


