Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7341B7E6
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710914429; cv=none; b=NCB6h5AARidmtfl4CO6tYN7qOmHkgyq4gtheCSENlyK9/tDF9ztf4XtGn5iiXzxkjo7BJOwAqWfVyfVQ1QrPNwBju6JKpF7vd6ih10J8pylvgARnJpXNXs/tVtuq+mF+uLhFO/gHS36eir7TfUzc2wFHWyV/imYN1QakxzLXr0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710914429; c=relaxed/simple;
	bh=jpMsw7EXvr5kjwTeMoWrcS9vr/pSiBNBFXFg8KfRhWg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XdZuWTTszTkH3MaI2SkPYA/jSKN5nRVP5XzUsGSsMaaA023S1SX2SJ81TQLhvRIgYJzlgSTfMx72dqCKpSJ/CqBcApNX54Hlu1BOsbW2L3kzkNN7A/SzlZ5DeTMsFItlIF42RT9nt8SmovoK1sK6fkR77HoV1mO2QVBfAwypNpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKZBigVb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKZBigVb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02678C433C7;
	Wed, 20 Mar 2024 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710914429;
	bh=jpMsw7EXvr5kjwTeMoWrcS9vr/pSiBNBFXFg8KfRhWg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GKZBigVb94wsN2Ysv0lvFeqt+otECRrL9IqxCQQcf3I9BcrYfn2kzv9E0F9YFpo+q
	 9q+dbs2SXDgwJEaZ9BJd1JWEJYPhnufWis5+6g6BBdcgoDLTMEgh5R/J2RXmIfELzE
	 fcu2wJSv26j0NlMgUnV/2NO2NxSZEYgkGvN2YIFTrdLtIXXIDy/dFk0FUl4BURylsQ
	 JR7P0C5IgczF4Z1Lo/IIR90QL/ckRf/TPBTSOt1nBccelfmPp29OP0NvoO69KeBiCQ
	 60L9sO2Qu5dUF9ZTbAjTrqxe1B4JS3d+q72GVNSzm0Lz21VNfmqwEfpZB5XgdmE1Zf
	 6sTrtZaOupT1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF142D95060;
	Wed, 20 Mar 2024 06:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] libbpf: fix u64-to-pointer cast on 32-bit arches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091442890.8613.16011763916021271085.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:00:28 +0000
References: <20240319215143.1279312-1-andrii@kernel.org>
In-Reply-To: <20240319215143.1279312-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, reatmon@ti.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Mar 2024 14:51:43 -0700 you wrote:
> It's been reported that (void *)map->map_extra is causing compilation
> warnings on 32-bit architectures. It's easy enough to fix this by
> casting to long first.
> 
> Fixes: 79ff13e99169 ("libbpf: Add support for bpf_arena.")
> Reported-by: Ryan Eatmon <reatmon@ti.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] libbpf: fix u64-to-pointer cast on 32-bit arches
    https://git.kernel.org/bpf/bpf/c/5ab8cb89dbb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


