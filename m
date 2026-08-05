Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C19345CCD
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924648; cv=none; b=ZDSA4r5VTglzQMM8xTdaca46mGJr/10EgPcZk/aXQPExav3yzBOCs6cN4AtnVB7UHyb/0XRuU0WWpTNjZQF7Cemk/Uk5meFbHb2QXqPFzZ3N/nKEXnrXKotqkEQZQVQoRLU7oe73LTzA8W01LEzRFGj8+yKZ+jAb73R7x1edn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924648; c=relaxed/simple;
	bh=UPel6NYBYTe9ho7f4G6CppaieRi/Vikg7x1uKnTTjjc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iCkDX2msJ/HRI452yaV6OYZdwnDr7DyTCVVeRauEXYGdjoAUDb4X4AH7ZLpu0TXR94vXWm3FFw+pmShi1EUUggSFhi4s8OnWrKj87PndLg4CcLPcnvjT0xTXq+0vBtOLhOFr+AgqWaFg0kyiq+yXr6fsfEbRsFliaNCF0ZiY+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbz6Lwl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbz6Lwl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA2D1F00A3A;
	Wed,  5 Aug 2026 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924647;
	bh=n13qh9TmYCMbsHeQIhKAKJaNrcPaegL00UPx6TU0XOM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dbz6Lwl7/4WMW6KzgyB16wfwbTq+qb6v8HIUqSpyD4RrtjS0LlZq6gRehLRfSuaEW
	 ZSRuY3RMYC8oEtq2BZsNaNElXi/WtQDxxor1vbWm5F1wBcRfoctErnKpFxxlAz0OZm
	 D0DWUqU2OpqV0JgHACVw1l4WAXUBBkoFVy28kn/O8OYEw9UA5wpB6lxg21bDaoFbwW
	 zm/tKrbbh0CbJrOJZRACm4CdLPnN14az/9IS7y1tLE6G3hmDByR1q711ECbWq7+SwV
	 /joRA+aSK7Hmmn1Kc2DwLh9f2vqENzB56E/gJL60598v5wIBeeWAHNIpWOULXo2rN2
	 0Pibvj+LwJ6jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938FE392706C;
	Wed,  5 Aug 2026 10:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 1/2] bpf: Check load-acquire src ptr type before
 the
 load
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178592460714.4035557.13170719320539313553.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 10:10:07 +0000
References: <20260804201917.253491-1-daniel@iogearbox.net>
In-Reply-To: <20260804201917.253491-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, eddyz87@gmail.com, puranjay@kernel.org,
 info@starlabs.sg, bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Tue,  4 Aug 2026 22:19:16 +0200 you wrote:
> check_atomic_load() calls check_load_mem() before atomic_ptr_type_ok().
> For a load-acquire that fetches into its own source register (dst_reg ==
> src_reg), check_load_mem() overwrites src_reg's type with the type of the
> loaded value, so the subsequent atomic_ptr_type_ok() no longer sees the
> source pointer and fails to reject the disallowed types (ctx, pkt,
> flow_keys, sock).
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: Check load-acquire src ptr type before the load
    https://git.kernel.org/bpf/bpf-next/c/b87803391baa
  - [bpf-next,2/2] selftests/bpf: Add load-acquire test for dst_reg == src_reg from ctx
    https://git.kernel.org/bpf/bpf-next/c/363b15d8551e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


