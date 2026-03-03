Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBA351C11
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580605; cv=none; b=oaPdRIZ5syIyGzq3yiSGfxt6KSWm45+NqTROu6OrLWTOhPgr9Ce2wTWqzb7vN+2WhUQPAKncqm2RVVIEwUw3FWw0ZgpKTFihJhFj3aNQ3jbw5vgKmzqvnbH0n3CJiIbDCGMmosXnqq3RKwzDPaGaqH5vpardcCywMWVeVtbdLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580605; c=relaxed/simple;
	bh=h1+DZye/6A7Rm2G6LemtJuFPGjO+0U/hnnGySl+Qvnk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KfH8pL1De1LXuDmlXdQLYwMKEBWugtx9IVvuqG+/GR830xc/WgHUd86/UtIhOsburDTpD6SquW7NZPFJUM8QitoYui6JNFBzPArR6YlT8DK2bSCwqWCM1e+CE37linMYjqq143YBh9rn2FKYKzJQhJPlYf02wL7rCbAO8/HcjmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilBnIauH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilBnIauH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED3BC116C6;
	Tue,  3 Mar 2026 23:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772580605;
	bh=h1+DZye/6A7Rm2G6LemtJuFPGjO+0U/hnnGySl+Qvnk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ilBnIauH4+07l09L+yvVjTGSplMnfC9a0tR1i8ZMygexlb2BEmc11TR/B280RtlHM
	 FAfMkib2mCv+LWN5g1aOzdy6UWX2rFKOnC9nESKd82El/Dy0hGD6e/Ioq419EUlO+Q
	 9hC4z5UQ4deHrPMmF7WjmAEuWC1KMeWB6tF5w03N4atYPQpXqSyFR+aVez1JJiDd+t
	 kPsvyRgaAJLsp30inaAXaSQ6dWuz2BcELA6bG3WM9LW6rZRN44yf81nkhgBuoIU0UF
	 c6BqCDX8JpY7+OMvYD3o7c1cpDcby6htGQtGyX/LvEA87jdrkJsMh2aclvy8XGMXUj
	 Ky/NO/l9AyEwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE5B3808200;
	Tue,  3 Mar 2026 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4] bpf: fix: Race condition in
 bpf_trampoline_unlink_cgroup_shim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258060605.1514859.8771485378779224297.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 23:30:06 +0000
References: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
In-Reply-To: <851F26B7D9E91336+20260303083626.1107524-1-xulang@uniontech.com>
To: xulang <xulang@uniontech.com>
Cc: martin.lau@linux.dev, andrii@kernel.org, ast@kernel.org,
 bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com,
 daniel@iogearbox.net, dddddd@hust.edu.cn, dzm91@hust.edu.cn,
 eddyz87@gmail.com, hust-os-kernel-patches@googlegroups.com,
 ihor.solodrai@linux.dev, kaiyanm@hust.edu.cn, martin.lau@kernel.org,
 sdf@fomichev.me, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  3 Mar 2026 16:36:26 +0800 you wrote:
> From: Lang Xu <xulang@uniontech.com>
> 
> The root cause of this bug is that when `bpf_link_put` reduces the
> refcount of `shim_link->link.link` to zero, the resource is considered
> released but may still be referenced via `tr->progs_hlist` in
> `cgroup_shim_find`. The actual cleanup of `tr->progs_hlist` in
> `bpf_shim_tramp_link_release` is deferred. During this window, another
> process can cause a use-after-free via `bpf_trampoline_link_cgroup_shim`.
> 
> [...]

Here is the summary with links:
  - [bpf,v4] bpf: fix: Race condition in bpf_trampoline_unlink_cgroup_shim
    https://git.kernel.org/bpf/bpf/c/56145d237385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


