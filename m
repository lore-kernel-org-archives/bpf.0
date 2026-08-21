Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0131F30A9;
	Fri, 21 Aug 2026 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334659; cv=none; b=LXLw1FXp17hZaqT3NhG+3Qs7lWdK2JSxP0ZYX13xoRo/g0vFU+/5oJidvth9aHq6fkX/k5hLUV4u7NYjQc1fi4W5rPmbsECnz/+c48bnZ//7o3sPNSrkqfr5FIKBjr5evgt7HNGMoa/LEmAUjomVobA+ogy5E7GDTlXGjXVqqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334659; c=relaxed/simple;
	bh=XKRTFLNGjNg+Q5zB63OO1erzju/QeHrF6DQxQPwYMpo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U7v8/rEE5TcVCna3CbjVObqaLweOU5AkPavryQgsC/W75mLmLalE+6JQSOsK0BtSn4blApypt7F3wAx0BDEuxqO7CPf6NNPDYkzNQK6ERdmgszd4GiJr/NtS6/AJa70sG4zakRNWSAMXgLXPUjNai6peeqnC+7ejC9ONWCsjf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLEoNzFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLEoNzFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C41F000E9;
	Fri, 21 Aug 2026 17:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787334658;
	bh=U3kHQpcDBmc5tblY2BmIW51zQ/fnQbhpr1EMzMI2r4I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TLEoNzFMMApw3EQdx4bjHowEpi5F/K8RPP3TtMVwcXmIMDE1zlZPwESCwYHIRCk/w
	 Dt3aOVAyhPUjNCc30AwjiTfJ0TqXNVwND2f0xkzZYnWMrDxx48FQLCUhagifih6OBe
	 9c4UUMakPIhN+r1oc7v8Uc/ydcpmB4Go7p7htp7MIqqYEiw24qKkXAiaTkajBEZBIe
	 IVmO3cwVCRKqUVKOGuoPUYC0wha1g0Mao3YFT1+fpZyC/S9q7BEvmZjL875WHucnlX
	 0vLbilKIKtyCwxVwLqDAbhxgJ+xDIK1w0YH6u/Nt8KaaLeKqxofwFt2q5xAk8n+mTH
	 l4hylPF/rAwkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19902380AAFE;
	Fri, 21 Aug 2026 17:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: fix percpu map update indexing with sparse
 CPU
 IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178733460765.1412990.8574022020312732917.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 17:50:07 +0000
References: <20260813155131.1022745-3-sh_def@163.com>
In-Reply-To: <20260813155131.1022745-3-sh_def@163.com>
To: Hui Su <sh_def@163.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, leon.hwang@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 13 Aug 2026 23:51:33 +0800 you wrote:
> Per-CPU array, hash, and cgroup storage map updates without BPF_F_CPU
> or BPF_F_ALL_CPUS use a value buffer whose per-CPU slots are packed in
> possible-CPU order. The buffer is sized as:
> 
>   round_up(value_size, 8) * num_possible_cpus()
> 
> The update paths iterate over possible CPUs, but use the logical CPU ID
> to calculate the source offset:
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: fix percpu map update indexing with sparse CPU IDs
    https://git.kernel.org/bpf/bpf/c/75b0a6db4300

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


