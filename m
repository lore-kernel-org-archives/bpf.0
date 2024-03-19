Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF74C626
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710885029; cv=none; b=ruSziDGHDDjUehAiRk1guoRudbh7hoQh4IssFrKr4TW44+YRSzMt6BKafmOqqjp4IWiPK66APo67hH8+kuF/f5Dvj10TomPWigTva1mEW7okqPgGDT0DW0Jq4qalZQVQd9OyviGZufyWFa05dJAu1tTsQZCvGoS4BnaLaBG1/kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710885029; c=relaxed/simple;
	bh=1vGit7iOe38MtQtl1UjZ9OK9wvRMZ1vosPYsFPTPWsU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pj8aYcsFsHzzcARzbe8IY3Pz0rELraFXVFtCm43N78FA9Nfngo5P+9/fhWSvHJO1QuZfW1sS4c6teLLWpQqpI/84JbL97cVcnz/EFHlLhI4zZgFamZTClTJpURmKuDZnRCu/r3iBMgVXCugy5CWNDnfNXdl3n4702Jx1TltVVkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz8Uej3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz8Uej3l"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF57C433C7;
	Tue, 19 Mar 2024 21:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710885029;
	bh=1vGit7iOe38MtQtl1UjZ9OK9wvRMZ1vosPYsFPTPWsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bz8Uej3lfjuW2xt5zLIYNraCf8hDpp6rky1UJBcvvdeZyHRXbjS8hD7e+4nPIWJY3
	 7mhi2ZWBCBg/rKO5DGJUAldqn2IAkRnvtDj+L8/6E8MY9xMujZW2h1gMd5/T+Q+V2l
	 wnGBDSiQWxRaodcmXunC12MetkRrLHV5Dr6lcdNs/EoH1yF29IfrsLbZrCO3jL/BX2
	 d5LZsqkibjQG2d1aj6ww4ksj7u97TYkynlu3eIQ9gZ3mSr5rbwSHDwSxREDecpceHj
	 ihfN5T4o1aAGDPx+4MsDbGM93mgUSOwAYIw+IUOJMcnI0aiuG/Oydvj1aVrr1cXHgY
	 ah1JxmJPztLAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 293B7D84BA6;
	Tue, 19 Mar 2024 21:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] bpf: Allow helper
 bpf_get_[ns_]current_pid_tgid() for all prog types
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171088502916.8654.5854109927706479675.git-patchwork-notify@kernel.org>
Date: Tue, 19 Mar 2024 21:50:29 +0000
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
In-Reply-To: <20240315184849.2974556-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, kernel-team@fb.com,
 martin.lau@kernel.org, ynamgung@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 15 Mar 2024 11:48:49 -0700 you wrote:
> Currently bpf_get_current_pid_tgid() is allowed in tracing, cgroup
> and sk_msg progs while bpf_get_ns_current_pid_tgid() is only allowed
> in tracing progs.
> 
> We have an internal use case where for an application running
> in a container (with pid namespace), user wants to get
> the pid associated with the pid namespace in a cgroup bpf
> program. Besides cgroup, the only prog type, supporting
> bpf_get_current_pid_tgid() but not bpf_get_ns_current_pid_tgid(),
> is sk_msg.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] bpf: Allow helper bpf_get_[ns_]current_pid_tgid() for all prog types
    https://git.kernel.org/bpf/bpf-next/c/eb166e522c77
  - [bpf-next,v2,2/5] selftests/bpf: Replace CHECK with ASSERT_* in ns_current_pid_tgid test
    https://git.kernel.org/bpf/bpf-next/c/84239a24d101
  - [bpf-next,v2,3/5] selftests/bpf: Refactor out some functions in ns_current_pid_tgid test
    https://git.kernel.org/bpf/bpf-next/c/4d4bd29e363c
  - [bpf-next,v2,4/5] selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test
    https://git.kernel.org/bpf/bpf-next/c/87ade6cd859e
  - [bpf-next,v2,5/5] selftests/bpf: Add a sk_msg prog bpf_get_ns_current_pid_tgid() test
    https://git.kernel.org/bpf/bpf-next/c/4c195ee4865d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


