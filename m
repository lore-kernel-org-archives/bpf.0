Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF262D8370
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 01:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775697633; cv=none; b=eJlmX7ukzqhm36wleJfuBbKY4VN3kgYXL1tL+9do0cKqDeOwRpwB4OGPdEtIM2AeAQN81iVu0zQzUwKrmJ4rjllcS8yzmHS4+DuS0ZZOYgNTXVURLr930/0/JjRiJNsYZYYQFdLOigEIodrt1WpdejVwOCiLm2dfV7BkAkFoBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775697633; c=relaxed/simple;
	bh=GYlUBPxwIjCv7/O3vXNNybR4XjfWDz7P7ia3vgk+2T0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W9j5rdcxNBgRGv4SwzibLFSexCQkUaOEU3nxilbxTaLK/MT7/qrQOznwIxbMjAhSB4I37RER1Ydh7qwrqKNELvkDxjTo+RtyFLUj2+oL8DA7KRVw+BtpZw+ahYqqw52qzIgjVMXhxmCi4M3ZhVjYG03ZdnKAmNacCfdVa/Z6UIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5UgdF/J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5UgdF/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816C3C19421;
	Thu,  9 Apr 2026 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775697633;
	bh=GYlUBPxwIjCv7/O3vXNNybR4XjfWDz7P7ia3vgk+2T0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W5UgdF/J4po4NSAkqq99qcghKXDf46bMr8C6ZcpG2dJ8ARTyVz0j3UsMIu2Hi0ZCU
	 RkTwcdBtoRAWxvorcS3xQc60CSVKp1ZsqCWD2m0deZXkO9B6caJO+Iez42QRE72DF0
	 FXOliR2V2hgYuA8sLWswi2Ffv0uDN9QFWLSU7ND89o4G8a2vOaxUGNq5+/vvNR4u8g
	 ZmiAhTQTRvKxJGn31DcE4+CiZZfAssnEO2PreuAlsoviXxRsDMbqf4FRt9dFW6oltZ
	 txzIB14lDy0wg4OMzJ3QLxKdutuP4gU/AcUQoWoZQ8nQRa1cBf8SIil49EEkRP1dg3
	 5xM3ZBfedOCNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E6F3930793;
	Thu,  9 Apr 2026 01:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/6] Add support to emit verifier warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177569760978.941108.16304121560166378854.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 01:20:09 +0000
References: <20260408021359.3786905-1-memxor@gmail.com>
In-Reply-To: <20260408021359.3786905-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 ihor.solodrai@linux.dev, kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  8 Apr 2026 04:13:51 +0200 you wrote:
> Currently, there are only two ways of communicating information to the user
> when a program is verified, success or failure with a verbose verifier log.
> Some information is meant to be more discretionary, e.g. warning about use of
> kfuncs that are deprecated, and may be removed in future kernel releases.
> 
> An example is shown below.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/6] bpf: Add support for verifier warning messages
    (no matching commit)
  - [bpf-next,v2,2/6] bpf: Extract bpf_get_linfo_file_line
    https://git.kernel.org/bpf/bpf-next/c/fbb98834a922
  - [bpf-next,v2,3/6] bpf: Make find_linfo widely available
    https://git.kernel.org/bpf/bpf-next/c/4f64d5b66418
  - [bpf-next,v2,4/6] bpf: Use KF_DEPRECATED to emit verifier warnings
    (no matching commit)
  - [bpf-next,v2,5/6] bpf: Add __bpf_kfunc_replacement() annotation
    (no matching commit)
  - [bpf-next,v2,6/6] libbpf: Flush verifier warning messages by default
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


