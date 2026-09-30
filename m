Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB984C10CA
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770209; cv=none; b=i6a6ES2eYJa/0foRfu+/Gi0U5fSc5sejR9TfAQ2lARvHgkYv3Ey2rcytAmw0hX3UO+TrVlNbR4YU3jY207lE7WZrBQ3bJ9/TfLm3IR3cYlTB84Mm3HMUYXQXJCor9AN0PiGPMu/vXb9km09pYlGRNwZJdRCu2wyzDEDfipn5oPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770209; c=relaxed/simple;
	bh=0G2XnNy5TWIvAwRUonWu0tn6ecsfnVPe0wyr3YEGzvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kyDSpsP3Yi3HiBpVwBYQ5XGeeulqsKPOpF9PANKUqA2qQ1mue5kyEKouTJZ2pYMIRIKDjcsQoNZr4BjUJHUZBqJqmiPONau/5n04jzgBsJnU9UsGJnsRb9InUi3734p6Lzwu7JchFYx6ecD4dgqLclWXmjA3dEj+zknEzXsPhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUG0GOS9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUG0GOS9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F531F000FF;
	Wed, 30 Sep 2026 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770208;
	bh=YLCquVGMC04DwFGGPMqPQdRjMdlnPxaFS7ajJIhWZ0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jUG0GOS9jQox+yw4IQ672Zg24eYYrLaISDmtYBSrQmisLpPytKkqTCQM2t8Bi2noa
	 p4tLpXZ8MwF31/9IRwpzUbumJCrzJfVH8H0/ktR5sH6AR6GDZ0J4gOUvXR3Hh0f+8A
	 QYxk86yLpgsz+hwaVuWni/gsenw5I0Oym8HawqD6l+TTIn1YYbb+fvgnSFKg/ke1tp
	 Cvl505/a6D8v1CPg67sbx9EhA+stugTlfgvU5V2R7w6VhzmMoC+0irGKUwVYl2FMeu
	 ttsC4mEkyGP/HmLfwjDseh9AYRs1KYish9RCKpkdAQGaPdN8BVlJrY1xH9shmlRaoN
	 nv2shRiM9BwqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A35739EAFCE;
	Wed, 30 Sep 2026 12:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/3] Follow ups for verifier errors set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179077020703.1431503.4082387503866963980.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 12:10:07 +0000
References: <20260926133048.2962553-1-memxor@gmail.com>
In-Reply-To: <20260926133048.2962553-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sat, 26 Sep 2026 15:30:42 +0200 you wrote:
> Some follow up changes based on comments from Eduard, Sashiko, and BPF
> CI Bot. See commits for details.
> 
> Patches 1-4 of v3 were applied to bpf-next. This is the remainder,
> rebased on the current bpf-next/master.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/3] selftests/bpf: Test non-sleepable kfunc context
    https://git.kernel.org/bpf/bpf-next/c/8295510622f3
  - [bpf-next,v4,2/3] bpf: Correct Program Structure diagnostic context
    https://git.kernel.org/bpf/bpf-next/c/d91052063bee
  - [bpf-next,v4,3/3] selftests/bpf: Test Program Structure diagnostic context
    https://git.kernel.org/bpf/bpf-next/c/917cfd1ed5ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


