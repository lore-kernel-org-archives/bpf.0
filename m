Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836812F585;
	Wed, 11 Feb 2026 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776410; cv=none; b=iAqzNIv2hscLoD4Yfc6DjwHyPw7KA+f0h6Z7z0+RBPzi/otfXWiGjAHu2BmqnPlIr8Amos9tDDDZLGhspoupHyBZKTT10EcRgucPqfDs8SDA/DRYPtUdMbI3QVQe+QfdY1kZZpbmeSKmoTdg+D3+ZNifX/WcRGRRG2RKxDQlUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776410; c=relaxed/simple;
	bh=9XwUKD9P0t/5B8oA18NxLYnMdHU1dnfF3o4wlA7Ls1Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=trlHSM5/pIM0uog4yPK2pbWc570Hmg0N0MPBrxUD4JXyJNoXy7ZokP6qbrgu9vFsMyx1eAXDhIS0XRICut0iOMc3DGBDlKQEnPvKybGPkuYlwvBkTKWvlR+joMuUQCH8hPweVmpf0xs4+J4aTLAhlJ88jzalnDcZwrY+nieoKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEU9htVJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEU9htVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9552C116C6;
	Wed, 11 Feb 2026 02:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776410;
	bh=9XwUKD9P0t/5B8oA18NxLYnMdHU1dnfF3o4wlA7Ls1Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lEU9htVJ7+GohpCzbDksGHyl7iRLq+xPtISnwMKnODWccCCQqL7FL6B/sNLLis2eQ
	 w872GkGgSEpeZXGZ//qAkIfRHr56Tx3+ggUrH3QprLRQpK+Z2N8X46rJd2XswgkXnt
	 PnnJfoAa2281KkSberUhtQ+HpXWOgzyHYGJpqBq8KhB1xL0489776eD2NW4qzTgG+e
	 t2TkoUV5QUTxOWMAHZ6XVG905oTXQffmBkZOy+PvMrUOdVhBtjwLLJzYr2RP0t036D
	 2X/JrQYeYDcmY6xnDIv361lj53aX7BRo6k45wMq2rfBoxvUH9+nQPNGCXH7Wqtq8hA
	 cNwnlMOGUtV8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4814239E3B79;
	Wed, 11 Feb 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v1] selftests/bpf: Rename do_filp_open() to
 do_file_open()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177077640508.4160838.11857900603243131631.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 02:20:05 +0000
References: <20260210235855.215679-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260210235855.215679-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 daniel@iogearbox.net, shung-hsi.yu@suse.com, viro@zeniv.linux.org.uk,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 10 Feb 2026 15:58:55 -0800 you wrote:
> do_filp_open() was renamed (fixing typo) in commit
> 541003b576c3 ("rename do_filp_open() to do_file_open()")
> 
> This broke test_profiler, because it uses a kretprobe on that
> function. Fix it by renaming accordingly.
> 
> Fixes: 541003b576c3 ("rename do_filp_open() to do_file_open()")
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Closes: https://lore.kernel.org/bpf/djwjf2vfb7gro3rfag666bojod6ytcectahnb5z6hx2hawimtj@sx47ghzjg4lw/
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> 
> [...]

Here is the summary with links:
  - [bpf,v1] selftests/bpf: Rename do_filp_open() to do_file_open()
    https://git.kernel.org/bpf/bpf/c/1a7eb7a3d740

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


