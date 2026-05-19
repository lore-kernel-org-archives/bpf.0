Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFC27E05F
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 02:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156599; cv=none; b=g7zqFFnIE96USFdQXTyuB4TU2BV/qjiJXWWWoulORg0msDirHUpWJl86MXiC6s3ZjEIeVu3Lj3QmVEzlkVgdDRBkiGpcgXAvr9zYavA3AVlyZnS7J4aKodZ5PtxovjKIXH/4EU1hFlVj0e85KneDhnezQjWTXlp1z0KkFivz4Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156599; c=relaxed/simple;
	bh=yvEWx6Dn3sfOUL4r8F44M0KjIsxErvh+HWfh6FmMxyk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mQNAiVD6rJiqjqzB49N6FNb1qajrbqizezZN99U2d+z9dPKKt2cujwVaeKs3ckoqx9SlTI/cC8qoXnJPLr/Gnne3MxFxYsRvS3477Z3AGjbIQG7DYVRdfbFtqSjB7bE7JQhgxi00jnS4pdPcciA8hwR4HWQY/56SeZ0qw1SjrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdDn7l9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdDn7l9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC97C2BCB7;
	Tue, 19 May 2026 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156599;
	bh=yvEWx6Dn3sfOUL4r8F44M0KjIsxErvh+HWfh6FmMxyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IdDn7l9CkbHt3Oq405XbIdLpbNA3ErICJV/jbqeRO1L1OqRudI22wGDvCTEwrHbK7
	 6U+j7G61Pble9gPV9M5DuLtfjNHkTdjTzxDqM/8KtyWtPRhlVx2SqDHpbLSabfdOUo
	 US/n0u+u4/7AFAZ2KrcO7+A2K8uZo3cu60yDXV24ofxTodYzV+bonKpdzcCsUWbqbD
	 qbPJsRDuRbIxSYI4OyX8SZnvdxdP+isnuI5gMRt6oKc4ruaVmKDaL5KcdDPZs1lqfZ
	 1Kpwg03JYvk3vkulenmTzKVt94hccpZIw2G9igtERlWqSFggMHID2hkCVFEIjCqu3A
	 Z2I/w7AgbCIwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1972D3930D10;
	Tue, 19 May 2026 02:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for static
 builds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177915661064.2054007.6892451454809138533.git-patchwork-notify@kernel.org>
Date: Tue, 19 May 2026 02:10:10 +0000
References: 
 <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
In-Reply-To: 
 <714556da329c812988010ffe53173d9152570a78.1778669303.git.paul.chaignon@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 alexis.lothore@bootlin.com, qmo@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 13 May 2026 13:24:37 +0200 you wrote:
> When running vmtest.sh with static linking, the bpftool_map_access
> selftests fail. These selftests are calling the bpftool binary in
> tools/sbin/ directly, which results in the following error:
> 
>     error while loading shared libraries: libLLVM.so.21.1:
>       cannot open shared object file: No such file or directory
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Override EXTRA_LDFLAGS for static builds
    https://git.kernel.org/bpf/bpf-next/c/879daba303f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


