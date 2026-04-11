Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C91862
	for <bpf@vger.kernel.org>; Sat, 11 Apr 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775946632; cv=none; b=aNV1Wcka5uHXJj6N42iBpSjhiLSSaQAO65kvc8lxEMWnBU6MAq906gUz1sOTrKy/UPiZHteugLjXO62hxW6nAK196gkfD7o8oaLCqHwIRF5/J6Pqw7bDUpvPptgePQTbcrTlyqWsP3rDLWGOLZB91ECOmVs6+PDALPqtanSAFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775946632; c=relaxed/simple;
	bh=7EBbxRVWUBscX/hP5Qdg6SZUHTz+7i+ZrlYM4RMbnG8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T7g+MxIAVVSG2Q8J9WpF/YPg8sg0peKT2b6EKFSxuLo+mHLbR1k9fp/ZAntDQNM1LA+ZeqMEt+SZtEupuGbpiU60Zh8i0DBIg0yc9hQZNdW6Aj6RMRkGXneFqR76Mkiso1oyJkPWfBrvhCAGDjAAHvZB/JcPIIkyyWgH6zLyRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYbHCyvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYbHCyvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C337C116C6;
	Sat, 11 Apr 2026 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775946632;
	bh=7EBbxRVWUBscX/hP5Qdg6SZUHTz+7i+ZrlYM4RMbnG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FYbHCyvYY5cLDDgEkCnr3WUgdt6no0iYT3I195/KmNB/QueODDzraevRRNjDgP80U
	 k2zVj+NbwfAOkyp4Kk6D98KoQAsLyA9QktakzEeF8EXTja+TNNMT1SbzuS7uIKPmbR
	 mjuplc8IbdqRcrAL9DdMZoWoggKpbxq/2+tYJJvtHWlAGJEv5hvvP0wV+UWNQGsS2Y
	 /CYwfzFpY1KMq2pQ7sMz9b7BhNWb5Fm/Pe6bnTVaLkgaz8LknyeHIHUj3qpVFbo/6h
	 lHJCICkvqpf7432FHqPYMj7CE49Imc3x+3R9SkLMR8yCs9vMSl7C3WsYwVeVdnDira
	 JRYbkef0clD/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F6A3809A8B;
	Sat, 11 Apr 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] bpf: Move checks for reserved fields out of
 the
 main pass
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177594660555.3095471.7373724267533935590.git-patchwork-notify@kernel.org>
Date: Sat, 11 Apr 2026 22:30:05 +0000
References: <20260411200932.41797-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20260411200932.41797-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 11 Apr 2026 13:09:32 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Check reserved fields of each insn once in a prepass
> instead of repeatedly rechecking them during the main verifier pass.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] bpf: Move checks for reserved fields out of the main pass
    https://git.kernel.org/bpf/bpf-next/c/ae3f8ca2ba50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


