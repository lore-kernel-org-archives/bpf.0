Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12422E648
	for <bpf@vger.kernel.org>; Thu,  7 Mar 2024 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709853031; cv=none; b=LqyXxNFDkKGnO30btjpG2jZ2DoEmWfvbhfA9M9cV1J2PRxVZu+5HLdlPcnHoUnik78Z97MnQdm53H0J9DffVhBwnedlM77bQ4xgssPZuVjLuGGkgRvrXFj5VgyAOTUWoPCfQBMtTxkzhoKdnRgpJk5fOmWfPLGD6UTS5HQkYbOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709853031; c=relaxed/simple;
	bh=atIzMDOsMMh5QIHpPOQEuyLVnXrsW5RFV0Nw19VWmz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BLwjQ6HLAU//E+ZmSaCeMocvHQgXYyL//NcTd0LuuqZnwKjaZb3W5pNUNsj9xDTup1652cXPd15SWYMQvYQXleTecrxCfObpH/4m4gOy0JTCwKl+mw3woaQBmZy4GykuLGHvpLkAOkjT0Lba8cgrVEod5MwmWYqUxJod79U6Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmagqIe9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmagqIe9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B80DC43394;
	Thu,  7 Mar 2024 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709853031;
	bh=atIzMDOsMMh5QIHpPOQEuyLVnXrsW5RFV0Nw19VWmz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DmagqIe9B4YY/iyu8i0eYgcRB5JoUB3qYrd7XLUAw3mQ923oKGMV5jHmhw78/2tQp
	 JFTobJHJCyS1aJ8uwarj53Eb7MbY0MxLfRP7yTSQCo7RMBbdH+/t770nkRuR44eS4U
	 bGnVdI/J9Y0JKXKs1sdLayWYzinE0g1taqP06e9fM6yR8zr4KH0PUxv0nJPnphps4+
	 rK+70HxpmR5+3GhNJNTUAhWHY5Rbhl0Vmb9UN9A9RrxR1sdLkisbgtjmO41c0YgThB
	 l7O4a+y3lMzTnK8jwWwhNlZAkYp70q7ohs7pfq8cuK5URvZrCgnAwMtj05/sTnjps6
	 ZkxQdV2ucwq5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC2DBC04D3F;
	Thu,  7 Mar 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf-next 0/6] bpf: arena prerequisites
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170985303095.28922.11104490293682114783.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 23:10:30 +0000
References: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240307031228.42896-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Wed,  6 Mar 2024 19:12:22 -0800 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These are bpf_arena prerequisite patches.
> Useful on its own.
> 
> Alexei Starovoitov (5):
>   bpf: Allow kfuncs return 'void *'
>   bpf: Recognize '__map' suffix in kfunc arguments
>   bpf: Plumb get_unmapped_area() callback into bpf_map_ops
>   libbpf: Allow specifying 64-bit integers in map BTF.
>   bpf: Tell bpf programs kernel's PAGE_SIZE
> 
> [...]

Here is the summary with links:
  - [v4,bpf-next,1/6] bpf: Allow kfuncs return 'void *'
    https://git.kernel.org/bpf/bpf-next/c/88d1d4a7eebe
  - [v4,bpf-next,2/6] bpf: Recognize '__map' suffix in kfunc arguments
    https://git.kernel.org/bpf/bpf-next/c/8d94f1357c00
  - [v4,bpf-next,3/6] bpf: Plumb get_unmapped_area() callback into bpf_map_ops
    https://git.kernel.org/bpf/bpf-next/c/cf2c2e4a3d91
  - [v4,bpf-next,4/6] libbpf: Allow specifying 64-bit integers in map BTF.
    https://git.kernel.org/bpf/bpf-next/c/d147357e2e59
  - [v4,bpf-next,5/6] bpftool: rename is_internal_mmapable_map into is_mmapable_map
    https://git.kernel.org/bpf/bpf-next/c/1576b0796197
  - [v4,bpf-next,6/6] bpf: Tell bpf programs kernel's PAGE_SIZE
    https://git.kernel.org/bpf/bpf-next/c/fe5064158c56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


