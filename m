Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C725B093
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789272072; cv=none; b=ndVFfki518JsiT7UUE11vCjD5QKrE4SDMpE+BO0u9ZiAeEbBpgsB69DOsX2NaLBWEhzjzR0fM37eVrrzwmPjOdMEcIJJVXR6figNM9zMULGqR8gNUeBkqWE111F8Vfe/zE1y40QjPOTkxaz2z03iW8jTR8q5HLrnNwZUDqU/e0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789272072; c=relaxed/simple;
	bh=8QL3w5F7OS5hRlkG/GsZtWxRtPm9bg+8oaQqADrSF9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JZzCCqLbTm41VzqWeQSeqqT4puS0Q4Fg7MkhscqMkGRqHUwFY1lJ3ciKCS1Lz2mIuJx0+UP4YxpsTL/narwR18cfjvEsoL6ezYitsuSK5N80SzoYAWoLxfhJWw2JQ7WFBBxp52sVxV6tWRHdM4Jq4ilA/Un0OquUHmz1+Nu4IOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3T+ehU/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3T+ehU/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98A111F000FF;
	Sun, 13 Sep 2026 04:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789272070;
	bh=2rOA4il9KCXxUjuuVMox42qOqw7niBO03goilwZmGAo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=d3T+ehU/ljlyV5KTNiYy2y8pU0guDFel8GyxF3iMHXVz4VvJivYI91PxVwu9Jyhj2
	 3sdHSvSl80y5IKnj6w2mA1NJZj4sOb+l30TEbyPT4iDXqZKPie1jo6u/8TOg/N473x
	 t0R92diftykg2/uvxI2UlIkkHxClfbw0CsoNa76Ksl0+bJ0QbNxstN0eMjThBrFVdw
	 yOckZG2XLCvkCNE19iN5cT6SIbbLDszU802Wkf5WebmXLbKhXwzzJ5Xay2ia6e/vY7
	 WcQY7Qs3dNt7pQOITz4jYDKzVyqjccKlJu64tAWl/GM0slK4hxLt/KFukGFR66nxX9
	 6vUqG7oC8qdIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08A03809A35;
	Sun, 13 Sep 2026 04:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 00/15] bpf: Support by-value struct and
 __int128
 arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178927200638.3732794.3320350937871230371.git-patchwork-notify@kernel.org>
Date: Sun, 13 Sep 2026 04:00:06 +0000
References: <20260912195156.980886-1-yonghong.song@linux.dev>
In-Reply-To: <20260912195156.980886-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 12 Sep 2026 12:51:56 -0700 you wrote:
> A global function or a kfunc taking a struct or union by value is rejected
> today:
> 
>   Arg#1 type STRUCT in tar() is not supported yet.
>   Unrecognized R2 type STRUCT
> 
> and an __int128 argument is accepted but mis-counted: the compiler passes
> it in two registers while the verifier gives it one, so every argument
> after it is checked against the wrong register and the program is rejected
> for a register its source never names.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,01/15] bpf: Read a kfunc's __sz argument only when it is in a register
    https://git.kernel.org/bpf/bpf-next/c/afe897e89918
  - [bpf-next,v4,02/15] selftests/bpf: Add a test for an __int128 by-value argument
    https://git.kernel.org/bpf/bpf-next/c/4196b1064bf2
  - [bpf-next,v4,03/15] bpf: Rename bpf_subprog_info::arg_cnt to arg_slot_cnt
    https://git.kernel.org/bpf/bpf-next/c/3bd9d96710f0
  - [bpf-next,v4,04/15] bpf: Index global function arguments by argument slot
    https://git.kernel.org/bpf/bpf-next/c/3f1023cab813
  - [bpf-next,v4,05/15] bpf: Support by-value struct arguments up to 16 bytes
    https://git.kernel.org/bpf/bpf-next/c/4dd676ca5b7a
  - [bpf-next,v4,06/15] bpf: Support __int128 as a by-value function argument
    https://git.kernel.org/bpf/bpf-next/c/00cfeb9554e2
  - [bpf-next,v4,07/15] bpf: Rename bpf_call_summary::num_params to arg_slot_cnt
    https://git.kernel.org/bpf/bpf-next/c/c6ff4e06033f
  - [bpf-next,v4,08/15] bpf: Recognize by-value struct and __int128 kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/ae6abae582b7
  - [bpf-next,v4,09/15] bpf: Prepare kfunc arguments for the JIT from an ABI description
    https://git.kernel.org/bpf/bpf-next/c/1e6c598b02e7
  - [bpf-next,v4,10/15] bpf, x86: Move kfunc arguments into the x86-64 calling convention
    https://git.kernel.org/bpf/bpf-next/c/a3195057406f
  - [bpf-next,v4,11/15] bpf, arm64: Place trampoline arguments by the arm64 calling convention
    https://git.kernel.org/bpf/bpf-next/c/afdbb4cdd3d2
  - [bpf-next,v4,12/15] bpf, arm64: Move kfunc arguments into the arm64 calling convention
    https://git.kernel.org/bpf/bpf-next/c/e1891a2c6474
  - [bpf-next,v4,13/15] selftests/bpf: Add C tests for by-value arguments up to 16 bytes
    https://git.kernel.org/bpf/bpf-next/c/9b55be31d16d
  - [bpf-next,v4,14/15] selftests/bpf: Add inline-asm tests for by-value arguments
    https://git.kernel.org/bpf/bpf-next/c/a7a97c37c58f
  - [bpf-next,v4,15/15] selftests/bpf: Add tests for by-value kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/4006c4b06c2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


