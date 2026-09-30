Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2263AEF57
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759418; cv=none; b=nC3P1MhoMjWG69X/lW0vBtwN0xglS2ectwoeelLcXYJrPtXakizndWmT/cUIIjznVvKqFhtc9KG5hWPGoojidlbRYwltKtu46m+4ZwKBZrUbnrAVjBRYMJxp4le1QLfaJmdaOxIr+iYmlp0Hhpq7RM4tvp5QnPU/EzFTGIswrKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759418; c=relaxed/simple;
	bh=si4+lWXU1iKeCpH9h3ltda6q9o8LyfQw9cK6A54e+AI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gnn3qb+3ZvpZtbfJPXRNEhjlAbauho7fw99KjxRvMJpIVn3aEey5NgyNNKpc/6YXzY4v/TFw2mMXFArMHLMzdvNQ742V1rc1E4iGmdL2jn01/U7d4W011jdF1dVVn8krGyx3aENjO6qwLnNjgRECpYPrq9woumBugxVFTmSq1/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAhUtEpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAhUtEpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805191F000FF;
	Wed, 30 Sep 2026 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759416;
	bh=gvPZffgj5IhRb13i8NNlrmkSrK5gnGWONwLYsiUaYG8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cAhUtEpR8Bs/DocXeqbql6vlVL7xxNgv17yzL1+7GENtvVrfx4RrrOK2X4unLh7kR
	 TD00U+WonPYMGDhr0S4OW0CyGc8sJaqRi3hXZrytg1CG9B6Y0edf1uQwEATW6bk+5A
	 32qAQDhxosvZvVbnSOeGg/1P62eBKH+2maaS5mn9H5dwttAZI6ah5UuEkhuwDjjavF
	 mO3wF1Je/gTGEaC0dTMN2ql1cFDJRqYU6cgAIw1eDe73rDvjU7Fr2C+fWTWXNHj6Z9
	 /JCGzqmDuh2hW87EAxtpHJjOAWGaRiAavxemQYFzJDUtcOnAWdC7SF/jvXy9qY2n+2
	 1SMfZbyvcHlLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773B439E8A77;
	Wed, 30 Sep 2026 09:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/5] libbpf: Render decl_tags in btf_dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179075941528.1349208.11059576048812534137.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 09:10:15 +0000
References: <20260929234608.48503-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260929234608.48503-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Sep 2026 16:46:03 -0700 you wrote:
> BTF supports arbitrary __attribute__ encoding via decl tags and type
> tags [1]. However btf_dump facility only outputs the attributes
> encoded in BTF as type tags, which was implemented in commit
> 2019c58318b8 ("libbpf: Check the kflag of type tags in btf_dump").
> 
> BTF_KIND_DECL_TAG has been left out of btf_dump entirely, independent
> of the kflag value. An attribute a BTF producer encoded is silently
> dropped from the C output.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/5] libbpf: Walk types in btf_dump_resize(), not in mark_referenced()
    https://git.kernel.org/bpf/bpf-next/c/1419795b98cf
  - [bpf-next,v2,2/5] libbpf: Render decl_tags in btf_dump
    https://git.kernel.org/bpf/bpf-next/c/76ea31239021
  - [bpf-next,v2,3/5] selftests/bpf: Add ASSERT_TEXT_EQ()
    https://git.kernel.org/bpf/bpf-next/c/1c36a1a41a47
  - [bpf-next,v2,4/5] selftests/bpf: Test btf_dump rendering of decl_tags
    https://git.kernel.org/bpf/bpf-next/c/096ee6e38267
  - [bpf-next,v2,5/5] selftests/bpf: Show the tag kflag in the raw BTF dump helper
    https://git.kernel.org/bpf/bpf-next/c/2c964f6c5d8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


