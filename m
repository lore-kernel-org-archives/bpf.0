Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD4230264;
	Tue,  3 Feb 2026 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087009; cv=none; b=TBR0KZWAcnQ8fVChcPOwbt5cVQYV0s95cgrK0l57ijYL3b/+j485oLc0F2f4N38eSBmBfJSD+jCiUoeg2aS5TooP9K644lV6qnwD5H21idC5BD4Sb8PE82d2rJmMFA6sxEo0MwZNKfuGyBozAU0qnz7YSNP19k80HqFp06dF6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087009; c=relaxed/simple;
	bh=0D+wIw099GKMIZMTSdElTQ3N3JceEAeAz9V0KQ8PQF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Uo/Pq0oV6X9A1WkFuzvHuzGR8AtiBdMwZn7J31AsF9LaXxnW3+xnl426mldvpFf+IeNPelIzV8TXJ8h28+Tn2e99DsK+aWC7U5jbJJp3D1IBClO7wj9p8IyWVrIg/ReWFb5q9maa6cCe0wvZL+/50HVkTPOxIuN/FIXLy2DqpzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8feTv0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8feTv0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28830C116C6;
	Tue,  3 Feb 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087009;
	bh=0D+wIw099GKMIZMTSdElTQ3N3JceEAeAz9V0KQ8PQF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s8feTv0eTr4RKRb3JG8aRkOV0FRA8N9dkFPWG+ousPFynbS7Y4ipKvFmFM42jdWXN
	 kF+MR/6V7h0yKLSqlsbDQVJmWNN4+kcaOxsCcHf738R7xOD/fQwPIvxlU5auBRFWst
	 lPbqVRq4/WjaaunZZfRVrK0B6hjyPUNsM+S3sdXLo2BHtTN1UA5nM6Z6/9RbzRoNhZ
	 q8MhBV5CLwTmPlwgUnUlGniNIhBMRqXfO1GcSnpNREUsIpCvgSeIyuX6WN4k05H2bM
	 ip/WqJ65iHFiycm5qieKSVh/pnTNBSWqs19wtcnHcAJ6N53sxNimXTb8NCi9CcVFaV
	 Edir3Kks0RseQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16D3B3808200;
	Tue,  3 Feb 2026 02:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Replace snprintf("%s",
 ...) with strscpy in parse_{base,module}
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008700563.1287645.10404215786992422378.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 02:50:05 +0000
References: <20260201215247.677121-2-thorsten.blum@linux.dev>
In-Reply-To: <20260201215247.677121-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sun,  1 Feb 2026 22:52:48 +0100 you wrote:
> Replace snprintf("%s", ...) with the faster and more direct strscpy().
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Keep snprintf("%s", ...) in btf_show_name() as suggested by Alexei
> - Update patch title
> - Link to v1: https://lore.kernel.org/lkml/20260201180445.664056-2-thorsten.blum@linux.dev/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Replace snprintf("%s", ...) with strscpy in parse_{base,module}
    https://git.kernel.org/bpf/bpf-next/c/d95d76aa772b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


