Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89D435A9D;
	Mon,  6 Jul 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377033; cv=none; b=H8tpqJxDzYig56G2hmqeZ/14FE13ftb0rAk8aO05593Raqiz7k7OioxYWFtaL7242ul04GMT0lX5xwX6rUUJnBw/A8BhYzzYmtJv2WZ8z3hhpZI2uHPUN2b7HZc3tiPA1ys3OKp8PeR+9hjyhpxlc6n1aXgunJ8xh1YdfCja0aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377033; c=relaxed/simple;
	bh=pg1KdjC7KN8egiZ64ccRdme3lxbX53Hh0wpG6x1YP4A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c96k0U9xgEg/tsmCNzPDkIAlsrhpprJlodVR+V9D6awb6ooQTcMJs397k2xCfk823De+E0evLuE0G8qIL/T7k1iOCM1RG1RQ8piRSD/iqAPnrRZANOmIB9NgP5H5oP5pp9pqw2f6Xk0hM0UffhsZt65oftf5QZOzxlhDKO7iLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmm49OD2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmm49OD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4EA1F00A3A;
	Mon,  6 Jul 2026 22:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783377031;
	bh=PHlbfT9SIM02HI3ZomSlPWh0SsR5wNbcsbXv7XHIqIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cmm49OD2TfRPGQWUG0uxjBBvWvd5pEwwC6iAKtTOXag7mFGpwqNPUucYi0xzL5KEk
	 UAjU/0JrLM/vlI7eckuWE6vfZ7CiMPPXM2jQOc/quK+LX3dVnQWRV+DCukUqah+fXt
	 mIhHdBIXE+jVpP2ABoJnZFfAArnoP1AsnXRGRoJBeVA9ZFiPjJlEqGACpn8pVffphD
	 G4wmrPhfHQz3Bym8Jxo05JXx+7uBdoWOt7t7brvBDoI29YxW3Z0bbIxdWFeD+TPfSO
	 Rkbi029kgfJB6xWZLsF7l8v0VziR0HOWUGnldcODI7ivF9OqQJHcSF8a08sDlnRzQN
	 u2Zmzjd80gvDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0A3925F73;
	Mon,  6 Jul 2026 22:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] docs/bpf: Document BPF_STRICT_BUILD=0 to tolerate test
 build failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178337701189.1232545.1878877150316891466.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 22:30:11 +0000
References: <20260706-b4-bpf_strict_build_docs-v1-1-5324d605c7b0@suse.com>
In-Reply-To: <20260706-b4-bpf_strict_build_docs-v1-1-5324d605c7b0@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 corbet@lwn.net, skhan@linuxfoundation.org, bpf@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Mon, 06 Jul 2026 12:28:43 -0300 you wrote:
> When the kernel config does not fully match the BPF selftest config
> fragment, some tests may fail to compile. BPF_STRICT_BUILD (defaulting to
> 1) makes any such failure fatal. Mention the option so that developers are
> aware they can set it to 0 to skip broken tests and keep the build going,
> which is particularly useful during bringup or when testing on constrained
> (e.g. distribution) configurations.
> 
> [...]

Here is the summary with links:
  - docs/bpf: Document BPF_STRICT_BUILD=0 to tolerate test build failures
    https://git.kernel.org/bpf/bpf-next/c/575d4e50192d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


