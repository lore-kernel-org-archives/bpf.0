Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7CC367F4D;
	Fri, 29 May 2026 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780023603; cv=none; b=QkA/+ZEPOaUti+b91D3W+UL3uLR05NYDQKH+2vyy7SlPO+c3eVuckTHOVRN+xJT4OKPT+ATaINdoSHZtIyWv2wKxWb8Ea5nxZAW9L1IvtpkztiNxeBN0HDKv5WoSSpiRiM1zIdt3l2aJet+BvXXItDJ1vIJXflurv8L9Uf5ryCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780023603; c=relaxed/simple;
	bh=fjJCo/0DY3jR+O6dJWDFVvBlJTjgwAFKovCUPiDzo6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S0pl2N5ZqtweBU5fgwvceT9aGfjDAKupZU9RKnHyhRCtL+PvPHPVBFmR37HaOrunssFlfLlP7u6An2ThbDOQaycBjKdEdzEy+5hJbvDv8ZuiGmIPS8H9vuEByqDAzXtaK1diZ7hROPXxwS7mkhdAebP5q7xbBIe+qkBEjteaVgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km9ET9M9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km9ET9M9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DD51F000E9;
	Fri, 29 May 2026 03:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780023602;
	bh=XYlzvqm85Rbq77lq4XnpB2ASnVX4qZQ6n9atg2WJw2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=km9ET9M9/KUAvqV+uHXjw0Bpae87dAEvq6Ibn/aHTa16XnpfDVaY5J4ef1MrVUuND
	 Pqa3OGwMCqFHCUf+A5PM1FdbZmekAFUL0Ccwcja/tvOs80oZmueG2bASOzw+/N0vRC
	 WVbS9QvVzGgGLTUyN2DpiMkEu9O08hmTDivmo2Ol31xQehJuUPVf/Vx5W4CUY9PjPb
	 bafZFXf0/snCVAvoZ5B/uYBym9cEMMonUJtysoSbdLOVTiDP2fDwi9dd/apgIm4UoD
	 teAq/LVGj4GZzbdzFUXvEoJqRcoS2obaV9PVTxCgwi2HolmmKMNldiZPFDov6awOqo
	 BZcarVL8HJclQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395C3930002;
	Fri, 29 May 2026 03:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: Fix concurrent regression in
 map_create()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178002360615.1609362.7462519212273516752.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 03:00:06 +0000
References: <20260521142909.95818-1-leon.hwang@linux.dev>
In-Reply-To: <20260521142909.95818-1-leon.hwang@linux.dev>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 21 May 2026 22:29:09 +0800 you wrote:
> Because there is time gap between bpf_map_new_fd() and close_fd(), a
> concurrent thread is able to close the new fd and opens a new, unrelated
> file with the exact same fd number. Thereafter, this close_fd() might
> inadvertently close the unrelated file.
> 
> To avoid such regression, do finalize log before security_bpf_map_create().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: Fix concurrent regression in map_create()
    https://git.kernel.org/bpf/bpf-next/c/9b435d23f51e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


