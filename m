Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFDE29C325
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230831; cv=none; b=uUMMtwWBzBeHiIobhGbmsAc9v1q6uTiA1m0rvPxuwenRj8Bx0utSoKsS2k8eUjcID8v5fJSD5fqVPsSSlaHlIqRztEXU+zuwXS8rzqeOHdTDYIwOJWmFhzDo9RHIwFyMjRUiOIlG7ML2N+KbMrcgNXm4HRJpVRq1LhEmlIqbHTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230831; c=relaxed/simple;
	bh=igSWFEgh1Qk6QOK22oJFxfQDRrByBrf8QqZhU4BkkbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bAX3JdP0nOwDmzcWZkC2mJ1gxh5g0BMxJEZ28ADTMPSAFayXeYuc6ldWLGyeaYNRDxJ+S97iLCqJO/7aVZZPbuJXvW8mLHRuMbOiYRIfLFRS8EmN096igaXSFQNJcAFwag6U40QC5WRYi0FVnwdeocGthvGZ4cHLqCv6fZrlJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djZjCllG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djZjCllG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A11DC4CEF7;
	Fri,  3 Apr 2026 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775230831;
	bh=igSWFEgh1Qk6QOK22oJFxfQDRrByBrf8QqZhU4BkkbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=djZjCllGF7GDdlPJ0D2W/jbVh9oWWyHuHBNbH/G0yCGfQwBr89qcG+7AEvQur4jCL
	 /Xe16WEN2+Nb2cmXTMSoHvH8hxGbIH1THsfMtxxeNn0zPGHPqD0NCGLGu6DN1dAn1P
	 86vmtJDtGVwCremT0oGfXYZTwnM7Ifi5Z/O7xJHrDe1GYPHkTI/Op3n1YCWdPaCuut
	 zkbWtIqH9UADxxLW06eLrIJr1QRh8zHRDHswh25Iviebb9iIg+l/E2DLUtcxeI6l8i
	 YLUqcnsrgcsxwW6eZzJHDfI+eu6zFvmrvc+wyuN7D2SQhmI5vq89MRGFVGsR/ljo4b
	 i6t/N+PQwIc7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC23809A13;
	Fri,  3 Apr 2026 15:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 bpf-next 0/6] bpf: Prep patches for static stack
 liveness.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177523081304.1353112.8083004739879504994.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 15:40:13 +0000
References: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260403024422.87231-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  2 Apr 2026 19:44:15 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> v4->v5:
> - minor test fixup
> 
> v3->v4:
> - fixed invalid recursion detection when calback is called multiple times
> 
> [...]

Here is the summary with links:
  - [v5,bpf-next,1/6] bpf: Do register range validation early
    https://git.kernel.org/bpf/bpf-next/c/503d21ef8eac
  - [v5,bpf-next,2/6] bpf: Sort subprogs in topological order after check_cfg()
    https://git.kernel.org/bpf/bpf-next/c/e6898ec751e4
  - [v5,bpf-next,3/6] selftests/bpf: Add tests for subprog topological ordering
    https://git.kernel.org/bpf/bpf-next/c/427c07ddb9e6
  - [v5,bpf-next,4/6] bpf: Add bpf_compute_const_regs() and bpf_prune_dead_branches() passes
    https://git.kernel.org/bpf/bpf-next/c/f1606dd0ac49
  - [v5,bpf-next,5/6] bpf: Move verifier helpers to header
    https://git.kernel.org/bpf/bpf-next/c/19dbb1347481
  - [v5,bpf-next,6/6] bpf: Add helper and kfunc stack access size resolution
    https://git.kernel.org/bpf/bpf-next/c/1a1cadbd5d50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


