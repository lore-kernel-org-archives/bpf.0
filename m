Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561807;
	b=PZBNDVdEzz2iuwLFT8nynkN+N9rshAGpFNdnMVrwqQGYSGBFK+GKu2yFPue25ovkAJYy
	 mdG29IP91uPDSbG08CvwwZprrj8HAT2DLYxmJ3OzohvUD5577soht59JnCM3YLOOghhMw
	 YShqyBAiW+2ksDX2ay3PsErXmtDR0rMRGxRcb1+/TRY2crvCx1/J97Gf7AYCaEn2NryUt
	 X9hiblVXWeD9NeRtFzAAte42PiexOriDJff8XAsKNx7reJbOBNRqCed2vC31MNBVrhZJY
	 IJAnl23wawZhTxIK703aaoXQhHDXtpEu5IjMcrabMZNYJHfmaI2+HvpyHzwpOaM9bqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rN/sV7IyT8KjUBI96vkK7PxN3EFFy/69U9dWXOK0UeA=;
	b=YTP6eY+LMAcfe2OkgtmvXrA7MqbG7OK1X6jzokncgKziuL5DNOAXcVceaHbPqCkY5SJ6
	 eXoJPgDbacvGfz2oUqh1LNpwzAJzY9fDWtvO1NVcKYcwdzLEB7GOvJZBouXkIWY/YKo2z
	 CFQ26EjxFUjvHLT9eaIgCO5NxnxCE/c53o5Cr/kaPKz+ZqPYohdIhIdWKHlFGNdlQjS2X
	 P74Y4MOy4bGqsi0uoI4pmdcA/sTjUh0LiTj7Pnm8W8l5YpuQ6vuEeG9pM/UZl/h2Y/YZN
	 ENsDERLUohNxcsqo3vsc3Z2kZe+lTW/UVklpBerSpnIpTkHmoL8NcpoguKzQ26h0m6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lY1l3cJ+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E298E606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lY1l3cJ+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5DA1F000C0;
	Tue, 24 Nov 2026 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561806;
	bh=rN/sV7IyT8KjUBI96vkK7PxN3EFFy/69U9dWXOK0UeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lY1l3cJ+3Y9PtQyRxP3jaRI/hHvaoT8axdNKllnay0y8p8x25UMHS7CMg0Svnt9eZ
	 1xRCTBNQhG1SMPna+d7WlslrVx+pSSuGo8UoUrk+4CHWxKGCj9+WaoleUbtgRN0v8x
	 DrwiDl0weELiMTjI5QYTFOGYQMaUNNz/sapjVBfSUnzqiu9bct3QveXqpDHM21y9zO
	 wnpYIlYeFVquFEfPZIwYv8necEC65GlFE3dEmjLOT6FCMkFEgcs9lCCujGfM9TeFVp
	 xXrTT1+SOY3du/mn1uNSduw4VfTlXgeO+ATwyr4HIMUeFkc5oC1S28RpxDStnOio2z
	 lGN52ubKQwiiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773B73808209;
	Tue, 24 Nov 2026 23:10:06 +0000 (UTC)
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
Subject: Re: [PATCH bpf-next v2 0/2] Set the minimum required pahole version
 to
 v1.24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179556180527.106325.13942817178545155085.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 23:10:05 +0000
References: <20261124024629.3871056-1-yonghong.song@linux.dev>
In-Reply-To: <20261124024629.3871056-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, kernel-team@fb.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 23 Nov 2026 18:46:29 -0800 you wrote:
> The requirements table in Documentation/process/changes.rst lists pahole
> v1.26 as the minimal version, for kfuncs with KF_IMPLICIT_ARGS, which
> resolve_btfids now handles without pahole. CONFIG_DEBUG_INFO_BTF, on the
> other hand, still accepts pahole v1.22.
> 
> Patch 1 sets the minimal version to v1.24 in Kconfig and changes.rst, so
> that the kflag of an enum in vmlinux and module BTF is meaningful: 0 for
> an unsigned enum and 1 for a signed enum. Patch 2 removes
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE, which is always set with
> CONFIG_DEBUG_INFO_BTF now.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] lib/Kconfig.debug: Set the minimum required pahole version to v1.24
    https://git.kernel.org/bpf/bpf-next/c/138ede2edc50
  - [bpf-next,v2,2/2] kbuild, bpf: Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE
    https://git.kernel.org/bpf/bpf-next/c/4006ad28b7cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


