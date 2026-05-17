Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF62BE7DC
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981999; cv=none; b=R73gO2GFfM7oWA2+Td/9G3JrFCE3OiDziHLePnMyv2RFMmieJ4izG8yxK1MUHCOBUlPJJMhkfw//F6bGkjJxKqQ4eUXv69Yqdicmxf6gqwID1mCNOuGQ5aa/KzFiUpTydiZfY7AXOl8si+bo/A60W0Ehwzr203qKWKOQ8Dbf8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981999; c=relaxed/simple;
	bh=uiNqer/U7RMiHYK8y+wraEJEYY0Oqr4htsW0fGHT+Ac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fJZh/myxloXle7oHLSvS3bRemJjh98Mz88V9DOLJu6TpW0oaVevVhaRyjXA53AZW1cx+zi3qeDRiDDyOz2qC1xAkIDdRc+6e3K0zAlmZz0ri6dJtJD7doHKwVLVtMFjTB0B3Q0TMMiMXgq1LcIGBwUk7N/2MxQ0wb8voZnNWPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnNzgt1J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnNzgt1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1159CC19425;
	Sun, 17 May 2026 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778981999;
	bh=uiNqer/U7RMiHYK8y+wraEJEYY0Oqr4htsW0fGHT+Ac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TnNzgt1JLEH9TspGK8osOphUrWSJ9Oh0j0fEL+GIxZTGH204iEElaxoSEDbzGKLCi
	 FDKleiSo7IqvHaMQ7aJUuxBNJNFSWLl1fSowf8zZE+iEhFc4mSGNwATIsgLCM0JjCB
	 NBmXIXy8276o2WrniGmn5lp1BXtlD7X+96FSbxHtCQlxpzsvmbZNwFYcTILdmzBN7f
	 AqazdsRfaFgALvO6/1+s5tg6BII9JTumvzWPwki9MmmRZzGFxSOD8CBOouayekSR8C
	 XBx53ZHNeILHqXDvLrcWL1Jancl6c07hFtaI0abXfPFQXbjxSmgLkE0FViJQWKIsAD
	 8HKq49Vzw9/pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A183930AB8;
	Sun, 17 May 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Validate outgoing stack args when
 btf_prepare_func_args fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177898201164.476559.9152177315116491592.git-patchwork-notify@kernel.org>
Date: Sun, 17 May 2026 01:40:11 +0000
References: <20260515014958.1186132-1-yonghong.song@linux.dev>
In-Reply-To: <20260515014958.1186132-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 May 2026 18:49:58 -0700 you wrote:
> btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
> If validation fails (e.g. unsupported pointer type in a static subprog),
> check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
> returns early. For static subprogs, check_func_call() ignores non-EFAULT
> errors and proceeds with the call.
> 
> This causes the callee to read stack arg slots that the caller never
> stored or not initialized, potentially dereferencing NULL caller->stack_arg_regs
> or getting no-initialized value.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Validate outgoing stack args when btf_prepare_func_args fails
    https://git.kernel.org/bpf/bpf-next/c/4286f5deee14
  - [bpf-next,v2,2/2] selftests/bpf: Add test for stack arg read without caller write
    https://git.kernel.org/bpf/bpf-next/c/ef1b54e0db67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


