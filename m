Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87247362
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 00:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4B67C433C9;
	Wed,  9 Aug 2023 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691540421;
	bh=KEvH3+b7kuYeVQWe6aTN19ry/olxY82t66djGgRmCOU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K3YiVAcXw9TH4rnAmFUqzla3unLOraZKN1jYqR5pVDlAll+tsndyUeJCEvV1Go317
	 aURqyEZSlBkIKg4Ph9smgCvT/wxqj1PSxkGJXRehT98Z46UB0y87Q+qOx1IZlU9zQe
	 8P9TquVFyCakxaENk/uo9XsjoKxbgNyC+zOH2/zg6oYrdvT1P3fV9NSidcvV5OYCEI
	 80nGplZgMT7958xs3aTRxMwX71HsdeXrW56mA9m3ecu8nRCJkmlng7fmNX8HkTuU21
	 Rk5BgQE+426TqT22+TlksaR35avEvzDoYWalMZdUYh0P7HL/A2g/Mc8l+VsqOppAll
	 jqXQHNtLiT7FA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCC27C595C2;
	Wed,  9 Aug 2023 00:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: relax expected log messages to allow
 emitting BPF_ST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169154042083.15967.1548393556107526816.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 00:20:20 +0000
References: <20230808162755.392606-1-eddyz87@gmail.com>
In-Reply-To: <20230808162755.392606-1-eddyz87@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Tue,  8 Aug 2023 19:27:55 +0300 you wrote:
> Update [1] to LLVM BPF backend seeks to enable generation of BPF_ST
> instruction when CPUv4 is selected. This affects expected log messages
> for the following selftests:
> - log_fixup/missing_map
> - spin_lock/lock_id_mapval_preserve
> - spin_lock/lock_id_innermapval_preserve
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: relax expected log messages to allow emitting BPF_ST
    https://git.kernel.org/bpf/bpf-next/c/898f55f50a00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


