Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651407;
	b=XL3jFRGhL+YAgajNQVxxV/sLbgCY4NJZ6Z/EIwm+TtRlZgFMI+cYtcQK6uR1CNmoR746
	 +KoUUD3Ox2ZkWNBOjEFYX2+C2S/QBURm5RrHdDafzjk8DjaAaLi5Ys9ntoyyW7Kah8QMN
	 sAzTQMqes0TMOV3Kd1S6n1Vkfjiv9b5GtW8Wa6a6s++419d+5Oln64+GwCaWIerTR/1wu
	 Q6R2ayoJ4/maYNRVSo16740K8ULLrf7lDOLgx+l2wwAKWA3mtdJwQhYpwc0k4GYxB4jfJ
	 N4NtDcmB4YnQRod0hxaICAxe2pf/twozGbVW5O9aQcDelIL4tPsxmzMMZo0ZiNv+4dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Dt0JpnPj5E9RJWErabsg0jnfVMzB704CiYUTKh3sSzs=;
	b=uR24IqTpyy6WIUkTJdPRQ9vxcUSX0UFqAJA05F/0gMFZu3a3bmgAfwTj/J2VHgOHezYd
	 Q5B+uM6wPF55yy+UAeEE+NaoX3d6oakMoS7bwAY4PQhsyoyxLCFZUhhFv8XaGcw539yXz
	 47EXen6tPRgRbDPTyWTc3XgDsp+MMvUd4IsSGbz7UluvQy8jjHF59Q9gBvkXwbpgxaRRa
	 m4KUbdz7GpUJHO71PrECPiSk4PbU3c7LRB+wEAsmsN/9aLA2uKZcCl+dQBZuegY2iVl/P
	 W9jSKCRu7pvvRf8X8FqYST/KJJ0y9YjnnBmLpK9KCApQid1I3XCBE0FH/HC+mkll7tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRhFtdEN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E5606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MRhFtdEN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404C1F00A16;
	Mon,  2 Nov 2026 20:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651406;
	bh=Dt0JpnPj5E9RJWErabsg0jnfVMzB704CiYUTKh3sSzs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MRhFtdEN8aDxIvPeJVHpnkGl2Y8xaA+3xRnJEN0ny9k9M7OvreEp0nyjySDB9UCUa
	 5NmWGNXJJGWv1tineJhiOhQWALBbRXDeIVs569cRk0rf7aNogJKuyxgT5+RqAq8akb
	 wiVf09kMjM1eQ93VvpghH4cGTyYLNlbTVMIgPQp99PKQDliTfnZ5OECdYu7LbFStqM
	 NSTJ6cWQZhp22QglbZDDW/dt1sRUi8xvgvwGE3CR2U9ZnkoY6HUuxh6EOveZPtT7Xu
	 6ROMJi7tBKmrhWbWNHQ5FJTmHV4Jo9Y7rnxMpn2OJajhX21a7A2m/1Ny2TgPo2Sbbz
	 TFZZi9JTfoZnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA270380821F;
	Mon,  2 Nov 2026 20:30:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf v2 0/2] bpf: Fix the stack buffer that
 bpf_dynptr_slice_rdwr() returns
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179365140555.640439.16316249663064461002.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 20:30:05 +0000
References: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102170958.3586893-1-alexei.starovoitov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 17:09:56 +0000 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> bpf_dynptr_slice_rdwr() and bpf_dynptr_slice() can return the buffer. When
> the buffer is on the stack, the prog has two pointers to the same stack
> slot, and the verifier knows only one of them. A store through the slice
> changes data that the verifier tracks in the slot: a known scalar, a
> spilled pointer, a dynptr, an iterator. Such a prog loads today and can
> crash the kernel. A load through the slice reads such data as a scalar.
> 
> [...]

Here is the summary with links:
  - [bpf,v2,1/2] bpf: Invalidate a dynptr slice when its stack buffer is written
    https://git.kernel.org/bpf/bpf/c/51f6627d44f3
  - [bpf,v2,2/2] selftests/bpf: Test writes to the buffer of bpf_dynptr_slice_rdwr()
    https://git.kernel.org/bpf/bpf/c/c820e6f70d12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


