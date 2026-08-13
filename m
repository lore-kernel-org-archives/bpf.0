Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9031E858
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786585255; cv=none; b=Wh/0XFkApMcQTEFAfHPQrVdXJ4K4q3ELQZl/R3uD/hsy3ppLnqDXkHYhbXMZidLm2pClNXqXp9HFh+Vg1GCtfEYdbc3+zePPd1hw7Bjj6+XUvMOyOJjeFGYUPsJyK73oH+cOvK5D3nvKZQR5ZF1an6SDLq5NF9a04BhUnzKBiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786585255; c=relaxed/simple;
	bh=J11Fk7oIlS7nVV7K2EG/hViqeZkoTU2eahNDo3Bt+Xo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocDgLOhLDo6VYMjYwZTRc1vAZHpJdqBq/Xtau7XfNLyd1oq+nAMSW+dr/FNFoT6N3ceWo7Es7vAsUI8+kEAPuQSflhQe9zurcZUTcXWN85rgFP+7HMASD3YVLVBEhSlxWK/DncpS3J8EIv+qNojli9WagCaENncAyAqQHSXUY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOSS7+vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOSS7+vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F4D1F000E9;
	Thu, 13 Aug 2026 01:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786585254;
	bh=GIodWZsSmqrg2TcFS4Joj/KVGRUu1Vdovti/kK2o6m4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OOSS7+vXySCwRTNGQOqlChu+5sn+kYvMyaZntGo2F8KllZQnU7TcvYsoQINfYMfOC
	 WUkyyzIXfpTWBnuhslRRHuoBm7oh6L6ghlOIvpkIEJIdptPwaxtAseKmF/beuvoQvq
	 dn4zM/XN/StEd8UnO4O1Vvm11xo1FxZ1Ek3amspJU+9PJO2o3fhhdUhx5s+ZMT5JbT
	 C6yW4jX0B/yCKGBanN+cV7obUSo6qbrRy3nDCnMZhgN5ZjdwMMWQEUV7dVjXqhiTkP
	 pOkE2bwc+BqV1xceByY40JHbX6vtol5FeXyR9OYKg1NlFelx4xsmJvSlaNmG3OOKzz
	 8n/DOHz2iDhgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56994380CED0;
	Thu, 13 Aug 2026 01:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] Add resolve_btfids support for __arena
 kfunc
 suffix
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178658520889.2182080.5468635531638484325.git-patchwork-notify@kernel.org>
Date: Thu, 13 Aug 2026 01:40:08 +0000
References: <20260812193842.2879226-1-memxor@gmail.com>
In-Reply-To: <20260812193842.2879226-1-memxor@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, emil@etsalapatis.com, tj@kernel.org,
 kkd@meta.com, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Wed, 12 Aug 2026 21:38:39 +0200 you wrote:
> Use __arena/__arena__nullable suffixes to emit address_space(1)
> annotations on kfunc definitions in vmlinux.h. See commits for details.
> 
> Changelog:
> ----------
> v1 -> v2
> v1: https://lore.kernel.org/bpf/20260809085155.3305519-1-memxor@gmail.com
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] resolve_btfids: Emit arena attributes from kfunc parameter suffixes
    https://git.kernel.org/bpf/bpf-next/c/5e31d32843d3
  - [bpf-next,v2,2/2] selftests/bpf: Test resolve_btfids arena argument suffixes
    https://git.kernel.org/bpf/bpf-next/c/d7842e98ca17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


