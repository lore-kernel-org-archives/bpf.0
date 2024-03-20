Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CF617BB2
	for <bpf@vger.kernel.org>; Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915629; cv=none; b=LA6FquSCwX6oGJLSS5SPycGSHVvo/Is9LbrBqFeTwmgCVitxERgjJhx4eHdqcb8zGUU2M8s38HLTPu1NVnyXc1kUsDAZqat9ps3KGC8KBdKVzAdrOaWyNMeGvoFh9nvVH/g0wdD0Xk1gawXYXN/8wmOCefMVcpQe3dK8iQFHLiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915629; c=relaxed/simple;
	bh=N1VYdNMznqb3k3DoT/NDo15q/HQlO9rKlRQtB3g0oE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rc+/ozB/luHl3usc5C2CgB2Uor6AhctnwZZ5LOrOnLUaLyKG0A4PXvMPGT1TB/uadrtiE4xkcniW55cQ6moP80JxHNVch0QKkok6BrGmsH35isQ2b1cH3a6n2gfH50Dz9vDEx6RWExz/mQyqbGKRFQPm6VxC3Wq9SIWMnsIuMxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn+UtJYZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn+UtJYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43917C43390;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710915629;
	bh=N1VYdNMznqb3k3DoT/NDo15q/HQlO9rKlRQtB3g0oE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cn+UtJYZ1RlsJADAvVnJ4npLTGDWbTrAaXsYkMSFEHj4MfWGneK9AGqoqrIAm1/nR
	 aMTRVfAaak2z96zbws7PYnH3lXd5reYZGeBzYn8RP9/hoQWT0e0w1fRc5lVJscqwfi
	 aYFJKqmDy7gGC+IYT9tI+wKyxN8C9FID8qvvAZqez2mSpo9ZCzSZhq69WAXYIOMijK
	 OE3MCfzbe89aVJZUi1JoMkVCn/9lBpAQriJR9B4ul80mnP24TTt8bjitt09gPPu9jg
	 QNXLY3a+vWdcNcVl0vxrQB/wlFdpkT8LUoaZUrP0IODayO/2KIGkvxWpe0QL5IF3Pz
	 S/ntcTMyQvHJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 340DDD84BB1;
	Wed, 20 Mar 2024 06:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next 0/5] BPF raw tracepoint support for BPF cookie
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171091562921.21070.14872499414602843823.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 06:20:29 +0000
References: <20240319233852.1977493-1-andrii@kernel.org>
In-Reply-To: <20240319233852.1977493-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 19 Mar 2024 16:38:47 -0700 you wrote:
> Add ability to specify and retrieve BPF cookie for raw tracepoint programs.
> Both BTF-aware (SEC("tp_btf")) and non-BTF-aware (SEC("raw_tp")) are
> supported, as they are exactly the same at runtime.
> 
> This issue recently came up in production use cases, where custom tried to
> switch from slower classic tracepoints to raw tracepoints and ran into this
> limitation. Luckily, it's not that hard to support this for raw_tp programs.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next,1/5] bpf: flatten bpf_probe_register call chain
    https://git.kernel.org/bpf/bpf-next/c/6b9c2950c912
  - [v3,bpf-next,2/5] bpf: pass whole link instead of prog when triggering raw tracepoint
    https://git.kernel.org/bpf/bpf-next/c/d4dfc5700e86
  - [v3,bpf-next,3/5] bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs
    https://git.kernel.org/bpf/bpf-next/c/68ca5d4eebb8
  - [v3,bpf-next,4/5] libbpf: add support for BPF cookie for raw_tp/tp_btf programs
    https://git.kernel.org/bpf/bpf-next/c/36ffb2023e37
  - [v3,bpf-next,5/5] selftests/bpf: add raw_tp/tp_btf BPF cookie subtests
    https://git.kernel.org/bpf/bpf-next/c/51146ff0fae3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


