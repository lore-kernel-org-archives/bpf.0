Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2F35E925
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776891654; cv=none; b=WJm7SQuJTF8xuRZoXee2BwtjCRqNVDiBnYS1H39AcGyfid1xJuhad72W5mpUuEGZy0QfOfLDZEp7Oc6PS5L9j9MT3o7QFizPTtfPjxjJf384RKjnwdBodQi0FZ9kqPAJxFWBCsF8ZP/2SnWhYJ6Ll+2DQC2MzX9bQVbUZxNEeB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776891654; c=relaxed/simple;
	bh=RplETUdxM96ZAjUf/e+pRg7oQEhnt1ARSKgvL5fbKWU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHjxvKjf1p3qgAy6a9n7cfuU5/yNwL8kU/22MkUeA9dKg8dA24/7Xm75xeW02Wcf9RRreOtmNzKnTcFD4OORk0weKUhd8CnZXIaLv8mrKmE8vUxBKRM32I9AWVj0UB2UH3y2xO9njFsETDQkrMc17jjXBhXYwJXcOtdW2YNNOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIIOi5vM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIIOi5vM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D35BC19425;
	Wed, 22 Apr 2026 21:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776891654;
	bh=RplETUdxM96ZAjUf/e+pRg7oQEhnt1ARSKgvL5fbKWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fIIOi5vM+qEvOfFsWmpI3sJHyGLNHzP6dlSvpFzDf268L0uVps5xHFTqz+14OYRq2
	 G46uuxOZ5sxLmm4hDrU6yrBys1ofuO004GKdvb0+tjM61UrnCdepu652zqfQENH/zX
	 DLqu2gnd/lKxB2n/esxvlqqQ5uuhZ3XtETKks+djPbFaXCrudN+V6LgI4TN68kJcF4
	 ywe3rUSWJHKZtfntlv3D0sHeTn8uEUgefxbS0882Ud1faRkIi+XezuXQrhCM1SfYQK
	 UG6yeBvG3zfOiiv5UF0AhNtVh30rpwQ+t9Akmle8IoHPjvcv5HyE0uuZ0rxAT72/yb
	 rFeHqc6iLP5bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE693809A84;
	Wed, 22 Apr 2026 21:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v13 0/6] bpf: Add support for sleepable
 tracepoint
 programs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177689161630.4034798.5996538156641439944.git-patchwork-notify@kernel.org>
Date: Wed, 22 Apr 2026 21:00:16 +0000
References: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
In-Reply-To: <20260422-sleepable_tracepoints-v13-0-99005dff21ef@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org,
 rostedt@goodmis.org, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed, 22 Apr 2026 12:41:05 -0700 you wrote:
> This series adds support for sleepable BPF programs attached to raw
> tracepoints (tp_btf, raw_tp) and classic tracepoints (tp).
> The motivation is to allow BPF programs on syscall
> tracepoints to use sleepable helpers such as bpf_copy_from_user(),
> enabling reliable user memory reads that can page-fault.
> 
> This series removes restriction for faultable tracepoints:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v13,1/6] bpf: Add sleepable support for raw tracepoint programs
    https://git.kernel.org/bpf/bpf-next/c/439ebd5b5708
  - [bpf-next,v13,2/6] bpf: Add bpf_prog_run_array_sleepable()
    https://git.kernel.org/bpf/bpf-next/c/12628ffaf98b
  - [bpf-next,v13,3/6] bpf: Add sleepable support for classic tracepoint programs
    https://git.kernel.org/bpf/bpf-next/c/57918341dd19
  - [bpf-next,v13,4/6] bpf: Verifier support for sleepable tracepoint programs
    https://git.kernel.org/bpf/bpf-next/c/8cfb77d30920
  - [bpf-next,v13,5/6] libbpf: Add section handlers for sleepable tracepoints
    https://git.kernel.org/bpf/bpf-next/c/0cd420a6f40c
  - [bpf-next,v13,6/6] selftests/bpf: Add tests for sleepable tracepoint programs
    https://git.kernel.org/bpf/bpf-next/c/8a20655749c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


