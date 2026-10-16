Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611862D0614;
	Fri, 16 Oct 2026 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170012; cv=none; b=PdP8jtK91faw0gUSKCqSTrkI31Zti7AdaIJbHZlKwzhQkL75xRTYLb6GngUGXAgZpw/aG9PEQUoWGwdLjZByE1eCzKecLB2QIuHsQp3r4YpipvRYQldUgM74pFHdp9Z99X1y08SDNKU5FfVXK8uLcaTubFeEFQ9xWkLHcPdwcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170012; c=relaxed/simple;
	bh=AsFZhgB21QxgMaccGaPIY6BeLC3vaHprBIeC0TEDAmk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p7OGN2NM2BCKVjuEFblhUcfMZwHgJXs0jhjEvzFc1tH7suzq1LLMIeYSa3QMdK+F9SUo20mcdZeucrczNDHZRWzXBZ0O6aFvpnheHbiQjO+a5jZjn8L7F1KWAs2RvRXGP9XMsBmtp7795dDUDBFfIE91IJd5c1aTTBv8TJojyxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq7BaDvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq7BaDvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFD61F000C6;
	Fri, 16 Oct 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170006;
	bh=VmLjeuHdZ9AD3s/Vxb4MAnUdqD9kSYMiZXXClv/vstk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sq7BaDvwXsdyRVCjUnJV8umLptTR/Nk4x3FBZJ+tSyNO4k38J8ATJnkWPKiCDoDQ5
	 O+4FLi4nanJfT/qxzFPmbi8mi3NN2YmZ/Yc45nb5VbBep4BgSGte95febGofyA/x23
	 BQR/WcqsouxWndUhB7uYb84+gdO8GgltsqbhhWq9XLTs+AmkTjuyBBouFFxW06HUK2
	 YgdKYnQlc2/Re4ZVWhnem4UmY4erW10rjjVo0dk0+QxQmJF1TQsnNidoN881iJCl+M
	 po3EFTgl5r+GRI3cVaNoksEj6IFSlQNR1Z6sjKIQJccgiMJOtxSD5GGVSybB+WCir2
	 jMQqLYutWOIzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 25EE1380AA4C;
	Fri, 16 Oct 2026 17:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Allow ksock connect/send calls from
 wq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179217000494.875581.6270942748112870456.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 17:00:04 +0000
References: <20261016133318.33999-1-mahe.tardy@gmail.com>
In-Reply-To: <20261016133318.33999-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com,
 edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org,
 liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com,
 song@kernel.org, netdev@vger.kernel.org, sdf.kernel@gmail.com,
 ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com,
 jiayuan.chen@linux.dev, almagui@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 16 Oct 2026 13:33:17 +0000 you wrote:
> The initial ksock implementation, commit 7ae4eb14c5f9 ("bpf: Add ksock
> kfuncs"), kept LSM checks from the kfunc calls and disallowed
> asynchronous workqueues because worker credentials differ from those of
> the triggering task. However, discussions at Plumbers 2026[^1] revealed
> that bypassing LSM checks for BPF-created sockets could be acceptable.
> 
> This patch allows workqueue use while retaining LSM checks for now,
> paving the way to call bpf_ksock_connect() and bpf_ksock_send() from
> non-sleepable programs, such as tracing programs, in future patches.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v7,1/2] bpf: Allow ksock connect/send calls from wq
    https://git.kernel.org/bpf/bpf-next/c/60bbe76a3f9e
  - [bpf-next,v7,2/2] selftests/bpf: Test ksock connect/send calls from wq
    https://git.kernel.org/bpf/bpf-next/c/242d8416f60c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


