Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB8366833
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770144016; cv=none; b=mF7IR4dIjpDOpQTJjDNFUgQtl0pl9sRBoi0jDz2hNNb3GihBW2PIuaPkgLbCLoQU7adAXLssNZjEQlF+OlI4W5XaLZoy5Q9nRehFPhC2Q9Z5jZ9Mq6lhPV6pCkTrVTgiJu9pGGXdnF1rG4kBUpkcxODYnahnwNukZD/fFNg+B5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770144016; c=relaxed/simple;
	bh=sNjJUXuCAiRYtkPVV5Ky/Ukpac4O79YLrNzW7ivPcgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LetAZW/ECjl1qTM5R9XahJzK/XR1hBEPsYLEFghiRlkkaSBgqS+h54dWSJ7wGsF+WKZAmrGzqmM3UlQrLm1mSYzmmNu0moPvvfF9JUvZAu/hZ4CUXDP/Kv1sND2VoUMplufwCXolCQ0r1nFJtZ3emFIkiNO0fsF1EyNrjwJNpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzzTAOCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzzTAOCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EECC116D0;
	Tue,  3 Feb 2026 18:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770144015;
	bh=sNjJUXuCAiRYtkPVV5Ky/Ukpac4O79YLrNzW7ivPcgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uzzTAOCotgcYuqWWU5XaY+z+N5XFXz2B69hoRRf3EKvaZFt9grCP4RzNu3Xpr/bUu
	 rqulHoiJEStF8Xf+lYaCZUKs3bpKrHaJTKPYDBWz/Vf2mK1PnoqA+iqCRQYFVfPtMQ
	 w645xTyEBrTbn+5m0AZBHEBQTFnRk7doUaq+qzSagWKj4n5QxNHca74dGGwWYV343b
	 g9AJTL2W0nKwePJIxLTi5dSlEsX+hoLtCS++M89rmA4Gy3JwRiaEH04GZdrHoR01Mx
	 pbq8W9edRxvnltajgR22Vls9JIPiW04neRLIb983Su+OCiNkBWJQXSePWclKpvbmpE
	 xCxS2hUyokGnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CE0463808200;
	Tue,  3 Feb 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3 0/5] bpf: verifier: Improve state pruning for
 scalar registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177014401163.1597022.5779253745242388746.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 18:40:11 +0000
References: <20260203165102.2302462-1-puranjay@kernel.org>
In-Reply-To: <20260203165102.2302462-1-puranjay@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, puranjay12@gmail.com, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com,
 kernel-team@meta.com, andrii.nakryiko@gmail.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  3 Feb 2026 08:50:56 -0800 you wrote:
> V2: https://lore.kernel.org/all/20260203022229.1630849-1-puranjay@kernel.org/
> Changes in V3:
> - Fix spelling mistakes in commit logs (AI)
> - Fix an incorrect comment in the selftest added in patch 5 (AI)
> - Improve the title of patch 5
> 
> V1: https://lore.kernel.org/all/20260202104414.3103323-1-puranjay@kernel.org/
> Changes in V2:
> - Collected acked by Eduard
> - Removed some unnecessary comments
> - Added a selftest for id=0 equivalence in Patch 5
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] bpf: verifier: Assign ids on stack fills
    https://git.kernel.org/bpf/bpf-next/c/3cd5c890652b
  - [bpf-next,v3,2/5] bpf: verifier: Clear singular ids for scalars
    https://git.kernel.org/bpf/bpf-next/c/b2a0aa3a8739
  - [bpf-next,v3,3/5] bpf: verifier: Relax maybe_widen_reg() constraints
    (no matching commit)
  - [bpf-next,v3,4/5] bpf: verifier: Relax scalar id equivalence for state pruning
    https://git.kernel.org/bpf/bpf-next/c/b0388bafa494
  - [bpf-next,v3,5/5] selftests: bpf: verifier_scalar_ids: Add a test for ids=0
    https://git.kernel.org/bpf/bpf-next/c/f6ef5584ccb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


