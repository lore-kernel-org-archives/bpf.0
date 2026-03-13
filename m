Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0390C3612F6
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 23:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444938; cv=none; b=AoryS8iT4JIbxRy1Y24nkNAyWAWcOSX921bpgkaNjG2GpoE4Vpt0yVlS2/oveV17YNIkzBAhzHCjx5QyQq0HhoffXwQqyXniULuXI0NbCCDlDQSRQdp8utuXcSSWjFrMdJV8Bkk0vOUdX3TIrftRDKwKX7jEvUyrQOW1nFBFlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444938; c=relaxed/simple;
	bh=tQw+PV5Xj0a+TTmuV7pe2KAbPFfoSu4etuQsOcb5F28=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ST4p+6Q7lZSZuU+R52tQgEN9ktdMr9aKpcHX0sv1+TAK5TZZQ8ZhxQW1KyiWLHFTJ30LyhTTqLToteOhSljhDy5koljNf0s5n+fNvUVQDw/64tP5KddVB8TY753cFkzH2eg8Qld2rZSWBmWJgBJHpU6+RgKYMfIu9x9xeqoTkV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvY5EEBy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvY5EEBy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A938C19421;
	Fri, 13 Mar 2026 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444937;
	bh=tQw+PV5Xj0a+TTmuV7pe2KAbPFfoSu4etuQsOcb5F28=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=dvY5EEByPCVQPVMPByh49nvhw5u3ltaPnwKHkgVKn2UlTnAwvhPQK/pX94IELtLBE
	 uALHnIIYPQuUjgXKy5lSlGtDxsv0fFMjNtAp+yHeStU1Rogr5bDb1DuuwuPpRD1ohR
	 +JTSt1dFmJzk4zoF2vgo+mwxBYcgwrV4CpXmjn+4h8K6wPjg3xNAphkmOhcf8zX196
	 UJNj19tBZHbtdG5S8qAd4EOaw1VnFgGE8HSMeyyHtq8TGlbyX3Y5w/QdzRwTyx5aGk
	 sJ8Jm4qiLotib1Zr52OTB35AohwyQwqkE1Nc8m41R60yk8LYyBj+Qn1Q5jWFzJkeyz
	 lbs4wY7+4DObA==
Content-Type: multipart/mixed; boundary="===============5885055955342180428=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4e8f00df703cab5ebf1e1f6f676a8dc8bbc36205d2866efa15c04b983ac4c39a@mail.kernel.org>
In-Reply-To: <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
References: <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on range violations
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: harishankar.vishwanathan@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,shung-hsi.yu@suse.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 13 Mar 2026 23:35:37 +0000 (UTC)

--===============5885055955342180428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 974305ef3210..bd3bdfb6b0c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> +	/* Jump (TRUE) branch */
> +	regs_refine_cond_op(&true_reg1_c, &true_reg2_c, opcode, is_jmp32);
> +	/* If there is a range bounds violation in *any* of the abstract values in either
> +	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE branch must be dead.
> +	 * Only TRUE branch will be taken.
> +	 */
            ^^^^
The comment says "Only TRUE branch will be taken" but the code
returns 0 here, meaning the TRUE branch is dead and only the FALSE
(fallthrough) branch will be taken. Should this say "Only FALSE
branch will be taken"? The equivalent comment in the FALSE branch
section above is correct.

> +	if (range_bounds_violation(&true_reg1_c) || range_bounds_violation(&true_reg2_c))
> +		return 0;

[ ... ]

Also, in the commit message:

> regs_refine_cond_op or reg_bounds_syncreturns an ill-formed state

There is a missing space between "reg_bounds_sync" and "returns".


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23074156227
--===============5885055955342180428==--
