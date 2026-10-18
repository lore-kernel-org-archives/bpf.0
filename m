Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9B3DB980
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364409; cv=none; b=s2Fe88sdS4hWeo38IktNZ0Z1iY2CzJwqndKDijdF0gBTBPOjYaO5z2ctPfiR9zipB86GSZrIpR43fes5XivfPa3qdmhqu3MZ+wdYbxEVH+9pvoSi6cRXWoRGkc9JUnpuiGhEcuh7SJV2zfC9nXk8dUx+9SRRqSjeNpHFpW8jXHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364409; c=relaxed/simple;
	bh=ureLavEJ6vBwLlRntnXGR+VYo8z5o5shaGbJ7fbmpGI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OcVdjFBCjC6dRpw0ic8m/CR/Nzcov6Krw9QR/wobwWbLJH8MGH0sJXbSwPo7uW7dtvUPhbLGI5lCxjUTXMZd+0mXProVl7eb6q6VTb7bkcwGMBSGLaDamgDYkxCsq0cvFIK/dB4IsMD9GgXlr/XSBa31izQDXxtxaMdPrjqNJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNJlv6hW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNJlv6hW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483C81F000C4;
	Sun, 18 Oct 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792364408;
	bh=XTpoxYbbn5ZH51dzkNR8F8W2TB4+dw7apGcdnYdLRaU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FNJlv6hWpBu/Se3TMlVohHbma+PjWOEG6jSSCz5aG1s2E81j2a2rdZOsPxjnu8a88
	 m+mBlb0nMjDKKOgrWHTR/HlLYeyqwDY26NaLL/yA1+wNUrJ+dMj1aKgab1PAqm9CNh
	 fUlQHCXPL2tlpxbO+HtTVit1NnfmwfczCYWycnJF9AdNW+qSK2xqX46CxNQbSMMmlb
	 nYLOvKKFkrURvCIhvnNCxiYiVObH/Ic37YEbbV8NyVrzVRCB7qcFXOn9ZPcr6K7Em8
	 Uuq2cn9KniYOTVp6qm6+wE/QHW5cX75/gtnTcZTIU9poAVXs68Ck7JwZw40oAr0LMn
	 A7XrGbxMsgYNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A28C3811977;
	Sun, 18 Oct 2026 23:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v6 0/3] bpf: Fix incorrect handling of user flags by
 percpu map updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179236440678.1848710.9466674837346626219.git-patchwork-notify@kernel.org>
Date: Sun, 18 Oct 2026 23:00:06 +0000
References: <20261008120734.1565972-1-maghasi@disroot.org>
In-Reply-To: <20261008120734.1565972-1-maghasi@disroot.org>
To: Masoud Aghasi <maghasi@disroot.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, leon.hwang@linux.dev,
 john.fastabend@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  8 Oct 2026 13:07:31 +0100 you wrote:
> For BPF_MAP_TYPE_PERCPU_ARRAY map, bpf_percpu_array_update()
> is not considering the possibility of a combination of
> (BPF_NOEXIST, BPF_EXIST) flags with (BPF_F_CPU, BPF_F_ALL_CPUS) flags.
> This causes the (BPF_NOEXIST, BPF_EXIST) flags to lose their effect
> in some cases.
> 
> For BPF_MAP_TYPE_PERCPU_HASH and BPF_MAP_TYPE_LRU_PERCPU_HASH maps,
> htab_map_check_update_flags() and check_flags() are not considering
> the possibility of a combination of (BPF_NOEXIST, BPF_EXIST) flags
> with (BPF_F_CPU, BPF_F_ALL_CPUS) flags. This causes the
> (BPF_NOEXIST, BPF_EXIST) flags to lose their effect in some cases.
> 
> [...]

Here is the summary with links:
  - [bpf,v6,1/3] bpf: Fix incorrect handling of user flags in bpf_percpu_array_update
    https://git.kernel.org/bpf/bpf-next/c/a898ff0f3e99
  - [bpf,v6,2/3] bpf: Fix incorrect handling of user flags by percpu hash map updates
    https://git.kernel.org/bpf/bpf-next/c/4a9b25fe8d13
  - [bpf,v6,3/3] selftests/bpf: add tests for percpu map flags combination
    https://git.kernel.org/bpf/bpf-next/c/22392799e251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


