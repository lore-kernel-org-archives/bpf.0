Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651254BCF
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383029; cv=none; b=HPf9acA4XMdTjqbMqU/yxlZ4Hq2lGLffivXCkdivkndIr+poKkE+Qm+P6ojYi/gWfEdc0ZhbSqT5ciUJKvLGWvE1orH4g2yF0zFIi0Fc9rxWc+2SRvSPDPMP0ra7Nt268OCd37BuNbeyD4eehNu3VC/jYQovvQnD02chWQ4fDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383029; c=relaxed/simple;
	bh=PgMjTFTlTH72cYRPL+en5gVaBoqhKJdTR+yeFMo7OqA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bp+dEC4lykUSEooTNnwAvc4o8HJY+VqRFpb68SS7bGjaF/FKv/WSEpjEYrOGUqhzWG4u2ESxIRt/N5CsgJlhmTsvkUP6PgZXp1ycldLDmY1+M0aVb8pJIXhUpiv94SDrrLBX3lm2OU3DUESKG6VQrYTdKJWlmRjP8GchKWTA4Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ok9MCQhD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ok9MCQhD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E7A6C433F1;
	Mon, 25 Mar 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711383029;
	bh=PgMjTFTlTH72cYRPL+en5gVaBoqhKJdTR+yeFMo7OqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ok9MCQhD1ia/GkrSe0szaPvh27d3pMPfh2Ph2KaFJXQxLDNcHC6usTiqAYdcDVAl8
	 CN1ZFA4QajmGtt9Q08EqP3pOPcRqMj5gOuDY5S50evZw4W48lDIl2OpDEzML361Pfo
	 qkIGvEr09IjdEHp/28l/m9yfQYnQDf+kwIiSd313yEsLKybw9NCTOIFAIo8zmvs02g
	 fSupgsLylURxL6uVYbKQfWZM/p8RmSAQ0s5XddK12VW1ddeO9giJzBQZdiGJ/u7hUh
	 uLcIqZOhosUIK3+VTrWPQNbCJ3hL6T1VdVaNd8E5rd5lQcgeYWH10iooVu4N6B/3SK
	 U4wukj1okVROQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F36C0D2D0EE;
	Mon, 25 Mar 2024 16:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe
 entry IP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171138302899.9923.3323757238369450275.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 16:10:28 +0000
References: <20240319212013.1046779-1-andrii@kernel.org>
In-Reply-To: <20240319212013.1046779-1-andrii@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, kernel-team@meta.com, mhiramat@kernel.org,
 peterz@infradead.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Mar 2024 14:20:13 -0700 you wrote:
> get_kernel_nofault() (or, rather, underlying copy_from_kernel_nofault())
> is not free and it does pop up in performance profiles when
> kprobes are heavily utilized with CONFIG_X86_KERNEL_IBT=y config.
> 
> Let's avoid using it if we know that fentry_ip - 4 can't cross page
> boundary. We do that by masking lowest 12 bits and checking if they are
> >= 4, in which case we can do direct memory read.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: avoid get_kernel_nofault() to fetch kprobe entry IP
    https://git.kernel.org/bpf/bpf-next/c/a8497506cd2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


