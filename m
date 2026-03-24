Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC23738AC75;
	Tue, 24 Mar 2026 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367428; cv=none; b=sZvUPtaRROOJzLXRblsFcsERGjgEXULk+vghhs7eqqwc9uWADjGUWlBlk/NJ8ANQi3GhF8CnjMz4S9eAX8C9tTC2F4RJnZpup/rEPbmZhj6BlbUrc6gT1PcOc2ow7GFWVpHN/9vfmJHen5kudvdnHL8nD1W8eaDQEd4RCFwSVyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367428; c=relaxed/simple;
	bh=IqkMzpEHIc6iVLlpb4odZQma6xmAzrp+uJ9Fuq7k0kM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IazbC18iR31x7V7sB6ybG7ANmWy57/VIaLmdiQhiR/ek5WpxbYln9ECwRLIP/Hvw7GGEqgnmbQJRXOc1sfefjI6+08L5erN5JK7iY8BcyJ8UIDU1Aw1JaeXaaxQMaNYSfTKDd8XtYBCLwv8Wp3RDQIhn+CxEOyso7TSRYw3Rgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hutl12tg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hutl12tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F0CC2BC87;
	Tue, 24 Mar 2026 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774367428;
	bh=IqkMzpEHIc6iVLlpb4odZQma6xmAzrp+uJ9Fuq7k0kM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hutl12tgk7vzBiurLwic82GPAbnpB2prVFLC5cQBSze0AraIx9mvaTCLEpCASwv4g
	 ZzTM9HlQ9DGpotd+jKrPY8FbEiZZdJzuXQpPDAUYPmyvYxijkTYAmqdGu2gtgeDeNa
	 7IQExY5GGELnYviHERN5ClRgjbf3D3axHeno0E+cUIifhwunB99b4kJSseoDVPBU5I
	 lDP60G1P+KPxMwehJIJSTXn7xXL1C7sbo7uXH+4r7QfrhOt65X/ERE2T3qoyZIB4z9
	 CqoG0VsCTqUkIxUG8cHXAZatRf3wRtgs362IIeK0PQztpz+luIeIvi05OTY5griEof
	 krxncH7ND6z0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F743808203;
	Tue, 24 Mar 2026 15:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, btf: switch CONFIG_CFI_CLANG to CONFIG_CFI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177436741631.1084685.10195982723622325517.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 15:50:16 +0000
References: <20260312183818.2721750-1-cmllamas@google.com>
In-Reply-To: <20260312183818.2721750-1-cmllamas@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 samitolvanen@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, kees@kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 12 Mar 2026 18:38:17 +0000 you wrote:
> This was renamed in commit 23ef9d439769 ("kcfi: Rename CONFIG_CFI_CLANG
> to CONFIG_CFI") as it is now a compiler-agnostic option. Using the wrong
> name results in the code getting compiled out. Meaning the CFI failures
> for btf_dtor_kfunc_t would still trigger.
> 
> Fixes: 99fde4d06261 ("bpf, btf: Enforce destructor kfunc type with CFI")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> [...]

Here is the summary with links:
  - bpf, btf: switch CONFIG_CFI_CLANG to CONFIG_CFI
    https://git.kernel.org/bpf/bpf-next/c/9b0cf064ea0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


