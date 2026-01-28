Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575024CEEA
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635812; cv=none; b=ujPtlc8Gvq/aaLBtvW0wrf/DbxTAmKuLBmNJIycdAeBpzcs9qU+3gUbV4V+BSbiVMgptpEKQdZXhJUaSrrZF9RLwoX7iKSH9WFK2ghlsvdmbbNTcmSFt3dL/yTfxAPZJL/TslfiO1ZpVb4ks0IllFZnzD8qBQgQiurg5GO2xCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635812; c=relaxed/simple;
	bh=aVSPxUx0HUXd5zLLrp3i261l2cpRnDwKVv6QhIFSMRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YwqX8nZqrL2N+7Vo+6pqFCFroeH7gNmxpQrrF6BUA/4a5d9dSqO70RcNsyREHeX0p07h9gbaZRGqsE3QR84np5r8OABrQadHOWrvqkmpKdBiYo11vWLJdPbNCORVIocTvg56+kjAbxbyIr18KAEDAxpJt39VXfBP+VXVrNBbAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5SGf2vL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5SGf2vL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A102FC4CEF1;
	Wed, 28 Jan 2026 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769635811;
	bh=aVSPxUx0HUXd5zLLrp3i261l2cpRnDwKVv6QhIFSMRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j5SGf2vL1zkbjqZwekaNaau8PsP+TIcqgYfODdK0n9SdMALTl7O3BAHoUfEtv5hTJ
	 hjqfJvM1W8/M4rkN2T5FDj1f/2Swbu4F3Rwu0zZldy/4MVDmMUmkB1Frk5Ex4WrH5S
	 fP9Y9KZSZaheJEfPcILO7sssyiBoCzjc3VVCV/nKThwEGAl4o/ANtIta/hjftYY/Qf
	 zgYF/33YJQ8jyr7f/tfS9YB0737qQBXGbKtiZH16w2684G8DEXml9ZnTNHr8E3z7bk
	 gDImC2L6+Fepvso5vvQ+g7q59akB5jyOtZM8e9aURagNMhjt3cw7fMJ/mq0RZV/W2b
	 BgNruegQ3xWwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B6F39EF953;
	Wed, 28 Jan 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Remove xxd util dependency
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176963580486.2238533.18301014240768634814.git-patchwork-notify@kernel.org>
Date: Wed, 28 Jan 2026 21:30:04 +0000
References: <20260128190552.242335-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260128190552.242335-1-mykyta.yatsenko5@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 alan.maguire@oracle.com, kpsingh@kernel.org, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 28 Jan 2026 19:05:51 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> The verification signature header generation requires converting a
> binary certificate to a C array. Previously this only worked with
> xxd (part of vim-common package).
> As xxd may not be available on some systems building selftests, it makes
> sense to substitute it with more common utils: hexdump, wc, sed to
> generate equivalent C array output.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Remove xxd util dependency
    https://git.kernel.org/bpf/bpf-next/c/b640d556a2b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


