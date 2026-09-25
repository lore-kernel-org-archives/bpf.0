Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FDF2C11EE;
	Fri, 25 Sep 2026 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330478; cv=none; b=dG5KaYekm4xYSnwFRDnn5EjjmZN5PTBz36EETwjhFNepbkHOh8bsRqTsaKyol37LWb1M3HGIWpC+2ze707g73Uw1t1dO3QHVAg8UgpdCyunFTl94SOIN01bykeYR+xg25svEv5ZHMujwNpafOEA+TTqKkDBme5t3veWLO1QYmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330478; c=relaxed/simple;
	bh=o+GQzv5VoS7SYSouq0tkQJwGpEVnzqUYxd8AMwhPGXo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ShgcKv/CHUyuCWKPs7mP5oEKASPflBlE6o2N68mLLQf2qG6NkZfjdKb9KrojVxrAyCmQV7sWbzv4eJ8+VgW4IbD3/3moWpia88ZMD73e9TxuriJNGq/OjG3zK+R+5ka92ilbEUMtzo46vwkeen7x2TXapAgdieDXX2jWOCpT13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hc2FYNrC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hc2FYNrC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3140D1F000FF;
	Fri, 25 Sep 2026 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330477;
	bh=Ex1hLPiH0jRiAXmcWotglspYjhJaOLPOVojkjwIQbTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hc2FYNrCTrCJ7MNFT/o96OvaUldA3vr/SJU500De4hVgNd3oe0K1XvUc0PTWVi+Rm
	 v+rfdbbrxiBii+84LNmxDiBzJJDwlws5SJbC3ILGyIxf4ABG6np+83PYw+HI4tmrpc
	 yy4LCcMuNk8nyge37c+OBtRL/nm34faltaAQ4owfl8fedVfxM/2oGReQeudwzaxWk7
	 h4TerRGXYm7cpW0a4hiB/Uv/R5qTgDXcglpLTEpyEC/A0YsrOj8fm1SOVmN5IqJfFU
	 mjLJOX1YNHgCy/fMeSOkEvWhxvdF7zCr9xFNxsZJMJ7wrG7B3n/1km6dnTK21ppghW
	 K0rqdh2O6z03g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389B3AA6A42;
	Fri, 25 Sep 2026 10:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix uninit read for helper mem args on
 partially spilled slots
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179033040522.2428861.4397350193691349968.git-patchwork-notify@kernel.org>
Date: Fri, 25 Sep 2026 10:00:05 +0000
References: <20260925082814.1554771-1-sunhao.th@gmail.com>
In-Reply-To: <20260925082814.1554771-1-sunhao.th@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com,
 memxor@gmail.com, martin.lau@linux.dev, linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Fri, 25 Sep 2026 10:28:13 +0200 you wrote:
> check_stack_range_initialized() takes the spilled register path when
> bpf_is_spilled_reg(ss) holds, which, however, only looks at the last
> byte of the slot. Hence, a partially spilled scalar (on the lower part)
> bypasses the check and the following loads:
> 
> 0: (b7) r1 = 1                        ; R1=1
> 1: (63) *(u32 *)(r10 -8) = r1         ; R1=1 R10=fp0 fp-8=????1
> 2: (18) r1 = 0x0                      ; R1=map_ptr(map=rb,ks=0,vs=0)
> 4: (bf) r2 = r10                      ; R2=fp0 R10=fp0
> 5: (07) r2 += -8                      ; R2=fp-8
> 6: (b7) r3 = 8                        ; R3=8
> 7: (b7) r4 = 0                        ; R4=0
> 8: (85) call bpf_ringbuf_output#130
> ...
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Fix uninit read for helper mem args on partially spilled slots
    https://git.kernel.org/bpf/bpf-next/c/b3861495d2b2
  - [bpf-next,2/2] selftests/bpf: Test helper read of a narrow stack spill
    https://git.kernel.org/bpf/bpf-next/c/7af653d4ebf8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


