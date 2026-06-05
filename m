Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64323D45C5;
	Fri,  5 Jun 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698622; cv=none; b=FQIELUTmNvElJWawu6d0Zu9CH2j1Of8mcN4cyJ9WEiJkjAHUaFSoBaRadWQzSP/fvbJN7lo9g4mBqy/jQXbjBPZ0fWHsIYKadHl9pW0TQjE1HMf73/X9xfgpKcnEdF5t95Ue4DdJVQvqieFm7EyHEZ8AiqCVYabPkBj5a2sHeUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698622; c=relaxed/simple;
	bh=WbK7lkqzKK6rH8b3uxgFdhD6T2cPT0EX7J/x0ploLoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qyaXzI7eRHZ/Udl0p79diF5b2ApsH7QgTEGkHAMOVTLzwyFyDQaNOwp2rMPQC+GNG3C45TRmzEGxnw0DT5yLWvZgAjwjoX9XrqI3h5gG77uNqnyQFtMB94k45gGDFLsHxRS3fauWLe2yDFRJZAPY5X1k6RB8UciKQf2+etwzeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRpNEoqH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRpNEoqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640C01F00898;
	Fri,  5 Jun 2026 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698621;
	bh=d1FS9jRxbt15zPdczeD3jqROF2JzOH7zVfMIxmBfRbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oRpNEoqHwJR0aIbFlw0Z6jVbqjRW+3aA3rriM/Y5FhdDDqMOxW8qkm1BpVzJuuJFJ
	 n2zVzaz0HmJU++aI0eyjd5gZ0b3zCOCLuj2JPV0zwsPO8EUiwKCWn711qPkmm2Tqs0
	 8t7oWa9ZdI412ucaLNxF4Wf+WvcvE83LEWZNgzvDFRZvkNIjIssoqo3up6IZieWzf5
	 cAbhFizwyU6d0ATp5VqC9e1NgUXwZEneUm0S9AFYDFr9v+IRirqZDMs+o2+pnljwZ0
	 8h8t2U+DmG9v2sJLEgFRlWXo6xBEvP2c6VgRnts8j5A+wbokIQP6wxUazesE2MWqaJ
	 dU4ag2XV1tVOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB73930C04;
	Fri,  5 Jun 2026 22:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] RISC-V JIT support for
 bpf_get_current_task/_btf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178069862138.3943503.16397384527889534334.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 22:30:21 +0000
References: <20260602205847.102825-1-varunrmallya@gmail.com>
In-Reply-To: <20260602205847.102825-1-varunrmallya@gmail.com>
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 bjorn@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 puranjay@kernel.org, menglong8.dong@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 pulehui@huawei.com, alex@ghiti.fr, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jun 2026 02:28:45 +0530 you wrote:
> These two patches add support for the bpf_get_current_task and
> bpf_get_current_task_btf kfuncs in RISC-V JIT and add a selftest.
> 
> The first patch adds support for cpu and feature detection on
> the JIT disassembly helper function as RISC-V JITed code was not
> being disassembled using `LLVMCreateDisasm` as it was missing the
> "+c" CPU feature and JITed code contained RISC-V Compressed (C)
> Extension. This patch generalizes that to detect CPU features and
> enables testing on more RISC-V JIT work ahead.
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: use host CPU features in JIT disassembler
    https://git.kernel.org/bpf/bpf-next/c/557d0cc3f252
  - [bpf-next,2/2] bpf, riscv: inline bpf_get_current_task() and bpf_get_current_task_btf()
    https://git.kernel.org/bpf/bpf-next/c/6d13ddb1d465

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


