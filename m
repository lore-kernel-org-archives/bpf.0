Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82084340419
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585228; cv=none; b=QCmo9jQy9fbOsj3HwZYmdLGYdxnIQGxD2Py7wtJ2HnfXjiHc8psq3Z4uaES2goxiKFLY9bCFsuh1bJ3UC6lWk+ZsXkxQobwOeLa/ZOA72LaRXHz2BJHXMj5A/R2oyd4bI27nMIIJSFFacIuDlnkxcHj+pFDP3zjB7zSwyN69pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585228; c=relaxed/simple;
	bh=rob9VMhX4H5kSsYCc2Zo2WBUAvUtBLeVG+8thJHN66w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tK2PWdsHScJTe9KAHgTScAUuoXbqviLC1qHLW+zyd/bIg3ftzcGpLvZQ5a4KJLivr+9k0xj7GeNnL+/53Y68UShhbkt/Gz90PO+9p6E9d/MTwVJ82IPDke0r9AbJcvybQBGFhI0BhbaHfZ5fXiR98gQVFWbpYO3inFSfy279U1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUkLJQLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUkLJQLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6930E1F000E9;
	Thu,  9 Jul 2026 08:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783585227;
	bh=82fowHZiUiFMcMANCMIFvTmxevhhoIBVN97RJVk7pD8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oUkLJQLYtCvhFdY+ZVWHOuy+HYw9K33IbqAVq0MbKJF/b+zAmuST73/zbU9p5CCSR
	 /wdf8gy2Yc4+bJKc8dkDTcXhwL7Dd8r3udo0zseCo5/yvkCjs3UrL9M7zpoBX/oWa0
	 uF+ysE2aCnov4Vl0Lewl8go+GUemDpdhiWmYo+tDz0vZCM7QWFsRTvbYoMprlQSoOm
	 9lsH2pmhBkUMRMSE5/nz2K0hIz5tqyhi3LaVyEhQ3rIw5zsvuUQci/SLPQfDMclQYq
	 IRWBsSbpRCsrLhpVn4OC/9x76fsKNx2FPthz+xI1th42VB53042aikd4/7Qk9i7J8+
	 JX+orTr1nU1Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5679D393972B;
	Thu,  9 Jul 2026 08:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix security_bpf_map_create error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358520589.3322995.17637812506485356697.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 08:20:05 +0000
References: <20260709073422.379247-1-daniel@iogearbox.net>
In-Reply-To: <20260709073422.379247-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, paul@paul-moore.com, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Thu,  9 Jul 2026 09:34:22 +0200 you wrote:
> Commit 5816bf4273ed ("lsm,selinux: Add LSM blob support for BPF objects")
> made the LSM hook wrappers for BPF object creation clean up the LSM
> state internally upon denial, e.g. security_bpf_map_create() internally
> calls security_bpf_map_free() when the bpf_map_create hook returns an
> error. map_create() however still routes a denial to its free_map_sec
> label, which invokes security_bpf_map_free() a second time, so the
> bpf_map_free hook fires twice for a single denied map.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix security_bpf_map_create error handling
    https://git.kernel.org/bpf/bpf-next/c/36ffa86c42f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


