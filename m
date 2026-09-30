Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBA45041A
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759419; cv=none; b=p0pcE5zM1WM7D+R0lVWHK9S7v0XsPrxR7v9dbxv93wyy5sVVaKudObvUYt7bWJ0r8NulnkVHD5ki/++V6KmBzoDxhCZ6ZlKI3rXLq7xtxwBgxrm8OqQHBocbMYW8uvkZMpNsKzXCKUUmkdnUDKTsO5ZLeY1MMXoaYigX2UEQqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759419; c=relaxed/simple;
	bh=87TLN6HiUTV6mnwEZBYTfLeK5pBV7PVYjZ/m/Xrx61w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JSYEIlycvYEdvtU7g/erCBpxrlXsZNKJoI2sCSj2eMXTs2dHh2BDcC0Rf+qdDbi+7GMWCSmAgaoRPF0YqPcGYoTrgKs3I5TQjXjRk7PLIBvpeoVG7CK+bmeFfGY9o+eL90RmjdiXRtQ2tgYvXPSG0iJ2X5IyNOB7ydsB2SA9yEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2rVLWBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2rVLWBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A7F1F00893;
	Wed, 30 Sep 2026 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790759418;
	bh=09WasKkXC48ObZmtDACX6cvxtsntVELc4fB+69MLuRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M2rVLWBpSKp6XnECEQT+ssqmkMd9W9EZTKi38fXi/Dux9o7XOdDwPPaB2sArAFKs6
	 Uzfv2sKRVSFVlQmIyc9mWRjcoSzI/8kQopvi+nEYNpU6XTpfTe2wgN8PbX29iC0mn9
	 wL0b19nnybQsLQZxuH/Vp8iUobjveDhB8p/RDEmH0wgL1PRezyrksntyCLMwh8Y4qx
	 ReqbcxJdfTeXdj0jVDEYWrHQKaB7eTdS3eZQggnbDiOAQgar6xE9hJS5+lR/qnIjvS
	 7vJvyv+RPDJnKkrQ6OIdeOIujRA2hoyzhoy7RmAYPNjAyvIJu+PDnUbIU2+fvtnIMK
	 4G8ucK3riLigQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F147639E8A77;
	Wed, 30 Sep 2026 09:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Skip callx switch table test
 for
 clang-22 with cpu=v4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179075941652.1349208.7470057462221019906.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 09:10:16 +0000
References: <20260930020851.71691-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260930020851.71691-1-ihor.solodrai@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org,
 yonghong.song@linux.dev

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue, 29 Sep 2026 19:08:51 -0700 you wrote:
> clang-22 miscompiles call_by_switch() when targeting -mcpu=v4: it turns
> the switch into an array of pointers to functions and then erroneously
> removes the array in BPFAsmPrinter::doFinalization(), breaking the build
> with:
> 
>   error: Undefined temporary symbol .Lswitch.table.call_by_switch
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1] selftests/bpf: Skip callx switch table test for clang-22 with cpu=v4
    https://git.kernel.org/bpf/bpf-next/c/99c3e74f8d96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


