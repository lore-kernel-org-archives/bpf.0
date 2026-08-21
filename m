Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8CF37BE9F;
	Fri, 21 Aug 2026 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334661; cv=none; b=g5WOqBgZAMSifc0Oxc9MNoP4Rf98LbVgBpBlNf1P7A4qLXEku9DjL+mM6dVvrsC8V1H5DnH3kCopW8VByCBPKyGLYFTTpyetndK5+ML3cLCnldZLKWQZMWdXe0dKePpcT7HUkOUkkP21L4UNTn6jbn8K0U2RamPq1Oi4v8nYAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334661; c=relaxed/simple;
	bh=EzEQgcIQciuzAc8WH5Muy1AVFcdG8DC+rkjvq4TefDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W5Xpgh7eS+bYssl7j2X9KsEHMKDj7Agpuzy2Ed2I9TyD0gTace7a3Ho9F4Yii/JfI0rC+JmX0IsBANG+AHHCrfGnR7RmzSTyhOLxlSBQPpFApV6dNbhK83GUGfjCaib6xcGTvyTDsMlSt+ixu9OEhE5nIxm8BKEvtEnDYKYzjCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY0hHs/G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY0hHs/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C142E1F00A3A;
	Fri, 21 Aug 2026 17:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787334659;
	bh=eM6Z18F6gvNNDIaP42q8XQWT6/dGbg7RNU9v6syaWZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MY0hHs/Gjce1QbsYrAZ8MFhOMs1p4oek2RHGM6tIVpidzm+FZ29fXwFD6WvR0/pC/
	 8oM80gqdAzZfStabRyLr4SCt71D2DaNlxM+ShPk4zSJ8b049YnnQta5MhA6sqh1qH3
	 iuCY3IPyY23CVDsnVaics2SK3qohGDyc6Qm0dN8JnpT1buM0Vo4hE4wrhH8hylFuxZ
	 +0UXPEl3t759LxUOtBAOyOCJJMo6hg1V1nw4Md1YR91qDZrrfTtexD5yPhS5ygj3Wb
	 TJuDKlNeqvXlvcYnkeZZ5eNIDhc2EGsbEoPicfqzjyoke9RMev9VIm56mz5LauPuZ1
	 nhGQnA0rTWsUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938A1380AAFE;
	Fri, 21 Aug 2026 17:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: fix BPF_F_CPU validation for sparse CPU IDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178733460914.1412990.11377910972320071983.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 17:50:09 +0000
References: <20260813160858.1042834-3-sh_def@163.com>
In-Reply-To: <20260813160858.1042834-3-sh_def@163.com>
To: Hui Su <sh_def@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, leon.hwang@linux.dev,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, john.fastabend@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 14 Aug 2026 00:09:00 +0800 you wrote:
> BPF_F_CPU stores the target CPU ID in the upper 32 bits of the map
> operation flags. bpf_map_check_op_flags() currently compares that ID
> with num_possible_cpus(), which is the number of possible CPUs rather
> than a bound on CPU IDs.
> 
> On an arm64 QEMU guest with a CPU device-tree hole, the possible CPU
> mask was 0,2-3. A userspace program using raw bpf() syscalls creates
> a BPF_MAP_TYPE_PERCPU_ARRAY and performs update and lookup operations
> for each CPU by setting BPF_F_CPU and the CPU ID in the flags.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: fix BPF_F_CPU validation for sparse CPU IDs
    https://git.kernel.org/bpf/bpf/c/ed54bf564ac5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


