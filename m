Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF80739E178;
	Wed, 30 Sep 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761808; cv=none; b=duSEikUul47JG4fpYgSHpwMzRfc1pQY75xfz1zeRwYPfysISqk9MdN5uL2+1sRdFlsB2qLoUyOp7ssl4yRvaguUCGvlwiQ+fZDPUO6W2ty8sKrtPS4EZQnLEiZeTAFwzQc5dhEqgiH0TFmGaEqaJ5LW1zR07bHiwk4RvwFIo58Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761808; c=relaxed/simple;
	bh=5y6LVgnjWwkTPz1cIeeaT4TIwMKpVqgkhfGu0EAij9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R81mRIonaHdd5s5wsSpyGNi6X5EVvSOI6TfYnv94A5zoRB3mAgOJRiI9tekCdErHVwGD0rR81SoDYndhxtmmZNvkhWl/idHefVrMk5foCDu4gY8Rm2ZUAaKC/WuCQilurye/db7AGa+r/iTFf+LsEb+sDfPGpJjDDw4k0tS3j7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdYaBDg5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdYaBDg5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457801F000FF;
	Wed, 30 Sep 2026 09:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790761806;
	bh=hwWnQGzX1TyCMOpy7jCup4OjL5a9qx3fkNPc+TvBHGQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FdYaBDg5Z+OYhrjuzoXRrqJL2D/kmJSN6H/BARYMEigNMHYpzzpx/p1c7ry/45Z6I
	 nqEawoWA40+vXArTp+fbv+LVtno7c318CBFjBZOEA4tXKtFl/jztTkIHcDfCPJxDrU
	 8exNpd88YUIDLKwUpJIlfEEuNxUqTmuhzns9H7rt3TPHbKzz9w0hcn9ReTPHtDGukp
	 wfpj4kiSInvLdB3mu0+lU9pppQ84f0sZg2tHktFEPxJQydXymv6zoZFQkiRILBMqMN
	 GI2OvqY9uyZvmPE+X7aROGH44ucHHL3SasFrWj3mZMinnh+kIhy36hJ6mP+lkMlX8a
	 Y0HiHLeouvoUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A29639E9609;
	Wed, 30 Sep 2026 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Fix cleanup on invalid CO-RE relocation
 offsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179076180483.1366309.473741544012834911.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 09:50:04 +0000
References: <20260929-libbpf-core-relo-cleanup-v1-1-c9cd0b5775a9@gmail.com>
In-Reply-To: <20260929-libbpf-core-relo-cleanup-v1-1-c9cd0b5775a9@gmail.com>
To: Luis Vieira <luisflavieira@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Sep 2026 22:56:12 -0300 you wrote:
> bpf_object__relocate_core() allocates a CO-RE candidate cache before
> processing relocation records. Two instruction offset validation
> failures return -EINVAL directly instead of going through the common
> cleanup path.
> 
> These checks were moved into bpf_object__relocate_core() when
> bpf_core_apply_relo() was split, preserving direct returns that were
> safe in the previous helper but now bypass cleanup.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Fix cleanup on invalid CO-RE relocation offsets
    https://git.kernel.org/bpf/bpf-next/c/acff58e30517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


