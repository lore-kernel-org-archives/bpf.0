Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723807;
	b=BlA7o8/62vUe8q34K/0jTZJVLpRme+cerz8VAssKZbfLnUXm29QFoMDb0oKvKlEEbmXV
	 pajgh3MTbG6NWKULhzj5/QVGB0mHf2f2Go1ElN3uSghgPsiy5+/BDpcI8nYt7G5PfkpqN
	 /TZgExxiCnkcdfX4qUjfoVvlWUaVIzJSzoeOZfW7AAMSzfbRhg5Ycn0RPoNcrkj3z9REM
	 k0J2j5hqd3UUsJsuUCg+juSnM5p3rUF2RmwSNp25x1K6nvmexEU+M9mxwZ07zyNxovYCP
	 oO9wOLzMvBInSgPjn9ocvjK8BHxGz3DDazQ1t56Z4bmPMF2eg5JI+aLId35m8FT7rXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=5t9gtwh4g3afelYRdZ4aIu4AY8xXUE7ia4doW3Fv6kU=;
	b=O/fgXpNu69exGY9AyU0P/WTqFChjUzA/peS0G57LxQw9bXUksj+87ExPxBubRKzPJrkG
	 p2s56b5UX57Rs8HCkumk/Q0P1HSiCeWMDbePPUv4O8P9YxxnfRs1mgN4U5Waag3BeLZpw
	 sA2W3NYu8l9K3HKeyujrhy+PBJwVdlAFJwk40DaJpmbO6pYPddvI0UJWMtcgaIwzlHjdt
	 6z8VCfdkt8P4S5obTCQfu7mhWJrB6z3tDkmEpjoQHb5qoDYl0iaUP9utaTfBA5FCkxHuI
	 TrRlyYi7UbtIvXZQq2i1csshWPa/5ISH332NI0a+DRWxCHmz5r86e8uzDgM2Yd/+ukg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwP925eE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F200606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwP925eE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77BB1F000C0;
	Thu, 26 Nov 2026 20:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723806;
	bh=5t9gtwh4g3afelYRdZ4aIu4AY8xXUE7ia4doW3Fv6kU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EwP925eE+Q9JZjAU+GdphMlIpmokZfPRpPV19IQ1MN1t+/ZZuxB94Rt8+blfT/mCk
	 bVUnpogB5MMNmDCtUxcEZ4BSnln2DsA246751ZCQbEOP+M3iYrn/cFqc1UYkbTDGkz
	 il/UHFk5iEDhzG7Xy5gNhElTE2NRJ7t5zv15aMYnuNh8L3Dsg7xa0glqOEuWRMI35R
	 fsH7zRnVK64WBZCBhe558D7oduMgUmZIwgjIaGnGeYZ0HcZ+X0U0N9K0CqgNu+QqMQ
	 Y6q63gpVJG1P6nFVWYG0xIj6n84/AwX7AZsIHZO8em1a5R0dpvv7Zvwm9zT3SmSDZe
	 mov8edSD5RUDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE8FC3803325;
	Thu, 26 Nov 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2 0/4] bpf: Fixes for speculation barriers and
 constant
 reads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179572380550.596731.16626845192699847891.git-patchwork-notify@kernel.org>
Date: Thu, 26 Nov 2026 20:10:05 +0000
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, luis.gerhorst@fau.de

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 26 Nov 2026 03:38:12 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> These patches fix bugs in the verifier:
> 
>   patch  area
>   -----  ------------------------------------------------------------------
>   1      insn aux data after a failed check on a speculative path
>   2      spills of invalid registers
>   3      unaligned reads of read-only maps
>   4      the barrier after a store to the stack by an atomic or a call
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/4] bpf: Undo insn aux changes of a failed speculative path
    https://git.kernel.org/bpf/bpf/c/fa84f87e42af
  - [bpf,v2,2/4] bpf: Treat NOT_INIT as a pointer in __is_pointer_value()
    https://git.kernel.org/bpf/bpf/c/bbe2012ece4a
  - [bpf,v2,3/4] bpf: Use get_unaligned() in bpf_map_direct_read()
    https://git.kernel.org/bpf/bpf/c/599e0ce412d5
  - [bpf,v2,4/4] bpf: Emit nospec after calls and atomics that write to the stack
    https://git.kernel.org/bpf/bpf/c/1879b5e505de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


