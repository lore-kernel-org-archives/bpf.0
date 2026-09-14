Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A736AB7C
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789361472; cv=none; b=KBR12aXFXJ/4W/Se2aBHujAauHV5Or7/6oHM+pGQcVyFfR6h82DF+zsGodX6CjH2kDXj/dfEKFw0bn6+E5biRHbazegEF/Qkb5MqFRQdqZ7mWqPq+IWs4id31YXoCDa7Awkjqme91uWLVvgP98m3vfbfxqkudiyODrkLbruoEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789361472; c=relaxed/simple;
	bh=MTL7pxnW/G7xUdKeg1dJLENJ5A9iaXLhjdf0iUYOzIg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ihgGmcIM18SFMUrVtMCwqGsU0rGJ7Kjo893So1kGYFJaRZnTOTCTdlcC3uSpFgR1H9TP0m7jafaKrK2nxlj5N9K/sWGQfiZSKDDFZy73cnHlWMnK9vkQdUm6FFX5I2/CbPUbKOZHZFtuoJpqIjgtnW0u6PNlOuUlmGHdxNCrWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNVM8vYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNVM8vYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0CC1F00893;
	Mon, 14 Sep 2026 04:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789361471;
	bh=c6DPgZRKeA/slwIggIFjqzQ+cX+q9VyDxbuEV17g49c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NNVM8vYu4UgtjQwFdQxOC4jqdS7LAIUNHhh8eV12FWZvW0KrVPOST5qO+NHx0aRgb
	 pcqh5cu7H/3NVn9AMagrBy8bv6uubQckpbOI5Dd3oNnLQSm0NTZhF1MMSTQ3TBB42C
	 67PxV7Wf9wlMj/t94yooMlPJIVdijFR3l7dLV0U6OUOwHA99+69lmwfi78q0lS/FOx
	 gKO0TMd/ZOJ6tAZbNS7vlJAh/7ZFzdqGtTGR5Likny/gIf+ys8Bmp9kgIckmvII6Ks
	 Uahxq+eKKE1uS3vXEMiZ79TbloGHUb/Z2t+sN5gB0JtBSr3q62EFwnM5MIlc4W0cU3
	 aPD4d5DUvo7/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93878380AA63;
	Mon, 14 Sep 2026 04:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] libbpf: fix log level propagation for light
 skeleton loaders
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178936140614.322883.4495787220749713017.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 04:50:06 +0000
References: <20260907170536.9996-1-mahe.tardy@gmail.com>
In-Reply-To: <20260907170536.9996-1-mahe.tardy@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  7 Sep 2026 17:05:36 +0000 you wrote:
> bpftool's -d option is documented to enable bpf_trace_printk() messages
> from the generated syscall loader when used with -L as specified in
> commit d510296d331a ("bpftool: Use syscall/loader program in "prog load"
> and "gen skeleton" command.")
> 
> However commit b59e4ce8bcaa ("bpftool: Switch bpf_object__load_xattr()
> to bpf_object__load()") changed bpftool to use bpf_object__load() which
> call the internal bpf_object_load with extra_log_level to 0 instead of
> bpf_object__load_xattr with the user request log_level.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] libbpf: fix log level propagation for light skeleton loaders
    https://git.kernel.org/bpf/bpf-next/c/e18e82ba9ed5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


