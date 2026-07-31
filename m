Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC3368957;
	Fri, 31 Jul 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527450; cv=none; b=kK/4ag3nhSdd/dRHL0vkkcADfX7auuo0jF79SCRI8TeIXEBvoHFovvm0ku7i2jRqN1CcacTMWPrCXBFUKq9HbgNfpl1HhQMEK2nXALnWkoIy0bxBGFzKBW9oIZltTFL3GaDCxPXrriOK83FMkZnAE3SEDQ1pm1XNbhJGnSEbKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527450; c=relaxed/simple;
	bh=Fykiq4PujOWVQqdc4hTMjoVorWNptrJQJ+8Fm7QC4ZM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXq1RQrv2s/q9pZAQEcI8LaESxRoPK/oKGLG9F9un6ZsoviT6PoG7M2jSrQLVTi2V82qJK3xBCdK/K3Kj1TuLCHNi6vODN/KERPiA/uPhttnbs9hjyN5T7ScFD56axB0uDZiirAWoPHaB4p4PKt0h95XVu/WXFdAu2y6ucgHrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZ75k+rp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZ75k+rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA181F00AC4;
	Fri, 31 Jul 2026 19:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785527449;
	bh=Ld9dFaqom/NlH+zjsR3lrYaHW15J3rC/MEEW1iwOvH0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gZ75k+rpLDv8chp6jpdKG0YeGY3qOlCksj5zmkZRlLCLA3s3wgawUSKDIQHGynL9D
	 wLM6C3JmveOfmCxE1R6VBPr7aN2/84Hf0VNszH8fpil7gk7ndc9rYMIYKdboyAjc3l
	 P1wmAppH3B00yj2+ytzfDgfpj2hzynUeCi18DoGUesnISKqP3Ed7udNUsdLUS2RRRo
	 he6l1UrdKnEX/4EiOw6ARu9z45qaZZ5SsPWqB9zsg8ALotlLk04/l/7jGcQfzEVGVV
	 uJ0lZPTunghAa5mcy3bEzWKUN72eFGW+VKwPboU3qCeMdKFyHzzpYAUVte2QhMeGSm
	 nbKK7JmqJuKgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994C392664B;
	Fri, 31 Jul 2026 19:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/4] bpf: Preserve pointer state for commuted
 arithmetic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178552741189.880156.9331013283819113501.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 19:50:11 +0000
References: 
 <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
In-Reply-To: 
 <20260729-c3-035-public-bpf-v4-v4-0-8ee297e2346b@mails.tsinghua.edu.cn>
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, shuah@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shung-hsi.yu@suse.com, danjwade95@gmail.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Wed, 29 Jul 2026 15:18:26 +0000 you wrote:
> This series fixes pointer-state propagation for commuted scalar += pointer
> arithmetic in the verifier.
> 
> Patch 1 simplifies sanitize_err() before the pointer-state change. Patch 2
> keeps the full pointer register state when the pointer operand is the source
> of the add, preserving fields such as the stack frame number and parent id.
> Patch 3 moves the untrusted PTR_TO_MEM early return after state propagation,
> so scalar += untrusted_pointer remains usable through the probe-read path.
> Patch 4 adds verifier selftests for stack frame number preservation,
> readonly-untrusted memory access, and dynptr data-slice invalidation.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/4] bpf: simplify sanitize_err() signature
    https://git.kernel.org/bpf/bpf/c/a15970d916b3
  - [bpf,v4,2/4] bpf: Preserve pointer state for commuted arithmetic
    https://git.kernel.org/bpf/bpf/c/a4c6f804b44c
  - [bpf,v4,3/4] bpf: Propagate untrusted pointer state in commuted arithmetic
    https://git.kernel.org/bpf/bpf/c/cdf19b1b3c01
  - [bpf,v4,4/4] selftests/bpf: Cover commuted pointer state propagation
    https://git.kernel.org/bpf/bpf/c/21596761ff37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


