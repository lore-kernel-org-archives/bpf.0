Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC735AC10;
	Thu, 28 May 2026 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780005607; cv=none; b=A1XPGNS4CxNwmRjIvs0UtQNpY9q7eEDV8pqqFPzc5e4yB/W5hv4tv6iGxeG5+Hb6K1l3Mr3NW/Q0UFV+aDyOIKQYslFdLutymqiO640Bq0DKao26DhJPmoYmH4tJ2Ia/k6CNgcYW5hLJbJjPN7d+U31bZok0ZhkLzkKn2LD1tSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780005607; c=relaxed/simple;
	bh=NaSi0KO2WKPH5qB9TMgttwsLz6NFojQRwDGr44o+DTA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X+8GWWclsxFLIbIhU4v70i1ovbwvgg4+TGwEdDGDkWFQHnzBt+bBVO4QNI0OUCHwNmdPiP8lA/qRt4N6ODmMcomaeEjpGJLuC7U7RftOifNmBuCPmmSBB9DUIObuTsvG9AX6rcTbO44bet+CvoemDDVR9l1ZAh0B5brXfxWeMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUr6YH14; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUr6YH14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B996C1F000E9;
	Thu, 28 May 2026 22:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780005605;
	bh=ECCwGiXtZqa8afeCgRpnd/BFCMBUdEcCK4bsM/hZNV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cUr6YH14MDBSybViWy8eZnLDxyji7BYhv23utmcuGbx/TfInbyKWZE44TF50Tcw74
	 Navv08n/PdbYlsivqTClJizBpXpSSvtq4sm2Xu2pd7uwbx41YVbkyAzFU3AxGOFttW
	 frDWY7XX2aR9sIuve7BEl/Y7P6fkwKhn8PIrIkJ+NKx5mZ8hSghFeUUgZsvspqQmTH
	 9WSqcT9xwKguMeMWvlbpLAWyfc6mEsoo1IZQ9qgl/HL5G0+Ncor3sJfAhm9YwISNs4
	 fll2E+nY9nPLynD11F5hk3ejc5wJBoOrwd5ceg+xtQuezs5/jOPMj600TVMoyVvv3k
	 vguq/AGbLwBtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 26C533811977;
	Thu, 28 May 2026 22:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 0/3] bpf: Implement
 stack_map_get_build_id_offset_sleepable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000560988.1528587.15711081709424255341.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 22:00:09 +0000
References: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260525223948.1920986-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, puranjay@kernel.org,
 shakeel.butt@linux.dev, mykyta.yatsenko5@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 25 May 2026 15:39:45 -0700 you wrote:
> The series introduces stack_map_get_build_id_offset_sleepable(),
> fixing a gap with parsing build_id in sleepable context in stackmap.c
> 
> In particular, this fixes a deadlock in
> stack_map_get_build_id_offset() doing a blocking __kernel_read(),
> which happens since commit 777a8560fd29 ("lib/buildid: use
> __kernel_read() for sleepable context").
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/3] bpf: Factor out stack_map build ID helpers
    https://git.kernel.org/bpf/bpf-next/c/fc99547a8bda
  - [bpf-next,v7,2/3] bpf: Avoid faultable build ID reads under mm locks
    https://git.kernel.org/bpf/bpf-next/c/fad3021faf7b
  - [bpf-next,v7,3/3] bpf: Cache build IDs in sleepable stackmap path
    https://git.kernel.org/bpf/bpf-next/c/5e9099d8ff24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


