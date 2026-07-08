Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CFE3AE19B
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474831; cv=none; b=bu10RX67py6Ph8n7Wk0nj2gEKeAJPrFK8Kqh1bz4/CdSHBDBegLmj+OoeGIf2p1CZf3tmRw4hBPBc2ZzaN8MBz4mB+zr2w17vxOgnBfShL3qgdMQmXe6EkGUd4yLJhFwmd8zOTrsx6jRL9Gz8EDrxJ6eG6+88tERXMhyD86id6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474831; c=relaxed/simple;
	bh=8FBNr8/oHVdl+a2mTgVN81u0TGmO/2B4T4AfRpEFxac=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rjUFkEqDkgtMZDHgoUgsdQIv5NF3S+f9NL688aFPmPkwmR079j8qsiMw4WwjJK/IoEwAQCfrcUo8f+puSXXWhNiZiS2J+8kiXt0aun60KxSfaiPk3blC9IbndSCIjeFbqY+DjJ9rPkujwjXUdMBH2eNDKc72nIJGJfwyUhrGnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC7fbhda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC7fbhda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BC31F000E9;
	Wed,  8 Jul 2026 01:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474829;
	bh=OYWv4qAep8WSpozmqkFkV17GAGae50pCuUsKW3dp2Io=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jC7fbhda/hTKGzN7TqXpbpBdOn5xWEFO8BI7qCxCtps0xl1w8huHieBxB4OvKGdXi
	 ghLTizyaU0M2hlROi4TNyTJ0015iQCKjJJsSwrQkBD12TW7AO9Sh+CfDV60g3HKZEx
	 eeU58TZ4Grkc5hAKGT6Rs+7vo/4xeWJfhm49MgqXTrFkjITtvRiA4GxD+rxmqtUmVx
	 rh4YXbK9x0BeN/JrC/tbPhcKf5P5YMIGEdSZNHNTWtG2W18LiWLSgXfP4LBGMqrR38
	 WKbiG0TtBqqQa2sNvoxr6zKcDafDQzUX56oSr6n/mL8idZj/wyPzZzC+3BLqxFOaBg
	 K/xzYwZqir3aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B67392546D;
	Wed,  8 Jul 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: remove artificial limitations on
 pointer
 types eligable for spilling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178347480889.2239832.16110683590834112096.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jul 2026 01:40:08 +0000
References: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
In-Reply-To: <20260707-missing-spillable-types-v1-0-44a92121dc41@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, memxor@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue,  7 Jul 2026 17:44:27 -0700 you wrote:
> Track spills for the following register types precisely:
> - PTR_TO_TP_BUFFER
> - PTR_TO_INSN
> - CONST_PTR_TO_DYNPTR
> 
> ---
> Eduard Zingerman (2):
>       bpf: remove artificial limitations on pointer types eligable for spilling
>       selftests/bpf: test cases for missing spill types
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: remove artificial limitations on pointer types eligable for spilling
    https://git.kernel.org/bpf/bpf-next/c/1f737e46ca6a
  - [bpf-next,2/2] selftests/bpf: test cases for missing spill types
    https://git.kernel.org/bpf/bpf-next/c/b6d29b9ba9d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


