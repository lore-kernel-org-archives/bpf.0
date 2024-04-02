Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923FF86146
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067627; cv=none; b=gqXspAbR2w2Ch8AURqIEGhQ8us98Qp0B+UL2MeJVm6WwUv5ZnsNRaQcbUYqDOeCvTWy9q4HdO/2qFU052lAbSFtlK14NKlcmol+Md3thXeN93MoKnovfDkik1vJpESFSx2geCWwT8u1kPS1KCNU6O1GVDEOJmMsIzFqqjxwqV74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067627; c=relaxed/simple;
	bh=pbivdlq+NhjOZzPYqcicpoyCPCpF30Phq9r4Jn8kyi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WnJ7mBGZTfRjEJoMe5Bp+Eiw3K4hDdeVOszfEUq1k6kdBavb6QK24l67TZ33BPEzREJzYc6N9BqzQsYx8mj+azZMr8fgd99R1b4OgogGjnBKOR8FeVcW4SWeuZT4nVg0g8f7UBt/c1TOuX1a6gxGJwe4V2mKjODhuQ0mt+1n2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEA2+LSN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEA2+LSN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38E24C433C7;
	Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067627;
	bh=pbivdlq+NhjOZzPYqcicpoyCPCpF30Phq9r4Jn8kyi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lEA2+LSNfnYpi/qy3Eooaqx79JTgIb2IiOOxtaWoPPtC1wNe8riyhCG/2sVOVhMSp
	 kB6QFCSiWyMLQJ9sC68Qr0wHuFd6xVVSZsADW8llHlSxy+9mTHxrNZSmZrJrB/KbuM
	 7X0RsS4SwxiT8znVM547dpNun5/FRWkUpShX5j99kWn8uIll+ffb05CCn3ynIbEw5s
	 qWMKJL/Iqc/5P03gulMvusltMRcU0/FOGKcgwNKBQ0mFZr3kwlNqBoprCZl0FOUE9D
	 HLVMkqamykV3shNV4SZRjxMR7eX5g4ZVnH583+7FJ9s2HYcMPNgkucFGdAK9g+qjNb
	 PHX8YzuNz2poQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28E4AD9A155;
	Tue,  2 Apr 2024 14:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: add a verbose message if map limit is
 reached
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206762716.12718.16350594816055308949.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:20:27 +0000
References: <20240402073347.195920-1-aspsk@isovalent.com>
In-Reply-To: <20240402073347.195920-1-aspsk@isovalent.com>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
 martin.lau@linux.dev, sdf@google.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue,  2 Apr 2024 07:33:47 +0000 you wrote:
> When more than 64 maps are used by a program and its subprograms the
> verifier returns -E2BIG. Add a verbose message which highlights the
> source of the error and also print the actual limit.
> 
> v1 -> v2:
>   * make the message more clear (Alexey)
> v2 -> v3:
>   * fixed grammar (Anton)
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: add a verbose message if map limit is reached
    https://git.kernel.org/bpf/bpf-next/c/9dc182c58b5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


