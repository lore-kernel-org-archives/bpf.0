Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4CC14A
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298371; cv=none; b=djLFYP7WieP5URvgyTHtqwfIt5F7ltyyHLlM7kKekxATWoH9oy1ChfgB0Fsk7+qvb+O4wJHHLIHj72Qcm9YlWw/1EabinHA9KWkVEpA6a7U2TDz6nBopaUcw/AmF+sip7mQ/HyrsibSqeK6XnoTnr/hNYDmg1qfvV4FUt91zS+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298371; c=relaxed/simple;
	bh=rvHGLW1RIdYCCQRvSkcuRai+sAeN+C7onVbOHGEWwj4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jhn0/9n4BmGmBO0Q2eKBm6yNpahPbHDz5ELAr7clfjcM33N9yZHJXak+pnp/d0zhUYqvRFMYBVLyq+htH6YhpeLtR0JyzMWTyEvdyXud2t6SzQdKFeHMfVcYgzinuLCJNyDRa5QfCGqMSLZEsaLLms20aY+Gyxy121pRgGibp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LamRu6gy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LamRu6gy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569FEC19424;
	Thu, 16 Apr 2026 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298371;
	bh=rvHGLW1RIdYCCQRvSkcuRai+sAeN+C7onVbOHGEWwj4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LamRu6gyu7BG6LYmJ3XIHO7r63vKgy/JI5L0vx5OZhpjLAIV7W1xU9IXZSgf54WFG
	 Dmu9LdCxjAto69NrhKevRANrcCKSYMle8hUhUUNgaQeod2ZuzWXjkRbZN9R8snWG50
	 ddNBYFPY0Pz3COgIS2BR06sbtBfyVevttqsR4d7hIGDyDhZXFU6AuoIlbBWifZm7+t
	 a2CwLjsZL2xidibj1InmzgIn2qD+3foKfI/CBn/khhrN8bcd0UTSeP0/bjtj4sOhFD
	 BjdMsG7OwuNaah+ShqoSjUhCwL96+CgENjTGQjv0pRzEykpFtf3EI/8h7FgG6+7Ema
	 DJixUPiiHAz6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA174380A964;
	Thu, 16 Apr 2026 00:12:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4 0/2] bpf: copy BPF token from main program to
 subprograms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177629834053.2488030.556653357025366202.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 00:12:20 +0000
References: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
In-Reply-To: <20260415-subprog-token-fix-v4-0-9bd000e8b068@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, ctao@meta.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 15 Apr 2026 13:03:54 -0700 you wrote:
> bpf_jit_subprogs() omits aux->token when it creates a struct
> bpf_prog_aux instances for a subprograms.
> This means that for programs loaded via BPF token (i.e., from a
> non-init user namespace), subprograms fail the bpf_token_capable()
> check in bpf_prog_kallsyms_add() and don't appear in /proc/kallsyms.
> Which in-turn makes it impossible to freplace such subprograms.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4,1/2] bpf: copy BPF token from main program to subprograms
    https://git.kernel.org/bpf/bpf/c/0251e40c4829
  - [bpf-next,v4,2/2] selftests/bpf: verify kallsyms entries for token-loaded subprograms
    https://git.kernel.org/bpf/bpf/c/969fb456ffb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


