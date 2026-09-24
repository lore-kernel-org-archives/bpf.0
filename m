Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C442047A;
	Thu, 24 Sep 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790284885; cv=none; b=Oli7H+WO7M7tautR+ovMKj7JVMbS6j6J8SYyvqddU5XDspjzzsO16eZavOVm4Vn/uI3pJTNjQ1IusF+BViAFLsIBWXMH5l/Md/TMLojx3ECaZVIZlpkiyeznuq+d4ULw8fdaHwGdVNPuqTXwoxXLsKYASQGfSVjKe/qjLtjOIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790284885; c=relaxed/simple;
	bh=E4vnPMcsjfacyNqdX3Sc9xQmR4CnK+PuCT1z6dKrBUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bLskkp+FM1dtGN4umbeh/2KnRFca4Yow/oWZ0Yro3bhtDm66YGetU/1sZ8RdKs0dV4GRcvNEMY41sONIoP6m1fQlJLDQgYEITWspisA5u5s6x5R+d8ZVb/SgbslycsvVhcpuiwwDmuT7HPuWCGYr2vDFzj4TAigpAWKM1jFqG2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkJhz95z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkJhz95z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D401F000FF;
	Thu, 24 Sep 2026 21:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790284878;
	bh=e7hd29C7nTRYc9eXkSyQm0MxhkxGCpQvPC9QXmvN0oU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TkJhz95zxkKty0LOPt6/7S5vUhHowVYO3n7a1ziy+/0l7WqIlhtWz8ou3tFNU4aWS
	 0aAZt2xuzx0vZ8zgs7XJG8vQ0tSqXIrLjq6kHVflA7H/sTcu3Xf0nHjC8YcSembNFh
	 ewH0ccAj1VxaTQNQAI56bpfyh6VWsjN0ZbAxorVqEJtB2Q7DrOdShi2mzkbpCJUU3b
	 BgbXvY049ePnvWDjj8ve2HYVs507TbyyUkml/ASiX2eiyT8KktjJvBwCwyVIih1ura
	 QC4X6MpPcLkmHiq0ZLFqr4Lc3e34nLYb/1LsK7jkL55q0hMHC43kkZ4obmWeOurW+d
	 c0SK7gD6S8Vhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FB3A566E5;
	Thu, 24 Sep 2026 21:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/3] bpf: expose cgroup preorder attachment
 state
 to userspace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179028480739.2205957.18056987431035408437.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 21:20:07 +0000
References: <20260922025442.3176057-1-sh_def@163.com>
In-Reply-To: <20260922025442.3176057-1-sh_def@163.com>
To: Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 yonghong.song@linux.dev, qmo@kernel.org, martin.lau@linux.dev,
 song@kernel.org, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 22 Sep 2026 11:54:39 +0900 you wrote:
> The BPF_F_PREORDER attach flag changes the ordering of programs in the
> effective cgroup program array, but BPF_PROG_QUERY did not report the
> per-program flag. This series exposes that state and updates bpftool to
> display, accept, and document this flag.
> 
> The series is split into three patches:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
    https://git.kernel.org/bpf/bpf-next/c/9ed640ee09ab
  - [bpf-next,v3,2/3] selftests/bpf: Test querying BPF_F_PREORDER cgroup attachments
    https://git.kernel.org/bpf/bpf-next/c/47211d1200f0
  - [bpf-next,v3,3/3] bpftool: Add support for BPF_F_PREORDER cgroup attach flag
    https://git.kernel.org/bpf/bpf-next/c/c39bf6b6705f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


