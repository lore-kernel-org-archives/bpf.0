Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0344339861
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742499; cv=none; b=aKab4ebc8PTTdX3AGuQ54ixa2pD7U1QHJeGBp//eAyBNDY2ZUobJyHxr99Q+exiuLam5GsgLCsusP9CYh7QbBQW/IcXreyolIILYSzbW1AO1L17kqQhyWaymCYnzZGClEwA6dwbUrW6lTAKbt1gwT2AyLMBfoNsj3Kg22v0EEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742499; c=relaxed/simple;
	bh=Tiy45h93hbyevmXK3PZxLVT0oEL3CPk6qbrVHwUDBkE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dhz5fowE+vEvT4x80NHmpbIgiYYTq4qEync9QBdtEj8VjOqD/7E2szdw0HsGWHMFTUYxxHO3lDOn5lNF1v+zr1EugPvRKJRlF2ayxIYMZxgZ1ShEn6snTg9Zwc7xWjKb7nPLdsKMvhnbS6C4phDDe0Z+HIFRtHCq7aM1A6ixzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgL7vSfe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgL7vSfe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F925C116C6;
	Thu,  5 Mar 2026 20:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742499;
	bh=Tiy45h93hbyevmXK3PZxLVT0oEL3CPk6qbrVHwUDBkE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JgL7vSfeanGx0dPRck3OiraTl5vkSsQAhtzCV0zgenbC1LY3BR0p8rjXjcRw0q6hd
	 Etcbhj952Jj80gJGRJMAmpgbDXaTlmYTtLtGc9nq/a7jm6q+VQYnt3cqErGF3OO4kc
	 rSAZYjN/Tq2Q5p8ZDI4Xm4dg04/WNLT6C5ZOt3aQaPefmV/pnAWaA4zWsVgmp97Cfr
	 /LYteISCQ8Vluil8NiAGUtOB1MCw1oB8NdQUFBPnj/J/fEYqwiy66HFW3kul7b6/hO
	 qp+7vNpXUPqfGYNznMO23FcuZOURxXavUEmtQz6rakWmtqa+LtIQpoH5oSe5azNfbo
	 kQEkXX8dHYtnQ==
Content-Type: multipart/mixed; boundary="===============3367509451540937078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c49825f6d0ae413ca101a5004a2e33ff1d979f2121180e9654957fe6121f9cc@mail.kernel.org>
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-1-7169206a3041@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: refine u32/s32 bounds when ranges cross min/max boundary
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,emil@etsalapatis.com,arighi@nvidia.com,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Mar 2026 20:28:19 +0000 (UTC)

--===============3367509451540937078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Reported-by: Andrea Righi <arighi@nvidia.com>
> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Closes: https://lore.kernel.org/bpf/aakqucg4vcujVwif@gpd4/T/
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

This commit fixes a missing refinement that was noted as a known gap
when the 64-bit version was added.  Paul Chaignon's commit message for
00bf8d0c6c9b stated: "The same logic can probably apply to the s32/u32
ranges, but this patch doesn't implement that change."

Should a Fixes: tag be included to reference that commit?  The
suggested tag would be:

Fixes: 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22734151945
--===============3367509451540937078==--
