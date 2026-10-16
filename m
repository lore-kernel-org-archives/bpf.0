Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A232C3AEB37;
	Fri, 16 Oct 2026 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119610; cv=none; b=abeSI/E2p1GrDrTBrFR7SadEqs02Z0VEpfJxFlLJgfGRYK6YTb1+QOC45urftvmiSMtBphL7TFdwZXSCw42JEJX2g5VpyWLasK0MVBjMMZnEtb8np6FCjAJVz4mqat4xLgU2nw9XvqKYawx5zQLCkEQIi/DpzNvx41s3tGczqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119610; c=relaxed/simple;
	bh=ut425ZVVJYbYLpk6hgih+heGZrcRsLV0tQju9qnPK+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AAbXPf6ZbiPBRdzUuRI+DnI/39f6Dd+uL2k163rbEDkYoNGRuFqoc3FA4m9dbSJFBAXeFWaGrhj+i0v3skdgKZ/C4cCyFSnqFMtXnoH5nPrU2kIZsHB9r/MSyyHVkzvctFguBTqhMB+lTNyosPW9dz+J6ZVv99/T6NFjPEKPjA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDCUml3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDCUml3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE331F000C4;
	Fri, 16 Oct 2026 03:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792119607;
	bh=4J2mGXg6QaNtnzBgwqkwdZqr1QlBxcy++o+uklQ8lrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fDCUml3zJxBe478lq79ORPQidJRuECeEwc7XJMQJixOLRNp18pz0TGEZC9o36ULZ7
	 2ypjbLi75xkH8HbexrOyajq3cVzLjkiK2u39spDAg/ZJY8hoL/kQfjJuZwFpyXz+mU
	 2icWPmpIM1p8r28sghzYkCurAtkJC42fZV3FwQQCumzMfYxI61ci8gg64PA7BG61IA
	 UR1JNFujGn6l4B2SypyV4vnRabXvr2OcjhT6cWiQaPsZfufZGyl96XIr9bQpVB67vL
	 5zIzlfzcw+F/25vaIljD242eLT4mKvrxJ2Rpjj/9VGxQ55jbAw31sq+66Qn7gga8+s
	 d7nMvfCZdJ1VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F143C3808209;
	Fri, 16 Oct 2026 03:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: Fix the bpffs handling of
 cgroup_hierarchical_stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179211960551.30782.10876178060857722550.git-patchwork-notify@kernel.org>
Date: Fri, 16 Oct 2026 03:00:05 +0000
References: 
 <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
In-Reply-To: 
 <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, shuah@kernel.org, yosry@kernel.org, haoluo@google.com,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 09 Oct 2026 10:04:36 +0800 you wrote:
> cgroup_hierarchical_stats mounts a bpffs on /sys/fs/bpf to pin its
> iterators, then moves into a private mount namespace to set up its
> cgroups, and unmounts the bpffs in the end if it mounted it itself.
> 
> The bpffs lands in the mount namespace shared with the tests running
> in parallel, on top of the one already there, and hides what they pin,
> which makes bpftool_maps_access and bpftool_metadata fail now and then.
> The unmount can't remove it from there, and it checks the other way
> around whether the test mounted a bpffs anyway.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
    https://git.kernel.org/bpf/bpf-next/c/3c824dfd17e6
  - [bpf-next,v2,2/2] selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted
    https://git.kernel.org/bpf/bpf-next/c/e0645cfd0e1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


