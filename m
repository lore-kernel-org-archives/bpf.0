Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84F450907;
	Thu, 26 Feb 2026 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134217; cv=none; b=DP2FJecb8+6qx4n8A/VBPBWUi3o5B4nEs2x/UhLZXqzRr9pML542q3/ZOPxno4xOjJWOIhtry5zyGGPTuOZJGdTSOOyaa8+g8s0sLOxGSNTjfGSEBIOyjvDCeqjvpOjpVyINm6T/B7KlFKD70/Wv1DFTK8SgMXSRxx02BMQsnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134217; c=relaxed/simple;
	bh=/TtayvrAYjQqI7MenL7U+5BMtYQ+ExWPGAZG+rKxGK4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/UmXrCWsh3tFrTEyi89cjPDuocyDwXfQtsnsQbu37/yXTrN7EyqxPosOf6H6W+bA/f5YN+L6/OdS3kuc50TIorxepYQbDc6klIwh421eth3Nec644wDXEpDBwf8UihYzPy9/9gjHTqhNn5uaKfGaIgq+poeENtDx/NYMRXsibQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXL3h3Sn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXL3h3Sn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41A6C2BC86;
	Thu, 26 Feb 2026 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772134217;
	bh=/TtayvrAYjQqI7MenL7U+5BMtYQ+ExWPGAZG+rKxGK4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UXL3h3SnEFKfWxsU//2vvm4P0vUnNyYMw+pWikdpDxPugcxGEEV2ci1YOVKSwJtxj
	 vIdnkag8erTxg5BayajRC9Y76EwprmYb9DCJK3f/H28FKP9hAR9y/FRqXxwxTIme4j
	 FKiPUfG/oZeN6gfoMx0ikRw2CdS9tWIvWKGjVWss6o5Jav9iVh9BI5hCpZh6e7vk4N
	 kvnP4kx1Uz7lSHnW901xf6veG5lSIUokJj17qxGb3GOtT5dyo9WeV6LfT3nx3xDHTH
	 QcqkAYn76mwm44Q8rlahp826gcapSMu5PcZOORjYt46u088qxs42xiuq/qCltJj1rF
	 oto3SgSrQu5Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF153931090;
	Thu, 26 Feb 2026 19:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 bpf] bpf: devmap: fix stack-out-of-bounds write in
 get_upper_ifindexes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177213422104.1808439.4101803762888860972.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 19:30:21 +0000
References: <20260225053506.4738-1-kohei@enjuk.jp>
In-Reply-To: <20260225053506.4738-1-kohei@enjuk.jp>
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, joamaki@gmail.com, kohei.enju@gmail.com,
 syzbot+10cc7f13760b31bd2e61@syzkaller.appspotmail.com, toke@redhat.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 05:34:44 +0000 you wrote:
> get_upper_ifindexes() iterates over all upper devices and writes their
> indices into an array without checking bounds.
> 
> Also the callers assume that the max number of upper devices is
> MAX_NEST_DEV and allocate excluded_devices[1+MAX_NEST_DEV] on the stack,
> but that assumption is not correct and the number of upper devices could
> be larger than MAX_NEST_DEV (e.g., many macvlans), causing a
> stack-out-of-bounds write.
> 
> [...]

Here is the summary with links:
  - [v4,bpf] bpf: devmap: fix stack-out-of-bounds write in get_upper_ifindexes()
    https://git.kernel.org/bpf/bpf/c/b7bf516c3ecd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


