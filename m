Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5F246784
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784250637; cv=none; b=N/xrQ/pO1KHgnQoe6+GMykqaww1OkcAJpU2iSmxhKFQCy5GxxlhILMuWuCKAKGE6VRCbbZtwlHZkafpslR6Iohr5JmUpsfJ/RV4L3NnJngMWM7ABmze3Ycuexn67D0ICIfS5bV1gmjw8kzymHDzTqyorJtNiJIJVg3jcfqbLY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784250637; c=relaxed/simple;
	bh=7pUKX2c99QEVTr9vj4bd3wFYr/gbsTvgM24gYdPym4k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nalMdZsLl4GGEqU02B4caqalEvd0HkeLhbmNlesRJWWmKlBqdMVr6MqXVjbBmglSCEd2wEkGk1SBS7LaPisKIpgzjbBBmEvnPyYxNkaEJNnRBq++/0Z3JHpz96kMyVvqIiMIrmJVdoCXgFoJ7WACke0KOhHaoPWytPzOysPqXaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXYMo7yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXYMo7yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5961B1F000E9;
	Fri, 17 Jul 2026 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784250636;
	bh=uLoj0i1Od6zdY7279BtUze7cXR09P0SpdPts8WHYQKA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cXYMo7yCvDeBFDzVtdYJgmBz+i08IKDtH7cV4bqyX6RyR/av2sMxQTTvjT8x4b6me
	 WSL8mxP6NVRW2ALuI/yPVcy1RevPwRdmSvYfVWvIfOagr7/yKGvB6f6YbONJQjry7Q
	 4tTpJfgjJ2hgJ4yKG53Pp6x1F29nEWCRGq/cuIWrlekvaho+ij8RuBXh2KQX+Km1le
	 +UN/Q3Mk+mqDuKemiI6zC78UOEOpTzltwk16ad9MYlaawmRZl/Iobwe8bg6dd9Ntq6
	 2AGe95pg+xcznc/Q5x0edVErKZUNj76Dp40fa6WeqKYUhk5kqTTL+9AE4pmLygcchh
	 KQcDv/7ebHJDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58438380A97A;
	Fri, 17 Jul 2026 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Fix leftover issues of the unify
 bpf_call_arg_meta patchset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178425060915.1479699.3241147480405942408.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 01:10:09 +0000
References: <20260715172127.2416388-1-ameryhung@gmail.com>
In-Reply-To: <20260715172127.2416388-1-ameryhung@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com,
 kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Eduard Zingerman <eddyz87@gmail.com>:

On Wed, 15 Jul 2026 10:21:25 -0700 you wrote:
> Hi,
> 
> This patchset fixes preexisting issues flagged by Sashiko when reviewing
> the patchset unifying bpf_call_arg_meta [0].
> 
> [0] https://lore.kernel.org/bpf/20260715064047.1793790-1-ameryhung@gmail.com/
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Disable raw mdoe for bloom filter map_peek
    https://git.kernel.org/bpf/bpf-next/c/01d98a8df31e
  - [bpf-next,v1,2/2] bpf: Zero kfunc arg meta before error paths can read it
    https://git.kernel.org/bpf/bpf-next/c/83f8ab834997

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


