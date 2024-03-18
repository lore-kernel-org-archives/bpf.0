Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1F535C1
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795633; cv=none; b=YsYXxVrnKQsDj6mwNWDrulznkU96qEuHZ4JKjdjn1TflBuM4+kVVUOqlN5O/wVrGl5n7gcSgHoUMjjBwvZJepVgXij3efDVF0mFfoQdgklDtS0q9XUcQbnJKkNWIstys0497QSS61IouaHcD6HM2iLih0KAlDZuigQY0keQ6WYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795633; c=relaxed/simple;
	bh=4KZsEUfbAl4v/EaskK8S0tIZjN5coHMdO94qmBEH6vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l6pZ00C1clmFQ/kvsnET41JDqMPQNXJY90QtD4QLjjH78G98n5ZlcOs7zfKDZDFdsEfYa1jgs88/CMVP/FizcZxTsl5d3xVhcWkDSuuTVErgU2ypuDbQiN0UFzjDovL1mX/7kTzq5TDpPowd/VXUK+GZPCW0LBrEjXpbGonEju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAKM2Mmc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAKM2Mmc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFD10C43399;
	Mon, 18 Mar 2024 21:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710795633;
	bh=4KZsEUfbAl4v/EaskK8S0tIZjN5coHMdO94qmBEH6vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UAKM2MmcqcrrJohGEk9UoOW7HnkzawxmhgbCUq+HsIwMyxfIlXggK4d9R9uEv7662
	 lQ1xkUmtrbtzeSFVJGKJaAGxrHqnRN0mdbg8pd0iHJbJy4YcxVBCjCgLT6UThzXkxf
	 Oer1TwSpYgOQ3y//5xBKlpc1rk3F04q5JxM/K3ZBba2vk9oAJ00fsKk1m2cUoNm9nv
	 kktahkKoLPXrHDCti8Ur6H179llJLBqtnGW4QVpI36m494qUlh35EdT1Y+KZdv/lyJ
	 R7JLW1CXzmUwHs9mPBV6/0RpmeZOZ5J+7u2bV8uBRmOrvkpyt1dhoV7bzdcU3C6BRl
	 Qe2WqGyfU3wZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF38F17B6478;
	Mon, 18 Mar 2024 21:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: check bpf_map/bpf_program fd validity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171079563291.18125.2069679784144831771.git-patchwork-notify@kernel.org>
Date: Mon, 18 Mar 2024 21:00:32 +0000
References: <20240318131808.95959-1-yatsenko@meta.com>
In-Reply-To: <20240318131808.95959-1-yatsenko@meta.com>
To: None <"Mykyta Yatsenkomykyta.yatsenko5"@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, yatsenko@meta.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Mon, 18 Mar 2024 13:18:08 +0000 you wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> libbpf creates bpf_program/bpf_map structs for each program/map that
> user defines, but it allows to disable creating/loading those objects in
> kernel, in that case they won't have associated file descriptor
> (fd < 0). Such functionality is used for backward compatibility
> with some older kernels.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: check bpf_map/bpf_program fd validity
    https://git.kernel.org/bpf/bpf-next/c/7b30c296af65

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


