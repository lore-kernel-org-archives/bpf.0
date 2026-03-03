Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BC43368B0
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580611; cv=none; b=kYvSSvXeSMjPmOvwQjnvlO6IT65q3vTCgskl4D9laZoIRbzhApAjScc8riH4jtLMQJ4bRHHYkTosWFkDLCXBrhRALm5aHwT2KqHO7jfqGJ4Cl91Fa7koDXyzuQOi4JgLHgvl07egqlJc3TCgyY0cNH5A+A8+h21wS5qqzJPFRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580611; c=relaxed/simple;
	bh=z7WxkVcUFswQHG4gl6UA91fQt16A0FuPKoZf4sB/zoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gmoQnxM2bC7q6mRBxX0ZathAxTxed5YisghFUmEBbsbSkBcQglkGQrCWLIeRn5zrJYGuBgHtQRqrRd46A5Avq0gUm8M5seT+6XOJp6olOaPHD+mZ5yRkk199JuFtO6rmshayxweGimwlv9eDMYWGNghxLU/22KhKra1yn5W0EG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAnMGKBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAnMGKBk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B18C116C6;
	Tue,  3 Mar 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772580610;
	bh=z7WxkVcUFswQHG4gl6UA91fQt16A0FuPKoZf4sB/zoI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dAnMGKBkgHuMexlSKA5Mj6KIb/wgwJGtpKYzKVgVmo3LFHXvME1skDW1n8S5EGMqS
	 5QBDcFdf0cuHImahyPSrxKXh8N/p6OQj8Bj5xcnjJvnGMVtaYRl7UqWeZlFAIZKRVF
	 Z+bvIHcRLDP7sO+rmBf+Bzb3z02ueqlgcxOeqaFeXEy2iOi44wYFdUW2eFyUOgj1CF
	 31Fu45KKGP2erbDZzYG8lbXscPRrDDFd00G9XpvH2SK0/sHtNqdmm2yWvfRq3cfY9k
	 /KXhi2v+m60NTBU18M7fopWJ/fmZZFaOUfv2iN0OGYo556gfpP7iOvpW2AGBAptb4L
	 hSkNhNqkGMo/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C9C3808200;
	Tue,  3 Mar 2026 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v5] bpf: fix: Race condition in
 bpf_trampoline_link_cgroup_shim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258061155.1514859.17135134965646626818.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 23:30:11 +0000
References: <279EEE1BA1DDB49D+20260303095217.34436-1-xulang@uniontech.com>
In-Reply-To: <279EEE1BA1DDB49D+20260303095217.34436-1-xulang@uniontech.com>
To: xulang <xulang@uniontech.com>
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, eddyz87@gmail.com,
 hust-os-kernel-patches@googlegroups.com, ihor.solodrai@linux.dev,
 kaiyanm@hust.edu.cn, martin.lau@kernel.org, martin.lau@linux.dev,
 sdf@fomichev.me, yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  3 Mar 2026 17:52:17 +0800 you wrote:
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
  - [bpf,v5] bpf: fix: Race condition in bpf_trampoline_link_cgroup_shim
    https://git.kernel.org/bpf/bpf/c/56145d237385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


