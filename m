Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2C56B65
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710791427; cv=none; b=G234decE1IC2A80DbyWR6vrnAGQPbePbw7DfffTmG+gqt4r2Jw0jHAdtzwGqxNjTIHhDH7YH3YypoV0808fQ4W2AqXt0swjMchPi8CtC1gJy3SIadmLGxO2A4z2ledJDplSUMyjTIcKom8mViPl9VrYEvY6+yZodOBbHI+KjbvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710791427; c=relaxed/simple;
	bh=qiRljwrpFJOaXfhoJ9KThbOaGs4B3Qus4TnFNNoQLT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UmgutrFpxXVlcniuUgVPhVO7LJc4V//3XAU+aMmjRk3jgGH7Mtc09Ig2AkiLeeuVPeAicCmO9f1PWXLUmWQ4fM7DzkcA73q+t19/3IWU9nodeH018+rrkPjBXc/Mnvr9LtUNpdBSwvGkt08JW+iEFlJSMOze61ICQZlSyk1aTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Eqphx2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Eqphx2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE228C43390;
	Mon, 18 Mar 2024 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710791427;
	bh=qiRljwrpFJOaXfhoJ9KThbOaGs4B3Qus4TnFNNoQLT4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9Eqphx24Z/DJauRsnH1GyZvhOSBDsEVC53u0vQiU9Rn07mXYQ9A26wUKlcwx/CgP
	 9tK2hnI+hoJ6LrKxY6Gbag9bLOjePyMvq4tXRflFtvlFImPK062/COKtoE/MZ88nX4
	 38IeYodOyQVDnHAsrEPR6yq3MV+3a+s7Op5HXXvuJMYdGRHR5FIknlk+8V6APVfC+C
	 HztONpnn5Hce1kx+0r24fXH53ZmN/pSvJmQBrMhfQsjjyvj6C+jWDvfclBjag9OjlR
	 xxni+SsOLKvUKv879gFb32yZpDf8j28ZxeO2AXu6LaQFwORNDp8ZfVC9JQ/I7/kWGb
	 haXdG7MRhsmWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D814117B6475;
	Mon, 18 Mar 2024 19:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Remove unnecessary err < 0 check in
 bpf_struct_ops_map_update_elem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171079142687.1505.16205481625192413466.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 19:50:26 +0000
References: <20240315192112.2825039-1-martin.lau@linux.dev>
In-Reply-To: <20240315192112.2825039-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@meta.com, thinker.li@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri, 15 Mar 2024 12:21:12 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> There is a "if (err)" check earlier, so the "if (err < 0)"
> check that this patch removing is unnecessary. It was my overlook
> when making adjustments to the bpf_struct_ops_prepare_trampoline()
> such that the caller does not have to worry about the new page when
> the function returns error.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Remove unnecessary err < 0 check in bpf_struct_ops_map_update_elem
    https://git.kernel.org/bpf/bpf-next/c/7f3edd0c72c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


