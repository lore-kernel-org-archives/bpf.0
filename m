Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D5382F33
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280850; cv=none; b=dEvhqMSthh2+uEfeMhu6bb7olCJMzcZrjtXAs813utpa2bG7f5fz4DWPlmBK1V30ATDjzdeudo5MRgAPkujWc+fvFW5odkcEzufFXwyAZunf1DPGj31rxeMzAkPvlHGmhTNcK2nLCRoverorOsGPVtlg7QlCaf8Rs4E4+u/ixj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280850; c=relaxed/simple;
	bh=rOJeVitTpOURxblqRmqQpsXxy1cWrfyjcWMPn1HQnMs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rQxy7B/c3KFMmJLNUaelXBs4dGhBSzPCnqIrYAXRlruR6pZtYcGVlkZQP+J4UJbe7A0mpUsjTwRQfo3nt+qchls7cbm8g0KimFxgWdQcXobxK61YYQUm3Ute9MFQeZ0raa/3MNiT0qQVUuHp/vMtdcLJmb8jWCxoZxNPc+7cQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SizwGA3a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SizwGA3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2057C19424;
	Wed, 15 Apr 2026 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776280849;
	bh=rOJeVitTpOURxblqRmqQpsXxy1cWrfyjcWMPn1HQnMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SizwGA3aHRDUXMFB3lNMjVpCD6DksOCa8oBMzblVedqBNkVzpfQbW0lLZQoJXg8wY
	 kZ28Ygu6IIX+XAxd6MSs76MpjB4/dPHdLHeLKFRNJQhJkKQmOZlMiPNUYCLof9ByGR
	 6i9cXLorAe8e6Ww7THEtiX6vNGsGeHwAa2AVQecQPOog4he1LcqyTz2VPVk69tl/Uw
	 UTFoY6RGDfPebJrHVqRKoi0/X33D7+lzeDW50+mysRlgx+zQk+6d3nw4O8vEsBDXre
	 WmHD/wkyYepP8NvTuyEKrVWMs9IY5p/VEjoveTQPNE2Qo0iLP9cMDI1VLtLyCNrDPT
	 ewD7y2oeL68qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCEB380A963;
	Wed, 15 Apr 2026 19:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 1/2] bpf, arm64,
 insn: Reject out-of-range B.cond targets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177628081879.2402333.2608299227037618336.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 19:20:18 +0000
References: <20260415121403.639619-1-daniel@iogearbox.net>
In-Reply-To: <20260415121403.639619-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, ast@kernel.org, puranjay@kernel.org,
 xukuohai@huaweicloud.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Apr 2026 14:14:02 +0200 you wrote:
> aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
> compute a 19-bit signed byte offset for a conditional branch,
> but unlike its siblings aarch64_insn_gen_branch_imm() and
> aarch64_insn_gen_comp_branch_imm(), it does not check whether
> label_imm_common() returned its out-of-range sentinel (range)
> before feeding the value to aarch64_insn_encode_immediate().
> 
> [...]

Here is the summary with links:
  - [bpf,1/2] bpf, arm64, insn: Reject out-of-range B.cond targets
    https://git.kernel.org/bpf/bpf/c/48d83d94930e
  - [bpf,2/2] bpf, arm64: Fix off-by-one in check_imm signed range check
    https://git.kernel.org/bpf/bpf/c/1dd8be4ec722

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


