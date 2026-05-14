Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728C3E0730
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778772661; cv=none; b=H34k4r/eaQwTwb7s5Inw7jCx5P0aa+l9Nlgesm5XaRzQbMsm20v/nW4Pq4D5IzF8qdswIkl+I1R0pxU0f2D5nKFakcp7LNi0QQCQi+DSEV9zr4mR1SK5rDlQrP+CX0Va3OdA6N0Q8btxIkO6nq/S5YdL8MO+f6KV2o5/yDMomSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778772661; c=relaxed/simple;
	bh=WVUXLFSZ8GmsURZNQPq8xJ3G41s98YGeMV5fcKHSd6Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dtz9Ny60qYJLrzPSuTeIqmz9CQZFHPYQNhzuT4l3cH47iv+diGk2neGGVGkUCjat2lyjdLyilIa3gWOHAnrERH1o9lYLmoUXEEkcbZEcRZwHulfKS8aizJKInyQ9xpjmtu/m6oh8u2oUZiVOL/J5YI5WaLVz1igmKBV0SEhiHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGwRr4Za; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGwRr4Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 083ABC2BCB3;
	Thu, 14 May 2026 15:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778772661;
	bh=WVUXLFSZ8GmsURZNQPq8xJ3G41s98YGeMV5fcKHSd6Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGwRr4ZaMBFlmJU0oFh+OCbfI0ShXVOS3O1LnDGNxSqMQEdSt38JiYjDLqpcG8TFH
	 8mcmJSuDzlB6r+NXNPJ9UShaoHT5gB2DQuhfpR/J9/08ut1mOx5IM3jUqpKkuimdWj
	 utnG76XEGJznmspKT8Pb73Zw1m154yHrPqnfInqWodkdAli62tvealdVpWloCuwj7z
	 jqJJPp8nKXJ0u1j4dFiz2+klu+o3BpJajSfO3vgh15v/0097mw6pcQ0em6V02qSuc0
	 AsSd7YqJGzpMvG4/XSMxoQ50kOvecOaxiax8pFz7TsWnyr4ni45zNKvbusPyzkBV0y
	 E0Ktlk215Sz5g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D7E39D609B;
	Thu, 14 May 2026 15:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: Use array_map_meta_equal for percpu array inner
 map
 replacement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177877260580.4176003.17875178222309758286.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 15:30:05 +0000
References: <20260514074454.77491-1-wgnbuaa@gmail.com>
In-Reply-To: <20260514074454.77491-1-wgnbuaa@gmail.com>
To: Guannan Wang <wgnbuaa@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, gregkh@linuxfoundation.org,
 ast@kernel.org, andrii@kernel.org, xlabai@tencent.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 14 May 2026 15:44:54 +0800 you wrote:
> percpu_array_map_ops.map_meta_equal points to the generic
> bpf_map_meta_equal(), which does not compare max_entries.  When a
> percpu array serves as an inner map, replacing it with one that has
> fewer max_entries bypasses the check.  Since percpu_array_map_gen_lookup()
> inlines the original template's index_mask as a JIT immediate, a lookup
> on the replacement map can access pptrs[] out of bounds.
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: Use array_map_meta_equal for percpu array inner map replacement
    https://git.kernel.org/bpf/bpf/c/593980175389

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


