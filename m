Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC0F763E3
	for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710448829; cv=none; b=e12u9URCPJas7CawmqWJvol6/Q6DobDsiJK/WIyqD+9cr6jzSuGcA6xta+jLnfY3EBFCIHpzW3GqqBFDVSAUHYxRxeVxvYG9ieKZICL7rexEMS38XY0rfc2B7lvbSKwffWezm5jnu9nbcuQt7cbhX3ESGK1Rzh5ZWqq2QecpGyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710448829; c=relaxed/simple;
	bh=bqT2Cdc5gcE8pkAQUCMqYa8RV825pWxiP8bPEB8Wd70=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kzkxXaLlmu+ZTB/gc8ZF0WHsI95MxvBZTw1clPw/td+vgnGkhDK9Cxe+7+9lAE1tHyokq/JxAVa1dmC8vaJXreqVbgMj9ClU0CX8Dubbn7ys/OJgjYEltl5P7p8mng2nK7ZHwnH9jh9ZRPcPvfNsf/RjXKPd353oWY/yGMPFumA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3m00Qi6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3m00Qi6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A817C43399;
	Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710448829;
	bh=bqT2Cdc5gcE8pkAQUCMqYa8RV825pWxiP8bPEB8Wd70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h3m00Qi6+HMDgVUQZuHtOkD/pizl//o8cMdEqwHGlOOBMMqkjwy+ggg8YDgNpAnWk
	 FnjgD/9BZCzyZmyO2owm8asr7D552non93TbBWd5AuYq6fm3fsE/gmBwzp7ANqMjA7
	 6tHe7Eua0EuuOyz2bd8b+80kjLwXXEK9WGPMmc6NAnYqTKJ4yGRnMEiCecB40ud/kl
	 hF7/sX5D9TVSeoyrx07ZaokNCrnd5NxU3ArK5Qy8kVpB8/ZMiAOCkKrDh+qn0EUA4O
	 UesGBbd/cKKwVc0p8p2P4n2YlPwDPfTIUcxlbwUwzRySZrk1Z+zGfLTY0mplEisSZV
	 0Z1H6zhnDY8VQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 373E3D95055;
	Thu, 14 Mar 2024 20:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types explicitly.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171044882922.16494.13730909982816183721.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 20:40:29 +0000
References: <20240312013726.1780720-1-thinker.li@gmail.com>
In-Reply-To: <20240312013726.1780720-1-thinker.li@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 sinquersw@gmail.com, kuifeng@meta.com, yhs@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 11 Mar 2024 18:37:26 -0700 you wrote:
> According to a report, skeletons fail to assign shadow pointers when being
> compiled with C++ programs. Unlike C doing implicit casting for void
> pointers, C++ requires an explicit casting.
> 
> To support C++, we do explicit casting for each shadow pointer.
> 
> Cc: yhs@meta.com
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: cast pointers for shadow types explicitly.
    https://git.kernel.org/bpf/bpf-next/c/c2a0257c1edf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


