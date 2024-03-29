Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AEE17BA1
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678229; cv=none; b=PN9EIkLEbwy+gl/OpaENtxnGN/3iu99DIFEOs3VImaXhFmshjwZaMR3CsikIgam8Nt+P94A0gPiGgF3yF39i89cFMmTtsPFEfF46TPJCqGfCqKmydPLzyawnd8E/FPs7ymytpoebP1lx8erwK5jn9DS56pAVdjmfjO2BiPvhDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678229; c=relaxed/simple;
	bh=84t3shwA7B6+z0cfLnAueH8ZCiDAuPTqcmU0Umba5q4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bj/gQEe+r3YJzzHDhEa6KZBajoVVEK84dsrcSEalRo85RZimIumGZ1Cb6fJyqLa5a6lvpe4ZixfV2+9lgkqx3U0qhgto+VQxZiq/Hf2tTqZerLF6KlMF9MO1uzqIqAVCDvXEE5IlMjg1korAwYnvbezVcEIbHtdk40bVZ+k4ZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLMqwvNV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLMqwvNV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B0C3C43390;
	Fri, 29 Mar 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678228;
	bh=84t3shwA7B6+z0cfLnAueH8ZCiDAuPTqcmU0Umba5q4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WLMqwvNVZQPX0iq/YBpHEvEbGl2a5WdiK5PlTRhVnosc8aBOfoVh2I2/Bx8Sx3sdR
	 a0TcXd4Z53eY2Gm+UuXGijjmLA2nyph3plnIiQLCCixSIuIzW502bPrt92Gl02woLg
	 5DauviOo13iobG8AowNx5/H2UCRL1ksqGC0J0LP0eUU0jS/oIhXPPOB6GCXmiZ5nZK
	 vo3v+Tnb70bV0+D81XbukPfV74k4KIrrp1L4Zbogyu8eAIukzSg5pSGsNm3IZfnc3C
	 QAgzRuFxmvjHl99V1NBfadj+ml6JX8Y8S4TljvQEirKchHCExwtIhlRN2vEBwbGKSY
	 IyYtPf4N9vIyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F93BD8BCE9;
	Fri, 29 Mar 2024 02:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Mark bpf prog stack with kmsan_unposion_memory
 in interpreter mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171167822851.26524.11926030451629724620.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 02:10:28 +0000
References: <20240328185801.1843078-1-martin.lau@linux.dev>
In-Reply-To: <20240328185801.1843078-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com,
 syzbot+603bcd9b0bf1d94dbb9b@syzkaller.appspotmail.com,
 syzbot+eb02dc7f03dce0ef39f3@syzkaller.appspotmail.com,
 syzbot+b4e65ca24fd4d0c734c3@syzkaller.appspotmail.com,
 syzbot+d2b113dc9fea5e1d2848@syzkaller.appspotmail.com,
 syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 28 Mar 2024 11:58:01 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> syzbot reported uninit memory usages during map_{lookup,delete}_elem.
> 
> ==========
> BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
> BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
> __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
> dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
> ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
> bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
> ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
> __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
> ==========
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Mark bpf prog stack with kmsan_unposion_memory in interpreter mode
    https://git.kernel.org/bpf/bpf-next/c/e8742081db7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


