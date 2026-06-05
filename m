Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A863F99E3;
	Fri,  5 Jun 2026 23:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780700419; cv=none; b=MeuiQtFv3pxdZfjNj+hcUl9XO6BWPWfTVUDXHofV/iszOHZAE4mC9MY7CJddX1j2Ktz52bllTj1oCNqjSEzgyXXyrVhCbLNwNAUW+zK0sXt6IO6S7YXaZBUlMsipdr7M4YoLeE+jA4nIHn0n5cbyTqAetW1LL2azx7lzwJxHJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780700419; c=relaxed/simple;
	bh=GMAJ/jN2ag227IdfEplRglKf8PSmH2CwUodA+X0+Wp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LGWf9YCgPCTaG8nv+LeyFh7fh3qaS+8WGbsbAPYgT4gOWFLv+Oh9H9w6ilOWCyLiDvUgE6qYrJRsM17TG/l94LK5etajTgsZ6c1JsR6CWFS/JEtwIuvYeIE8PouLpHDm9eTu8F7tNq2bpjSWtY4APhybavAlizN/StRq15dkwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1mXzfgt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1mXzfgt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280F11F00898;
	Fri,  5 Jun 2026 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780700418;
	bh=KzWnNAVZKz4ae26CgaSWwGeqowdeQmkpemI5ErivSxA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A1mXzfgtXfkk8ZXUcLTaphvU7pz+ATprBjzlXDdU7ONalud6pQz4yMWuV243RD2wC
	 AhSqJRZB1mBanCXFJSha82l3qiLoiICFe4hJnVlDd43R95jgjRb547yw732ewJO/GU
	 r+Zw/L5msMAZ3m2aShXXLbA3AjXLpZpjznNcIxjTvBaPOV7X6GzX1YFdUB5YqTRBXJ
	 3vcWzw/OJ31OFxPVjym1P8JDpeU7JCujW7e6d6NNQ40ONHXU2dQMs56JJhoYDvGw91
	 yxcVjso6pxDAK0/NSAnsL0jsR6NbRX6dZXOht5x5f1RK9J3qYkl+nCD5UFJdvFB+q9
	 wu/TGYLTBexEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939453930C04;
	Fri,  5 Jun 2026 23:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] bpf: fix sysctl new-value handling in
 __cgroup_bpf_run_filter_sysctl
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178070041813.3950549.9677793894804519619.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 23:00:18 +0000
References: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260603105317.944304-1-dawei.feng@seu.edu.cn>
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: martin.lau@linux.dev, emil@etsalapatis.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, kees@kernel.org,
 joel.granados@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed,  3 Jun 2026 18:53:14 +0800 you wrote:
> This series fixes three bugs in the sysctl write-buffer replacement path
> of __cgroup_bpf_run_filter_sysctl(). It resolves a kvzalloc()/kfree()
> mismatch, adds a missing NUL terminator to the replacement string, and
> updates a stale return value check to safely restore the replacement
> functionality.
> 
> Patch Summary:
> - patch 1 NUL-terminates the replaced sysctl value
> - patch 2 uses kvfree() for the replaced sysctl write buffer
> - patch 3 restores sysctl new-value replacement
> 
> [...]

Here is the summary with links:
  - [v3,1/3] bpf: NUL-terminate replaced sysctl value
    https://git.kernel.org/bpf/bpf-next/c/a66e3b5bacf3
  - [v3,2/3] bpf: use kvfree() for replaced sysctl write buffer
    https://git.kernel.org/bpf/bpf-next/c/4c21b5927d43
  - [v3,3/3] bpf: Restore sysctl new-value from 1 to 0
    https://git.kernel.org/bpf/bpf-next/c/2566c3b24219

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


