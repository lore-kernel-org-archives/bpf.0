Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A673B893C;
	Thu, 15 Oct 2026 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083623; cv=none; b=EfD2m62YCrjBduOjByNGM7YjyfRyTb20alXP+0WIeWsJE0M4mXN3r3ePo88/4mfD/HorcJNbMfIxE8tYLVVdcGM147SDSbYdv+6qohWqI71eQ52sV2H1vzRL5Sh+Bh9k9ogCE+10RmA6nU6JLwtRRs1Lg68iGBy8CkDbX0kYoe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083623; c=relaxed/simple;
	bh=w2+R8voRI9UqPtsx+TAQpdzIZOVyF2IevMRYhRoY/4o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B0e9zUhWN8yOs7SStVP7J3qmspJD8krddVMEMlLZMyF3sBfKBYWwJ8hx4TjQzi630psFVJDvLsykECChAa6Vf/Qm06PvurwMFS2sVhzwSEQQU/sX6dkC6JGpvvpJyVynJYMwkDtfN34wcjTutNDguHYdhD6dJiOAnBwkRtI8Glo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXaG3n+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXaG3n+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C62F1F000C4;
	Thu, 15 Oct 2026 17:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792083610;
	bh=7juUMTcRMBD9VR91hqT22QzkRIs4TtHhx9UEK1RzdRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DXaG3n+GNjrU3ckd5fW7nBHnKp+/XKSowc9QFOnu54MrxIN45g5nmAm1UQvjWgLQj
	 T/vcsSs7SKNYo1C2815AUdejC+UxDKhuFqLM2AXR7XMKhkrlYYTH8QrZ6D5YDcdH5X
	 9tVVr5SkvMNRpTjNJY4IQBlAH4oCyRr9L9uDFs5ff9TCndbBiqJIIymd1qXeHBj6qu
	 2UW2e9ezZ/sir6PkqDHmU2LXHxWLYml4nlIsxRY984/wigcZNyySlVrbvrpDZg5LmZ
	 Chv4Tgz2QescW3d6o/FV3xXn2kkplxfYF9yDn1vpMtYOw0lW77cW6qy04plcKLONDt
	 AjzJAg6WycSyQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3FA3808209;
	Thu, 15 Oct 2026 17:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Accept unnamed dma-bufs in the
 dmabuf_iter default test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179208360890.4008483.3208591498200154692.git-patchwork-notify@kernel.org>
Date: Thu, 15 Oct 2026 17:00:08 +0000
References: 
 <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com>
In-Reply-To: 
 <20261009-selftests-bpf-dmabuf-iter-unnamed-v1-1-962ee94f7a5e@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, christian.koenig@amd.com,
 tjmercier@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 09 Oct 2026 09:49:42 +0800 you wrote:
> The dmabuf_collector iterator prints the inode, size, name and exporter
> of every dma-buf in the system on separate lines, with an empty name for
> the buffers that have none. The default_iter subtest parses that output
> and looks for the two buffers it created.
> 
> It requires a name for every buffer, and sscanf() finds none on the
> empty line of an unnamed one. On a system that has such a buffer, like
> one exported by udmabuf without a name, the subtest fails before it gets
> to its own buffers.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Accept unnamed dma-bufs in the dmabuf_iter default test
    https://git.kernel.org/bpf/bpf-next/c/653b8f14fdda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


