Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AD3C3BFD
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 20:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629037; cv=none; b=tqmEZPX8G66mx9EO2G57TWV4A8fLZNsF9ogLz24sSnAOo5pM6eVK4dAcc+UqGQkxPYImXiw39ZOknmCPFvfdoJkOFx7e/2q+rcuU0dxnbXmZNByT+Naj0kCtBWICNSd/+jvTFt0aoMuzKgrAQ6Ds2y3VI0QmOSu4KPUNPnbpbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629037; c=relaxed/simple;
	bh=1BPzjQRvGjXNpUMiUqcTPepMZ8ujlQZgM7PPNAeFn5o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oS8eKmzmsJtbwVMKssR61kn9WNnmbAQaF+HtvbyXBpUJLdj9/W9igWiIy1c5nI2onlBc9Zp6RvRUAAO4KKdQirjiYHWRdIjDwB2D0Z02+ylSnwNUeGkVgDKsbd5M9aA1VL6RatdHTDFa+JTdXR1NN0sF6YXrTnHHLE7nfd8lrl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcnEggTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcnEggTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A32B1F000E9;
	Thu,  9 Jul 2026 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629030;
	bh=VvaaQv+9cq18MAa4xxp1a85mgo/whe1/4Jai19VpSbM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lcnEggTu63LXK5rLvqY+i8ERKLdy02qLKpb+f3tC1vNoVyEm5KBiMNyL95cmMsU1W
	 uPU9y/f2VzV2GLBmgiiJZSrdhts8Y9NsLuE2K8OLu/dsMQILGlPARBP1I55Emf1bll
	 2eF3VtnEH+26ULmyPrstbm02toQ8mrQu3YFmkHs/J25VwR5g7gFw0OT4xjjBt9XHxI
	 kBhnoh0mA5C76XYT9RfLBH0qJ2FDkUXSoYaCDwMyk36QJJokfJEi8lNqUvYddN8bvy
	 ih9umqsXMEtfdykI1sb9+43G45b//v/8SJhadv8SHZUAct9iKpKoFdVUCW3LS7kfCr
	 SFk5bslLEhtWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19AB63924FE2;
	Thu,  9 Jul 2026 20:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: bound rdonly/rdwr_buf_size kfunc
 return
 size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178362900864.4110346.1795099751428880992.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 20:30:08 +0000
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
In-Reply-To: <20260709155837.1879230-1-main.kalliope@gmail.com>
To: Nicholas Dudar <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu,  9 Jul 2026 11:58:35 -0400 you wrote:
> check_kfunc_args() stores a kfunc's rdonly_buf_size/rdwr_buf_size
> argument into a u64 that check_kfunc_call() later narrows into the
> returned register's u32 mem_size, so a value above U32_MAX truncates
> instead of being rejected. Fix it and add a selftest for coverage.
> 
> Changelog:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max
    https://git.kernel.org/bpf/bpf-next/c/2aaf67f0516f
  - [bpf-next,v2,2/2] selftests/bpf: add test for oversized rdonly/rdwr_buf_size kfunc argument
    https://git.kernel.org/bpf/bpf-next/c/12556c319832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


