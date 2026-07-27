Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31963E316B
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192641; cv=none; b=ZkU2HqJyuo4sHuGF8bK6gj29CN38f9nlUSxzbL4bQsAZfaE71aUVHLU6x8XCVCYnEDMo6YFeK88J0LWuIULv+86B9drGtUUfV3rvdRbViSkMd2qmeNMceL5MBWVY7x5og2TP3mfvspqMxtPfXBbeOZ3LGVnhgMkIKW4nydB1nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192641; c=relaxed/simple;
	bh=Pzz2/HU+fChKoGx+QK1BuTc7r/OQ5+1J0ERzY6vX2o4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTRBs3joPMGwoqnsZJ/WdbQj3+0OSYmcVliXDeImYLYMdtj6cXNsqT9JJPK7Hk4pBnVN1OIx+g/WZ/0+wxNBCqNPfoAvUF5Kr43xes970hNt5DdJ54Krd9xmjA2T9ZO4gQsoGN5v60z+pzcd9tTH3G0I0kpZJ0c4y6wwJLGhCxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgZnH3TM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgZnH3TM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE21F000E9;
	Mon, 27 Jul 2026 22:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785192640;
	bh=XQH8b7ON/k0LAHmcsw4IYRqb1r5aKGaZ0rrwbX4P5Rw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jgZnH3TMYcECke8ow/UkqSaOJFYHTgZUM3oG0UJUHLx3vXSH7qI5taM1juVBZ6u/7
	 pZ+BsVDrGfwvCLHNzWRdY5VQaZGqCVxBJhBeTID5GXa8hISSuWtl/EATipqwS3sxqa
	 iaFqXQi5L9sSPts9CNWzhWqHxJK1MvtGz4ubEkqskLM9Im8hF79Gb//5qUUTISS8UU
	 2wvcUp3p4qY0BqrmuEYuRQX2kzJfPQHGRUZgZXT1AP2BKJE9opAL4gB6Hs7AgDnxgs
	 g9F0p/9gcJER6nHveKtSuxBt4fHsF5t1oGnSpUonqwKSC7wS+XhcaJWTVW80b5JfqB
	 68fTzRgsPSW+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1982C380CED0;
	Mon, 27 Jul 2026 22:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Open up res_spin_lock for tracing
 programs,
 fix is_tracing_prog_type()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178519260589.1445878.6086749891364924241.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 22:50:05 +0000
References: <20260719113551.1294284-1-memxor@gmail.com>
In-Reply-To: <20260719113551.1294284-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, kkd@meta.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun, 19 Jul 2026 13:35:48 +0200 you wrote:
> Patches in the set first open up res_spin_lock in all program types. The
> second patch goes back to addressing the technical debt highlighted in [0].
> While for programs affected by the second patch don't need res_spin_lock
> to be opened up (since it was already allowed in those program types due
> to the oversight in is_tracing_prog_type()), it is timely to do so now.
> 
>   [0]: https://lore.kernel.org/bpf/DJ3W8IZ08WBT.VTRTP72FSWVO@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Allow bpf_res_spin_lock() in all contexts
    https://git.kernel.org/bpf/bpf-next/c/59b9731addc7
  - [bpf-next,v1,2/2] bpf: Fix is_tracing_prog_type() to cover fentry/fexit/fmod_ret
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


