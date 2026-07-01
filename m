Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D98D378812
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930039; cv=none; b=lpeNBq3nO262TKiIrOyw4Fsx1bJsbNod0h4DaDLO0hoOTAJ8Zm9vY/uKT/k4LlGIKHxHj2GRmWEOA//omsMhrrTRR3DWuv0eBtfyvYsrKTdDRKyUV3f8LPjBoDdjzL4CRtuFheGeI00M48d0oE0XNpsmFH5dAJT0s2y0vyZH3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930039; c=relaxed/simple;
	bh=MzNIhSrnLBEEgNMskfDRRBnMiEMAMM3YAFtTYiiTfAs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RvBSP/K+wLAnY5k2pCBr/9F8722JveAqA/5QhEUHUOfYLgzpjNW+qjCQKwbtfk6sxj5m+20lAExYqgPUXmgzjjq6APsxWol3bioXYNmsJqfUKVw4I1CIMelEihuThdw4FxYtz1qIb3Qmn0FC7v3pRgYRyjrNOkjEVbLpbh54T7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea5C0MIM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea5C0MIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023A71F000E9;
	Wed,  1 Jul 2026 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930038;
	bh=3MKmp3aVjjCk3PJYc9VjRGB5cfkteyiPZHS/RijXuKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ea5C0MIMhJTXNcw+8DGAdWzYOPn8thKJ3TiBFJDHwzoK4tnSwEa5d/qWxwTUmjtNx
	 kQKh4ECnn9v2JPNSR8gMeRQi2528Lnp/bcJyDwjTVFbm4YnP4QqZ4TIeI5+jhk6cMR
	 bjtrCRRRil2A84+bh+usgC7LzzHq/2/a09u8WIB8fPwHmGJ4pI3wRTXSZ7skMQmKK3
	 V6Qfw20Q1NIJHg4eHOFe4Er8rsFjxBQt7EPsN77rwwnvl9GnVqGGyAQnRUToXPRU8k
	 8nz0i6SmyXfg5eco+l+FZHfn8L5rwd346VCx1+hFoNtfF3idyouT5EnkXWG+9Qv5vz
	 0yMm2eT2MMEBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C9C383B26F;
	Wed,  1 Jul 2026 18:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpftool: Strip all -Wformat* flags from
 bootstrap
 libbpf build
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178293002115.1238008.12470076131335703921.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 18:20:21 +0000
References: <20260630205418.3483969-1-andrii@kernel.org>
In-Reply-To: <20260630205418.3483969-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, qmo@kernel.org, kernel-team@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 30 Jun 2026 13:54:18 -0700 you wrote:
> Commit 9080b97689db ("bpftool: Pass host flags to bootstrap libbpf")
> started building the bootstrap libbpf with HOST_CFLAGS, stripping the
> warning options that are unsuitable for that build by filtering out
> -W -Wall -Wextra -Wformat -Wformat-signedness.
> 
> HOST_CFLAGS inherits EXTRA_WARNINGS, which includes -Wformat-security
> and -Wformat-y2k. The filter drops -Wall and -Wformat (the latter being
> what actually enables -Wformat), but leaves those two -Wformat-* children
> in LIBBPF_BOOTSTRAP_CFLAGS. Building the bootstrap libbpf with it then
> warns:
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpftool: Strip all -Wformat* flags from bootstrap libbpf build
    https://git.kernel.org/bpf/bpf-next/c/a954c9e3168c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


