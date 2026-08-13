Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E44756D1
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657481; cv=none; b=t4AVKn7J6UqWd7SpG74IBNVAwafZOzLJfj1saD/vdkpG8T5/+gECtsRRz1oMFb20CbM7ipiUWvNljJLePOmarOlOhH4B5hTNb7m6RcMRNBNBGD6LerAxIo1mF/a1U4W/29GORK+ze6sknqoQDdH3hKfstA+b5TJfnjo0MxwHjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657481; c=relaxed/simple;
	bh=xg2PzB7HFma/izzUtXw/ELD+O+9OR+F7e0EIZ9TX+Sg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=g1xWYS57N+eOf1F+oXxDRRNGnvRVLgnC+v9Uawo0RYjO6E9zO2qTGn8dNNTAZ5GDPV9pQnFS/vwW1ML7ZRx7IWdvNgJ4ogRqr6vsANuuD5ZhAm5MEY9JXoBn3UMr5Hn7Ze+qOPMFGiUlUb9dot0cHlWLL7tZEewy0hUFR8CUmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwiGFVMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwiGFVMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C11F00A3A;
	Thu, 13 Aug 2026 21:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657480;
	bh=KOh6cMd2kgI/mKKB5407OuHgie8/jKTGIdCyeZx2fSc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WwiGFVMbUnNP0SaY00fPAVVWoDKAeK9cGI5uLX1YjoMrsTwrI4slv1NQnfpe+SpVL
	 PzOmtwaPK+5n4vjd+KZcZHn3OKU6uGFwfa0Zk6gvYgKcPb22lmKNVWd6u/xp9fSqo3
	 XA/rzqhrQutvk6ri/1uA/SS3Rx983IBea02HYSAZAb0LY4CcowKlF7nwcM9nHXPBjs
	 x3QmA5vBUo46eiFh75wdyQ7LxoisCQoMCIVxAinc1sQTKLUKIhxpbkWa7EIil31Jy/
	 SQ7jMeavVh8fnbp8fahy9WRXGX+ytt4E4GvYBlN4BU6WaAD3ZqhDFZKdjFQ8tycNNr
	 lJnhOkEk6mS/Q==
Content-Type: multipart/mixed; boundary="===============7059256553291181025=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b49d62342fa0ab39f64ac3eabda039b1c7cd99efa52a8304d6daeaf017b99eb7@mail.kernel.org>
In-Reply-To: <20260813204032.644949-3-daniel@iogearbox.net>
References: <20260813204032.644949-3-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next 3/4] bpf: Keep untrusted PTR_TO_MEM read-only on RCU invalidation
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,eddyz87@gmail.com
Cc: memxor@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 21:44:39 +0000 (UTC)

--===============7059256553291181025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Keep untrusted PTR_TO_MEM read-only on RCU invalidation
>
>     invalidate_rcu_protected_refs() turns MEM_RCU pointers into PTR_UNTRUSTED
>     ones once the RCU read-side critical section ends.
>
>     For a PTR_TO_BTF_ID base that is fine, but for a PTR_TO_MEM base the
>     result has to carry MEM_RDONLY as well, since the rest of the verifier
>     relies on the two coming as a pair (e.g. bpf_convert_ctx_accesses()).
>
>     A writable untrusted PTR_TO_MEM would otherwise end up as a plain load
>     or store to memory without fault protection. No in-tree kfunc produces
>     the combination today, thus this is mainly hardening.
>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

This looks like a bug fix that closes a security hole.  Should this include:

  Fixes: 5861d1e8dbc4 ("bpf: Allow bpf_spin_{lock,unlock} in sleepable progs")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31743446421
--===============7059256553291181025==--
