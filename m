Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D3171E41
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712339429; cv=none; b=sCXeFszFy9xZzQFKJkdNYwb6HhSPQW5RFZeDfT+nrwNRj52AD5xj4C/i4q9AQlZGrB/D9xvdWBeJHzxmtKHXW/KE8nuBiWVJ/NjQw6409k1a5fE6Jci9jaOek6LaBYO9EdfrCxKm3m3DRUKG8RLJ/sjMfQNac4lBQfm9CrE+WYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712339429; c=relaxed/simple;
	bh=7JurBHrqUMj7/vHxb7WCKU6w/ca0TXFhqSfE7NXyhjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SArgo/Y+djSt/SnPzwZ4AIc82t6FJaFD8Z8yJYGfDaiZEGVVGVP7f1XvzUt1PZJavWxbRb0xah71iCElyyk2i0djudOTa1yeKYgRJJdubWW2XM/tvRnCWhTr8kTjITgYDD2+NbDdCx25b6rtwrD4pINWD5QEoRn8g3WkfrhkNdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuBDSiGx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuBDSiGx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 165EBC43394;
	Fri,  5 Apr 2024 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712339429;
	bh=7JurBHrqUMj7/vHxb7WCKU6w/ca0TXFhqSfE7NXyhjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uuBDSiGx07/KYeQCdj0JLJOlJ+KItd/C6m955vIkvCmKmBUxEUD+hgTLJRtxbZCQX
	 Tv3jsQA3KZhsrMu1LKT9a8/IP7aPNvpNnyJ7ghZkZMAAKMYE7FglSfBQoKcKwhRiQD
	 zGi7i07B1xGzTwsPdbkEvTR/ulkRsui3Sk3YpOMy7puFLOicwCqMsNjk7hLemUKiQU
	 nr+RfGfxNjiYYb6kMBNCZG6uxH+EBzqbcTZFqiLG5DOIkSRF0z3onCHKIUogUKSgiy
	 LTF6LJXGuoj990xI6voFyCIiENQg6w4qHN6OQGENHNWYmv02TmHYG21jOAitjjf7MF
	 3H2SMZy1nagTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04D02D2D0F1;
	Fri,  5 Apr 2024 17:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf, docs: Editorial nits in instruction-set.rst
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171233942901.890.12943574419670100374.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 17:50:29 +0000
References: <20240405155245.3618-1-dthaler1968@gmail.com>
In-Reply-To: <20240405155245.3618-1-dthaler1968@gmail.com>
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf@vger.kernel.org, bpf@ietf.org, dthaler1968@gmail.com

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Apr 2024 08:52:45 -0700 you wrote:
> This patch addresses a number of editorial nits including
> spelling, punctuation, grammar, and wording consistency issues
> in instruction-set.rst.
> 
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 47 ++++++++++---------
>  1 file changed, 26 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf, docs: Editorial nits in instruction-set.rst
    https://git.kernel.org/bpf/bpf-next/c/00d5d22a5b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


