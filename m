Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE773B18A
	for <bpf@vger.kernel.org>; Mon, 15 Jun 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483429; cv=none; b=BbQkiNg6q55GmCqFCJGIv7tMr7s2TqXAjdOmD7LCBa3RhfvvA78rXUqaLTkwgoW9Q8gJsCI7TArKTD9en4ytrZlVJvSMBngW6WJsPDzlad25LVgLl8GhuBLJYW/Xn9o52DhLPdZNuD3QQqnfCcYlQ2cBpxjlw57EgQdmLL31Zt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483429; c=relaxed/simple;
	bh=QLQKd5Ns3n7ynNssBloug6ACU/G135w/DKEzI0zcvrA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3LK3epFfOGLgAhbxqbvCL04HaU2GyzT1g6v8HtFU48e+zyozM4Cqawok6VNM1jhrhYZG0wHqPj5kDDsA6DFIPDehhPyF1q/SrMaXnrCSdG1bdjW4yPGKKD5izfkWpRxEfVqPO2Kz9zVNsAi2+1Gbd1KLxQRpx5ApQQ8xLuCj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHhm3ou2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHhm3ou2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193F91F000E9;
	Mon, 15 Jun 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781483428;
	bh=NSFkOyNP6vANPHZCqP9tUfQKZdruHSLSFuEXFApsQyc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gHhm3ou2m/lsMeeRKH81tKzbLkeqmB51Xh0K0MP1x5SF+0N0QqPl5VnmMHBLDpfZJ
	 266Y64wkdrresfdD0ZZJpfBQlDnyqA+BKF4varEYYbZBE/GyPMSqyGqXgqiYZj9bi4
	 j9BFYZI1+G2C2/MgztWWtl0mIPiH/xUp+k2/zgZkDCP4yqgNWTNbTG9mP3rT2OfSlm
	 jcPNGYSzRPui5WbUOm5RoRXxFCFEgCK6iYc0QDJT+aszmo2oda/1x14YSeUEoiFg35
	 I9dT+N5MS6a0t2td0Yv/llNg2vdBQmrZLcuLnLmR+2c3gPWIR2lpU+0l9IUpxe095v
	 6qkO9K0tVgxWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A723A566D2;
	Mon, 15 Jun 2026 00:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv3 bpf-next 0/7] bpf: Allow uprobe_multi binary specified
 by
 file descriptor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178148342339.2360960.8113242983343926626.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 00:30:23 +0000
References: <20260611114230.950379-1-jolsa@kernel.org>
In-Reply-To: <20260611114230.950379-1-jolsa@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 bpf@vger.kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 songliubraving@fb.com, yhs@fb.com, oleg@redhat.com, mhiramat@kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 11 Jun 2026 13:42:23 +0200 you wrote:
> hi,
> we'd like to be able to open uprobe_multi link on top of binary identified
> by file descriptor. This allows us to avoid the race where the binary is
> replaced between path resolution and attachment, ensuring we monitor the
> intended binary.
> 
> v1: https://lore.kernel.org/bpf/20260609104244.588321-1-jolsa@kernel.org/T/#m0275d5f39805c57dc8fd3308c640237dc7aec4db
> v2: https://lore.kernel.org/bpf/20260610143627.804790-1-jolsa@kernel.org/T/#m153e18fa426140fdcc773cc97b10e006531656c0
> 
> [...]

Here is the summary with links:
  - [PATCHv3,bpf-next,1/7] bpf: Guard __get_user acesss with access_ok for uprobe_multi data
    https://git.kernel.org/bpf/bpf-next/c/4d87a251d45b
  - [PATCHv3,bpf-next,2/7] bpf: Use user_path_at for path resolution in uprobe_multi
    https://git.kernel.org/bpf/bpf-next/c/65d81609e931
  - [PATCHv3,bpf-next,3/7] bpf: Add support to specify uprobe_multi target via file descriptor
    https://git.kernel.org/bpf/bpf-next/c/26330a922641
  - [PATCHv3,bpf-next,4/7] libbpf: Add path_fd to struct bpf_link_create_opts
    https://git.kernel.org/bpf/bpf-next/c/da3a4c3ec7ed
  - [PATCHv3,bpf-next,5/7] selftests/bpf: Add uprobe_multi path_fd test
    https://git.kernel.org/bpf/bpf-next/c/d5026e6bfc70
  - [PATCHv3,bpf-next,6/7] selftests/bpf: Add uprobe_multi path_fd fail tests
    https://git.kernel.org/bpf/bpf-next/c/3229675be841
  - [PATCHv3,bpf-next,7/7] selftests/bpf: Fix typo in verify_umulti_link_info
    https://git.kernel.org/bpf/bpf-next/c/df29003c5511

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


