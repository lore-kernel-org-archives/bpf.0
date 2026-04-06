Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA71D2628D
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775440234; cv=none; b=RQ3Lm9qwM8v9nkjONnJmNgH08e8/B4z8nAvgJ3jrXWLWcvwO23X8T9otrk3KuGIPQcE9pf+uChzrehvLyPZIBu0diAxE9d3MVAOhL5V+ljp9qbUe2d6cCQbGwWnBQicoVjLcIfUpn+tKrXfaZzzVS1XhDA1qvZpmbDxt6hO+uIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775440234; c=relaxed/simple;
	bh=1sA6fPbmf6cTm63MMcvhmdwA0Yq8QoW/2KpC2Y6ouaA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b7drdmlBgbN3R7C8hM1/1AorUX5W9ZIjQCODNZKOX9EOg50iMG5Ab0k89FLjAatAXBBYTwT+tIm+yEAif3D3lE7K1SKZqwdjDElK0bXcPmaCb+nfJ5Q54igyAdmqmyR+4n2ASJP71XTNJJWJ7ProcXjPHgCSLe3DRJfS4YrEJoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOuugwYQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOuugwYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96660C116C6;
	Mon,  6 Apr 2026 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775440234;
	bh=1sA6fPbmf6cTm63MMcvhmdwA0Yq8QoW/2KpC2Y6ouaA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOuugwYQ6Lf3JdlasjBCMuwuGDdOHkGnKDEaQs0D9LZe8VhMbvn9RXEFJyhBe8YDW
	 qyvWV8p/G03rTJ7FsBNrembLuzUfyLa5UcW9fNldS3AdIGcqsFVbYoOhJLyCWIZnWi
	 R/A5jXOYLD2di97xpNo6NROvtAXzwhOwIMcwjvBRZcKIKS4D1WiEz6t3dQZpmjtkM6
	 QP1TWFFyII9YOiwdC3s4zMd7v1Zj/at7PZEfyKE64po+Ke80COsSt8jmDcXpA+tnqe
	 awy7RNJeKihhyCXVPB0PJ/5hueXMjwmCykDB15h6Y3tpJzNkWbBVncEeMjvXVwwlC3
	 WJsE5QT4R5axw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5C3809A22;
	Mon,  6 Apr 2026 01:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] bpf: Fix torn writes in non-prealloc htab with
 BPF_F_LOCK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177544021381.2520976.18165686699458802520.git-patchwork-notify@kernel.org>
Date: Mon, 06 Apr 2026 01:50:13 +0000
References: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
In-Reply-To: <20260401-bpf_map_torn_writes-v1-0-782d071c55e7@meta.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, aaron1esau@gmail.com, yatsenko@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 01 Apr 2026 06:50:35 -0700 you wrote:
> A torn write issue was reported in htab_map_update_elem() with
> BPF_F_LOCK on hash maps. The BPF_F_LOCK fast path performs
> a lockless lookup and copies the value under the element's embedded
> spin_lock. A concurrent delete can free the element via
> bpf_mem_cache_free(), which allows immediate reuse. When
> alloc_htab_elem() recycles the same memory, it writes the value with
> plain copy_map_value() without taking the spin_lock, racing with the
> stale lock holder and producing torn writes.
> 
> [...]

Here is the summary with links:
  - [1/2] bpf: Use copy_map_value_locked() in alloc_htab_elem() for BPF_F_LOCK
    https://git.kernel.org/bpf/bpf-next/c/07738bc566c3
  - [2/2] selftests/bpf: Add torn write detection test for htab BPF_F_LOCK
    https://git.kernel.org/bpf/bpf-next/c/f64eb44ce906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


