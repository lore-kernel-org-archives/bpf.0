Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880D21FF2E;
	Sat, 28 Feb 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238006; cv=none; b=RKvVL4LRECQNo6UDt/TRpIu/QYLAWucxi42GDVbx4BtgH9Ea0VX/K4ol85le8aRuSaAKkPsFcW377bVsqkaGIzRFsHxJr7WLb9NI/zRVwMkZsB3wf+WD5cmLtk4whDTmAnxSxjLwNbqmwqgRh9DDmbL18SU6m9PLzP1Pl7MQoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238006; c=relaxed/simple;
	bh=rFLs49bIoTa/GDiTlmR2it7GbdnW1QvlONvz4DeIYmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BopNUucw1gj0Z/pXR0BCJqULe2uohwdL+RVD7ncRh28XVuxFwLDrWYIVTFMxtmxVRrNAw535Xs8BLyPk14oZr/ooGqPiBOQLUq9Zg/ypTgPzUVUpQIr5ZEy0GtLYCl/O4Khe6dsahMBR3Gs04BJ7MiYisZd9DY/gTSnNgxwZwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy/UMOQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy/UMOQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A2C116C6;
	Sat, 28 Feb 2026 00:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772238006;
	bh=rFLs49bIoTa/GDiTlmR2it7GbdnW1QvlONvz4DeIYmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hy/UMOQdPitkxPPdo2+cm6lPD82U6zQEyfmPGssSnw8liegLi5HWctSiKMbGLyjSv
	 LxceG9tUktXkK08BlCWuFK3R9CNP/ueUseB32YXPWIx5CjxeDwWDdLRAnKBE7bZ2Qg
	 gW0syhlQCu40Puxyj5CWGBvbzIsPdGnFvLLWZpZR1+zPPSgTTnVaCbfKRfEkDodX1Q
	 YxyN9tJTkeB1GE/3f1xBBFDa9czIAZnUemKpM2JVz3jpo/skm645i59JxtEjlPDZcV
	 tKXx2P/CFb1JFIdFMosA1r6Ja1vbmTo05Pv0yYfDi62QfDp4rD5RUsWCHctTQVqFRJ
	 fP2zfExxPlRxQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09839EF967;
	Sat, 28 Feb 2026 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 0/2] bpf: cpumap/devmap: fix per-CPU bulk queue
 races
 on PREEMPT_RT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177223800954.2812023.3473953942632581583.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 00:20:09 +0000
References: <20260225121459.183121-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260225121459.183121-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, haoluo@google.com,
 jolsa@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, tglx@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev

Hello:

This series was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 25 Feb 2026 20:14:54 +0800 you wrote:
> On PREEMPT_RT kernels, local_bh_disable() only calls migrate_disable()
> (when PREEMPT_RT_NEEDS_BH_LOCK is not set) and does not disable
> preemption. This means CFS scheduling can preempt a task inside the
> per-CPU bulk queue (bq) operations in cpumap and devmap, allowing
> another task on the same CPU to concurrently access the same bq,
> leading to use-after-free, list corruption, and kernel panics.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] bpf: cpumap: fix race in bq_flush_to_queue on PREEMPT_RT
    https://git.kernel.org/bpf/bpf/c/869c63d5975d
  - [bpf,v4,2/2] bpf: devmap: fix race in bq_xmit_all on PREEMPT_RT
    https://git.kernel.org/bpf/bpf/c/1872e75375c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


