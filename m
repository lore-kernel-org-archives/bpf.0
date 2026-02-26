Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5939444CAFB;
	Thu, 26 Feb 2026 19:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134214; cv=none; b=jpRgxsYSFaiXHN/CK/k0yiNerqKoKSItbyXpSEg72dlzQdfGhwFL0gD6qVY757J/0tqJomoZmlXodVmJRS77QoitBO4T/cdJ4u0uDPAURU8kkHU9W0QZY6RkL9pXAtUNRP02UeS2RkclYXvjtj4UWSbExg/szAVPJsMQFOFxFds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134214; c=relaxed/simple;
	bh=1KYBtTG6rzJ8bZY2BxE4MBt5Dq5M6oM4Lqgm75y+Yrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cMjKBZVhzPMurwziJPBEvH4a9ZHuL7bMMCv93Epqaw9DLQIYDpsRhkBNvG1Z9o//AnZzmieh1A1Gl9BMdzBXS9Pm5kOabpUfcUtI0P0CNPL8qdqK2B7geadIWeLSbrcjuwlRGZWsma+OIAhvXi/RHH8F3PLLLL9LxZTjKbd4G7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8a0S42g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8a0S42g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8649C116C6;
	Thu, 26 Feb 2026 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134213;
	bh=1KYBtTG6rzJ8bZY2BxE4MBt5Dq5M6oM4Lqgm75y+Yrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s8a0S42gqNaRp7a0PkAdyelhbaNL9vT3+cn7YQmkXxrFL4rxWE7Y/5w7xrsXN/X/f
	 UL3cmbEXcMbTcpXPXq4yP8LnULUP7eUnQmyIG8DpDht/XjZ9vfv0GPnW3EM6EpwX/m
	 cAfTRRyetK5NmzSWkXh/Sln8Baf0p1mMQBj7Yuo/+HKOZxpwJs445AzrVLit3dj4+c
	 r10whtfruTVwSol+hXsb0uC/gVjrsiv2bwbYFOL6j3jwu6r1NukcqeAYX+wFIKgqSo
	 7XK6hIiEK40SkeI1nTrWFQ8N8744G+ocwZLE+X4sscvGc4mZdLatM/0i60IXe3WA6j
	 AM1iPg7P7Nwvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1C03931090;
	Thu, 26 Feb 2026 19:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Fix OOB read in dmabuf_collector
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177213421804.1808439.320626533267956186.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 19:30:18 +0000
References: <20260225003349.113746-1-tjmercier@google.com>
In-Reply-To: <20260225003349.113746-1-tjmercier@google.com>
To: T.J. Mercier <tjmercier@google.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 quic_sukadev@quicinc.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 24 Feb 2026 16:33:48 -0800 you wrote:
> Dmabuf name allocations can be less than DMA_BUF_NAME_LEN characters,
> but bpf_probe_read_kernel always tries to read exactly that many bytes.
> If a name is less than DMA_BUF_NAME_LEN characters,
> bpf_probe_read_kernel will read past the end. bpf_probe_read_kernel_str
> stops at the first NUL terminator so use it instead, like
> iter_dmabuf_for_each already does.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Fix OOB read in dmabuf_collector
    https://git.kernel.org/bpf/bpf/c/6881af27f9ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


