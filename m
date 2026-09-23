Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607729DB6E;
	Wed, 23 Sep 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121675; cv=none; b=M/EldR9IjeMygPiLXGWH77HEa3uA6785dYdZej9QnyvF844S3C29RL8U5+C2fv8mM4+S215s5J945yiqsg3Vedyz5cjoynzd5CBpvbcJicKfA7hUq3enDxf/HSZN9ZvNdD9FLTFa+OweG2mqBTZD6YinekNAiJfzaYfsnuMXUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121675; c=relaxed/simple;
	bh=gQ7+bc0cXYi7r9jYB+aNQDpm7U4efqVw7Cnw1ri9NE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dpGEWhQ8GjChsia9tl4a3guaRffD4KnKQYumq28jkOy41vlK5j3U1MJCCrr3HE4D6mL3kjVf29nzo4RSmZkt1EM1xtvQ9aggqr1RNikKjfqtR1u6g/FtXp2WpHqeZAdMtsm5TgDDiJLUyEqgBQWbXnRvmATnDG8N8WmX+Zg627g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYTnV1u5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYTnV1u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5E21F000FF;
	Wed, 23 Sep 2026 00:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790121674;
	bh=cw58Y9/eYTa7ToLPFco7mggC1vZsnQAC6F+d7GeI5jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kYTnV1u5psy/FYr3htXLEw2+W8HtTnmgkXEnnIN6tBKghNwRVxBm0ZSdY3yzz/k/j
	 0mgWbwmJFJMPxByBoCeOdFUzhFQ/Ui2n0O7CCKT7vjtGu4Ym/WjYrRF3gC2f1Ac2l4
	 i81a145NFtikK4a41NXWzMr2au2oJARi6ybTfDlAfStPUenKBMwB97nIZgX5MjsFIU
	 wSv0PygwMOornm2s2mNJiYNyu9dsv0ZH73oKS92SpHeFKQAJdmVyET4oLxnc4Nfog8
	 alE8ueln82xzk3Fl+uetcDbPbRf12k3QAXrgD+zoQV+ZbmlXFnf6d7eeJOeZdNVwG/
	 muRgevAsJPcFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568AA3822D65;
	Wed, 23 Sep 2026 00:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf,
 sockmap: reject max_entries > INT_MAX in sock_map_alloc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179012160516.137376.9044341582800034905.git-patchwork-notify@kernel.org>
Date: Wed, 23 Sep 2026 00:00:05 +0000
References: <20260917121016.48171-1-zhaogongyi@bytedance.com>
In-Reply-To: <20260917121016.48171-1-zhaogongyi@bytedance.com>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, zhaogongyi@BYTEDANCE.COM

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 17 Sep 2026 20:10:16 +0800 you wrote:
> From: Zhao Gongyi <zhaogongyi@BYTEDANCE.COM>
> 
> sock_map_alloc() only rejects max_entries == 0 and otherwise allows any
> u32 value.  sock_map_free() then walks the sks[] array with a signed int
> iterator:
> 
> 	int i;
> 	for (i = 0; i < stab->map.max_entries; i++)
> 		struct sock **psk = &stab->sks[i];
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf, sockmap: reject max_entries > INT_MAX in sock_map_alloc
    https://git.kernel.org/bpf/bpf/c/814a81c842bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


