Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55EF478846
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245258; cv=none; b=uD9j+GSeY4ZxbQrs+x6BW9kdAhsc7gX7oahCuB3QxVMvfKWieyKvkMAOv3PdwGbva9MyFERsX57H5/uv5pw0q/BdOzcbvGJmTns2GsqzisHJQxoSqiEnNt06wunlz7hZPWbUSpp5Bh32RGwOPcINyaeyolGbCBV9+xs2yg4qiN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245258; c=relaxed/simple;
	bh=GPX2z5mJPlw1gFTxTCY0yqGFJ1u0tKnYT7R90L/saSU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PfjVBrZ1b7J0O78IK1zz+DTHFwy2Rkt8TMmbN0IMa1v5fzW6yoiBxsIBJsb+KEfExWrXA20utmhjH+EoH/SvlMMR+cK4OQA35/lc0wuwu1ELzksvKDxvMSg5NNBBjdnKSh9WQWpjvyOa/tFUFRlO9PbO6A0n/udIyGzftM3R+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBpxZuSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBpxZuSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE821F000E9;
	Thu, 20 Aug 2026 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787245257;
	bh=1UqhQKX04AgkVZx7HsCwgygATvFAb8R0svbeMEfJfPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NBpxZuStZZq9h9D7E2DkEnbCAZE6HUgkVFjCbw29fo0gjxRAu48l7V2Mr+uOSw9Qv
	 PiIa5D3c+n7tMfuLkFyP23wT84W7DBFXmOVlCvdkYv446Rx8b2+3JZMJHPntJwCFY8
	 de7WTtaVxxOJJKZKIA0LaqagOBOCRuAj2gWcJzb++w40VC4l/VuowlfT19lHwU1nsy
	 GBDU7f/R25qWUDZB2G61mihHUIIT1dCIs8FUZbS0dASctjSzCqb8GnkbDfGwYyhagt
	 S3sn4WXzJfXdW/yi9MpwAg4qabI3YCwatEzjbN1y/w6rsqaMlI2PVDewkFPE/FXkqz
	 FAYUc/+C5We4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198123822D27;
	Thu, 20 Aug 2026 17:00:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Reject invalid LDSX instruction in
 disassembler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178724520764.375549.8870221055303575118.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 17:00:07 +0000
References: <20260820022020.3450479-1-memxor@gmail.com>
In-Reply-To: <20260820022020.3450479-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 20 Aug 2026 04:20:17 +0200 you wrote:
> Reject invalid LDSX insn encoding in print_bpf_insn. This was reported
> by syzbot in [0]. See commit logs for details.
> 
>   [0]: https://lore.kernel.org/bpf/6a86596a.ae6ddae5.3da009.0015.GAE@google.com
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Reject invalid LDSX instruction in disassembly
>   selftests/bpf: Test invalid DW LDSX diagnostics
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Reject invalid LDSX instruction in disassembly
    https://git.kernel.org/bpf/bpf/c/37e5c4f4d285
  - [bpf-next,v1,2/2] selftests/bpf: Test invalid DW LDSX diagnostics
    https://git.kernel.org/bpf/bpf/c/175a58668e2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


