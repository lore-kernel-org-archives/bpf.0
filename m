Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C2442B34
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927448; cv=none; b=e9tmQFRcf5l2TevafrVP8Hv4G4E+nyb+7k5T2oUla1gxAyVhKCd0G9rK8oYEgwVoYsrhHsLE29jD5lSkJSAo++czRprPczLGv7mc+Zz6HQ11xnTdTreyGsV1JIPls8XgtWoAfEhIkzsQW0tNQMfh9PoFxmtQD1iY7btjkDhCkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927448; c=relaxed/simple;
	bh=/eL3gCGhif4ydur/Ro/RMklVoofE0G0Ajkz+ewwT2VM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l5AUUYw6cNvHzb7hUzaWBIjGMwt9yDIdLfNDNBd5xa/JyXd8DGz66tZG+BlKG+wFDOaB5IcxP4XKVEFnn0GxQVY+sbRXU+2l0Uta+dlXHblepUTIPgWpzRC3Sy47JMYqwZm+8xIF8sAtOVXkVt5x6eqWV3U/C20BokgQ1jSU4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PihBktN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PihBktN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701081F000E9;
	Fri, 24 Jul 2026 21:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784927446;
	bh=P1rGrDGXi+t7Ib0UvdtTwLjXuZYP7PeDZkwOs3SCRuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PihBktN9dz8Uw7g80KYCAqg+rYOqbFqmTvc6NkW5LVUt/dJQ27vUVB2YkShEKe3xJ
	 Gvn+X3ENRZU9iEYvSR1DjVHi+Bf2wA+FZumioz0EUxoADxY8Y1m1RVdcUSBAZxymD+
	 TcS6h7QsIJLNWdESDnjaU9HFer0XhA7ERVY0FOWv9X5YmstPgMiGG4/NpSwVpTwdB9
	 RsMu0EBjcdiIw7hrlEIqTqHjz0e06DDTiJpZ6vw0rFKvVLFdijr5czVtgH03A6ZMz0
	 hgNGoFi7/cAGRjLNYUjHvemznAxaU/LY5h/SUP5xoaRzhOFLk1VaGN55Wv7qaUuBoU
	 Y/i/DlmD/v+kg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9138111D2;
	Fri, 24 Jul 2026 21:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] s390/bpf: Support load-acquire and
 store-release
 instructions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178492741339.3309102.503525499704647974.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 21:10:13 +0000
References: <20260723140648.583055-5-max@linux.ibm.com>
In-Reply-To: <20260723140648.583055-5-max@linux.ibm.com>
To: Maxim Khmelevskii <max@linux.ibm.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 bpf@vger.kernel.org, iii@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu, 23 Jul 2026 16:03:48 +0200 you wrote:
> Support load-acquire (BPF_LOAD_ACQ) and store-release (BPF_STORE_REL)
> instructions. Since s390 has strong memory model, implement
> them as regular BPF_LDX/BPF_STX instructions.
> 
> Maxim Khmelevskii (3):
>   s390/bpf: Add emit_ldx and emit_stx functions
>   s390/bpf: Support load-acquire and store-release instructions
>   s390/bpf: Enable atomics tests for s390
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] s390/bpf: Add emit_ldx and emit_stx functions
    https://git.kernel.org/bpf/bpf-next/c/2d7f576c9d83
  - [bpf-next,2/3] s390/bpf: Support load-acquire and store-release instructions
    https://git.kernel.org/bpf/bpf-next/c/898343edde47
  - [bpf-next,3/3] s390/bpf: Enable atomics tests for s390
    https://git.kernel.org/bpf/bpf-next/c/2925f8deeade

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


